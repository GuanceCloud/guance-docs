---
title: 'AliCloud RDS PostgreSQL'
summary: 'AliCloud RDS PostgreSQL metrics showcase, including CPU utilization, memory usage, and more.'
__int_icon: 'icon/aliyun_rds_postgresql'
dashboard:
  - desc: 'AliCloud RDS PostgreSQL Built-in Dashboard'
    path: 'dashboard/zh/aliyun_rds_postgresql/'

monitor:
  - desc: 'AliCloud RDS PostgreSQL Monitor'
    path: 'monitor/zh/aliyun_rds_postgresql/'
---


<!-- markdownlint-disable MD025 -->
# AliCloud RDS PostgreSQL
<!-- markdownlint-enable -->

AliCloud RDS PostgreSQL metrics showcase, including CPU utilization, memory usage, and more.

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/)

> Recommended deployment of GSE version

### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of RDS cloud resources, we install the corresponding collection script：「观测云集成（阿里云- RDS 采集）」(ID：`guance_aliyun_rds`)

Click 【Install】 and enter the corresponding parameters: Aliyun AK, Aliyun account name.

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-rds/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure Ali Cloud - cloud monitoring. The default indicator set is as follows. You can collect more indicators by configuring them [Alibaba Cloud Monitor Metrics Details](https://cms.console.aliyun.com/metric-meta/acs_rds_dashboard/postgresql?spm=a2c4g.11186623.0.0.252476abya93cJ){:target="_blank"}

| Metric Name  | Descriptive  | Unit  | Dimensions  |
| ---- | :----: | ------ | ------ |
| PG_DBAge | PG_Database Age | count | instanceId |
| PG_InactiveSlots | PG_Number of inactive replication slots | count | instanceId |
| PG_MaxExecutingSQLTime | PG_Slowest SQL Execution Time Consumption | seconds | instanceId |
| PG_MaxSlotWalDelay | PG_Maximum Copy Slot Delay(MB) | byte | instanceId |
| PG_ReplayLatency | PG_Slowest Standby Playback Delay(MB) | byte | instanceId |
| PG_SwellTime | PG_Maximum transaction execution time | seconds | instanceId |
| active_connections_per_cpu | PG_Average Active Connections per CPU | count | instanceId |
| conn_usgae | PG_Connections Utilization | % | instanceId |
| cpu_usage | PG_CPU utilization | % | instanceId |
| five_seconds_executing_sqls | PG_Five Seconds Slow SQL | count | instanceId |
| iops_usage | PG_IOPS utilization | % | instanceId |
| local_fs_inode_usage | PG_INODE utilization rate | % | instanceId |
| local_fs_size_usage | PG_Disk Space Utilization | % | instanceId |
| local_pg_wal_dir_size | PG_WAL file size | MB | instanceId |
| mem_usage | PG_Memory Usage | % | instanceId |
| one_second_executing_sqls | PG_One Second Slow SQL | count | instanceId |
| three_seconds_executing_sqls | PG_Three Seconds Slow SQL | count | instanceId |


## Object {#object}

The collected Alibaba Cloud RDS object data structure can see the object data from 「Infrastructure-custom-defined」

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
    "DBInstanceDescription": "业务系统",
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
    "ConnectionString" : "{连接地址 JSON 数据}",
    "DBInstanceStorage": "100",
    "accounts"         : "{用户权限信息 JSON 数据}",
    "databases"        : "{数据库信息 JSON 数据}",
    "SSLExpireTime"    : "2022-10-11T08:16:43Z",
    "message"          : "{实例 JSON 数据}",
  }
}

```


## Log {#logging}

### Slow query statistics

#### The prerequisite for slow query statistics

> Tip 1：The execution of this script depends on RDS instance object collection. If RDS custom object collection is not configured, the slow log script will not be able to collect slow log data.
>
> Tip 2：Due to the 6 to 8 hours data delay in the statistics returned by Alibaba Cloud, there might be a delay in the collector's data updates. For more details, please refer to the Alibaba Cloud documentation on "Cloud Database RDS Query Slow Log Statistics."
>
> Tip 3：This collector supports all versions of MySQL (except for MySQL 5.7 Basic Edition), SQL Server 2008 R2, and MariaDB 10.3 databases. If you want to collect data from other types of databases, please use the [Aliyun-RDS Slow query details](https://func.guance.com/doc/script-market-guance-aliyun-rds-slowlog-record/){:target="_blank"} collector.

#### Slow Query Statistics Installation Script

On top of that, you need to install a corresponding collector. **The script for RDS slow query log collection**

Click and install the corresponding script package in「Management / Script market」：

- 「观测云集成（阿里云- RDS 慢查询统计日志采集）」(ID：`guance_aliyun_rds_slowlog`)

Once the data is successfully synchronized, you can view it in the "Logs" section of Observing Cloud.

Examples of reported data are as follows：

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
    "DBInstanceDescription": "业务系统"
  },
  "fields": {
    "SQLHASH"                      : "436f9dd030e0a87920bbcd818b34f271",
    "SQLText"                      : "{SQL 语句}",
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
    "message"                      : "{日志 JSON 数据}"
  }
}

```

