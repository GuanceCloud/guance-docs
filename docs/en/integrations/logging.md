---
title     : 'LOG COLLECTION'
summary   : 'Collect log data from the HOST'
tags:
  - 'LOGS'
__int_icon      : 'icon/logging'
dashboard :
  - desc  : 'LOGS'
    path  : '-'
monitor   :
  - desc  : 'Not applicable'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

This document primarily introduces local disk log collection and Socket log collection:

- Disk log collection: Collects data from file tails (similar to the command-line `tail -f`)
- Socket port acquisition: Sends logs to DataKit via TCP/UDP

## Configuration {#config}

<!-- markdownlint-disable MD046 -->
=== "HOST Deployment"

    Enter the `conf.d/log` directory under the DataKit installation directory, copy `logging.conf.sample`, and rename it to `logging.conf`. Example as follows:
    
    ``` toml
    [[inputs.logging]]
      # List of log files, absolute paths can be specified, supports using glob rules for batch designation
      # It is recommended to use absolute paths and specify file extensions
      # Try to narrow the scope to avoid collecting compressed package files or binary files
      logfiles = [
        "/var/log/*.log",                          # All log files under the file path
        "/var/log/*.txt",                          # All txt files under the file path
        "/var/log/sys*",                           # All files under the file path with sys prefix
        "/var/log/syslog",                         # Unix format file path
        '''C:\\path\\space 空格中文路径\\*.txt''', # Windows style file path, path separator is double backslash \\, and there are three single quotes on each side
      ]
    
      ## Currently supports two protocols for socket: tcp/udp. It is recommended to enable internal network ports to prevent security risks
      ## Only one of socket and log can be selected, cannot collect both through files and through sockets
      socket = [
       "tcp://0.0.0.0:9540"
       "udp://0.0.0.0:9541"
      ]
    
      # File path filtering, using glob rules, any file that matches a filter condition will not be collected
      ignore = [""]
      
      # Data source, if empty, defaults to 'default'
      source = ""
      
      # New tag creation, if empty, defaults to $source
      service = ""
      
      # Pipeline script path, if empty, uses $source.p; if $source.p does not exist, pipeline will not be used
      pipeline = ""
      
      # Filter corresponding status
      #   `emerg`,`alert`,`critical`,`error`,`warning`,`info`,`debug`,`OK`
      ignore_status = []
      
      # Select encoding, if encoding is incorrect, data may not be viewable. Default is fine when left empty
      #    `utf-8`, `utf-16le`, `utf-16le`, `gbk`, `gb18030` or ""
      character_encoding = ""
      
      ## Set regular expressions, for example ^\d{4}-\d{2}-\d{2} matches YYYY-MM-DD time format at the start of the line
      ## Data matching this regex will be considered valid, otherwise it will accumulate and append to the end of the previous valid data
      ## Use three single quotes '''this-regexp''' to avoid escaping
      ## Regular expression reference: https://golang.org/pkg/regexp/syntax/#hdr-Syntax
      # multiline_match = '''^\S'''

      ## Whether to enable automatic multiline mode, if enabled, it will match applicable multiline rules in the patterns list
      auto_multiline_detection = true
      ## Configure automatic multiline patterns list, content is an array of multiline rules, i.e., multiple multiline_match, if empty then default rules are used, see documentation
      auto_multiline_extra_patterns = []

      ## Whether to remove ANSI escape codes, such as text colors in standard output, etc.
      remove_ansi_escape_codes = false

      ## Limit the maximum number of open files, default is 500
      ## This is a global configuration; if multiple collectors configure this item, the maximum value will be used
      # max_open_files = 500

      ## Ignore inactive files, e.g., if the last modification was more than 20 minutes ago, beyond 10m, the file will be ignored
      ## Supported time units are "ms", "s", "m", "h"
      ignore_dead_log = "1h"

      ## Whether to start reading from the beginning of the file
      from_beginning = false
    
      # Custom tags
      [inputs.logging.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
      # ...
    ```

