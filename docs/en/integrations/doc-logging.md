---
title: 'Design and Implementation of the Datakit Log Collection System'
skip: 'not-searchable-on-index-page'
---

## Preface {#head}

Log collection (logging) is a crucial feature of Guance's Datakit. It processes log data collected actively or received passively, ultimately uploading it to the Guance center. Log collection can be categorized into two types based on the data source: "network stream data" and "local disk files."

### Network Stream Data {#network}

This typically involves subscribing to network interfaces to receive data sent by the log-producing end.

A common example is viewing Docker logs. When executing `docker logs -f CONTAINER_NAME`, Docker starts a separate process that connects to the main process, receiving data from the main process and outputting it to the terminal. Although the Docker log process and the main process are on the same host, their interaction occurs via the local loopback network.

In more complex network logging scenarios, such as Kubernetes clusters, logs are distributed across different Nodes and require api-server relaying, making the access chain twice as complex as Docker's single access path.

However, most network-based log retrieval methods share a common issue — inability to specify the log location. The log receiver can only choose to start receiving logs from the beginning, potentially receiving hundreds of thousands of entries at once; or from the end, similar to `tail -f`, receiving only the latest data. If the log-receiving process restarts, logs generated during this period may be lost.

Datakit initially used network reception for container log collection but faced these issues for a long time. Subsequently, it gradually adjusted and switched to the "local disk file" collection method mentioned below.

### Local Disk Files {#disk-file}

Collecting local log files is the most common and efficient method. It eliminates the need for intermediate transmission steps, allowing direct access to disk files with higher controllability. However, implementation is more complex, leading to a series of detailed issues:

- How to read data from the disk more efficiently?
- What to do if a file is deleted or rotated?
- How to locate the last position when reopening a file for "continued reading"?

These problems unfold the details of Docker log services, handling various execution aspects independently while skipping the final network transmission part. Implementing this is more complex than simply using network reception.

This article will focus on "local disk files," detailing the design and implementation of the Datakit log collection system from bottom to top in three aspects: "file discovery," "data collection and processing," and "sending and synchronization."

Supplementally, the execution flow of Datakit log collection is as follows, covering and subdividing the aforementioned "three aspects":

``` not-set
glob discovers files       Docker API discovers files      Containerd (CRI) discovers files
     |                       |                            |
     `-----------------------+----------------------------`
                             |
               added to the log scheduler, assigned to specific lines
                             |
     .-----------------------+-------------------------.
     |                |                |               |
   line1            line2            line3          line4
                      |
                      |              +- collect data, split by lines
                      |              |
                      |              +- data transcoding
           .----->    |              |
           |          |              +- special character processing
           |          |-  File A     |
           |          | one collection cycle +- multiline processing
           |          |              |
           |          |              +- Pipeline processing
           |          |              |
           |          |              +- sending
           |          |              |
           |          |              +- synchronizing file collection position
           |          |              |
           | pipeline |              `- file status detection
           | loop     |
           |          |
           |          +-  File B |-
           |          |
           |          |
           |          +-  File C |-
           |          |
           +----------+
```

## Discovering and Locating Log Files {#discovery}

To read and collect log files, the first step is to locate them on the disk. In Datakit, there are mainly three types of log files, two of which are container logs and one is a regular log. Their collection methods are similar, and this article primarily covers these three:

- Regular log files
- Docker Stdout/Stderr, managed and written to disk by the Docker service itself (Datakit currently supports parsing `json-file` driver only)
- Containerd Stdout/Stderr, managed by Kubernetes’s kubelet component, referred to as `Containerd (CRI)`

### Discovering Regular Log Files {#discovery-log}

Regular log files are the most common type. They are directly written to disk files by processes, like the famous "log4j" framework or executing `echo "this is log" >> /tmp/log`.

The file paths for these logs are usually fixed. For instance, MySQL on Linux platforms has its log path set to `/var/log/mysql/mysql.log`. Running the Datakit MySQL collector defaults to searching for this path. However, log storage paths can be configurable, so Datakit must support manual specification of file paths.

In Datakit, glob patterns are used to configure file paths, utilizing wildcards to match filenames (though wildcards are optional).

For example, consider the following directory structure:

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

In the Datakit logging collector, you can specify log files to collect through the `logfiles` parameter:

- Collect all files in the `datakit` directory using `/tmp/datakit/*`
- Collect all files named `datakit` using `/tmp/datakit/datakit-*log`
- Collect `mysql.log`, located within multiple layers of directories:
    - Directly specify: `/tmp/mysql.d/mysql/mysql.log`
    - Single wildcard: `/tmp/*/*/mysql.log` (rarely used)
    - Double wildcard (`**`): `/tmp/**/mysql.log` (a concise and commonly used method)

After specifying file paths using glob in the configuration file, Datakit periodically searches the disk for matching files. If a file is not already in the collection list, it adds and begins collecting it.

### Locating Container Stdout/Stderr Log Files {#discovery-container-log}

There are two ways to output logs in containers:

- Writing directly to a mounted disk directory, appearing as a regular log file on the host
- Outputting to Stdout/Stderr, managed and written to disk by the container runtime. This is the more common approach, with the log path obtainable via runtime API calls.

Datakit connects to Docker or Containerd sock files, accessing their APIs to retrieve the specified container's `LogPath`, similar to running `docker inspect --format='{{.LogPath}}' $INSTANCE_ID`:

``` shell
docker inspect --format='{{.LogPath}}' cf681e

