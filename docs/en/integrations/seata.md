---
title     : 'Seata'
summary   : 'Collect Seata related Metrics information'
__int_icon: 'icon/seata'
dashboard :
  - desc  : 'Seata Monitoring View'
    path  : 'dashboard/en/seata'
monitor   :
  - desc  : 'None available'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Seata
<!-- markdownlint-enable -->

## Deployment and Implementation {#config}


Seata supports enabling Metrics data collection in TC and outputting it to the Prometheus monitoring system.

### Enable Seata Metrics

- Configure the enabling of Metrics in TC. Open the Metrics configuration item in TC. The Seata Server already includes the Metrics (`seata-metrics-all`) dependency, but it is disabled by default. You need to enable the Metrics collection configuration. (**This step is very important**)

In `Seata 1.5.0+`, use `application.yaml`

```shell
seata:
  metrics:
    enabled: true
    registry-type: compact
    exporter-list: prometheus
    exporter-prometheus-port: 9898

```

For `Seata <1.5.0`, enable `metrics`

GitHub configuration address: [https://github.com/seata/seata/blob/1.4.2/server/src/main/resources/file.conf.example](https://github.com/seata/seata/blob/1.4.2/server/src/main/resources/file.conf.example)

Server-side `metrics` configuration

[file.conf]

```shell
metrics {
  enabled = true
  registryType = "compact"
  # multi exporters use comma divided
  exporterList = "prometheus"
  exporterPrometheusPort = 9898
}
```

[registry.conf]

```shell
registry {
    type = "nacos"
    nacos {
      application = "Application Name"
      serverAddr = "xxxx:port"
      group = "Group"
      namespace = "Namespace"
      cluster = "default"
      username = "Fill according to actual situation"
      password = "Fill according to actual situation"
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

Receiving data similar to the above proves that `metric` has been successfully enabled. (If certain Transaction statuses have not occurred, for example `rollback`, then the corresponding Metrics will not exist (output))


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
  ## Ignore request errors for url
  ignore_req_err = false
  ## Collector alias
  source = "Resource Name"
  metric_types = []
  ## Metric filtering, only collect seata_* related metrics
  metric_name_filter = ["seata_*"]
  measurement_prefix = "seata_"
  ## Collection interval "ns", "us" (or "µs"), "ms", "s", "m", "h"
  interval = "10s"
  ## TLS configuration
  tls_open = false
  ## Custom Tags
  [inputs.prom.tags]
  app = "Custom app name"
  # more_tag = "some_other_value"
```

- Restart DataKit

```shell
systemctl restart datakit
```

## Metric Details {#metric}

| **Metrics** | **Description** |
| --- | --- |
| `seata.transaction`(role=tc,meter=counter,status=active/committed/rollback) | Total number of currently active/committed/rolled back transactions |
| `seata.transaction`(role=tc,meter=summary,statistic=count,status=committed/rollback) | Number of committed/rolled back transactions within the current period |
| `seata.transaction`(role=tc,meter=summary,statistic=tps,status=committed/rollback) | TPS (transactions per second) of committed/rolled back transactions within the current period |
| `seata.transaction`(role=tc,meter=timer,statistic=total,status=committed/rollback) | Total time spent on committed/rolled back transactions within the current period |
| `seata.transaction`(role=tc,meter=timer,statistic=count,status=committed/rollback) | Number of committed/rolled back transactions within the current period |
| `seata.transaction`(role=tc,meter=timer,statistic=average,status=committed/rollback) | Average time spent on committed/rolled back transactions within the current period |
| `seata.transaction`(role=tc,meter=timer,statistic=max,status=committed/rollback) | Maximum time spent on committed/rolled back transactions within the current period |