The partial parameter explanations are as follows：

| Fields                            | Type | Description                                   |
| :------------------------------ | :--- | :------------------------------------- |
| `SQLServerTotalExecutionTimes`  | int  | SQL Server Execution Duration (Total, in milliseconds)      |
| `AvgExecutionTime`              | int  | Execution Time (Average), Unit: Seconds             |
| `SQLServerAvgExecutionTime`     | int  | Execution Time (Average), Unit: Seconds             |
| `MySQLTotalExecutionTimes`      | int  | MySQL Execution Time (Total), Unit: Seconds         |
| `SQLServerTotalExecutionTimes`  | int  | SQL Server Execution Time (Total), Unit: Milliseconds |
| `SQLServerTotalExecutionCounts` | int  | SQL Server Execution Count (Total)            |
| `MySQLTotalExecutionCounts`     | int  | MySQL Execution Count (Total)                 |

> *Attention：The fields `AvgExecutionTime`, `SQLServerAvgExecutionTime`, `SQLServerTotalExecutionTimes`, etc. are only supported by SQL Server instances.*
>
> *Attention：The fields in `tags` and `fields` may be subject to changes in subsequent updates.*

### Slow query details

#### Prerequisite for slow query of details


> Tip：This script's code execution relies on RDS instance object collection. If RDS custom object collection is not configured, the slow log script will not be able to collect slow log data.

#### Slow query details installation script

On top of that, you need to install a corresponding script for **The script for RDS slow query log collection.**

Click and install the corresponding script package in「Management / Script market」：

- 「观测云集成（阿里云-RDS慢查询明细日志采集）」(ID：`guance_aliyun_rds_slowlog_record`)

After the data is successfully synchronized, you can view it in the 「Logs」 section of Observing Cloud.

settings[Cloud Database RDS slow query details](https://func.guance.com/doc/script-market-guance-aliyun-rds-slowlog-record/){:target="_blank"}

The reported data example is as follows：

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
    "DBInstanceDescription": "业务系统",
    "HostAddress"          : "xxxx",
    "UserName"             : "xxxx",
    "ClientHostName"       : "xxxx",
    "ApplicationName"      : "xxxx",

  },
  "fields": {
    "SQLHASH"                      : "436f9dd030e0a87920bbcd818b34f271",
    "SQLText"                      : "{SQL 语句}",
    "QueryTimes"                   : 0,
    "QueryTimesMS"                 : 0,
    "ReturnRowCounts"              : 0,
    "ParseRowCounts"               : 0,
    "ExecutionStartTime"           : "2022-02-02T12:00:00Z",
    "CpuTime"                      : 1,
    "RowsAffectedCount"            : 0,
    "LastRowsAffectedCount"        : 0,
    "message"                      : "{日志 JSON 数据}"
  }
}

```

The partial parameter explanations are as follows：

| Fields                    | Type | Description                       |
| :---------------------- | :--- | :------------------------- |
| `QueryTimes`            | int  | Execution Duration. Unit: Seconds (s)    |
| `QueryTimesMS`          | int  | Execution Duration. Unit: Milliseconds (ms) |
| `ReturnRowCounts`       | int  | Number of Rows Returned                  |
| `ParseRowCounts`        | int  | Number of Rows Parsed                   |
| `ExecutionStartTime`    | str  | Execution Start Time               |
| `CpuTime`               | int  | CPU Processing Duration                |
| `RowsAffectedCount`     | int  | Number of Rows Affected                   |
| `LastRowsAffectedCount` | int  | Number of Rows Affected by the Last Statement       |

> *Attention：The fields `CpuTime`, `RowsAffectedCount`, `LastRowsAffectedCount`, etc. are only supported by SQL Server instances.*
>
> *Attention：The fields in `tags` and `fields` may be subject to changes in subsequent updates.*
>
> *Attention：The `fields.message` is a JSON-serialized string.
