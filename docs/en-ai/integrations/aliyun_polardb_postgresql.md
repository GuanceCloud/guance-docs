---
title: 'Alibaba Cloud PolarDB PostgreSQL'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud PolarDB PostgreSQL Metrics Display, including CPU usage, memory usage, network traffic, connection count, IOPS, TPS, data disk size, etc.'
__int_icon: 'icon/aliyun_polardb'
dashboard:
  - desc: 'Built-in Views for Alibaba Cloud PolarDB PostgreSQL'
    path: 'dashboard/en/aliyun_polardb_postgresql/'

monitor:
  - desc: 'Monitor for Alibaba Cloud PolarDB PostgreSQL'
    path: 'monitor/en/aliyun_polardb_postgresql/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud PolarDB PostgreSQL
<!-- markdownlint-enable -->

Alibaba Cloud PolarDB PostgreSQL Metrics Display, including CPU usage, memory usage, network traffic, connection count, IOPS, TPS, data disk size, etc.

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> It is recommended to deploy the GSE version.

### Install Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize monitoring data from Alibaba Cloud PolarDB PostgreSQL, install the corresponding collection script: 「Guance Integration (Alibaba Cloud-PolarDB PostgreSQL Collection)」(ID: `guance_aliyun_polardb_postgresql`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK and Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Once enabled, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you need to collect logs, you also need to enable the corresponding log collection script. If you need to collect billing information, you need to enable the cloud billing collection script.

We default to collecting some configurations; for more details, see the Metrics section.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}

### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm whether the corresponding tasks have been configured for automatic triggers, and check the task records and logs for any anomalies.
2. On the Guance platform, under 「Infrastructure - Resource Catalog」, check if asset information exists.
3. On the Guance platform, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}
By configuring Alibaba Cloud Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration. [Alibaba Cloud Cloud Monitoring Metrics Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id               | Metric Name       | Dimensions                  | Statistics | Unit      |
| ---- | ------ | ---- | ---- | ---- |
| pg_active_connections   | Active Connections | userId,clusterId,instanceId | Average    | `count`   |
| pg_blks_read_delta      | Blocks Read       | userId,clusterId,instanceId | Average    | `count`   |
| pg_conn_usage           | Connection Usage  | userId,clusterId,instanceId | Average    | `%`       |
| pg_cpu_total            | CPU Usage         | userId,clusterId,instanceId | Average    | `%`       |
| pg_db_age               | Database Age      | userId,clusterId,instanceId | Average    | `xids`    |
| pg_mem_usage            | Memory Usage      | userId,clusterId,instanceId | Average    | `%`       |
| pg_pls_data_size        | Data Disk Size    | userId,clusterId,instanceId | Value      | `Mbyte`   |
| pg_pls_iops             | IOPS              | userId,clusterId,instanceId | Average    | `frequency` |
| pg_pls_iops_read        | Read IOPS         | userId,clusterId,instanceId | Average    | `frequency` |
| pg_pls_iops_write       | Write IOPS        | userId,clusterId,instanceId | Average    | `frequency` |
| pg_pls_pg_wal_dir_size  | WAL Log Size      | userId,clusterId,instanceId | Value      | `Mbyte`   |
| pg_pls_throughput       | IO Throughput     | userId,clusterId,instanceId | Average    | `Mbyte/s` |
| pg_pls_throughput_read  | Read IO Throughput| userId,clusterId,instanceId | Average    | `Mbyte/s` |
| pg_pls_throughput_write | Write IO Throughput| userId,clusterId,instanceId | Average    | `Mbyte/s` |
| pg_rollback_ratio       | Rollback Ratio    | userId,clusterId,instanceId | Average    | `%`       |
| pg_swell_time           | Swell Time        | userId,clusterId,instanceId | Average    | `s`       |
| pg_tps                  | TPS               | userId,clusterId,instanceId | Average    | `frequency` |

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