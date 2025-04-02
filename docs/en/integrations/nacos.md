---
title     : 'Nacos'
summary   : 'Collect information related to Nacos Metrics'
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


Display of Nacos performance metrics, including Nacos uptime, the number of long connections for Nacos Config, the number of configurations for Nacos Config, Service Count, HTTP request counts, and more.


## Installation Configuration {#config}

### Version Support

- Operating system support: Linux / Windows
- Nacos version: >= 0.8.0

Note: The example Nacos version is 1.4.1.

( Same environment for Linux / Windows )

### Metrics Collection (Required)

- Configure the `application.properties` file to expose metrics data

```shell
management.endpoints.web.exposure.include=*
```

- Restart Nacos

Cluster mode and singleton mode startup parameters differ; refer specifically to the [Nacos Official Documentation](https://nacos.io/en-us/docs/quick-start.html).

- Verification

Access `{ip}:8848/nacos/actuator/prometheus` to check if you can access the metrics data.

- Enable DataKit Prometheus Plugin

```shell
cd /usr/local/datakit/conf.d/prom/
cp prom.conf.sample nacos-prom.conf
```

- Modify the `nacos-prom.conf` configuration file

Key parameter descriptions:

- urls: `prometheus` metric address, fill in the metric url exposed by Nacos here.
- source: collector alias, it is recommended to use `nacos`.
- interval: collection interval.
- measurement_prefix: metric prefix for easier metric classification queries.
- tls_open: TLS configuration.
- metric_types: metric types, leave blank to collect all metrics.

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

## Detailed Metrics {#metric}

### JVM Metrics

| Metric | Meaning |
| --- | --- |
| system_cpu_usage | CPU usage rate |
| system_load_average_1m | Load average |
| jvm_memory_used_bytes | Memory used bytes, includes various memory areas |
| jvm_memory_max_bytes | Maximum memory bytes, includes various memory areas |
| jvm_gc_pause_seconds_count | GC count, includes various GC |
| jvm_gc_pause_seconds_sum | GC time consumption, includes various GC |
| jvm_threads_daemon | Daemon thread count |

### Nacos Monitoring Metrics

| Metric | Meaning |
| --- | --- |
| http_server_requests_seconds_count | HTTP request count, includes multiple (url, method, code) |
| http_server_requests_seconds_sum | Total HTTP request time, includes multiple (url, method, code) |
| `nacos_timer_seconds_sum` | Time consumed by Nacos config level notifications |
| `nacos_timer_seconds_count` | Number of Nacos config level notifications |
| `nacos_monitor{name='longPolling'}` | Number of Nacos config long connections |
| `nacos_monitor{name='configCount'}` | Number of Nacos config configurations |
| `nacos_monitor{name='dumpTask'}` | Number of accumulated tasks for Nacos config configuration disk writing |
| `nacos_monitor{name='notifyTask'}` | Number of accumulated tasks for Nacos config level notifications |
| `nacos_monitor{name='getConfig'}` | Statistics on reading Nacos config configurations |
| `nacos_monitor{name='publish'}` | Statistics on writing Nacos config configurations |
| `nacos_monitor{name='ipCount'}` | Number of IPs in Nacos naming |
| `nacos_monitor{name='domCount'}` | Number of domains in Nacos naming (1.x version) |
| `nacos_monitor{name='serviceCount'}` | Number of domains in Nacos naming (2.x version) |
| `nacos_monitor{name='failedPush'}` | Number of failed pushes in Nacos naming |
| `nacos_monitor{name='avgPushCost'}` | Average push time in Nacos naming |
| `nacos_monitor{name='leaderStatus'}` | Role status in Nacos naming |
| `nacos_monitor{name='maxPushCost'}` | Maximum push time in Nacos naming |
| `nacos_monitor{name='mysqlhealthCheck'}` | Number of MySQL health checks in Nacos naming |
| `nacos_monitor{name='httpHealthCheck'}` | Number of HTTP health checks in Nacos naming |
| `nacos_monitor{name='tcpHealthCheck'}` | Number of TCP health checks in Nacos naming |

### Nacos Exception Metrics

| Metric | Meaning |
| --- | --- |
| `nacos_exception_total{name='db'}` | Database exceptions |
| `nacos_exception_total{name='configNotify'}` | Nacos config level notification failure |
| `nacos_exception_total{name='unhealth'}` | Health check exceptions between Nacos config servers |
| `nacos_exception_total{name='disk'}` | Disk write exceptions in Nacos naming |
| `nacos_exception_total{name='leaderSendBeatFailed'}` | Leader heartbeat sending exceptions in Nacos naming |
| `nacos_exception_total{name='illegalArgument'}` | Invalid request parameters |
| `nacos_exception_total{name='nacos'}` | Internal error exceptions in Nacos request responses (read/write failures, no permissions, invalid parameters) |


For more Nacos metrics, refer to the [Nacos Official Website - Monitoring](https://nacos.io/en-us/docs/monitor-guide.html)

<<<% if custom_key.brand_key == "guance" %>>>
## Best Practices {#best-practices}
<div class="grid cards" data-href="https://learning.guance.com/uploads/banner_f446194a3c.png" data-title="Best Practices for Nacos Observability" data-desc=" This article introduces how to collect Nacos metric data via <<< custom_key.brand_name >>>, monitor the operation status of Nacos, and ensure service stability and reliability."  markdown>
<[Best Practices for Nacos Observability](https://<<< custom_key.brand_main_domain >>>/learn/articles/nacos){:target="_blank"}>
</div>
<<<% endif %>>>