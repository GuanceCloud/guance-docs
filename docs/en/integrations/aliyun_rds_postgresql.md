---
title: 'Alibaba Cloud RDS PostgreSQL'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud RDS PostgreSQL Metrics Display, including CPU usage, memory usage, etc.'
__int_icon: 'icon/aliyun_rds_postgresql'
dashboard:
  - desc: 'Alibaba Cloud RDS PostgreSQL built-in views'
    path: 'dashboard/en/aliyun_rds_postgresql/'

monitor:
  - desc: 'Alibaba Cloud RDS PostgreSQL monitors'
    path: 'monitor/en/aliyun_rds_postgresql/'
---


<!-- markdownlint-disable MD025 -->
# Alibaba Cloud RDS PostgreSQL
<!-- markdownlint-enable -->

Alibaba Cloud RDS PostgreSQL Metrics Display, including CPU usage, memory usage, etc.

## Configuration {#config}

### Install Func

It is recommended to activate the <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/)

> It is recommended to deploy the GSE version.

### Installation Script

> Note: Please prepare an appropriate Alibaba Cloud AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data of RDS cloud resources, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (Alibaba Cloud - RDS Collection)" (ID: `guance_aliyun_rds`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK and Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Clicking 【Execute】 will immediately execute once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

We collect some configurations by default; for more details, see the metrics section [Customize Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-rds/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configuration, and at the same time, you can check the corresponding task records and logs for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, under "Infrastructure / Custom", check if asset information exists.
3. On the <<< custom_key.brand_name >>> platform, under "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}
Configure Alibaba Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics via configuration [Alibaba Cloud Cloud Monitoring Metric Details](https://cms.console.aliyun.com/metric-meta/acs_rds_dashboard/postgresql?spm=a2c4g.11186623.0.0.252476abya93cJ){:target="_blank"}

| Metric Name | Description | Unit | Dimensions |
| ---- | :----: | ------ | ------ |
| PG_DBAge | PG_database age | count | instanceId |
| PG_InactiveSlots | PG_inactive replication slot count | count | instanceId |
| PG_MaxExecutingSQLTime | PG_slowest SQL execution time | seconds | instanceId |
| PG_MaxSlotWalDelay | PG_maximum replication slot delay (MB) | byte | instanceId |
| PG_ReplayLatency | PG_slowest Standby replay delay (MB) | byte | instanceId |
| PG_SwellTime | PG_longest transaction execution time | seconds | instanceId |
| active_connections_per_cpu | PG_average active connections per CPU | count | instanceId |
| conn_usgae | PG_connection usage rate | % | instanceId |
| cpu_usage | PG_CPU usage rate | % | instanceId |
| five_seconds_executing_sqls | PG_five-second slow SQL | count | instanceId |
| iops_usage | PG_IOPS usage rate | % | instanceId |
| local_fs_inode_usage | PG_INODE usage rate | % | instanceId |
| local_fs_size_usage | PG_disk space usage rate | % | instanceId |
| local_pg_wal_dir_size | PG_WAL file size | MB | instanceId |
| mem_usage | PG_memory usage rate | % | instanceId |
| one_second_executing_sqls | PG_one-second slow SQL | count | instanceId |
| three_seconds_executing_sqls | PG_three-second slow SQL | count | instanceId |


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
    "ConnectionString" : "{JSON connection address data}",
    "DBInstanceStorage": "100",
    "accounts"         : "{JSON user permissions data}",
    "databases"        : "{JSON database data}",
    "SSLExpireTime"    : "2022-10-11T08:16:43Z",
    "message"          : "{JSON instance data}",
  }
}

