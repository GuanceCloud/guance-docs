---
title: 'Alibaba Cloud RDS MariaDB'
tags: 
  - Alibaba Cloud
summary: 'The displayed metrics for Alibaba Cloud RDS MariaDB include response time, concurrent connections, QPS, and TPS, etc.'
__int_icon: 'icon/aliyun_rds_mariadb'
dashboard:
  - desc: 'Built-in views for Alibaba Cloud RDS MariaDB'
    path: 'dashboard/en/aliyun_rds_mariadb/'

monitor:
  - desc: 'Monitor for Alibaba Cloud RDS MariaDB'
    path: 'monitor/en/aliyun_rds_mariadb/'
---


<!-- markdownlint-disable MD025 -->
# Alibaba Cloud RDS MariaDB
<!-- markdownlint-enable -->

The displayed metrics for Alibaba Cloud RDS MariaDB include response time, concurrent connections, QPS, and TPS, etc.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/)

> We recommend deploying the GSE version

### Installation Script

> Note: Prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data from RDS cloud resources, we install the corresponding collection script: "Guance Integration (Alibaba Cloud - RDS Collection)" (ID: `guance_aliyun_rds`)

Click [Install], then enter the required parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click [Deploy Startup Script], and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Additionally, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click [Execute] to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

We default to collecting some configurations; see the metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-rds/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm that the corresponding task has the automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, in "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, in "Metrics", check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Alibaba Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration. [Alibaba Cloud Cloud Monitoring Metrics Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                    |          Metric Name           | Dimensions        | Statistics              | Unit        |
| ---- | :----: | ------ | ------ | ---- |
| `ConnectionUsage`     |          Connection Usage Rate          | userId,instanceId | Average,Minimum,Maximum | %           |
| `CpuUsage`        |           CPU Usage Rate            | userId,instanceId | Average,Minimum,Maximum | %           |
| `DiskUsage`           |           Disk Usage Rate           | userId,instanceId | Average,Minimum,Maximum | %           |
| `IOPSUsage`         |           IOPS Usage Rate           | userId,instanceId | Average,Minimum,Maximum | %           |
| `MemoryUsage`        |           Memory Usage Rate           | userId,instanceId | Average,Minimum,Maximum | %           |
| `MySQL_ComDelete`     |       MySQL Deletes per Second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComInsert`    |       MySQL Inserts per Second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComInsertSelect`   |    MySQL InsertSelects per Second     | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComReplace`   |       MySQL Replaces per Second       | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComReplaceSelect`  |    MySQL ReplaceSelects per Second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComSelect`  |       MySQL Selects per Second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComUpdate`   |       MySQL Updates per Second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_DataDiskSize`    |      MySQL Data Disk Usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| `MySQL_IbufDirtyRatio`  |       MySQL Buffer Pool Dirty Page Ratio       | userId,instanceId | Average,Maximum,Minimum | %           |
| `MySQL_IbufReadHit`  |        MySQL Buffer Pool Read Hit Rate        | userId,instanceId | Average,Maximum,Minimum | %           |
| `MySQL_IbufRequestR`    |      MySQL Logical Reads per Second       | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_IbufRequestW`    |      MySQL Logical Writes per Second       | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_IbufUseRatio`   |         MySQL Buffer Pool Utilization Rate         | userId,instanceId | Average,Maximum,Minimum | %           |
| `MySQL_InnoDBDataRead`  |   MySQL_InnoDB Data Read per Second   | userId,instanceId | Average,Maximum,Minimum | **Kbyte**   |
| `MySQL_InnoDBDataWritten` |   MySQL_InnoDB Data Written per Second   | userId,instanceId | Average,Maximum,Minimum | **Kbyte**   |
| `MySQL_InnoDBLogFsync`   |  MySQL_InnoDB Log fsyncs per Second   | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBLogWriteRequests` | MySQL_InnoDB Log Write Requests per Second | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBLogWrites` | MySQL_InnoDB Log Physical Writes per Second | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowDelete`  |    MySQL_InnoDB Rows Deleted per Second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowInsert` |    MySQL_InnoDB Rows Inserted per Second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowRead` |    MySQL_InnoDB Rows Read per Second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowUpdate` |    MySQL_InnoDB Rows Updated per Second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InstanceDiskSize`   |      MySQL Instance Disk Usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| `MySQL_LogDiskSize`   |      MySQL Log Disk Usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| `MySQL_NetworkInNew`   |       MySQL Network Inbound Bandwidth        | userId,instanceId | Average,Minimum,Maximum | bits/s      |
| `MySQL_NetworkOutNew`    |       MySQL Network Outbound Bandwidth        | userId,instanceId | Average,Minimum,Maximum | bits/s      |
| `MySQL_OtherDiskSize`   |      MySQL Other Disk Usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| `MySQL_QPS`    |        MySQL Queries per Second         | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_SlowQueries`  |       MySQL Slow Queries per Second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_TPS`  |        MySQL Transactions per Second         | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_TempDiskTableCreates` |    MySQL Temporary Tables Created per Second     | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ThreadsConnected` |        MySQL Connected Threads        | userId,instanceId | Average,Maximum,Minimum | count       |
| `MySQL_ThreadsRunning` |        MySQL Active Threads        | userId,instanceId | Average,Maximum,Minimum | count       |

## Objects {#object}

The collected Alibaba Cloud SLB object data structure can be viewed in "Infrastructure - Custom".

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

*Note: The fields in `tags` and `fields` may change with subsequent updates.*

> Note: The value of `tags.name` is the instance ID, used as a unique identifier.
>
> Note 2: `fields.message`, `fields.ConnectionString` are JSON serialized strings.
>
> Note 3: The units for `fields.DiskUsed`, `fields.BackupSize`, `fields.LogSize`, `fields.BackupLogSize`, `fields.BackupDataSize` are Bytes, and `fields.DBInstanceStorage` is GB.
>
> Note 4: `field.SSLExpireTime` is in UTC time.