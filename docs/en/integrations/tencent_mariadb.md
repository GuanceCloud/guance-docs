---
title: 'Tencent Cloud MariaDB'
summary: 'Use the 「Guance Synchronization」 series of script packages in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.'
__int_icon: 'icon/tencent_mariadb'
dashboard:

  - desc: 'Tencent Cloud MariaDB Monitoring View'
    path: 'dashboard/zh/tencent_mariadb'

monitor:
  - desc: 'Tencent MariaDB Monitor'
    path: 'monitor/zh/tencent_mariadb'
---

<!-- markdownlint-disable MD025 -->
# Tencent Cloud MariaDB
<!-- markdownlint-enable -->

Use the 「Guance Synchronization」 series of script packages in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare Tencent AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of  Tencent MariaDB Private resources, we install the corresponding collection script：「Guance Integration（Tencent Cloud-MariaDBCollect）」(ID：`guance_tencentcloud_mariadb`)

Click 【Install】 and enter the corresponding parameters: Tencent AK, Tencent account name.。

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

In addition, the corresponding automatic trigger configuration is displayed in「Management / Crontab Config」. tap【Run】，It can be executed immediately once, without waiting for a periodic time。After a while, you can view task execution records and corresponding logs.


We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-mariadb/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists


## Metric {#metric}
Configure Tencent Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Tencent Cloud Monitor Metrics Details](https://cloud.tencent.com/document/product/248/54397){:target="_blank"}


| Index English name      | Index Chinese name              | Metric specification                        | unit  | Statistical granularity              |
| --------------- | ---------------------- | --------------------------- | ----- | ----------------- |
| `ActiveThreadCount` | Active Thread Count | Instance-level monitoring metric, calculated as the sum of active thread counts across all primary and secondary nodes in the shards. | **indivual** | InstanceId |
| `BinlogDiskAvailable` | Remaining Binlog Disk Space | Instance-level monitoring metric, calculated as the sum of the monitored values of the BinlogDiskAvailableShard metric across all shards. | GB | InstanceId |
| `BinlogUsedDisk` | Used Binlog Disk Space | Instance-level monitoring metric, calculated as the sum of the used Binlog disk space of the primary nodes across all shards. | GB | InstanceId |
| `ConnUsageRate` | DB Connection Usage Rate | Instance-level monitoring metric, taking the maximum value of the DB connection usage rate across all primary and standby nodes of the instance. | % | InstanceId |
| `CpuUsageRate` | CPU Utilization Rate | Instance-level monitoring metric, taking the maximum value of the CPU usage rate across all primary nodes of the instance. | % | InstanceId |
| `DataDiskAvailable` | Available Data Disk Space | Instance-level monitoring metric, calculated by summing up the available data disk space of all primary nodes across various shards. | GB | InstanceId |
| `DataDiskUsedRate` | Data Disk Space Utilization | Instance-level monitoring metric, the value is the maximum data disk space utilization rate among the primary nodes of each shard in the instance. | % | InstanceId |
| `DeleteTotal` | DELETE Request Count | Instance-level monitoring metric, calculated by summing up the DELETE request count from the primary nodes of each shard in the instance. | Times/second | InstanceId |
| `InnodbBufferPoolReads` | `innodb` Disk Read Page Count | Instance-level monitoring metric, calculated by summing up the `InnoDB` disk read page count from the primary and standby nodes of each shard in the instance. | times | InstanceId |
| `InnodbBufferPoolReadAhead` | `innodb` Buffer Pool Read Page Count | Instance-level monitoring metric, calculated by summing up the `InnoDB` buffer pool pre-read page count from the primary and standby nodes of each shard in the instance. | times | InstanceId |
| `InnodbBufferPoolReadRequests` | `innodb` Buffer Pool Read Page Count | Instance-level monitoring metric, calculated by summing up the `InnoDB` buffer pool read page count from the primary and standby nodes of each shard in the instance. | times | InstanceId |
| `InnodbRowsDeleted` | `InnoDB` Delete Rows Count | Instance-level monitoring metric, calculated by summing up the `InnoDB` DELETE rows executed count from the primary nodes of each shard in the instance. | rows | InstanceId |
| `InnodbRowsInserted` | `InnoDB` Insert Rows Count | Instance-level monitoring metric, calculated by summing up the `InnoDB` INSERT rows executed count from the primary nodes of each shard in the instance. | rows | InstanceId |
| `InnodbRowsRead` | `InnoDB` Read Rows Count | Instance-level monitoring metric, calculated by summing up the `InnoDB` READ rows executed count from the primary and standby nodes of each shard in the instance. | rows | InstanceId |
| `InnodbRowsUpdated` | `InnoDB` Update Rows Count | Instance-level monitoring metric, calculated by summing up the `InnoDB` UPDATE rows executed count from the primary nodes of each shard in the instance. | rows | InstanceId |
| `InsertTotal` | Number of INSERT Requests | Instance-level monitoring metric, calculated by summing up the INSERT request count from the primary nodes of each shard in the instance. | Times/second | InstanceId |
| `LongQueryCount` | Number of Slow Queries | Instance-level monitoring metric, calculated by summing up the slow query count from the primary nodes of each shard in the instance. | times | InstanceId |
| `MemAvailable` | Available Cache Space | Instance-level monitoring metric, calculated by summing up the available cache space from the primary nodes of each shard in the instance. | GB | InstanceId |
| `MemHitRate` | Cache Hit Rate | Instance-level monitoring metric, the value of which is the minimum cache hit rate among the primary nodes of each shard in the instance. | % | InstanceId |
| `ReplaceSelectTotal` | REPLACE_SELECT Request Count | Instance-level monitoring metric, calculated by summing up the REPLACE-SELECT request counts from the primary nodes of each shard in the instance. | Times/second | InstanceId |
| `ReplaceTotal` | REPLACE Request Count | Instance-level monitoring metric, calculated by summing up the REPLACE request counts from the primary nodes of each shard in the instance. | Times/second | InstanceId |
| `RequestTotal` | Total Request Count | Instance-level monitoring metric, calculated by summing up the total request counts from all primary nodes and the SELECT request counts from all secondary nodes in the instance. | Times/second | InstanceId |
| `SelectTotal` | SELECT Request Count | Instance-level monitoring metric, calculated by summing up the SELECT request counts from all primary and secondary nodes across all shards in the instance. | Times/second | InstanceId |
| `SlaveDelay` | Secondary Lag    | Instance-level monitoring metric, calculated by first calculating the replication delay for each shard's replicas and then taking the maximum value among them as the replication delay for the instance. The replication delay for a shard is determined by finding the minimum delay among all replicas in that shard. | second | InstanceId |
| `UpdateTotal` | Number of UPDATE Requests | Instance-level monitoring metric, calculated by summing up the number of UPDATE requests across all primary nodes of the shards in the instance. | Times/second | InstanceId |
| `ThreadsConnected` | Current Open Connections | Instance-level monitoring metric, calculated by summing up the current number of open connections across all primary and replica nodes of the shards in the instance. | times | InstanceId |
| `ConnMax` | Maximum Connections | Instance-level monitoring metric, calculated by summing up the maximum connection limit across all primary and replica nodes of the shards in the instance. | **indivual** | InstanceId |
| `ClientConnTotal` | Total Client Connections | Instance-level monitoring metric, calculated by summing up all connections on the instance's proxy. This metric accurately shows how many clients are connected to the database instance. | **indivual** | InstanceId |
| `SQLTotal` | Total SQL Statements | Instance-level monitoring metric that indicates how many SQL statements are sent to the database instance. | items | InstanceId |
| `ErrorSQLTotal` | SQL Error Count | Instance-level monitoring metric that indicates how many SQL statements are executed with errors. | items | InstanceId |
| `SuccessSQLTotal` | SQL Success Count | Instance-level monitoring metric that represents the number of successfully executed SQL statements. | **indivual** | InstanceId |
| `TimeRange0` | Number of Requests with Latency (<5ms) | Instance-level monitoring metric that represents the number of requests with execution time less than 5 ms. | Times/second | InstanceId |
| `TimeRange1` | Number of Requests with Latency (5-20ms) | Instance-level monitoring metric that represents the number of requests with execution time between 5 and 20 ms. | Times/second | InstanceId |
| `TimeRange2` | Number of Requests with Latency (20~30ms) | Instance-level monitoring metric that represents the number of requests with execution time between 20 and 30 ms. | Times/second | InstanceId |
| `TimeRange3` | Number of Requests with Latency (>30ms) | Instance-level monitoring metric that represents the number of requests with execution time greater than 30 ms. | Times/second | InstanceId |
| `MasterSwitchedTotal` | Number of Master-Slave Switches | Instance-level monitoring metric that represents the number of times master-slave switch occurs in the instance. | Times | InstanceId |
| `IOUsageRate` | IO Utilization  | Instance-level monitoring metric, which is the maximum value of I/O utilization across all primary nodes of the shards in the instance. | % | InstanceId |
| `MaxSlaveCpuUsageRate` | Maximum Secondary Node CPU Utilization | Instance-level monitoring metric, which is the maximum value of CPU utilization among all backup nodes in the instance. | % | InstanceId |
| `ThreadsRunningCount` | Sum of Running Threads | Instance-level monitoring metric, calculated as the cumulative value of the Threads_running number from all nodes in the instance. Threads_running is obtained by executing the command "show status like 'Threads_running'". | **indivual** | InstanceId |

## Object {#object}

The collected Tencent Cloud CLB Private object data structure can be seen from the「Infrastructure-Custom」object data

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
    "message"       : "{Instance JSON data}"
  }
}

```

> **Note: Fields in `tags` and `fields` may change in subsequent updates.**
>
> Tip 1: The value of `tags.name` serves as a unique identifier.
>
> Tip 2：`fields.message`、 `fields.InstanceNode` are JSON serialized strings.
