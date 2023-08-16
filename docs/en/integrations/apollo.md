---
title     : 'Apollo'
summary   : 'Collect information about Apollo-related indicators'
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

Information on Apollo-related indicators was collected.

## Installation Configuration{#config}

- [x] Apollo >= 1.5.0


### Apollo Indicators

The default Exposure Indicator port for Apollo is: `8070`. Indicator-related information can be viewed through a browser: `http://clientIP:8070/prometheus`.

### DataKit Collector Configuration

Because `Apollo` can expose `metrics` URL directly, it can be collected directly through [ `prom`](./prom.md) collector.



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
- Urls: `prometheus` Indicator address, where you fill in the indicator URL exposed by the corresponding component
- Source: Collector alias, recommended to distinguish
- Interval: collection interval

<!-- markdownlint-enable -->
### Restart DataKit

[Restart DataKit] (.. /datakit/datakit-service-how-to.md/#manage-service)

## Metric {#metric}

### Tags

|Tags| Describe |
| -- | -- |
| component |Component name `apollo`|


### Indicator Set `jvm`

|Metrics| Describe |
| -- | -- |
|threads_states_threads| thread states |
|memory_used_bytes| memory used  |


### Indicator Set `jdbc`

|Metrics| Describe |
| -- | -- |
|connections_idle| idle connections  |
|connections_active| active connections |
|connections_max| max connections |
|connections_min| min connections |

### Indicator Set `process`

|Metrics| Describe |
| -- | -- |
|uptime_seconds| jvm start time |

### Indicator Set `system`

|Metrics| Describe |
| -- | -- |
|cpu_usage| cpu usage |
|cpu_count| cpu count |

### Indicator Set `http`

|Metrics| Describe |
| -- | -- |
|server_requests_seconds_count| server requests seconds count |
|cpu_count| cpu count |


