# How to Write a Pipeline Script
---

Writing Pipeline scripts can be complex. To assist with this, Datakit includes a simple debugging tool that helps users write Pipeline scripts.

## Debugging Grok and Pipeline {#debug}

Specify the name of the Pipeline script and input a text snippet to determine if extraction is successful.

> The Pipeline script must be placed in the *[Datakit installation directory]/pipeline* directory.

```shell
$ datakit pipeline -P your_pipeline.p -T '2021-01-11T17:43:51.887+0800  DEBUG io  io/io.go:458  post cost 6.87021ms'
Extracted data(cost: 421.705µs): # Indicates successful parsing
{
    "code"   : "io/io.go: 458",       # Corresponding code location
    "level"  : "DEBUG",               # Corresponding log level
    "module" : "io",                  # Corresponding code module
    "msg"    : "post cost 6.87021ms", # Raw log content
    "time"   : 1610358231887000000    # Log time (Unix nanosecond timestamp)
    "message": "2021-01-11T17:43:51.887+0800  DEBUG io  io/io.g o:458  post cost 6.87021ms"
}
```

Example of failed extraction (only `message` remains, indicating other fields were not extracted):

```shell
$ datakit pipeline -P other_pipeline.p -T '2021-01-11T17:43:51.887+0800  DEBUG io  io/io.g o:458  post cost 6.87021ms'
{
    "message": "2021-01-11T17:43:51.887+0800  DEBUG io  io/io.g o:458  post cost 6.87021ms"
}
```

> If the debug text is complex, you can write it into a file (sample.log) and use the following method for debugging:

```shell
datakit pipeline -P your_pipeline.p -F sample.log
```

For more Pipeline debugging commands, see `datakit help pipeline`.

### Grok Wildcard Search {#grokq}

Given the numerous Grok patterns, manual matching can be cumbersome. Datakit provides an interactive command-line tool `grokq` (Grok query):

```Shell
datakit tool --grokq
grokq > Mon Jan 25 19:41:17 CST 2021   # Enter the text you want to match here
        2 %{DATESTAMP_OTHER: ?}        # The tool suggests corresponding matches; higher-ranked matches are more precise (higher weight). The number before indicates the weight.
        0 %{GREEDYDATA: ?}

grokq > 2021-01-25T18:37:22.016+0800
        4 %{TIMESTAMP_ISO8601: ?}      # The ? indicates you need to name the matched text with a field
        0 %{NOTSPACE: ?}
        0 %{PROG: ?}
        0 %{SYSLOGPROG: ?}
        0 %{GREEDYDATA: ?}             # Patterns like GREEDYDATA have a wide range and lower weight
                                       # Higher weights mean better precision

grokq > Q                              # Use Q or exit to quit
Bye!
```

<!-- markdownlint-disable MD046 -->
???+ warning

    On Windows, execute the debugging in PowerShell.
<!-- markdownlint-enable -->

### Handling Multi-line Logs {#multiline}

When dealing with call stack-related logs, which have varying line counts, directly using the `GREEDYDATA` pattern cannot handle logs like the following:

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

Here, you can use the `GREEDYLINES` rule for wildcard matching, as shown in (*usr/local/datakit/pipeline/test.p*):

```python
add_pattern('_dklog_date', '%{YEAR}-%{MONTHNUM}-%{MONTHDAY} %{HOUR}:%{MINUTE}:%{SECOND}%{INT}')
grok(_, '%{_dklog_date:log_time}\\s+%{LOGLEVEL:Level}\\s+%{NUMBER:Level_value}\\s+---\\s+\\[%{NOTSPACE:thread_name}\\]\\s+%{GREEDYDATA:Logger_name}\\s+(\\n)?(%{GREEDYLINES:stack_trace})'

# Remove the message field for easier debugging
drop_origin_data()
```

Save the above multi-line log as *multi-line.log* and debug it:

```shell
datakit pipeline -P test.p -T "$(<multi-line.log)"
```

The parsed result is as follows:

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

### Pipeline Field Naming Considerations {#naming}

