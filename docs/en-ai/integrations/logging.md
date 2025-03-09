---
title     : 'Log Collection'
summary   : 'Collect log data from hosts'
tags:
  - 'Logs'
__int_icon      : 'icon/logging'
dashboard :
  - desc  : 'Logs'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

This document primarily introduces local disk log collection and Socket log collection:

- Disk Log Collection: Collects data from the end of files (similar to the command line `tail -f`)
- Socket Port Collection: Sends logs to DataKit via TCP/UDP methods

## Configuration {#config}

<!-- markdownlint-disable MD046 -->
=== "Host Deployment"

    Enter the `conf.d/log` directory under the DataKit installation directory, copy `logging.conf.sample` and rename it to `logging.conf`. An example is as follows:
    
    ``` toml
    [[inputs.logging]]
      # List of log files; absolute paths can be specified, supporting glob rules for batch designation
      # It is recommended to use absolute paths with file extensions specified
      # Try to narrow the scope to avoid collecting compressed package files or binary files
      logfiles = [
        "/var/log/*.log",                          # All log files in the file path
        "/var/log/*.txt",                          # All txt files in the file path
        "/var/log/sys*",                           # All files with the sys prefix in the file path
        "/var/log/syslog",                         # Unix format file path
        '''C:\\path\\space 空格中文路径\\*.txt''', # Windows style file path, path separator is double backslash \\, and three single quotes on each side
      ]
    
      ## Sockets currently support two protocols: tcp/udp. It is recommended to enable internal network ports to prevent security risks
      ## Sockets and logs can only choose one; file-based collection and socket-based collection cannot be used simultaneously
      socket = [
       "tcp://0.0.0.0:9540"
       "udp://0.0.0.0:9541"
      ]
    
      # File path filtering using glob rules; files matching any filter condition will not be collected
      ignore = [""]
      
      # Data source; if empty, defaults to 'default'
      source = ""
      
      # Add tag, if empty, defaults to $source
      service = ""
      
      # Pipeline script path; if empty, uses $source.p, if $source.p does not exist, no pipeline is used
      pipeline = ""
      
      # Filter corresponding status
      #   `emerg`,`alert`,`critical`,`error`,`warning`,`info`,`debug`,`OK`
      ignore_status = []
      
      # Select encoding; incorrect encoding can make data unreadable. Default is empty
      #    `utf-8`, `utf-16le`, `utf-16le`, `gbk`, `gb18030` or ""
      character_encoding = ""
      
      ## Set regular expression, e.g., ^\d{4}-\d{2}-\d{2} matches lines starting with YYYY-MM-DD time format
      ## Data matching this regex will be considered valid; otherwise, it will be appended to the end of the previous valid data
      ## Use three single quotes '''this-regexp''' to avoid escaping
      ## Regular expression link: https://golang.org/pkg/regexp/syntax/#hdr-Syntax
      # multiline_match = '''^\S'''

      ## Whether to enable automatic multiline mode; when enabled, it matches applicable multiline rules in the patterns list
      auto_multiline_detection = true
      ## Configure additional patterns for automatic multiline detection, content is an array of multiline rules, i.e., multiple multiline_match entries; if empty, default rules are used, see documentation
      auto_multiline_extra_patterns = []

      ## Whether to remove ANSI escape codes, such as text colors in standard output
      remove_ansi_escape_codes = false

      ## Limit the maximum number of open files, default is 500
      ## This is a global configuration; if multiple collectors configure this item, the highest value will be used
      # max_open_files = 500

      ## Ignore inactive files, e.g., if the file was last modified more than 20 minutes ago and has been inactive for over 10m, it will be ignored
      ## Time units supported: "ms", "s", "m", "h"
      ignore_dead_log = "1h"

      ## Whether to start reading from the beginning of the file
      from_beginning = false
    
      # Custom tags
      [inputs.logging.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
      # ...
    ```