=== "KUBERNETES/Docker/Containerd"

    In Kubernetes, once the [CONTAINER collector](container.md) starts, it will by default capture stdout/stderr logs from various CONTAINERS (including CONTAINERS within Pods). There are several configuration methods for CONTAINER logs:

    - [Adjust CONTAINER log collection via Annotation/Label](container.md#logging-with-annotation-or-label)
    - [Configure log collection based on CONTAINER image](container.md#logging-with-image-config)
    - [Collect Pod internal logs via Sidecar form](logfwd.md)

???+ Note "Explanation about `ignore_dead_log`"

    If a file is already being collected but no new logs have been written within 1h, DataKit will close the collection of that file. During this period (1h), the file **cannot** be physically deleted (for example, after `rm`, the file is only marked for deletion, and it will only be truly deleted after DataKit closes the file).
<!-- markdownlint-enable -->

### Socket log collection {#socket}

Comment out `logfiles` in the conf and configure `sockets`. For example, using log4j2:

``` xml
 <!-- Socket configuration sends logs to port 9540 on this machine, protocol defaults to tcp -->
 <Socket name="name1" host="localHost" port="9540" charset="utf8">
     <!-- Output format Sequence layout-->
     <PatternLayout pattern="%d{yyyy.MM.dd 'at' HH:mm:ss z} %-5level %class{36} %L %M - %msg%xEx%n"/>

     <!-- Note: Do not enable serialized transmission to the socket collector, currently DataKit cannot deserialize, please use plain text transmission -->
     <!-- <SerializedLayout/>-->
 </Socket>
```

For more configuration and code examples of mainstream Java Go Python logging components, refer to [socket client configuration](logging_socket.md).

### Multiline log collection {#multiline}

By identifying the characteristic of the first line of multiline logs, you can determine whether a line of log is a new log. If it doesn't meet this characteristic, we consider the current line of log just as an appendage to the previous multiline log.

To illustrate, usually logs are written flush-left, but some log texts are not flush-left, like call stack logs when the program crashes. Therefore, for such log texts, they are multiline logs.

In DataKit, we use regular expressions to identify the characteristics of multiline logs. Logs matching the regex indicate the start of a new log, all subsequent non-matching log lines are considered appended to this new log until another line matches the regex for a new log.

Modify the following configurations in `logging.conf`:

```toml
multiline_match = ''' Here write the specific regular expression ''' # Note: It's recommended to add three 'English single quotes' on each side of the regex
```

The style of regular expressions used in the log collector [reference](https://golang.org/pkg/regexp/syntax/#hdr-Syntax){:target="_blank"}

Assuming the original data is:

```not-set
2020-10-23 06:41:56,688 INFO demo.py 1.0
2020-10-23 06:54:20,164 ERROR /usr/local/lib/python3.6/dist-packages/flask/app.py Exception on /0 [GET]
Traceback (most recent call last):
  File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app
    response = self.full_dispatch_request()
ZeroDivisionError: division by zero
2020-10-23 06:41:56,688 INFO demo.py 5.0
```

`multiline_match` configured as `^\\d{4}-\\d{2}-\\d{2}.*` (i.e., matching lines starting with something like `2020-10-23`)

Three resulting lines of protocol points are as follows (line numbers are 1/2/8 respectively). You can see that `Traceback ...` (lines 3 ~ 6) do not form a separate log entry but are appended to the `message` field of the previous log entry (line 2).

```not-set
testing,filename=/tmp/094318188 message="2020-10-23 06:41:56,688 INFO demo.py 1.0" 1611746438938808642
testing,filename=/tmp/094318188 message="2020-10-23 06:54:20,164 ERROR /usr/local/lib/python3.6/dist-packages/flask/app.py Exception on /0 [GET]
Traceback (most recent call last):
  File \"/usr/local/lib/python3.6/dist-packages/flask/app.py\", line 2447, in wsgi_app
    response = self.full_dispatch_request()
ZeroDivisionError: division by zero
" 1611746441941718584
testing,filename=/tmp/094318188 message="2020-10-23 06:41:56,688 INFO demo.py 5.0" 1611746443938917265
```

#### Automatic multiline mode {#auto-multiline}

After enabling this feature, each line of log data will be matched against the multiline list. If a match is successful, the weight of the current multiline rule will be incremented by one to allow faster matching later, then exit the matching loop; if the entire list has been checked and still no match is found, it is considered a failed match.

Successful and failed matches follow the same operations as normal multiline log collection: On a successful match, the existing multiline data will be sent out, and the current line will be filled in; on a failed match, it will append to the end of the existing data.

Because there are multiple multiline configurations for logs, their priorities are as follows:

1. `multiline_match` is not empty, only use the current rule
1. Use the mapping configuration from source to `multiline_match` (only exists in container logs as `logging_source_multiline_map`), if the corresponding multiline rule can be found using source, only use this rule
1. Enable `auto_multiline_detection`, if `auto_multiline_extra_patterns` is not empty, match within these multiline rules
1. Enable `auto_multiline_detection`, if `auto_multiline_extra_patterns` is empty, use the default automatic multiline matching rule list, i.e.:

```not-set
// time.RFC3339, "2006-01-02T15:04:05Z07:00"
`^\d+-\d+-\d+T\d+:\d+:\d+(\.\d+)?(Z\d*:?\d*)?`,

// time.ANSIC, "Mon Jan _2 15:04:05 2006"
`^[A-Za-z_]+ [A-Za-z_]+ +\d+ \d+:\d+:\d+ \d+`,

// time.RubyDate, "Mon Jan 02 15:04:05 -0700 2006"
`^[A-Za-z_]+ [A-Za-z_]+ \d+ \d+:\d+:\d+ [\-\+]\d+ \d+`,

// time.UnixDate, "Mon Jan _2 15:04:05 MST 2006"
`^[A-Za-z_]+ [A-Za-z_]+ +\d+ \d+:\d+:\d+( [A-Za-z_]+ \d+)?`,

// time.RFC822, "02 Jan 06 15:04 MST"
`^\d+ [A-Za-z_]+ \d+ \d+:\d+ [A-Za-z_]+`,

// time.RFC822Z, "02 Jan 06 15:04 -0700" // RFC822 with numeric zone
`^\d+ [A-Za-z_]+ \d+ \d+:\d+ -\d+`,

// time.RFC850, "Monday, 02-Jan-06 15:04:05 MST"
`^[A-Za-z_]+, \d+-[A-Za-z_]+-\d+ \d+:\d+:\d+ [A-Za-z_]+`,

// time.RFC1123, "Mon, 02 Jan 2006 15:04:05 MST"
`^[A-Za-z_]+, \d+ [A-Za-z_]+ \d+ \d+:\d+:\d+ [A-Za-z_]+`,

// time.RFC1123Z, "Mon, 02 Jan 2006 15:04:05 -0700" // RFC1123 with numeric zone
`^[A-Za-z_]+, \d+ [A-Za-z_]+ \d+ \d+:\d+:\d+ -\d+`,

// time.RFC3339Nano, "2006-01-02T15:04:05.999999999Z07:00"
`^\d+-\d+-\d+[A-Za-z_]+\d+:\d+:\d+\.\d+[A-Za-z_]+\d+:\d+`,

// 2021-07-08 05:08:19,214
`^\d+-\d+-\d+ \d+:\d+:\d+(,\d+)?`,

// Default java logging SimpleFormatter date format
`^[A-Za-z_]+ \d+, \d+ \d+:\d+:\d+ (AM|PM)`,

// 2021-01-31 - stricter matching around months/days
`^\d{4}-(0?[1-9]|1[012])-(0?[1-9]|[12][0-9]|3[01])`,
```

#### Restrictions on handling extremely long multiline logs {#too-long-logs}

Currently, it can handle multiline logs up to 32MiB per line. If the actual multiline log exceeds 32MiB, DataKit will recognize it as multiple logs. For example, assuming we have the following multiline log, which we want to recognize as a single log:

```log
2020-10-23 06:54:20,164 ERROR /usr/local/lib/python3.6/dist-packages/flask/app.py Exception on /0 [GET]
Traceback (most recent call last):
  File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app
    response = self.full_dispatch_request()
      ...                                 <---- Omitted 32MiB - 800 bytes here, adding the above 4 lines, just exceeding 32MiB
        File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app
          response = self.full_dispatch_request()
             ZeroDivisionError: division by zero
2020-10-23 06:41:56,688 INFO demo.py 5.0  <---- A completely new multiline log
Traceback (most recent call last):
 ...
```

Here, due to an excessively long multiline log, the first log exceeds 32MiB, so DataKit prematurely ends this multiline log, ultimately resulting in three logs:

First: The top 32MiB

```log
2020-10-23 06:54:20,164 ERROR /usr/local/lib/python3.6/dist-packages/flask/app.py Exception on /0 [GET]
Traceback (most recent call last):
  File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app
    response = self.full_dispatch_request()
      ...                                 <---- Omitted 32MiB - 800 bytes here, adding the above 4 lines, just exceeding 32MiB
```

Second: The remaining part after the top 32MiB becomes an independent log

```log
        File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app
          response = self.full_dispatch_request()
             ZeroDivisionError: division by zero
```

Third: The next completely new log:

```log
2020-10-23 06:41:56,688 INFO demo.py 5.0  <---- A completely new multiline log
Traceback (most recent call last):
 ...
```

#### Maximum length of a single log line {#max-log}

Whether reading logs from files or from sockets, the maximum length of a single line (including after processing by `multiline_match`) is 32MB, exceeding parts will be truncated and discarded.

### Pipeline Configuration and Usage {#pipeline}

[Pipeline](../pipeline/use-pipeline/index.md) is mainly used to parse unstructured text data, or extract partial information from structured text (such as JSON).

For log data, the main fields extracted are:

- `time`: The generation time of the log, if the `time` field is not extracted or parsing fails, the system current time is used by default
- `status`: The level of the log, if the `status` field is not extracted, it defaults to `unknown`

#### Available log levels {#status}

Valid `status` field values are as follows (case-insensitive):

| Log Levels Available | Abbreviation | Display Value in Studio |
| ------------         | :----        | ----                    |
| `alert`              | `a`         | `alert`                 |
| `critical`           | `c`         | `critical`              |
| `error`              | `e`         | `error`                 |
| `warning`            | `w`         | `warning`               |
| `notice`             | `n`         | `notice`                |
| `info`               | `i`         | `info`                  |
| `debug/trace/verbose` | `d`         | `debug`                 |
| `OK`                 | `o`/`s`     | `OK`                   |

Example: Assuming the text data is as follows:

```not-set
12115:M 08 Jan 17:45:41.572 # Server started, Redis version 3.0.6
```

Pipeline script:

```python
add_pattern("date2", "%{MONTHDAY} %{MONTH} %{YEAR}?%{TIME}")
grok(_, "%{INT:pid}:%{WORD:role} %{date2:time} %{NOTSPACE:serverity} %{GREEDYDATA:msg}")
group_in(serverity, ["#"], "warning", status)
cast(pid, "int")
default_time(time)
```

Final result:

```python
{
    "message": "12115:M 08 Jan 17:45:41.572 # Server started, Redis version 3.0.6",
    "msg": "Server started, Redis version 3.0.6",
    "pid": 12115,
    "role": "M",
    "serverity": "#",
    "status": "warning",
    "time": 1610127941572000000
}
```

Several notes about the Pipeline:

- If the `pipeline` field in the logging.conf configuration file is empty, it defaults to `<source-name>.p` (assuming `source` is `nginx`, then it defaults to `nginx.p`)
- If `<source-name.p>` does not exist, the Pipeline function will not be enabled
- All Pipeline script files are uniformly stored in the Pipeline directory under the Datakit installation path
- If the log file configuration is a wildcard directory, the logging collector will automatically discover new log files to ensure that new log files conforming to the rules are collected as soon as possible

### Glob Rules Summary {#glob-rules}

Use glob rules to conveniently specify log files and automatically discover and filter files.

| Wildcard  | Description                               | Regex Example      | Match Example                    | Not Match                     |
| :--       | ---                                      | ---               | ---                             | ----                         |
| `*`       | Matches any number of any characters, including none | `Law*`             | `Law, Laws, Lawyer`             | `GrokLaw, La, aw`             |
| `?`       | Matches any single character              | `?at`             | `Cat, cat, Bat, bat`            | `at`                         |
| `[abc]`   | Matches one of the characters given inside brackets | `[CB]at`           | `Cat, Bat`                      | `cat, bat`                   |
| `[a-z]`   | Matches one of the characters in the range given inside brackets | `Letter[0-9]`      | `Letter0, Letter1, Letter9`     | `Letters, Letter, Letter10`   |
| `[!abc]`  | Matches one of the characters not given inside brackets | `[!C]at`           | `Bat, bat, cat`                | `Cat`                        |
| `[!a-z]`  | Matches one of the characters not in the range given inside brackets | `Letter[!3-5]`     | `Letter1…`                     | `Letter3 … Letter5, Letterxx` |

It should be noted that apart from the aforementioned glob standard rules, the collector also supports `**` for recursive file traversal, as shown in the example configuration. More Grok introductions can be found [here](https://rgb-24bit.github.io/blog/2018/glob.html){:target="_blank"}.

### File Reading Offset Position {#read-position}

*Supports Datakit [:octicons-tag-24: Version-1.5.5](../datakit/changelog.md#cl-1.5.5) and above.*

The file reading offset refers to where to start reading after opening the file. Generally, it is either "head" or "tail".

In Datakit, there are mainly 3 scenarios, prioritized as follows:

- First, use the position cache of the file. If the position value can be obtained and is less than or equal to the file size (indicating that this is a file that has not been truncated), use this position as the reading offset.
- Second, set `from_beginning` to `true`, which reads from the head of the file.
- Finally, the default "tail" mode, which reads from the tail.

<!-- markdownlint-disable MD046 -->
???+ Note "Explanation about `position cache`"

    `position cache` is a built-in feature of log collection. It consists of multiple K/V pairs stored in the `cahce/logtail.history` file:

    - The key is a unique value generated based on the log file path, inode, etc.
    - The value is the read offset (position) of this file, and it updates in real-time.

    When log collection starts, it retrieves the position as the read offset according to the key, avoiding missed collections and duplicate collections.
<!-- markdownlint-enable -->

### Special Bytecode Handling for Logs {#ansi-decode}

Logs may contain unreadable bytecodes (such as color outputs from terminals), setting `remove_ansi_escape_codes` to true can filter them out.

<!-- markdownlint-disable MD046 -->
???+ Attention

    It is generally recommended to disable color characters in the log output framework instead of having Datakit filter them. The screening and filtering of special characters are handled by regular expressions, which may not cover everything comprehensively and incur some performance overhead.
<!-- markdownlint-enable -->

Benchmark test results for processing performance are as follows, for reference:

```text
goos: linux
goarch: arm64
pkg: ansi
BenchmarkStrip
BenchmarkStrip-2          653751              1775 ns/op             272 B/op          3 allocs/op
BenchmarkStrip-4          673238              1801 ns/op             272 B/op          3 allocs/op
PASS
ok      ansi      2.422s
```

Each text processing increases by approximately 1700 ns. Without enabling this function, there will be no extra cost.

### Field Whitelisting to Retain Specific Fields {#field-whitelist}

The following basic fields are included in CONTAINER log collection:

| Field Name           |
| -----------          |
| `service`            |
| `status`             |
| `filepath`           |
| `log_read_lines`     |

In special scenarios, many basic fields might not be necessary. Now a whitelist (whitelist) function is provided to retain only specified fields.

Field whitelist configuration example `'["service", "filepath"]'`, details as follows:

- If the whitelist is empty, all basic fields are added
- If the whitelist is not empty and the value is valid, such as `["service", "filepath"]`, then only these two fields are retained
- If the whitelist is not empty and all fields are invalid, such as `["no-exist"]` or `["no-exist-key1", "no-exist-key2"]`, the data is discarded

For other sources of tags fields, there are the following situations:

- The whitelist does not affect Datakit's global tags (`global tags`)
- Debug fields enabled via `ENV_ENABLE_DEBUG_FIELDS = "true"` remain unaffected, including `log_read_offset` and `log_file_inode` from log collection, as well as debug fields from `pipeline`

## LOGS {#logging}

All data collection below appends a global tag named `host` by default (tag value is the hostname of the DataKit host), and other tags can be specified in the configuration via `[inputs.logging.tags]`:

``` toml
 [inputs.logging.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `Logging Collection`

Use the `source` of the config, if empty then use `default`

- Tags


| Tag | Description |
|  ----  | --------|
|`filename`|The base name of the file.|
|`host`|Host name|
|`service`|Use the `service` of the config.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`__namespace`|Built-in extension fields added by server. The unique identifier for a log document dataType.|string|-|
|`__truncated_count`|Built-in extension fields added by server. If the log is particularly large (usually exceeding 1M in size), the central system will split it and add three fields: `__truncated_id`, `__truncated_count`, and `__truncated_number` to define the splitting scenario. The __truncated_count field represents the total number of logs resulting from the split.|int|-|
|`__truncated_id`|Built-in extension fields added by server. If the log is particularly large (usually exceeding 1M in size), the central system will split it and add three fields: `__truncated_id`, `__truncated_count`, and `__truncated_number` to define the splitting scenario. The __truncated_id field represents the unique identifier for the split log.|string|-|
|`__truncated_number`|Built-in extension fields added by server. If the log is particularly large (usually exceeding 1M in size), the central system will split it and add three fields: `__truncated_id`, `__truncated_count`, and `__truncated_number` to define the splitting scenario. The __truncated_count field represents represents the current sequential identifier for the split logs.|int|-|
|``__docid``|Built-in extension fields added by server. The unique identifier for a log document, typically used for sorting and viewing details|string|-|
|`create_time`|Built-in extension fields added by server. The `create_time` field represents the time when the log is written to the storage engine.|int|ms|
|`date`|Built-in extension fields added by server. The `date` field is set to the time when the log is collected by the collector by default, but it can be overridden using a Pipeline.|int|ms|
|`date_ns`|Built-in extension fields added by server. The `date_ns` field is set to the millisecond part of the time when the log is collected by the collector by default. Its maximum value is 1.0E+6 and its unit is nanoseconds. It is typically used for sorting.|int|ns|
|`df_metering_size`|Built-in extension fields added by server. The `df_metering_size` field is used for logging cost statistics.|int|-|
|`log_read_lines`|The lines of the read file.|int|count|
|`message`|The text of the logging.|string|-|
|`status`|The status of the logging, default is `unknown`[^1].|string|-|



<!-- markdownlint-disable MD053 -->
[^1]: Early Pipeline implementations could only cut out fields, and most statuses were obtained through Pipeline cutting, hence categorizing it under fields. Semantically, however, it should belong to tags.
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD013 -->
## FAQ {#faq}

### :material-chat-question: Why don't I see log data on the page? {#why-no-data}

After DataKit starts, **log files configured in `logfiles` will only be collected if new logs are generated, old logs will not be collected**.

Additionally, once the collection of a certain log file begins, it will automatically trigger a log with content similar to the following:

``` not-set
First Message. filename: /some/path/to/new/log ...
```

If you see such information, it means the specified file has started to be collected, but currently no new log data is being generated. Moreover, uploading, processing, and storing log data takes some time, even if new data is generated, you need to wait a certain amount of time (< 1min).

### :material-chat-question: Mutual Exclusivity of Disk Log Collection and Socket Log Collection {#exclusion}

These two collection methods are mutually exclusive. When collecting logs via Socket, the `logfiles` field in the configuration must be set to empty: `logfiles=[]`

### :material-chat-question: Remote File Collection Solution {#remote-ntfs}

On Linux, you can use the [NFS method](https://linuxize.com/post/how-to-mount-an-nfs-share-in-linux/){:target="_blank"} to mount the file path of the log-hosted HOST onto the DataKit HOST. Then, the logging collector can be configured with the corresponding log path.

### :material-chat-question: MacOS Log Collector Error `operation not permitted` {#mac-no-permission}

In MacOS, due to system security policies, the DataKit log collector may fail to open files, reporting the error `operation not permitted`. Refer to the [Apple Developer Doc](https://developer.apple.com/documentation/security/disabling_and_enabling_system_integrity_protection){:target="_blank"} for solutions.

### :material-chat-question: How to Estimate the Total Volume of Logs {#log-size}

Since logs are charged based on the number of entries, but generally most logs are written to the disk by programs, and only the disk usage size can be seen (for example, 100GB of logs daily).

A feasible way is to use the following simple shell to judge:

```shell
# Count the number of lines in 1GB of logs
head -c 1g path/to/your/log.txt | wc -l
```

Sometimes, you need to estimate the potential traffic consumption caused by log collection:

```shell
# Count the size (in bytes) of 1GB of logs after compression
head -c 1g path/to/your/log.txt | gzip | wc -c
```

Here, the number of bytes after compression is obtained, and according to the network bit calculation method (x8), the bandwidth consumption can be calculated as follows:

``` not-set
bytes * 2 * 8 /1024/1024 = xxx MBit
```

But actually, the compression rate of DataKit won't be this high because DataKit won't send 1GB of data at once, but rather in multiple batches, with a compression rate of around 85% (i.e., compressing 100MB to 15MB). Hence, a rough calculation method is:

``` not-set
1GB * 2 * 8 * 0.15/1024/1024 = xxx MBit
```

<!-- markdownlint-disable MD046 -->
??? info

    Here `*2` accounts for the actual data expansion caused by [Pipeline Cutting](../pipeline/use-pipeline/index.md). Normally, the original data is retained after cutting, so considering the worst-case scenario, doubling is used for the calculation.
<!-- markdownlint-enable -->

## Further Reading {#more-reading}

- [DataKit Log Collection Overview](datakit-logging.md)
- [Pipeline: Text Data Processing](../pipeline/use-pipeline/index.md)
- [Pipeline Debugging](../developers/datakit-pl-how-to.md)
- [Pipeline Performance Testing and Comparison](logging-pipeline-bench.md)
- [Collect Container Internal Logs via Sidecar(logfwd)](logfwd.md)
- [Properly Configuring Using Regular Expressions](../datakit/datakit-input-conf.md#debug-regex)