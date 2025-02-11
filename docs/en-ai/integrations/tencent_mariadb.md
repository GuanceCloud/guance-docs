---
title: 'Tencent Cloud MariaDB'
tags: 
  - Tencent Cloud
summary: 'Use the "Guance Cloud Sync" series of script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/tencent_mariadb'
dashboard:

  - desc: 'Tencent Cloud MariaDB built-in views'
    path: 'dashboard/en/tencent_mariadb'

monitor:
  - desc: 'Tencent MariaDB Monitor'
    path: 'monitor/en/tencent_mariadb'
---

<!-- markdownlint-disable MD025 -->
# Tencent Cloud MariaDB
<!-- markdownlint-enable -->

Use the "Guance Cloud Sync" series of script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance

## Configuration {#config}

### Install Func

It is recommended to enable Guance integration - Extension - Managed Func: all prerequisites are automatically installed, please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install MariaDB Collection Script

> Note: Please prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

To synchronize MariaDB monitoring data, we install the corresponding collection script: "Guance Integration (Tencent Cloud-MariaDB Collection)" (ID: `guance_tencentcloud_mariadb`)

Click [Install], then enter the corresponding parameters: Tencent Cloud AK, Tencent Cloud account name.

Click [Deploy Startup Script], the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

After enabling, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click [Execute] to immediately execute it once without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, you should also enable the log collection script. If you need to collect billing information, you should enable the cloud billing collection script.

We default to collecting some configurations, see the metrics section for details [Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-mariadb/){:target="_blank"}

### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Tencent Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration [Tencent Cloud Cloud Monitoring Metric Details](https://cloud.tencent.com/document/product/248/54397){:target="_blank"}

### Monitoring Metrics

