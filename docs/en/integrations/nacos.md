---
title     : 'Nacos'
summary   : 'Collect metrics related to Nacos'
__int_icon: 'icon/nacos'
dashboard :
  - desc  : 'Nacos'
    path  : 'dashboard/en/nacos'
monitor   :
  - desc  : 'Nacos'
    path  : 'monitor/en/nacos'
---

<!-- markdownlint-disable MD025 -->
# Nacos
<!-- markdownlint-enable -->


Display of Nacos performance metrics, including Nacos uptime, number of long connections in Nacos Config, number of configurations in Nacos Config, service count, HTTP request count, etc.


## Installation and Configuration {#config}

### Version Support

- Supported operating systems: Linux / Windows
- Nacos version: >= 0.8.0

Note: The example Nacos version is 1.4.1.

( Same for Linux / Windows environments)

### Metrics Collection (Required)

- Configure the `application.properties` file to expose metrics data

```shell
management.endpoints.web.exposure.include=*
```

- Restart Nacos

Cluster mode and standalone mode startup parameters differ; refer to the [Nacos official documentation](https://nacos.io/en-us/docs/quick-start.html).

- Verification

Access `{ip}:8848/nacos/actuator/prometheus` to check if you can access the metrics data.

- Enable DataKit Prometheus Plugin

```shell
cd /usr/local/datakit/conf.d/prom/
cp prom.conf.sample nacos-prom.conf
```

- Modify the `nacos-prom.conf` configuration file

Key parameter descriptions:

- urls: Prometheus metrics address, fill in the exposed metrics URL of Nacos.
- source: Collector alias, it is recommended to write `nacos`.
- interval: Collection interval.
- measurement_prefix: Metric prefix for easier metric classification queries.
- tls_open: TLS configuration.
- metric_types: Metric types, leave blank to collect all metrics.

```toml
[[inputs.prom]]
  urls = ["http://192.168.0.189:8848/nacos/actuator/prometheus"]
  ## Ignore request errors for URLs
  ignore_req_err = false
  ## Collector alias
  source = "nacos"
  metric_types = []
  measurement_prefix = "nacos_"
  ## Collection interval "ns", "us" (or "µs"), "ms", "s", "m", "h"
  interval = "10s"
  ## TLS configuration
  tls_open = false
  ## Custom Tags
  [inputs.prom.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
```

- Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics Details {#metric}

### JVM Metrics

| Metric | Meaning |
| --- | --- |
| system_cpu_usage | CPU usage rate |
| system_load_average_1m | Load average over 1 minute |
| jvm_memory_used_bytes | Memory usage in bytes, including various memory regions |
| jvm_memory_max_bytes | Maximum memory in bytes, including various memory regions |
| jvm_gc_pause_seconds_count | Number of GC pauses, including various GC types |
| jvm_gc_pause_seconds_sum | Total GC pause time, including various GC types |
| jvm_threads_daemon | Number of daemon threads |

### Nacos Monitoring Metrics

| Metric | Meaning |
| --- | --- |
| http_server_requests_seconds_count | Number of HTTP requests, including various (URL, method, code) |
| http_server_requests_seconds_sum | Total time spent on HTTP requests, including various (URL, method, code) |
| `nacos_timer_seconds_sum` | Time spent on Nacos config broadcast notifications |
| `nacos_timer_seconds_count` | Number of Nacos config broadcast notifications |
| `nacos_monitor{name='longPolling'}` | Number of long connections in Nacos Config |
| `nacos_monitor{name='configCount'}` | Number of configurations in Nacos Config |
| `nacos_monitor{name='dumpTask'}` | Number of pending tasks for writing configurations to disk in Nacos Config |
| `nacos_monitor{name='notifyTask'}` | Number of pending tasks for broadcast notifications in Nacos Config |
| `nacos_monitor{name='getConfig'}` | Number of times reading configurations in Nacos Config |
| `nacos_monitor{name='publish'}` | Number of times writing configurations in Nacos Config |
| `nacos_monitor{name='ipCount'}` | Number of IPs in Nacos Naming |
| `nacos_monitor{name='domCount'}` | Number of domains in Nacos Naming (version 1.x) |
| `nacos_monitor{name='serviceCount'}` | Number of services in Nacos Naming (version 2.x) |
| `nacos_monitor{name='failedPush'}` | Number of failed pushes in Nacos Naming |
| `nacos_monitor{name='avgPushCost'}` | Average push time in Nacos Naming |
| `nacos_monitor{name='leaderStatus'}` | Leader status in Nacos Naming |
| `nacos_monitor{name='maxPushCost'}` | Maximum push time in Nacos Naming |
| `nacos_monitor{name='mysqlhealthCheck'}` | Number of MySQL health checks in Nacos Naming |
| `nacos_monitor{name='httpHealthCheck'}` | Number of HTTP health checks in Nacos Naming |
| `nacos_monitor{name='tcpHealthCheck'}` | Number of TCP health checks in Nacos Naming |

### Nacos Exception Metrics

| Metric | Meaning |
| --- | --- |
| `nacos_exception_total{name='db'}` | Database exceptions |
| `nacos_exception_total{name='configNotify'}` | Failures in Nacos config broadcast notifications |
| `nacos_exception_total{name='unhealth'}` | Health check failures between Nacos config servers |
| `nacos_exception_total{name='disk'}` | Disk write exceptions in Nacos Naming |
| `nacos_exception_total{name='leaderSendBeatFailed'}` | Heartbeat sending failures from the leader in Nacos Naming |
| `nacos_exception_total{name='illegalArgument'}` | Invalid request parameters |
| `nacos_exception_total{name='nacos'}` | Internal errors in Nacos request responses (read/write failures, no permissions, parameter errors) |

For more Nacos metrics, refer to the [Nacos official website - Monitoring](https://nacos.io/en-us/docs/monitor-guide.html).
