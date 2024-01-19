---
title     : 'Nacos'
summary   : 'Collect Nacos related index information'
__int_icon: 'icon/nacos'
dashboard :
  - desc  : 'Nacos'
    path  : 'dashboard/en/nacos'
monitor   :
  - desc  : 'No'
    path  : '-'
---


<!-- markdownlint-disable MD025 -->
# Nacos
<!-- markdownlint-enable -->


Nacos performance metrics, including Nacos online length, Nacos Config long links, Nacos Config configuration number, Service Count, HTTP requests, and so on.


## Configuration {#config}

### Version support

- Operating system support: Linux / Windows
- Nacos version: >= 0.8.0

Description: Example Nacos version 1.4.1.

(same Linux / Windows environment)

### Metric Collection (Required)

- Configure `application.properties` files to expose metrics data

```shell
management.endpoints.web.exposure.include=*
```

- Restart Nacos

There are differences between cluster mode and singleton mode start parameters, refer to [Nacos 官方文档](https://nacos.io/zh-cn/docs/quick-start.html).

- Verification

Visit `{ip}:8848/nacos/actuator/prometheus` to see if metrics data is accessible

- Open the DataKit Prometheus plug-in

```shell
cd /usr/local/datakit/conf.d/prom/
cp prom.conf.sample nacos-prom.conf
```

- Modify `nacos-prom.conf` Profile

Description of main parameters

- Urls: `prometheus` Metric address, fill in the metric URL exposed by Nacos here
- Source: alias of collector, recommended as `nacos`
- Interval: collection interval
- Measurement_ Prefix: index prefix for easy index classification query
- Tls_ Open:TLS Configuration
- Metric_ Types: Metric type, not filled in, representing the collection of all metrics

```toml
[[inputs.prom]]
  urls = ["http://192.168.0.189:8848/nacos/actuator/prometheus"]

  ignore_req_err = false

  source = "nacos"
  metric_types = []
  measurement_prefix = "nacos_"

  interval = "10s"

  tls_open = false

  [inputs.prom.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
```

- Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metric {#metric}

### JVM metrics

|Metric| Description |
| --- | --- |
|system_cpu_usage| system cpu usage |
|system_load_average_1m| system load average 1m |
|jvm_memory_used_bytes| jvm memory used bytes |
|jvm_memory_max_bytes| jvm memory max bytes |
|jvm_gc_pause_seconds_count| jvm gc pause seconds count |
|jvm_gc_pause_seconds_sum| jvm gc pause seconds sum |
|jvm_threads_daemon| jvm threads daemon |

### Nacos Monitoring Metric

|Metric| Description |
| --- | --- |
|http_server_requests_seconds_count| http server requests count (by url、func、code) |
|http_server_requests_seconds_sum| http server requests sum (by url、func、code) |
| `nacos_timer_seconds_sum`| Nacos config notify duration |
| `nacos_timer_seconds_count`| Nacos config notify count |
| `nacos_monitor {name='longPolling'}`| Nacos config long poll |
| `nacos_monitor {name='configCount'}`| Nacos config count |
| `nacos_monitor {name='dumpTask'}`| Nacos config dump task count |
| `nacos_monitor {name='notifyTask'}`| Nacos config  notify task count|
| `nacos_monitor {name='getConfig'}`| Nacos config get  count |
| `nacos_monitor {name='publish'}`| Nacos config publish count |
| `nacos_monitor {name='ipCount'}`| Nacos naming ip count |
| `nacos_monitor {name='domCount'}`| Nacos naming domain count (1.x version) |
| `nacos_monitor {name='serviceCount'}`| Nacos naming domain count (2.x version) |
| `nacos_monitor {name='failedPush'}`| Nacos naming  push failed|
| `nacos_monitor {name='avgPushCost'}`| Nacos naming push cost by avg |
| `nacos_monitor {name='leaderStatus'}`| Nacos naming leader status |
| `nacos_monitor {name='maxPushCost'}`| Nacos naming max push cost time |
| `nacos_monitor {name='mysqlhealthCheck'}`| Nacos naming mysql health check time |
| `nacos_monitor {name='httpHealthCheck'}`| Nacos naming http health check time  |
| `nacos_monitor {name='tcpHealthCheck'}`| Nacos naming tcp health check time  |

### Nacos exception Metric

|Metric| Description |
| --- | --- |
| `nacos_exception_total {name='db'}`| db exception count |
| `nacos_exception_total {name='configNotify'}`| Nacos config notify exception count |
| `nacos_exception_total {name='unhealth'}`| Nacos config server unHealth count |
| `nacos_exception_total {name='disk'}`| Nacos naming disk write error count |
| `nacos_exception_total {name='leaderSendBeatFailed'}`| Nacos naming leader send beat error count |
| `nacos_exception_total {name='illegalArgument'}`| illegal argument count |
| `nacos_exception_total {name='nacos'}`| Nacos Request response internal error exception (read write failure, no permission, parameter error) |


For more Nacos metrics, refer to [Nacos Official Website - Monitoring](https://nacos.io/zh-cn/docs/monitor-guide.html)
