---
title     : 'Nacos'
summary   : 'Collect Nacos related Metrics information'
__int_icon: 'icon/nacos'
dashboard :
  - desc  : 'Nacos'
    path  : 'dashboard/en/nacos'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Nacos
<!-- markdownlint-enable -->


Nacos performance Metrics display, including Nacos uptime, Nacos Config long connection count, Nacos Config configuration count, Service Count, HTTP request count, etc.


## Installation and Configuration {#config}

### Version Support

- Operating system support: Linux / Windows
- Nacos version: >= 0.8.0

Note: The example Nacos version is 1.4.1.

( Linux / Windows environment is the same )

### Metrics Collection (Required)

- Configure the `application.properties` file to expose metrics data

```shell
management.endpoints.web.exposure.include=*
```

- Restart Nacos

Cluster mode and singleton mode startup parameters differ; for more details, refer to the [Nacos official documentation](https://nacos.io/en-us/docs/quick-start.html).

- Verification

Access `{ip}:8848/nacos/actuator/prometheus` to check if you can access the metrics data.

- Enable DataKit Prometheus Plugin

```shell
cd /usr/local/datakit/conf.d/prom/
cp prom.conf.sample nacos-prom.conf
```

- Modify the `nacos-prom.conf` configuration file

Key parameter explanations:

- urls: `prometheus` Metrics address, fill in the Metrics url exposed by Nacos here.
- source: Collector alias, it's recommended to name it `nacos`.
- interval: Collection interval.
- measurement_prefix: Metrics prefix, used for easy classification and querying of Metrics.
- tls_open: TLS configuration.
- metric_types: Metrics types, leave blank to collect all Metrics.

```toml
[[inputs.prom]]
  urls = ["http://192.168.0.189:8848/nacos/actuator/prometheus"]
  ## Ignore request errors for the url
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

| Metrics | Meaning |
| --- | --- |
| system_cpu_usage | CPU usage rate |
| system_load_average_1m | load |
| jvm_memory_used_bytes | Memory usage in bytes, includes various memory areas |
| jvm_memory_max_bytes | Maximum memory in bytes, includes various memory areas |
| jvm_gc_pause_seconds_count | GC count, includes various GCs |
| jvm_gc_pause_seconds_sum | GC duration, includes various GCs |
| jvm_threads_daemon | Daemon thread count |

### Nacos Monitoring Metrics

| Metrics | Meaning |
| --- | --- |
| http_server_requests_seconds_count | HTTP request count, including multiple (url, method, code) |
| http_server_requests_seconds_sum | Total HTTP request duration, including multiple (url, method, code) |
| `nacos_timer_seconds_sum` | Nacos config horizontal notification duration |
| `nacos_timer_seconds_count` | Nacos config horizontal notification count |
| `nacos_monitor{name='longPolling'}` | Nacos config long connection count |
| `nacos_monitor{name='configCount'}` | Nacos config configuration count |
| `nacos_monitor{name='dumpTask'}` | Nacos config configuration disk dump task backlog count |
| `nacos_monitor{name='notifyTask'}` | Nacos config horizontal notification task backlog count |
| `nacos_monitor{name='getConfig'}` | Nacos config read configuration statistics count |
| `nacos_monitor{name='publish'}` | Nacos config write configuration statistics count |
| `nacos_monitor{name='ipCount'}` | Nacos naming IP count |
| `nacos_monitor{name='domCount'}` | Nacos naming domain count (1.x version) |
| `nacos_monitor{name='serviceCount'}` | Nacos naming domain count (2.x version) |
| `nacos_monitor{name='failedPush'}` | Nacos naming push failure count |
| `nacos_monitor{name='avgPushCost'}` | Nacos naming average push duration |
| `nacos_monitor{name='leaderStatus'}` | Nacos naming role status |
| `nacos_monitor{name='maxPushCost'}` | Nacos naming maximum push duration |
| `nacos_monitor{name='mysqlhealthCheck'}` | Nacos naming MySQL health check count |
| `nacos_monitor{name='httpHealthCheck'}` | Nacos naming HTTP health check count |
| `nacos_monitor{name='tcpHealthCheck'}` | Nacos naming TCP health check count |

### Nacos Exception Metrics

| Metrics | Meaning |
| --- | --- |
| `nacos_exception_total{name='db'}` | Database exceptions |
| `nacos_exception_total{name='configNotify'}` | Nacos config horizontal notification failures |
| `nacos_exception_total{name='unhealth'}` | Nacos config server health check exceptions between servers |
| `nacos_exception_total{name='disk'}` | Nacos naming disk write exceptions |
| `nacos_exception_total{name='leaderSendBeatFailed'}` | Nacos naming leader heartbeat send exceptions |
| `nacos_exception_total{name='illegalArgument'}` | Invalid request parameters |
| `nacos_exception_total{name='nacos'}` | Nacos request internal error exceptions (read/write failures, no permissions, invalid parameters) |


For more Nacos Metrics, refer to the [Nacos Official Website - Monitoring](https://nacos.io/en-us/docs/monitor-guide.html)
