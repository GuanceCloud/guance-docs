---
title: 'Alibaba Cloud RDS SQLServer'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud RDS SQLServer Metrics Display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc.'
__int_icon: 'icon/aliyun_rds_sqlserver'
dashboard:
  - desc: 'Alibaba Cloud RDS SQLServer built-in view'
    path: 'dashboard/en/aliyun_rds_sqlserver/'
monitor:
  - desc: 'Alibaba Cloud RDS Monitor'
    path: 'monitor/en/aliyun_rds_sqlserver/'

cloudCollector:
  desc: 'cloud collector'
  path: 'cloud-collector/en/aliyun_rds_sqlserver'
---

<!-- markdownlint-disable MD025 -->

# Alibaba Cloud RDS SQLServer

<!-- markdownlint-enable -->


Alibaba Cloud RDS SQLServer metrics display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc.

## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - managed Func

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Enable Script

> Tip: Please prepare the required Alibaba Cloud AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

#### Managed Version Enable Script

1. Log in to <<< custom_key.brand_name >>> Console
2. Click on the 【Manage】 menu and select 【Cloud Account Management】
3. Click 【Add Cloud Account】, select 【Alibaba Cloud】, fill in the required information on the interface; if cloud account information has been configured before, skip this step
4. Click 【Test】, after a successful test click 【Save】, if the test fails, check whether the related configuration information is correct and retest
5. Click on the 【Cloud Account Management】 list to see the added cloud account, click the corresponding cloud account, and enter the details page
6. Click the 【Integration】 button on the cloud account details page, under the `Not Installed` list, find `Alibaba Cloud RDS SQLServer`, click the 【Install】 button, and install it via the installation interface.

#### Manual Enable Script

1. Log in to the Func console, click 【Script Market】, go to the official script market, search for `guance_aliyun_rds`

2. After clicking 【Install】, input the corresponding parameters: Alibaba Cloud AK ID, AK Secret, and account name.

3. Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

4. After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】, and it will immediately execute once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.
We default collect some configurations, see the metrics section for details.

[Configure Custom Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-rds/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm that the corresponding tasks have corresponding automatic trigger configurations, and at the same time, you can view the corresponding task records and log checks for any anomalies
2. In <<< custom_key.brand_name >>>, 「Infrastructure / Custom」 check if there are asset information
3. In <<< custom_key.brand_name >>>, 「Metrics」 check if there are corresponding monitoring data

## Metrics {#metric}
After configuring Alibaba Cloud - Cloud Monitoring, the default metric set is as follows, more metrics can be collected through configuration [Alibaba Cloud Cloud Monitoring Metric Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id              | Metric Name           | Dimensions        | Statistics              | Unit        |
| ---- | ------ | ------ | ---- | ---- |
| SQLServer_CpuUsage | SQLServerCpu Usage Rate    | userId,instanceId | Average,Maximum,Minimum | %           |
| SQLServer_DiskUsage | SQLServer Disk Usage Rate   | userId,instanceId | Average,Maximum,Minimum | %           |
| SQLServer_IOPS     | SQLServer IO per Second   | userId,instanceId | Average,Maximum,Minimum | countSecond |
| SQLServer_NetworkRead | SQLServer Network Outbound Bandwidth | userId,instanceId | Average,Maximum,Minimum | bits/s      |
| SQLServer_NetworkWrite | SQLServer Network Inbound Bandwidth | userId,instanceId | Average,Maximum,Minimum | bits/s      |
| SQLServer_QPS     | SQLServer Queries per Second   | userId,instanceId | Average,Maximum,Minimum | countSecond |
| SQLServer_TPS     | SQLServer Transactions per Second   | userId,instanceId | Average,Maximum,Minimum | countSecond |
| SQLServer_TotalConn | SQLServer Total Connections     | userId,instanceId | Average,Maximum,Minimum | count       |

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
    "ConnectionString" : "{Connection Address JSON Data}",
    "DBInstanceStorage": "100",
    "accounts"         : "{User Permission Information JSON Data}",
    "databases"        : "{Database Information JSON Data}",
    "SSLExpireTime"    : "2022-10-11T08:16:43Z",
    "message"          : "{Instance JSON Data}",
  }
}

