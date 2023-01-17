
# How to Write Pipeline Scripts
---

Pipeline writing is more troublesome, so DataKit has built-in simple debugging tools to help you write Pipeline scripts.

## Debug Grok and Pipeline {#debug}

Specify the pipeline script name and enter a piece of text to determine whether the extraction is successful or not.

> Pipeline scripts must be placed in the *<DataKit 安装目录>/pipeline* directory.

```shell
$ datakit pipeline your_pipeline.p -T '2021-01-11T17:43:51.887+0800  DEBUG io  io/io.go:458  post cost 6.87021ms'
Extracted data(cost: 421.705µs): # Indicate successful cutting
{
	"code"   : "io/io.go: 458",       # Corresponding code position
	"level"  : "DEBUG",               # Corresponding log level
	"module" : "io",                  # Corresponding code module
	"msg"    : "post cost 6.87021ms", # Pure log attributes
	"time"   : 1610358231887000000    # Log time (Unix nanosecond timestamp)
	"message": "2021-01-11T17:43:51.887+0800  DEBUG io  io/io.g o:458  post cost 6.87021ms"
}
```

Extraction failure example (only `message` is left, indicating that other fields have not been extracted):

```shell
$ datakit pipeline other_pipeline.p -T '2021-01-11T17:43:51.887+0800  DEBUG io  io/io.g o:458  post cost 6.87021ms'
{
	"message": "2021-01-11T17:43:51.887+0800  DEBUG io  io/io.g o:458  post cost 6.87021ms"
}
```

> If the debug text is complex, you can write it to a file (sample.log) and debug it as follows:

```shell
$ datakit pipeline your_pipeline.p -F sample.log
```

For more Pipeline debugging commands, see `datakit help pipeline`.

### Grok Wildcard Search {#grokq}

Because of the large number of Grok patterns, manual matching is troublesome. DataKit provides an interactive command-line tool `grokq`（grok query）：

```Shell
datakit tool --grokq
grokq > Mon Jan 25 19:41:17 CST 2021   # Enter the text you want to match here
        2 %{DATESTAMP_OTHER: ?}        # The tool will give corresponding suggestions, and the more accurate the matching month is (the greater the weight is). The previous figures indicate the weights.
        0 %{GREEDYDATA: ?}

grokq > 2021-01-25T18:37:22.016+0800
        4 %{TIMESTAMP_ISO8601: ?}      # Here ? indicates that you need to name the matching text with a field
        0 %{NOTSPACE: ?}
        0 %{PROG: ?}
        0 %{SYSLOGPROG: ?}
        0 %{GREEDYDATA: ?}             # A wide range of patterns like GREEDYDATA have low weights
                                       # The higher the weight, the greater the matching accuracy

grokq > Q                              # Q or exit to quit
Bye!
```

???+ info

    Under Windows, debug in Powershell.

### How to Deal with Multiple Lines {#multiline}

When dealing with some call stack related logs, because the number of log rows is not fixed, the logs of the following situations cannot be handled directly with the pattern `GREEDYDATA`:

