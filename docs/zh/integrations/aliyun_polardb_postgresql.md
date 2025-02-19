---
title: '阿里云 PolarDB PostgreSQL'
tags: 
  - 阿里云
summary: '阿里云 PolarDB PostgreSQL 指标展示，包括 CPU 使用率、内存使用率、网络流量、连接数、 IOPS、 TPS、 数据盘大小等。'
__int_icon: 'icon/aliyun_polardb'
dashboard:
  - desc: '阿里云 PolarDB PostgreSQL 内置视图'
    path: 'dashboard/zh/aliyun_polardb_postgresql/'

monitor:
  - desc: '阿里云 PolarDB PostgreSQL 监控器'
    path: 'monitor/zh/aliyun_polardb_postgresql/'
---

<!-- markdownlint-disable MD025 -->
# 阿里云 PolarDB PostgreSQL
<!-- markdownlint-enable -->

阿里云 PolarDB PostgreSQL 指标展示，包括 CPU 使用率、内存使用率、网络流量、连接数、 IOPS、 TPS、 数据盘大小等。

## 配置 {#config}

### 安装 Func

推荐开通{{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> 推荐部署GSE版

### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步阿里云 PolarDB PostgreSQL 的监控数据，我们安装对应的采集脚本：「{{{ custom_key.brand_name }}}集成（阿里云-PolarDB PostgreSQL 采集）」(ID：`guance_aliyun_polardb_postgresql`)

点击【安装】后，输入相应的参数：阿里云 AK、阿里云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

> 如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。



我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在{{{ custom_key.brand_name }}}平台，「基础设施 - 资源目录」中查看是否存在资产信息
3. 在{{{ custom_key.brand_name }}}平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好阿里云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [阿里云云监控指标详情](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id               | Metric Name       | Dimensions                  | Statistics | Unit      |
| ---- | ------ | ---- | ---- | ---- |
| pg_active_connections   | pg 活跃连接数     | userId,clusterId,instanceId | Average    | `count`   |
| pg_blks_read_delta      | pg 数据块读取数   | userId,clusterId,instanceId | Average    | `count`   |
| pg_conn_usage           | pg 连接使用率     | userId,clusterId,instanceId | Average    | `%`       |
| pg_cpu_total            | pg CPU使用率      | userId,clusterId,instanceId | Average    | `%`       |
| pg_db_age               | pg 数据库最大年龄 | userId,clusterId,instanceId | Average    | `xids`    |
| pg_mem_usage            | pg 内存使用率     | userId,clusterId,instanceId | Average    | `%`       |
| pg_pls_data_size        | pg 数据盘大小     | userId,clusterId,instanceId | Value      | `Mbyte`   |
| pg_pls_iops             | pg IOPS           | userId,clusterId,instanceId | Average    | `frequency` |
| pg_pls_iops_read        | pg 读IOPS         | userId,clusterId,instanceId | Average    | `frequency` |
| pg_pls_iops_write       | pg 写IOPS         | userId,clusterId,instanceId | Average    | `frequency` |
| pg_pls_pg_wal_dir_size  | pg WAL日志大小    | userId,clusterId,instanceId | Value      | `Mbyte`   |
| pg_pls_throughput       | pg IO吞吐         | userId,clusterId,instanceId | Average    | `Mbyte/s` |
| pg_pls_throughput_read  | pg 读IO吞吐       | userId,clusterId,instanceId | Average    | `Mbyte/s` |
| pg_pls_throughput_write | pg 写IO吞吐       | userId,clusterId,instanceId | Average    | `Mbyte/s` |
| pg_rollback_ratio       | pg 事务回滚率     | userId,clusterId,instanceId | Average    | `%`       |
| pg_swell_time           | pg 膨胀点         | userId,clusterId,instanceId | Average    | `s`       |
| pg_tps                  | pg TPS            | userId,clusterId,instanceId | Average    | `frequency` |

## 对象 {#object}

采集到的阿里云 PolarDB 对象数据结构, 可以从「基础设施 - 资源目录」里看到对象数据

```json
{
  "measurement": "aliyun_polardb",
  "tags": {
    "name"                : "pc-xxxx",
    "RegionId"            : "cn-hangzhou",
    "DBNodeNumber"        : "2",
    "DBType"              : "MySQL",
    "DBClusterId"         : "pc-xxxx",
    "ZoneId"              : "cn-hangzhou-i",
    "Engine"              : "POLARDB",
    "Category"            : "Normal",
    "DBClusterDescription": "pc-xxxx"
  },
  "fields": {
    "CreateTime"          : "2022-06-17T06:07:19Z",
    "DBClusterNetworkType": "VPC",
    "DBNodeClass"         : "polar.mysql.g1.tiny.c",
    "DBNodes"             : "{节点列表 JSON 数据}",
    "DBVersion"           : "8.0",
    "Database"            : "[数据库详情 JSON 数据]",
    "ExpireTime"          : "",
    "LockMode"            : "Unlock",
    "PayType"             : "Postpaid",
    "Tags"                : "{"Tag": []}",
    "VpcId"               : "vpc-bp16f7**********3p3",
    "message"             : "{实例 JSON 数据}"
  }
}

```

