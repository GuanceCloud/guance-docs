# Quick Start
---

## First Script {#fist-script}

- Configure Pipeline in DataKit and write the following Pipeline file, assuming it is named *nginx.p*. Save it under the *[Datakit installation directory]/pipeline* directory.

```python
# Assume the input is an Nginx log
# Note: comments can be added to scripts

grok(_, "some-grok-patterns")  # Perform grok extraction on the input text
rename('client_ip', ip)        # Rename the ip field to client_ip
rename("网络协议", protocol)   # Rename the protocol field to "network_protocol"

# Convert timestamps (like 1610967131) to RFC3339 date format: 2006-01-02T15:04:05Z07:00
datetime(access_time, "s", "RFC3339")

url_decode(request_url)      # Decode HTTP request routes into plain text

# When status_code is between 200 ~ 300, create a new field http_status = "HTTP_OK"
group_between(status_code, [200, 300], "HTTP_OK", "http_status")

# Discard original content
drop_origin_data()
```

- Configure the corresponding collector to use the above Pipeline

Taking the logging collector as an example, configure the `pipeline_path` field. Note that here you configure the script name of the pipeline, not the path. All referenced pipeline scripts must be placed in the `<DataKit installation directory/pipeline>` directory:

```python
[[inputs.logging]]
    logfiles = ["/path/to/nginx/log"]

    # required
    source = "nginx"

    # All scripts must be placed in /path/to/datakit/pipeline directory
    # If the gitrepos feature is enabled, then the same-named files in gitrepos take precedence
    # If no pipeline is configured, it looks for a script with the same name as the source in the pipeline directory
    # (e.g., nginx -> nginx.p) as its default pipeline configuration
    pipeline = "nginx.p"

    ... # Other configurations
```

Restart the collector to process the corresponding logs.

## Debugging Grok and Pipeline {#debug}

Writing Pipelines can be complex, so DataKit includes a simple debugging tool to assist in writing Pipeline scripts.

Specify the Pipeline script name and input some text to determine if the extraction was successful.

> The Pipeline script must be placed in the *[Datakit installation directory]/pipeline* directory.

```shell
$ datakit pipeline -P your_pipeline.p -T '2021-01-11T17:43:51.887+0800  DEBUG io  io/io.go:458  post cost 6.87021ms'
Extracted data(cost: 421.705µs): # Indicates successful extraction
{
    "code"   : "io/io.go: 458",       # Corresponding code location
    "level"  : "DEBUG",               # Corresponding log level
    "module" : "io",                  # Corresponding code module
    "msg"    : "post cost 6.87021ms", # Pure log content
    "time"   : 1610358231887000000    # Log time (Unix nanosecond timestamp)
    "message": "2021-01-11T17:43:51.887+0800  DEBUG io  io/io.g o:458  post cost 6.87021ms"
}
```

Failed extraction example (only `message` remains, indicating other fields were not extracted):

```shell
$ datakit pipeline -P other_pipeline.p -T '2021-01-11T17:43:51.887+0800  DEBUG io  io/io.g o:458  post cost 6.87021ms'
{
    "message": "2021-01-11T17:43:51.887+0800  DEBUG io  io/io.g o:458  post cost 6.87021ms"
}
```

> If the debug text is complex, you can write it to a file (sample.log) and debug it using the following command:

```shell
datakit pipeline -P your_pipeline.p -F sample.log
```

For more Pipeline debugging commands, refer to `datakit help pipeline`.

### Grok Pattern Search {#grokq}

Since there are numerous Grok patterns, manual matching can be cumbersome. DataKit provides an interactive command-line tool `grokq` (Grok Query):

```Shell
datakit tool --grokq
grokq > Mon Jan 25 19:41:17 CST 2021   # Enter the text you wish to match here
        2 %{DATESTAMP_OTHER: ?}        # The tool suggests matches; higher numbers indicate more precise matches (higher weight).
        0 %{GREEDYDATA: ?}

grokq > 2021-01-25T18:37:22.016+0800
        4 %{TIMESTAMP_ISO8601: ?}      # Here, ? indicates you need to name the matched text with a field.
        0 %{NOTSPACE: ?}
        0 %{PROG: ?}
        0 %{SYSLOGPROG: ?}
        0 %{GREEDYDATA: ?}             # Patterns like GREEDYDATA have lower weights due to their broad range.
                                       # Higher weights mean better precision.

grokq > Q                              # Exit with Q or exit
Bye!
```

