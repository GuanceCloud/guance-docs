---
title     : 'Kong'
summary   : '采集 Kong 指标、日志信息'
__int_icon: 'icon/kong'
dashboard :
  - desc  : 'Kong overview'
    path  : 'dashboard/zh/kong'
  - desc  : 'Kong API overview'
    path  : 'dashboard/zh/kong_api'
monitor   :
  - desc  : 'Kong'
    path  : 'monitor/zh/kong'
---

采集 Kong 指标、日志信息

<!-- markdownlint-disable MD046 MD010 MD024-->
## 指标 {#metrics}

### 1. Kong 配置

Kong 需要开启 Prometheus 插件后，方可上报指标数据，这里建议采用全局的方式进行配置，可参考 [Kong 官方文档](https://docs.konghq.com/gateway/latest/production/monitoring/prometheus/)

#### 通过 Kong Manager 进行配置

登陆 `Kong Manager` ，点击 `Plugins` 菜单，新增 `Prometheus`。

#### 通过 Kong API 进行配置

```shell
curl -X POST http://localhost:8001/plugins \
    --header "accept: application/json" \
    --header "Content-Type: application/json" \
    --data '
    {
  "name": "prometheus",
  "config": {
    "per_consumer": true,
    "status_code_metrics" : true,
    "bandwidth_metrics": true
  }
}'
```

### 2. DataKit 配置


- 进入 datakit 安装目录下的 `conf.d/prom` 目录，复制 `prom.conf.sample` 并命名为 `kong.conf`

> cp prom.conf.sample kong.conf

- 调整 `kong.conf`

只需调整以下两个参数，其他保持不变：

```yaml
[[inputs.prom]]
  ## Exporter URLs.
  urls = ["http://127.0.0.1:8001/metrics"]
  keep_exist_metric_name = true
```

- 重启 DataKit

执行以下命令

```shell
datakit service -R
```

### 3. Kong 指标集

| 指标名 | 单位 | 描述 |
| --- | --- | --- |
| kong_bandwidth_bytes | bytes | Kong的带宽使用量，单位为字节 |
| kong_datastore_reachable | - | 数据存储是否可达的状态指标 |
| kong_http_requests_total | count | HTTP请求的总数 |
| kong_kong_latency_ms_bucket | ms | Kong自身延迟的直方图桶，单位为毫秒 |
| kong_kong_latency_ms_count | count | Kong自身延迟的计数 |
| kong_kong_latency_ms_sum | ms | Kong自身延迟的总和，单位为毫秒 |
| kong_latency_ms_bucket | ms | 请求延迟的直方图桶，单位为毫秒 |
| kong_latency_ms_count | count | 请求延迟的计数 |
| kong_latency_ms_sum | ms | 请求延迟的总和，单位为毫秒 |
| kong_memory_lua_shared_dict_bytes | bytes | Lua共享字典使用的内存，单位为字节 |
| kong_memory_lua_shared_dict_total_bytes | bytes | Lua共享字典总内存，单位为字节 |
| kong_memory_workers_lua_vms_bytes | bytes | 工作进程中的Lua虚拟机使用的内存，单位为字节 |
| kong_nginx_connections_total | count | Nginx连接的总数 |
| kong_nginx_metric_errors_total | count | Nginx指标错误的总数 |
| kong_nginx_requests_total | count | Nginx请求的总数 |
| kong_node_info | - | 节点信息 |
| kong_request_latency_ms_bucket | ms | 请求延迟的直方图桶，单位为毫秒 |
| kong_request_latency_ms_count | count | 请求延迟的计数 |
| kong_request_latency_ms_sum | ms | 请求延迟的总和，单位为毫秒 |
| kong_upstream_latency_ms_bucket | ms | 上游延迟的直方图桶，单位为毫秒 |
| kong_upstream_latency_ms_count | count | 上游延迟的计数 |
| kong_upstream_latency_ms_sum | ms | 上游延迟的总和，单位为毫秒 |


## 日志 {#Logging}

### 1. Kong 配置

Kong 需要开启 `TCP Log` 插件后，方可上报日志数据

#### 通过 Kong Manager 进行配置

登陆 `Kong Manager` ，点击 `Plugins` 菜单，新增 `TCP Log`。

参数说明：

- host：DataKit host
- port: DataKit 日志 socket 端口

#### 通过 Kong API 进行配置

```shell
curl -X POST http://localhost:8001/plugins \
    --header "accept: application/json" \
    --header "Content-Type: application/json" \
    --data '
    {
  "name": "tcp-log",
  "config": {
    "port": 9580,
    "host" : "<datakit-host>"
  }
}'
```


### 2. DataKit 配置


- 进入 datakit 安装目录下的 `conf.d/log` 目录，复制 `logging.conf.sample` 并命名为 `kong-socket.conf`

> cp logging.conf.sample kong-socket.conf

- 调整 `kong-socket.conf`

可用以下全文替换：

```toml
# {"version": "1.22.0", "desc": "do NOT edit this line"}

[[inputs.logging]]
  ## Required
  ## File names or a pattern to tail.

  # Only two protocols are supported:TCP and UDP.
  sockets = [
  	 "tcp://0.0.0.0:9580",
  #	 "udp://0.0.0.0:9531",
  ]
  ## glob filteer
  ignore = [""]

  ## Your logging source, if it's empty, use 'default'.
  source = "kong_tcp_log"

  ## Add service tag, if it's empty, use $source.
  service = ""

  ## Grok pipeline script name.
  pipeline = ""

  ## optional status:
  ##   "emerg","alert","critical","error","warning","info","debug","OK"
  ignore_status = []

  ## optional encodings:
  ##    "utf-8", "utf-16le", "utf-16be", "gbk", "gb18030" or ""
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

- 重启 DataKit

执行以下命令

```shell
datakit service -R
```
<!-- markdownlint-enable -->

### Pipeline

Pipeline 可用于日志的字段提取，kong 通过 tcp-log 上报 json 格式的日志，规则如下：

```python

kong_log_json = load_json(_)

add_key("url", kong_log_json["request"]["url"])
add_key("uri", kong_log_json["request"]["uri"])
add_key("method", kong_log_json["request"]["method"])
add_key("code", kong_log_json["response"]["status"])

add_key("kong_route", kong_log_json["route"]["name"])
add_key("kong_service", kong_log_json["service"]["name"])
add_key("client_ip", kong_log_json["client_ip"])
add_key("trace_id", kong_log_json["request"]["headers"]["traceparent"])
grok(trace_id, "%{DATA}-%{DATA:trace_id}-%{DATA}") 

add_key("status", "ok")

```

也可以按照实际需求进行增删处理。


