---
title     : 'Apollo'
summary   : 'Collect Apollo related metrics information'
__int_icon: 'icon/apollo'
dashboard :
  - desc  : 'Apollo monitoring view'
    path  : 'dashboard/en/apollo'
monitor   :
  - desc  : 'Not exist'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Apollo
<!-- markdownlint-enable -->

Collect Apollo related metrics information.

## Installation Configuration {#config}

- [x] Apollo >= 1.5.0

### Apollo Metrics

The default metrics port exposed by Apollo is `8070`. You can view the metrics-related information via a browser: `http://clientIP:8070/prometheus`.

### DataKit Collector Configuration

Since `Apollo` can directly expose a `metrics` URL, it can be collected directly using the [`prom`](./prom.md) collector.



Adjust the content as follows:

```toml

  urls = ["http://clientIP:8070/prometheus"]

  source = "apollo"

  [inputs.prom.tags]
    component="apollo"
  interval = "10s"

```

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations can be adjusted as needed*</font>
<!-- markdownlint-enable -->
, parameter adjustment explanation:

<!-- markdownlint-disable MD004 -->
- urls: The `prometheus` metrics address, fill in the metrics URL exposed by the corresponding component here.
- source: Collector alias, recommended for differentiation.
- interval: Collection interval.

<!-- markdownlint-enable -->
### Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

### Tags

| Tags | Description |
| -- | -- |
| component | Component name `apollo` |


### Metric Set `jvm`

| Metrics | Description |
| -- | -- |
| threads_states_threads | Thread states |
| memory_used_bytes | Memory usage |


### Metric Set `jdbc`

| Metrics | Description |
| -- | -- |
| connections_idle | Idle connections |
| connections_active | Active connections |
| connections_max | Maximum active connections |
| connections_min | Minimum active connections |

### Metric Set `process`

| Metrics | Description |
| -- | -- |
| uptime_seconds | JVM uptime in seconds |

### Metric Set `system`

| Metrics | Description |
| -- | -- |
| cpu_usage | CPU usage |
| cpu_count | Number of available CPUs |

### Metric Set `http`

| Metrics | Description |
| -- | -- |
| server_requests_seconds_count | Number of requests per second for the service |
| cpu_count | Number of available CPUs |