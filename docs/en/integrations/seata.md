---
title     : 'Seata'
summary   : 'Collect information about Seata-related metrics'
__int_icon: 'icon/seata'
dashboard :
  - desc  : 'Seata'
    path  : 'dashboard/en/seata'
monitor   :
  - desc  : 'No'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Seata
<!-- markdownlint-enable -->

## Configuration {#config}


Seata supports Metrics data collection on TC and output to Prometheus monitoring system.

### Open Seata Metrics

- Configure Metrics on TC and Metrics on TC. Seata Server already contains Metrics ( `seata-metrics-all`) dependencies, but it is off by default and needs to turn on metrics collection configuration. (**This step is very important)**  

 `Seata 1.5.0+` Use `application.yaml`

```shell
seata:
  metrics:
    enabled: true
    registry-type: compact
    exporter-list: prometheus
    exporter-prometheus-port: 9898

```

 `Seata <1.5.0` Turn on `metrics`

GitHub address configuration: [https://github.com/seata/seata/blob/1.4.2/server/src/main/resources/file.conf.example](https://github.com/seata/seata/blob/1.4.2/server/src/main/resources/file.conf.example)

Server-side configuration `metrics`

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
      application = "application name"
      serverAddr = "xxxx:port"
      group = "group name"
      namespace = "namespace"
      cluster = "default"
      username = "username"
      password = "password"
    }
}
config {
  type = "file"
  file {
    name="file:/root/seata-config/file.conf"
  }
}
```

- Visit [http://tc-server-ip:9898/metrics](http://tc-server-ip:9898/metrics) to see if metrics data is accessible  

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

Similar data above proves that `metric` was successfully turned on. (If some Transaction states do not occur, such as `rollback`, then the corresponding Metrics metric does not exist (output)


### Open DataKit Collector

- Open the DataKit Prometheus plug-in and create `seata-prom.conf`

```shell
cd /usr/local/datakit/conf.d/prom/
cp prom.conf.sample seata-prom.conf
```

- Modify `seata-prom.conf` Profile

```toml
[[inputs.prom]]
  urls = ["http://ip:9898/metrics"]

  ignore_req_err = false

  source = "seata"
  metric_types = []

  metric_name_filter = ["seata_*"]
  measurement_prefix = "seata_"

  interval = "10s"

```

- Restart DataKit

```shell
systemctl restart datakit
```

## Metric {#metric}

| Metric | Description |
| --- | --- |
| `seata.transaction` (role=tc, meter=counter, status=active/committed/rollback)| current active/committed/rollback transaction count |
| `seata.transaction` (role=tc, meter=summary, statistic=count, status=committed/rollback)| current committed/rollback transaction count|
| `seata.transaction` (role=tc, meter=summary, statistic=tps, status=committed/rollback)| current committed/rollback transaction count . TPS(transaction per second) |
| `seata.transaction` (role=tc, meter=timer, statistic=total, status=committed/rollback)| current committed/rollback transaction total count |
| `seata.transaction` (role=tc, meter=timer, statistic=count, status=committed/rollback)| current committed/rollback transaction count |
| `seata.transaction` (role=tc, meter=timer, statistic=average, status=committed/rollback)| current committed/rollback transaction average duration |
| `seata.transaction` (role=tc, meter=timer, statistic=max, status=committed/rollback)| current committed/rollback transaction max duration |
