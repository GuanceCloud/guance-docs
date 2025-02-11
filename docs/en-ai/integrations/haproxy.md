---
title     : 'Haproxy'
summary   : 'Collect Haproxy Metrics information'
__int_icon: 'icon/haproxy'
dashboard :
  - desc  : 'Haproxy'
    path  : 'dashboard/en/haproxy'
---

<!-- markdownlint-disable MD025 -->
# Haproxy
<!-- markdownlint-enable -->

Collection of Haproxy Metrics information.

## Installation and Deployment {#config}

### Version Requirements

- [x] HAProxy 2.0
- [x] HAProxy Enterprise 2.0r1
- [x] HAProxy ALOHA 11.5

### 1. Enable Haproxy Metrics

Adjust the Haproxy configuration file by adding the following module configuration:

```toml
frontend prometheus
  bind *:8405
  mode http
  http-request use-service prometheus-exporter if { path /metrics }
  no log
......

```

Expose Metrics information via `prometheus-exporter` on port `8405` with path `/metrics`.

Restart the Haproxy service. Access port `8405` to retrieve Metrics information, as shown below:

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

### 2. DataKit Collector Configuration

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Configure the Collector

Since `Haproxy` can directly expose a `metrics` URL, it can be collected using the [`prom`](./prom.md) collector.

Navigate to the [DataKit installation directory](./datakit_dir.md) under `conf.d/prom`, copy `prom.conf.sample` to `haproxy.conf`.

> `cp prom.conf.sample haproxy.conf`

Modify the content of `haproxy.conf` as follows:

```toml

  urls = ["http://localhost:8405/metrics"]

  source = "haproxy"

  ## Keep Exist Metric Name
  ## If the keep_exist_metric_name is true, keep the raw value for field names.
  keep_exist_metric_name = true

  interval = "10s"

```

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations can be adjusted as needed*</font>
<!-- markdownlint-enable -->
Parameter adjustment explanation:

<!-- markdownlint-disable MD004 -->
- urls: The Metrics URL for `haproxy`, fill in the corresponding component's exposed Metrics URL
- source: Alias for the collector, recommended for differentiation
- keep_exist_metric_name: Keep the original metric name
- interval: Collection interval

<!-- markdownlint-enable -->
### 3. Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

### Haproxy Mearsurement Set

| Metrics | Description | Unit |
| -- | -- |-- |
|`haproxy_backend_bytes_in_total` | Total bytes received by backend | byte |
|`haproxy_backend_bytes_out_total` | Total bytes sent by backend | byte |
|`haproxy_backend_client_aborts_total` | Total client aborts in backend | count |
|`haproxy_backend_connect_time_average_seconds` | Average connection time in seconds for backend | seconds |
|`haproxy_backend_connection_attempts_total` | Total connection attempts in backend | count |
|`haproxy_backend_connection_errors_total` | Total connection errors in backend | count |
|`haproxy_backend_connection_reuses_total` | Total reused connections in backend | count |
|`haproxy_backend_current_queue` | Current queue size in backend | count |
|`haproxy_backend_current_sessions` | Current sessions in backend | count |
|`haproxy_backend_internal_errors_total` | Total internal errors in backend | count |
|`haproxy_backend_loadbalanced_total` | Total load balanced requests in backend | count |
|`haproxy_backend_max_queue` | Maximum queue size in backend | count |
|`haproxy_backend_max_sessions` | Maximum sessions in backend | count |
|`haproxy_backend_requests_denied_total` | Total denied requests in backend | count |
|`haproxy_backend_response_errors_total` | Total response errors in backend | count |
|`haproxy_backend_responses_denied_total` | Total denied responses in backend | count |
|`haproxy_backend_retry_warnings_total` | Total retry warnings in backend | count |
|`haproxy_backend_server_aborts_total` | Total server aborts in backend | count |
|`haproxy_backend_sessions_total` | Total sessions in backend | count |
|`haproxy_frontend_bytes_in_total` | Total bytes received by frontend | byte |
|`haproxy_frontend_bytes_out_total` | Total bytes sent by frontend | byte |
|`haproxy_frontend_connections_total` | Total connections in frontend | count |
|`haproxy_frontend_current_sessions` | Current sessions in frontend | count |
|`haproxy_frontend_denied_connections_total` | Total denied connections in frontend | count |
|`haproxy_frontend_denied_sessions_total` | Total denied sessions in frontend | count |
|`haproxy_frontend_intercepted_requests_total` | Total intercepted requests in frontend | count |
|`haproxy_frontend_internal_errors_total` | Total internal errors in frontend | count |
|`haproxy_frontend_limit_session_rate` | Session rate limit in frontend | count |
|`haproxy_frontend_limit_sessions` | Session limit in frontend | count |
|`haproxy_frontend_max_sessions` | Maximum sessions in frontend | count |
|`haproxy_frontend_request_errors_total` | Total request errors in frontend | count |
|`haproxy_frontend_requests_denied_total` | Total denied requests in frontend | count |
|`haproxy_frontend_responses_denied_total` | Total denied responses in frontend | count |
|`haproxy_frontend_sessions_total` | Total sessions in frontend | count |
|`haproxy_server_bytes_in_total` | Total bytes received by server | byte |
|`haproxy_server_bytes_out_total` | Total bytes sent by server | byte |
|`haproxy_server_response_errors_total` | Total response errors in server | count |
|`haproxy_server_response_time_average_seconds` | Average response time in seconds for server | seconds |
|`haproxy_server_responses_denied_total` | Total denied responses in server | count |
|`haproxy_server_retry_warnings_total` | Total retry warnings in server | count |
|`haproxy_server_safe_idle_connections_current` | Current safe idle connections in server | count |
|`haproxy_server_server_aborts_total` | Total server aborts in server | count |
|`haproxy_server_sessions_total` | Total sessions in server | count |
|`haproxy_server_used_connections_current` | Current used connections in server | count |
|`haproxy_server_uweight` | Server unweighted | count |
|`haproxy_server_weight` | Server weight | count |

For more details on Metrics, refer to the [official Haproxy documentation](https://www.haproxy.com/documentation/haproxy-configuration-tutorials/alerts-and-monitoring/prometheus/#exported-metrics).