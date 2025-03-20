---
title: 'Alibaba Cloud RDS MySQL'
tags: 
  - Alibaba Cloud
summary: 'Display of Alibaba Cloud RDS MySQL Metrics, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc.'
__int_icon: 'icon/aliyun_rds_mysql'
dashboard:
  - desc: 'Built-in views for Alibaba Cloud RDS MySQL'
    path: 'dashboard/en/aliyun_rds_mysql/'

monitor:
  - desc: 'Alibaba Cloud RDS Monitor'
    path: 'monitor/en/aliyun_rds_mysql/'
---


<!-- markdownlint-disable MD025 -->
# Alibaba Cloud RDS MySQL
<!-- markdownlint-enable -->

Display of Alibaba Cloud RDS MySQL Metrics, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc.

## Configuration {#config}

### Install Func

It is recommended to enable Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/)

> GSE version deployment is recommended.

### Installation Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data of RDS cloud resources, we install the corresponding collection script: "Guance Integration (Alibaba Cloud - RDS Collection)" (ID: `guance_aliyun_rds`).

After clicking 【Install】, input the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a while, you can view the execution task records and corresponding logs.

We default collect some configurations; for details, see the metrics section.

[Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-rds/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration, and check the corresponding task records and logs for any abnormalities.
2. On the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, under "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration [Alibaba Cloud Cloud Monitoring Metric Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                    |          Metric Name           | Dimensions        | Statistics              | Unit        |
| ---- | :----: | ------ | ------ | ---- |
| `ConnectionUsage`     |          Connection usage rate         | userId,instanceId | Average,Minimum,Maximum | %           |
| `CpuUsage`        |           CPU usage rate            | userId,instanceId | Average,Minimum,Maximum | %           |
| `DiskUsage`           |           Disk usage rate           | userId,instanceId | Average,Minimum,Maximum | %           |
| `IOPSUsage`         |           IOPS usage rate           | userId,instanceId | Average,Minimum,Maximum | %           |
| `MemoryUsage`        |           Memory usage rate           | userId,instanceId | Average,Minimum,Maximum | %           |
| `MySQL_ComDelete`     |       MySQL Delete per second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComInsert`    |       MySQL Insert per second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComInsertSelect`   |    MySQL InsertSelect per second     | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComReplace`   |       MySQL Replace per second       | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComReplaceSelect`  |    MySQL ReplaceSelect per second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComSelect`  |       MySQL Select per second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComUpdate`   |       MySQL Update per second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_DataDiskSize`    |      MySQL_data disk usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| `MySQL_IbufDirtyRatio`  |       MySQL_BP dirty page percentage       | userId,instanceId | Average,Maximum,Minimum | %           |
| `MySQL_IbufReadHit`  |        MySQL_BP read hit rate        | userId,instanceId | Average,Maximum,Minimum | %           |
| `MySQL_IbufRequestR`    |      MySQL logical read per second       | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_IbufRequestW`    |      MySQL logical write per second       | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_IbufUseRatio`   |         MySQL_BP utilization         | userId,instanceId | Average,Maximum,Minimum | %           |
| `MySQL_InnoDBDataRead`  |   MySQL_InnoDB data read per second   | userId,instanceId | Average,Maximum,Minimum | **Kbyte**   |
| `MySQL_InnoDBDataWritten` |   MySQL_InnoDB data written per second   | userId,instanceId | Average,Maximum,Minimum | **Kbyte**   |
| `MySQL_InnoDBLogFsync`   |  MySQL_InnoDB log fsync per second   | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBLogWriteRequests` | MySQL_InnoDB log write requests per second | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBLogWrites` | MySQL_InnoDB log physical writes per second | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowDelete`  |    MySQL_InnoDB rows deleted per second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowInsert` |    MySQL_InnoDB rows inserted per second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowRead` |    MySQL_InnoDB rows read per second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowUpdate` |    MySQL_InnoDB rows updated per second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InstanceDiskSize`   |      MySQL_instance disk usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| `MySQL_LogDiskSize`   |      MySQL_log disk usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| `MySQL_NetworkInNew`   |       MySQL network inbound bandwidth        | userId,instanceId | Average,Minimum,Maximum | bits/s      |
| `MySQL_NetworkOutNew`    |       MySQL network outbound bandwidth        | userId,instanceId | Average,Minimum,Maximum | bits/s      |
| `MySQL_OtherDiskSize`   |      MySQL_other disk usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| `MySQL_QPS`    |        MySQL queries per second         | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_SlowQueries`  |       MySQL slow queries per second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_TPS`  |        MySQL transactions per second         | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_TempDiskTableCreates` |    MySQL temporary tables created per second     | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ThreadsConnected` |        MySQL_threads connected        | userId,instanceId | Average,Maximum,Minimum | count       |
| `MySQL_ThreadsRunning` |        MySQL_active threads        | userId,instanceId | Average,Maximum,Minimum | count       |

## Objects {#object}

The collected Alibaba Cloud SLB object data structure can be viewed in "Infrastructure - Custom".

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
    "ConnectionString" : "{Connection address JSON data}",
    "DBInstanceStorage": "100",
    "accounts"         : "{User privilege information JSON data}",
    "databases"        : "{Database information JSON data}",
    "SSLExpireTime"    : "2022-10-11T08:16:43Z",
    "message"          : "{Instance JSON data}",
  }
}
```

## Logs {#logging}

### Slow Query Statistics

#### Prerequisites for Slow Query Statistics

> Note 1: The code execution of this script depends on the collection of RDS instance objects. If the custom object collection for RDS is not configured, the slow log script cannot collect slow log data.
> Note 2: Due to a 6~8 hour delay in returning statistics from Alibaba Cloud, the collector's data update may also have a delay. Refer to the Alibaba Cloud documentation: Cloud Database RDS Slow Log Statistics Query.
> Note 3: This collector supports all versions of MySQL (except the basic edition of MySQL 5.7), SQL Server 2008 R2, and MariaDB 10.3 type databases. To collect other types of databases, please use the [Alibaba Cloud - RDS Slow Query Detail](https://func.guance.com/doc/script-market-guance-aliyun-rds-slowlog-record/){:target="_blank"} collector.

#### Slow Query Statistics Installation Script

Based on the previous setup, you need to install another script for **RDS Slow Query Statistics Log Collection**.

In "Management / Script Market," click and install the corresponding script package:

- "Guance Integration (Alibaba Cloud - RDS Slow Query Statistics Log Collection)" (ID: `guance_aliyun_rds_slowlog`)

After the data synchronizes normally, you can view the data in the "Logs" section of Guance.

An example of the reported data is as follows:

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
    "message"                      : "{Log JSON data}"
  }
}

```

