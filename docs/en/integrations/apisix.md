---
Title:'APISIX'
summary:'Collecting APISIX metric information'
__int_icon: 'icon/apisix'
dashboard:
  - Desc:'APISIX Monitoring View'
    path:'dashboard/en/apisix'
monitor   :
  - Desc:'No'
    path:'-'
---


<!-- markdownlint-disable MD025 -->
# `APISIX`
<!-- markdownlint-enable -->

Collecting `APISIX` metric information。

## Installation Configuration{#config}

### Preconditions

- [x] Installed `APISIX`
- [x] Installed DataKit

### `APISIX` Metric

`APISIX` components can expose metrics capabilities externally by accessing `curl http://127.0.0.1:9091/apisix/prometheus/metrics` You can obtain relevant metric information.

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

For more information, please refer to [the official document](https://apisix.apache.org/docs/apisix/plugins/prometheus/)

### DataKit configure

Because `APISIX` can expose `metrics` URL directly, it can be collected directly through [`prom`](./prom.md) collector.


```toml
[[inputs.prom]]
  ## Exporter URLs.
  urls = ["http://localhost:9091/apisix/prometheus/metrics"]
...
```

### Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metric {#metric}

|Tags| Describe |
| -- | -- |
| bandwidth | Total amount of traffic (ingress and egress) flowing through `APISIX`. Total bandwidth of a service can also be obtained |
| etcd_modify_indexes | etcd modify indexes |
| etcd_reachable | A gauge type representing whether etcd can be reached by `APISIX`. A value of 1 represents reachable and 0 represents unreachable. |
| http_latency_bucket | Histogram of the request time per service |
| http_latency_count | Total count  of the request time per service |
| http_latency_sum | Sum of the request time per service |
| http_requests_total | Total count of http requests |
| http_status | http status |
| nginx_http_current_connections | Nginx connection metrics like active, reading, writing, and number of accepted connections. |
| nginx_metric_errors_total | nginx error count |
| node_info | Information about the `APISIX` node.  |
| shared_dict_capacity_bytes |  The capacity space of all nginx.shared.DICT in `APISIX`. |
| shared_dict_free_space_bytes |  The free space of all nginx.shared.DICT in `APISIX`. |
