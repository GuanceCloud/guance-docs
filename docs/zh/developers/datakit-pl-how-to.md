# 如何编写 Pipeline 脚本
---

Pipeline 编写较为麻烦，为此，Datakit 中内置了简单的调试工具，用以辅助大家来编写 Pipeline 脚本。

## 调试 Grok 和 Pipeline {#debug}

指定 Pipeline 脚本名称，输入一段文本即可判断提取是否成功

> Pipeline 脚本必须放在 *[Datakit 安装目录]/pipeline* 目录下。

```shell
$ datakit pipeline -P your_pipeline.p -T '2021-01-11T17:43:51.887+0800  DEBUG io  io/io.go:458  post cost 6.87021ms'
Extracted data(cost: 421.705µs): # 表示切割成功
{
    "code"   : "io/io.go: 458",       # 对应代码位置
    "level"  : "DEBUG",               # 对应日志等级
    "module" : "io",                  # 对应代码模块
    "msg"    : "post cost 6.87021ms", # 纯日志内容
    "time"   : 1610358231887000000    # 日志时间(Unix 纳秒时间戳)
    "message": "2021-01-11T17:43:51.887+0800  DEBUG io  io/io.g o:458  post cost 6.87021ms"
}
```

提取失败示例（只有 `message` 留下了，说明其它字段并未提取出来）：

```shell
$ datakit pipeline -P other_pipeline.p -T '2021-01-11T17:43:51.887+0800  DEBUG io  io/io.g o:458  post cost 6.87021ms'
{
    "message": "2021-01-11T17:43:51.887+0800  DEBUG io  io/io.g o:458  post cost 6.87021ms"
}
```

> 如果调试文本比较复杂，可以将它们写入一个文件（sample.log），用如下方式调试：

```shell
datakit pipeline -P your_pipeline.p -F sample.log
```

更多 Pipeline 调试命令，参见 `datakit help pipeline`。

### Grok 通配搜索 {#grokq}

由于 Grok pattern 数量繁多，人工匹配较为麻烦。Datakit 提供了交互式的命令行工具 `grokq`（grok query）：

```Shell
datakit tool --grokq
grokq > Mon Jan 25 19:41:17 CST 2021   # 此处输入你希望匹配的文本
        2 %{DATESTAMP_OTHER: ?}        # 工具会给出对应对的建议，越靠前匹配月精确（权重也越大）。前面的数字表明权重。
        0 %{GREEDYDATA: ?}

grokq > 2021-01-25T18:37:22.016+0800
        4 %{TIMESTAMP_ISO8601: ?}      # 此处的 ? 表示你需要用一个字段来命名匹配到的文本
        0 %{NOTSPACE: ?}
        0 %{PROG: ?}
        0 %{SYSLOGPROG: ?}
        0 %{GREEDYDATA: ?}             # 像 GREEDYDATA 这种范围很广的 pattern，权重都较低
                                       # 权重越高，匹配的精确度越大

grokq > Q                              # Q 或 exit 退出
Bye!
```

<!-- markdownlint-disable MD046 -->
???+ warning

    Windows 下，请在 Powershell 中执行调试。
<!-- markdownlint-enable -->

### 多行如何处理 {#multiline}

在处理一些调用栈相关的日志时，由于其日志行数不固定，直接用 `GREEDYDATA` 这个 pattern 无法处理如下情况的日志：

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

此处可以使用 `GREEDYLINES` 规则来通配，如（*/usr/local/datakit/pipeline/test.p*）：

```python
add_pattern('_dklog_date', '%{YEAR}-%{MONTHNUM}-%{MONTHDAY} %{HOUR}:%{MINUTE}:%{SECOND}%{INT}')
grok(_, '%{_dklog_date:log_time}\\s+%{LOGLEVEL:Level}\\s+%{NUMBER:Level_value}\\s+---\\s+\\[%{NOTSPACE:thread_name}\\]\\s+%{GREEDYDATA:Logger_name}\\s+(\\n)?(%{GREEDYLINES:stack_trace})'

# 此处移除 message 字段便于调试
drop_origin_data()
```

