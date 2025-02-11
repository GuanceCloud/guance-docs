---
title: 'Design and Implementation of the Datakit Log Collection System'
skip: 'not-searchable-on-index-page'
---

## Preface {#head}

Log collection (logging) is a critical component of Datakit in Guance. It processes logs by actively collecting or passively receiving log data, which is ultimately uploaded to the Guance center. Log collection can be categorized into two types based on data sources: "network stream data" and "local disk files."

### Network Stream Data {#network}

This generally involves subscribing to network interfaces to passively receive data sent from log-producing endpoints.

A common example is viewing Docker logs. When executing the command `docker logs -f CONTAINER_NAME`, Docker initiates a separate process that connects to the main process, receiving and outputting data from the main process to the terminal. Although both Docker's log process and the main process are on the same host, their interaction occurs via the local loopback network.

More complex network logging scenarios include Kubernetes clusters, where logs are distributed across different Nodes and must be routed through an API server, making it twice as complicated as Docker's single access path.

However, most methods of obtaining logs via the network have one issue — the inability to specify the log location. The log receiver can only choose to start receiving logs from the beginning, potentially receiving hundreds of thousands of entries at once, or from the end, similar to `tail -f`, receiving only the latest data. If the log receiver process restarts, logs generated during this period may be lost.

Datakit initially used network reception for container log collection but faced these issues for a long time. Later, it gradually adjusted and switched to the "local disk file" collection method mentioned below.

### Local Disk Files {#disk-file}

Collecting local log files is the most common and efficient method, eliminating the complexity of intermediate transmission steps by directly accessing disk files. This method offers higher controllability but is more complex to implement, involving various detailed issues such as:

- How to read data from the disk more efficiently?
- What should be done if a file is deleted or rotated?
- How to locate the last position when reopening a file for "continuing reading"?

These questions unfold the details of Docker log services, handling all aspects except the final network transmission part, making the implementation more complex than simply using network reception.

This article will focus on "local disk files," detailing the design and implementation of the Datakit log collection system from the bottom up in three main aspects: "discovering files," "collecting and processing data," and "sending and synchronizing."

Supplementally, the execution flow of Datakit log collection covers and subdivides the aforementioned "three aspects":

``` not-set
glob discovering files       Docker API discovering files      Containerd（CRI）discovering files
     |                       |                            |
     `-----------------------+----------------------------`
                             |
               Adding to the log scheduler, allocating to specified lines
                             |
     .-----------------------+-------------------------.
     |                |                |               |
   line1            line2            line3          line4
                      |
                      |              +- Collecting data, splitting lines
                      |              |
                      |              +- Data transcoding
           .----->    |              |
           |          |              +- Special character handling
           |          |-  File A     |
           |          | One collection cycle  +- Multi-line handling
           |          |                    |
           |          |                    +- Pipeline processing
           |          |                    |
           |          |                    +- Sending
           |          |                    |
           |          |                    +- Synchronizing file collection position
           |          |                    |
           | Pipeline |                    `- File status detection
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

To read and collect log files, the first step is to locate the files on the disk. In Datakit, there are mainly three types of file logs, including two types of container logs and one type of regular log. Their collection methods are largely similar, and this article primarily introduces these three types:

- Regular log files
- Docker Stdout/Stderr, managed and logged by the Docker service itself (Datakit currently supports parsing only the `json-file` driver)
- Containerd Stdout/Stderr, managed by Kubernetes's kubelet component since Containerd does not have its own logging strategy; referred to as `Containerd (CRI)` hereafter

### Discovering Regular Log Files {#discovery-log}

Regular log files are the most common type, where processes directly write readable log records to disk files, like the famous "log4j" framework or executing `echo "this is log" >> /tmp/log`.

The file paths for these logs are mostly fixed. For example, MySQL on Linux platforms has a log path of `/var/log/mysql/mysql.log`. If running the Datakit MySQL collector, it defaults to searching for log files in this path. However, log storage paths can be configurable, and Datakit cannot cover all scenarios, so manual specification of file paths must be supported.

In Datakit, glob patterns are used to configure file paths, allowing wildcards to locate filenames (though they can also be used without wildcards).

For instance, consider the following directory structure:

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

In the Datakit logging collector, you can specify log files to collect by configuring the `logfiles` parameter, such as:

- Collect all files in the `datakit` directory with glob `/tmp/datakit/*`
- Collect all files named with `datakit` using the glob `/tmp/datakit/datakit-*log`
- Collect `mysql.log`, located within two levels of directories (`mysql.d` and `mysql`), using several methods:
    - Directly specify: `/tmp/mysql.d/mysql/mysql.log`
    - Single wildcard: `/tmp/*/*/mysql.log`, rarely used
    - Double wildcard (`double star`): `/tmp/**/mysql.log`, replacing multiple directory layers with `**`, a more concise and commonly used method

After specifying file paths using glob in the configuration file, Datakit periodically searches the disk for matching files. If a file is not in the current collection list, it is added and collected.

### Locating Container Stdout/Stderr Log Files {#discovery-container-log}

There are two ways to output logs in containers:

