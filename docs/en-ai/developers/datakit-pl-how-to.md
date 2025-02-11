# How to Write Pipeline Scripts
---

Writing Pipeline scripts can be complicated. For this reason, Datakit includes a simple debugging tool that assists in writing Pipeline scripts.

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
    "msg"    : "post cost 6.87021ms", # Pure log content
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

### Grok Pattern Matching {#grokq}

Due to the numerous Grok patterns, manual matching can be cumbersome. Datakit provides an interactive command-line tool `grokq` (Grok query):

```Shell
datakit tool --grokq
grokq > Mon Jan 25 19:41:17 CST 2021   # Enter the text you want to match here
        2 %{DATESTAMP_OTHER: ?}        # The tool will provide corresponding suggestions; higher-weighted matches are more accurate. The number at the front indicates the weight.
        0 %{GREEDYDATA: ?}

grokq > 2021-01-25T18:37:22.016+0800
        4 %{TIMESTAMP_ISO8601: ?}      # Here, ? means you need to name the matched text with a field
        0 %{NOTSPACE: ?}
        0 %{PROG: ?}
        0 %{SYSLOGPROG: ?}
        0 %{GREEDYDATA: ?}             # Patterns like GREEDYDATA have lower weights due to their broad scope
                                       # Higher weights mean more precise matches

grokq > Q                              # Use Q or exit to quit
Bye!
```

<!-- markdownlint-disable MD046 -->
???+ warning

    On Windows, please execute the debugging in Powershell.
<!-- markdownlint-enable -->

### Handling Multi-line Logs {#multiline}

When processing call stack-related logs, since the number of lines is not fixed, directly using the `GREEDYDATA` pattern cannot handle logs like the following:

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

Here, you can use the `GREEDYLINES` rule for matching, as shown in (*usr/local/datakit/pipeline/test.p*):

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

You will get the following parsed result:

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

### Naming Considerations for Pipeline Fields {#naming}

All fields extracted by Pipeline are metrics (fields) rather than tags. Due to [line protocol constraints](../datakit/apis.md#lineproto-limitation), we should not extract any fields that share names with tags. These tags include the following categories:

- [Global Tags in Datakit](../datakit/datakit-conf.md#set-global-tag)
- [Custom Tags in log collectors](../integrations/logging.md#measurements)

Additionally, all collected logs contain multiple reserved fields. **We should not overwrite these fields**, as doing so may cause data to display incorrectly on the Explorer page.

| Field Name | Type          | Description                                  |
| ---        | ----          | ----                                        |
| `source`   | string(tag)   | Log source                                  |
| `service`  | string(tag)   | Service associated with the log, defaulting to `service` |
| `status`   | string(tag)   | [Log level](../integrations/logging.md#status) |
| `message`  | string(field) | Original log                                |
| `time`     | int           | Timestamp associated with the log           |

<!-- markdownlint-disable MD046 -->
???+ tip

    We can override the values of these tags using [specific Pipeline functions](pipeline.md#fn-set-tag).
<!-- markdownlint-enable -->

If any field extracted by Pipeline has the same name as an existing tag (case-sensitive), it will result in the following error. Therefore, it's recommended to avoid naming conflicts in Pipeline extraction.

```shell
# This error can be seen in Datakit monitor
same key xxx in tag and field
```

### Complete Pipeline Example {#example}

Let's take Datakit's own log parsing as an example. The format of Datakit's logs is as follows:

``` log
2021-01-11T17:43:51.887+0800  DEBUG io  io/io.go:458  post cost 6.87021ms
```

Corresponding Pipeline script:

```python
# pipeline for datakit log
# Mon Jan 11 10:42:41 CST 2021
# auth: tanb

grok(_, '%{_dklog_date:log_time}%{SPACE}%{_dklog_level:level}%{SPACE}%{_dklog_mod:module}%{SPACE}%{_dklog_source_file:code}%{SPACE}%{_dklog_msg:msg}')
rename("time", log_time) # Rename log_time to time
default_time(time)       # Set the time field as the timestamp for output data
drop_origin_data()       # Discard the original log text (not recommended)
```

This references several user-defined patterns such as `_dklog_date`, `_dklog_level`. Place these rules under *<Datakit installation directory>/pipeline/pattern*.

<!-- markdownlint-disable MD046 -->
???+ warning

    User-defined patterns that need to be globally effective (i.e., used in other Pipeline scripts) must be placed in the *[Datakit installation directory]/pipeline/pattern/* directory:

    ```Shell
    $ cat pipeline/pattern/datakit
    # Note: It's best to prefix custom pattern names to avoid conflicts with built-in names (built-in pattern names cannot be overridden)
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

Now that both the Pipeline and its referenced patterns are ready, you can use Datakit's built-in Pipeline debugging tool to parse this line of log:

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

Consider the following Pipeline script:

```py linenums="1"
json(_, message, "message")
json(_, thread_name, "thread")
json(_, level, "status")
json(_, @timestamp, "time")
```

It produces the following error:

``` not-set
[E] new piepline failed: 4:8 parse error: unexpected character: '@'
```

This is because the variable name (`@timestamp`) contains special characters. In such cases, we need to escape this variable:

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

This occurs because the Pipeline script being debugged is placed in the wrong location. The Pipeline script used for debugging needs to be placed in the *[Datakit installation directory]/pipeline/* directory.

<!-- markdownlint-disable MD013 -->
### :material-chat-question: How to Parse Multiple Different Formats of Logs in One Pipeline? {#if-else}
<!-- markdownlint-enable -->

In daily logs, different business operations can lead to various log formats. To improve Grok's performance, **match the most frequent Grok patterns first**. This way, most logs will likely match within the first few Groks, avoiding unnecessary matches.

<!-- markdownlint-disable MD046 -->
???+ tip

    Grok matching is the most resource-intensive part of log parsing, so avoiding redundant Grok matches can significantly enhance performance.

    ```python
    grok(_, "%{NOTSPACE:client_ip} %{NOTSPACE:http_ident} ...")
    if client_ip != nil {
        # If the above Grok matches, proceed with further processing based on this log
        ...
    } else {
        # If the above Grok does not match, try another Grok pattern
        grok(_, "%{date2:time} \\[%{LOGLEVEL:status}\\] %{GREEDYDATA:msg} ...")

        if status != nil {
            # Check if the second Grok matches
        } else {
            # Handle unidentified logs or add another Grok pattern for further matching
        }
    }
    ```
<!-- markdownlint-enable -->

### :material-chat-question: How to Drop Specific Fields During Parsing? {#drop-keys}

Sometimes, we only need a few specific fields from the middle of a log but cannot skip over preceding parts, for example:

``` not-set
200 356 1 0 44 30032 other messages
```

Here, we only need the value `44`, which might represent response latency. You can parse it as follows (by omitting `:some_field` in Grok):

```python
grok(_, "%{INT} %{INT} %{INT} %{INT:response_time} %{GREEDYDATA}")
```

### :material-chat-question: Escaping Issues with `add_pattern()` {#escape}

When using `add_pattern()` to add local patterns, escaping issues can arise. For instance, consider this pattern (for matching file paths and filenames):

``` not-set
(/?[\w_%!$@:.,-]?/?)(\S+)?
```

If you place it in the global pattern directory (i.e., *pipeline/pattern* directory), you can write it as:

``` not-set
# my-test
source_file (/?[\w_%!$@:.,-]?/?)(\S+)?
```

If using `add_pattern()`, it should be written as:

``` python
# my-test.p
add_pattern('source_file', '(/?[\\w_%!$@:.,-]?/?)(\\S+)?')
```

That is, backslashes need to be escaped.