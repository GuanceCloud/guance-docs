---
title: 'Tencent Cloud MariaDB'
tags: 
  - Tencent Cloud
summary: 'Use the script packages in the script market of the "Guance Cloud Sync" series to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/tencent_mariadb'
dashboard:

  - desc: 'Built-in views for Tencent Cloud MariaDB'
    path: 'dashboard/en/tencent_mariadb'

monitor:
  - desc: 'Tencent MariaDB Monitor'
    path: 'monitor/en/tencent_mariadb'
---

<!-- markdownlint-disable MD025 -->
# Tencent Cloud MariaDB
<!-- markdownlint-enable -->

Use the script packages in the script market of the "Guance Cloud Sync" series to synchronize cloud monitoring and cloud asset data to Guance

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install MariaDB Collection Script

> Note: Prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of MariaDB, we install the corresponding collection script: "Guance Integration (Tencent Cloud-MariaDB Collection)" (ID: `guance_tencentcloud_mariadb`)

Click 【Install】, then enter the corresponding parameters: Tencent Cloud AK, Tencent Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

After enabling, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.

> If you need to collect corresponding logs, you also need to enable the log collection script. If you need to collect billing data, you need to enable the cloud billing collection script.

By default, we collect some configurations. For details, see the metrics section [Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-mariadb/){:target="_blank"}

### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and check the task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if there is any asset information.
3. On the Guance platform, under "Metrics", check if there is any corresponding monitoring data.

