---
title     : 'Seata'
summary   : 'Collect Seata related Metrics information'
__int_icon: 'icon/seata'
dashboard :
  - desc  : 'Seata monitoring view'
    path  : 'dashboard/en/seata'
monitor   :
  - desc  : 'None'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Seata
<!-- markdownlint-enable -->

## Deployment and Implementation {#config}

Seata supports enabling Metrics data collection in TC and outputting it to the Prometheus monitoring system.

### Enable Seata Metrics

- To enable Metrics in TC, configure the Metrics settings in TC. The Seata Server already includes the Metrics (`seata-metrics-all`) dependency, but it is disabled by default. You need to enable the metrics collection configuration. (**This step is very important**)

For `Seata 1.5.0+`, use `application.yaml`

```shell
seata:
  metrics:
    enabled: true
    registry-type: compact
    exporter-list: prometheus
    exporter-prometheus-port: 9898
```

For `Seata <1.5.0`, enable `metrics`

GitHub configuration link: [https://github.com/seata/seata/blob/1.4.2/server/src/main/resources/file.conf.example](https://github.com/seata/seata/blob/1.4.2/server/src/main/resources/file.conf.example)

Configure server-side `metrics`

【file.conf】

```shell
metrics {
  enabled = true
  registryType = "compact"
  # multiple exporters separated by commas
  exporterList = "prometheus"
  exporterPrometheusPort = 9898
}
```

【registry.conf】

```shell
registry {
    type = "nacos"
    nacos {
      application = "application name"
      serverAddr = "xxxx:port"
      group = "group"
      namespace = "namespace"
      cluster = "default"
      username = "fill according to actual situation"
      password = "fill according to actual situation"
    }
}
config {
  type = "file"
  file {
    name="file:/root/seata-config/file.conf"
  }
}
```

- Access [http://tc-server-ip:9898/metrics](http://tc-server-ip:9898/metrics) to check if you can access the metrics data

```shell
# HELP seata seata
# TYPE seata untyped
seata_transaction{meter="counter",role="tc",status="committed",} 1358.0 1551946035372
seata_transaction{meter="counter",role="tc",status="active",} 0.0 1551946035372
seata_transaction{meter="summary",role="tc",statistic="count",status="committed",} 6.0 1551946035372
seata_transaction{meter="summary",role="tc",statistic="total",status="committed",} 6.0 1551946035372
seata_transaction{meter="summary",role="tc",statistic="tps",status="committed",} 1.6163793103448276 1551946035372
seata_transaction{meter="timer",role="tc",statistic="count",status="committed",} 6.0 1551946035372
seata_transaction{meter="timer",role="tc",statistic="total",status="committed",} 910.0 1551946035372
seata_transaction{meter="timer",role="tc",statistic="max",status="committed",} 164.0 1551946035372
seata_transaction{meter="timer",role="tc",statistic="average",status="committed",} 151.66666666666666 1551946035372
```

Receiving similar data indicates that `metric` has been successfully enabled. (If certain Transaction statuses have not occurred, such as `rollback`, the corresponding Metrics will not exist (output)).

### Enable DataKit Collector

- Enable the DataKit Prometheus plugin and create `seata-prom.conf`

```shell
cd /usr/local/datakit/conf.d/prom/
cp prom.conf.sample seata-prom.conf
```

- Modify the `seata-prom.conf` configuration file

```toml
[[inputs.prom]]
  urls = ["http://ip:9898/metrics"]
  ## Ignore request errors for URLs
  ignore_req_err = false
  ## Collector alias
  source = "resource name"
  metric_types = []
  ## Filter metrics to collect only those related to seata_
  metric_name_filter = ["seata_*"]
  measurement_prefix = "seata_"
  ## Collection interval "ns", "us" (or "µs"), "ms", "s", "m", "h"
  interval = "10s"
  ## TLS configuration
  tls_open = false
  ## Custom Tags
  [inputs.prom.tags]
  app = "custom app name"
  # more_tag = "some_other_value"
```

- Restart DataKit

```shell
systemctl restart datakit
```

## Metric Details {#metric}

| **Metrics** | **Description** |
| --- | --- |
| `seata.transaction`(role=tc,meter=counter,status=active/committed/rollback) | Total number of active/committed/rolled back transactions currently |
| `seata.transaction`(role=tc,meter=summary,statistic=count,status=committed/rollback) | Number of committed/rolled back transactions within the current period |
| `seata.transaction`(role=tc,meter=summary,statistic=tps,status=committed/rollback) | Transactions per second (TPS) of committed/rolled back transactions within the current period |
| `seata.transaction`(role=tc,meter=timer,statistic=total,status=committed/rollback) | Total time spent on committed/rolled back transactions within the current period |
| `seata.transaction`(role=tc,meter=timer,statistic=count,status=committed/rollback) | Number of committed/rolled back transactions within the current period |
| `seata.transaction`(role=tc,meter=timer,statistic=average,status=committed/rollback) | Average time spent on committed/rolled back transactions within the current period |
| `seata.transaction`(role=tc,meter=timer,statistic=max,status=committed/rollback) | Maximum time spent on committed/rolled back transactions within the current period |
  
Note: Replace placeholders like "application name", "xxxx:port", "group", "namespace", "custom app name", etc., with actual values as required.