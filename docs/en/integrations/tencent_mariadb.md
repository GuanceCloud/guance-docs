---
title: 'Tencent Cloud MariaDB'
tags: 
  - Tencent Cloud
summary: 'Use the script market "Guance cloud sync" series script package to synchronize the data of cloud monitoring and cloud assets to Guance'
__int_icon: 'icon/tencent_mariadb'
dashboard:

  - desc: 'Tencent Cloud MariaDB built-in views'
    path: 'dashboard/en/tencent_mariadb'

monitor:
  - desc: 'Tencent MariaDB monitor'
    path: 'monitor/en/tencent_mariadb'
---

<!-- markdownlint-disable MD025 -->
# Tencent Cloud MariaDB
<!-- markdownlint-enable -->

Use the script market "Guance cloud sync" series script package to synchronize the data of cloud monitoring and cloud assets to Guance

## Configuration {#config}

### Install Func

It is recommended to enable Guance integration - extension - hosted Func: all prerequisites are automatically installed, please continue with the script installation

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Install MariaDB collection script

> Note: Please prepare the required Tencent Cloud AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize MariaDB monitoring data, we install the corresponding collection script: "Guance integration (Tencent Cloud-MariaDB collection)" (ID: `guance_tencentcloud_mariadb`)

After clicking 【Install】, enter the corresponding parameters: Tencent Cloud AK, Tencent Cloud account name.

Click 【Deploy startup script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in "Manage / Automatic trigger configuration". Click 【Execute】 to execute immediately without waiting for the scheduled time. Wait for a moment, and you can view the execution task records and corresponding logs.

> If you need to collect the corresponding logs, you also need to enable the corresponding log collection script. If you need to collect billing information, enable the cloud billing collection script.

We default to collecting some configurations, for more details see the metrics section [Customize cloud object metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-mariadb/){:target="_blank"}


### Verification

