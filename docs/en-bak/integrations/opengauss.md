---
title     : 'OpenGauss'
summary   : 'Collect OpenGaussian metric information'
__int_icon: 'icon/opengauss'
dashboard :
  - desc  : 'OpenGauss Monitoring View'
    path  : 'dashboard/en/opengauss'
monitor   :
  - desc  : 'No'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# OpenGauss
<!-- markdownlint-enable -->

## Installation Configuration{#config}

### Preconditions

- [x] Installed OpenGauss

### OpenGauss Exporter

OpenGauss has officially opened source [`openGauss prometheus exporter`]( https://gitee.com/opengauss/openGauss-prometheus-exporter),You can obtain metric information by accessing `/metrics`.

Support using Docker mode or compiling binary to run Exporter.


```shell
git clone https://gitee.com/opengauss/openGauss-prometheus-exporter.git
cd openGauss-prometheus-exporter
make build
export DATA_SOURCE_NAME="postgresql://login:password@hostname:port/dbname"
./bin/opengauss_exporter <flags>
```

Parameter usage instructions refer to [official document](https://gitee.com/opengauss/openGauss-prometheus-exporter#flags).

After successful operation, the default port of the Exporter is `9187`.

### DataKit enable the `prom` collector

You can directly collect metrics in the format of `prometheus` through the [`prom`](./prom.md) collector.

- Open the DataKit prom plugin and copy the `sample` file

```bash
cd /usr/local/datakit/conf.d/prom/
cp prom.conf.sample opengauss-prom.conf
```

- Modify `opengauss-prom.conf`

Adjust the following content

```toml
[[inputs.prom]]
  ## Exporter URLs.
  urls = ["http://localhost:9187/metrics"]

  source = "opengauss-prom"
...
```

### Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metric {#metric}


| Metric | Description |
| -- | -- |
| `up` | Service startup status |
| `database_size_bytes` | database size |
| `stat_database_blks_hit`| Cache hit|
| `stat_database_blks_read`| Cache read|
| `lock_count`| Total number of transaction locks|
| `stat_database_conflicts_confl_bufferpin`| Cache conflicts|
| `stat_database_conflicts_confl_lock`| lock conflicts|
| `stat_database_conflicts_confl_snapshot`| snapshot conflicts|
| `stat_database_conflicts_confl_tablespace`| `tablespace` conflicts|

