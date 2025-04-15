---
title: 'Alibaba Cloud RDS PostgreSQL'
tags: 
  - Alibaba Cloud
summary: 'Display of Alibaba Cloud RDS PostgreSQL Metrics, including CPU usage, memory usage, etc.'
__int_icon: 'icon/aliyun_rds_postgresql'
dashboard:
  - desc: 'Built-in views for Alibaba Cloud RDS PostgreSQL'
    path: 'dashboard/en/aliyun_rds_postgresql/'

monitor:
  - desc: 'Monitors for Alibaba Cloud RDS PostgreSQL'
    path: 'monitor/en/aliyun_rds_postgresql/'

cloudCollector:
  desc: 'cloud collector'
  path: 'cloud-collector/en/aliyun_rds_postgresql'
---


<!-- markdownlint-disable MD025 -->
# Alibaba Cloud RDS PostgreSQL
<!-- markdownlint-enable -->

Display of Alibaba Cloud RDS PostgreSQL Metrics, including CPU usage, memory usage, etc.

## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> Integration - Extension - Managed Func

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Enable Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

#### Script for enabling managed version

1. Log in to <<< custom_key.brand_name >>> Console
2. Click on the 【Manage】 menu and select 【Cloud Account Management】
3. Click 【Add Cloud Account】, select 【Alibaba Cloud】, fill in the required information on the interface; if you have already configured cloud account information, skip this step
4. Click 【Test】, after a successful test click 【Save】. If the test fails, check whether the related configuration information is correct and retest
5. In the 【Cloud Account Management】 list, you can see the added cloud account. Click the corresponding cloud account to enter the details page
6. Click the 【Integration】 button on the cloud account details page. Under the `Not Installed` list, find `Alibaba Cloud RDS PostgreSQL`, click the 【Install】 button, and follow the installation interface to install it.

#### Manual Activation Script

1. Log in to the Func Console, click 【Script Market】, enter the official script market, and search for `guance_aliyun_rds`

2. After clicking 【Install】, input the corresponding parameters: Alibaba Cloud AK ID, AK Secret, and account name.

3. Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and configure the corresponding startup scripts automatically.

4. After activation, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the scheduled time. Wait a moment, then you can view the execution task records and corresponding logs.

We default collect some configurations. For more details, see the metrics section [Customize Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-rds/){:target="_blank"}


### Verification

1. Confirm in "Management / Automatic Trigger Configuration" whether the corresponding tasks have the corresponding automatic trigger configurations, and check the corresponding task records and logs for any anomalies.
2. In <<< custom_key.brand_name >>>, under "Infrastructure / Custom", check if there are asset information entries.
3. In <<< custom_key.brand_name >>>, under "Metrics", check if there are corresponding monitoring data entries.

## Metrics {#metric}
After configuring Alibaba Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration [Alibaba Cloud Cloud Monitoring Metric Details](https://cms.console.aliyun.com/metric-meta/acs_rds_dashboard/postgresql?spm=a2c4g.11186623.0.0.252476abya93cJ){:target="_blank"}

| Metric Name | Description | Unit | Dimensions |
| ---- | :----: | ------ | ------ |
| PG_DBAge | PG_Database Age | count | instanceId |
| PG_InactiveSlots | PG_Inactive Replication Slot Count | count | instanceId |
| PG_MaxExecutingSQLTime | PG_Slowest SQL Execution Time | seconds | instanceId |
| PG_MaxSlotWalDelay | PG_Maximum Replication Slot Delay (MB) | byte | instanceId |
| PG_ReplayLatency | PG_Slowest Standby Replay Delay (MB) | byte | instanceId |
| PG_SwellTime | PG_Longest Transaction Execution Time | seconds | instanceId |
| active_connections_per_cpu | PG_Average Active Connections Per CPU | count | instanceId |
| conn_usgae | PG_Connection Usage Rate | % | instanceId |
| cpu_usage | PG_CPU Usage Rate | % | instanceId |
| five_seconds_executing_sqls | PG_Five Second Slow SQLs | count | instanceId |
| iops_usage | PG_IOPS Usage Rate | % | instanceId |
| local_fs_inode_usage | PG_INODE Usage Rate | % | instanceId |
| local_fs_size_usage | PG_Disk Space Usage Rate | % | instanceId |
| local_pg_wal_dir_size | PG_WAL File Size | MB | instanceId |
| mem_usage | PG_Memory Usage Rate | % | instanceId |
| one_second_executing_sqls | PG_One Second Slow SQLs | count | instanceId |
| three_seconds_executing_sqls | PG_Three Second Slow SQLs | count | instanceId |


## Objects {#object}

The collected Alibaba Cloud RDS PostgreSQL object data structure can be seen from "Infrastructure - Custom"

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
    "accounts"         : "{JSON user privilege information data}",
    "databases"        : "{JSON database information data}",
    "SSLExpireTime"    : "2022-10-11T08:16:43Z",
    "message"          : "{JSON instance data}",
  }
}