=== "Kubernetes/Docker/Containerd"

    In Kubernetes, once the [container collector](container.md) starts, it will default to capturing stdout/stderr logs from various containers (including containers within Pods). There are several configuration methods for container logs:

    - [Adjust container log collection through Annotation/Label](container.md#logging-with-annotation-or-label)
    - [Configure log collection based on container image](container.md#logging-with-image-config)
    - [Collect Pod internal logs via Sidecar](logfwd.md)

???+ Note "Explanation about `ignore_dead_log`"

    If a file is being collected but no new logs have been written within 1h, DataKit will stop collecting that file. During this period (1h), the file **cannot** be physically deleted (e.g., using `rm`). The file is only marked for deletion, and DataKit will delete it after closing.
<!-- markdownlint-enable -->

### Socket Log Collection {#socket}

Comment out `logfiles` in the conf and configure `sockets`. For example, with log4j2:

``` xml
 <!-- Configure log transmission to port 9540 on localhost, protocol defaults to tcp -->
 <Socket name="name1" host="localHost" port="9540" charset="utf8">
     <!-- Output format sequence layout-->
     <PatternLayout pattern="%d{yyyy.MM.dd 'at' HH:mm:ss z} %-5level %class{36} %L %M - %msg%xEx%n"/>

     <!-- Note: Do not enable serialized transmission to the socket collector; currently, DataKit cannot deserialize. Use plain text format instead -->
     <!-- <SerializedLayout/>-->
 </Socket>
```

For more configurations and code examples of mainstream logging components in Java, Go, Python, please refer to [Socket client configuration](logging_socket.md).

### Multiline Log Collection {#multiline}

By identifying the first line feature of multiline logs, we can determine if a line of log is a new entry. If it does not match this feature, it is considered an appendage to the previous multiline log.

For instance, logs are usually written at the beginning of the line, but some logs, like stack traces during program crashes, are not. These are multiline logs.

In DataKit, we use regular expressions to identify multiline log features. Lines matching the regex are considered the start of a new log entry. Subsequent lines that do not match the regex are treated as appendages until another line matches the regex.

In `logging.conf`, modify the following configuration:

```toml
multiline_match = ''' Here specify the exact regular expression ''' # Note: The regex should be enclosed by three single quotes on each side
```

Refer to the [regular expression style](https://golang.org/pkg/regexp/syntax/#hdr-Syntax){:target="_blank"}

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

When `multiline_match` is configured as `^\\d{4}-\\d{2}-\\d{2}.*` (i.e., matching lines starting with `2020-10-23`):

The three parsed log entries (line numbers are 1/2/8) are as follows. Notice that the `Traceback ...` section (lines 3 to 6) does not form a separate log entry but is appended to the previous log entry (line 2) in the `message` field.

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

#### Automatic Multiline Mode {#auto-multiline}

Enabling this feature causes each line of log data to match against the multiline list. If a match is successful, the current multiline rule's weight is incremented for faster future matching, then the loop exits; if no match is found after checking the entire list, it is considered a failed match.

Whether a match succeeds or fails, subsequent operations are similar to normal multiline log collection: a successful match sends existing multiline data and adds the current line; a failed match appends the line to the end of existing data.

Because there can be multiple multiline configurations, their priorities are as follows:

1. If `multiline_match` is not empty, only the current rule is used
1. Use the mapping configuration from `source` to `multiline_match` (only exists in container logs with `logging_source_multiline_map`); if a multiline rule can be found using `source`, only this rule is used
1. Enable `auto_multiline_detection`; if `auto_multiline_extra_patterns` is not empty, it matches these multiline rules
1. Enable `auto_multiline_detection`; if `auto_multiline_extra_patterns` is empty, it uses the default automatic multiline matching rule list, which includes:

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

// 2021-01-31 - stricter matching around the months/days
`^\d{4}-(0?[1-9]|1[012])-(0?[1-9]|[12][0-9]|3[01])`,
```

#### Handling Extremely Long Multiline Logs {#too-long-logs}

Currently, DataKit can handle multiline logs up to 32MiB. If the actual multiline log exceeds 32MiB, DataKit will split it into multiple logs. For example, consider the following multiline log that we want to treat as a single log:

```log
2020-10-23 06:54:20,164 ERROR /usr/local/lib/python3.6/dist-packages/flask/app.py Exception on /0 [GET]
Traceback (most recent call last):
  File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app
    response = self.full_dispatch_request()
      ...                                 <---- Omitting 32MiB - 800 bytes, plus the above 4 lines, just exceeding 32MiB
        File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app
          response = self.full_dispatch_request()
             ZeroDivisionError: division by zero
2020-10-23 06:41:56,688 INFO demo.py 5.0  <---- A brand new multiline log
Traceback (most recent call last):
 ...
```

Here, due to extremely long multiline logs, the first log exceeds 32MiB, causing DataKit to prematurely end the multiline. Ultimately, three logs are obtained:

First log: The first 32MiB

```log
2020-10-23 06:54:20,164 ERROR /usr/local/lib/python3.6/dist-packages/flask/app.py Exception on /0 [GET]
Traceback (most recent call last):
  File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app
    response = self.full_dispatch_request()
      ...                                 <---- Omitting 32MiB - 800 bytes, plus the above 4 lines, just exceeding 32MiB
```

Second log: Remaining part after the first 32MiB becomes a separate log

```log
        File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app
          response = self.full_dispatch_request()
             ZeroDivisionError: division by zero
```

Third log: A new log entry below:

```log
2020-10-23 06:41:56,688 INFO demo.py 5.0  <---- A brand new multiline log
Traceback (most recent call last):
 ...
```

#### Maximum Length of Single Log Line {#max-log}

Regardless of whether logs are read from files or sockets, the maximum length of a single line (including those processed by `multiline_match`) is 32MB. Excess parts will be truncated and discarded.

### Pipeline Configuration and Usage {#pipeline}

[Pipeline](../pipeline/use-pipeline/index.md) is mainly used to parse unstructured text data or extract partial information from structured text (such as JSON).

For log data, the main extracted fields are:

- `time`: The generation time of the log. If the `time` field is not extracted or parsing fails, the system's current time is used by default.
- `status`: The log level. If the `status` field is not extracted, it defaults to `unknown`.

#### Available Log Levels {#status}

Valid `status` field values (case-insensitive) are as follows:

| Available Log Level | Abbreviation | Studio Display Value |
| ------------        | :----        | ----                 |
| `alert`             | `a`          | `alert`              |
| `critical`          | `c`          | `critical`           |
| `error`             | `e`          | `error`              |
| `warning`           | `w`          | `warning`            |
| `notice`            | `n`          | `notice`             |
| `info`              | `i`          | `info`               |
| `debug/trace/verbose` | `d`         | `debug`             |
| `OK`                | `o`/`s`      | `OK`                 |

Example: Assume the text data is as follows:

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

Key points for Pipeline:

- If `pipeline` is empty in the `logging.conf` configuration file, `<source-name>.p` is used by default (assuming `source` is `nginx`, then `nginx.p` is used by default)
- If `<source-name.p>` does not exist, the Pipeline feature is not enabled
- All Pipeline script files are stored uniformly in the Pipeline directory under the Datakit installation path
- If the log file configuration uses wildcard directories, the logging collector automatically discovers new log files to ensure that new log files conforming to the rules are collected as soon as possible

### Glob Rule Summary {#glob-rules}

Using glob rules makes it easier to specify log files and automatically discover and filter files.

| Wildcard | Description                                | Regex Example | Match Examples                  | Non-Match Examples              |
| :--      | ---                                        | ---           | ---                             | ----                            |
| `*`      | Matches any number of any characters, including none | `Law*`        | `Law, Laws, Lawyer`             | `GrokLaw, La, aw`               |
| `?`      | Matches any single character               | `?at`         | `Cat, cat, Bat, bat`            | `at`                            |
| `[abc]`  | Matches one character given in brackets    | `[CB]at`      | `Cat, Bat`                      | `cat, bat`                      |
| `[a-z]`  | Matches one character within the range     | `Letter[0-9]` | `Letter0, Letter1, Letter9`     | `Letters, Letter, Letter10`     |
| `[!abc]` | Matches one character not given in brackets| `[!C]at`      | `Bat, bat, cat`                 | `Cat`                           |
| `[!a-z]` | Matches one character outside the range    | `Letter[!3-5]`| `Letter1…`                      | `Letter3 … Letter5, Letterxx`   |

Additionally, the collector supports `**` for recursive file traversal, as shown in the sample configuration. More Grok introduction, see [here](https://rgb-24bit.github.io/blog/2018/glob.html){:target="_blank"}.

### File Read Offset Position {#read-position}

*Supported by Datakit [:octicons-tag-24: Version-1.5.5](../datakit/changelog.md#cl-1.5.5) and above.*

File read offset refers to where to start reading after opening the file. Generally, it is either "head" or "tail".

In Datakit, there are mainly three scenarios, prioritized as follows:

- Prefer using the position cache of the file. If the position value can be obtained and is less than or equal to the file size (indicating that the file has not been truncated), this position is used as the read offset.
- Next, if `from_beginning` is set to `true`, it reads from the head of the file.
- Finally, the default `tail` mode reads from the tail of the file.

<!-- markdownlint-disable MD046 -->
???+ Note "About `position cache`"

    `position cache` is a built-in feature of log collection. It consists of multiple K/V pairs stored in the `cahce/logtail.history` file:

    - Key is a unique value generated based on the log file path, inode, etc.
    - Value is the read offset (position) of this file, updated in real-time.

    When the log collector starts, it retrieves the position as the read offset to avoid missing or duplicate collections.
<!-- markdownlint-enable -->

### Special Byte Code Handling in Logs {#ansi-decode}

Logs may contain unreadable byte codes (like terminal color codes). Setting `remove_ansi_escape_codes` to `true` removes these codes.

<!-- markdownlint-disable MD046 -->
???+ attention

    It is generally recommended to disable color codes in the log output framework rather than having Datakit filter them. Filtering special characters using regular expressions might not cover all cases comprehensively and incurs performance overhead.
<!-- markdownlint-enable -->

Benchmark results for processing performance, for reference:

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

Each line of text processing increases by approximately 1700 ns. Not enabling this function incurs no additional overhead.

### Retain Specified Fields Based on Whitelist {#field-whitelist}

Container log collection includes the following basic fields:

| Field Name      |
| -----------     |
| `service`       |
| `status`        |
| `filepath`      |
| `log_read_lines`|

In specific scenarios, many basic fields may not be necessary. Now a whitelist (whitelist) function is provided to retain only specified fields.

Field whitelist configuration, for example, `'["service", "filepath"]'`, details as follows:

- If the whitelist is empty, all basic fields are added
- If the whitelist is not empty and valid, e.g., `["service", "filepath"]`, only these fields are retained
- If the whitelist is not empty but contains invalid fields, e.g., `["no-exist"]` or `["no-exist-key1", "no-exist-key2"]`, the data is discarded

For other source tags, there are the following situations:

- The whitelist does not apply to Datakit's global tags (`global tags`)
- Debug fields enabled by `ENV_ENABLE_DEBUG_FIELDS = "true"` are unaffected, including `log_read_offset` and `log_file_inode` for log collection, and debug fields for `pipeline`

## Logs {#logging}

All data collection defaults to appending a global tag named `host` (tag value is the hostname where DataKit resides). Other tags can be specified in the configuration using `[inputs.logging.tags]`:

``` toml
 [inputs.logging.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `logging collect`

Use the `source` from the config, if empty then use `default`

- Tags


| Tag | Description |
|  ----  | --------|
|`filename`|The base name of the file.|
|`host`|Host name|
|`service`|Use the `service` from the config.|

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
[^1]: In early Pipeline implementations, only fields could be parsed, and most statuses were derived from Pipeline parsing, hence they were categorized as fields. Semantically, however, they belong to the tag category.
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD013 -->
## FAQ {#faq}

### :material-chat-question: Why can't I see log data on the page? {#why-no-data}

After DataKit starts, **new logs must be generated in the log files configured in `logfiles` for collection**. Old log data will not be collected.

Additionally, once DataKit starts collecting a particular log file, it will automatically trigger a log entry with content similar to:

``` not-set
First Message. filename: /some/path/to/new/log ...
```

If you see such a message, it means the specified file has started being collected, but no new log data has been generated yet. Also, uploading, processing, and storing log data take some time, so even if new data is generated, it will take some time (< 1min).

### :material-chat-question: Exclusivity Between Disk Log Collection and Socket Log Collection {#exclusion}

These two collection methods are mutually exclusive. When collecting logs via Socket, the `logfiles` field in the configuration should be set to empty: `logfiles=[]`

### :material-chat-question: Remote File Collection Solution {#remote-ntfs}

On Linux, you can use the [NFS method](https://linuxize.com/post/how-to-mount-an-nfs-share-in-linux/){:target="_blank"} to mount the log file path from the log host to the DataKit host. The logging collector can then be configured with the corresponding log path.

### :material-chat-question: MacOS Log Collector Error `operation not permitted` {#mac-no-permission}

On MacOS, due to system security policies, the DataKit log collector may not be able to open files, reporting an `operation not permitted` error. Refer to the [Apple Developer Documentation](https://developer.apple.com/documentation/security/disabling_and_enabling_system_integrity_protection){:target="_blank"} for solutions.

### :material-chat-question: How to Estimate Total Log Volume {#log-size}

Since log costs are charged per entry, but most logs are written to disk by programs, you can only see the disk usage size (e.g., 100GB of logs per day).

One feasible way to estimate is to use the following simple shell command:

```shell
# Count the number of lines in 1GB of logs
head -c 1g path/to/your/log.txt | wc -l
```

Sometimes, you need to estimate the potential traffic consumption of log collection:

```shell
# Calculate the compressed size (bytes) of 1GB of logs
head -c 1g path/to/your/log.txt | gzip | wc -c
```

The result here is the compressed byte count. Using the network bit calculation method (x8), the bandwidth consumption can be calculated as follows:

``` not-set
bytes * 2 * 8 /1024/1024 = xxx MBit
```

However, DataKit's compression ratio is not this high because DataKit does not send 1GB of data at once but in multiple batches. The compression ratio is around 85% (i.e., 100MB compresses to 15MB), so a rough calculation would be:

``` not-set
1GB * 2 * 8 * 0.15/1024/1024 = xxx MBit
```

<!-- markdownlint-disable MD046 -->
??? info

    The `*2` accounts for [Pipeline parsing](../pipeline/use-pipeline/index.md) leading to actual data expansion. Generally, the parsed data retains the original data, so the worst-case scenario doubles the data volume.
<!-- markdownlint-enable -->

## Further Reading {#more-reading}

- [Overview of DataKit Log Collection](datakit-logging.md)
- [Pipeline: Text Data Processing](../pipeline/use-pipeline/index.md)
- [Pipeline Debugging](../developers/datakit-pl-how-to.md)
- [Pipeline Performance Testing and Comparison](logging-pipeline-bench.md)
- [Collect Container Internal Logs via Sidecar(logfwd)](logfwd.md)
- [Properly Configuring Regular Expressions](../datakit/datakit-input-conf.md#debug-regex)