/var/lib/docker/containers/cf681eXXXX/cf681eXXXX-json.log
```

After obtaining the container's `LogPath`, Datakit uses this path along with relevant configurations to create log collection.

## Collecting and Processing Log Data {#log-process}

### Log Collection Scheduler {#scheduler}

Upon obtaining a log file path, since Datakit is written in Golang, it typically spawns one or more goroutines to independently collect from the file. This model is simple and easy to implement, which was how Datakit initially operated.

However, as the number of files increases, so does the number of goroutines, making management inefficient. Therefore, Datakit implemented a log collection scheduler.

Like most schedulers, Datakit implements multiple pipelines (lines) beneath the scheduler. When a new log collection registers with the scheduler, Datakit allocates it based on each pipeline's weight.

Each pipeline operates in a loop: after collecting data from file A (or continuously for N seconds), it moves to file B, then file C, effectively controlling the number of goroutines and avoiding resource contention.

If an error occurs during log collection, it is removed from the pipeline and not processed in the next cycle.

### Reading Data and Splitting into Lines {#read}

When discussing reading log data, many think of methods like `Readline()`, which returns a complete line of log data each time it is called. However, Datakit does not implement this.

For finer control and better performance, Datakit uses the basic `Read()` method, reading 4KiB of data at a time (buffer size is 4KiB, actual read amount may be less). This 4KiB of data is manually split into N parts using newline characters `\n`, resulting in two scenarios:

- The last character of the 4KiB data is a newline, splitting into N parts without remainder.
- The last character is not a newline, splitting into N-1 parts with a remaining portion, which is appended to the next 4KiB data block.

In Datakit's code, this involves continuously updating the buffer's cursor position, copying, and truncating to maximize memory reuse.

After processing, the data becomes individual lines, ready for encoding and special character handling.

### Encoding and Special Character Handling {#decode}

Encoding and special character handling occur after data formation to avoid issues like mid-character truncation. For instance, a UTF-8 Chinese character occupies 3 bytes, and processing it before fully receiving it would lead to undefined behavior.

Data encoding is common, requiring specification of encoding type and byte order (if applicable). Here, we focus on "special character handling."

"Special characters" refer to color codes in the data, such as the command below, which outputs a red `red` word in the terminal:

``` not-set
RED='\033[0;31m' && NC='\033[0m' && print "${RED}red${NC}"
```

Without handling, the final log data would include `\033[0;31m`, affecting aesthetics, storage, and subsequent data processing. Therefore, these color codes should be filtered out.

Many open-source projects use regular expressions for this purpose, but performance can be suboptimal.

A mature logging framework should provide a way to disable color codes, which Datakit recommends over post-processing.

### Parsing Line Data {#parse}

"Parsing line data" primarily applies to container Stdout/Stderr logs. The container runtime adds extra fields when managing and writing logs, such as timestamp, source (`stdout` or `stderr`), and whether the log is truncated. Datakit needs to parse this data to extract corresponding fields.

- Docker JSON file log format is as follows, where the main content is in the `log` field. If the `log` ends with `\n`, the line is complete; otherwise, it indicates truncation due to exceeding 16KB, with the remainder in the next JSON entry.

``` json
{"log":"2022/09/14 15:11:11 Bash For Loop Examples. Hello, world! Testing output.\n","stream":"stdout","time":"2022-09-14T15:11:11.125641305Z"}
```

- Containerd (CRI) log format, with fields separated by spaces. Similar to Docker, Containerd (CRI) also marks truncated logs, using `P` for partial and `F` for full.

``` log
2016-10-06T00:17:09.669794202Z stdout P log content 1
2016-10-06T00:17:09.669794202Z stdout F log content 2
```

Concatenated log data: `log content 1 log content 2`.

---

By parsing line data, Datakit extracts log content, stdout/stderr information, and determines if logs are incomplete and need concatenation. Ordinary log files do not have truncation, allowing theoretically infinite-length single lines.

Moreover, concatenated truncated log lines still count as a single log entry, distinct from multi-line logs discussed below.

### Multi-line Data {#multiline}

Multi-line processing is crucial for transforming non-conforming data into conforming formats without losing any data. For instance, consider the following Python stack trace in a log file:

``` log
2020-10-23 06:41:56,688 INFO demo.py 1.0
2020-10-23 06:54:20,164 ERROR /usr/local/lib/python3.6/dist-packages/flask/app.py Exception on /0 [GET]
Traceback (most recent call last):
  File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app
    response = self.full_dispatch_request()
2020-10-23 06:41:56,688 INFO demo.py 5.0
```

Without multi-line processing, the final data remains seven lines, identical to the original. This hinders subsequent Pipeline slicing because lines like `Traceback (most recent call last):` or `File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app` lack a consistent format.

With effective multi-line processing, the seven lines become three:

``` log
2020-10-23 06:41:56,688 INFO demo.py 1.0
2020-10-23 06:54:20,164 ERROR /usr/local/lib/python3.6/dist-packages/flask/app.py Exception on /0 [GET]\nTraceback (most recent call last):\n  File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app\n    response = self.full_dispatch_request()
2020-10-23 06:41:56,688 INFO demo.py 5.0
```

Each log line now starts with a characteristic string like `2020-10-23`, and the previously non-conforming lines are appended to the end of the second line, enhancing readability and facilitating Pipeline field slicing.

This functionality is straightforward, requiring a regular expression pattern for the characteristic string.

In the Datakit logging collector, the `multiline_match` parameter can be configured as `^\d{4}-\d{2}-\d{2}` to match lines starting with `2020-10-23`.

Implementation-wise, this resembles a stack structure: if a line matches the pattern, it pops the previous line and pushes itself; otherwise, it appends itself to the previous line. The popped lines are always pattern-matching.

Additionally, Datakit supports automatic multi-line processing through `auto_multiline_detection` and `auto_multiline_extra_patterns` parameters, simplifying configuration by providing a default rule list.

### Pipeline Slicing and Log Status {#pipeline}

Pipeline is a simple scripting language offering various functions and syntax to define rules for processing text data, primarily used for parsing unstructured text into meaningful fields or extracting parts from structured text like JSON.

Pipeline implementation is complex, involving abstract syntax trees (AST) and internal state machines, but we won't delve into those details here.

Consider an example:

Original log line:

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

> Note: The `status` field in the Pipeline result is `INFO`, but Datakit maps it to lowercase `info` for consistency.

Pipeline is the final step in log data processing. Datakit uses Pipeline results to construct line protocols, serialize objects, and prepare them for transmission to Dataway.

## Sending Data and Synchronization {#send}

Sending data is a common operation in Datakit, involving three main steps: "packing," "encoding," and "transmitting."

However, essential operations follow sending: "synchronizing the current file's read position" and "detecting file status."

### Synchronization {#sync}

As mentioned earlier regarding "network stream data," to enable resuming log collection from a specific point rather than just reading from the start or using `tail -f`, Datakit introduces the critical operation of recording the current file's read position (position).

Each time Datakit reads data from a disk file, it records the position in the file. Only after completing processing and transmission does it synchronize this position with other data to a separate disk file.

This ensures that upon restarting log collection, Datakit can resume from the last recorded position, preventing duplicate data collection or data loss.

Functionally, this is straightforward:

When Datakit initiates log collection, it constructs a unique key using the "absolute file path + file inode + first N bytes of the file." It uses this key to search for the position in a specified file.

- If a position is found, it indicates the file was previously collected, and Datakit resumes reading from that position.
- If no position is found, it treats the file as new, choosing to read from the start or end based on the situation.

### Detecting File Status {#checking}

Disk file states change over time, including deletion, renaming, or prolonged inactivity. Datakit handles these scenarios accordingly.

- Long-term inactive files:
    - Datakit periodically checks the modification time (`file Modification Date`). If it exceeds a threshold, the file is deemed "inactive" and closed to prevent further collection.
    - This logic applies when using glob rules to search for log files; if a file hasn't been modified for a long time, it won't be collected.

- File rotation:
    - Rotation changes the file name's target inode. For example, Docker log writes involve rotation.

Datakit regularly checks if the current file has been rotated by opening a new file handle with the same name and comparing it with the existing handle using a function like `SameFile()`. If they differ, it indicates rotation.

Upon detecting rotation, Datakit collects the remaining data until EOF, reopens the file, and resumes normal operations.

## Summary {#end}

Log collection is a complex system involving numerous detail handling and optimization logic. This article aims to introduce the design and implementation of the Datakit log collection system, excluding benchmark reports and performance comparisons with similar projects, which can be covered in future updates.

Additional links:

- [Glob Pattern Introduction](https://en.wikipedia.org/wiki/Glob_(programming)){:target="_blank"}
- [Datakit Automatic Multi-line Configuration](https://docs.guance.com/integrations/logging/#auto-multiline){:target="_blank"}
- [Datakit Pipeline Processing](https://docs.guance.com/datakit/pipeline/){:target="_blank"}
- [Docker Truncation Discussion for Logs Exceeding 16KiB](https://github.com/moby/moby/issues/34855){:target="_blank"}
- [Docker Truncation Source Code for Logs Exceeding 16KiB](https://github.com/nalind/docker/blob/master/daemon/logger/copier.go#L13){:target="_blank"}
- [Docker Logging Driver](https://docs.docker.com/config/containers/logging/local/){:target="_blank"}