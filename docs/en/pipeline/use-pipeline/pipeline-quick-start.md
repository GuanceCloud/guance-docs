
# Quick Start
---


## The First Script {#first-script}

- Configure the Pipeline in DataKit and write the following Pipeline file, assuming it is named *nginx.p*. Store it in the *[DataKit Installation Directory]/pipeline* directory.

```python
# Assume the input is an Nginx log
# Note that comments can be added to the script

grok(_, "some-grok-patterns")  # Use grok to extract the input text
rename('client_ip', ip)        # Rename the ip field to client_ip
rename("网络协议", protocol)   # Rename the protocol field to "Network Protocol"

# Convert the timestamp (e.g., 1610967131) to RFC3339 date format: 2006-01-02T15:04:05Z07:00
datetime(access_time, "s", "RFC3339")

url_decode(request_url)      # Decode the HTTP request route into plain text

# When status_code is between 200 and 300, create a new field http_status = "HTTP_OK"
group_between(status_code, [200, 300], "HTTP_OK", "http_status")

# Discard the original content
drop_origin_data()
```

- Configure the corresponding collector to use the above Pipeline

Take the logging collector as an example; you just need to configure the `pipeline_path` field. Note that the configuration here is the name of the pipeline script, not the path. All pipeline scripts referenced here must be stored in the `<DataKit Installation Directory>/pipeline` directory:

```python
[[inputs.logging]]
    logfiles = ["/path/to/nginx/log"]

    # required
    source = "nginx"

    # All scripts must be placed in the /path/to/datakit/pipeline directory
    # If the gitrepos feature is enabled, it will prioritize the same-named files in gitrepos
    # If the pipeline is not configured, it will look for a script with the same name as the source in the pipeline directory (e.g., nginx -> nginx.p) as its default pipeline configuration
    pipeline = "nginx.p"

    ... # Other configurations
```

Restart the collector to parse the corresponding logs.

## Debugging Grok and Pipeline {#debug}

Writing Pipeline scripts can be quite troublesome, so DataKit has a built-in simple debugging tool to assist in writing Pipeline scripts.

Specify the Pipeline script name and input a piece of text to determine if the extraction is successful.

> Pipeline scripts must be placed in the *[DataKit Installation Directory]/pipeline* directory.

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

Example of failed extraction (only `message` is left, indicating that other fields were not extracted):

```shell
$ datakit pipeline -P other_pipeline.p -T '2021-01-11T17:43:51.887+0800  DEBUG io  io/io.g o:458  post cost 6.87021ms'
{
    "message": "2021-01-11T17:43:51.887+0800  DEBUG io  io/io.g o:458  post cost 6.87021ms"
}
```

> If the debugging text is complex, you can write them into a file (sample.log) and debug as follows:

```shell
datakit pipeline -P your_pipeline.p -F sample.log
```

For more Pipeline debugging commands, see `datakit help pipeline`.

### Grok Wildcard Search {#grokq}

Since there are many Grok patterns and manual matching can be troublesome, DataKit provides an interactive command-line tool `grokq` (grok query):

```Shell
datakit tool --grokq
grokq > Mon Jan 25 19:41:17 CST 2021   # Enter the text you want to match here
        2 %{DATESTAMP_OTHER: ?}        # The tool will suggest the corresponding matching patterns, the higher the number, the more precise the match (the weight is also greater). The number before indicates the weight.
        0 %{GREEDYDATA: ?}

grokq > 2021-01-25T18:37:22.016+0800
        4 %{TIMESTAMP_ISO8601: ?}      # The ? here indicates that you need to name the matched text with a field
        0 %{NOTSPACE: ?}
        0 %{PROG: ?}
        0 %{SYSLOGPROG: ?}
        0 %{GREEDYDATA: ?}             # Patterns with a broad range like GREEDYDATA have lower weights
                                       # The higher the weight, the more precise the match

grokq > Q                              # Q or exit to quit
Bye!
```

<!-- markdownlint-disable MD046 -->
???+ warning

    On Windows, execute the debug in PowerShell.
