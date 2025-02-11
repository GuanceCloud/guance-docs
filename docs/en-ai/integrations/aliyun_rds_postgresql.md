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

We recommend enabling the Guance integration - Extensions - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/)

> We recommend deploying the GSE version.

### Installation Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data from RDS cloud resources, we install the corresponding collection script: "Guance Integration (Alibaba Cloud - RDS Collection)" (ID: `guance_aliyun_rds`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK and Alibaba Cloud account name.

Click 【Deploy Startup Script】. The system will automatically create a `Startup` script set and configure the startup script accordingly.

Additionally, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click 【Execute】to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

By default, we collect some configurations. For more details, see [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-aliyun-rds/){:target="_blank"}


### Verification

1. Confirm in "Management / Automatic Trigger Configuration" whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any anomalies.
2. In the Guance platform, check under "Infrastructure / Custom" to see if asset information exists.
3. In the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration. [Alibaba Cloud Cloud Monitoring Metrics Details](https://cms.console.aliyun.com/metric-meta/acs_rds_dashboard/postgresql?spm=a2c4g.11186623.0.0.252476abya93cJ){:target="_blank"}

| Metric Name       | Description                          | Unit   | Dimensions     |
| --------------- | ------------------------------------ | ------ | ------------- |
| PG_DBAge        | PG_database age                     | count  | instanceId    |
| PG_InactiveSlots | PG_inactive replication slot count  | count  | instanceId    |
| PG_MaxExecutingSQLTime | PG_slowest SQL execution time   | seconds | instanceId    |
| PG_MaxSlotWalDelay | PG_maximum replication slot delay (MB) | byte | instanceId    |
| PG_ReplayLatency | PG_slowest Standby replay delay (MB) | byte | instanceId    |
| PG_SwellTime    | PG_longest transaction execution time | seconds | instanceId    |
| active_connections_per_cpu | PG_average active connections per CPU | count | instanceId    |
| conn_usgae      | PG_connection usage                  | %      | instanceId    |
| cpu_usage       | PG_CPU usage                         | %      | instanceId    |
| five_seconds_executing_sqls | PG_5-second slow SQLs        | count  | instanceId    |
| iops_usage      | PG_IOPS usage                        | %      | instanceId    |
| local_fs_inode_usage | PG_INODE usage                    | %      | instanceId    |
| local_fs_size_usage | PG_disk space usage                | %      | instanceId    |
| local_pg_wal_dir_size | PG_WAL file size                 | MB     | instanceId    |
| mem_usage       | PG_memory usage                      | %      | instanceId    |
| one_second_executing_sqls | PG_1-second slow SQLs         | count  | instanceId    |
| three_seconds_executing_sqls | PG_3-second slow SQLs       | count  | instanceId    |


## Objects {#object}

The collected Alibaba Cloud RDS PostgreSQL object data structure can be viewed under "Infrastructure - Custom"

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
    "accounts"         : "{user permissions information JSON data}",
    "databases"        : "{database information JSON data}",
    "SSLExpireTime"    : "2022-10-11T08:16:43Z",
    "message"          : "{instance JSON data}",
  }
}

```


## Logging {#logging}

### Slow Query Statistics

#### Prerequisites for Slow Query Statistics

> Note 1: This script depends on the collection of RDS instance objects. If RDS custom object collection is not configured, the slow log script cannot collect slow log data.
> Note 2: Due to a 6~8 hour delay in returning statistics from Alibaba Cloud, the collector's data update may be delayed. Refer to the Alibaba Cloud documentation: Cloud Database RDS Slow Log Statistics Query.
> Note 3: This collector supports all versions of MySQL (except the basic edition of MySQL 5.7), SQL Server 2008 R2, MariaDB 10.3 types of databases. To collect other types of database logs, use the [Alibaba Cloud-RDS Slow Query Detail Logs](https://func.guance.com/doc/script-market-guance-aliyun-rds-slowlog-record/){:target="_blank"} collector.

#### Slow Query Statistics Installation Script

On top of the existing setup, you need to install a script for collecting **RDS slow query statistics logs**.

In "Management / Script Market", click and install the corresponding script package:

- "Guance Integration (Alibaba Cloud - RDS Slow Query Statistics Log Collection)" (ID: `guance_aliyun_rds_slowlog`)

After the data is synchronized normally, you can view the data in the "Logs" section of Guance.

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
    "message"                      : "{log JSON data}"
  }
}

```

Part of the parameter descriptions are as follows:

| Field                            | Type | Description                                   |
| :------------------------------ | :--- | :------------------------------------- |
| `SQLServerTotalExecutionTimes`  | int  | SQL Server execution duration (total, milliseconds)      |
| `AvgExecutionTime`              | int  | Execution time (average value) unit: seconds             |
| `SQLServerAvgExecutionTime`     | int  | Execution time (average value) unit: seconds             |
| `MySQLTotalExecutionTimes`      | int  | MySQL execution time (total) unit: seconds         |
| `SQLServerTotalExecutionTimes`  | int  | SQL Server execution time (total) unit: milliseconds |
| `SQLServerTotalExecutionCounts` | int  | SQL Server execution counts (total)            |
| `MySQLTotalExecutionCounts`     | int  | MySQL execution counts (total)                 |

> *Note: `AvgExecutionTime`, `SQLServerAvgExecutionTime`, `SQLServerTotalExecutionTimes`, etc., fields are only supported by SQL Server instances.*
> *Note: Fields in `tags` and `fields` may change with subsequent updates.*

### Slow Query Details

#### Prerequisites for Slow Query Details

> Note: This script depends on the collection of RDS instance objects. If RDS custom object collection is not configured, the slow log script cannot collect slow log data.

#### Slow Query Details Installation Script

On top of the existing setup, you need to install a script for collecting **RDS slow query detail logs**.

In "Management / Script Market", click and install the corresponding script package:

- "Guance Integration (Alibaba Cloud - RDS Slow Query Detail Log Collection)" (ID: `guance_aliyun_rds_slowlog_record`)

After the data is synchronized normally, you can view the data in the "Logs" section of Guance.

Configure [Cloud Database RDS Slow Query Details](https://func.guance.com/doc/script-market-guance-aliyun-rds-slowlog-record/){:target="_blank"}

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
    "message"                      : "{log JSON data}"
  }
}

```


Part of the parameter descriptions are as follows:

| Field                    | Type | Description                       |
| :---------------------- | :--- | :------------------------- |
| `QueryTimes`            | int  | Execution duration. Unit: seconds (s)    |
| `QueryTimesMS`          | int  | Execution duration. Unit: milliseconds (ms) |
| `ReturnRowCounts`       | int  | Number of returned rows                   |
| `ParseRowCounts`        | int  | Number of parsed rows                   |
| `ExecutionStartTime`    | str  | Start execution time               |
| `CpuTime`               | int  | CPU processing duration                |
| `RowsAffectedCount`     | int  | Number of affected rows                   |
| `LastRowsAffectedCount` | int  | Number of affected rows of the last statement       |

> *Note: `CpuTime`, `RowsAffectedCount`, `LastRowsAffectedCount`, etc., fields are only supported by SQL Server instances.*
> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
> Note: `fields.message` is a serialized JSON string