---
title: 'Alibaba Cloud RDS PostgreSQL'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud RDS PostgreSQL Metrics display, including CPU usage, memory usage, etc.'
__int_icon: 'icon/aliyun_rds_postgresql'
dashboard:
  - desc: 'Alibaba Cloud RDS PostgreSQL built-in views'
    path: 'dashboard/en/aliyun_rds_postgresql/'

monitor:
  - desc: 'Alibaba Cloud RDS PostgreSQL monitor'
    path: 'monitor/en/aliyun_rds_postgresql/'
---


<!-- markdownlint-disable MD025 -->
# Alibaba Cloud RDS PostgreSQL
<!-- markdownlint-enable -->

Alibaba Cloud RDS PostgreSQL Metrics display, including CPU usage, memory usage, etc.

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/)

> It is recommended to deploy the GSE version.

### Installation Script

> Note: Prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize monitoring data of RDS cloud resources, we install the corresponding collection script: "Guance Integration (Alibaba Cloud - RDS Collection)" (ID: `guance_aliyun_rds`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Additionally, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click 【Execute】to immediately execute it without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations; for details, see [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-rds/){:target="_blank"}

### Verification

1. Confirm in "Management / Automatic Trigger Configuration" whether the corresponding task has the corresponding automatic trigger configuration, and check the task records and logs for any anomalies.
2. In the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. In the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration. [Alibaba Cloud Cloud Monitoring Metrics Details](https://cms.console.aliyun.com/metric-meta/acs_rds_dashboard/postgresql?spm=a2c4g.11186623.0.0.252476abya93cJ){:target="_blank"}

| Metric Name  | Description  | Unit  | Dimensions  |
| ---- | :----: | ------ | ------ |
| PG_DBAge | PG Database Age | count | instanceId |
| PG_InactiveSlots | PG Inactive Replication Slots Count | count | instanceId |
| PG_MaxExecutingSQLTime | PG Slowest SQL Execution Time | seconds | instanceId |
| PG_MaxSlotWalDelay | PG Maximum Replication Slot Delay (MB) | byte | instanceId |
| PG_ReplayLatency | PG Slowest Standby Replay Delay (MB) | byte | instanceId |
| PG_SwellTime | PG Longest Transaction Execution Time | seconds | instanceId |
| active_connections_per_cpu | PG Average Active Connections per CPU | count | instanceId |
| conn_usgae | PG Connection Usage Rate | % | instanceId |
| cpu_usage | PG CPU Usage Rate | % | instanceId |
| five_seconds_executing_sqls | PG Five-second Slow SQL | count | instanceId |
| iops_usage | PG IOPS Usage Rate | % | instanceId |
| local_fs_inode_usage | PG INODE Usage Rate | % | instanceId |
| local_fs_size_usage | PG Disk Space Usage Rate | % | instanceId |
| local_pg_wal_dir_size | PG WAL File Size | MB | instanceId |
| mem_usage | PG Memory Usage Rate | % | instanceId |
| one_second_executing_sqls | PG One-second Slow SQL | count | instanceId |
| three_seconds_executing_sqls | PG Three-second Slow SQL | count | instanceId |

## Objects {#object}

The collected Alibaba Cloud RDS PostgreSQL object data structure can be viewed from "Infrastructure - Custom"

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
    "accounts"         : "{user permission JSON data}",
    "databases"        : "{database information JSON data}",
    "SSLExpireTime"    : "2022-10-11T08:16:43Z",
    "message"          : "{instance JSON data}",
  }
}

```

## Logging {#logging}

### Slow Query Statistics

#### Prerequisites for Slow Query Statistics

> Note 1: The code execution of this script depends on the collection of RDS instance objects. If custom object collection for RDS is not configured, the slow log script cannot collect slow log data.
> Note 2: Due to a delay of 6~8 hours in Alibaba Cloud's statistical data return, there may be a delay in the collector updating data. For detailed reference, see Alibaba Cloud documentation: Cloud Database RDS Slow Log Statistics.
> Note 3: This collector supports all versions of MySQL (except Basic Edition MySQL 5.7), SQL Server 2008 R2, MariaDB 10.3 type databases. To collect other types of databases, use the [Alibaba Cloud - RDS Slow Query Detail](https://func.guance.com/doc/script-market-guance-aliyun-rds-slowlog-record/){:target="_blank"} collector.

#### Installation Script for Slow Query Statistics

On top of the previous setup, you need to install a script for **RDS Slow Query Statistics Log Collection**.

In "Management / Script Market", click and install the corresponding script package:

- "Guance Integration (Alibaba Cloud - RDS Slow Query Statistics Log Collection)" (ID: `guance_aliyun_rds_slowlog`)

After the data is synchronized normally, you can view the data in the "Logs" section of Guance.

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

Part of the parameter descriptions are as follows:

| Field                            | Type | Description                                   |
| :------------------------------ | :--- | :------------------------------------- |
| `SQLServerTotalExecutionTimes`  | int  | SQL Server total execution duration (milliseconds)      |
| `AvgExecutionTime`              | int  | Average execution duration (seconds)             |
| `SQLServerAvgExecutionTime`     | int  | Average execution duration (seconds)             |
| `MySQLTotalExecutionTimes`      | int  | MySQL total execution duration (seconds)         |
| `SQLServerTotalExecutionTimes`  | int  | SQL Server total execution duration (milliseconds) |
| `SQLServerTotalExecutionCounts` | int  | SQL Server total execution counts            |
| `MySQLTotalExecutionCounts`     | int  | MySQL total execution counts                 |

> *Note: Fields like `AvgExecutionTime`, `SQLServerAvgExecutionTime`, `SQLServerTotalExecutionTimes`, etc., are only supported by SQL Server instances.*
> *Note: Fields in `tags` and `fields` may change with subsequent updates.*

### Slow Query Details

#### Prerequisites for Slow Query Details

> Note: The code execution of this script depends on the collection of RDS instance objects. If custom object collection for RDS is not configured, the slow log script cannot collect slow log data.

#### Installation Script for Slow Query Details

On top of the previous setup, you need to install a script for **RDS Slow Query Detail Log Collection**.

In "Management / Script Market", click and install the corresponding script package:

- "Guance Integration (Alibaba Cloud - RDS Slow Query Detail Log Collection)" (ID: `guance_aliyun_rds_slowlog_record`)

After the data is synchronized normally, you can view the data in the "Logs" section of Guance.

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

Part of the parameter descriptions are as follows:

| Field                    | Type | Description                       |
| :---------------------- | :--- | :------------------------- |
| `QueryTimes`            | int  | Execution duration (seconds)    |
| `QueryTimesMS`          | int  | Execution duration (milliseconds) |
| `ReturnRowCounts`       | int  | Returned row count                   |
| `ParseRowCounts`        | int  | Parsed row count                   |
| `ExecutionStartTime`    | str  | Execution start time               |
| `CpuTime`               | int  | CPU processing duration                |
| `RowsAffectedCount`     | int  | Affected row count                   |
| `LastRowsAffectedCount` | int  | Last affected row count       |

> *Note: Fields like `CpuTime`, `RowsAffectedCount`, `LastRowsAffectedCount`, etc., are only supported by SQL Server instances.*
> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
> Note: `fields.message` is a JSON serialized string.