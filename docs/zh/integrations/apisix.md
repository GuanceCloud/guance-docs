---
title     : 'APISIX'
summary   : '采集 APISIX 相关指标信息'
__int_icon: 'icon/apisix'
dashboard :
  - desc  : 'APISIX 监控视图'
    path  : 'dashboard/zh/apisix'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# `APISIX`
<!-- markdownlint-enable -->

采集 `APISIX` 相关指标信息。

## 安装配置 {#config}

### 前提条件

- [x] 安装 `APISIX`
- [x] 安装 DataKit

### `APISIX` 指标接入

`APISIX` 组件对外可以暴露 `metrics` 能力，通过访问 `curl http://127.0.0.1:9091/apisix/prometheus/metrics` 即可获取相关指标信息。

```log
...
# HELP apisix_bandwidth Total bandwidth in bytes consumed per service in APISIX
# TYPE apisix_bandwidth counter
apisix_bandwidth{type="egress",route="490244363826234050",service="",consumer="",node="192.168.2.114"} 4014
apisix_bandwidth{type="ingress",route="490244363826234050",service="",consumer="",node="192.168.2.114"} 17421
# HELP apisix_etcd_modify_indexes Etcd modify index for APISIX keys
# TYPE apisix_etcd_modify_indexes gauge
apisix_etcd_modify_indexes{key="consumers"} 0
apisix_etcd_modify_indexes{key="global_rules"} 19
apisix_etcd_modify_indexes{key="max_modify_index"} 19
apisix_etcd_modify_indexes{key="prev_index"} 19
apisix_etcd_modify_indexes{key="protos"} 0
apisix_etcd_modify_indexes{key="routes"} 0
apisix_etcd_modify_indexes{key="services"} 0
apisix_etcd_modify_indexes{key="ssls"} 0
apisix_etcd_modify_indexes{key="stream_routes"} 0
apisix_etcd_modify_indexes{key="upstreams"} 0
apisix_etcd_modify_indexes{key="x_etcd_index"} 19
...
```

需要了解更多信息，请参考[官方文档](https://apisix.apache.org/docs/apisix/plugins/prometheus/)

### DataKit 采集器配置

由于 `APISIX` 能够直接暴露`metrics` url，所以可以直接通过[`prom`](./prom.md)采集器进行采集。

```toml
[[inputs.prom]]
  ## Exporter URLs.
  urls = ["http://localhost:9091/apisix/prometheus/metrics"]
...
```

### 重启 DataKit

[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service)

## 指标详解 {#metric}

| 指标 | 含义 |
| -- | -- |
| bandwidth | `APISIX` 流量（ingress/egress） |
| etcd_modify_indexes | etcd 索引记录数 |
| etcd_reachable | etcd 可用性，`1`表示可用，`0`表示不可用 |
| http_latency_bucket | 服务的请求时间延迟 |
| http_latency_count | 服务的请求时间延迟数量 |
| http_latency_sum | 服务的请求时间延迟总数 |
| http_requests_total | http 请求总数 |
| http_status | http 状态 |
| nginx_http_current_connections | 当前 nginx 的链接数 |
| nginx_metric_errors_total | nginx 错误的指标数 |
| node_info | 节点信息 |
| shared_dict_capacity_bytes | `APISIX` nginx 的容量 |
| shared_dict_free_space_bytes | `APISIX` nginx 的可用空间|
