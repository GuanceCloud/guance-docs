
# 文件日志
---

- DataKit 版本：1.4.8
- 操作系统支持：全平台

本文档主要介绍本地磁盘日志采集和 Socket 日志采集：

- 磁盘日志采集 ：采集文件尾部数据（类似命令行 `tail -f`）
- Socket 端口获取：通过 TCP/UDP 方式将日志发送给 DataKit 

## 配置 {#config}

进入 DataKit 安装目录下的 `conf.d/log` 目录，复制 `logging.conf.sample` 并命名为 `logging.conf`。示例如下：

``` toml
[[inputs.logging]]
  # 日志文件列表，可以指定绝对路径，支持使用 glob 规则进行批量指定
  # 推荐使用绝对路径
  logfiles = [
    "/var/log/*",                          # 文件路径下所有文件
    "/var/log/sys*",                       # 文件路径下所有以 sys 前缀的文件
    "/var/log/syslog",                     # Unix 格式文件路径
    "C:/path/space 空格中文路径/some.txt", # Windows 风格文件路径
    "/var/log/*",                          # 文件路径下所有文件
    "/var/log/sys*",                       # 文件路径下所有以 sys 前缀的文件
  ]

  ## socket 目前支持两种协议：tcp/udp。建议开启内网端口防止安全隐患
  ## socket 和 log 目前只能选择其中之一，不能既通过文件采集，又通过 socket 采集
  socket = [
   "tcp://0.0.0.0:9540"
   "udp://0.0.0.0:9541"
  ]

  # 文件路径过滤，使用 glob 规则，符合任意一条过滤条件将不会对该文件进行采集
  ignore = [""]
  
  # 数据来源，如果为空，则默认使用 'default'
  source = ""
  
  # 新增标记tag，如果为空，则默认使用 $source
  service = ""
  
  # pipeline 脚本路径，如果为空将使用 $source.p，如果 $source.p 不存在将不使用 pipeline
  pipeline = ""
  
  # 过滤对应 status:
  #   `emerg`,`alert`,`critical`,`error`,`warning`,`info`,`debug`,`OK`
  ignore_status = []
  
  # 选择编码，如果编码有误会导致数据无法查看。默认为空即可:
  #    `utf-8`, `utf-16le`, `utf-16le`, `gbk`, `gb18030` or ""
  character_encoding = ""
  
  ## 设置正则表达式，例如 ^\d{4}-\d{2}-\d{2} 行首匹配 YYYY-MM-DD 时间格式
  ## 符合此正则匹配的数据，将被认定为有效数据，否则会累积追加到上一条有效数据的末尾
  ## 使用3个单引号 '''this-regexp''' 避免转义
  ## 正则表达式链接：https://golang.org/pkg/regexp/syntax/#hdr-Syntax
  # multiline_match = '''^\S'''

  ## 是否删除 ANSI 转义码，例如标准输出的文本颜色等
  remove_ansi_escape_codes = false
  
  ## 忽略不活跃的文件，例如文件最后一次修改是 20 分钟之前，距今超出 10m，则会忽略此文件
  ## 时间单位支持 "ms", "s", "m", "h"
  ignore_dead_log = "10m"

  # 自定义 tags
  [inputs.logging.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

> 关于 `ignore_dead_log` 的说明：如果文件已经在采集，但 10min 内没有新日志写入的话，DataKit 会关闭该文件的采集。在这期间（10min），该文件**不能**被物理删除（如 `rm` 之后，该文件只是标记删除，DataKit 关闭该文件后，该文件才会真正被删除）。

### socket 采集日志 {#socket}

将 conf 中 `logfiles` 注释掉，并配置 `sockets`。以 log4j2 为例:

``` xml
 <!-- socket 配置日志传输到本机 9540 端口，protocol 默认 tcp -->
 <Socket name="name1" host="localHost" port="9540" charset="utf8">
     <!-- 输出格式  序列布局-->
     <PatternLayout pattern="%d{yyyy.MM.dd 'at' HH:mm:ss z} %-5level %class{36} %L %M - %msg%xEx%n"/>

     <!--注意：不要开启序列化传输到 socket 采集器上，目前 DataKit 无法反序列化，请使用纯文本形式传输-->
     <!-- <SerializedLayout/>-->
 </Socket>
