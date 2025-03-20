---
title: 'Design and Implementation of Datakit Log Collection System'
skip: 'not-searchable-on-index-page'
---

## Introduction {#head}

Log collection (logging) is an important feature of the Guance Datakit. It processes log data collected actively or received passively, ultimately uploading it to the Guance center. Based on the data source, log collection can be divided into "network stream data" and "local disk files."

### Network Stream Data {#network}

Mostly, this involves subscribing to network interfaces to passively receive data sent by the log producer.

A common example is viewing Docker logs. When executing the `docker logs -f CONTAINER_NAME` command, Docker starts a separate process that connects to the main process, receiving data from the main process and outputting it to the terminal. Although the Docker log process and the main process are on the same host, their interaction occurs through the local loopback network.

More complex network log scenarios, such as Kubernetes clusters, have logs distributed across different Nodes. These require api-server relays, making the access chain twice as complex as Docker's single access path.

However, most methods for obtaining logs via the network share a common issue — inability to specify the log location. The log receiver can only choose to start receiving from the beginning, collecting as much as available, possibly receiving hundreds of thousands of entries at once; or start from the end, similar to `tail -f`, only receiving the latest generated data. If the log receiver process restarts during this time, the logs generated in between will be lost.

Datakit initially used network reception for container log collection but encountered these issues for a long time. Subsequently, it transitioned to the "local disk file" collection method mentioned below.

### Local Disk Files {#disk-file}

Collecting local log files is the most common and efficient method. It eliminates intermediate transmission steps, directly accessing disk files, offering higher control but with more complex implementation. A series of detailed problems may arise, such as:

- How to read data more efficiently from the disk?
- What to do if files are deleted or rotated?
- How to locate the last position when reopening a file to "continue reading"?

These questions essentially unfold the Docker log service, handing over various details and execution to be managed independently while omitting only the final network transmission part. This makes the implementation more complex compared to simply using network reception.

This article will primarily focus on "local disk files," breaking down the design and implementation details of the Datakit log collection system into three aspects: "file discovery," "data collection and processing," and "sending and synchronization."

As a supplement, the Datakit log collection workflow includes and subdivides the aforementioned "three aspects":

``` not-set
glob discovers files       Docker API discovers files      Containerd (CRI) discovers files
     |                       |                            |
     `-----------------------+----------------------------`
                             |
               Adds to the log scheduler, assigns to specified lines
                             |
     .-----------------------+-------------------------.
     |                |                |               |
   line1            line2            line3          line4
                      |
                      |              +- Collect data, split lines
                      |              |
                      |              +- Data transcoding
           .----->    |              |
           |          |              +- Special character handling
           |          |-  File A     |
           |          | One collection cycle +- Multi-line handling
           |          |              |
           |          |              +- Pipeline processing
           |          |              |
           |          |              +- Sending
           |          |              |
           |          |              +- Synchronizing file collection positions
           |          |              |
           | Pipeline |              `- File status checking
           | Loop     |
           |          |
           |          +-  File B |-
           |          |
           |          |
           |          +-  File C |-
           |          |
           +----------+
```

## Discovering and Locating Log Files {#discovery}

To read and collect log files, the first step is to locate them on the disk. In Datakit, there are mainly three types of file logs, two of which are container logs and one is a regular log. Their collection methods are similar, so this article focuses on these three types, namely:

- Regular log files
- Docker Stdout/Stderr, managed and written to disk by the Docker service itself (Datakit currently supports parsing only the `json-file` driver)
- Containerd Stdout/Stderr, where Containerd does not have its own strategy for outputting logs. Currently, Containerd Stdout/Stderr are managed by the Kubernetes kubelet component, subsequently referred to as `Containerd (CRI)`

### Discovering Regular Log Files {#discovery-log}

Regular log files are the most common type, where processes directly write readable record data to disk files, like the famous "log4j" framework or executing `echo "this is log" >> /tmp/log` commands, which generate log files.

The file paths for these logs are mostly fixed in most cases, such as `/var/log/mysql/mysql.log` for MySQL on Linux platforms. If running the Datakit MySQL collector, it defaults to searching for this path for log files. However, log storage paths can be configurable, and Datakit cannot cover all situations, so manual specification of file paths must be supported.

In Datakit, glob patterns are used to configure file paths, utilizing wildcards to locate filenames (though wildcards are optional).

For example, consider the following files:

``` shell
tree /tmp

/tmp
├── datakit
│   ├── datakit-01.log
│   ├── datakit-02.log
│   └── datakit-03.log
└── mysql.d
    └── mysql
        └── mysql.log

