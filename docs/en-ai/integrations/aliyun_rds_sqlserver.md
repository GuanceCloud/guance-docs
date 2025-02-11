---
title: 'Alibaba Cloud RDS SQLServer'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud RDS SQLServer Metrics display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc.'
__int_icon: 'icon/aliyun_rds_sqlserver'
dashboard:
  - desc: 'Built-in views for Alibaba Cloud RDS SQLServer'
    path: 'dashboard/en/aliyun_rds_sqlserver/'
monitor:
  - desc: 'Alibaba Cloud RDS Monitor'
    path: 'monitor/en/aliyun_rds_sqlserver/'

---

<!-- markdownlint-disable MD025 -->

# Alibaba Cloud RDS SQLServer

<!-- markdownlint-enable -->


Alibaba Cloud RDS SQLServer Metrics display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc.

## Configuration {#config}

### Install Func

We recommend enabling the Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> We recommend deploying the GSE version.

### Install Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize RDS cloud resource monitoring data, we install the corresponding collection script: 「Guance Integration (Alibaba Cloud - RDS Collection)」(ID: `guance_aliyun_rds`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Additionally, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

We default to collecting some configurations; see the metrics section for details.

[Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-rds/){:target="_blank"}


### Verification

1. Confirm in 「Management / Automatic Trigger Configuration」whether the corresponding tasks have the corresponding automatic trigger configurations, and check the corresponding task records and logs for any anomalies.
2. On the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. On the Guance platform, under 「Metrics」, check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Alibaba Cloud Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration. [Alibaba Cloud Cloud Monitoring Metric Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id              | Metric Name           | Dimensions        | Statistics              | Unit        |
| ---- | ------ | ------ | ---- | ---- |
| SQLServer_CpuUsage | SQLServer CPU Usage    | userId,instanceId | Average,Maximum,Minimum | %           |
| SQLServer_DiskUsage | SQLServer Disk Usage   | userId,instanceId | Average,Maximum,Minimum | %           |
| SQLServer_IOPS     | SQLServer IOPS         | userId,instanceId | Average,Maximum,Minimum | countSecond |
| SQLServer_NetworkRead | SQLServer Network Outbound Bandwidth | userId,instanceId | Average,Maximum,Minimum | bits/s      |
| SQLServer_NetworkWrite | SQLServer Network Inbound Bandwidth | userId,instanceId | Average,Maximum,Minimum | bits/s      |
| SQLServer_QPS     | SQLServer QPS          | userId,instanceId | Average,Maximum,Minimum | countSecond |
| SQLServer_TPS     | SQLServer TPS          | userId,instanceId | Average,Maximum,Minimum | countSecond |
| SQLServer_Total_Conn | SQLServer Total Connections | userId,instanceId | Average,Maximum,Minimum | count       |

## Objects {#object}

The collected Alibaba Cloud RDS object data structure can be viewed from 「Infrastructure - Custom」

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
    "accounts"         : "{JSON user permission information}",
    "databases"        : "{JSON database information}",
    "SSLExpireTime"    : "2022-10-11T08:16:43Z",
    "message"          : "{JSON instance data}",
  }
}

```

## Logs {#logging}

### Slow Query Statistics

#### Prerequisites for Slow Query Statistics

> Note 1: This script depends on the collection of RDS instance objects. If RDS custom object collection is not configured, the slow log script cannot collect slow log data.
> Note 2: Due to a delay of 6~8 hours in returning statistics data from Alibaba Cloud, there may be delays in the collector updating data. Refer to the Alibaba Cloud documentation: Cloud Database RDS Slow Log Statistics Query.
> Note 3: This collector supports MySQL all versions (excluding MySQL 5.7 Basic Edition), SQL Server 2008 R2, MariaDB 10.3 types of databases. For other types of databases, use the [Alibaba Cloud - RDS Slow Query Detail](https://func.guance.com/doc/script-market-guance-aliyun-rds-slowlog-record/){:target="_blank"} collector.

#### Installation Script for Slow Query Statistics

On top of the existing setup, you need to install another script for **RDS Slow Query Statistics Log Collection**.

In 「Management / Script Market」, click and install the corresponding script package:

- 「Guance Integration (Alibaba Cloud - RDS Slow Query Statistics Log Collection)」(ID: `guance_aliyun_rds_slowlog`)

After data synchronization, you can view the data in the 「Logs」section of Guance.

Example of reported data:

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
    "message"                      : "{JSON log data}"
  }
}

```

Parameter explanations:

| Field                            | Type | Description                                   |
| :------------------------------ | :--- | :------------------------------------- |
| `SQLServerTotalExecutionTimes`  | int  | SQL Server Execution Time (total, milliseconds)      |
| `AvgExecutionTime`              | int  | Execution Time (average) unit: seconds             |
| `SQLServerAvgExecutionTime`     | int  | Execution Time (average) unit: seconds             |
| `MySQLTotalExecutionTimes`      | int  | MySQL Execution Time (total) unit: seconds         |
| `SQLServerTotalExecutionTimes`  | int  | SQL Server Execution Time (total) unit: milliseconds |
| `SQLServerTotalExecutionCounts` | int  | SQL Server Execution Counts (total)            |
| `MySQLTotalExecutionCounts`     | int  | MySQL Execution Counts (total)                 |

> *Note: `AvgExecutionTime`, `SQLServerAvgExecutionTime`, `SQLServerTotalExecutionTimes`, etc., fields are only supported by SQL Server instances.*
> *Note: Fields in `tags` and `fields` may change with subsequent updates.*

### Slow Query Details

#### Prerequisites for Slow Query Details

> Note: This script depends on the collection of RDS instance objects. If RDS custom object collection is not configured, the slow log script cannot collect slow log data.

#### Installation Script for Slow Query Details

On top of the existing setup, you need to install another script for **RDS Slow Query Detail Log Collection**.

In 「Management / Script Market」, click and install the corresponding script package:

- 「Guance Integration (Alibaba Cloud - RDS Slow Query Detail Log Collection)」(ID: `guance_aliyun_rds_slowlog_record`)

After data synchronization, you can view the data in the 「Logs」section of Guance.

Configuration [Cloud Database RDS Slow Query Details](https://func.guance.com/doc/script-market-guance-aliyun-rds-slowlog-record/){:target="_blank"}

Example of reported data:

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
    "message"                      : "{JSON log data}"
  }
}

```

Parameter explanations:

| Field                    | Type | Description                       |
| :---------------------- | :--- | :------------------------- |
| `QueryTimes`            | int  | Execution Time. Unit: seconds (s)    |
| `QueryTimesMS`          | int  | Execution Time. Unit: milliseconds (ms) |
| `ReturnRowCounts`       | int  | Returned Row Count                   |
| `ParseRowCounts`        | int  | Parsed Row Count                   |
| `ExecutionStartTime`    | str  | Execution Start Time               |
| `CpuTime`               | int  | CPU Processing Time                |
| `RowsAffectedCount`     | int  | Affected Row Count                   |
| `LastRowsAffectedCount` | int  | Last Statement Affected Row Count       |

> *Note: `CpuTime`, `RowsAffectedCount`, `LastRowsAffectedCount` fields are only supported by SQL Server instances.*
> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
> *Note: `fields.message` is a JSON serialized string