```


## Logs {#logging}

### Slow Query Statistics

#### Prerequisites for Slow Query Statistics

> Note 1: The code execution of this script depends on the collection of RDS instance objects. If RDS custom object collection is not configured, the slow log script cannot collect slow log data.
> Note 2: Due to a delay of 6~8 hours in the return of Alibaba Cloud statistics data, there may be delays in the data updates by the collector. Refer to Alibaba Cloud documentation: Cloud Database RDS Slow Log Statistics Query for more details.
> Note 3: This collector supports all versions of MySQL (except the basic version of MySQL 5.7), SQL Server 2008 R2, and MariaDB 10.3 type databases. To collect other types of databases, use the [Alibaba Cloud - RDS Slow Query Detail](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-rds-slowlog-record/){:target="_blank"} collector.

#### Slow Query Statistics Installation Script

On top of the previous setup, you need to install another script corresponding to **RDS Slow Query Log Collection**

In the "Management / Script Market," click and install the corresponding script package:

- "<<< custom_key.brand_name >>> Integration (Alibaba Cloud - RDS Slow Query Log Collection)" (ID: `guance_aliyun_rds_slowlog`)

Once the data synchronizes normally, you can view it in the "Logs" section of <<< custom_key.brand_name >>>.

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

Some parameter explanations are as follows:

| Field                            | Type | Explanation                                   |
| :------------------------------ | :--- | :------------------------------------- |
| `SQLServerTotalExecutionTimes`  | int  | SQL Server execution duration (total value, milliseconds)      |
| `AvgExecutionTime`              | int  | Execution time (average value) unit: seconds             |
| `SQLServerAvgExecutionTime`     | int  | Execution time (average value) unit: seconds             |
| `MySQLTotalExecutionTimes`      | int  | MySQL execution time (total value) unit: seconds         |
| `SQLServerTotalExecutionTimes`  | int  | SQL Server execution time (total value) unit: milliseconds |
| `SQLServerTotalExecutionCounts` | int  | SQL Server execution count (total value)            |
| `MySQLTotalExecutionCounts`     | int  | MySQL execution count (total value)                 |

> *Note: Fields such as `AvgExecutionTime`, `SQLServerAvgExecutionTime`, `SQLServerTotalExecutionTimes`, etc., are only supported by SQL Server instances.*
> *Note: Fields in `tags` and `fields` may change with subsequent updates.*

### Slow Query Details

#### Prerequisites for Slow Query Details


> Note: The code execution of this script depends on the collection of RDS instance objects. If RDS custom object collection is not configured, the slow log script cannot collect slow log data.

#### Slow Query Detail Installation Script

On top of the previous setup, you need to install another script corresponding to **RDS Slow Query Detailed Log Collection**

In the "Management / Script Market," click and install the corresponding script package:

- "<<< custom_key.brand_name >>> Integration (Alibaba Cloud - RDS Slow Query Detailed Log Collection)" (ID: `guance_aliyun_rds_slowlog_record`)

Once the data synchronizes normally, you can view it in the "Logs" section of <<< custom_key.brand_name >>>.

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


Some parameter explanations are as follows:

| Field                    | Type | Explanation                       |
| :---------------------- | :--- | :------------------------- |
| `QueryTimes`            | int  | Execution duration. Unit: seconds (s)    |
| `QueryTimesMS`          | int  | Execution duration. Unit: milliseconds (ms) |
| `ReturnRowCounts`       | int  | Number of returned rows                   |
| `ParseRowCounts`        | int  | Number of parsed rows                   |
| `ExecutionStartTime`    | str  | Start execution time               |
| `CpuTime`               | int  | CPU processing duration                |
| `RowsAffectedCount`     | int  | Number of affected rows                   |
| `LastRowsAffectedCount` | int  | Number of affected rows of the last statement       |

> *Note: Fields such as `CpuTime`, `RowsAffectedCount`, `LastRowsAffectedCount`, etc., are only supported by SQL Server instances.*
> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
> Note: `fields.message` is a JSON serialized string