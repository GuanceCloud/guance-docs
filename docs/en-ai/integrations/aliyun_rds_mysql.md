---
title: 'Alibaba Cloud RDS MySQL'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud RDS MySQL Metrics Display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc.'
__int_icon: 'icon/aliyun_rds_mysql'
dashboard:
  - desc: 'Alibaba Cloud RDS MySQL built-in views'
    path: 'dashboard/en/aliyun_rds_mysql/'

monitor:
  - desc: 'Alibaba Cloud RDS Monitor'
    path: 'monitor/en/aliyun_rds_mysql/'
---


<!-- markdownlint-disable MD025 -->
# Alibaba Cloud RDS MySQL
<!-- markdownlint-enable -->

Alibaba Cloud RDS MySQL Metrics Display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc.

## Configuration {#config}

### Install Func

We recommend enabling the Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/)

> We recommend deploying the GSE version.

### Install Script

> Note: Prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize monitoring data of RDS cloud resources, we install the corresponding collection script: 「Guance Integration (Alibaba Cloud - RDS Collection)」(ID: `guance_aliyun_rds`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Additionally, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for scheduled times. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations; for details, see the metrics section.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-rds/){:target="_blank"}


### Verification

1. In 「Management / Automatic Trigger Configuration」confirm whether the corresponding automatic trigger configuration exists for the task, and check the task records and logs for any abnormalities.
2. On the Guance platform, under 「Infrastructure / Custom」check if asset information exists.
3. On the Guance platform, under 「Metrics」check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Alibaba Cloud Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration. [Alibaba Cloud Cloud Monitoring Metrics Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

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
| `MySQL_IbufDirtyRatio`  |       MySQL BP Dirty Page Percentage       | userId,instanceId | Average,Maximum,Minimum | %           |
| `MySQL_IbufReadHit`  |        MySQL BP Read Hit Rate        | userId,instanceId | Average,Maximum,Minimum | %           |
| `MySQL_IbufRequestR`    |      MySQL Logical Reads per Second       | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_IbufRequestW`    |      MySQL Logical Writes per Second       | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_IbufUseRatio`   |         MySQL BP Utilization Rate         | userId,instanceId | Average,Maximum,Minimum | %           |
| `MySQL_InnoDBDataRead`  |   MySQL InnoDB Data Reads per Second   | userId,instanceId | Average,Maximum,Minimum | **Kbyte**   |
| `MySQL_InnoDBDataWritten` |   MySQL InnoDB Data Writes per Second   | userId,instanceId | Average,Maximum,Minimum | **Kbyte**   |
| `MySQL_InnoDBLogFsync`   |  MySQL InnoDB Log fsyncs per Second   | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBLogWriteRequests` | MySQL InnoDB Log Write Requests per Second | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBLogWrites` | MySQL InnoDB Log Physical Writes per Second | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowDelete`  |    MySQL InnoDB Rows Deleted per Second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowInsert` |    MySQL InnoDB Rows Inserted per Second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowRead` |    MySQL InnoDB Rows Read per Second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowUpdate` |    MySQL InnoDB Rows Updated per Second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
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

The collected Alibaba Cloud SLB object data structure can be viewed in 「Infrastructure - Custom」

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
    "ConnectionString" : "{JSON connection address data}",
    "DBInstanceStorage": "100",
    "accounts"         : "{JSON user permission data}",
    "databases"        : "{JSON database data}",
    "SSLExpireTime"    : "2022-10-11T08:16:43Z",
    "message"          : "{JSON instance data}",
  }
}
```

## Logs {#logging}

### Slow Query Statistics

#### Prerequisites for Slow Query Statistics

> Note 1: This script depends on the collection of RDS instance objects. If RDS custom object collection is not configured, the slow log script cannot collect slow log data.
> Note 2: Due to a delay of 6~8 hours in Alibaba Cloud's statistical data return, there may be delays in the collector updating data. For detailed reference, see Alibaba Cloud documentation: Cloud Database RDS Slow Query Log Statistics.
> Note 3: This collector supports MySQL all versions (excluding MySQL 5.7 Basic Edition), SQL Server 2008 R2, MariaDB 10.3 type databases. To collect other types of databases, please use the [Alibaba Cloud-RDS Slow Query Details](https://func.guance.com/doc/script-market-guance-aliyun-rds-slowlog-record/){:target="_blank"} collector.

#### Installation Script for Slow Query Statistics

On top of the existing setup, you need to install a script for collecting RDS slow query statistics logs.

In 「Management / Script Market」click and install the corresponding script package:

- 「Guance Integration (Alibaba Cloud - RDS Slow Query Statistics Log Collection)」(ID: `guance_aliyun_rds_slowlog`)

After data synchronization, you can view the data in the 「Logs」section of Guance.

Sample reported data:

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
    "SQLText"                      : "{SQL Statement}",
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
    "message"                      : "{JSON log data}"
  }
}
```