All fields extracted by the Pipeline are metrics (fields), not tags. Due to [line protocol constraints](../datakit/apis.md#lineproto-limitation), we should not extract any fields with the same names as tags. These tags include the following categories:

- [Global Tags in Datakit](../datakit/datakit-conf.md#set-global-tag)
- [Custom Tags in the log collector](../integrations/logging.md#measurements)

Additionally, all collected logs contain multiple reserved fields. **We should not overwrite these fields**, as doing so may cause data to display incorrectly on the Explorer page.

| Field Name | Type          | Description                                  |
| ---        | ----          | ----                                        |
| `source`   | string(tag)   | Log source                                  |
| `service`  | string(tag)   | Service corresponding to the log, defaults to `service` |
| `status`   | string(tag)   | [Log level](../integrations/logging.md#status) |
| `message`  | string(field) | Original log                                |
| `time`     | int           | Log timestamp                               |

<!-- markdownlint-disable MD046 -->
???+ tip

    We can override the values of these tags using [specific Pipeline functions](pipeline.md#fn-set-tag).
<!-- markdownlint-enable -->

If any fields extracted by the Pipeline have the same name as existing tags (case-sensitive), it will result in the following error. Therefore, it's recommended to avoid naming conflicts in the Pipeline.

```shell
# This error can be seen in Datakit monitor
same key xxx in tag and field
```

### Complete Pipeline Example {#example}

Here’s an example of parsing Datakit's own logs. The format of Datakit logs is as follows:

``` log
2021-01-11T17:43:51.887+0800  DEBUG io  io/io.go:458  post cost 6.87021ms
```

Corresponding Pipeline:

```python
# Pipeline for Datakit logs
# Mon Jan 11 10:42:41 CST 2021
# auth: tanb

grok(_, '%{_dklog_date:log_time}%{SPACE}%{_dklog_level:level}%{SPACE}%{_dklog_mod:module}%{SPACE}%{_dklog_source_file:code}%{SPACE}%{_dklog_msg:msg}')
rename("time", log_time) # Rename log_time to time
default_time(time)       # Set the time field as the output data timestamp
drop_origin_data()       # Discard original log text (not recommended)
```

This references several user-defined patterns, such as `_dklog_date`, `_dklog_level`. Place these rules in *<Datakit installation directory>/pipeline/pattern*.

<!-- markdownlint-disable MD046 -->
???+ warning

    User-defined patterns that need to take effect globally (i.e., used in other Pipeline scripts) must be placed in *[Datakit installation directory]/pipeline/pattern/*:

    ```Shell
    $ cat pipeline/pattern/datakit
    # Note: It's best to prefix custom pattern names to avoid conflicts with built-in names
    # Built-in pattern names cannot be overridden
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

Now that both the Pipeline and its referenced patterns are set up, you can use Datakit's built-in Pipeline debugging tool to parse this log line:

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

It results in the following error:

``` not-set
[E] new piepline failed: 4:8 parse error: unexpected character: '@'
```

This is because the variable name (`@timestamp`) contains special characters. In such cases, you need to escape this variable:

```python
json(_, `@timestamp`, "time")
```

Refer to [Basic Syntax Rules for Pipeline](pipeline.md#basic-syntax)

<!-- markdownlint-disable MD013 -->
### :material-chat-question: Why Can't the Corresponding Pipeline Script Be Found During Pipeline Debugging? {#pl404}
<!-- markdownlint-enable -->

Command:

```shell
$ datakit pipeline -P test.p -T "..."
[E] get pipeline failed: stat /usr/local/datakit/pipeline/test.p: no such file or directory
```

This is because the Pipeline being debugged is located in the wrong place. Debugging Pipeline scripts must be placed in the *[Datakit installation directory]/pipeline/* directory.

<!-- markdownlint-disable MD013 -->
### :material-chat-question: How to Parse Multiple Different Formats of Logs in One Pipeline? {#if-else}
<!-- markdownlint-enable -->

In daily logs, due to different business requirements, logs can take various forms. To improve Grok performance, **prioritize matching Groks based on their frequency**. This way, most logs will likely match within the first few Groks, avoiding unnecessary matches.

<!-- markdownlint-disable MD046 -->
???+ tip

    Grok matching is the most resource-intensive part of log parsing. Avoid redundant Grok matches to significantly enhance Grok performance.

    ```python
    grok(_, "%{NOTSPACE:client_ip} %{NOTSPACE:http_ident} ...")
    if client_ip != nil {
        # Confirms the Grok has matched; proceed with subsequent processing based on this log
        ...
    } else {
        # Indicates a different log type; try another Grok
        grok(_, "%{date2:time} \\[%{LOGLEVEL:status}\\] %{GREEDYDATA:msg} ...")

        if status != nil {
            # Check if the Grok matched
        } else {
            # Unrecognized log or add another Grok for further processing
        }
    }
    ```
<!-- markdownlint-enable -->

### :material-chat-question: How to Drop Fields During Parsing? {#drop-keys}

In some cases, we only need a few fields from the middle of a log but cannot skip the preceding parts, e.g.,

``` not-set
200 356 1 0 44 30032 other messages
```

Here, we only need `44`, which might represent response latency. You can parse it as follows (without attaching `:some_field` in Grok):

```python
grok(_, "%{INT} %{INT} %{INT} %{INT:response_time} %{GREEDYDATA}")
```

### :material-chat-question: Escaping Issues with `add_pattern()` {#escape}

When using `add_pattern()` to add local patterns, escaping issues can arise, e.g., for a pattern matching file paths and filenames:

``` not-set
(/?[\w_%!$@:.,-]?/?)(\S+)?
```

If placed in the global pattern directory (*pipeline/pattern*), it can be written as:

``` not-set
# my-test
source_file (/?[\w_%!$@:.,-]?/?)(\S+)?
```

If using `add_pattern()`, it needs to be written as:

``` python
# my-test.p
add_pattern('source_file', '(/?[\\w_%!$@:.,-]?/?)(\\S+)?')
```

That is, backslashes need to be escaped.