<!-- markdownlint-enable -->

### How to Handle Multi-line Logs {#multiline}

When processing logs related to call stacks, since the number of log lines is not fixed, it is not possible to directly use the `GREEDYDATA` pattern to handle logs in the following situations:


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


This section can use the `GREEDYLINES` rule for wildcard matching, such as (*/usr/local/datakit/pipeline/test.p*):

```python
# Add a pattern to match the log date
add_pattern('_dklog_date', '%{YEAR}-%{MONTHNUM}-%{MONTHDAY} %{HOUR}:%{MINUTE}:%{SECOND}%{INT}')
# Use the Grok pattern to match the log format
grok(_, '%{_dklog_date:log_time}\\s+%{LOGLEVEL:Level}\\s+%{NUMBER:Level_value}\\s+---\\s+\\[%{NOTSPACE:thread_name}\\]\\s+%{GREEDYDATA:Logger_name}\\s+(\\n)?(%{GREEDYLINES:stack_trace})')

# Remove the message field here for easier debugging
drop_origin_data()
```

Save the above multi-line log as *multi-line.log* and debug it:

```shell
# Use the datakit tool to test log parsing
datakit pipeline -P test.p -T "$(<multi-line.log)"
```

Save the above multi-line log as multi-line.log and debug it:


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

