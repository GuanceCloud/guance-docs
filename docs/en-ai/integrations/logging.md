---
title: Log Collection
summary: Collect log data from hosts
tags:
  - Logs
__int_icon: 'icon/logging'
dashboard:
  - desc: 'Logs'
    path: '-'
monitor:
  - desc: 'None'
    path: '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

This document primarily introduces local disk log collection and Socket log collection:

- Disk log collection: Collects data from the end of files (similar to the command line `tail -f`)
- Socket port acquisition: Sends logs to DataKit via TCP/UDP

## Configuration {#config}

<!-- markdownlint-disable MD046 -->
=== "Host Deployment"

    Enter the `conf.d/log` directory under the DataKit installation directory, copy `logging.conf.sample` and rename it to `logging.conf`. An example is as follows:
    
    ``` toml
    [[inputs.logging]]
      # List of log files, absolute paths can be specified, supporting batch designation using glob rules
      # It is recommended to use absolute paths and specify file extensions
      # Try to narrow down the scope to avoid collecting compressed or binary files
      logfiles = [
        "/var/log/*.log",                          # All log files under the file path
        "/var/log/*.txt",                          # All txt files under the file path
        "/var/log/sys*",                           # All files with sys prefix under the file path
        "/var/log/syslog",                         # Unix style file path
        '''C:\\path\\space 空格中文路径\\*.txt''', # Windows style file path, path separator is double backslash \\, with three single quotes on each side
      ]
    
      ## Currently supports two protocols for socket: tcp/udp. It's recommended to open internal network ports to prevent security risks
      ## Only one of socket or log can be chosen; cannot collect both through files and sockets
      socket = [
       "tcp://0.0.0.0:9540"
       "udp://0.0.0.0:9541"
      ]
    
      # File path filtering using glob rules; files matching any condition will not be collected
      ignore = [""]
      
      # Data source, defaults to 'default' if empty
      source = ""
      
      # Additional tag, defaults to $source if empty
      service = ""
      
      # Pipeline script path, defaults to $source.p if empty, and uses $source.p if it exists
      pipeline = ""
      
      # Filter corresponding status
      #   `emerg`,`alert`,`critical`,`error`,`warning`,`info`,`debug`,`OK`
      ignore_status = []
      
      # Choose encoding, incorrect encoding may prevent data viewing. Default is empty
      #    `utf-8`, `utf-16le`, `utf-16le`, `gbk`, `gb18030` or ""
      character_encoding = ""
      
      ## Set regular expression, e.g., ^\d{4}-\d{2}-\d{2} matches YYYY-MM-DD format at the start of a line
      ## Data matching this regex is considered valid; otherwise, it accumulates and appends to the last valid data
      ## Use three single quotes '''this-regexp''' to avoid escaping
      ## Regular expression reference: https://golang.org/pkg/regexp/syntax/#hdr-Syntax
      # multiline_match = '''^\S'''

      ## Whether to enable automatic multiline mode, which matches applicable multiline rules in the patterns list
      auto_multiline_detection = true
      ## Configure additional multiline patterns list, containing multiple multiline_match rules. If empty, default rules apply
      auto_multiline_extra_patterns = []

      ## Whether to remove ANSI escape codes, such as text colors in standard output
      remove_ansi_escape_codes = false

      ## Limit maximum open files, default is 500
      ## This is a global configuration; if multiple collectors configure this item, the maximum value is used
      # max_open_files = 500

      ## Ignore inactive files, e.g., files not modified within 20 minutes, exceeding 10m will be ignored
      ## Time units support "ms", "s", "m", "h"
      ignore_dead_log = "1h"

      ## Whether to read from the beginning of the file
      from_beginning = false
    
      # Custom tags
      [inputs.logging.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
      # ...
    ```