将上述多行日志存为 *multi-line.log*，调试一下：

```shell
datakit pipeline -P test.p -T "$(<multi-line.log)"
```

得到如下切割结果：

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

### Pipeline 字段命名注意事项 {#naming}

在所有 Pipeline 切割出来的字段中，它们都是指标（field）而不是标签（tag）。由于[行协议约束](../datakit/apis.md#lineproto-limitation)，我们不应该切割出任何跟 tag 同名的字段。这些 Tag 包含如下几类：

- Datakit 中的[全局 Tag](../datakit/datakit-conf.md#set-global-tag)
- 日志采集器中[自定义的 Tag](../integrations/logging.md#measurements)

另外，所有采集上来的日志，均存在如下多个保留字段。**我们不应该去覆盖这些字段**，否则可能导致数据在查看器页面显示不正常。

| 字段名    | 类型          | 说明                                  |
| ---       | ----          | ----                                  |
| `source`  | string(tag)   | 日志来源                              |
| `service` | string(tag)   | 日志对应的服务，默认跟 `service` 一样 |
| `status`  | string(tag)   | 日志对应的[等级](../integrations/logging.md#status)   |
| `message` | string(field) | 原始日志                              |
| `time`    | int           | 日志对应的时间戳                      |

<!-- markdownlint-disable MD046 -->
???+ tip

    当然我们可以通过[特定的 Pipeline 函数](pipeline.md#fn-set-tag)覆盖上面这些 tag 的值。
<!-- markdownlint-enable -->

一旦 Pipeline 切割出来的字段跟已有 Tag 重名（大小写敏感），都会导致如下数据报错。故建议在 Pipeline 切割中，绕开这些字段命名。

```shell
# 该错误在 Datakit monitor 中能看到
same key xxx in tag and field
```

### 完整 Pipeline 示例 {#example}

这里以 Datakit 自身的日志切割为例。Datakit 自身的日志形式如下：

``` log
2021-01-11T17:43:51.887+0800  DEBUG io  io/io.go:458  post cost 6.87021ms
```

编写对应 Pipeline：

```python
# pipeline for datakit log
# Mon Jan 11 10:42:41 CST 2021
# auth: tanb

grok(_, '%{_dklog_date:log_time}%{SPACE}%{_dklog_level:level}%{SPACE}%{_dklog_mod:module}%{SPACE}%{_dklog_source_file:code}%{SPACE}%{_dklog_msg:msg}')
rename("time", log_time) # 将 log_time 重名命名为 time
default_time(time)       # 将 time 字段作为输出数据的时间戳
drop_origin_data()       # 丢弃原始日志文本(不建议这么做)
```

这里引用了几个用户自定义的 pattern，如 `_dklog_date`、`_dklog_level`。我们将这些规则存放 *<Datakit 安装目录>/pipeline/pattern* 下。

<!-- markdownlint-disable MD046 -->
???+ warning

    用户自定义 pattern 如果需要全局生效（即在其它 Pipeline 脚本中应用），必须放置在 *[Datakit 安装目录]/pipeline/pattern/>* 目录下：

    ```Shell
    $ cat pipeline/pattern/datakit
    # 注意：自定义的这些 pattern，命名最好加上特定的前缀，以免跟内置的命名
    # 冲突（内置 pattern 名称不允许覆盖）
    #
    # 自定义 pattern 格式为：
    #    <pattern-name><空格><具体 pattern 组合>
    #
    _dklog_date %{YEAR}-%{MONTHNUM}-%{MONTHDAY}T%{HOUR}:%{MINUTE}:%{SECOND}%{INT}
    _dklog_level (DEBUG|INFO|WARN|ERROR|FATAL)
    _dklog_mod %{WORD}
    _dklog_source_file (/?[\w_%!$@:.,-]?/?)(\S+)?
    _dklog_msg %{GREEDYDATA}
    ```
<!-- markdownlint-enable -->

现在 Pipeline 以及其引用的 pattern 都有了，就能通过 Datakit 内置的 Pipeline 调试工具，对这一行日志进行切割：

```Shell
# 提取成功示例
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
### :material-chat-question: Pipeline 调试时，为什么变量无法引用？ {#ref-variables}
<!-- markdownlint-enable -->

现有如下 Pipeline：

```py linenums="1"
json(_, message, "message")
json(_, thread_name, "thread")
json(_, level, "status")
json(_, @timestamp, "time")
```

其报错如下：

``` not-set
[E] new piepline failed: 4:8 parse error: unexpected character: '@'
```

这是因为变量名（此处为 `@timestamp`） 中带有了特殊字符，这种情况下，我们需要对这个变量做一些转义：

```python
json(_, `@timestamp`, "time")
```

参见 [Pipeline 的基本语法规则](pipeline.md#basic-syntax)

<!-- markdownlint-disable MD013 -->
### :material-chat-question: Pipeline 调试时，为什么找不到对应的 Pipeline 脚本？ {#pl404}
<!-- markdownlint-enable -->

命令如下：

```shell
$ datakit pipeline -P test.p -T "..."
[E] get pipeline failed: stat /usr/local/datakit/pipeline/test.p: no such file or directory
```

这是因为被调试的 Pipeline 存放的位置不对。调试用的 Pipeline 脚本，需将其放置到 *[Datakit 安装目录]/pipeline/* 目录下。

<!-- markdownlint-disable MD013 -->
### :material-chat-question: 如何在一个 Pipeline 中切割多种不同格式的日志？ {#if-else}
<!-- markdownlint-enable -->

在日常的日志中，因为业务的不同，日志会呈现出多种形态，此时，需写多个 Grok 切割，为提高 Grok 的运行效率，**可根据日志出现的频率高低，优先匹配出现频率更高的那个 Grok**，这样，大概率日志在前面几个 Grok 中就匹配上了，避免了无效的匹配。

<!-- markdownlint-disable MD046 -->
???+ tip

    在日志切割中，Grok 匹配是性能开销最大的部分，故避免重复的 Grok 匹配，能极大的提高 Grok 的切割性能。

    ```python
    grok(_, "%{NOTSPACE:client_ip} %{NOTSPACE:http_ident} ...")
    if client_ip != nil {
        # 证明此时上面的 grok 已经匹配上了，那么就按照该日志来继续后续处理
        ...
    } else {
        # 这里说明是不同的日志来了，上面的 grok 没有匹配上当前的日志
        grok(_, "%{date2:time} \\[%{LOGLEVEL:status}\\] %{GREEDYDATA:msg} ...")
    
        if status != nil {
            # 此处可再检查上面的 grok 是否匹配上
        } else {
            # 未识别的日志，或者，在此可再加一个 grok 来处理，如此层层递进
        }
    }
    ```
<!-- markdownlint-enable -->

### :material-chat-question: 如何丢弃字段切割 {#drop-keys}

在某些情况下，我们需要的只是日志中间的几个字段，但不好跳过前面的部分，比如

``` not-set
200 356 1 0 44 30032 other messages
```

其中，我们只需要 `44` 这个值，它可能代码响应延迟，那么可以这样切割（即 Grok 中不附带 `:some_field` 这个部分）：

```python
grok(_, "%{INT} %{INT} %{INT} %{INT:response_time} %{GREEDYDATA}")
```

### :material-chat-question: `add_pattern()` 转义问题 {#escape}

大家在使用 `add_pattern()` 添加局部模式时，容易陷入转义问题，比如如下这个 pattern（用来通配文件路径以及文件名）：

``` not-set
(/?[\w_%!$@:.,-]?/?)(\S+)?
```

如果我们将其放到全局 pattern 目录下（即 *pipeline/pattern* 目录），可这么写：

``` not-set
# my-test
source_file (/?[\w_%!$@:.,-]?/?)(\S+)?
```

如果使用 `add_pattern()`，就需写成这样：

``` python
# my-test.p
add_pattern('source_file', '(/?[\\w_%!$@:.,-]?/?)(\\S+)?')
```

即这里面反斜杠需要转义。