```

更多: Java Go Python 主流日志组件的配置及代码示例，请参阅：[socket client 配置](logging_socket.md)

### 多行日志采集

通过识别多行日志的第一行特征，即可判定某行日志是不是一条新的日志。如果不符合这个特征，我们即认为当前行日志只是前一条多行日志的追加。

举例说明一下，一般情况下，日志都是顶格写的，但有些日志文本不是顶格写的，比如程序崩溃时的调用栈日志，那么，对于这种日志文本，就是多行日志。

在 DataKit 中，我们通过正则表达式来识别多行日志特征，正则匹配上的日志行，就是一条新的日志的开始，后续所有不匹配的日志行，都认为是这条新日志的追加，直到遇到另一行匹配正则的新日志为止。 

在 `logging.conf` 中，修改如下配置：

```toml
multiline_match = '''这里填写具体的正则表达式''' # 注意，这里的正则俩边，建议分别加上三个「英文单引号」
```

日志采集器中使用的正则表达式风格[参考](https://golang.org/pkg/regexp/syntax/#hdr-Syntax){:target="_blank"}

假定原数据为：

```
2020-10-23 06:41:56,688 INFO demo.py 1.0
2020-10-23 06:54:20,164 ERROR /usr/local/lib/python3.6/dist-packages/flask/app.py Exception on /0 [GET]
Traceback (most recent call last):
  File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app
    response = self.full_dispatch_request()
ZeroDivisionError: division by zero
2020-10-23 06:41:56,688 INFO demo.py 5.0
```

`multiline_match` 配置为 `^\d{4}-\d{2}-\d{2}.*` 时，（意即匹配形如 `2020-10-23` 这样的行首）

切割出的三个行协议点如下（行号分别是 1/2/8）。可以看到 `Traceback ...` 这一段（第 3 ~ 6 行）没有单独形成一条日志，而是追加在上一条日志（第 2 行）的 `message` 字段中。

```
testing,filename=/tmp/094318188 message="2020-10-23 06:41:56,688 INFO demo.py 1.0" 1611746438938808642
testing,filename=/tmp/094318188 message="2020-10-23 06:54:20,164 ERROR /usr/local/lib/python3.6/dist-packages/flask/app.py Exception on /0 [GET]
Traceback (most recent call last):
  File \"/usr/local/lib/python3.6/dist-packages/flask/app.py\", line 2447, in wsgi_app
    response = self.full_dispatch_request()
ZeroDivisionError: division by zero
" 1611746441941718584
testing,filename=/tmp/094318188 message="2020-10-23 06:41:56,688 INFO demo.py 5.0" 1611746443938917265
```

#### 超长多行日志处理的限制

目前最多能处理不超过 1000 行的单条多行日志，如果实际多行日志超过 1000 行，DataKit 会将其识别成多条。举例如下，假定有如下多行日志，我们要将其识别成单条日志：

```log
2020-10-23 06:54:20,164 ERROR /usr/local/lib/python3.6/dist-packages/flask/app.py Exception on /0 [GET]
Traceback (most recent call last):
  File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app
    response = self.full_dispatch_request()
      ...                                 <---- 此处省略 996 行，加上上面的 4 行，刚好 1000 行
        File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app
          response = self.full_dispatch_request()
             ZeroDivisionError: division by zero
2020-10-23 06:41:56,688 INFO demo.py 5.0  <---- 全新的一条多行日志
Traceback (most recent call last):
 ...
```

此处，由于有超长的多行日志，第一条日志总共有 1003 行，但 DataKit 这里会做一个截取动作，具体而言，这里会切割出三条日志：

第一条：即头部的 1000 行

```log
2020-10-23 06:54:20,164 ERROR /usr/local/lib/python3.6/dist-packages/flask/app.py Exception on /0 [GET]
Traceback (most recent call last):
  File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app
    response = self.full_dispatch_request()
      ...                                 <---- 此处省略 996 行，加上上面的 4 行，刚好 1000 行
```

第二条：除去头部的 1000 条，剩余的部分独立成为一条日志

```log
        File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app
          response = self.full_dispatch_request()
             ZeroDivisionError: division by zero
```

第三条：下面一条全新的日志：

```log
2020-10-23 06:41:56,688 INFO demo.py 5.0  <---- 全新的一条多行日志
Traceback (most recent call last):
 ...