## Metrics {#metric}
After configuring Tencent Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration [Tencent Cloud Cloud Monitoring Metric Details](https://cloud.tencent.com/document/product/248/54397){:target="_blank"}

### Monitoring Metrics

| Metric Name      | Metric Description             | Meaning                        | Unit  | Dimensions              |
| --------------- | ---------------------- | --------------------------- | ----- | ----------------- |
| ActiveThreadCount | Number of active threads               | Instance-level monitoring metric, calculated by summing up the active thread counts of all primary and secondary nodes of the shards  | Count   | InstanceId |
| BinlogDiskAvailable | Remaining Binlog log disk space | Instance-level monitoring metric, calculated by summing up the BinlogDiskAvailableShard monitoring values of each shard | GB | InstanceId |
| BinlogUsedDisk | Used Binlog log disk space | Instance-level monitoring metric, calculated by summing up the used Binlog log disk space of the primary nodes of each shard | GB | InstanceId |
| ConnUsageRate | DB connection usage rate            | Instance-level monitoring metric, value is the maximum DB connection usage rate of all primary and secondary nodes of the instance | % | InstanceId |
| CpuUsageRate | CPU utilization               | Instance-level monitoring metric, value is the maximum CPU utilization of all primary nodes of the instance | % | InstanceId |
| DataDiskAvailable | Available data disk space         | Instance-level monitoring metric, calculated by summing up the available data disk space of the primary nodes of each shard | GB | InstanceId |
| DataDiskUsedRate | Data disk space utilization       | Instance-level monitoring metric, value is the maximum data disk space utilization of all primary nodes of the instance | % | InstanceId |
| DeleteTotal | DELETE request count            | Instance-level monitoring metric, calculated by summing up the DELETE request counts of all primary nodes of the instance | Times/second | InstanceId |
| `InnodbBufferPoolReads` | `innodb` disk page reads      | Instance-level monitoring metric, calculated by summing up the `innodb` disk page reads of all primary and secondary nodes of the instance | Times | InstanceId |
| `InnodbBufferPoolReadAhead` | `innodb` buffer pool pre-read page count  | Instance-level monitoring metric, calculated by summing up the `innodb` buffer pool pre-read page counts of all primary and secondary nodes of the instance | Times | InstanceId |
| `InnodbBufferPoolReadRequests` | `innodb` buffer pool page read count    | Instance-level monitoring metric, calculated by summing up the `innodb` buffer pool page read counts of all primary and secondary nodes of the instance | Times | InstanceId |
| `InnodbRowsDeleted` | `innodb` deleted rows count  | Instance-level monitoring metric, calculated by summing up the `innodb` deleted row counts of all primary nodes of the instance | Rows | InstanceId |
| `InnodbRowsInserted` | `innodb` inserted rows count  | Instance-level monitoring metric, calculated by summing up the `innodb` inserted row counts of all primary nodes of the instance | Rows | InstanceId |
| `InnodbRowsRead` | `innodb` read rows count    | Instance-level monitoring metric, calculated by summing up the `innodb` read row counts of all primary and secondary nodes of the instance | Rows | InstanceId |
| `InnodbRowsUpdated` | `innodb` updated rows count  | Instance-level monitoring metric, calculated by summing up the `innodb` updated row counts of all primary nodes of the instance | Rows | InstanceId |
| InsertTotal | INSERT request count            | Instance-level monitoring metric, calculated by summing up the INSERT request counts of all primary nodes of the instance | Times/second | InstanceId |
| LongQueryCount | Slow query count                 | Instance-level monitoring metric, calculated by summing up the slow query counts of all primary nodes of the instance | Times | InstanceId |
| MemAvailable | Available cache space             | Instance-level monitoring metric, calculated by summing up the available cache space of all primary nodes of the instance | GB | InstanceId |
| MemHitRate | Cache hit rate               | Instance-level monitoring metric, value is the minimum cache hit rate of all primary nodes of the instance | % | InstanceId |
| ReplaceSelectTotal | REPLACE_SELECT request count    | Instance-level monitoring metric, calculated by summing up the REPLACE-SELECT request counts of all primary nodes of the instance | Times/second | InstanceId |
| ReplaceTotal | REPLACE request count           | Instance-level monitoring metric, calculated by summing up the REPLACE request counts of all primary nodes of the instance | Times/second | InstanceId |
| RequestTotal | Total request count                 | Instance-level monitoring metric, calculated by summing up the total request counts of all primary nodes and SELECT request counts of all secondary nodes of the instance | Times/second | InstanceId |
| SelectTotal | SELECT request count            | Instance-level monitoring metric, calculated by summing up the SELECT request counts of all primary and secondary nodes of the instance | Times/second | InstanceId |
| SlaveDelay | Replica delay                 | Instance-level monitoring metric, first calculate the replica delay of each shard, then take the maximum value as the replica delay of the instance. The replica delay of a shard is the minimum delay of all replica nodes of that shard | Seconds | InstanceId |
| UpdateTotal | UPDATE request count            | Instance-level monitoring metric, calculated by summing up the UPDATE request counts of all primary nodes of the instance | Times/second | InstanceId |
| ThreadsConnected | Current open connections           | Instance-level monitoring metric, calculated by summing up the current open connection counts of all primary and secondary nodes of the instance | Times | InstanceId |
| ConnMax | Maximum connections               | Instance-level monitoring metric, calculated by summing up the maximum connection counts of all primary and secondary nodes of the instance | Count | InstanceId |
| ClientConnTotal | Total client connections           | Instance-level monitoring metric, calculated by summing up all connections on the instance Proxy. This metric truly shows how many clients are connected to the database instance | Count | InstanceId |
| SQLTotal | Total SQL count                 | Instance-level monitoring metric, indicates how many SQL statements are sent to the database instance          | Statements | InstanceId |
| ErrorSQLTotal | SQL error count               | Instance-level monitoring metric, indicates how many SQL statements executed with errors                  | Statements | InstanceId |
| SuccessSQLTotal | SQL success count               | Instance-level monitoring metric, indicates the number of successfully executed SQL statements                    | Count | InstanceId |
| TimeRange0 | Requests with response time (<5ms)         | Instance-level monitoring metric, indicates the number of requests with response time less than 5ms                | Times/second | InstanceId |
| TimeRange1 | Requests with response time (5~20ms)       | Instance-level monitoring metric, indicates the number of requests with response time between 5-20ms                 | Times/second | InstanceId |
| TimeRange2 | Requests with response time (20~30ms)      | Instance-level monitoring metric, indicates the number of requests with response time between 20-30ms                | Times/second | InstanceId |
| TimeRange3 | Requests with response time (>30ms)     | Instance-level monitoring metric, indicates the number of requests with response time greater than 30ms               | Times/second | InstanceId |
| MasterSwitchedTotal | Master-slave switch count             | Instance-level monitoring metric, indicates the number of times the master-slave switch has occurred                 | Times | InstanceId |
| IOUsageRate | IO utilization                | Instance-level monitoring metric, value is the maximum IO utilization of all primary nodes of the instance | % | InstanceId |
| MaxSlaveCpuUsageRate | Maximum replica node CPU utilization    | Instance-level monitoring metric, value is the maximum CPU utilization of all replica nodes        | % | InstanceId |
| ThreadsRunningCount | Aggregated running threads count           | Instance-level monitoring metric, value is the sum of Threads_running across all nodes of the instance. Threads_running is the result obtained from executing show status like 'Threads_running' | Count | InstanceId |

## Objects {#object}

The collected Tencent Cloud MariaDB object data structure can be viewed in "Infrastructure - Custom"

```json
{
  "measurement": "tencentcloud_mariadb",
  "tags": {
    "AppId": "1311xxx185",
    "AutoRenewFlag" : "0",
    "DbEngine"      : "MariaDB",
    "DbVersion"     : "10.1",
    "DbVersionId"   : "10.1",
    "InstanceId"    : "tdsql-ewqokixxxxxhu",
    "InstanceName"  : "tdsql-ewqoxxxxxxihu",
    "InstanceType"  : "2",
    "Paymode"       : "postpaid",
    "ProjectId"     : "0",
    "RegionId"      : "ap-shanghai",
    "Status"        : "0",
    "StatusDesc"    : "Creating",
    "TdsqlVersion"  : "Based on MariaDB 10.1 design (compatible with MySQL 5.6)",
    "Uin"           : "100xxxx113474",
    "Vip"           : "",
    "Vport"         : "3306",
    "WanDomain"     : "",
    "WanPort"       : "0",
    "WanVip"        : "",
    "Zone"          : "ap-shanghai-5",
    "name"          : "tdsql-ewqokihu",
    "WanVIP"        : ""
  },
  "fields": {
    "Cpu"           : 1,
    "CreateTime"    : "2023-08-17 17:55:03",
    "Memory"        : 2,
    "NodeCount"     : 2,
    "PeriodEndTime" : "0001-01-01 00:00:00",
    "Qps"           : 2100,
    "Storage"       : 10,
    "UpdateTime"    : "2023-08-17 17:55:03",
    "message"       : "{instance JSON data}"
  }
}

```

> *Note: Fields in `tags` and `fields` may change with subsequent updates*
>
> Tip 1: `tags.name` value serves as unique identification
>
> Tip 2: `fields.message`, `fields.InstanceNode` are JSON serialized strings
