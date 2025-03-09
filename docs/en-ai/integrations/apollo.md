---
title: 'Apollo'
summary: 'Collect Apollo-related Metrics information'
__int_icon: 'icon/apollo'
dashboard:
  - desc: 'Apollo monitoring view'
    path: 'dashboard/en/apollo'
monitor:
  - desc: 'None'
    path: '-'
---

<!-- markdownlint-disable MD025 -->
# Apollo
<!-- markdownlint-enable -->

Collect Apollo-related Metrics information.

## Installation and Configuration {#config}

- [x] Apollo >= 1.5.0

### Apollo Metrics

Apollo exposes the metrics port by default at `8070`. You can view the metrics information via a browser at `http://clientIP:8070/prometheus`.

### DataKit Collector Configuration

Since `Apollo` can directly expose a `metrics` URL, you can use the [`prom`](./prom.md) collector for data collection.

Adjust the content as follows:

```toml
urls = ["http://clientIP:8070/prometheus"]

source = "apollo"

[inputs.prom.tags]
  component = "apollo"
interval = "10s"
```

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations should be adjusted as needed*</font>
<!-- markdownlint-enable -->

Explanation of adjustable parameters:

<!-- markdownlint-disable MD004 -->
- urls: The `prometheus` metrics address; enter the metrics URL exposed by the corresponding component.
- source: Alias for the collector; it is recommended to differentiate it.
- interval: Collection interval

<!-- markdownlint-enable -->
### Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

### Tags

| Tags       | Description            |
| ---------- | ---------------------- |
| component  | Component name `apollo` |

### Metrics Set `jvm`

| Metrics               | Description          |
| --------------------- | -------------------- |
| threads_states_threads | Thread states        |
| memory_used_bytes     | Memory usage         |

### Metrics Set `jdbc`

| Metrics             | Description    |
| ------------------- | -------------- |
| connections_idle    | Idle connections |
| connections_active  | Active connections |
| connections_max     | Maximum connections |
| connections_min     | Minimum connections |

### Metrics Set `process`

| Metrics           | Description      |
| ----------------- | ---------------- |
| uptime_seconds    | JVM uptime in seconds |

### Metrics Set `system`

| Metrics      | Description      |
| ------------ | ---------------- |
| cpu_usage    | CPU usage rate   |
| cpu_count    | Available CPUs   |

### Metrics Set `http`

| Metrics                       | Description      |
| ----------------------------- | ---------------- |
| server_requests_seconds_count  | Requests per second |
| cpu_count                     | Available CPUs   |