3 directories, 4 files
```

In the Datakit logging collector, you can specify the `logfiles` parameter to indicate the log files to collect, such as:

- Collect all files under the `datakit` directory, glob pattern is `/tmp/datakit/*`
- Collect all files named `datakit`, corresponding glob pattern is `/tmp/datakit/datakit-*log`
- Collect `mysql.log`, but there are two layers of directories `mysql.d` and `mysql`. There are several ways to locate the `mysql.log` file:
    - Directly specify: `/tmp/mysql.d/mysql/mysql.log`
    - Single wildcard: `/tmp/*/*/mysql.log`, this method is rarely used
    - Double wildcard (`double star`): `/tmp/**/mysql.log`, using double wildcard `**` to replace multiple layers of directory structure, which is a more concise and commonly used approach

After specifying file paths using glob in the configuration file, Datakit regularly searches the disk for matching files. If any new files are found that are not already being collected, they are added and started for collection.

### Locating Container Stdout/Stderr Log Files {#discovery-container-log}

There are two ways to output logs in containers:

- Writing directly to a mounted disk directory, which appears identical to "regular log files" from the host's perspective, being fixed-location files on the disk.
- Outputting to Stdout/Stderr, collected and managed by the container runtime before being written to disk. This is a more common method, and the disk path can be obtained by querying the runtime API.

Datakit connects to Docker or Containerd sock files, accesses their APIs to obtain the `LogPath` for specific containers, similar to executing `docker inspect --format='{{.LogPath}}' $INSTANCE_ID` in the command line:

``` shell
docker inspect --format='{{.LogPath}}' cf681e