- Writing directly to a mounted disk directory, which appears the same as "regular log files" from the host's perspective, being files in fixed disk locations.
- Outputting to Stdout/Stderr, collected and managed by the container's runtime, which is a more common approach. The log landing path can be obtained by accessing the runtime API.

Datakit connects to Docker or Containerd sock files, accesses their APIs to retrieve the specified container's `LogPath`, similar to running `docker inspect --format='{{.LogPath}}' $INSTANCE_ID` in the command line:

``` shell
docker inspect --format='{{.LogPath}}' cf681e

/var/lib/docker/containers/cf681eXXXX/cf681eXXXX-json.log
```

After obtaining the container `LogPath`, Datakit uses this path along with the relevant configuration to create log collection.

## Collecting and Processing Log Data {#log-process}

### Log Collection Scheduler {#scheduler}

Upon obtaining a log file path, since Datakit is written in Golang, it typically spawns one or more goroutines to independently collect data from the file. This model is simple and easy to implement, and Datakit previously followed this approach.

However, if the number of files increases significantly, the number of goroutines required also grows, complicating goroutine management. Therefore, Datakit implemented a log collection scheduler.

Similar to most scheduler models, Datakit implements multiple pipelines (lines) beneath the scheduler. When a new log collection is registered with the scheduler, Datakit allocates it based on the weight of each pipeline.

Each pipeline executes in a loop, meaning it collects from file A, then file B, and then file C, effectively controlling the number of goroutines and avoiding excessive low-level scheduling and resource contention.

If a log collection encounters an error, it is removed from the pipeline and will not be collected in the next cycle.

### Reading Data and Splitting into Lines {#read}

When discussing reading log data, most people think of methods like `Readline()`, which returns a complete line of log data with each call. However, Datakit did not implement it this way.

To ensure finer control and higher performance, Datakit uses the basic `Read()` method, reading 4KiB of data per call (buffer size is 4KiB, but the actual amount read may be less). It manually splits this 4KiB of data into N parts using newline characters `\n`. This results in two scenarios:

- The last character of the 4KiB data is a newline, splitting it into N parts with no remainder.
- The last character is not a newline, resulting in N-1 parts with a remaining portion, which is appended to the beginning of the next 4KiB data block.

In Datakit's code, the buffer is continuously updated with `update CursorPosition`, `copy`, and `truncate` operations to maximize memory reuse.

After processing, the read data is split into individual lines, ready for the next stage of transcoding and special character handling.

### Transcoding and Special Character Handling {#decode}

Transcoding and special character handling occur after data formatting to avoid issues like splitting characters mid-byte or processing incomplete segments. For example, a UTF-8 Chinese character spans 3 bytes, and processing the first byte would lead to undefined behavior.

Transcoding is a common operation requiring encoding type and endianness specifications (if applicable). Here, we focus on "special character handling."

"Special characters" refer to color codes in the data. For example, the following command outputs a red `red` word in the terminal:

``` not-set
RED='\033[0;31m' && NC='\033[0m' && print "${RED}red${NC}"
```

Without handling, color codes like `\033[0;31m` remain in the final log data, affecting aesthetics, storage, and subsequent data processing. Therefore, special color characters should be filtered out.

Many open-source projects use regular expressions for this purpose, though performance may not be optimal.

For mature logging frameworks, disabling color codes at the source is recommended, ensuring log producers avoid printing color characters.

### Parsing Line Data {#parse}

"Parsing line data" primarily targets container Stdout/Stderr logs. Container runtimes add extra fields when managing and writing logs, such as timestamp, source (`stdout` or `stderr`), and whether the log is truncated. Datakit needs to parse this data to extract corresponding fields.

- Docker JSON file log format is as follows, with the main content in the `log` field. If the `log` ends with `\n`, it indicates a complete line; otherwise, it signifies truncation exceeding 16KB, with the remainder in the next JSON entry.

``` json
{"log":"2022/09/14 15:11:11 Bash For Loop Examples. Hello, world! Testing output.\n","stream":"stdout","time":"2022-09-14T15:11:11.125641305Z"}
```

- Containerd (CRI) log format is space-separated. Similar to Docker, Containerd marks truncation with `P` (partial) and `F` (full).

``` log
2016-10-06T00:17:09.669794202Z stdout P log content 1
2016-10-06T00:17:09.669794202Z stdout F log content 2
```

Concatenated log data becomes `log content 1 log content 2`.

By parsing line data, Datakit extracts log content, stdout/stderr information, and determines if the log is truncated, requiring concatenation. Ordinary log files do not have truncation issues, and single lines can theoretically be infinitely long.

Additionally, concatenated truncated log lines still count as a single log line, distinct from multiline logs discussed later.

### Multiline Data {#multiline}

Multiline handling is crucial for log collection, transforming non-conforming data into a consistent format without losing any data. For example, consider a common Python stack trace in a log file:

``` log
2020-10-23 06:41:56,688 INFO demo.py 1.0
2020-10-23 06:54:20,164 ERROR /usr/local/lib/python3.6/dist-packages/flask/app.py Exception on /0 [GET]
Traceback (most recent call last):
  File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app
    response = self.full_dispatch_request()
2020-10-23 06:41:56,688 INFO demo.py 5.0
```