=== "Kubernetes/Docker/Containerd"

    In Kubernetes, once the [container collector](container.md) starts, it will default to capturing stdout/stderr logs from various containers (including containers under Pods). Container log configurations mainly include:

    - [Adjust container log collection via Annotation/Label](container.md#logging-with-annotation-or-label)
    - [Configure log collection based on container image](container.md#logging-with-image-config)
    - [Collect Pod internal logs via Sidecar](logfwd.md)

???+ Note "Explanation of `ignore_dead_log`"

    If a file is being collected but no new logs are written within 1 hour, DataKit will stop collecting from that file. During this period (1 hour), the file **cannot** be physically deleted (e.g., with `rm`; the file is only marked for deletion, and it will be truly deleted after DataKit closes the file).
<!-- markdownlint-enable -->

### Socket Log Collection {#socket}

Comment out `logfiles` in the conf and configure `sockets`. For example, with log4j2:

``` xml
 <!-- Configure log transmission to local port 9540, protocol defaults to tcp -->
 <Socket name="name1" host="localHost" port="9540" charset="utf8">
     <!-- Output format sequence layout -->
     <PatternLayout pattern="%d{yyyy.MM.dd 'at' HH:mm:ss z} %-5level %class{36} %L %M - %msg%xEx%n"/>

     <!-- Note: Do not enable serialized transmission to the socket collector as DataKit cannot deserialize; use plain text instead -->
     <!-- <SerializedLayout/>-->
 </Socket>
```

For more Java, Go, Python mainstream logging component configurations and code examples, refer to [Socket Client Configurations](logging_socket.md).

### Multiline Log Collection {#multiline}

By recognizing the first line feature of multiline logs, we can determine if a line of log is a new log entry. If it does not match this feature, we consider it an appendage to the previous multiline log.

For instance, logs are generally written without indentation, but some logs, like stack traces when a program crashes, are not top-aligned. These are multiline logs.

In DataKit, we use regular expressions to identify multiline log features. Lines matching the regex are considered new logs, and subsequent non-matching lines are appended until another matching line appears.

In `logging.conf`, modify the following configuration:

```toml
multiline_match = ''' Here, fill in the specific regular expression ''' # Note: Suggest adding three English single quotes on both sides of the regex
```

The regular expression style used in the log collector [reference](https://golang.org/pkg/regexp/syntax/#hdr-Syntax){:target="_blank"}

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

If `multiline_match` is set to `^\\d{4}-\\d{2}-\\d{2}.*` (matching lines starting with `2020-10-23`),

the resulting log entries would be (line numbers are 1/2/8):

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

When this feature is enabled, each line of log data is matched against the multiline list. If a match is found, the current multiline rule weight is incremented for faster matching later, then exits the matching loop; if no match is found after checking the entire list, it is considered a failed match.

Successful and failed matches handle operations similarly to normal multiline log collection: successful matches send existing multiline data and add the current line; failed matches append to the end of existing data.

Because multiple multiline configurations exist, their priority order is as follows:

1. `multiline_match` is not empty, only the current rule is used
1. Use the mapping configuration from source to `multiline_match` (only present in container logs with `logging_source_multiline_map`). If a corresponding multiline rule is found using source, only this rule is used
1. Enable `auto_multiline_detection`, if `auto_multiline_extra_patterns` is not empty, these multiline rules are matched
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

#### Handling Extremely Long Multiline Logs {#too-long-logs}

Currently, DataKit can process single multiline logs up to 32MiB. If the actual multiline log exceeds 32MiB, it will be split into multiple logs. For example, consider the following multiline log, which we want to recognize as a single log:

```log
2020-10-23 06:54:20,164 ERROR /usr/local/lib/python3.6/dist-packages/flask/app.py Exception on /0 [GET]
Traceback (most recent call last):
  File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app
    response = self.full_dispatch_request()
      ...                                 <---- Omitted 32MiB - 800 bytes, plus the above 4 lines, just over 32MiB
        File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app
          response = self.full_dispatch_request()
             ZeroDivisionError: division by zero
2020-10-23 06:41:56,688 INFO demo.py 5.0  <---- A brand new multiline log
Traceback (most recent call last):
 ...
```

Due to the extremely long multiline log, the first log exceeds 32MiB, so DataKit splits it into three logs:

First log: The first 32MiB part

```log
2020-10-23 06:54:20,164 ERROR /usr/local/lib/python3.6/dist-packages/flask/app.py Exception on /0 [GET]
Traceback (most recent call last):
  File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app
    response = self.full_dispatch_request()
      ...                                 <---- Omitted 32MiB - 800 bytes, plus the above 4 lines, just over 32MiB
```

Second log: Remaining part after the first 32MiB

```log
        File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app
          response = self.full_dispatch_request()
             ZeroDivisionError: division by zero
```

Third log: A brand new log

```log
2020-10-23 06:41:56,688 INFO demo.py 5.0  <---- A brand new multiline log
Traceback (most recent call last):
 ...
```

#### Maximum Length of Single Line Logs {#max-log}

Whether reading logs from files or sockets, the maximum length of a single line (including after `multiline_match` processing) is 32MB. Excess parts are truncated and discarded.

### Pipeline Configuration and Usage {#pipeline}

[Pipeline](../pipeline/use-pipeline/index.md) is mainly used to parse unstructured text data or extract information from structured text (such as JSON).

For log data, the main fields extracted are:

- `time`: The log generation time. If the `time` field is not extracted or parsed incorrectly, the system current time is used by default.
- `status`: The log level. If the `status` field is not extracted, it defaults to `unknown`.

#### Available Log Levels {#status}

Valid values for the `status` field (case-insensitive) are:

| Log Level           | Abbreviation | Studio Display Value |
| ------------        | :----        | ----                 |
| `alert`             | `a`          | `alert`              |
| `critical`          | `c`          | `critical`           |
| `error`             | `e`          | `error`              |
| `warning`           | `w`          | `warning`            |
| `notice`            | `n`          | `notice`             |
| `info`              | `i`          | `info`               |
| `debug/trace/verbose` | `d`         | `debug`              |
| `OK`                | `o`/`s`      | `OK`                 |

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

Pipeline points to note:

- If `pipeline` is empty in the logging.conf configuration file, it defaults to `<source-name>.p` (assuming `source` is `nginx`, then it defaults to `nginx.p`)
- If `<source-name.p>` does not exist, the Pipeline function is not enabled
- All Pipeline scripts are stored uniformly in the Pipeline directory under the Datakit installation path
- If the log file configuration specifies a wildcard directory, the logging collector automatically discovers new log files to ensure they are quickly collected

### Glob Rules Summary {#glob-rules}

Use glob rules to specify log files more conveniently, as well as for automatic discovery and file filtering.

| Wildcard | Description                              | Regex Example | Match Examples                  | Non-Match Examples              |
| :--      | ---                                      | ---           | ---                             | ----                            |
| `*`      | Matches any number of any characters, including none | `Law*`        | `Law, Laws, Lawyer`             | `GrokLaw, La, aw`               |
| `?`      | Matches any single character             | `?at`         | `Cat, cat, Bat, bat`            | `at`                            |
| `[abc]`  | Matches one character given in the brackets | `[CB]at`      | `Cat, Bat`                      | `cat, bat`                      |
| `[a-z]`  | Matches one character in the range given in the brackets | `Letter[0-9]` | `Letter0, Letter1, Letter9`     | `Letters, Letter, Letter10`     |
| `[!abc]` | Matches one character not given in the brackets | `[!C]at`      | `Bat, bat, cat`                 | `Cat`                           |
| `[!a-z]` | Matches one character not in the range given in the brackets | `Letter[!3-5]` | `Letter1…`                      | `Letter3 … Letter5, Letterxx`   |

Additionally, the collector supports `**` for recursive file traversal, as shown in the example configuration. More Grok details can be found [here](https://rgb-24bit.github.io/blog/2018/glob.html){:target="_blank"}.

### File Reading Offset Position {#read-position}

*Supported by Datakit [:octicons-tag-24: Version-1.5.5](../datakit/changelog.md#cl-1.5.5) and above.*

File reading offset refers to the position from which to start reading the file after opening it. Generally, it is either "head" or "tail".

In Datakit, there are mainly three scenarios, prioritized as follows:

- Preferably use the position cache of the file. If a position value can be obtained and is less than or equal to the file size (indicating it has not been truncated), use this position as the reading offset.
- Next, configure `from_beginning` as `true`, which reads from the beginning of the file.
- Finally, the default `tail` mode, which reads from the end of the file.

<!-- markdownlint-disable MD046 -->
???+ Note "Explanation of `position cache`"

    `position cache` is a built-in feature of log collection. It consists of multiple K/V pairs stored in the `cache/logtail.history` file:

    - Key is generated uniquely based on the log file path, inode, etc.
    - Value is the read offset position (position) of the file, updated in real-time

    At startup, the log collector retrieves the position as the reading offset to avoid missed or duplicate collection.
<!-- markdownlint-enable -->

### Special Byte Code Handling in Logs {#ansi-decode}

Logs may contain unreadable byte codes (such as terminal color outputs), which can be removed by setting `remove_ansi_escape_codes` to true.

<!-- markdownlint-disable MD046 -->
???+ attention

    It is usually recommended to disable color characters in the log output framework rather than filter them using Datakit. Filtering special characters is handled by regular expressions, which may not cover all cases comprehensively and can have performance overhead.
<!-- markdownlint-enable -->

Performance benchmarking results are as follows for reference:

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

Each line of text processing adds approximately 1700 ns. Without enabling this function, there is no extra cost.

### Field Whitelisting {#field-whitelist}

Container log collection includes the following base fields:

| Field Name |
| ----------- |
| `service`  |
| `status`   |
| `filepath` |
| `log_read_lines` |

In special scenarios, many base fields may not be necessary. Now, a whitelist (whitelist) feature is provided to retain only specified fields.

Field whitelist configuration, for example `'["service", "filepath"]'`, details as follows:

- If the whitelist is empty, all base fields are added.
- If the whitelist is not empty and valid, for example `["service", "filepath"]`, only these two fields are retained.
- If the whitelist is not empty and all fields are invalid, such as `["no-exist"]` or `["no-exist-key1", "no-exist-key2"]`, the data is discarded.

For other sources of tags fields, the following applies:

- The whitelist does not affect Datakit's global tags (`global tags`)
- Debug fields enabled by `ENV_ENABLE_DEBUG_FIELDS = "true"` remain unaffected, including `log_read_offset` and `log_file_inode` for log collection, and debug fields for `pipeline`

## Logs {#logging}

All data collection defaults to appending a global tag named `host` (tag value is the hostname where DataKit resides). Additional tags can be specified in the configuration via `[inputs.logging.tags]`:

``` toml
 [inputs.logging.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `logging collect`

Use the `source` of the config, if empty then use `default`

- Tags


| Tag | Description |
|  ----  | --------|
|`filename`|The base name of the file.|
|`host`|Host name|
|`service`|Uses the `service` of the config.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`__namespace`|Built-in extension fields added by server. The unique identifier for a log document dataType.|string|-|
|`__truncated_count`|Built-in extension fields added by server. If the log is particularly large (usually exceeding 1M in size), the central system will split it and add three fields: `__truncated_id`, `__truncated_count`, and `__truncated_number` to define the splitting scenario. The __truncated_count field represents the total number of logs resulting from the split.|int|-|
|`__truncated_id`|Built-in extension fields added by server. If the log is particularly large (usually exceeding 1M in size), the central system will split it and add three fields: `__truncated_id`, `__truncated_count`, and `__truncated_number` to define the splitting scenario. The __truncated_id field represents the unique identifier for the split log.|string|-|
|`__truncated_number`|Built-in extension fields added by server. If the log is particularly large (usually exceeding 1M in size), the central system will split it and add three fields: `__truncated_id`, `__truncated_count`, and `__truncated_number` to define the splitting scenario. The __truncated_count field represents the current sequential identifier for the split logs.|int|-|
|``__docid``|Built-in extension fields added by server. The unique identifier for a log document, typically used for sorting and viewing details|string|-|
|`create_time`|Built-in extension fields added by server. The `create_time` field represents the time when the log is written to the storage engine.|int|ms|
|`date`|Built-in extension fields added by server. The `date` field is set to the time when the log is collected by the collector by default, but it can be overridden using a Pipeline.|int|ms|
|`date_ns`|Built-in extension fields added by server. The `date_ns` field is set to the millisecond part of the time when the log is collected by the collector by default. Its maximum value is 1.0E+6 and its unit is nanoseconds. It is typically used for sorting.|int|ns|
|`df_metering_size`|Built-in extension fields added by server. The `df_metering_size` field is used for logging cost statistics.|int|-|
|`log_read_lines`|The lines of the read file.|int|count|
|`message`|The text of the logging.|string|-|
|`status`|The status of the logging, default is `unknown`[^1].|string|-|



<!-- markdownlint-disable MD053 -->
[^1]: Early Pipeline implementations could only extract fields, and most statuses were extracted via Pipeline, hence it was categorized as a field. Semantically, it should belong to the tag category.
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD013 -->
## FAQ {#faq}

### :material-chat-question: Why can't I see log data on the page? {#why-no-data}

After DataKit starts, logs in the `logfiles` configuration **will only be collected if new logs are generated; old log data will not be collected**.

Additionally, once a log file starts being collected, it will trigger a log automatically, content similar to:

``` not-set
First Message. filename: /some/path/to/new/log ...
```

Seeing this information indicates that the specified file "has started collection, but currently no new log data is being generated." Also, uploading, processing, and storing log data takes some time, so even if new data is generated, it needs to wait a certain amount of time (< 1min).

### :material-chat-question: Exclusivity Between Disk Log Collection and Socket Log Collection {#exclusion}

These two methods are mutually exclusive. When collecting logs via Socket, the `logfiles` field in the configuration should be set to empty: `logfiles=[]`

### :material-chat-question: Remote File Collection Scheme {#remote-ntfs}

On Linux, you can use the [NFS method](https://linuxize.com/post/how-to-mount-an-nfs-share-in-linux/){:target="_blank"} to mount the log directory from the remote host to the DataKit host, and configure the logging collector with the corresponding log path.

### :material-chat-question: MacOS Log Collector Error `operation not permitted` {#mac-no-permission}

On MacOS, due to system security policies, the DataKit log collector might fail to open files, reporting an `operation not permitted` error. Refer to the [Apple Developer Documentation](https://developer.apple.com/documentation/security/disabling_and_enabling_system_integrity_protection){:target="_blank"} for solutions.

### :material-chat-question: How to Estimate Total Log Volume {#log-size}

Since log charges are based on the number of logs, but generally, most logs are written to disk, you can only see the disk usage size (e.g., 100GB of logs per day).

One feasible way to estimate this is using a simple shell command:

```shell
# Count lines in 1GB of logs
head -c 1g path/to/your/log.txt | wc -l
```

Sometimes, estimating traffic consumption due to log collection is needed:

```shell
# Compressed size (bytes) of 1GB of logs
head -c 1g path/to/your/log.txt | gzip | wc -c
```

Here, you get the compressed byte count. According to the network bit calculation method (x8), the bandwidth consumption can be calculated as follows, giving an approximate bandwidth usage:

``` not-set
bytes * 2 * 8 /1024/1024 = xxx MBit
```

However, DataKit's compression rate won't be this high because it doesn't send 1GB of data at once but in multiple batches, with a compression rate of about 85% (i.e., 100MB compresses to 15MB). Therefore, an approximate calculation method is:

``` not-set
1GB * 2 * 8 * 0.15/1024/1024 = xxx MBit
```

<!-- markdownlint-disable MD046 -->
??? info

    The `*2` factor considers data expansion caused by [Pipeline parsing](../pipeline/use-pipeline/index.md). Generally, parsed data retains the original data, so the worst-case scenario doubles the data volume.
<!-- markdownlint-enable -->

## Further Reading {#more-reading}

- [DataKit Log Collection Overview](datakit-logging.md)
- [Pipeline: Text Data Processing](../pipeline/use-pipeline/index.md)
- [Pipeline Debugging](../developers/datakit-pl-how-to.md)
- [Pipeline Performance Testing and Comparison](logging-pipeline-bench.md)
- [Collecting Container Internal Logs via Sidecar(logfwd)](logfwd.md)
- [Correctly Using Regular Expressions for Configuration](../datakit/datakit-input-conf.md#debug-regex)