In all fields extracted by the Pipeline, they are metrics (fields) rather than tags (tags). Due to the [line protocol constraints](../../datakit/apis.md#point-limitation), we should not extract any fields that have the same name as tags. These tags include the following categories:

- [Global Tags](../../datakit/datakit-conf.md#set-global-tag) in Datakit
- [Custom Tags](../../integrations/logging.md#measurements) in the log collector

In addition, all collected logs have the following reserved fields. **We should not overwrite these fields**, otherwise, it may cause the data to display abnormally on the viewer page.

| Field Name | Type          | Description                                                  |
| ---        | ----          | ----                                                         |
| `source`   | string(tag)   | Source of the log                                            |
| `service`  | string(tag)   | The service corresponding to the log, defaults to the same as `source` |
| `status`   | string(tag)   | The [level](../../integrations/logging.md#status) corresponding to the log |
| `message`  | string(field) | Original log                                                 |
| `time`     | int           | The timestamp corresponding to the log                       |

<!-- markdownlint-disable MD046 -->
???+ abstract

   Of course, we can override the values of these tags through [specific Pipeline functions](pipeline-built-in-function.md#fn-set-tag).
<!-- markdownlint-enable -->

### Complete Pipeline Example {#example}

Here, the log parsing of Datakit itself is taken as an example. The log format of Datakit itself is as follows:

``` log
2021-01-11T17:43:51.887+0800  DEBUG io  io/io.go:458  post cost 6.87021ms
```

Write the corresponding Pipeline:

```python
# pipeline for datakit log
# Mon Jan 11 10:42:41 CST 2021
# auth: tanb

grok(_, '%{_dklog_date:log_time}%{SPACE}%{_dklog_level:level}%{SPACE}%{_dklog_mod:module}%{SPACE}%{_dklog_source_file:code}%{SPACE}%{_dklog_msg:msg}')
rename("time", log_time) # Rename log_time to time
default_time(time)       # Use the time field as the timestamp for the output data
drop_origin_data()       # Discard the original log text (not recommended)
```

Here, several user-defined patterns are referenced, such as `_dklog_date`, `_dklog_level`. We store these rules in the *<Datakit installation directory>/pipeline/pattern* directory.

<!-- markdownlint-disable MD046 -->
???+ warning

    If user-defined patterns need to take effect globally (i.e., applied in other Pipeline scripts), they must be placed in the *[Datakit installation directory]/pipeline/pattern/>* directory:

    ```Shell
    $ cat pipeline/pattern/datakit
    # Note: It is best to add a specific prefix to these custom patterns to avoid conflicts with built-in names
    # (The names of built-in patterns cannot be overwritten)
    #
    # The format of custom patterns is:
    #    <pattern-name> <specific pattern combination>
    #
    _dklog_date %{YEAR}-%{MONTHNUM}-%{MONTHDAY}T%{HOUR}:%{MINUTE}:%{SECOND}%{INT}
    _dklog_level (DEBUG|INFO|WARN|ERROR|FATAL)
    _dklog_mod %{WORD}
    _dklog_source_file (/?[\w_%!$@:.,-]?/?)(\S+)?
    _dklog_msg %{GREEDYDATA}
    ```
<!-- markdownlint-enable -->

Now that the Pipeline and its referenced patterns are in place, you can use Datakit's built-in Pipeline debugging tool to parse this line of log:

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

### :material-chat-question: Why can't variables be referenced during Pipeline debugging? {#ref-variables}

Here is an existing Pipeline:

```python
json(_, message, "message")
json(_, thread_name, "thread")
json(_, level, "status")
json(_, @timestamp, "time")
```

The error message is as follows:

```plaintext
[E] new pipeline failed: 4:8 parse error: unexpected character: '@'
```

This is because the variable name (here `@timestamp`) contains a special character. In this case, we need to use backticks to make it a legal identifier:

```python
json(_, `@timestamp`, "time")
```

See [Basic Syntax Rules of Pipeline](pipeline-platypus-grammar.md)

### :material-chat-question: Why can't the corresponding Pipeline script be found during debugging? {#pl404}

The command is as follows:

```shell
$ datakit pipeline -P test.p -T "..."
[E] get pipeline failed: stat /usr/local/datakit/pipeline/test.p: no such file or directory
```

This is because the location of the Pipeline being debugged is incorrect. The Pipeline script for debugging should be placed in the *[Datakit installation directory]/pipeline/* directory.

### :material-chat-question: How to parse multiple different log formats in a single Pipeline? {#if-else}

In daily logs, due to different business needs, logs come in various forms. At this time, multiple Grok parsings are needed. To improve the efficiency of Grok parsing, **prioritize matching the Grok that appears more frequently**, so that most of the logs are matched in the first few Grok, avoiding ineffective matching.

<!-- markdownlint-disable MD046 -->
???+ abstract

    In log parsing, Grok matching is the most performance-intensive part, so avoiding repeated Grok matching can greatly improve the performance of Grok parsing.

    ```python
    grok(_, "%{NOTSPACE:client_ip} %{NOTSPACE:http_ident} ...")
    if client_ip != nil {
        # This proves that the above grok has been matched, so continue the subsequent processing according to this log
        ...
    } else {
        # This indicates that a different log has arrived, and the above grok did not match the current log
        grok(_, "%{date2:time} \\[%{LOGLEVEL:status}\\] %{GREEDYDATA:msg} ...")
    
        if status != nil {
            # Here you can check if the above grok matched
        } else {
            # Unrecognized logs, or, you can add another grok here to handle, and so on
        }
    }
    ```
<!-- markdownlint-enable -->

### :material-chat-question: How to discard field parsing? {#drop-keys}

In some cases, we only need a few fields in the middle of the logs, but it's not easy to skip the previous parts, for example:

```plaintext
200 356 1 0 44 30032 other messages
```

Where we only need the value `44`, which may be the code response delay, then it can be parsed like this (i.e., without `:some_field` in Grok):

```python
grok(_, "%{INT} %{INT} %{INT} %{INT:response_time} %{GREEDYDATA}")
```

### :material-chat-question: Escaping issues with `add_pattern()` {#escape}

When using `add_pattern()` to add local patterns, it is easy to fall into the problem of escaping, such as the following pattern (used to match file paths and file names):

```plaintext
(/?[\w_%!$@:.,-]?/?)(\S+)?
```

If we put it in the global pattern directory (i.e., the *pipeline/pattern* directory), it can be written like this:

```plaintext
# my-test
source_file (/?[\w_%!$@:.,-]?/?)(\S+)?
```

If using `add_pattern()`, it needs to be written like this:

```python
# my-test.p
add_pattern('source_file', '(/?[\\w_%!$@:.,-]?/?)(\\S+)?')
```

That is, the backslash needs to be escaped.
