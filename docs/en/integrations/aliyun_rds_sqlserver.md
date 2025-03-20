---
title: 'Alibaba Cloud RDS SQLServer'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud RDS SQLServer Metrics display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc.'
__int_icon: 'icon/aliyun_rds_sqlserver'
dashboard:
  - desc: 'Alibaba Cloud RDS SQLServer built-in views'
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

It is recommended to enable <<< custom_key.brand_name >>> integration - expansion - managed Func: all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

> It is recommended to deploy the GSE version.

### Installation Script

> Note: Please prepare the required Alibaba Cloud AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data of RDS cloud resources, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (Alibaba Cloud - RDS Collection)" (ID: `guance_aliyun_rds`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

We default to collecting some configurations, details are listed under metrics.

[Configure custom cloud object metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-rds/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and you can also check the corresponding task records and logs for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, in "Infrastructure / Custom", check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, in "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud - Cloud Monitoring, the default metric sets are as follows. You can collect more metrics through configuration. [Alibaba Cloud Cloud Monitoring Metric Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id              | Metric Name           | Dimensions        | Statistics              | Unit        |
| ---- | ------ | ------ | ---- | ---- |
| SQLServer_CpuUsage | SQLServerCpu Usage Rate    | userId,instanceId | Average,Maximum,Minimum | %           |
| SQLServer_DiskUsage | SQLServer Disk Usage Rate   | userId,instanceId | Average,Maximum,Minimum | %           |
| SQLServer_IOPS     | SQLServer IO Operations Per Second   | userId,instanceId | Average,Maximum,Minimum | countSecond |
| SQLServer_NetworkRead | SQLServer Network Outbound Bandwidth | userId,instanceId | Average,Maximum,Minimum | bits/s      |
| SQLServer_NetworkWrite | SQLServer Network Inbound Bandwidth | userId,instanceId | Average,Maximum,Minimum | bits/s      |
| SQLServer_QPS     | SQLServer Queries Per Second   | userId,instanceId | Average,Maximum,Minimum | countSecond |
| SQLServer_TPS     | SQLServer Transactions Per Second   | userId,instanceId | Average,Maximum,Minimum | countSecond |
| SQLServer_Tota_Conn | SQLServer Total Connections     | userId,instanceId | Average,Maximum,Minimum | count       |

## Objects {#object}

The collected Alibaba Cloud RDS object data structure can be seen from "Infrastructure - Custom".

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
    "accounts"         : "{JSON user privilege data}",
    "databases"        : "{JSON database data}",
    "SSLExpireTime"    : "2022-10-11T08:16:43Z",
    "message"          : "{JSON instance data}",
  }
}

```

## Logs {#logging}

### Slow Query Statistics

#### Prerequisites for Slow Query Statistics

> Note 1: The code execution of this script depends on the RDS instance object collection. If the custom object collection for RDS is not configured, the slow log script cannot collect slow log data.
> Note 2: Due to the delay of 6~8 hours in returning statistics data from Alibaba Cloud, the collector updating data may have delays. Refer to the Alibaba Cloud documentation: Cloud Database RDS Slow Log Statistics for detailed information.
> Note 3: This collector supports all versions of MySQL (excluding the basic edition of MySQL 5.7), SQL Server 2008 R2, MariaDB 10.3 type databases. To collect other types of databases, use the [Alibaba Cloud - RDS Slow Query Detail](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-rds-slowlog-record/){:target="_blank"} collector.

#### Slow Query Statistics Installation Script

On top of the previous setup, you need to install another script for **RDS Slow Query Statistics Log Collection**.

In "Management / Script Market", click and install the corresponding script package:

- "<<< custom_key.brand_name >>> Integration (Alibaba Cloud - RDS Slow Query Statistics Log Collection)" (ID: `guance_aliyun_rds_slowlog`)

After the data synchronization is normal, you can view the data in the "Logs" section of <<< custom_key.brand_name >>>.

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
| `SQLServerTotalExecutionTimes`  | int  | SQL Server total execution time (milliseconds)      |
| `AvgExecutionTime`              | int  | Execution time (average value) unit: seconds             |
| `SQLServerAvgExecutionTime`     | int  | Execution time (average value) unit: seconds             |
| `MySQLTotalExecutionTimes`      | int  | MySQL total execution time (seconds)         |
| `SQLServerTotalExecutionTimes`  | int  | SQL Server total execution time (milliseconds) |
| `SQLServerTotalExecutionCounts` | int  | SQL Server total execution counts            |
| `MySQLTotalExecutionCounts`     | int  | MySQL total execution counts                 |

> *Note: Fields such as `AvgExecutionTime`, `SQLServerAvgExecutionTime`, `SQLServerTotalExecutionTimes`, etc., are only supported by SQL Server instances.*
> *Note: Fields in `tags` and `fields` may change with subsequent updates.*

### Slow Query Details

#### Prerequisites for Slow Query Details


> Note: The code execution of this script depends on the RDS instance object collection. If the custom object collection for RDS is not configured, the slow log script cannot collect slow log data.

#### Slow Query Details Installation Script

On top of the previous setup, you need to install another script for **RDS Slow Query Details Log Collection**.

In "Management / Script Market", click and install the corresponding script package:

- "<<< custom_key.brand_name >>> Integration (Alibaba Cloud - RDS Slow Query Details Log Collection)" (ID: `guance_aliyun_rds_slowlog_record`)

After the data synchronization is normal, you can view the data in the "Logs" section of <<< custom_key.brand_name >>>.

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
> *Note: `fields.message` is a JSON serialized string.