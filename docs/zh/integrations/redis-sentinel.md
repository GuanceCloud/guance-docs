---
title     : 'Redis Sentinel'
summary   : '采集 Redis Sentinel 集群指标、日志信息'
__int_icon: 'icon/redis'
dashboard :
  - desc  : 'Redis-sentinel 监控视图'
    path  : 'dashboard/zh/redis_sentinel'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Redis Sentinel
<!-- markdownlint-enable -->

Redis-sentinel 指标展示，包括 Redis 集群、Slaves、节点分布信息等。


## 安装部署 {#config}

### 下载 redis-sentinel-exporter 指标采集器

下载地址 [https://github.com/lrwh/redis-sentinel-exporter/releases](https://github.com/lrwh/redis-sentinel-exporter/releases)


### 启动 redis-sentinel-exporter

```bash
java -Xmx64m -jar redis-sentinel-exporter-0.2.jar --spring.redis.sentinel.master=mymaster --spring.redis.sentinel.nodes="127.0.0.1:26379,127.0.0.1:26380,127.0.0.1:26381"
```

参数说明：

- spring.redis.sentinel.master ： 集群名称
- spring.redis.sentinel.nodes ： 哨兵节点地址

### 采集器配置

#### 指标采集

- 开启 DataKit prom 插件，复制 sample 文件

```bash
cd /usr/local/datakit/conf.d/prom/
cp prom.conf.sample redis-sentinel-prom.conf
```

- 修改 `redis-sentinel-prom.conf` 配置文件

??? quote "`redis-sentinel-prom.conf`"
<!-- markdownlint-disable MD046 -->
    ```toml
    # {"version": "1.2.12", "desc": "do NOT edit this line"}

    [[inputs.prom]]
    ## Exporter URLs
    urls = ["http://localhost:6390/metrics"]

    ## 忽略对 url 的请求错误
    ignore_req_err = false

    ## 采集器别名
    source = "redis_sentinel"

    ## 采集数据输出源
    # 配置此项，可以将采集到的数据写到本地文件而不将数据打到中心
    # 之后可以直接用 datakit --prom-conf /path/to/this/conf 命令对本地保存的指标集进行调试
    # 如果已经将 url 配置为本地文件路径，则 --prom-conf 优先调试 output 路径的数据
    # output = "/abs/path/to/file"

    ## 采集数据大小上限，单位为字节
    # 将数据输出到本地文件时，可以设置采集数据大小上限
    # 如果采集数据的大小超过了此上限，则采集的数据将被丢弃
    # 采集数据大小上限默认设置为32MB
    # max_file_size = 0

    ## 指标类型过滤, 可选值为 counter, gauge, histogram, summary
    # 默认只采集 counter 和 gauge 类型的指标
    # 如果为空，则不进行过滤
    metric_types = []

    ## 指标名称过滤
    # 支持正则，可以配置多个，即满足其中之一即可
    # 如果为空，则不进行过滤
    # metric_name_filter = ["cpu"]

    ## 指标集名称前缀
    # 配置此项，可以给指标集名称添加前缀
    # measurement_prefix = "redis_sentinel_"

    ## 指标集名称
    # 默认会将指标名称以下划线"_"进行切割，切割后的第一个字段作为指标集名称，剩下字段作为当前指标名称
    # 如果配置measurement_name, 则不进行指标名称的切割
    # 最终的指标集名称会添加上measurement_prefix前缀
    measurement_name = "redis_sentinel"

    ## 采集间隔 "ns", "us" (or "µs"), "ms", "s", "m", "h"
    interval = "10s"

    ## 过滤tags, 可配置多个tag
    # 匹配的tag将被忽略
    # tags_ignore = ["xxxx"]

    ## TLS 配置
    tls_open = false
    # tls_ca = "/tmp/ca.crt"
    # tls_cert = "/tmp/peer.crt"
    # tls_key = "/tmp/peer.key"

    ## 自定义认证方式，目前仅支持 Bearer Token
    # token 和 token_file: 仅需配置其中一项即可
    # [inputs.prom.auth]
    # type = "bearer_token"
    # token = "xxxxxxxx"
    # token_file = "/tmp/token"

    ## 自定义指标集名称
    # 可以将包含前缀prefix的指标归为一类指标集
    # 自定义指标集名称配置优先measurement_name配置项
    #[[inputs.prom.measurements]]
    #  prefix = "cpu_"
    #  name = "cpu"

    # [[inputs.prom.measurements]]
    # prefix = "mem_"
    # name = "mem"

    ## 自定义Tags
    [inputs.prom.tags]
    # some_tag = "some_value"
      # more_tag = "some_other_value"

    ```
<!-- markdownlint-enable -->
主要参数说明

- urls：`prometheus` 指标地址，这里填写 redis-sentinel-exporter 暴露出来的指标 url
- source：采集器别名
- interval：采集间隔
- measurement_prefix：指标前缀，便于指标分类查询
- tls_open：TLS 配置
- metric_types：指标类型，不填，代表采集所有指标
- [inputs.prom.tags]：额外定义的 tag

- 重启 DataKit (如果需要开启日志，请配置日志采集再重启)

```bash
systemctl restart datakit
```


## 日志采集 {#logging}

### 配置采集器

- 修改 `redis.conf` 配置文件

```toml

[[inputs.logging]]
  ## required
  logfiles = [
    "D:/software_installer/Redis-x64-3.2.100/log/sentinel_*_log.log",
  ]

  ## glob filteer
  ignore = [""]

  ## your logging source, if it's empty, use 'default'
  source = "redis-sentinel"

  ## add service tag, if it's empty, use $source.
  service = "redis-sentinel"

  ## grok pipeline script name
  pipeline = ""

  ## optional status:
  ##   "emerg","alert","critical","error","warning","info","debug","OK"
  ignore_status = []

  ## optional encodings:
  ##    "utf-8", "utf-16le", "utf-16le", "gbk", "gb18030" or ""
  character_encoding = ""

  ## datakit read text from Files or Socket , default max_textline is 32k
  ## If your log text line exceeds 32Kb, please configure the length of your text, 
  ## but the maximum length cannot exceed 32Mb 
  # maximum_length = 32766

  ## The pattern should be a regexp. Note the use of '''this regexp'''
  ## regexp link: https://golang.org/pkg/regexp/syntax/#hdr-Syntax
  # multiline_match = '''^\S'''

  ## removes ANSI escape codes from text strings
  remove_ansi_escape_codes = false

  ## if file is inactive, it is ignored
  ## time units are "ms", "s", "m", "h"
  # ignore_dead_log = "1h"

  [inputs.logging.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"

```

参数说明

```txt
- files：日志文件路径 (通常填写访问日志和错误日志)
- ignore：要过滤的文件名
- pipeline：日志切割文件
- character_encoding：日志编码格式
- match：开启多行日志收集
```

- 重启 DataKit (如果需要开启自定义标签，请配置插件标签再重启)

```bash
systemctl restart datakit
```

### 配置 Pipeline

日志 Pipeline 功能切割字段说明

Redis 通用日志切割

- 原始日志为：

```txt
[11412] 05 May 10:17:31.329 # Creating Server TCP listening socket *:26380: bind: No such file or directory
```

- 切割后的字段列表如下：

| 字段名 | 字段值 | 说明 |
| --- | --- | --- |
| `pid` | `122` | 进程id |
| `role` | `M` | 角色 |
| `service` | `*` | 服务 |
| `status` | `notice` | 日志级别 |
| `message` | `Creating Server TCP listening socket *:26380: bind: No such file or directory` | 日志内容 |
| `time` | `1557861100164000000` | 纳秒时间戳（作为行协议时间） |


重启 DataKit

```bash
systemctl restart datakit
```


## 指标详解 {#metric}

| 指标 | 含义 | 类型 |
| --- | --- | --- |
| redis_sentinel_known_sentinels | 哨兵实例数 | Gauge |
| redis_sentinel_known_slaves | 集群slaves实例数 | Gauge |
| redis_sentinel_cluster_type | 集群节点类型 | Gauge |
| redis_sentinel_link_pending_commands | 哨兵挂起命令数 | Gauge |
| redis_sentinel_odown_slaves | slave客观宕机 | Gauge |
| redis_sentinel_sdown_slaves | slave主观宕机 | Gauge |
| redis_sentinel_ok_slaves | 正在运行的slave数 | Gauge |
| redis_sentinel_ping_latency | 哨兵ping的延迟显示为毫秒 | Gauge |
| redis_sentinel_last_ok_ping_latency | 哨兵ping成功的秒数 | Gauge |
| redis_sentinel_node_state  | redis 节点状态     | Gauge |