```

#### 日志单行最大长度

无论从文件还是从 socket 中读取的日志, 单行（包括经过 `multiline_match` 处理后）最大长度为 32MB，超出部分会被截断且丢弃。

### Pipeline 配置和使用

[Pipeline](../datakit/pipeline.md) 主要用于切割非结构化的文本数据，或者用于从结构化的文本中（如 JSON）提取部分信息。

对日志数据而言，主要提取两个字段：

- `time`：即日志的产生时间，如果没有提取 `time` 字段或解析此字段失败，默认使用系统当前时间
- `status`：日志的等级，如果没有提取出 `status` 字段，则默认将 `stauts` 置为 `unknown`

#### 可用日志等级 {#status}

有效的 `status` 字段值如下（不区分大小写）：

| 日志可用等级          | 简写    | Studio 显示值 |
| ------------          | :----   | ----          |
| `alert`               | `a`     | `alert`       |
| `critical`            | `c`     | `critical`    |
| `error`               | `e`     | `error`       |
| `warning`             | `w`     | `warning`     |
| `notice`              | `n`     | `notice`      |
| `info`                | `i`     | `info`        |
| `debug/trace/verbose` | `d`     | `debug`       |
| `OK`                  | `o`/`s` | `OK`          |

> 注：如果日志等级（status）不属于上述任何一种（含简写），那么 DataKit 会将其 status 字段置为 `unknown`。

示例：假定文本数据如下：

```
12115:M 08 Jan 17:45:41.572 # Server started, Redis version 3.0.6
```
pipeline 脚本：

```python
add_pattern("date2", "%{MONTHDAY} %{MONTH} %{YEAR}?%{TIME}")
grok(_, "%{INT:pid}:%{WORD:role} %{date2:time} %{NOTSPACE:serverity} %{GREEDYDATA:msg}")
group_in(serverity, ["#"], "warning", status)
cast(pid, "int")
default_time(time)
```

最终结果：

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

Pipeline 的几个注意事项：

- 如果 logging.conf 配置文件中 `pipeline` 为空，默认使用 `<source-name>.p`（假定 `source` 为 `nginx`，则默认使用 `nginx.p`）
- 如果 `<source-name.p>` 不存在，将不启用 pipeline 功能
- 所有 pipeline 脚本文件，统一存放在 DataKit 安装路径下的 pipeline 目录下
- 如果日志文件配置的是通配目录，logging 采集器会自动发现新的日志文件，以确保符合规则的新日志文件能够尽快采集到

### glob 规则简述（图表数据[来源](https://rgb-24bit.github.io/blog/2018/glob.html){:target="_blank"}）

使用 glob 规则更方便地指定日志文件，以及自动发现和文件过滤。

| 通配符   | 描述                               | 正则示例       | 匹配示例                  | 不匹配                      |
| :--      | ---                                | ---            | ---                       | ----                        |
| `*`      | 匹配任意数量的任何字符，包括无     | `Law*`         | Law, Laws, Lawyer         | GrokLaw, La, aw             |
| `?`      | 匹配任何单个字符                   | `?at`          | Cat, cat, Bat, bat        | at                          |
| `[abc]`  | 匹配括号中给出的一个字符           | `[CB]at`       | Cat, Bat                  | cat, bat                    |
| `[a-z]`  | 匹配括号中给出的范围中的一个字符   | `Letter[0-9]`  | Letter0, Letter1, Letter9 | Letters, Letter, Letter10   |
| `[!abc]` | 匹配括号中未给出的一个字符         | `[!C]at`       | Bat, bat, cat             | Cat                         |
| `[!a-z]` | 匹配不在括号内给定范围内的一个字符 | `Letter[!3-5]` | Letter1…                  | Letter3 … Letter5, Letterxx |

另需说明，除上述 glob 标准规则外，采集器也支持 `**` 进行递归地文件遍历，如示例配置所示。

## 指标集 {#measurements}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.logging.tags]` 指定其它标签：