Without multiline handling, the final data would consist of the original 7 lines. This format is not ideal for subsequent Pipeline processing because lines like `Traceback (most recent call last):` or `File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app` lack a consistent pattern.

Effective multiline handling transforms these 7 lines into 3 lines:

``` log
2020-10-23 06:41:56,688 INFO demo.py 1.0
2020-10-23 06:54:20,164 ERROR /usr/local/lib/python3.6/dist-packages/flask/app.py Exception on /0 [GET]\nTraceback (most recent call last):\n  File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app\n    response = self.full_dispatch_request()
2020-10-23 06:41:56,688 INFO demo.py 5.0
```

Now, each log line starts with a characteristic string like `2020-10-23`, improving readability and facilitating subsequent Pipeline field extraction.

This feature is straightforward, requiring only a regular expression for the characteristic string. In the Datakit logging collector, this is configured using the `multiline_match` option. For the above example, the configuration would be `^\d{4}-\d{2}-\d{2}`, matching lines starting with `2020-10-23`.

Implementation-wise, this resembles a stack data structure, where lines conforming to the pattern pop the previous line and push themselves, while non-conforming lines append to the previous line.

Additionally, Datakit supports automatic multiline handling with options `auto_multiline_detection` and `auto_multiline_extra_patterns`, simplifying configuration by providing default rules.

### Pipeline Processing and Log Status {#pipeline}

Pipeline is a simple scripting language offering functions and syntax for defining text data processing rules, primarily used to parse unstructured text data into meaningful fields or extract information from structured formats like JSON.

Pipeline implementation involves abstract syntax trees (AST) and a series of internal state machines and pure functions, which are not covered in detail here.

As an example, consider the original text:

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

> Note: The `status` field after Pipeline processing is mapped to lowercase `info` by Datakit.

Pipeline is the final step in log data processing, where Datakit constructs line protocol, serializes objects, and prepares them for sending to Dataway.

## Sending Data and Synchronization {#send}

Sending data is a common operation in Datakit, involving three basic steps: "packaging," "transcoding," and "sending."

However, post-sending operations are essential, specifically "synchronizing the current file read position" and "detecting file status."

### Synchronization {#sync}

In the introduction to "network stream data," it was mentioned that to support resuming log file reading from a specific point, rather than only supporting "reading from the beginning" or `tail -f` mode, Datakit introduces an important operation—recording the current file read position (position).

Each time Datakit reads data from a disk file, it records the position of this data in the file. Only after a series of processing and sending operations are completed does it synchronize this position information along with other data to a separate disk file.

This ensures that upon restarting log collection, Datakit can resume from the last recorded position, preventing duplicate data collection and avoiding data loss.

Implementation is straightforward:

When Datakit starts log collection, it constructs a unique key using the "absolute file path + file inode + first N bytes of the file header." This key is used to find the position in a specified file path.

- If a position is found, it indicates the file was previously collected, and collection resumes from this position.
- If no position is found, it is a new file, and collection starts from either the beginning or end based on the situation.

### Detecting File Status {#checking}

Disk file status can change over time. Files may be deleted, renamed, or remain unchanged for extended periods. Datakit must handle these scenarios.

- Long-unmodified files:
    - Datakit periodically retrieves the modification time (`file Modification Date`). If it detects that the file has not been modified beyond a certain threshold, it considers the file "inactive" and stops collecting logs.
    - This logic applies when using glob rules to search for log files. If a file matching the glob rule has not been modified for a long time, it will not be collected.

- File rotation:
    - File rotation involves changing the underlying file pointed to by the filename, e.g., its inode. A typical example is Docker log persistence.

Datakit regularly checks if the currently collected file has undergone rotation. The check involves opening a new file handle with the same filename and using a function like `SameFile()` to determine if both handles point to the same file. If they differ, the file has rotated.

Upon detecting rotation, Datakit completes the collection of the remaining data until EOF, reopens the file, and resumes normal operations.

## Summary {#end}

Log collection is a complex system involving numerous detailed handling and optimization logic. This article aims to introduce the design and implementation of the Datakit log collection system, without benchmark reports or performance comparisons with similar projects. Additional details can be provided based on future needs.

Supplementary links:

- [Introduction to glob patterns](https://en.wikipedia.org/wiki/Glob_(programming)){:target="_blank"}
- [Datakit automatic multiline configuration](https://docs.guance.com/integrations/logging/#auto-multiline){:target="_blank"}
- [Datakit Pipeline processing](https://docs.guance.com/datakit/pipeline/){:target="_blank"}
- [Discussion on Docker truncating logs over 16KiB](https://github.com/moby/moby/issues/34855){:target="_blank"}
- [Docker truncating logs over 16KiB source code](https://github.com/nalind/docker/blob/master/daemon/logger/copier.go#L13){:target="_blank"}
- [Docker logging driver](https://docs.docker.com/config/containers/logging/local/){:target="_blank"}