1. In "Manage / Automatic trigger configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configuration, and at the same time, check the corresponding task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
Configure Tencent Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration [Tencent Cloud Cloud Monitoring Metric Details](https://cloud.tencent.com/document/product/248/54397){:target="_blank"}

### Monitoring Metrics

| Metric Name      | Metric Description             | Meaning                        | Unit  | Dimensions              |
| --------------- | ---------------------- | --------------------------- | ----- | ----------------- |
| ActiveThreadCount | Active Threads               | Instance-level monitoring metric, calculated by summing up active thread counts of all shard master-slave nodes | Count   | InstanceId |
| BinlogDiskAvailable | Remaining Binlog Log Disk Space | Instance-level monitoring metric, calculated by summing up the BinlogDiskAvailableShard monitoring values of each shard | GB | InstanceId |
| BinlogUsedDisk | Used Binlog Log Disk Space | Instance-level monitoring metric, calculated by summing up used Binlog log disk space of the master node of each shard | GB | InstanceId |
| ConnUsageRate | DB Connection Usage Rate            | Instance-level monitoring metric, value taken as the maximum DB connection usage rate of all shard master-slave nodes | % | InstanceId |
| CpuUsageRate | CPU Usage Rate               | Instance-level monitoring metric, value taken as the maximum CPU usage rate of all shard master nodes | % | InstanceId |
| DataDiskAvailable | Available Data Disk Space         | Instance-level monitoring metric, calculated by summing up available data disk space of the master node of each shard | GB | InstanceId |
| DataDiskUsedRate | Data Disk Space Usage Rate       | Instance-level monitoring metric, value taken as the maximum data disk space usage rate of each shard master node | % | InstanceId |
| DeleteTotal | DELETE Request Count            | Instance-level monitoring metric, calculated by summing up DELETE request counts of all shard master nodes | Times/Second | InstanceId |
| `InnodbBufferPoolReads` | `innodb` Disk Read Page Count      | Instance-level monitoring metric, calculated by summing up `innodb` disk read page counts of all shard master-slave nodes | Times | InstanceId |
| `InnodbBufferPoolReadAhead` | `innodb` Buffer Pool Pre-read Page Count  | Instance-level monitoring metric, calculated by summing up `innodb` buffer pool pre-read page counts of all shard master-slave nodes | Times | InstanceId |
| `InnodbBufferPoolReadRequests` | `innodb` Buffer Pool Read Page Count    | Instance-level monitoring metric, calculated by summing up `innodb` buffer pool read page counts of all shard master-slave nodes | Times | InstanceId |
| `InnodbRowsDeleted` | `innodb` Executed DELETE Row Count  | Instance-level monitoring metric, calculated by summing up `innodb` executed DELETE row counts of all shard master nodes | Rows | InstanceId |
| `InnodbRowsInserted` | `innodb` Executed INSERT Row Count  | Instance-level monitoring metric, calculated by summing up `innodb` executed INSERT row counts of all shard master nodes | Rows | InstanceId |
| `InnodbRowsRead` | `innodb` Executed READ Row Count    | Instance-level monitoring metric, calculated by summing up `innodb` executed READ row counts of all shard master-slave nodes | Rows | InstanceId |
| `InnodbRowsUpdated` | `innodb` Executed UPDATE Row Count  | Instance-level monitoring metric, calculated by summing up `innodb` executed UPDATE row counts of all shard master nodes | Rows | InstanceId |
| InsertTotal | INSERT Request Count            | Instance-level monitoring metric, calculated by summing up INSERT request counts of all shard master nodes | Times/Second | InstanceId |
| LongQueryCount | Slow Query Count                 | Instance-level monitoring metric, calculated by summing up slow query counts of all shard master nodes | Times | InstanceId |
| MemAvailable | Available Cache Space             | Instance-level monitoring metric, calculated by summing up available cache space of all shard master nodes | GB | InstanceId |
| MemHitRate | Cache Hit Rate               | Instance-level monitoring metric, value taken as the minimum cache hit rate of each shard master node | % | InstanceId |
| ReplaceSelectTotal | REPLACE_SELECT Request Count    | Instance-level monitoring metric, calculated by summing up REPLACE-SELECT request counts of all shard master nodes | Times/Second | InstanceId |
| ReplaceTotal | REPLACE Request Count           | Instance-level monitoring metric, calculated by summing up REPLACE request counts of all shard master nodes | Times/Second | InstanceId |
| RequestTotal | Total Request Count                 | Instance-level monitoring metric, calculated by summing up total request counts of all master nodes and SELECT request counts of all slave nodes | Times/Second | InstanceId |
| SelectTotal | SELECT Request Count            | Instance-level monitoring metric, calculated by summing up SELECT request counts of all shard master-slave nodes | Times/Second | InstanceId |
| SlaveDelay | Slave Delay                 | Instance-level monitoring metric, first calculate the standby delay of each shard, then take the maximum value as the standby delay of this instance. The standby delay of a shard is the minimum delay of all standby nodes of this shard | Seconds | InstanceId |
| UpdateTotal | UPDATE Request Count            | Instance-level monitoring metric, calculated by summing up UPDATE request counts of all shard master nodes | Times/Second | InstanceId |
| ThreadsConnected | Current Open Connections           | Instance-level monitoring metric, calculated by summing up current open connections of all shard master-slave nodes | Times | InstanceId |
| ConnMax | Maximum Connections               | Instance-level monitoring metric, calculated by summing up maximum connections of all shard master-slave nodes | Count | InstanceId |
| ClientConnTotal | Total Client Connections           | Instance-level monitoring metric, calculated by summing up all connections on the instance Proxy. This metric truly shows how many clients are connected to the database instance | Count | InstanceId |
| SQLTotal | Total SQL Count                 | Instance-level monitoring metric, indicates how many SQL statements are sent to the database instance          | Statements | InstanceId |
| ErrorSQLTotal | SQL Error Count               | Instance-level monitoring metric, indicates how many SQL statements execute errors                  | Statements | InstanceId |
| SuccessSQLTotal | SQL Success Count               | Instance-level monitoring metric, indicates the number of successfully executed SQL statements                    | Count | InstanceId |
| TimeRange0 | Latency (<5ms) Request Count         | Instance-level monitoring metric, indicates the number of requests executing less than 5ms                | Times/Second | InstanceId |
| TimeRange1 | Latency (5~20ms) Request Count       | Instance-level monitoring metric, indicates the number of requests executing between 5-20ms                 | Times/Second | InstanceId |
| TimeRange2 | Latency (20~30ms) Request Count      | Instance-level monitoring metric, indicates the number of requests executing between 20~30ms                | Times/Second | InstanceId |
| TimeRange3 | Latency (>30ms) Request Count     | Instance-level monitoring metric, indicates the number of requests executing greater than 30ms               | Times/Second | InstanceId |
| MasterSwitchedTotal | Master-Slave Switch Count             | Instance-level monitoring metric, indicates the number of times the master-slave switch occurs                 | Times | InstanceId |
| IOUsageRate | IO Usage Rate                | Instance-level monitoring metric, value taken as the maximum IO usage rate of each shard master node | % | InstanceId |
| MaxSlaveCpuUsageRate | Maximum Slave Node CPU Usage Rate    | Instance-level monitoring metric, value taken as the maximum CPU usage rate of all slave nodes        | % | InstanceId |
| ThreadsRunningCount | Aggregated Running Threads Count           | Instance-level monitoring metric, value taken as the sum of Threads_running values of all nodes in the instance. Threads_running is the result obtained by executing show status like 'Threads_running' | Count | InstanceId |

## Objects {#object}

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
    "TdsqlVersion"  : "Based on MariaDB 10.1 design (compatible with Mysql 5.6)",
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
    "message"       : "{Instance JSON data}"
  }
}

```

> *Note: Fields in `tags`, `fields` may change with subsequent updates*
>
> Tip 1: `tags.name` value serves as unique identification
>
> Tip 2: `fields.message`, `fields.InstanceNode` are serialized JSON strings