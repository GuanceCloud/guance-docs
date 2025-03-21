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

Expose Metrics information via `prometheus-exporter`, on port `8405` with path `/metrics`.

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

Since `Haproxy` can directly expose a `metrics` URL, it can be collected directly using the [`prom`](./prom.md) collector.

Navigate to the `conf.d/prom` directory under the [DataKit installation directory](./datakit_dir.md), and copy `prom.conf.sample` to `haproxy.conf`.

> `cp prom.conf.sample haproxy.conf`

Adjust the content of `haproxy.conf` as follows:

```toml

  urls = ["http://localhost:8405/metrics"]

  source = "haproxy"

  ## Keep Exist Metric Name
  ## If the keep_exist_metric_name is true, keep the raw value for field names.
  keep_exist_metric_name = true

  interval = "10s"

```

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations may need adjustment*</font>
<!-- markdownlint-enable -->
, parameter adjustment description:

<!-- markdownlint-disable MD004 -->
- urls: The Metrics address for `haproxy`, fill in the Metrics URL exposed by the corresponding component here.
- source: Collector alias, recommended for differentiation.
- keep_exist_metric_name: Preserve the Metrics name.
- interval: Collection interval.

<!-- markdownlint-enable -->
### 3. Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

### Haproxy Metrics Set

| Metrics | Description | Unit |
| -- | -- | -- |
|`haproxy_backend_bytes_in_total` |`Total backend bytes in` |byte |
|`haproxy_backend_bytes_out_total` |`Total backend bytes out` |byte |
|`haproxy_backend_client_aborts_total` |`Total backend client aborts` |count |
|`haproxy_backend_connect_time_average_seconds` |`Average backend connection time in seconds` |seconds |
|`haproxy_backend_connection_attempts_total` |`Total backend connection attempts` |count |
|`haproxy_backend_connection_errors_total` |`Total backend connection errors` |count |
|`haproxy_backend_connection_reuses_total` |`Total backend connection reuses` |count |
|`haproxy_backend_current_queue` |`Current backend queue` |count |
|`haproxy_backend_current_sessions` |`Current backend sessions` |count |
|`haproxy_backend_internal_errors_total` |`Total backend internal errors` |count |
|`haproxy_backend_loadbalanced_total` |`Total backend load balancing` |count |
|`haproxy_backend_max_queue` |`Maximum backend queue` |count |
|`haproxy_backend_max_sessions` |`Maximum backend sessions` |count |
|`haproxy_backend_requests_denied_total` |`Total backend requests denied` |count |
|`haproxy_backend_response_errors_total` |`Total backend response errors` |count |
|`haproxy_backend_responses_denied_total` |`Total backend responses denied` |count |
|`haproxy_backend_retry_warnings_total` |`Total backend retry warnings` |count |
|`haproxy_backend_server_aborts_total` |`Total backend server aborts` |count |
|`haproxy_backend_sessions_total` |`Total backend sessions` |count |
|`haproxy_frontend_bytes_in_total` |`Total frontend bytes in` |byte |
|`haproxy_frontend_bytes_out_total` |`Total frontend bytes out` |byte |
|`haproxy_frontend_connections_total` |`Total frontend connections` |count |
|`haproxy_frontend_current_sessions` |`Current frontend sessions` |count |
|`haproxy_frontend_denied_connections_total` |`Total frontend denied connections` |count |
|`haproxy_frontend_denied_sessions_total` |`Total frontend denied sessions` |count |
|`haproxy_frontend_intercepted_requests_total` |`Total frontend intercepted requests` |count |
|`haproxy_frontend_internal_errors_total` |`Total frontend internal errors` |count |
|`haproxy_frontend_limit_session_rate` |`Frontend session rate limit` |count |
|`haproxy_frontend_limit_sessions` |`Frontend session limit` |count |
|`haproxy_frontend_max_sessions` |`Maximum frontend sessions` |count |
|`haproxy_frontend_request_errors_total` |`Total frontend request errors` |count |
|`haproxy_frontend_requests_denied_total` |`Total frontend requests denied` |count |
|`haproxy_frontend_responses_denied_total` |`Total frontend responses denied` |count |
|`haproxy_frontend_sessions_total` |`Total frontend sessions` |count |
|`haproxy_server_bytes_in_total` |`Total server bytes in` |byte |
|`haproxy_server_bytes_out_total` |`Total server bytes out` |byte |
|`haproxy_server_response_errors_total` |`Total server response errors` |count |
|`haproxy_server_response_time_average_seconds` |`Average server response time in seconds` |seconds |
|`haproxy_server_responses_denied_total` |`Total server responses denied` |count |
|`haproxy_server_retry_warnings_total` |`Total server retry warnings` |count |
|`haproxy_server_safe_idle_connections_current` |`Current safe idle server connections` |count |
|`haproxy_server_server_aborts_total` |`Total server aborts` |count |
|`haproxy_server_sessions_total` |`Total server sessions` |count |
|`haproxy_server_used_connections_current` |`Current used server connections` |count |
|`haproxy_server_uweight` |`Server non-weight` |count |
|`haproxy_server_weight` |`Server weight` |count |

For more Metrics descriptions, refer to the [Haproxy official documentation](https://www.haproxy.com/documentation/haproxy-configuration-tutorials/alerts-and-monitoring/prometheus/#exported-metrics).