``` toml
 [inputs.logging.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `logging 日志采集`

使用配置文件中的 `source` 字段值，如果该值为空，则默认为 `default`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`filename`|此条日志来源的文件名，仅为基础文件名，并非带有全路径|
|`host`|主机名|
|`service`|service 名称，对应配置文件中的 `service` 字段值|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`log_read_lines`|采集到的行数计数，多行数据算成一行（[:octicons-tag-24: Version-1.4.6](../datakit/changelog.md#cl-1.4.6)）|int|count|
|`log_read_offset`|当前数据在文件中的偏移位置（[:octicons-tag-24: Version-1.4.8](../datakit/changelog.md#cl-1.4.8) · [:octicons-beaker-24: Experimental](index.md#experimental)）|int|-|
|`message`|日志正文，默认存在，可以使用 pipeline 删除此字段|string|-|
|`status`|日志状态，默认为 `unknown`，采集器会该字段做支持映射，映射表见上述 pipelie 配置和使用|string|-|

 

## FAQ

### 为什么在页面上看不到日志数据？

DataKit 启动后，`logfiles` 中配置的日志文件==有新的日志产生才会采集上来，老的日志数据是不会采集的==。

另外，一旦开始采集某个日志文件，将会自动触发一条日志，内容大概如下：

```
First Message. filename: /some/path/to/new/log ...
```

如果看到这样的信息，证明指定的文件==已经开始采集，只是当前尚无新的日志数据产生==。另外，日志数据的上传、处理、入库也有一定的时延，即使有新的数据产生，也需要等待一定时间（< 1min）。

### 磁盘日志采集和 Socket 日志采集的互斥性

两种采集方式目前互斥，当以 Socket 方式采集日志时，需将配置中的 `logfiles` 字段置空：`logfiles=[]`

### 远程文件采集方案

在 linux 上，可通过 [NFS 方式](https://linuxize.com/post/how-to-mount-an-nfs-share-in-linux/){:target="_blank"}，将日志所在主机的文件路径，挂载到 DataKit 主机下，logging 采集器配置对应日志路径即可。

### 日志的特殊字节码过滤

日志可能会包含一些不可读的字节码（比如终端输出的颜色等），可以将 `remove_ansi_escape_codes` 设置为 `true` 对其删除过滤。

此配置可能会影响日志的处理性能，基准测试结果如下：

```
goos: linux
goarch: amd64
pkg: gitlab.jiagouyun.com/cloudcare-tools/test
cpu: Intel(R) Core(TM) i7-4770HQ CPU @ 2.20GHz
BenchmarkRemoveAnsiCodes
BenchmarkRemoveAnsiCodes-8        636033              1616 ns/op
PASS
ok      gitlab.jiagouyun.com/cloudcare-tools/test       1.056s
```

每一条文本的处理耗时增加 `1616 ns` 不等。如果不开启此功能将无额外损耗。

### MacOS 日志采集器报错 `operation not permitted`

在 MacOS 中，因为系统安全策略的原因，DataKit 日志采集器可能会无法打开文件，报错 `operation not permitted`，解决方法参考 [apple developer doc](https://developer.apple.com/documentation/security/disabling_and_enabling_system_integrity_protection){:target="_blank"}。

### 日志量太大可能会引发的问题

自 datakit 版本1.2.0之后，无论是从磁盘读还是通过 socket 端口传输日志，为增加日志处理能力 采集器处理日志都改为异步操作，但同时也可能会在异步阻塞导致部分日志丢失

这个问题并不会影响到正常的服务运行，因为 socket 处理如果不是异步并主动丢弃堆积日志的话，日志会在 client 端产生堆积，严重情况造成内存泄露从而影响主业务的运行。
datakit 也会在处理不及造成日志堆积之后 缓存一定量日志到内存当中

### 如何估算日志的总量

由于日志的收费是按照条数来计费的，但一般情况下，大部分的日志都是程序写到磁盘的，只能看到磁盘占用大小（比如每天 100GB 日志）。

一种可行的方式，可以用以下简单的 shell 来判断：

```shell
# 统计 1GB 日志的行数
head -c 1g path/to/your/log.txt | wc -l
```

有时候，要估计一下日志采集可能带来的流量消耗：

```shell
# 统计 1GB 日志压缩后大小（字节）
head -c 1g path/to/your/log.txt | gzip | wc -c
```

这里拿到的是压缩后的字节数(bytes)，按照网络 bit 的计算方法（x8），其计算方式如下，以此可拿到大概的带宽消耗：

```
bytes * 2 * 8 /1024/1024 = xxx MBit
``` 

但实际上 DataKit 的压缩率不会这么高，因为 DataKit 不会一次性发送 1GB 的数据，而且分多次发送的，这个压缩率在 85% 左右（即 100MB 压缩到 15MB），故一个大概的计算方式是：

```
1GB * 2 * 8 * 0.15/1024/1024 = xxx MBit
```

> 此处 `*2` 考虑到了 [Pipeline 切割](../datakit/pipeline.md)导致的实际数据膨胀，而一般情况下，切割完都是要带上原始数据的，故按照最坏情况考虑，此处以加倍方式来计算。

## 延伸阅读

- [DataKit 日志采集综述](datakit-logging.md)
- [Pipeline: 文本数据处理](../datakit/pipeline.md)
- [Pipeline 调试](../datakit/datakit-pl-how-to.md)
- [Pipeline 性能测试和对比](../datakit/logging-pipeline-bench.md)
- [容器采日志采集](container#config)
- [通过 Sidecar(logfwd) 采集容器内部日志](logfwd.md)
- [正确使用正则表达式来配置](datakit-input-conf#debug-regex) 
