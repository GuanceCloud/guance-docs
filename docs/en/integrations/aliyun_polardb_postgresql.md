---
title: 'Alibaba Cloud PolarDB PostgreSQL'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud PolarDB PostgreSQL Metrics display, including CPU usage, memory usage, network traffic, connection count, IOPS, TPS, data disk size, etc.'
__int_icon: 'icon/aliyun_polardb'
dashboard:
  - desc: 'Built-in views for Alibaba Cloud PolarDB PostgreSQL'
    path: 'dashboard/en/aliyun_polardb_postgresql/'

monitor:
  - desc: 'Monitor for Alibaba Cloud PolarDB PostgreSQL'
    path: 'monitor/en/aliyun_polardb_postgresql/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud PolarDB PostgreSQL
<!-- markdownlint-enable -->

Alibaba Cloud PolarDB PostgreSQL Metrics display, including CPU usage, memory usage, network traffic, connection count, IOPS, TPS, data disk size, etc.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> We recommend deploying the GSE version.

### Installation Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize monitoring data from Alibaba Cloud PolarDB PostgreSQL, we install the corresponding collection script: 「Guance Integration (Alibaba Cloud-PolarDB PostgreSQL Collection)」(ID: `guance_aliyun_polardb_postgresql`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

After enabling, you can see the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, you also need to enable the corresponding log collection script. If you need to collect billing information, you need to enable the cloud billing collection script.

We default to collecting some configurations; for more details, see the Metrics section.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}

### Verification

1. In 「Manage / Automatic Trigger Configuration」confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and check the task records and logs to ensure there are no abnormalities.
2. On the Guance platform, go to 「Infrastructure - Resource Catalog」to check if asset information exists.
3. On the Guance platform, go to 「Metrics」to check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud Cloud Monitor, the default metric set is as follows. You can collect more metrics through configuration. [Alibaba Cloud Cloud Monitor Metric Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id               | Metric Name       | Dimensions                  | Statistics | Unit      |
| ---- | ------ | ---- | ---- | ---- |
| pg_active_connections   | pg Active Connections | userId,clusterId,instanceId | Average    | `count`   |
| pg_blks_read_delta      | pg Blocks Read    | userId,clusterId,instanceId | Average    | `count`   |
| pg_conn_usage           | pg Connection Usage | userId,clusterId,instanceId | Average    | `%`       |
| pg_cpu_total            | pg CPU Usage      | userId,clusterId,instanceId | Average    | `%`       |
| pg_db_age               | pg Database Max Age | userId,clusterId,instanceId | Average    | `xids`    |
| pg_mem_usage            | pg Memory Usage   | userId,clusterId,instanceId | Average    | `%`       |
| pg_pls_data_size        | pg Data Disk Size | userId,clusterId,instanceId | Value      | `Mbyte`   |
| pg_pls_iops             | pg IOPS           | userId,clusterId,instanceId | Average    | `frequency` |
| pg_pls_iops_read        | pg Read IOPS      | userId,clusterId,instanceId | Average    | `frequency` |
| pg_pls_iops_write       | pg Write IOPS     | userId,clusterId,instanceId | Average    | `frequency` |
| pg_pls_pg_wal_dir_size  | pg WAL Log Size   | userId,clusterId,instanceId | Value      | `Mbyte`   |
| pg_pls_throughput       | pg IO Throughput  | userId,clusterId,instanceId | Average    | `Mbyte/s` |
| pg_pls_throughput_read  | pg Read IO Throughput | userId,clusterId,instanceId | Average    | `Mbyte/s` |
| pg_pls_throughput_write | pg Write IO Throughput | userId,clusterId,instanceId | Average    | `Mbyte/s` |
| pg_rollback_ratio       | pg Rollback Ratio | userId,clusterId,instanceId | Average    | `%`       |
| pg_swell_time           | pg Swell Time     | userId,clusterId,instanceId | Average    | `s`       |
| pg_tps                  | pg TPS            | userId,clusterId,instanceId | Average    | `frequency` |

## Objects {#object}

The collected Alibaba Cloud PolarDB object data structure can be viewed in 「Infrastructure - Resource Catalog」

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
