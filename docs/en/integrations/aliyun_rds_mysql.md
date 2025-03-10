---
title: 'Alibaba Cloud RDS MySQL'
tags: 
  - Alibaba Cloud
summary: 'Display of Alibaba Cloud RDS MySQL metrics, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc.'
__int_icon: 'icon/aliyun_rds_mysql'
dashboard:
  - desc: 'Built-in views for Alibaba Cloud RDS MySQL'
    path: 'dashboard/en/aliyun_rds_mysql/'

monitor:
  - desc: 'Alibaba Cloud RDS monitor'
    path: 'monitor/en/aliyun_rds_mysql/'
---


<!-- markdownlint-disable MD025 -->
# Alibaba Cloud RDS MySQL
<!-- markdownlint-enable -->

Display of Alibaba Cloud RDS MySQL metrics, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - Extensions - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/)

> We recommend deploying the GSE version.

### Installation Script

> Note: Prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data from RDS cloud resources, we install the corresponding collection script: "Guance Integration (Alibaba Cloud - RDS Collection)" (ID: `guance_aliyun_rds`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the startup script accordingly.

Additionally, you can see the corresponding automatic trigger configuration in the "Manage / Automatic Trigger Configuration". Clicking 【Execute】will immediately execute it once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

By default, we collect some configurations; see the Metrics section for details.

[Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-rds/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have the automatic trigger configuration and check the task records and logs for any abnormalities.
2. On the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, under "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration. [Alibaba Cloud Cloud Monitoring Metric Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                    |          Metric Name           | Dimensions        | Statistics              | Unit        |
| ---- | :----: | ------ | ------ | ---- |
| `ConnectionUsage`     |          Connection Usage Rate          | userId,instanceId | Average,Minimum,Maximum | %           |
| `CpuUsage`        |           CPU Usage Rate            | userId,instanceId | Average,Minimum,Maximum | %           |
| `DiskUsage`           |           Disk Usage Rate           | userId,instanceId | Average,Minimum,Maximum | %           |
| `IOPSUsage`         |           IOPS Usage Rate           | userId,instanceId | Average,Minimum,Maximum | %           |
| `MemoryUsage`        |           Memory Usage Rate           | userId,instanceId | Average,Minimum,Maximum | %           |
| `MySQL_ComDelete`     |       MySQL Deletes per Second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComInsert`    |       MySQL Inserts per Second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComInsertSelect`   |    MySQL InsertSelects per Second     | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComReplace`   |       MySQL Replaces per Second       | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComReplaceSelect`  |    MySQL ReplaceSelects per Second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComSelect`  |       MySQL Selects per Second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComUpdate`   |       MySQL Updates per Second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_DataDiskSize`    |      MySQL Data Disk Usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| `MySQL_IbufDirtyRatio`  |       MySQL BP Dirty Page Ratio       | userId,instanceId | Average,Maximum,Minimum | %           |
| `MySQL_IbufReadHit`  |        MySQL BP Read Hit Rate        | userId,instanceId | Average,Maximum,Minimum | %           |
| `MySQL_IbufRequestR`    |      MySQL Logical Reads per Second       | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_IbufRequestW`    |      MySQL Logical Writes per Second       | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_IbufUseRatio`   |         MySQL BP Utilization Rate         | userId,instanceId | Average,Maximum,Minimum | %           |
| `MySQL_InnoDBDataRead`  |   MySQL_InnoDB Data Reads per Second   | userId,instanceId | Average,Maximum,Minimum | **Kbyte**   |
| `MySQL_InnoDBDataWritten` |   MySQL_InnoDB Data Writes per Second   | userId,instanceId | Average,Maximum,Minimum | **Kbyte**   |
| `MySQL_InnoDBLogFsync`   |  MySQL_InnoDB Log fsyncs per Second   | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBLogWriteRequests` | MySQL_InnoDB Log Write Requests per Second | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBLogWrites` | MySQL_InnoDB Log Physical Writes per Second | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowDelete`  |    MySQL_InnoDB Rows Deleted per Second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowInsert` |    MySQL_InnoDB Rows Inserted per Second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowRead` |    MySQL_InnoDB Rows Read per Second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowUpdate` |    MySQL_InnoDB Rows Updated per Second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InstanceDiskSize`   |      MySQL Instance Disk Usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| `MySQL_LogDiskSize`   |      MySQL Log Disk Usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| `MySQL_NetworkInNew`   |       MySQL Network Inbound Bandwidth        | userId,instanceId | Average,Minimum,Maximum | bits/s      |
| `MySQL_NetworkOutNew`    |       MySQL Network Outbound Bandwidth        | userId,instanceId | Average,Minimum,Maximum | bits/s      |
| `MySQL_OtherDiskSize`   |      MySQL Other Disk Usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| `MySQL_QPS`    |        MySQL Queries per Second         | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_SlowQueries`  |       MySQL Slow Queries per Second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_TPS`  |        MySQL Transactions per Second         | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_TempDiskTableCreates` |    MySQL Temporary Tables Created per Second     | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ThreadsConnected` |        MySQL Connected Threads        | userId,instanceId | Average,Maximum,Minimum | count       |
| `MySQL_ThreadsRunning` |        MySQL Active Threads        | userId,instanceId | Average,Maximum,Minimum | count       |

## Objects {#object}

The collected Alibaba Cloud SLB object data structure can be viewed under "Infrastructure - Custom".

```json
{
  "measurement": "aliyun_rds",
  "tags": {
    "name"                 : "rm-xxxxx",
    "DBInstanceType"       : "Primary",
    "PayType"              : "Prepaid",
    "Engine"               : "MySQL",
    "DBInstanceClass"      : "rds.mysql.s2.large",
    "DBInstanceId"         : "rm-xxxxx",
    "ZoneId"               : "cn-shanghai-h",
    "RegionId"             : "cn-shanghai",
    "DBInstanceDescription": "Business System",
    "LockMode"             : "Unlock",
    "Category"             : "Basic",
    "ConnectionMode"       : "Standard",
    "DBInstanceNetType"    : "Intranet",
    "DBInstanceStorageType": "local_ssd",
  },
  "fields": {
    "CreationTime"     : "2022-12-13T16:00:00Z",
    "ExpireTime"       : "2022-12-13T16:00:00Z",
    "DiskUsed"         : "10000",
    "BackupSize"       : "10000",
    "LogSize"          : "10000",
    "BackupLogSize"    : "10000",
    "BackupDataSize"   : "10000",
    "ConnectionString" : "{connection address JSON data}",
    "DBInstanceStorage": "100",
    "accounts"         : "{user permission information JSON data}",
    "databases"        : "{database information JSON data}",
    "SSLExpireTime"    : "2022-10-11T08:16:43Z",
    "message"          : "{instance JSON data}",
  }
}
```

## Logs {#logging}

### Slow Query Statistics

#### Prerequisites for Slow Query Statistics

> Note 1: The code execution of this script depends on the collection of RDS instance objects. If RDS custom object collection is not configured, the slow log script cannot collect slow log data.
> Note 2: Due to a delay of 6~8 hours in returning statistics from Alibaba Cloud, the collector's data update may also be delayed. Refer to the Alibaba Cloud documentation: Cloud Database RDS Query Slow Log Statistics for more details.
> Note 3: This collector supports all versions of MySQL (except the Basic Edition of MySQL 5.7), SQL Server 2008 R2, MariaDB 10.3. For other types of databases, use the [Alibaba Cloud-RDS Slow Query Details](https://func.guance.com/doc/script-market-guance-aliyun-rds-slowlog-record/){:target="_blank"} collector.

#### Installation Script for Slow Query Statistics

On top of the previous setup, install the corresponding script for collecting **RDS slow query statistics logs**.

In the "Manage / Script Market", click and install the corresponding script package:

- "Guance Integration (Alibaba Cloud - RDS Slow Query Statistics Log Collection)" (ID: `guance_aliyun_rds_slowlog`)

After data synchronization is successful, you can view the data in the "Logs" section of Guance.

An example of reported data is as follows:

```json
{
  "measurement": "aliyun_rds_slowlog",
  "tags": {
    "name"                 : "rm-xxxxx",
    "DBName"               : "cloudcare_core",
    "DBInstanceId"         : "rm-bp1xxxxxxxxxx",
    "RegionId"             : "cn-hangzhou",
    "DBInstanceType"       : "Primary",
    "PayType"              : "Prepaid",
    "Engine"               : "MySQL",
    "DBInstanceClass"      : "rds.mysql.s2.large",
    "ZoneId"               : "cn-shanghai-h",
    "DBInstanceDescription": "Business System"
  },
  "fields": {
    "SQLHASH"                      : "436f9dd030e0a87920bbcd818b34f271",
    "SQLText"                      : "{SQL statement}",
    "CreateTime"                   : "2022-06-05Z",
    "SQLServerTotalExecutionTimes" : 0,
    "MaxExecutionTime"             : 1,
    "MaxLockTime"                  : 0,
    "AvgExecutionTime"             : 0,
    "MySQLTotalExecutionTimes"     : 0,
    "SQLServerTotalExecutionTimes" : 1,
    "SQLServerTotalExecutionCounts": 0,
    "MySQLTotalExecutionCounts"    : 0,
    "SQLServerAvgExecutionTime"    : 0,
    "message"                      : "{log JSON data}"
  }
}
```

Partial parameter descriptions are as follows:

| Field                            | Type | Description                                   |
| :------------------------------ | :--- | :------------------------------------- |
| `SQLServerTotalExecutionTimes`  | int  | Total execution time for SQL Server (in milliseconds)      |
| `AvgExecutionTime`              | int  | Average execution time (unit: seconds)             |
| `SQLServerAvgExecutionTime`     | int  | Average execution time for SQL Server (unit: seconds)             |
| `MySQLTotalExecutionTimes`      | int  | Total execution time for MySQL (unit: seconds)         |
| `SQLServerTotalExecutionTimes`  | int  | Total execution time for SQL Server (unit: milliseconds) |
| `SQLServerTotalExecutionCounts` | int  | Total execution counts for SQL Server            |
| `MySQLTotalExecutionCounts`     | int  | Total execution counts for MySQL                 |

> *Note: Fields such as `AvgExecutionTime`, `SQLServerAvgExecutionTime`, `SQLServerTotalExecutionTimes`, etc., are only supported by SQL Server instances.*
> *Note: Fields in `tags` and `fields` may change with subsequent updates.*

### Slow Query Details

#### Prerequisites for Slow Query Details

> Note: The code execution of this script depends on the collection of RDS instance objects. If RDS custom object collection is not configured, the slow log script cannot collect slow log data.

#### Installation Script for Slow Query Details

On top of the previous setup, install the corresponding script for collecting **RDS slow query detail logs**.

In the "Manage / Script Market", click and install the corresponding script package:

- "Guance Integration (Alibaba Cloud - RDS Slow Query Detail Log Collection)" (ID: `guance_aliyun_rds_slowlog_record`)

After data synchronization is successful, you can view the data in the "Logs" section of Guance.

Refer to the [Cloud Database RDS Slow Query Details](https://func.guance.com/doc/script-market-guance-aliyun-rds-slowlog-record/){:target="_blank"}

An example of reported data is as follows:

```json
{
  "measurement": "aliyun_rds_slowlog",
  "tags": {
    "name"                 : "rm-xxxxx",
    "DBName"               : "cloudcare_core",
    "DBInstanceId"         : "rm-bp1xxxxxxxxxx",
    "RegionId"             : "cn-hangzhou",
    "DBInstanceType"       : "Primary",
    "PayType"              : "Prepaid",
    "Engine"               : "MySQL",
    "DBInstanceClass"      : "rds.mysql.s2.large",
    "ZoneId"               : "cn-shanghai-h",
    "DBInstanceDescription": "Business System",
    "HostAddress"          : "xxxx",
    "UserName"             : "xxxx",
    "ClientHostName"       : "xxxx",
    "ApplicationName"      : "xxxx",

  },
  "fields": {
    "SQLHASH"                      : "436f9dd030e0a87920bbcd818b34f271",
    "SQLText"                      : "{SQL statement}",
    "QueryTimes"                   : 0,
    "QueryTimesMS"                 : 0,
    "ReturnRowCounts"              : 0,
    "ParseRowCounts"               : 0,
    "ExecutionStartTime"           : "2022-02-02T12:00:00Z",
    "CpuTime"                      : 1,
    "RowsAffectedCount"            : 0,
    "LastRowsAffectedCount"        : 0,
    "message"                      : "{log JSON data}"
  }
}
```

Partial parameter descriptions are as follows:

| Field                    | Type | Description                       |
| :---------------------- | :--- | :------------------------- |
| `QueryTimes`            | int  | Execution duration. Unit: seconds (s)    |
| `QueryTimesMS`          | int  | Execution duration. Unit: milliseconds (ms) |
| `ReturnRowCounts`       | int  | Number of returned rows                   |
| `ParseRowCounts`        | int  | Number of parsed rows                   |
| `ExecutionStartTime`    | str  | Execution start time               |
| `CpuTime`               | int  | CPU processing time                |
| `RowsAffectedCount`     | int  | Number of affected rows                   |
| `LastRowsAffectedCount` | int  | Number of affected rows for the last statement       |

> *Note: Fields such as `CpuTime`, `RowsAffectedCount`, `LastRowsAffectedCount`, etc., are only supported by SQL Server instances.*
> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
> Note: `fields.message` is a JSON serialized string.