---
title: 'Alibaba Cloud RDS MySQL'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud RDS MySQL Metrics display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc.'
__int_icon: 'icon/aliyun_rds_mysql'
dashboard:
  - desc: 'Alibaba Cloud RDS MySQL built-in views'
    path: 'dashboard/en/aliyun_rds_mysql/'

monitor:
  - desc: 'Alibaba Cloud RDS Monitor'
    path: 'monitor/en/aliyun_rds_mysql/'

cloudCollector:
  desc: 'cloud collector'
  path: 'cloud-collector/en/aliyun_rds_mysql'
---


<!-- markdownlint-disable MD025 -->
# Alibaba Cloud RDS MySQL
<!-- markdownlint-enable -->

Alibaba Cloud RDS MySQL Metrics display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc.

## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> Integration - Extension - Managed Func: all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/)

> It is recommended to deploy the GSE version.

### Installation Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize the monitoring data of RDS cloud resources, we install the corresponding collection script: 「<<< custom_key.brand_name >>> Integration (Alibaba Cloud - RDS Collection)」(ID: `guance_aliyun_rds`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to immediately execute once without waiting for the regular time. After a while, you can view the execution task records and corresponding logs.

We default collect some configurations, for details see the metrics section.

[Configure Custom Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-rds/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」confirm whether the corresponding tasks have corresponding automatic trigger configurations, and at the same time, you can check the corresponding task records and logs to see if there are any abnormalities.
2. In <<< custom_key.brand_name >>>, under 「Infrastructure / Custom」, check if there is asset information.
3. In <<< custom_key.brand_name >>>, under 「Metrics」check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud - Cloud Monitoring, the default Measurement set is as follows, more metrics can be collected through configuration [Alibaba Cloud Cloud Monitoring Metric Details](https://cms.console.aliyun.com/metric-meta/acs_ecs_dashboard/ecs?spm=a2c4g.11186623.0.0.252476abTrNabN){:target="_blank"}

| Metric Id                    |          Metric Name           | Dimensions        | Statistics              | Unit        |
| ---- | :----: | ------ | ------ | ---- |
| `ConnectionUsage`     |          Connection Usage Rate         | userId,instanceId | Average,Minimum,Maximum | %           |
| `CpuUsage`        |           CPU Usage Rate             | userId,instanceId | Average,Minimum,Maximum | %           |
| `DiskUsage`           |           Disk Usage Rate            | userId,instanceId | Average,Minimum,Maximum | %           |
| `IOPSUsage`         |           IOPS Usage Rate            | userId,instanceId | Average,Minimum,Maximum | %           |
| `MemoryUsage`        |           Memory Usage Rate           | userId,instanceId | Average,Minimum,Maximum | %           |
| `MySQL_ComDelete`     |       MySQL Deletes per Second       | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComInsert`    |       MySQL Inserts per Second       | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComInsertSelect`   |    MySQL InsertSelects per Second     | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComReplace`   |       MySQL Replaces per Second      | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComReplaceSelect`  |    MySQL ReplaceSelects per Second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComSelect`  |       MySQL Selects per Second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComUpdate`   |       MySQL Updates per Second       | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_DataDiskSize`    |      MySQL Data Disk Usage       | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| `MySQL_IbufDirtyRatio`  |       MySQL_BP Dirty Page Percentage    | userId,instanceId | Average,Maximum,Minimum | %           |
| `MySQL_IbufReadHit`  |        MySQL_BP Read Hit Rate       | userId,instanceId | Average,Maximum,Minimum | %           |
| `MySQL_IbufRequestR`    |      MySQL Logical Reads per Second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_IbufRequestW`    |      MySQL Logical Writes per Second   | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_IbufUseRatio`   |         MySQL_BP Utilization Rate     | userId,instanceId | Average,Maximum,Minimum | %           |
| `MySQL_InnoDBDataRead`  |   MySQL_InnoDB Data Reads per Second  | userId,instanceId | Average,Maximum,Minimum | **Kbyte**   |
| `MySQL_InnoDBDataWritten` |   MySQL_InnoDB Data Writes per Second  | userId,instanceId | Average,Maximum,Minimum | **Kbyte**   |
| `MySQL_InnoDBLogFsync`   |  MySQL_InnoDB Log fsyncs per Second  | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBLogWriteRequests` | MySQL_InnoDB Log Write Requests per Second | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBLogWrites` | MySQL_InnoDB Physical Log Writes per Second | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowDelete`  |    MySQL_InnoDB Rows Deleted per Second   | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowInsert` |    MySQL_InnoDB Rows Inserted per Second   | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowRead` |    MySQL_InnoDB Rows Read per Second   | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowUpdate` |    MySQL_InnoDB Rows Updated per Second   | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InstanceDiskSize`   |      MySQL Instance Disk Usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| `MySQL_LogDiskSize`   |      MySQL Log Disk Usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| `MySQL_NetworkInNew`   |       MySQL Network Inbound Bandwidth     | userId,instanceId | Average,Minimum,Maximum | bits/s      |
| `MySQL_NetworkOutNew`    |       MySQL Network Outbound Bandwidth     | userId,instanceId | Average,Minimum,Maximum | bits/s      |
| `MySQL_OtherDiskSize`   |      MySQL Other Disk Usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| `MySQL_QPS`    |        MySQL Queries per Second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_SlowQueries`  |       MySQL Slow Queries per Second       | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_TPS`  |        MySQL Transactions per Second       | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_TempDiskTableCreates` |    MySQL Temporary Tables Created per Second     | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ThreadsConnected` |        MySQL Threads Connected       | userId,instanceId | Average,Maximum,Minimum | count       |
| `MySQL_ThreadsRunning` |        MySQL Active Threads       | userId,instanceId | Average,Maximum,Minimum | count       |

## Objects {#object}

The structure of collected Alibaba Cloud SLB object data can be viewed in 「Infrastructure - Custom」.

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
    "ConnectionString" : "{Connection Address JSON Data}",
    "DBInstanceStorage": "100",
    "accounts"         : "{User Permissions Information JSON Data}",
    "databases"        : "{Database Information JSON Data}",
    "SSLExpireTime"    : "2022-10-11T08:16:43Z",
    "message"          : "{Instance JSON Data}",
  }
}
```

## Logs {#logging}

### Slow Query Statistics

#### Prerequisites for Slow Query Statistics

> Note 1: The code execution of this script depends on the collection of RDS instance objects. If the custom object collection for RDS has not been configured, the slow log script cannot collect slow log data.
> Note 2: Due to a 6~8 hour delay in returning statistics from Alibaba Cloud, there may be delays in updating data by the collector. For detailed reference, please consult Alibaba Cloud documentation: Cloud Database RDS Slow Log Statistics Query.
> Note 3: This collector supports all versions of MySQL (except MySQL 5.7 Basic Edition), SQL Server 2008 R2, MariaDB 10.3 type databases. To collect other types of databases, use the [Alibaba Cloud-RDS Slow Query Detail](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-rds-slowlog-record/){:target="_blank"} collector.

#### Slow Query Statistics Installation Script

On top of the previous setup, you need to install another script for collecting **RDS Slow Query Statistics Logs**.

In 「Manage / Script Market」, click and install the corresponding script package:

- 「<<< custom_key.brand_name >>> Integration (Alibaba Cloud - RDS Slow Query Statistics Log Collector)」(ID: `guance_aliyun_rds_slowlog`)

After the data is synchronized normally, you can view the data in the 「Logs」section of <<< custom_key.brand_name >>>.

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
    "message"                      : "{Log JSON Data}"
  }
}

```

