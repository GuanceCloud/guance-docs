---
title: 'Apollo'
summary: 'Collect Apollo related Metrics information'
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

Collect Apollo related Metrics information.

## Installation and Configuration {#config}

- [x] Apollo >= 1.5.0

### Apollo Metrics

Apollo exposes metrics on port `8070` by default, which can be viewed via a browser at: `http://clientIP:8070/prometheus`.

### DataKit Collector Configuration

Since `Apollo` can directly expose a `metrics` URL, it can be collected using the [`prom`](./prom.md) collector.

The configuration changes are as follows:

```toml
urls = ["http://clientIP:8070/prometheus"]

source = "apollo"

[inputs.prom.tags]
  component = "apollo"
interval = "10s"
```

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations can be adjusted as needed*</font>
<!-- markdownlint-enable -->

Parameter adjustment explanation:

<!-- markdownlint-disable MD004 -->
- urls: The `prometheus` Metrics address; enter the URL exposed by the corresponding component.
- source: Alias for the collector; it is recommended to differentiate it.
- interval: Collection interval.

<!-- markdownlint-enable -->
### Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

### Tags

| Tags       | Description        |
|------------|--------------------|
| component  | Component name `apollo` |

### Mearsurement `jvm`

| Metrics                | Description     |
|------------------------|-----------------|
| threads_states_threads | Thread states   |
| memory_used_bytes      | Memory usage    |

### Mearsurement `jdbc`

| Metrics             | Description   |
|---------------------|---------------|
| connections_idle    | Idle connections |
| connections_active  | Active connections |
| connections_max     | Maximum connections |
| connections_min     | Minimum connections |

### Mearsasurement `process`

| Metrics           | Description   |
|-------------------|---------------|
| uptime_seconds    | JVM uptime in seconds |

### Mearsurement `system`

| Metrics     | Description   |
|-------------|---------------|
| cpu_usage   | CPU usage rate |
| cpu_count   | Available CPUs |

### Mearsurement `http`

| Metrics                      | Description         |
|------------------------------|---------------------|
| server_requests_seconds_count | Server requests per second |
| cpu_count                    | Available CPUs |

Note: There seems to be a repetition of `cpu_count` under both `system` and `http` sections. Please verify the source content for accuracy.