/var/lib/docker/containers/cf681eXXXX/cf681eXXXX-json.log
```

After acquiring the container `LogPath`, it creates log collection using this path along with relevant configurations.

## Collecting Log Data and Processing {#log-process}

### Log Collection Scheduler {#scheduler}

Upon obtaining a log file path, since Datakit is written in Golang, it typically initiates one or more goroutines to independently collect data from the file, a simple model and easy to implement. Initially, Datakit did exactly this.

However, if the number of files increases significantly, the number of goroutines required would also increase, making goroutine management difficult. Therefore, Datakit implemented a log collection scheduler.

Like most scheduler models, Datakit implements multiple pipelines (lines) below the scheduler. When a new log collection registers with the scheduler, Datakit allocates it based on the weight of each pipeline.

Each pipeline executes cyclically, i.e., collects from file A once (or continuously collects for N seconds depending on the situation), then collects from file B, then file C, effectively controlling the number of goroutines and avoiding excessive underlying scheduling and resource contention.

If an error is detected in this log collection, it is removed from the pipeline and will not be collected again in the next cycle.

### Reading Data and Splitting into Lines {#read}

When mentioning reading log data, most people might first think of functions like `Readline()`, which returns a complete line of logs each time it is called. However, Datakit does not implement it this way.

To ensure finer control and better performance, Datakit uses only the basic `Read()` method, reading 4KiB of data at a time (buffer size is 4KiB, actual read may be less), manually splitting this 4KiB of data into N parts using newline characters `\n`. Two scenarios can occur:

- The last character of this 4KiB of data is exactly a newline character, allowing it to be split into N parts with no remainder.
- The last character of this 4KiB of data is not a newline character, resulting in only N-1 parts being split in this case, with a remaining portion that will be appended to the beginning of the next 4KiB of data, and so on.

In Datakit's code, this section continuously performs `update CursorPosition`, `copy`, and `truncate` operations on the same buffer to maximize memory reuse.

After processing, the data read has been transformed into individual lines, ready to proceed to the next stage of transcoding and special character handling.

### Transcoding and Special Character Handling {#decode}

Transcoding and special character handling should occur after the data has taken shape, otherwise it risks truncating characters mid-stream or processing truncated data. For example, a UTF-8 Chinese character occupies 3 bytes, and performing transcoding upon reading only the first byte results in undefined behavior.

Data transcoding is a common operation requiring specification of encoding type and endianness (if applicable). This section focuses on "special character handling."

"Special characters" here refer to color codes in the data, such as the following command, which outputs a red `rea` word in the terminal:

``` not-set
RED='\033[0;31m' && NC='\033[0m' && print "${RED}red${NC}"
```

Without handling and removing color codes, the final log data would contain `\033[0;31m`, which not only lacks aesthetics and consumes storage but may also negatively impact subsequent data processing. Therefore, it is necessary to filter out special color characters here.

There are many examples in open-source communities, most using regular expressions for implementation, which is not particularly high-performing.

For mature log output frameworks, there is usually a method to disable color characters, which Datakit recommends as the preferred approach, having the log producer avoid printing color characters.

### Parsing Line Data {#parse}

"Parsing line data" primarily applies to container Stdout/Stderr logs. The container runtime adds some extra fields when managing and writing logs, such as generation time, whether the source is `stdout` or `stderr`, and whether the log entry has been truncated. Datakit needs to parse this data and extract corresponding fields.

- Docker JSON file log single-entry format is as follows, in JSON format, with the body in the `log` field. If the `log` content ends with `\n`, it indicates the line is complete and not truncated; otherwise, it signifies the data exceeds 16KB and has been truncated, with the remainder in the next JSON.

``` json
{"log":"2022/09/14 15:11:11 Bash For Loop Examples. Hello, world! Testing output.\n","stream":"stdout","time":"2022-09-14T15:11:11.125641305Z"}
```

- Containerd (CRI) single log entry format is as follows, with fields separated by spaces. Similar to Docker, Containerd (CRI) marks truncated logs with the third field `P`, and `F`. `P` stands for `Partial`, meaning incomplete or truncated; `F` stands for `Full`.

``` log
2016-10-06T00:17:09.669794202Z stdout P log content 1
2016-10-06T00:17:09.669794202Z stdout F log content 2
```

After concatenation, the log data becomes `log content 1 log content 2`.

---

By parsing line data, log body, stdout/stderr information, etc., can be obtained, determining whether the log is incomplete and requires concatenation. Truncated logs in regular log files do not exist, theoretically allowing single-line data in files to be infinitely long.

Additionally, even though log lines are truncated and concatenated, they still belong to a single log line, distinct from the multiline logs mentioned later, which are two different concepts.

### Multiline Data {#multiline}

Multiline processing is a crucial aspect of log collection, transforming non-conforming data into conforming data without losing any data. For example, the following data exists in a log file, which is a typical Python stack trace:

``` log
2020-10-23 06:41:56,688 INFO demo.py 1.0
2020-10-23 06:54:20,164 ERROR /usr/local/lib/python3.6/dist-packages/flask/app.py Exception on /0 [GET]
Traceback (most recent call last):
  File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app
    response = self.full_dispatch_request()
2020-10-23 06:41:56,688 INFO demo.py 5.0
```

Without multiline processing, the final data would consist of the above 7 lines, exactly as in the original. This is not conducive to subsequent Pipeline slicing because lines like `Traceback (most recent call last):` or `File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app` are not in a fixed format.

With effective multiline processing, these 7 lines become 3 lines, as shown below:

``` log
2020-10-23 06:41:56,688 INFO demo.py 1.0
2020-10-23 06:54:20,164 ERROR /usr/local/lib/python3.6/dist-packages/flask/app.py Exception on /0 [GET]\nTraceback (most recent call last):\n  File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app\n    response = self.full_dispatch_request()
2020-10-23 06:41:56,688 INFO demo.py 5.0
```

It can be seen that each line of log data now starts with a characteristic string like `2020-10-23`, and the non-characteristic lines 3, 4, and 5 from the original text are appended to the end of line 2. This looks tidier and facilitates subsequent Pipeline field cutting.

This functionality is not complex, requiring only the specification of a characteristic string regular expression.

In the Datakit logging collector configuration, there is a `multiline_match` item. Using the example above, this item’s configuration should be `^\d{4}-\d{2}-\d{2}`, i.e., matching lines starting with `2020-10-23`.

Specifically, this is akin to a stack (stack) structure in data structures. If a line matches the characteristic, the previous line is popped from the stack and the current line pushed onto the stack. If it doesn’t match the characteristic, the current line is pushed onto the stack and appended to the end of the previous line. Thus, the data popped from outside the stack always conforms to the characteristic.

Moreover, Datakit supports automatic multiline processing through the `auto_multiline_detection` and `auto_multiline_extra_patterns` items in the logging collector configuration. Its logic is very simple: providing a set of `multiline_match`, iterating through all rules according to the original text, and increasing the weight of successfully matched rules for priority selection next time.

Automatic multiline processing simplifies configuration. Besides user configuration, it provides a "default automatic multiline rule list". See the link at the end of the article for details.

### Pipeline Cutting and Log Status {#pipeline}

Pipeline is a simple scripting language providing various functions and syntaxes for writing execution rules for a segment of textual data. It is mainly used for slicing unstructured textual data, such as cutting a line of string text into multiple meaningful fields, or extracting partial information from structured text (such as JSON).

The implementation of Pipeline is relatively complex, consisting of abstract syntax trees (AST) and a series of internal state machines and pure functional functions. This won't be elaborated on further here.

Looking only at use cases, here's a simple example. Original text as follows:

``` not-set
2020-10-23 06:41:56,688 INFO demo.py 1.0
```

Pipeline script:

```python
grok(_, "%{date:time} %{NOTSPACE:status} %{GREEDYDATA:msg}")
default_time(time)
```

Final result:

```python
{
    "message": "2020-10-23 06:41:56,688 INFO demo.py 1.0",
    "msg": "demo.py 1.0",
    "status": "info",
    "time": 1603435316688000000
}
```

> Note: After Pipeline slicing, the `status` field is `INFO`, but Datakit performs mapping processing, so it displays as lowercase `info` for rigor.

Pipeline is the final step in log data processing. Datakit uses the results of Pipeline to build line protocols, serialize objects, and prepare to send them to Dataway.

## Sending Data and Synchronization {#send}

Sending data is a common behavior. In Datakit, it basically consists of three steps: "packaging," "transcoding," and "sending."

However, operations after sending are indispensable and crucial, namely "synchronizing the current file's read position" and "detecting file status."

### Synchronization {#sync}

In the first section introducing "network stream data," it was mentioned that to enable log files to be read from a specific point rather than just supporting "reading from the start of the file" or `tail -f` mode, Datakit introduces an important operation — recording the current file's read position (position).

Each time Datakit reads data from a disk file, it records the position of that data within the file. Only after a series of processing and sending is completed, will this position information be synchronized along with other data to a separate disk file.

The advantage of this is that each time Datakit initiates log collection, if this log file has been previously collected, it can continue from the last position, preventing duplicate data collection and avoiding loss of intermediate segments.

Function implementation is not complex:

When Datakit initiates log collection, it constructs a unique key value using the "absolute file path + file inode + first N bytes of the file header." This key is used to search for the position in a specified path file.

- If the position is found, it means the file was previously collected, and reading will resume from the current position.
- If the position is not found, it indicates a new file, and reading will commence either from the start or the end of the file depending on the situation.

### Detecting File Status {#checking}

The status of disk files is not static; they may be deleted, renamed, or remain unmodified for a long time. Datakit needs to handle these situations.

- Files unmodified for a long time:
    - Datakit periodically retrieves the modification time (`file Modification Date`) of the file. If it finds that the time difference from the current time exceeds a certain limit, it considers the file "inactive" (inactive) and closes it, ceasing collection.
    - This logic also applies when using glob rules to search for log files. If a file matching the glob rule is found but has not been modified for a long time (or "updated"), it will not be collected for logging.

- Files undergo rotation (rotate):
    - File rotation is a complex logic, generally speaking, the filename remains unchanged, but the actual file pointed to by the filename changes, such as its inode. A typical example is Docker log writing to disk.

Datakit periodically checks if the currently collected file has undergone rotation. The check logic is: opening a new file handle with the filename, calling a function similar to `SameFile()`, and determining if the two handles point to the same file. If they do not, it indicates that the filename has undergone rotation.

Once it detects that the file has undergone rotation, Datakit will finish collecting the remaining data (until EOF) of the current file, then reopen the file, which is now a new file, and continue the operation flow as usual.

## Summary {#end}

Log collection is a complex system involving numerous detail treatments and optimization logics. This article aims to introduce the design and implementation of the Datakit log collection system, without benchmark reports or performance comparisons with similar projects, which could be supplemented depending on the situation.

Supplementary links:

- [Introduction to glob Patterns](https://en.wikipedia.org/wiki/Glob_(programming)){:target="_blank"}
- [Datakit Automatic Multiline Configuration](https://docs.guance.com/integrations/logging/#auto-multiline){:target="_blank"}
- [Datakit Pipeline Processing](https://docs.guance.com/datakit/pipeline/){:target="_blank"}
- [Discussion on Docker Truncating Logs Over 16KiB](https://github.com/moby/moby/issues/34855){:target="_blank"}
- [Source Code for Docker Truncating Logs Over 16KiB](https://github.com/nalind/docker/blob/master/daemon/logger/copier.go#L13){:target="_blank"}
- [Docker Logging Driver](https://docs.docker.com/config/containers/logging/local/){:target="_blank"}