```
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

Here you can use the `GREEDYLINES` rule for generalization, such as (*/usr/local/datakit/pipeline/test.p*):

```python
add_pattern('_dklog_date', '%{YEAR}-%{MONTHNUM}-%{MONTHDAY} %{HOUR}:%{MINUTE}:%{SECOND}%{INT}')
grok(_, '%{_dklog_date:log_time}\\s+%{LOGLEVEL:Level}\\s+%{NUMBER:Level_value}\\s+---\\s+\\[%{NOTSPACE:thread_name}\\]\\s+%{GREEDYDATA:Logger_name}\\s+(\\n)?(%{GREEDYLINES:stack_trace})'

# Remove the message field here for easy debugging
drop_origin_data()
```

Save the above multi-line log as *multi-line.log* and debug it:

```shell
$ datakit --pl test.p --txt "$(<multi-line.log)"
```

The following cutting results are obtained:

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

In all the fields cut out by Pipeline, they are a field rather than a tag. Because of the [line protocol constraint](../datakit/apis.md#lineproto-limitation), we should not cut out any fields with the same name as tag. These tags include the following categories:

- [Global Tag](../datakit/datakit-conf.md#set-global-tag) in DataKit
- [Custom Tag](../datakit/logging.md#measurements) in the log collector

In addition, all collected logs have the following reserved fields. ==We should not override these fields==, otherwise the data may not appear properly on the viewer page.

| Field Name    | Type          | Description                                  |
| ---       | ----          | ----                                  |
| `source`  | string(tag)   | log source                              |
| `service` | string(tag)   | The service corresponding to the log is the same as `service` by default |
| `status`  | string(tag)   | The [level](../datakit/logging.md#status) corresponding to the log  |
| `message` | string(field) | Original log                              |
| `time`    | int           | Timestamp corresponding to log                      |


???+ tip

    Of course, we can override the values of these tags by [specific Pipeline function](pipeline.md#fn-set-tag).

Once the Pipeline cut-out field has the same name as the existing Tag (case sensitive), it will cause the following data error. Therefore, it is recommended to bypass these field naming in Pipeline cutting.

```shell
# This error is visible in the DataKit monitor
same key xxx in tag and field
```

### Complete Pipeline Sample {#example}

Take DataKit's own log cutting as an example. DataKit's own log form is as follows:

```
2021-01-11T17:43:51.887+0800  DEBUG io  io/io.go:458  post cost 6.87021ms
```

Write corresponding pipeline:

```python
# pipeline for datakit log
# Mon Jan 11 10:42:41 CST 2021
# auth: tanb

grok(_, '%{_dklog_date:log_time}%{SPACE}%{_dklog_level:level}%{SPACE}%{_dklog_mod:module}%{SPACE}%{_dklog_source_file:code}%{SPACE}%{_dklog_msg:msg}')
rename("time", log_time) # Name log_time duplicate name as time
default_time(time)       # Use the time field as the timestamp of the output data
drop_origin_data()       # Discard the original log text (not recommended)
```

Several user-defined patterns are referenced here, such as `_dklog_date`, `_dklog_level`. We store these rules under `<datakit安装目录>/pipeline/pattern`.

> Note that a user-defined pattern must be placed in the `<DataKit安装目录/pipeline/pattern/>` directory if it needs to be ==globally effective== (that is, to be applied in other pipeline scripts):

```Shell
$ cat pipeline/pattern/datakit
# Note: For these custom patterns, it is best to name them with specific prefixes to avoid conflicts with built-in naming (built-in pattern names are not allowed to be overwritten)
# The custom pattern format is:
#    <pattern-name><space><specific pattern combination>
_dklog_date %{YEAR}-%{MONTHNUM}-%{MONTHDAY}T%{HOUR}:%{MINUTE}:%{SECOND}%{INT}
_dklog_level (DEBUG|INFO|WARN|ERROR|FATAL)
_dklog_mod %{WORD}
_dklog_source_file (/?[\w_%!$@:.,-]?/?)(\S+)?
_dklog_msg %{GREEDYDATA}
```

Now that you have the pipeline and its referenced pattern, you can cut this line of logs through DataKit's built-in pipeline debugging tool:

```Shell
# Extract successful examples
$ ./datakit --pl dklog_pl.p --txt '2021-01-11T17:43:51.887+0800  DEBUG io  io/io.go:458  post cost 6.87021ms'
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

### Why can't variables be referenced when Pipeline is debugging? {#ref-variables}

Pipeline is:

```python
json(_, message, "message")
json(_, thread_name, "thread")
json(_, level, "status")
json(_, @timestamp, "time")
```

The error reported is as follows:

```
[E] new piepline failed: 4:8 parse error: unexpected character: '@'
```

---

A: For variables with special characters, you need to decorate them with two `` ` ``:

```python
json(_, `@timestamp`, "time")
```

See [Basic Syntax Rules for Pipeline](pipeline.md#basic-syntax).

### When debugging Pipeline, why can't you find the corresponding Pipeline script? {#pl404}

The order is as follows:

```shell
$ datakit pipeline test.p -T "..."
[E] get pipeline failed: stat /usr/local/datakit/pipeline/test.p: no such file or directory
```

---

A: Pipeline script for debugging. Place it in the *<DataKit 安装目录>/pipeline* directory.

### How to cut multiple logs in different formats in a single Pipeline? {#if-else}

In daily logs, logs will take on various forms because of different services. At this time, multiple Grok cuts need to be written. In order to improve the running efficiency of Grok, yoou ==can give priority to matching the Grok with higher frequency according to the frequency of logs==, so that high probability logs can be matched in the previous Groks, thus avoiding invalid matching.

> Grok matching is the most expensive part in log cutting, so avoiding repeated Grok matching can greatly improve the cutting performance of Grok.

```python
grok(_, "%{NOTSPACE:client_ip} %{NOTSPACE:http_ident} ...")
if client_ip != nil {
	# Prove that the above grok has matched at this time, then continue the subsequent processing according to the log.
	...
} else {
	# It is stated here that there is a different log, and the above grok does not match the current log.
	grok(_, "%{date2:time} \\[%{LOGLEVEL:status}\\] %{GREEDYDATA:msg} ...")

	if status != nil {
		# Here you can check whether the grok above matches...
	} else {
		# Unrecognized logs or a grok can be added here to process them, so as to process step by step.
	}
}
```

### How to Discard Field Cut {#drop-keys}

In some cases, all we need is ==a few fields in the middle of log ==, but it is difficult to skip the previous parts, such as

```
200 356 1 0 44 30032 other messages
```

Where we only need the value `44`, which may be code response latency, we can cut it like this (that is, the `:some_field` section is not included in Grok):

```python
grok(_, "%{INT} %{INT} %{INT} %{INT:response_time} %{GREEDYDATA}")
```

### `add_pattern()` Escape Problems {#escape}

When you use `add_pattern()` to add local patterns, you are prone to escape problems, such as the following pattern (used to match file paths and file names):

```
(/?[\w_%!$@:.,-]?/?)(\S+)?
```

If we put it in the global pattern directory (that is, the *pipeline/pattern* directory), we can write this:

```
# my-test
source_file (/?[\w_%!$@:.,-]?/?)(\S+)?
```

If you use `add_pattern()`, you need to write this: 

```python
# my-test.p
add_pattern('source_file', '(/?[\\w_%!$@:.,-]?/?)(\\S+)?')
```

That is, the backslash needs to be escaped.