Some parameter explanations:

| Field                            | Type | Description                                   |
| :------------------------------ | :--- | :------------------------------------- |
| `SQLServerTotalExecutionTimes`  | int  | SQL Server Execution Time (total value, milliseconds)      |
| `AvgExecutionTime`              | int  | Execution Time (average value) unit: seconds             |
| `SQLServerAvgExecutionTime`     | int  | Execution Time (average value) unit: seconds             |
| `MySQLTotalExecutionTimes`      | int  | MySQL Execution Time (total value) unit: seconds         |
| `SQLServerTotalExecutionTimes`  | int  | SQL Server Execution Time (total value) unit: milliseconds |
| `SQLServerTotalExecutionCounts` | int  | SQL Server Execution Count (total value)            |
| `MySQLTotalExecutionCounts`     | int  | MySQL Execution Count (total value)                 |

> *Note: Fields like `AvgExecutionTime`, `SQLServerAvgExecutionTime`, `SQLServerTotalExecutionTimes`, etc., are only supported by SQL Server instances.*
> *Note: The fields in `tags` and `fields` may change with subsequent updates.*

### Slow Query Details

#### Prerequisites for Slow Query Details

> Note: This script depends on the collection of RDS instance objects. If RDS custom object collection is not configured, the slow log script cannot collect slow log data.

#### Installation Script for Slow Query Details

On top of the existing setup, you need to install a script for collecting RDS slow query detail logs.

In 「Management / Script Market」click and install the corresponding script package:

- 「Guance Integration (Alibaba Cloud - RDS Slow Query Detail Log Collection)」(ID: `guance_aliyun_rds_slowlog_record`)

After data synchronization, you can view the data in the 「Logs」section of Guance.

Configure [Cloud Database RDS Slow Query Details](https://func.guance.com/doc/script-market-guance-aliyun-rds-slowlog-record/){:target="_blank"}

Sample reported data:

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
    "SQLText"                      : "{SQL Statement}",
    "QueryTimes"                   : 0,
    "QueryTimesMS"                 : 0,
    "ReturnRowCounts"              : 0,
    "ParseRowCounts"               : 0,
    "ExecutionStartTime"           : "2022-02-02T12:00:00Z",
    "CpuTime"                      : 1,
    "RowsAffectedCount"            : 0,
    "LastRowsAffectedCount"        : 0,
    "message"                      : "{JSON log data}"
  }
}
```

Some parameter explanations:

| Field                    | Type | Description                       |
| :---------------------- | :--- | :------------------------- |
| `QueryTimes`            | int  | Execution time. Unit: seconds (s)    |
| `QueryTimesMS`          | int  | Execution time. Unit: milliseconds (ms) |
| `ReturnRowCounts`       | int  | Returned row count                   |
| `ParseRowCounts`        | int  | Parsed row count                   |
| `ExecutionStartTime`    | str  | Execution start time               |
| `CpuTime`               | int  | CPU processing time                |
| `RowsAffectedCount`     | int  | Affected row count                   |
| `LastRowsAffectedCount` | int  | Last statement affected row count       |

> *Note: Fields like `CpuTime`, `RowsAffectedCount`, `LastRowsAffectedCount`, etc., are only supported by SQL Server instances.*
> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
> Note: `fields.message` is a JSON serialized string.