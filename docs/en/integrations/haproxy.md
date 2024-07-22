---
title     : 'Haproxy'
summary   : 'Collect metrics of Haproxy'
__int_icon: 'icon/haproxy'
dashboard :
  - desc  : 'Haproxy'
    path  : 'dashboard/en/haproxy'
---

<!-- markdownlint-disable MD025 -->
# Haproxy
<!-- markdownlint-enable -->

Collect metrics of Haproxy.

## Configuration {#config}

### Preconditions {#requirements}

- [x] HAProxy 2.0
- [x] HAProxy Enterprise 2.0r1
- [x] HAProxy ALOHA 11.5

### 1. Haproxy Enable Metrics

Adjust the Haproxy configuration file and add the following module configurations:

```toml
frontend prometheus
  bind *:8405
  mode http
  http-request use-service prometheus-exporter if { path /metrics }
  no log
......

```

Expose metric information through `prometheus-exporter` with port `8405` and path`/metrics`.

Restart the Haproxy service. Obtain metrics information by accessing port `8405`, as shown below:

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

#### 2.2 Configuration Collector

Because `Haproxy` can expose `metrics` URL directly, it can be collected directly through [`prom`](./prom.md) collector.

Enter `conf.d/prom` in the [DataKit installation directory](./datakit_dir.md) and copy `prom.conf.sample` to `haproxy.conf`.

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
<font color="red">*Other configurations are adjusted as needed*</font>
<!-- markdownlint-enable -->
, adjust parameter description:

<!-- markdownlint-disable MD004 -->
- Urls: `prometheus` Metric address, where you fill in the metric URL exposed by the corresponding component
- Source: Collector alias, recommended to distinguish
- Interval: collection interval

<!-- markdownlint-enable -->
### 3. Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metric {#metric}

### Haproxy Metrics

| Metric | Description | Unit |
| -- | -- |-- |
|`haproxy_backend_bytes_in_total`|`Total bytes in from backend`| byte  |
|`haproxy_backend_bytes_out_total`|`Total bytes out to backend`| byte  |
|`haproxy_backend_client_aborts_total`|`Total client aborts on backend`| count  |
|`haproxy_backend_connect_time_average_seconds`|`Average connection time on backend in seconds`| seconds  |
|`haproxy_backend_connection_attempts_total`|`Total connection attempts on backend`| count  |
|`haproxy_backend_connection_errors_total`|`Total connection errors on backend`| count  |
|`haproxy_backend_connection_reuses_total`|`Total connection reuses on backend`| count  |
|`haproxy_backend_current_queue`|`Current queue count on backend`| count  |
|`haproxy_backend_current_sessions`|`Current session count on backend`| count  |
|`haproxy_backend_internal_errors_total`|`Total internal errors on backend`| count  |
|`haproxy_backend_loadbalanced_total`|`Total load balanced on backend`| count  |
|`haproxy_backend_max_queue`|`Maximum queue count on backend`| count  |
|`haproxy_backend_max_sessions`|`Maximum session count on backend`| count  |
|`haproxy_backend_requests_denied_total`|`Total requests denied on backend`| count  |
|`haproxy_backend_response_errors_total`|`Total response errors on backend`| count  |
|`haproxy_backend_responses_denied_total`|`Total responses denied on backend`| count  |
|`haproxy_backend_retry_warnings_total`|`Total retry warnings on backend`| count  |
|`haproxy_backend_server_aborts_total`|`Total server aborts on backend`| count  |
|`haproxy_backend_sessions_total`|`Total sessions on backend`| count  |
|`haproxy_frontend_bytes_in_total`|`Total bytes in from frontend`| byte  |
|`haproxy_frontend_bytes_out_total`|`Total bytes out to frontend`| byte  |
|`haproxy_frontend_connections_total`|`Total connections on frontend`| count  |
|`haproxy_frontend_current_sessions`|`Current session count on frontend`| count  |
|`haproxy_frontend_denied_connections_total`|`Total denied connections on frontend`| count  |
|`haproxy_frontend_denied_sessions_total`|`Total denied sessions on frontend`| count  |
|`haproxy_frontend_intercepted_requests_total`|`Total intercepted requests on frontend`| count  |
|`haproxy_frontend_internal_errors_total`|`Total internal errors on frontend`| count  |
|`haproxy_frontend_limit_session_rate`|`Frontend session rate limit`| count  |
|`haproxy_frontend_limit_sessions`|`Frontend session limit`| count  |
|`haproxy_frontend_max_sessions`|`Maximum session count on frontend`| count  |
|`haproxy_frontend_request_errors_total`|`Total request errors on frontend`| count  |
|`haproxy_frontend_requests_denied_total`|`Total requests denied on frontend`| count  |
|`haproxy_frontend_responses_denied_total`|`Total responses denied on frontend`| count  |
|`haproxy_frontend_sessions_total`|`Total sessions on frontend`| count  |
|`haproxy_server_bytes_in_total`|`Total bytes in from server`| byte  |
|`haproxy_server_bytes_out_total`|`Total bytes out to server`| byte  |
|`haproxy_server_response_errors_total`|`Total response errors from server`| count  |
|`haproxy_server_response_time_average_seconds`|`Average response time from server in seconds`| seconds  |
|`haproxy_server_responses_denied_total`|`Total responses denied from server`| count  |
|`haproxy_server_retry_warnings_total`|`Total retry warnings from server`| count  |
|`haproxy_server_safe_idle_connections_current`|`Current safe idle connections on server`| count  |
|`haproxy_server_server_aborts_total`|`Total server aborts from server`| count  |
|`haproxy_server_sessions_total`|`Total sessions on server`| count  |
|`haproxy_server_used_connections_current`|`Current used connections on server`| count  |
|`haproxy_server_uweight`|`Server unweighted count`| count  |
|`haproxy_server_weight`|`Server weighted count`| count  |

For more metrics, refer to [the official haproxy document](https://www.haproxy.com/documentation/haproxy-configuration-tutorials/alerts-and-monitoring/prometheus/#exported-metrics)

