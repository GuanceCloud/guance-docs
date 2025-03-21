---
title: 'CouchBase Exporter'
summary: '采集器可以从 CouchBase 实例中采取很多指标，比如数据使用的内存和磁盘、当前连接数等多种指标，并将指标采集到<<< custom_key.brand_name >>>，帮助监控分析 CouchBase 各种异常情况。'
__int_icon:'icon/couchbase'
dashboard:
  - desc: 'CouchBase 内置视图 by Exporter'
    path: 'dashboard/zh/couchbase_prom'

monitor:
  - desc: 'CouchBase 监控器'
    path: 'monitor/zh/couchbase_prom'

---


<!-- markdownlint-disable MD025 -->
# CouchBase
<!-- markdownlint-enable -->


采集器可以从 CouchBase 实例中采取很多指标，比如数据使用的内存和磁盘、当前连接数等多种指标，并将指标采集到<<< custom_key.brand_name >>>，帮助监控分析 CouchBase 各种异常情况。

## 采集器配置 {#config}

### 前置条件

#### 版本说明

> CouchBase Version：*7.2.0*
> CouchBase Exporter Version：`blakelead/couchbase-exporter:latest`

#### 安装CouchBase Exporter

使用 CouchBase 的客户端采集器 CouchBase Exporter，采集器文档[地址](https://github.com/blakelead/couchbase_exporter)

备注：文中使用的用户密码为 CouchBase Server 的用户密码

```bash
docker run -d  --name cbexporter                      --publish 9191:9191                      --env EXPORTER_LISTEN_ADDR=:9191                      --env EXPORTER_TELEMETRY_PATH=/metrics                      --env EXPORTER_SERVER_TIMEOUT=10s                      --env EXPORTER_LOG_LEVEL=debug                      --env EXPORTER_LOG_FORMAT=json                      --env EXPORTER_DB_URI=http://172.17.0.92:8091                      --env EXPORTER_DB_TIMEOUT=10s                      --env EXPORTER_DB_USER=Administrator                      --env EXPORTER_DB_PASSWORD=guance.com                      --env EXPORTER_SCRAPE_CLUSTER=true                      --env EXPORTER_SCRAPE_NODE=true                      --env EXPORTER_SCRAPE_BUCKET=true                      --env EXPORTER_SCRAPE_XDCR=false                      blakelead/couchbase-exporter:latest
```

参数介绍：

```txt
|                            |                     |                                                    |                                                 |
| -------------------------- | ------------------- | -------------------------------------------------- | ----------------------------------------------- |
| environment variable       | argument            | description                                        | default                                         |
|                            | -config.file        | Configuration file to load data from               |                                                 |
| EXPORTER_LISTEN_ADDR       | -web.listen-address | Address to listen on for HTTP requests             | :9191                                           |
| EXPORTER_TELEMETRY_PATH    | -web.telemetry-path | Path under which to expose metrics                 | /metrics                                        |
| EXPORTER_SERVER_TIMEOUT    | -web.timeout        | Server read timeout in seconds                     | 10s                                             |
| EXPORTER_DB_URI            | -db.uri             | Address of CouchBase cluster                       | [http://127.0.0.1:8091](http://127.0.0.1:8091/) |
| EXPORTER_DB_TIMEOUT        | -db.timeout         | CouchBase client timeout in seconds                | 10s                                             |
| EXPORTER_TLS_ENABLED       | -tls.enabled        | If true, enable TLS communication with the cluster | false                                           |
| EXPORTER_TLS_SKIP_INSECURE | -tls.skip-insecure  | If true, certificate won't be verified             | false                                           |
| EXPORTER_TLS_CA_CERT       | -tls.ca-cert        | Root certificate of the cluster                    |                                                 |
| EXPORTER_TLS_CLIENT_CERT   | -tls.client-cert    | Client certificate                                 |                                                 |
| EXPORTER_TLS_CLIENT_KEY    | -tls.client-key     | Client private key                                 |                                                 |
| EXPORTER_DB_USER           | *not allowed*       | Administrator username                             |                                                 |
| EXPORTER_DB_PASSWORD       | *not allowed*       | Administrator password                             |                                                 |
| EXPORTER_LOG_LEVEL         | -log.level          | Log level: info,debug,warn,error,fatal             | error                                           |
| EXPORTER_LOG_FORMAT        | -log.format         | Log format: text, `json`                             | text                                            |
| EXPORTER_SCRAPE_CLUSTER    | -scrape.cluster     | If false, wont scrape cluster metrics              | true                                            |
| EXPORTER_SCRAPE_NODE       | -scrape.node        | If false, wont scrape node metrics                 | true                                            |
| EXPORTER_SCRAPE_BUCKET     | -scrape.bucket      | If false, wont scrape bucket metrics               | true                                            |
| EXPORTER_SCRAPE_XDCR       | -scrape.xdcr        | If false, wont scrape `xdcr` metrics                 | false                                           |
|                            | -help               | Command line help                                  |                                                 |
```

### 配置实施

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    - 开启 DataKit Prom 插件，复制 sample 文件
    
    ```bash
    /usr/local/datakit/conf.d/prom
    cp prom.conf.sample couchbase-prom.conf
    ```
    
    - 修改 `couchbase-prom.conf` 配置文件
    
    ```toml
    [[inputs.prom]]
    ## Exporter URLs
    urls = [""]
    
    ## 忽略对 url 的请求错误
    ignore_req_err = false
    
    ## 采集器别名
    source = "zookeeper"
    
    ## 采集数据输出源
    # 配置此项，可以将采集到的数据写到本地文件而不将数据打到中心
    # 之后可以直接用 datakit --prom-conf /path/to/this/conf 命令对本地保存的指标集进行调试
    # 如果已经将 url 配置为本地文件路径，则 --prom-conf 优先调试 output 路径的数据
    # output = "/abs/path/to/file"
    > 
    ## 采集数据大小上限，单位为字节
    # 将数据输出到本地文件时，可以设置采集数据大小上限
    # 如果采集数据的大小超过了此上限，则采集的数据将被丢弃
    # 采集数据大小上限默认设置为32MB
    # max_file_size = 0
    
    ## 指标类型过滤, 可选值为 counter, gauge, histogram, summary
    # 默认只采集 counter 和 gauge 类型的指标
    # 如果为空，则不进行过滤
    metric_types = ["counter", "gauge"]
    
    ## 指标名称过滤
    # 支持正则，可以配置多个，即满足其中之一即可
    # 如果为空，则不进行过滤
    # metric_name_filter = ["cpu"]
    
    ## 指标集名称前缀
    # 配置此项，可以给指标集名称添加前缀
    measurement_prefix = ""
    
    ## 指标集名称
    # 默认会将指标名称以下划线"_"进行切割，切割后的第一个字段作为指标集名称，剩下字段作为当前指标名称
    # 如果配置measurement_name, 则不进行指标名称的切割
    # 最终的指标集名称会添加上measurement_prefix前缀
    # measurement_name = "prom"
    
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
    #some_tag = "some_value"
    # more_tag = "some_other_value"
    ```
    
    - 重启 DataKit
    
    ```bash
    systemctl restart datakit
    ```

=== "Kubernetes"

    > 目前可以通过 [ConfigMap 方式注入采集器配置](datakit-daemonset-deploy.md#configmap-setting)来开启采集器。


<!-- markdownlint-enable -->

## 指标 {#metric}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.prom.tags]` 指定其它标签：

```toml
[inputs.prom.tags]
#some_tag = "some_value"
# more_tag = "some_other_value"
```

### Cluster metrics

标签

| name     | description                     |
| -------- | ------------------------------- |
| bucket   | bucket name                     |
| host     | host name which installed nginx |
| instance | host                            |

指标

| name                            | description          |
| ------------------------------- | -------------------- |
| cluster_rebalance_status    | `Rebalancing` status |

完整指标详见：[地址]( https://github.com/blakelead/couchbase_exporter/blob/master/resources/metrics.md#cluster-metrics)

### Node metrics

标签

| name     | description                     |
| -------- | ------------------------------- |
| bucket   | bucket name                     |
| host     | host name which installed nginx |
| instance | host                            |

指标

| name                                    | description                               |
| --------------------------------------- | ----------------------------------------- |
| node_stats_couch_docs_data_size   | CouchBase documents data size in the node |
| node_stats_get_hits               | Number of get hits                        |
| node_uptime_seconds               | Node uptime                               |
| node_status                      | Status of CouchBase node                  |

完整指标详见：[地址](https://github.com/blakelead/couchbase_exporter/blob/master/resources/metrics.md#node-metrics)

### Bucket metrics

标签

| name     | description                     |
| -------- | ------------------------------- |
| bucket   | bucket name                     |
| host     | host name which installed nginx |
| instance | host                            |

指标

| name                                  | description                                     |
| ------------------------------------- | ----------------------------------------------- |
| bucket_ram_quota_percent_used  | Memory used by the bucket in percent            |
| bucket_ops_per_second          | Number of operations per second                 |
| bucket_item_count            | Number of items in the bucket                   |
| bucketstats_curr_connections     | Current bucket connections                      |
| bucketstats_delete_hits         | Delete hits                                     |
| bucketstats_disk_write_queue     | Disk write queue depth                          |
| bucketstats_ep_bg_fetched       | Disk reads per second                           |
| bucketstats_ep_mem_high_wat     | Memory usage high water mark for auto-evictions |

完整指标详见：[地址](https://github.com/blakelead/couchbase_exporter/blob/master/resources/metrics.md#bucket-metrics)

### XDCR metrics

标签

| name     | description                     |
| -------- | ------------------------------- |
| bucket   | bucket name                     |
| host     | host name which installed nginx |
| instance | host                            |

指标

完整指标详见：[地址](https://github.com/blakelead/couchbase_exporter/blob/master/resources/metrics.md#xdcr-metrics)

## 日志 {#logging}

如需采集 CouchBase 的日志，步骤如下：

- 开启 DataKit log 插件，复制 sample 文件

```bash
/usr/local/datakit/conf.d/log
cp logging.conf.sample couchbase-logging.conf
```

> 注意：必须将 DataKit 安装在 CouchBase 所在主机才能采集 CouchBase 日志。

- 修改 `couchbase-prom.conf` 配置文件

```toml
# {"version": "1.9.2", "desc": "do NOT edit this line"}

[[inputs.logging]]
  ## Required
  ## File names or a pattern to tail.
  logfiles = [
    "/opt/couchbase/var/lib/couchbase/logs/couchdb.log",
  ]

  ## glob filteer
  ignore = [""]

  ## Your logging source, if it's empty, use 'default'.
  source = "couchdb"

  ## Add service tag, if it's empty, use $source.
  service = "couchdb"

  ## Grok pipeline script name.
  pipeline = ""

  ## optional status:
  ##   "emerg","alert","critical","error","warning","info","debug","OK"
  ignore_status = []

  ## optional encodings:
  ##    "utf-8", "utf-16le", "utf-16le", "gbk", "gb18030" or ""
  character_encoding = ""

  ## The pattern should be a regexp. Note the use of '''this regexp'''.
  ## regexp link: https://golang.org/pkg/regexp/syntax/#hdr-Syntax
  # multiline_match = '''^\S'''

  auto_multiline_detection = true
  auto_multiline_extra_patterns = []

  ## Removes ANSI escape codes from text strings.
  remove_ansi_escape_codes = false

  ## If the data sent failure, will retry forevery.
  blocking_mode = true

  ## If file is inactive, it is ignored.
  ## time units are "ms", "s", "m", "h"
  ignore_dead_log = "1h"

  ## Read file from beginning.
  from_beginning = false

  [inputs.logging.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
```

