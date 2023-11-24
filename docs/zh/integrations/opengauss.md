---
title     : 'OpenGauss'
summary   : '采集 OpenGauss 指标信息'
__int_icon: 'icon/opengauss'
dashboard :
  - desc  : 'OpenGauss 监控视图'
    path  : 'dashboard/zh/opengauss'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# OpenGauss
<!-- markdownlint-enable -->

## 配置 {#config}

### 前置条件

- [x] 安装 OpenGauss

### OpenGauss Exporter

OpenGauss 官方已开源了 [`openGauss-prometheus-exporter`](https://gitee.com/opengauss/openGauss-prometheus-exporter)，可以通过访问 `/metrics` 获取指标信息。

支持使用 Docker 方式或者编译二进制的方式运行 Exporter。


```shell
git clone https://gitee.com/opengauss/openGauss-prometheus-exporter.git
cd openGauss-prometheus-exporter
make build
export DATA_SOURCE_NAME="postgresql://login:password@hostname:port/dbname"
./bin/opengauss_exporter <flags>
```

参数使用说明参考[官方文档](https://gitee.com/opengauss/openGauss-prometheus-exporter#flags)。

运行成功后，Exporter 默认端口为 `9187`。

### DataKit 开启 `prom` 采集器

可以直接通过[`prom`](./prom.md)采集器来采集 `prometheus` 格式的指标。

- 开启 DataKit prom 插件，复制 sample 文件

```bash
cd /usr/local/datakit/conf.d/prom/
cp prom.conf.sample opengauss-prom.conf
```

- 修改 `opengauss-prom.conf` 配置文件

调整以下内容

```toml
[[inputs.prom]]
  ## Exporter URLs.
  urls = ["http://localhost:9187/metrics"]

  source = "opengauss-prom"
...
```

### 重启 DataKit

[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service)

## 指标 {#metric}


| 指标 | 描述 |
| -- | -- |
| `up` | 服务启动状态 |
| `database_size_bytes` | 数据库大小 |
| `stat_database_blks_hit`| 缓存命中|
| `stat_database_blks_read`| 缓存读取|
| `lock_count`| 事务锁总数|
| `stat_database_conflicts_confl_bufferpin`| 缓存冲突|
| `stat_database_conflicts_confl_lock`| 锁冲突|
| `stat_database_conflicts_confl_snapshot`| 快照冲突|
| `stat_database_conflicts_confl_tablespace`| 表空间冲突|

