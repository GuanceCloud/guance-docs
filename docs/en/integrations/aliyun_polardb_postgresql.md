---
title: 'Alibaba Cloud PolarDB PostgreSQL'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud PolarDB PostgreSQL Metrics Display, including CPU usage, memory usage, network traffic, connection count, IOPS, TPS, data disk size, etc.'
__int_icon: 'icon/aliyun_polardb'
dashboard:
  - desc: 'Alibaba Cloud PolarDB PostgreSQL Built-in Views'
    path: 'dashboard/en/aliyun_polardb_postgresql/'

monitor:
  - desc: 'Alibaba Cloud PolarDB PostgreSQL Monitor'
    path: 'monitor/en/aliyun_polardb_postgresql/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud PolarDB PostgreSQL
<!-- markdownlint-enable -->

Alibaba Cloud PolarDB PostgreSQL metrics display, including CPU usage, memory usage, network traffic, connection count, IOPS, TPS, data disk size, etc.

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites will be automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> It is recommended to deploy the GSE version.

### Installation Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data for Alibaba Cloud PolarDB PostgreSQL, we install the corresponding collection script: 「Guance Integration (Alibaba Cloud-PolarDB Collection)」(ID: `guance_aliyun_polardb`)

After clicking 【Install】, input the corresponding parameters: Alibaba Cloud AK and Alibaba Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】to immediately run it without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, you also need to enable the corresponding log collection script. If you want to collect billing information, you need to enable the cloud billing collection script.



We default to collecting some configurations, details are shown in the metrics section.

[Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」confirm whether the corresponding tasks have the corresponding automatic trigger configuration, and at the same time, you can check the corresponding task records and logs to check for any abnormalities.
2. On the Guance platform, under 「Infrastructure / Custom」check if there is asset information.
3. On the Guance platform, under 「Metrics」check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud-Monitoring, the default metric sets are as follows. You can collect more metrics through configuration. [Alibaba Cloud Monitoring Metric Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id               | Metric Name       | Dimensions                  | Statistics | Unit      |
| ---- | ------ | ---- | ---- | ---- |
| pg_active_connections   | pg Active Connections | userId,clusterId,instanceId | Average    | `count`   |
| pg_blks_read_delta      | pg Blocks Read     | userId,clusterId,instanceId | Average    | `count`   |
| pg_conn_usage           | pg Connection Usage | userId,clusterId,instanceId | Average    | `%`       |
| pg_cpu_total            | pg CPU Usage      | userId,clusterId,instanceId | Average    | `%`       |
| pg_db_age               | pg Database Max Age | userId,clusterId,instanceId | Average    | `xids`    |
| pg_mem_usage            | pg Memory Usage   | userId,clusterId,instanceId | Average    | `%`       |
| pg_pls_data_size        | pg Data Disk Size | userId,clusterId,instanceId | Value      | `Mbyte`   |
| pg_pls_iops             | pg IOPS          | userId,clusterId,instanceId | Average    | `frequency` |
| pg_pls_iops_read        | pg Read IOPS     | userId,clusterId,instanceId | Average    | `frequency` |
| pg_pls_iops_write       | pg Write IOPS    | userId,clusterId,instanceId | Average    | `frequency` |
| pg_pls_pg_wal_dir_size  | pg WAL Log Size  | userId,clusterId,instanceId | Value      | `Mbyte`   |
| pg_pls_throughput       | pg IO Throughput | userId,clusterId,instanceId | Average    | `Mbyte/s` |
| pg_pls_throughput_read  | pg Read IO Throughput | userId,clusterId,instanceId | Average    | `Mbyte/s` |
| pg_pls_throughput_write | pg Write IO Throughput | userId,clusterId,instanceId | Average    | `Mbyte/s` |
| pg_rollback_ratio       | pg Rollback Ratio | userId,clusterId,instanceId | Average    | `%`       |
| pg_swell_time           | pg Swell Time    | userId,clusterId,instanceId | Average    | `s`       |
| pg_tps                  | pg TPS          | userId,clusterId,instanceId | Average    | `frequency` |

## Objects {#object}

The collected Alibaba Cloud PolarDB object data structure can be seen in 「Infrastructure-Custom」.

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