Descriptions of some parameters are as follows:

| Field                            | Type | Description                                   |
| :------------------------------ | :--- | :------------------------------------- |
| `SQLServerTotalExecutionTimes`  | int  | Total execution time of SQL Server (in milliseconds)      |
| `AvgExecutionTime`              | int  | Execution time (average value) unit: seconds             |
| `SQLServerAvgExecutionTime`     | int  | Execution time (average value) unit: seconds             |
| `MySQLTotalExecutionTimes`      | int  | Total execution time of MySQL (unit: seconds)         |
| `SQLServerTotalExecutionTimes`  | int  | Total execution time of SQL Server (unit: milliseconds) |
| `SQLServerTotalExecutionCounts` | int  | Total execution count of SQL Server            |
| `MySQLTotalExecutionCounts`     | int  | Total execution count of MySQL                 |

> *Note: Fields such as `AvgExecutionTime`, `SQLServerAvgExecutionTime`, `SQLServerTotalExecutionTimes`, etc., are only supported by SQL Server instances.*
> *Note: Fields in `tags` and `fields` may change with subsequent updates.*

### Slow Query Details

#### Prerequisites for Slow Query Details

> Note: The code execution of this script depends on the collection of RDS instance objects. If the custom object collection for RDS is not configured, the slow log script cannot collect slow log data.

#### Slow Query Details Installation Script

Based on the previous setup, you need to install another script for **RDS Slow Query Details Log Collection**.

In "Management / Script Market," click and install the corresponding script package:

- "Guance Integration (Alibaba Cloud - RDS Slow Query Details Log Collection)" (ID: `guance_aliyun_rds_slowlog_record`)

After the data synchronizes normally, you can view the data in the "Logs" section of Guance.

Configure [Cloud Database RDS Slow Query Details](https://func.guance.com/doc/script-market-guance-aliyun-rds-slowlog-record/){:target="_blank"}

An example of the reported data is as follows:

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
    "message"                      : "{Log JSON data}"
  }
}

```

Descriptions of some fields are as follows:

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

> *Note: Fields such as `CpuTime`, `RowsAffectedCount`, `LastRowsAffectedCount` are only supported by SQL Server instances.*
> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
> Note: `fields.message` is a JSON serialized string.