| Metric English Name      | Metric Chinese Name             | Meaning                        | Unit  | Dimension              |
| --------------- | ---------------------- | --------------------------- | ----- | ----------------- |
| ActiveThreadCount | Number of Active Threads               | Instance-level monitoring metric, calculated by summing up the number of active threads on all shard master and slave nodes  | Count   | InstanceId |
| BinlogDiskAvailable | Remaining Binlog Log Disk Space | Instance-level monitoring metric, calculated by summing up the BinlogDiskAvailableShard monitoring values of each shard | GB | InstanceId |
| BinlogUsedDisk | Used Binlog Log Disk Space | Instance-level monitoring metric, calculated by summing up the used Binlog log disk space on each shard master node | GB | InstanceId |
| ConnUsageRate | DB Connection Usage Rate            | Instance-level monitoring metric, takes the maximum value of DB connection usage rate across all shard master and slave nodes | % | InstanceId |
| CpuUsageRate | CPU Utilization Rate               | Instance-level monitoring metric, takes the maximum value of CPU utilization rate across all shard master nodes | % | InstanceId |
| DataDiskAvailable | Available Data Disk Space         | Instance-level monitoring metric, calculated by summing up the available data disk space on each shard master node | GB | InstanceId |
| DataDiskUsedRate | Data Disk Space Utilization Rate       | Instance-level monitoring metric, takes the maximum value of data disk space utilization rate across all shard master nodes | % | InstanceId |
| DeleteTotal | DELETE Request Count            | Instance-level monitoring metric, calculated by summing up the DELETE request count on each shard master node | Times/Second | InstanceId |
| `InnodbBufferPoolReads` | `innodb` Disk Page Reads      | Instance-level monitoring metric, calculated by summing up the `innodb` disk page reads on all shard master and slave nodes | Times | InstanceId |
| `InnodbBufferPoolReadAhead` | `innodb` Buffer Pool Pre-read Pages  | Instance-level monitoring metric, calculated by summing up the `innodb` buffer pool pre-read pages on all shard master and slave nodes | Times | InstanceId |
| `InnodbBufferPoolReadRequests` | `innodb` Buffer Pool Page Reads    | Instance-level monitoring metric, calculated by summing up the `innodb` buffer pool page reads on all shard master and slave nodes | Times | InstanceId |
| `InnodbRowsDeleted` | `innodb` Executed DELETE Row Count  | Instance-level monitoring metric, calculated by summing up the `innodb` executed DELETE row count on each shard master node | Rows | InstanceId |
| `InnodbRowsInserted` | `innodb` Executed INSERT Row Count  | Instance-level monitoring metric, calculated by summing up the `innodb` executed INSERT row count on each shard master node | Rows | InstanceId |
| `InnodbRowsRead` | `innodb` Executed READ Row Count    | Instance-level monitoring metric, calculated by summing up the `innodb` executed READ row count on all shard master and slave nodes | Rows | InstanceId |
| `InnodbRowsUpdated` | `innodb` Executed UPDATE Row Count  | Instance-level monitoring metric, calculated by summing up the `innodb` executed UPDATE row count on each shard master node | Rows | InstanceId |
| InsertTotal | INSERT Request Count            | Instance-level monitoring metric, calculated by summing up the INSERT request count on each shard master node | Times/Second | InstanceId |
| LongQueryCount | Slow Query Count                 | Instance-level monitoring metric, calculated by summing up the slow query count on each shard master node | Times | InstanceId |
| MemAvailable | Available Cache Space             | Instance-level monitoring metric, calculated by summing up the available cache space on each shard master node | GB | InstanceId |
| MemHitRate | Cache Hit Rate               | Instance-level monitoring metric, takes the minimum value of cache hit rate across all shard master nodes | % | InstanceId |
| ReplaceSelectTotal | REPLACE_SELECT Request Count    | Instance-level monitoring metric, calculated by summing up the REPLACE-SELECT request count on each shard master node | Times/Second | InstanceId |
| ReplaceTotal | REPLACE Request Count           | Instance-level monitoring metric, calculated by summing up the REPLACE request count on each shard master node | Times/Second | InstanceId |
| RequestTotal | Total Request Count                 | Instance-level monitoring metric, calculated by summing up the total request count on all master nodes and SELECT request count on all slave nodes | Times/Second | InstanceId |
| SelectTotal | SELECT Request Count            | Instance-level monitoring metric, calculated by summing up the SELECT request count on all shard master and slave nodes | Times/Second | InstanceId |
| SlaveDelay | Slave Delay                 | Instance-level monitoring metric, first calculates the delay of each shard, then takes the maximum value as the delay of this instance. The shard delay is the minimum value of delays of all slave nodes in this shard | Seconds | InstanceId |
| UpdateTotal | UPDATE Request Count            | Instance-level monitoring metric, calculated by summing up the UPDATE request count on each shard master node | Times/Second | InstanceId |
| ThreadsConnected | Current Open Connections           | Instance-level monitoring metric, calculated by summing up the current open connections on all shard master and slave nodes | Times | InstanceId |
| ConnMax | Maximum Connections               | Instance-level monitoring metric, calculated by summing up the maximum connections on all shard master and slave nodes | Count | InstanceId |
| ClientConnTotal | Total Client Connections           | Instance-level monitoring metric, calculated by summing up all connections on the instance Proxy. This metric truly shows how many clients are connected to the database instance | Count | InstanceId |
| SQLTotal | Total SQL Count                 | Instance-level monitoring metric, indicates the number of SQL statements sent to the database instance          | Statements | InstanceId |
| ErrorSQLTotal | SQL Error Count               | Instance-level monitoring metric, indicates the number of SQL statements that executed with errors                  | Statements | InstanceId |
| SuccessSQLTotal | SQL Success Count               | Instance-level monitoring metric, indicates the number of successfully executed SQL statements                    | Count | InstanceId |
| TimeRange0 | Request Count (<5ms)         | Instance-level monitoring metric, indicates the number of requests executing within less than 5ms                | Times/Second | InstanceId |
| TimeRange1 | Request Count (5~20ms)       | Instance-level monitoring metric, indicates the number of requests executing between 5-20ms                 | Times/Second | InstanceId |
| TimeRange2 | Request Count (20~30ms)      | Instance-level monitoring metric, indicates the number of requests executing between 20-30ms                | Times/Second | InstanceId |
| TimeRange3 | Request Count (>30ms)     | Instance-level monitoring metric, indicates the number of requests executing greater than 30ms               | Times/Second | InstanceId |
| MasterSwitchedTotal | Master-Slave Switch Count             | Instance-level monitoring metric, indicates the number of times the master-slave switch has occurred                 | Times | InstanceId |
| IOUsageRate | IO Utilization Rate                | Instance-level monitoring metric, takes the maximum value of IO utilization rate across all shard master nodes | % | InstanceId |
| MaxSlaveCpuUsageRate | Maximum Slave Node CPU Utilization Rate    | Instance-level monitoring metric, takes the maximum value of CPU utilization rate across all slave nodes        | % | InstanceId |
| ThreadsRunningCount | Aggregated Running Threads           | Instance-level monitoring metric, takes the sum of Threads_running values across all nodes. Threads_running is the result obtained from executing show status like 'Threads_running' | Count | InstanceId |

## Object {#object}

The collected Tencent Cloud MariaDB object data structure can be seen in "Infrastructure - Custom"

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
    "TdsqlVersion"  : "Designed based on MariaDB 10.1 (compatible with MySQL 5.6)",
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

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: `tags.name` value serves as unique identification.
>
> Tip 2: `fields.message`, `fields.InstanceNode` are JSON serialized strings.