Descriptions of some parameters are as follows:

| Field                            | Type | Description                                   |
| :------------------------------ | :--- | :------------------------------------- |
| `SQLServerTotalExecutionTimes`  | int  | SQL Server Execution Duration (Total Value, Milliseconds)      |
| `AvgExecutionTime`              | int  | Execution Time (Average Value) Unit: Seconds             |
| `SQLServerAvgExecutionTime`     | int  | Execution Time (Average Value) Unit: Seconds             |
| `MySQLTotalExecutionTimes`      | int  | MySQL Execution Time (Total Value) Unit: Seconds         |
| `SQLServerTotalExecutionTimes`  | int  | SQL Server Execution Time (Total Value) Unit: Milliseconds |
| `SQLServerTotalExecutionCounts` | int  | SQL Server Execution Count (Total Value)            |
| `MySQLTotalExecutionCounts`     | int  | MySQL Execution Count (Total Value)                 |

> *Note: Fields such as `AvgExecutionTime`, `SQLServerAvgExecutionTime`, `SQLServerTotalExecutionTimes`, etc., are only supported by SQL Server instances.*
> *Note: Fields in `tags` and `fields` may change with subsequent updates.*

### Slow Query Details

#### Prerequisites for Slow Query Details

> Note: The code execution of this script depends on the collection of RDS instance objects. If the custom object collection for RDS has not been configured, the slow log script cannot collect slow log data.

#### Slow Query Details Installation Script

On top of the previous setup, you need to install another script for collecting **RDS Slow Query Details Logs**.

In 「Manage / Script Market」, click and install the corresponding script package:

- 「<<< custom_key.brand_name >>> Integration (Alibaba Cloud - RDS Slow Query Details Log Collector)」(ID: `guance_aliyun_rds_slowlog_record`)

After the data is synchronized normally, you can view the data in the 「Logs」section of <<< custom_key.brand_name >>>.

Configuration [Cloud Database RDS Slow Query Details](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-rds-slowlog-record/){:target="_blank"}

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
    "SQLText"                      : "{SQL Statement}",
    "QueryTimes"                   : 0,
    "QueryTimesMS"                 : 0,
    "ReturnRowCounts"              : 0,
    "ParseRowCounts"               : 0,
    "ExecutionStartTime"           : "2022-02-02T12:00:00Z",
    "CpuTime"                      : 1,
    "RowsAffectedCount"            : 0,
    "LastRowsAffectedCount"        : 0,
    "message"                      : "{Log JSON Data}"
  }
}

```

Descriptions of some parameters are as follows:

| Field                    | Type | Description                       |
| :---------------------- | :--- | :------------------------- |
| `QueryTimes`            | int  | Execution Duration. Unit: Seconds (s)    |
| `QueryTimesMS`          | int  | Execution Duration. Unit: Milliseconds (ms) |
| `ReturnRowCounts`       | int  | Number of Returned Rows                   |
| `ParseRowCounts`        | int  | Number of Parsed Rows                   |
| `ExecutionStartTime`    | str  | Execution Start Time               |
| `CpuTime`               | int  | CPU Processing Time                |
| `RowsAffectedCount`     | int  | Number of Affected Rows                   |
| `LastRowsAffectedCount` | int  | Number of Affected Rows of Last Statement       |

> *Note: Fields such as `CpuTime`, `RowsAffectedCount`, `LastRowsAffectedCount`, etc., are only supported by SQL Server instances.*
> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
> Note: `fields.message` is a JSON serialized string.