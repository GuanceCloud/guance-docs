---
title     : 'OpenGauss'
summary   : 'Collect OpenGauss Metrics information'
__int_icon: 'icon/opengauss'
dashboard :
  - desc  : 'OpenGauss monitoring view'
    path  : 'dashboard/en/opengauss'
monitor   :
  - desc  : 'None temporarily'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# OpenGauss
<!-- markdownlint-enable -->

## Configuration {#config}

### Prerequisites

- [x] Install OpenGauss

### OpenGauss Exporter

The official OpenGauss has open-sourced the [`openGauss-prometheus-exporter`](https://gitee.com/opengauss/openGauss-prometheus-exporter), which can obtain Metrics information by accessing `/metrics`.

It supports running the Exporter using Docker or compiling it into a binary format.


```shell
git clone https://gitee.com/opengauss/openGauss-prometheus-exporter.git
cd openGauss-prometheus-exporter
make build
export DATA_SOURCE_NAME="postgresql://login:password@hostname:port/dbname"
./bin/opengauss_exporter <flags>
```

For parameter usage, refer to the [official documentation](https://gitee.com/opengauss/openGauss-prometheus-exporter#flags).

After successful execution, the default port for the Exporter is `9187`.

### Enable DataKit's `prom` collector

You can directly use the [`prom`](./prom.md) collector to collect metrics in `prometheus` format.

- Enable the DataKit prom plugin and copy the sample file

```bash
cd /usr/local/datakit/conf.d/prom/
cp prom.conf.sample opengauss-prom.conf
```

- Modify the `opengauss-prom.conf` configuration file

Adjust the following content:

```toml
[[inputs.prom]]
  ## Exporter URLs.
  urls = ["http://localhost:9187/metrics"]

  source = "opengauss-prom"
...
```

### Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}


| Metric | Description |
| -- | -- |
| `up` | Service startup status |
| `database_size_bytes` | Database size |
| `stat_database_blks_hit`| Cache hit|
| `stat_database_blks_read`| Cache read|
| `lock_count`| Total number of transaction locks|
| `stat_database_conflicts_confl_bufferpin`| Cache conflict|
| `stat_database_conflicts_confl_lock`| Lock conflict|
| `stat_database_conflicts_confl_snapshot`| Snapshot conflict|
| `stat_database_conflicts_confl_tablespace`| Tablespace conflict|