---
title     : 'APISIX'
summary   : 'Collect APISIX related Metrics information'
__int_icon: 'icon/apisix'
dashboard :
  - desc  : 'APISIX monitoring view'
    path  : 'dashboard/en/apisix'
monitor   :
  - desc  : 'None for now'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# `APISIX`
<!-- markdownlint-enable -->

Collect `APISIX` related Metrics information.

## Installation and Configuration {#config}

### Prerequisites

- [x] Install `APISIX`
- [x] Install DataKit

### `APISIX` Metrics Integration

The `APISIX` component can expose `metrics` capabilities externally. By accessing `curl http://127.0.0.1:9091/apisix/prometheus/metrics`, you can obtain relevant Metrics information.

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

For more information, please refer to the [official documentation](https://apisix.apache.org/docs/apisix/plugins/prometheus/)

### DataKit Collector Configuration

Since `APISIX` can directly expose a `metrics` URL, it can be collected directly via the [`prom`](./prom.md) collector.

```toml
[[inputs.prom]]
  ## Exporter URLs.
  urls = ["http://localhost:9091/apisix/prometheus/metrics"]
...
```

### Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metric Details {#metric}

| Metric | Meaning |
| -- | -- |
| bandwidth | `APISIX` bandwidth (ingress/egress) |
| etcd_modify_indexes | Number of etcd index records |
| etcd_reachable | Availability of etcd, `1` means available, `0` means unavailable |
| http_latency_bucket | Service request time delay |
| http_latency_count | Number of service request time delays |
| http_latency_sum | Total number of service request time delays |
| http_requests_total | Total number of HTTP requests |
| http_status | HTTP status |
| nginx_http_current_connections | Current number of nginx connections |
| nginx_metric_errors_total | Total number of incorrect nginx metrics |
| node_info | Node information |
| shared_dict_capacity_bytes | Capacity of `APISIX` nginx |
| shared_dict_free_space_bytes | Available space of `APISIX` nginx |