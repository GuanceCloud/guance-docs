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


Display of Nacos performance metrics, including Nacos uptime, number of long connections in Nacos Config, number of configurations in Nacos Config, service count, HTTP request counts, etc.


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

The startup parameters differ between cluster mode and standalone mode; refer to the [Nacos official documentation](https://nacos.io/en-us/docs/quick-start.html).

- Verification

Access `{ip}:8848/nacos/actuator/prometheus` to check if metrics data can be accessed

- Enable DataKit Prometheus Plugin

```shell
cd /usr/local/datakit/conf.d/prom/
cp prom.conf.sample nacos-prom.conf
```

- Modify the `nacos-prom.conf` configuration file

Key parameter descriptions:

- urls: Prometheus metrics address, fill in the exposed metrics URL of Nacos
- source: Collector alias, recommended to be `nacos`
- interval: Collection interval
- measurement_prefix: Metric prefix for easier classification and querying of metrics
- tls_open: TLS configuration
- metric_types: Types of metrics, leave blank to collect all metrics

```toml
[[inputs.prom]]
  urls = ["http://192.168.0.189:8848/nacos/actuator/prometheus"]
  ## Ignore request errors to URLs
  ignore_req_err = false
  ## Collector alias
  source = "nacos"
  metric_types = []
  measurement_prefix = "nacos_"
  ## Collection interval "ns", "us" (or "µs"), "ms", "s", "m", "h"
  interval = "10s"
  ## TLS configuration
  tls_open = false
  ## Custom tags
  [inputs.prom.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
```

- Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics Details {#metric}

### JVM Metrics

| Metric | Description |
| --- | --- |
| system_cpu_usage | CPU usage |
| system_load_average_1m | Load average over 1 minute |
| jvm_memory_used_bytes | Used memory bytes, including various memory regions |
| jvm_memory_max_bytes | Maximum memory bytes, including various memory regions |
| jvm_gc_pause_seconds_count | GC count, including various types of GC |
| jvm_gc_pause_seconds_sum | Total GC time, including various types of GC |
| jvm_threads_daemon | Number of daemon threads |

### Nacos Monitoring Metrics

| Metric | Description |
| --- | --- |
| http_server_requests_seconds_count | HTTP request count, including various (URL, method, code) |
| http_server_requests_seconds_sum | Total HTTP request time, including various (URL, method, code) |
| `nacos_timer_seconds_sum` | Time taken for Nacos config horizontal notifications |
| `nacos_timer_seconds_count` | Number of Nacos config horizontal notifications |
| `nacos_monitor{name='longPolling'}` | Number of long connections in Nacos Config |
| `nacos_monitor{name='configCount'}` | Number of configurations in Nacos Config |
| `nacos_monitor{name='dumpTask'}` | Number of pending tasks for dumping Nacos Config |
| `nacos_monitor{name='notifyTask'}` | Number of pending tasks for Nacos Config horizontal notifications |
| `nacos_monitor{name='getConfig'}` | Statistics on reading Nacos Config |
| `nacos_monitor{name='publish'}` | Statistics on writing Nacos Config |
| `nacos_monitor{name='ipCount'}` | Number of IPs in Nacos naming |
| `nacos_monitor{name='domCount'}` | Number of domains in Nacos naming (version 1.x) |
| `nacos_monitor{name='serviceCount'}` | Number of services in Nacos naming (version 2.x) |
| `nacos_monitor{name='failedPush'}` | Number of failed pushes in Nacos naming |
| `nacos_monitor{name='avgPushCost'}` | Average push time in Nacos naming |
| `nacos_monitor{name='leaderStatus'}` | Leader status in Nacos naming |
| `nacos_monitor{name='maxPushCost'}` | Maximum push time in Nacos naming |
| `nacos_monitor{name='mysqlhealthCheck'}` | Number of MySQL health checks in Nacos naming |
| `nacos_monitor{name='httpHealthCheck'}` | Number of HTTP health checks in Nacos naming |
| `nacos_monitor{name='tcpHealthCheck'}` | Number of TCP health checks in Nacos naming |

### Nacos Exception Metrics

| Metric | Description |
| --- | --- |
| `nacos_exception_total{name='db'}` | Database exceptions |
| `nacos_exception_total{name='configNotify'}` | Failures in Nacos config horizontal notifications |
| `nacos_exception_total{name='unhealth'}` | Health check failures between Nacos config servers |
| `nacos_exception_total{name='disk'}` | Disk write exceptions in Nacos naming |
| `nacos_exception_total{name='leaderSendBeatFailed'}` | Heartbeat send failures from the leader in Nacos naming |
| `nacos_exception_total{name='illegalArgument'}` | Invalid request parameters |
| `nacos_exception_total{name='nacos'}` | Internal error exceptions in Nacos requests (read/write failures, no permissions, parameter errors) |

For more Nacos metrics, refer to the [Nacos official website - Monitoring](https://nacos.io/en-us/docs/monitor-guide.html)