```

## Logs {#logging}

### Slow Query Statistics

#### Prerequisites for Slow Query Statistics

> Tip 1: The code execution of this script depends on RDS instance object collection. If RDS custom object collection is not configured, the slow log script cannot collect slow log data.
> Tip 2: Due to the 6~8 hour delay in returning statistics data from Alibaba Cloud, the collector updating data may also experience delays. Refer to the Alibaba Cloud documentation: Cloud Database RDS Query Slow Log Statistics for detailed information.
> Tip 3: This collector supports all versions of MySQL (excluding the basic version of MySQL 5.7), SQL Server 2008 R2, MariaDB 10.3 type databases. To collect other types of databases, use the [Alibaba Cloud - RDS Slow Query Detail](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-rds-slowlog-record/){:target="_blank"} collector.

#### Installation Script for Slow Query Statistics

On the previous basis, you need to install another script corresponding to **RDS Slow Query Statistics Log Collection**

In 「Manage / Script Market」, click and install the corresponding script package:

- 「<<< custom_key.brand_name >>> Integration (Alibaba Cloud - RDS Slow Query Statistics Log Collection)」(ID: `guance_aliyun_rds_slowlog`)

After the data is synchronized normally, you can view the data in the 「Logs」 of <<< custom_key.brand_name >>>.

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

Explanation of some parameters:

| Field                            | Type | Description                                   |
| :------------------------------ | :--- | :------------------------------------- |
| `SQLServerTotalExecutionTimes`  | int  | SQL Server execution duration (total value, milliseconds)      |
| `AvgExecutionTime`              | int  | Execution time (average value) unit: seconds             |
| `SQLServerAvgExecutionTime`     | int  | Execution time (average value) unit: seconds             |
| `MySQLTotalExecutionTimes`      | int  | MySQL execution time (total value) unit: seconds         |
| `SQLServerTotalExecutionTimes`  | int  | SQL Server execution time (total value) unit: milliseconds |
| `SQLServerTotalExecutionCounts` | int  | SQL Server execution count (total value)            |
| `MySQLTotalExecutionCounts`     | int  | MySQL execution count (total value)                 |

> *Note: Fields like `AvgExecutionTime`, `SQLServerAvgExecutionTime`, `SQLServerTotalExecutionTimes`, etc., are only supported by SQL Server instances.*
> *Note: Fields in `tags` and `fields` may change with subsequent updates.*

### Slow Query Details

#### Prerequisites for Slow Query Details


> Tip: The code execution of this script depends on RDS instance object collection. If RDS custom object collection is not configured, the slow log script cannot collect slow log data.

#### Installation Script for Slow Query Details

On the previous basis, you need to install another script corresponding to **RDS Slow Query Detail Log Collection**

In 「Manage / Script Market」, click and install the corresponding script package:

- 「<<< custom_key.brand_name >>> Integration (Alibaba Cloud - RDS Slow Query Detail Log Collection)」(ID: `guance_aliyun_rds_slowlog_record`)

After the data is synchronized normally, you can view the data in the 「Logs」 of <<< custom_key.brand_name >>>.

Configuration [Cloud Database RDS Slow Query Detail](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-rds-slowlog-record/){:target="_blank"}

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

Explanation of some parameters:

| Field                    | Type | Description                       |
| :---------------------- | :--- | :------------------------- |
| `QueryTimes`            | int  | Execution duration. Unit: seconds (s)    |
| `QueryTimesMS`          | int  | Execution duration. Unit: milliseconds (ms) |
| `ReturnRowCounts`       | int  | Returned row counts                   |
| `ParseRowCounts`        | int  | Parsed row counts                   |
| `ExecutionStartTime`    | str  | Execution start time               |
| `CpuTime`               | int  | CPU processing duration                |
| `RowsAffectedCount`     | int  | Affected row counts                   |
| `LastRowsAffectedCount` | int  | Last statement affected row counts       |

> *Note: Fields like `CpuTime`, `RowsAffectedCount`, `LastRowsAffectedCount`, etc., are only supported by SQL Server instances.*
> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
> *Tip: `fields.message` is a JSON serialized string