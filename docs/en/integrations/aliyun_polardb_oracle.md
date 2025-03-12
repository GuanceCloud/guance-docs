---
title: 'Alibaba Cloud PolarDB Oracle'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud PolarDB Oracle Metrics display, including CPU usage, memory usage, network traffic, connection count, IOPS, TPS, data disk size, etc.'
__int_icon: 'icon/aliyun_polardb'
dashboard:
  - desc: 'Alibaba Cloud PolarDB Oracle built-in views'
    path: 'dashboard/en/aliyun_polardb_oracle/'

monitor:
  - desc: 'Alibaba Cloud PolarDB Oracle monitor'
    path: 'monitor/en/aliyun_polardb_oracle/' 
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud PolarDB Oracle
<!-- markdownlint-enable -->

Alibaba Cloud PolarDB Oracle Metrics display, including CPU usage, memory usage, network traffic, connection count, IOPS, TPS, data disk size, etc.

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> It is recommended to deploy the GSE version.

### Installation Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize Alibaba Cloud PolarDB Oracle monitoring data, install the corresponding collection script:「Guance Integration (Alibaba Cloud-PolarDB Oracle Collection)」(ID: `guance_aliyun_polardb_oracle`)

After clicking 【Install】, enter the required parameters: Alibaba Cloud AK and Alibaba Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, you also need to enable the corresponding log collection script. If you need to collect billing data, you need to enable the cloud billing collection script.

We default to collecting some configurations; for details, see the Metrics section.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}

### Verification

1. In 「Manage / Automatic Trigger Configuration」confirm whether the corresponding task has the corresponding automatic trigger configuration, and check the task records and logs for any abnormalities.
2. On the Guance platform, in 「Infrastructure - Resource Catalog」check if asset information exists.
3. On the Guance platform, in 「Metrics」check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration. [Alibaba Cloud Cloud Monitoring Metrics Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id            | Metric Name         | Dimensions                  | Statistics | Unit      |
| ---- | ------ | ---- | ---- | ---- |
| `active_connections` | Active Connections  | userId,clusterId,instanceId | Average    | `count`   |
| `blks_read_delta`    | Blocks Read         | userId,clusterId,instanceId | Average    | `count`   |
| `conn_usage`         | Connection Usage    | userId,clusterId,instanceId | Average    | `%`       |
| `cpu_total`          | CPU Usage           | userId,clusterId,instanceId | Average    | `%`       |
| `db_age`             | Database Age        | userId,clusterId,instanceId | Average    | `xids`    |
| `mem_usage`          | Memory Usage        | userId,clusterId,instanceId | Average    | `%`       |
| `pls_data_size`      | Data Disk Size      | userId,clusterId,instanceId | Value      | `Mbyte`   |
| `pls_iops`           | IOPS                | userId,clusterId,instanceId | Average    | `frequency` |
| `pls_iops_read`      | Read IOPS           | userId,clusterId,instanceId | Average    | `frequency` |
| `pls_iops_write`     | Write IOPS          | userId,clusterId,instanceId | Average    | `frequency` |
| `pls_pg_wal_dir_size`| WAL Log Size        | userId,clusterId,instanceId | Value      | `Mbyte`   |
| `pls_throughput`     | IO Throughput       | userId,clusterId,instanceId | Average    | `Mbyte/s` |
| `pls_throughput_read`| Read IO Throughput  | userId,clusterId,instanceId | Average    | `Mbyte/s` |
| `pls_throughput_write`| Write IO Throughput | userId,clusterId,instanceId | Average    | `Mbyte/s` |
| `rollback_ratio`     | Rollback Ratio      | userId,clusterId,instanceId | Average    | `%`       |
| `swell_time`         | Swell Time          | userId,clusterId,instanceId | Average    | `s`       |
| `tps`                | TPS                 | userId,clusterId,instanceId | Average    | `frequency` |

## Objects {#object}

The collected Alibaba Cloud PolarDB object data structure can be viewed in the 「Infrastructure - Resource Catalog」

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
    "DBNodes"             : "{JSON data of node list}",
    "DBVersion"           : "8.0",
    "Database"            : "[JSON data of database details]",
    "ExpireTime"          : "",
    "LockMode"            : "Unlock",
    "PayType"             : "Postpaid",
    "Tags"                : "{"Tag": []}",
    "VpcId"               : "vpc-bp16f7**********3p3",
    "message"             : "{JSON data of instance}"
  }
}
```
