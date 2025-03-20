---
title: 'Alibaba Cloud PolarDB Oracle'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud PolarDB Oracle Metrics Display, including CPU usage, memory usage, network traffic, connection count, IOPS, TPS, data disk size, etc.'
__int_icon: 'icon/aliyun_polardb'
dashboard:
  - desc: 'Alibaba Cloud PolarDB Oracle Built-in Views'
    path: 'dashboard/en/aliyun_polardb_oracle/'

monitor:
  - desc: 'Alibaba Cloud PolarDB Oracle Monitors'
    path: 'monitor/en/aliyun_polardb_oracle/' 
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud PolarDB Oracle
<!-- markdownlint-enable -->

Alibaba Cloud PolarDB Oracle Metrics Display, including CPU usage, memory usage, network traffic, connection count, IOPS, TPS, data disk size, etc.

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> It is recommended to deploy the GSE version.

### Installation Script

> Note: Please prepare the required Alibaba Cloud AK in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

To synchronize monitoring data for Alibaba Cloud PolarDB Oracle, we install the corresponding collection script: "Guance Integration (Alibaba Cloud-PolarDB Collection)" (ID: `guance_aliyun_polardb`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK and Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set, and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to immediately run it once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, you also need to enable the corresponding log collection script. If you need to collect billing information, you need to enable the cloud billing collection script.



We default to collecting some configurations; see the metrics section for details.

[Customize Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」 confirm whether the corresponding task has an automatic trigger configuration, and at the same time, you can check the corresponding task records and logs for any abnormalities.
2. On the Guance platform, under 「Infrastructure / Custom」, check if there is asset information.
3. On the Guance platform, under 「Metrics」, check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud - Cloud Monitoring, the default metric sets are as follows. You can collect more metrics through configuration. [Alibaba Cloud Cloud Monitoring Metrics Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id            | Metric Name       | Dimensions                  | Statistics | Unit      |
| ---- | ------ | ---- | ---- | ---- |
| `active_connections` | Active Connections | userId,clusterId,instanceId | Average    | `count`   |
| `blks_read_delta`    | Blocks Read       | userId,clusterId,instanceId | Average    | `count`   |
| `conn_usage`         | Connection Usage   | userId,clusterId,instanceId | Average    | `%`       |
| `cpu_total`          | CPU Usage         | userId,clusterId,instanceId | Average    | `%`       |
| `db_age`             | Database Max Age   | userId,clusterId,instanceId | Average    | `xids`    |
| `mem_usage`          | Memory Usage      | userId,clusterId,instanceId | Average    | `%`       |
| `pls_data_size`      | Data Disk Size    | userId,clusterId,instanceId | Value      | `Mbyte`   |
| `pls_iops`           | IOPS              | userId,clusterId,instanceId | Average    | `frequency` |
| `pls_iops_read`      | Read IOPS         | userId,clusterId,instanceId | Average    | `frequency` |
| `pls_iops_write`     | Write IOPS        | userId,clusterId,instanceId | Average    | `frequency` |
| `pls_pg_wal_dir_size` | WAL Log Size      | userId,clusterId,instanceId | Value      | `Mbyte`   |
| `pls_throughput`     | IO Throughput     | userId,clusterId,instanceId | Average    | `Mbyte/s` |
| `pls_throughput_read` | Read IO Throughput | userId,clusterId,instanceId | Average    | `Mbyte/s` |
| `pls_throughput_write` | Write IO Throughput | userId,clusterId,instanceId | Average    | `Mbyte/s` |
| `rollback_ratio`     | Rollback Ratio    | userId,clusterId,instanceId | Average    | `%`       |
| `swell_time`         | Swell Time        | userId,clusterId,instanceId | Average    | `s`       |
| `tps`                | TPS               | userId,clusterId,instanceId | Average    | `frequency` |

## Objects {#object}

The collected Alibaba Cloud PolarDB object data structure can be viewed from 「Infrastructure-Custom」.

```json
{
  "measurement": "aliyun_polardb",
  "tags": {
    "name"                : "pc-xxxx",
    "RegionId"            : "cn-hangzhou",
    "VpcId"               : "vpc-xxxx",
    "DBNodeNumber"        : "2",
    "PayType"             : "Postpaid",
    "DBType"              : "MySQL",
    "LockMode"            : "Unlock",
    "DBVersion"           : "8.0",
    "DBClusterId"         : "pc-xxxx",
    "DBClusterNetworkType": "VPC",
    "ZoneId"              : "cn-hangzhou-i",
    "Engine"              : "POLARDB",
    "Category"            : "Normal",
    "DBClusterDescription": "pc-xxxx",
    "DBNodeClass"         : "polar.mysql.x4.medium"
  },
  "fields": {
    "DBNodes"   : "{JSON Data of Node List}",
    "Database"  : "[JSON Data of Database Details]",
    "ExpireTime": "",
    "CreateTime": "2022-06-17T06:07:19Z",
    "message"   : "{JSON Data of Instance}"
  }
}

```