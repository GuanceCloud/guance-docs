---
title: 'Aliyun RDS MySQL'
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.'
__int_icon: 'icon/aliyun_rds_mysql'
dashboard:
  - desc: 'Aliyun RDS MySQL Monitoring View'
    path: 'dashboard/zh/aliyun_rds_mysql/'

monitor:
  - desc: 'Aliyun RDS Monitor'
    path: 'monitor/zh/aliyun_rds_mysql/'
---


<!-- markdownlint-disable MD025 -->
# Aliyun RDS MySQL
<!-- markdownlint-enable -->

Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.

## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> Recommended deployment of GSE version

### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of RDS cloud resources, we install the corresponding collection script：「Guance Integration（Aliyun - RDS Collect）」(ID：`guance_aliyun_rds`)

Click "Install" and enter the corresponding parameters: Aliyun AK, Aliyun account name.。

tap "Deploy startup Script"，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click "Run"，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-rds/){:target="_blank"}

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure Ali Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Aliyun Monitor Metrics Details](https://cms.console.aliyun.com/metric-meta/acs_rds_dashboard/rds){:target="_blank"}

| Metric Id                    |          Metric Name           | Dimensions        | Statistics              | Unit        |
| ---- | :----: | ------ | ------ | ---- |
| `ConnectionUsage`       |          Connection usage rate        | userId,instanceId | Average,Minimum,Maximum | %           |
| `CpuUsage`          |           CPU usage rate             | userId,instanceId | Average,Minimum,Maximum | %           |
| `DiskUsage`            |           Disk usage rate           | userId,instanceId | Average,Minimum,Maximum | %           |
| `IOPSUsage`           |           IOPS usage rate           | userId,instanceId | Average,Minimum,Maximum | %           |
| `MemoryUsage`          |           Memory usage rate           | userId,instanceId | Average,Minimum,Maximum | %           |
| `MySQL_ComDelete`       |       MySQL Deletes per second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComInsert`      |       MySQL Inserts per second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComInsertSelect`     |    MySQL InsertSelects per second     | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComReplace`     |       MySQL Replaces per second       | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComReplaceSelect`    |    MySQL ReplaceSelects per second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComSelect`    |       MySQL Selects per second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComUpdate`     |       MySQL Updates per second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_DataDiskSize`      |      MySQL data disk usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| `MySQL_IbufDirtyRatio`    |       MySQL Buffer Pool Dirty Page Percentage       | userId,instanceId | Average,Maximum,Minimum | %           |
| `MySQL_IbufReadHit`    |        MySQL Buffer Pool Read Hit Rate        | userId,instanceId | Average,Maximum,Minimum | %           |
| `MySQL_IbufRequestR`      |      MySQL Logical Reads per second       | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_IbufRequestW`      |      MySQL Logical Writes per second       | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_IbufUseRatio`     |         MySQL Buffer Pool Utilization Rate         | userId,instanceId | Average,Maximum,Minimum | %           |
| `MySQL_InnoDBDataRead`    |   MySQL InnoDB Reads per second   | userId,instanceId | Average,Maximum,Minimum | **Kbyte**       |
| `MySQL_InnoDBDataWritten`  |   MySQL InnoDB Writes per second   | userId,instanceId | Average,Maximum,Minimum | **Kbyte**       |
| `MySQL_InnoDBLogFsync`     |  MySQL InnoDB Log fsyncs per second   | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBLogWriteRequests` | MySQL InnoDB Log Write Requests per second | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBLogWrites`   | MySQL InnoDB Log Physical Writes per second | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowDelete`    |    MySQL InnoDB Deletes per second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowInsert`   |    MySQL InnoDB Inserts per second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowRead`   |    MySQL InnoDB Reads per second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowUpdate`   |    MySQL InnoDB Updates per second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InstanceDiskSize`     |      MySQL instance disk usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| `MySQL_LogDiskSize`     |      MySQL log disk usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| `MySQL_NetworkInNew`     |       MySQL inbound network bandwidth        | userId,instanceId | Average,Minimum,Maximum | bits/s      |
| `MySQL_NetworkOutNew`      |       MySQL outbound network bandwidth        | userId,instanceId | Average,Minimum,Maximum | bits/s      |
| `MySQL_OtherDiskSize`     |      MySQL other disk usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| `MySQL_QPS`      |        MySQL Queries per second         | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_SlowQueries`    |       MySQL Slow Queries per second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_TPS`    |        MySQL Transactions per second         | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_TempDiskTableCreates`  |    MySQL Temporary Tables Created per second     | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ThreadsConnected`   |        MySQL thread connection count        | userId,instanceId | Average,Maximum,Minimum | count       |
| `MySQL_ThreadsRunning`    |        MySQL active thread count        | userId,instanceId | Average,Maximum,Minimum | count       |


## Object {#object}

The collected Aliyun RDS object data structure can see the object data from 「Infrastructure-custom-defined」

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
    "DBInstanceDescription": "Business system",
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
    "accounts"         : "{User permission information JSON data}",
    "databases"        : "{Details of the data library JSON data}",
    "SSLExpireTime"    : "2022-10-11T08:16:43Z",
    "message"          : "{Instance JSON data}",
  }
}

```

## Log {#logging}

### Slow query statistics

#### The prerequisite for slow query statistics

> Tip 1：The execution of this script depends on RDS instance object collection. If RDS custom object collection is not configured, the slow log script will not be able to collect slow log data.
>
> Tip 2：Due to the 6 to 8 hours data delay in the statistics returned by Aliyun, there might be a delay in the collector's data updates. For more details, please refer to the Aliyun documentation on "Cloud Database RDS Query Slow Log Statistics."
>
> Tip 3：This collector supports all versions of MySQL (except for MySQL 5.7 Basic Edition), SQL Server 2008 R2, and MariaDB 10.3 databases. If you want to collect data from other types of databases, please use the [Aliyun-RDS Slow query details](https://func.guance.com/doc/script-market-guance-aliyun-rds-slowlog-record/){:target="_blank"} collector.

#### Slow Query Statistics Installation Script

On top of that, you need to install a corresponding collector. **The script for RDS slow query log collection**

Click and install the corresponding script package in「Management / Script market」：

- 「Guance Integration（Aliyun - RDS 慢查询统计日志Collect）」(ID：`guance_aliyun_rds_slowlog`)

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
    "message"                      : "{日志 JSON data}"
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

- 「Guance Integration（Aliyun -RDS慢查询明细日志Collect）」(ID：`guance_aliyun_rds_slowlog_record`)

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
    "message"                      : "{日志 JSON data}"
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

