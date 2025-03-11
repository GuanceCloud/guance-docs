---
title: 'Alibaba Cloud RDS SQLServer'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud RDS SQLServer Metrics display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc.'
__int_icon: 'icon/aliyun_rds_sqlserver'
dashboard:
  - desc: 'Alibaba Cloud RDS SQLServer built-in view'
    path: 'dashboard/en/aliyun_rds_sqlserver/'
monitor:
  - desc: 'Alibaba Cloud RDS monitor'
    path: 'monitor/en/aliyun_rds_sqlserver/'

---

<!-- markdownlint-disable MD025 -->

# Alibaba Cloud RDS SQLServer

<!-- markdownlint-enable -->


Alibaba Cloud RDS SQLServer Metrics display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc.

## Configuration {#config}

### Install Func

It is recommended to enable Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> It is recommended to deploy the GSE version.

### Install Script

> Note: Prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

To synchronize the monitoring data of RDS cloud resources, we install the corresponding collection script:「Guance Integration (Alibaba Cloud - RDS Collection)」(ID: `guance_aliyun_rds`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK and Alibaba Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Additionally, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short wait, you can check the execution task records and corresponding logs.

We collect some configurations by default; see the metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-rds/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」confirm that the corresponding task has the automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. On the Guance platform, under 「Metrics」check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Alibaba Cloud Cloud Monitor, the default metric set is as follows. You can collect more metrics through configuration [Alibaba Cloud Cloud Monitor Metrics Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id              | Metric Name           | Dimensions        | Statistics              | Unit        |
| ---- | ------ | ------ | ---- | ---- |
| SQLServer_CpuUsage | SQLServer CPU Usage   | userId,instanceId | Average,Maximum,Minimum | %           |
| SQLServer_DiskUsage | SQLServer Disk Usage | userId,instanceId | Average,Maximum,Minimum | %           |
| SQLServer_IOPS     | SQLServer IOPS       | userId,instanceId | Average,Maximum,Minimum | countSecond |
| SQLServer_NetworkRead | SQLServer Network Read Bandwidth | userId,instanceId | Average,Maximum,Minimum | bits/s      |
| SQLServer_NetworkWrite | SQLServer Network Write Bandwidth | userId,instanceId | Average,Maximum,Minimum | bits/s      |
| SQLServer_QPS     | SQLServer QPS         | userId,instanceId | Average,Maximum,Minimum | countSecond |
| SQLServer_TPS     | SQLServer TPS         | userId,instanceId | Average,Maximum,Minimum | countSecond |
| SQLServer_Total_Conn | SQLServer Total Connections | userId,instanceId | Average,Maximum,Minimum | count       |

## Objects {#object}

The collected Alibaba Cloud RDS object data structure can be seen from 「Infrastructure - Custom」

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

> Note 1: The code execution of this script depends on the RDS instance object collection. If RDS custom object collection is not configured, the slow log script cannot collect slow log data.
> Note 2: Due to a delay of 6~8 hours in Alibaba Cloud's statistical data return, there may be delays in the collector updating data. For detailed information, refer to the Alibaba Cloud documentation: Cloud Database RDS Slow Log Statistics Query.
> Note 3: This collector supports MySQL all versions (excluding MySQL 5.7 Basic Edition), SQL Server 2008 R2, MariaDB 10.3 type databases. To collect other types of databases, please use the [Alibaba Cloud-RDS Slow Query Details](https://func.guance.com/doc/script-market-guance-aliyun-rds-slowlog-record/){:target="_blank"} collector.

#### Installation Script for Slow Query Statistics

Based on the previous setup, you need to install another script for **RDS Slow Query Statistics Log Collection**

In 「Manage / Script Market」click and install the corresponding script package:

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

Some parameter explanations are as follows:

| Field                            | Type | Description                                   |
| :------------------------------ | :--- | :------------------------------------- |
| `SQLServerTotalExecutionTimes`  | int  | SQL Server total execution time (milliseconds)      |
| `AvgExecutionTime`              | int  | Average execution time (unit: seconds)             |
| `SQLServerAvgExecutionTime`     | int  | Average execution time (unit: seconds)             |
| `MySQLTotalExecutionTimes`      | int  | MySQL total execution time (unit: seconds)         |
| `SQLServerTotalExecutionTimes`  | int  | SQL Server total execution time (unit: milliseconds) |
| `SQLServerTotalExecutionCounts` | int  | SQL Server total execution counts            |
| `MySQLTotalExecutionCounts`     | int  | MySQL total execution counts                 |

> *Note: Fields like `AvgExecutionTime`, `SQLServerAvgExecutionTime`, `SQLServerTotalExecutionTimes`, etc., are supported only by SQL Server instances.*
> *Note: Fields in `tags` and `fields` may change with subsequent updates.*

### Slow Query Details

#### Prerequisites for Slow Query Details


> Note: The code execution of this script depends on the RDS instance object collection. If RDS custom object collection is not configured, the slow log script cannot collect slow log data.

#### Installation Script for Slow Query Details

Based on the previous setup, you need to install another script for **RDS Slow Query Details Log Collection**

In 「Manage / Script Market」click and install the corresponding script package:

- 「Guance Integration (Alibaba Cloud - RDS Slow Query Details Log Collection)」(ID: `guance_aliyun_rds_slowlog_record`)

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

Some parameter explanations are as follows:

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

> *Note: Fields like `CpuTime`, `RowsAffectedCount`, `LastRowsAffectedCount`, etc., are supported only by SQL Server instances.*
> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
> *Note: `fields.message` is a JSON serialized string
