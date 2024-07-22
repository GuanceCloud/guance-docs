---
title     : 'Haproxy'
summary   : '采集 Haproxy 指标信息'
__int_icon: 'icon/haproxy'
dashboard :
  - desc  : 'Haproxy'
    path  : 'dashboard/zh/haproxy'
---

<!-- markdownlint-disable MD025 -->
# Haproxy
<!-- markdownlint-enable -->

Haproxy 指标信息采集。

## 安装部署 {#config}

### 版本要求

- [x] HAProxy 2.0
- [x] HAProxy Enterprise 2.0r1
- [x] HAProxy ALOHA 11.5

### 1. Haproxy 开启指标

调整 Haproxy 配置文件，新增以下模块配置：

```toml
frontend prometheus
  bind *:8405
  mode http
  http-request use-service prometheus-exporter if { path /metrics }
  no log
......

```

通过`prometheus-exporter`暴露指标信息，端口为 `8405`，path为`/metrics`。

重启 Haproxy 服务。通过访问`8405`端口获取指标信息，如下所示：

```shell
# HELP haproxy_process_nbthread Number of started threads (global.nbthread)
# TYPE haproxy_process_nbthread gauge
haproxy_process_nbthread 8
# HELP haproxy_process_nbproc Number of started worker processes (historical, always 1)
# TYPE haproxy_process_nbproc gauge
haproxy_process_nbproc 1
# HELP haproxy_process_relative_process_id Relative worker process number (1)
# TYPE haproxy_process_relative_process_id gauge
haproxy_process_relative_process_id 1
# HELP haproxy_process_uptime_seconds How long ago this worker process was started (seconds)
# TYPE haproxy_process_uptime_seconds gauge
haproxy_process_uptime_seconds 1364
...
```

### 2. DataKit 采集器配置

#### 2.1 [安装 DataKit](../datakit/datakit-install.md)

#### 2.2 配置采集器

由于`Haproxy`能够直接暴露`metrics` url，所以可以直接通过[`prom`](./prom.md)采集器进行采集。

进入 [DataKit 安装目录](./datakit_dir.md)下的 `conf.d/prom` ，复制 `prom.conf.sample` 为 `haproxy.conf`。

> `cp prom.conf.sample haproxy.conf`

调整`haproxy.conf`内容如下：

```toml

  urls = ["http://localhost:8405/metrics"]

  source = "haproxy"

  ## Keep Exist Metric Name
  ## If the keep_exist_metric_name is true, keep the raw value for field names.
  keep_exist_metric_name = true

  interval = "10s"

```

<!-- markdownlint-disable MD033 -->
<font color="red">*其他配置按需调整*</font>
<!-- markdownlint-enable -->
，调整参数说明 ：

<!-- markdownlint-disable MD004 -->
- urls：`haproxy`指标地址，这里填写对应组件暴露出来的指标 url
- source：采集器别名，建议做区分
- keep_exist_metric_name: 保持指标名称
- interval：采集间隔

<!-- markdownlint-enable -->
### 3. 重启 DataKit

[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service)

## 指标 {#metric}

### haproxy 指标集

| Metrics | 描述 |单位 |
| -- | -- |-- |
|`haproxy_backend_bytes_in_total` |`后端总字节入` |byte |
|`haproxy_backend_bytes_out_total` |`后端总字节出` |byte |
|`haproxy_backend_client_aborts_total` |`后端客户端中断总数` |count |
|`haproxy_backend_connect_time_average_seconds` |`后端平均连接时间秒数` |seconds |
|`haproxy_backend_connection_attempts_total` |`后端连接尝试总数` |count |
|`haproxy_backend_connection_errors_total` |`后端连接错误总数` |count |
|`haproxy_backend_connection_reuses_total` |`后端连接重用总数` |count |
|`haproxy_backend_current_queue` |`后端当前队列` |count |
|`haproxy_backend_current_sessions` |`后端当前会话数` |count |
|`haproxy_backend_internal_errors_total` |`后端内部错误总数` |count |
|`haproxy_backend_loadbalanced_total` |`后端负载均衡总数` |count |
|`haproxy_backend_max_queue` |`后端最大队列` |count |
|`haproxy_backend_max_sessions` |`后端最大会话数` |count |
|`haproxy_backend_requests_denied_total` |`后端请求被拒绝总数` |count |
|`haproxy_backend_response_errors_total` |`后端响应错误总数` |count |
|`haproxy_backend_responses_denied_total` |`后端响应被拒绝总数` |count |
|`haproxy_backend_retry_warnings_total` |`后端重试警告总数` |count |
|`haproxy_backend_server_aborts_total` |`后端服务器中断总数` |count |
|`haproxy_backend_sessions_total` |`后端会话总数` |count |
|`haproxy_frontend_bytes_in_total` |`前端总字节入` |byte |
|`haproxy_frontend_bytes_out_total` |`前端总字节出` |byte |
|`haproxy_frontend_connections_total` |`前端连接总数` |count |
|`haproxy_frontend_current_sessions` |`前端当前会话数` |count |
|`haproxy_frontend_denied_connections_total` |`前端拒绝连接总数` |count |
|`haproxy_frontend_denied_sessions_total` |`前端拒绝会话总数` |count |
|`haproxy_frontend_intercepted_requests_total` |`前端拦截请求总数` |count |
|`haproxy_frontend_internal_errors_total` |`前端内部错误总数` |count |
|`haproxy_frontend_limit_session_rate` |`前端限制会话速率` |count |
|`haproxy_frontend_limit_sessions` |`前端限制会话数` |count |
|`haproxy_frontend_max_sessions` |`前端最大会话数` |count |
|`haproxy_frontend_request_errors_total` |`前端请求错误总数` |count |
|`haproxy_frontend_requests_denied_total` |`前端请求被拒绝总数` |count |
|`haproxy_frontend_responses_denied_total` |`前端响应被拒绝总数` |count |
|`haproxy_frontend_sessions_total` |`前端会话总数` |count |
|`haproxy_server_bytes_in_total` |`服务器总字节入` |byte |
|`haproxy_server_bytes_out_total` |`服务器总字节出` |byte |
|`haproxy_server_response_errors_total` |`服务器响应错误总数` |count |
|`haproxy_server_response_time_average_seconds` |`服务器平均响应时间秒数` |seconds |
|`haproxy_server_responses_denied_total` |`服务器响应被拒绝总数` |count |
|`haproxy_server_retry_warnings_total` |`服务器重试警告总数` |count |
|`haproxy_server_safe_idle_connections_current` |`服务器当前安全空闲连接数` |count |
|`haproxy_server_server_aborts_total` |`服务器服务器中断总数` |count |
|`haproxy_server_sessions_total` |`服务器会话总数` |count |
|`haproxy_server_used_connections_current` |`服务器当前已用连接数` |count |
|`haproxy_server_uweight` |`服务器非权重` |count |
|`haproxy_server_weight` |`服务器权重` |count |

更多指标说明，参考 [haproxy 官方文档](https://www.haproxy.com/documentation/haproxy-configuration-tutorials/alerts-and-monitoring/prometheus/#exported-metrics)。