<!-- markdownlint-disable MD046 -->
???+ attention

    On Windows, run debugging in PowerShell.
<!-- markdownlint-enable -->

### Handling Multi-line Logs {#multiline}

When processing stack trace-related logs where the number of lines is not fixed, directly using the `GREEDYDATA` pattern cannot handle such cases. For example:

``` log
2022-02-10 16:27:36.116 ERROR 1629881 --- [scheduling-1] o.s.s.s.TaskUtils$LoggingErrorHandler    : Unexpected error occurred in scheduled task

    java.lang.NullPointerException: null
    at com.xxxxx.xxxxxxxxxxx.xxxxxxx.impl.SxxxUpSxxxxxxImpl.isSimilarPrize(xxxxxxxxxxxxxxxxx.java:442)
    at com.xxxxx.xxxxxxxxxxx.xxxxxxx.impl.SxxxUpSxxxxxxImpl.lambda$getSimilarPrizeSnapUpDo$0(xxxxxxxxxxxxxxxxx.java:595)
    at java.util.stream.ReferencePipeline$3$1.accept(xxxxxxxxxxxxxxxxx.java:193)
    at java.util.ArrayList$ArrayListSpliterator.forEachRemaining(xxxxxxxxx.java:1382)
    at java.util.stream.AbstractPipeline.copyInto(xxxxxxxxxxxxxxxx.java:481)
    at java.util.stream.AbstractPipeline.wrapAndCopyInto(xxxxxxxxxxxxxxxx.java:471)
    at java.util.stream.ReduceOps$ReduceOp.evaluateSequential(xxxxxxxxx.java:708)
    at java.util.stream.AbstractPipeline.evaluate(xxxxxxxxxxxxxxxx.java:234)
    at java.util.stream.ReferencePipeline.collect(xxxxxxxxxxxxxxxxx.java:499)
```

You can use the `GREEDYLINES` rule to match multiple lines, for example (*/usr/local/datakit/pipeline/test.p*):

```python
add_pattern('_dklog_date', '%{YEAR}-%{MONTHNUM}-%{MONTHDAY} %{HOUR}:%{MINUTE}:%{SECOND}%{INT}')
grok(_, '%{_dklog_date:log_time}\\s+%{LOGLEVEL:Level}\\s+%{NUMBER:Level_value}\\s+---\\s+\\[%{NOTSPACE:thread_name}\\]\\s+%{GREEDYDATA:Logger_name}\\s+(\\n)?(%{GREEDYLINES:stack_trace})')

# Remove the message field for easier debugging
drop_origin_data()
```

Save the multi-line log as *multi-line.log* and debug it:

```shell
datakit pipeline -P test.p -T "$(<multi-line.log)"
```

The result of the extraction is as follows:

```json
{
  "Level": "ERROR",
  "Level_value": "1629881",
  "Logger_name": "o.s.s.s.TaskUtils$LoggingErrorHandler    : Unexpected error occurred in scheduled task",
  "log_time": "2022-02-10 16:27:36.116",
  "stack_trace": "java.lang.NullPointerException: null\n\tat com.xxxxx.xxxxxxxxxxx.xxxxxxx.impl.SxxxUpSxxxxxxImpl.isSimilarPrize(xxxxxxxxxxxxxxxxx.java:442)\n\tat com.xxxxx.xxxxxxxxxxx.xxxxxxx.impl.SxxxUpSxxxxxxImpl.lambda$getSimilarPrizeSnapUpDo$0(xxxxxxxxxxxxxxxxx.java:595)\n\tat java.util.stream.ReferencePipeline$3$1.accept(xxxxxxxxxxxxxxxxx.java:193)\n\tat java.util.ArrayList$ArrayListSpliterator.forEachRemaining(xxxxxxxxx.java:1382)\n\tat java.util.stream.AbstractPipeline.copyInto(xxxxxxxxxxxxxxxx.java:481)\n\tat java.util.stream.AbstractPipeline.wrapAndCopyInto(xxxxxxxxxxxxxxxx.java:471)\n\tat java.util.stream.ReduceOps$ReduceOp.evaluateSequential(xxxxxxxxx.java:708)\n\tat java.util.stream.AbstractPipeline.evaluate(xxxxxxxxxxxxxxxx.java:234)\n\tat java.util.stream.ReferencePipeline.collect(xxxxxxxxxxxxxxxxx.java:499)",
  "thread_name": "scheduling-1"
}
```

