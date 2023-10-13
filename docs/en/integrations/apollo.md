---
title     : 'Apollo'
summary   : 'Collect information about Apollo-related metrics'
__int_icon: 'icon/apollo'
dashboard :
  - desc  : 'Apollo Monitoring View'
    path  : 'dashboard/zh/apollo'
monitor   :
  - desc  : 'No'
    path  : '-'
---



<!-- markdownlint-disable MD025 -->
# Apollo
<!-- markdownlint-enable -->

Information on Apollo-related metrics was collected.

## Installation Configuration{#config}

- [x] Apollo >= 1.5.0


### Apollo Metrics

The default Exposure Metric port for Apollo is: `8070`. Metric-related information can be viewed through a browser: `http://clientIP:8070/prometheus`.

### DataKit Collector Configuration

Because `Apollo` can expose `metrics` URL directly, it can be collected directly through [`prom`](./prom.md) collector.


The adjustments are as follows:

```toml

  urls = ["http://clientIP:8070/prometheus"]

  source = "apollo"

  [inputs.prom.tags]
    component="apollo"
  interval = "10s"

```

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations are adjusted as needed*</font>
<!-- markdownlint-enable -->
, adjust parameter description:

<!-- markdownlint-disable MD004 -->
- Urls: `prometheus` Metric address, where you fill in the metric URL exposed by the corresponding component
- Source: Collector alias, recommended to distinguish
- Interval: collection interval

<!-- markdownlint-enable -->
### Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metric {#metric}

### Tags

|Tags| Describe |
| -- | -- |
| component |Component name `apollo`|


### Metric Set `jvm`

|Metrics| Describe |
| -- | -- |
|threads_states_threads| thread states |
|memory_used_bytes| memory used  |


### Metric Set `jdbc`

|Metrics| Describe |
| -- | -- |
|connections_idle| idle connections  |
|connections_active| active connections |
|connections_max| max connections |
|connections_min| min connections |

### Metric Set `process`

|Metrics| Describe |
| -- | -- |
|uptime_seconds| jvm start time |

### Metric Set `system`

|Metrics| Describe |
| -- | -- |
|cpu_usage| cpu usage |
|cpu_count| cpu count |

### Metric Set `http`

|Metrics| Describe |
| -- | -- |
|server_requests_seconds_count| server requests seconds count |
|cpu_count| cpu count |