```


## Logs {#logging}

### Slow Query Statistics

#### Prerequisites for Slow Query Statistics

> Note 1: The operation of this script's code depends on the collection of RDS instance objects. If the custom object collection for RDS is not configured, the slow log script cannot collect slow log data.
> Note 2: Due to the 6~8 hours delay in returning statistics data from Alibaba Cloud, there may be delays in updating the collector's data. For more details, refer to the Alibaba Cloud documentation: Cloud Database RDS Query Slow Log Statistics.
> Note 3: This collector supports all versions of MySQL (except the basic edition of MySQL 5.7), SQL Server 2008 R2, MariaDB 10.3 type databases. To collect other types of databases, use the [Alibaba Cloud-RDS Slow Query Detail](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-rds-slowlog-record/){:target="_blank"} collector.

#### Slow Query Statistics Installation Script

On top of the previous setup, you need to install another script corresponding to **RDS Slow Query Statistics Log Collection**.

In "Manage / Script Market," click and install the corresponding script package:

- "<<< custom_key.brand_name >>> Integration (Alibaba Cloud - RDS Slow Query Statistics Log Collection)" (ID: `guance_aliyun_rds_slowlog`)

Once the data is synchronized correctly, you can view it under the "Logs" section of <<< custom_key.brand_name >>>.

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
    "message"                      : "{Log JSON data}"
  }
}

```

Some parameter explanations are as follows:

| Field                            | Type | Description                                   |
| :------------------------------ | :--- | :------------------------------------- |
| `SQLServerTotalExecutionTimes`  | int  | SQL Server execution duration (total value, milliseconds)      |
| `AvgExecutionTime`              | int  | Execution time (average value) unit: seconds             |
| `SQLServerAvgExecutionTime`     | int  | Execution time (average value) unit: seconds             |
| `MySQLTotalExecutionTimes`      | int  | MySQL execution time (total value) unit: seconds         |
| `SQLServerTotalExecutionTimes`  | int  | SQL Server execution time (total value) unit: milliseconds |
| `SQLServerTotalExecutionCounts` | int  | SQL Server execution counts (total value)            |
| `MySQLTotalExecutionCounts`     | int  | MySQL execution counts (total value)                 |

> *Note: Fields such as `AvgExecutionTime`, `SQLServerAvgExecutionTime`, `SQLServerTotalExecutionTimes`, etc., are only supported by SQL Server instances.*
> *Note: Fields in `tags` and `fields` may change with subsequent updates.*

### Slow Query Details

#### Prerequisites for Slow Query Details

> Note: The operation of this script's code depends on the collection of RDS instance objects. If the custom object collection for RDS is not configured, the slow log script cannot collect slow log data.

#### Slow Query Details Installation Script

On top of the previous setup, you need to install another script corresponding to **RDS Slow Query Detail Log Collection**.

In "Manage / Script Market," click and install the corresponding script package:

- "<<< custom_key.brand_name >>> Integration (Alibaba Cloud-RDS Slow Query Detail Log Collection)" (ID: `guance_aliyun_rds_slowlog_record`)

Once the data is synchronized correctly, you can view it under the "Logs" section of <<< custom_key.brand_name >>>.

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
    "message"                      : "{Log JSON data}"
  }
}

```

Some parameter explanations are as follows:

| Field                    | Type | Description                       |
| :---------------------- | :--- | :------------------------- |
| `QueryTimes`            | int  | Execution duration. Unit: second(s)    |
| `QueryTimesMS`          | int  | Execution duration. Unit: millisecond(ms) |
| `ReturnRowCounts`       | int  | Returned row count                   |
| `ParseRowCounts`        | int  | Parsed row count                   |
| `ExecutionStartTime`    | str  | Execution start time               |
| `CpuTime`               | int  | CPU processing duration                |
| `RowsAffectedCount`     | int  | Affected row count                   |
| `LastRowsAffectedCount` | int  | Last statement affected row count       |

> *Note: Fields such as `CpuTime`, `RowsAffectedCount`, `LastRowsAffectedCount`, etc., are only supported by SQL Server instances.*
> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
> Note: `fields.message` is a JSON serialized string.