### Pipeline Field Naming Guidelines {#naming}

All fields extracted by the Pipeline are fields (not tags). Due to [line protocol constraints](../../datakit/apis.md#point-limitation), we should not extract any fields with the same name as tags. These tags include:

- Global Tags in DataKit [(see global tag settings)](../../datakit/datakit-conf.md#set-global-tag)
- Custom Tags in the logging collector [(see measurements)](../../integrations/logging.md#measurements)

Additionally, all collected logs contain multiple reserved fields. **We should not overwrite these fields**, as this may cause issues when viewing the logs in the Explorer page.

| Field Name | Type          | Description                                                   |
| ---        | ----          | ----                                                          |
| `source`   | string(tag)   | Log source                                                    |
| `service`  | string(tag)   | Service corresponding to the log, defaults to the same as `source` |
| `status`   | string(tag)   | [Log level](../../integrations/logging.md#status)             |
| `message`  | string(field) | Original log                                                  |
| `time`     | int           | Log timestamp                                                 |

<!-- markdownlint-disable MD046 -->
???+ tip

    You can override the values of these tags using specific Pipeline functions [(see set tag function)](pipeline-built-in-function.md#fn-set-tag).
<!-- markdownlint-enable -->

### Complete Pipeline Example {#example}

Here’s an example of cutting DataKit's own logs. DataKit's log format is as follows:

``` log
2021-01-11T17:43:51.887+0800  DEBUG io  io/io.go:458  post cost 6.87021ms
```

Corresponding Pipeline:

```python
# pipeline for datakit log
# Mon Jan 11 10:42:41 CST 2021
# auth: tanb

grok(_, '%{_dklog_date:log_time}%{SPACE}%{_dklog_level:level}%{SPACE}%{_dklog_mod:module}%{SPACE}%{_dklog_source_file:code}%{SPACE}%{_dklog_msg:msg}')
rename("time", log_time) # Rename log_time to time
default_time(time)       # Use the time field as the output data timestamp
drop_origin_data()       # Discard the original log text (not recommended)
```

This references several user-defined patterns such as `_dklog_date`, `_dklog_level`. Place these rules in *<Datakit installation directory>/pipeline/pattern*.

<!-- markdownlint-disable MD046 -->
???+ attention

    If user-defined patterns need to be globally effective (i.e., used in other Pipeline scripts), they must be placed in the *[Datakit installation directory]/pipeline/pattern/* directory:

    ```Shell
    $ cat pipeline/pattern/datakit
    # Note: custom patterns should ideally have specific prefixes to avoid conflicts with built-in names
    # (built-in pattern names cannot be overridden)
    #
    # Custom pattern format:
    #    <pattern-name><space><specific pattern combination>
    #
    _dklog_date %{YEAR}-%{MONTHNUM}-%{MONTHDAY}T%{HOUR}:%{MINUTE}:%{SECOND}%{INT}
    _dklog_level (DEBUG|INFO|WARN|ERROR|FATAL)
    _dklog_mod %{WORD}
    _dklog_source_file (/?[\w_%!$@:.,-]?/?)(\S+)?
    _dklog_msg %{GREEDYDATA}
    ```
<!-- markdownlint-enable -->

Now that both the Pipeline and its referenced patterns are in place, you can use DataKit's built-in Pipeline debugging tool to parse this line of log:

```Shell
# Successful extraction example
datakit pipeline -P dklog_pl.p -T '2021-01-11T17:43:51.887+0800  DEBUG io  io/io.go:458  post cost 6.87021ms'

Extracted data(cost: 421.705µs):
{
    "code": "io/io.go:458",
    "level": "DEBUG",
    "module": "io",
    "msg": "post cost 6.87021ms",
    "time": 1610358231887000000
}
```

## FAQ {#faq}

<!-- markdownlint-disable MD013 -->
### :material-chat-question: Why Can't Variables Be Referenced During Pipeline Debugging? {#ref-variables}
<!-- markdownlint-enable -->

Consider the following Pipeline:

```py linenums="1"
json(_, message, "message")
json(_, thread_name, "thread")
json(_, level, "status")
json(_, @timestamp, "time")
```

Error message:

``` not-set
[E] new piepline failed: 4:8 parse error: unexpected character: '@'
```

This is because the variable name (`@timestamp`) contains special characters. In such cases, you need to escape them using backticks to make it a valid identifier:

```python
json(_, `@timestamp`, "time")
```

Refer to [Pipeline Basic Grammar Rules](pipeline-platypus-grammar.md)

<!-- markdownlint-disable MD013 -->
### :material-chat-question: Why Can't the Pipeline Script Be Found During Debugging? {#pl404}
<!-- markdownlint-enable -->

Command:

```shell
$ datakit pipeline -P test.p -T "..."
[E] get pipeline failed: stat /usr/local/datakit/pipeline/test.p: no such file or directory
```

This is because the Pipeline being debugged is placed in the wrong directory. The Pipeline script for debugging should be placed in the *[Datakit installation directory]/pipeline/* directory.

<!-- markdownlint-disable MD013 -->
### :material-chat-question: How to Parse Multiple Different Formats in One Pipeline? {#if-else}
<!-- markdownlint-enable -->

In daily logs, due to different business needs, logs can appear in various formats. To improve Grok performance, **match the most frequent Grok first**. This way, most logs will likely match within the first few Groks, avoiding unnecessary matches.

<!-- markdownlint-disable MD046 -->
???+ tip

    Grok matching is the most resource-intensive part of log parsing. Avoid redundant Grok matches to significantly enhance performance.

    ```python
    grok(_, "%{NOTSPACE:client_ip} %{NOTSPACE:http_ident} ...")
    if client_ip != nil {
        # This means the previous Grok has already matched, proceed with subsequent processing
        ...
    } else {
        # Different log format detected, previous Grok did not match
        grok(_, "%{date2:time} \\[%{LOGLEVEL:status}\\] %{GREEDYDATA:msg} ...")
    
        if status != nil {
            # Check if the current Grok matched
        } else {
            # Unrecognized log or add another Grok for further processing
        }
    }
    ```
<!-- markdownlint-enable -->

### :material-chat-question: How to Drop Fields During Parsing? {#drop-keys}

Sometimes, we only need a few fields from the middle of a log, but skipping the preceding parts is difficult, for example:

``` not-set
200 356 1 0 44 30032 other messages
```

Here, we only need `44`, which might represent response latency. You can parse it as follows (i.e., omitting `:some_field` in Grok):

```python
grok(_, "%{INT} %{INT} %{INT} %{INT:response_time} %{GREEDYDATA}")
```

### :material-chat-question: Escaping Issues with `add_pattern()` {#escape}

When using `add_pattern()` to add local patterns, escaping issues can occur, for example with this pattern (used to match file paths and filenames):

``` not-set
(/?[\w_%!$@:.,-]?/?)(\S+)?
```

If placed in the global pattern directory (i.e., *pipeline/pattern*), it can be written as:

``` not-set
# my-test
source_file (/?[\w_%!$@:.,-]?/?)(\S+)?
```

Using `add_pattern()`, it should be written as:

``` python
# my-test.p
add_pattern('source_file', '(/?[\\w_%!$@:.,-]?/?)(\\S+)?')
```

That is, backslashes need to be escaped.