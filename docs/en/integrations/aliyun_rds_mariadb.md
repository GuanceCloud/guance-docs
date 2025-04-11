---
title: 'Alibaba Cloud RDS MariaDB'
tags: 
  - Alibaba Cloud
summary: 'The displayed Metrics for Alibaba Cloud RDS MariaDB include response time, concurrent connections, QPS, and TPS, etc.'
__int_icon: 'icon/aliyun_rds_mariadb'
dashboard:
  - desc: 'Built-in views for Alibaba Cloud RDS MariaDB'
    path: 'dashboard/en/aliyun_rds_mariadb/'

monitor:
  - desc: 'Monitors for Alibaba Cloud RDS MariaDB'
    path: 'monitor/en/aliyun_rds_mariadb/'

cloudCollector:
  desc: 'cloud collector'
  path: 'cloud-collector/en/aliyun_rds_mariadb'
---


<!-- markdownlint-disable MD025 -->
# Alibaba Cloud RDS MariaDB
<!-- markdownlint-enable -->

The displayed Metrics for Alibaba Cloud RDS MariaDB include response time, concurrent connections, QPS, and TPS, etc.

## Configuration {#config}

### Install Func

It is recommended to activate <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites will be automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/)

## Configuration {#config}

### Install Func

It is recommended to activate <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata)

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Activation Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

#### Managed Version Activation Script

1. Log in to the <<< custom_key.brand_name >>> console.
2. Click on the [Manage] menu, select [Cloud Account Management].
3. Click [Add Cloud Account], choose [Alibaba Cloud], and fill in the required information on the interface. If you have already configured the cloud account information, skip this step.
4. Click [Test]. After a successful test, click [Save]. If the test fails, check whether the related configuration information is correct and retest.
5. In the [Cloud Account Management] list, you can see the added cloud accounts. Click the corresponding cloud account to enter the details page.
6. Click the [Integration] button on the cloud account details page. Under the `Not Installed` list, find `Alibaba Cloud RDS MariaDB`, click the [Install] button, and install it from the pop-up installation interface.

#### Manual Activation Script

1. Log in to the Func console, click [Script Market], enter the official script market, and search for `guance_aliyun_rds`.

2. After clicking [Install], input the corresponding parameters: Alibaba Cloud AK ID, AK Secret, and account name.

3. Click [Deploy Startup Script], and the system will automatically create a `Startup` script set and configure the corresponding startup script automatically.

4. After activation, you can see the corresponding automatic trigger configuration under [Manage / Automatic Trigger Configuration]. Click [Execute] to immediately run once without waiting for the scheduled time. Wait a moment, then you can view the execution task records and corresponding logs.

We default collect some configurations, see the Metrics section for details.

[Configure Custom Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-rds/){:target="_blank"}


### Verification

1. Confirm in [Manage / Automatic Trigger Configuration] whether the corresponding tasks have been configured with automatic triggers. You can also check the task records and logs for any anomalies.
2. In <<< custom_key.brand_name >>>, under [Infrastructure / Custom], check if asset information exists.
3. In <<< custom_key.brand_name >>>, under [Metrics], check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud - Cloud Monitoring, the default Measurement sets are as follows. You can collect more Metrics through configuration. [Details of Alibaba Cloud Cloud Monitoring Metrics](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                    |          Metric Name           | Dimensions        | Statistics              | Unit        |
| ---- | :----: | ------ | ------ | ---- |
| `ConnectionUsage`     |          Connection Usage Rate          | userId,instanceId | Average,Minimum,Maximum | %           |
| `CpuUsage`        |           CPU Usage Rate            | userId,instanceId | Average,Minimum,Maximum | %           |
| `DiskUsage`           |           Disk Usage Rate           | userId,instanceId | Average,Minimum,Maximum | %           |
| `IOPSUsage`         |           IOPS Usage Rate           | userId,instanceId | Average,Minimum,Maximum | %           |
| `MemoryUsage`        |           Memory Usage Rate           | userId,instanceId | Average,Minimum,Maximum | %           |
| `MySQL_ComDelete`     |       MySQL Deletes Per Second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComInsert`    |       MySQL Inserts Per Second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComInsertSelect`   |    MySQL InsertSelects Per Second     | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComReplace`   |       MySQL Replaces Per Second       | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComReplaceSelect`  |    MySQL ReplaceSelects Per Second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComSelect`  |       MySQL Selects Per Second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ComUpdate`   |       MySQL Updates Per Second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_DataDiskSize`    |      MySQL Data Disk Usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| `MySQL_IbufDirtyRatio`  |       MySQL_BP Dirty Page Percentage       | userId,instanceId | Average,Maximum,Minimum | %           |
| `MySQL_IbufReadHit`  |        MySQL_BP Read Hit Ratio        | userId,instanceId | Average,Maximum,Minimum | %           |
| `MySQL_IbufRequestR`    |      MySQL Logical Reads Per Second       | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_IbufRequestW`    |      MySQL Logical Writes Per Second       | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_IbufUseRatio`   |         MySQL_BP Utilization Rate         | userId,instanceId | Average,Maximum,Minimum | %           |
| `MySQL_InnoDBDataRead`  |   MySQL_InnoDB Data Reads Per Second   | userId,instanceId | Average,Maximum,Minimum | **Kbyte**   |
| `MySQL_InnoDBDataWritten` |   MySQL_InnoDB Data Writes Per Second   | userId,instanceId | Average,Maximum,Minimum | **Kbyte**   |
| `MySQL_InnoDBLogFsync`   |  MySQL_InnoDB Log fsyncs Per Second   | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBLogWriteRequests` | MySQL_InnoDB Log Write Requests Per Second | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBLogWrites` | MySQL_InnoDB Physical Log Writes Per Second | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowDelete`  |    MySQL_InnoDB Rows Deleted Per Second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowInsert` |    MySQL_InnoDB Rows Inserted Per Second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowRead` |    MySQL_InnoDB Rows Read Per Second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InnoDBRowUpdate` |    MySQL_InnoDB Rows Updated Per Second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_InstanceDiskSize`   |      MySQL Instance Disk Usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| `MySQL_LogDiskSize`   |      MySQL Log Disk Usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| `MySQL_NetworkInNew`   |       MySQL Network Inbound Bandwidth        | userId,instanceId | Average,Minimum,Maximum | bits/s      |
| `MySQL_NetworkOutNew`    |       MySQL Network Outbound Bandwidth        | userId,instanceId | Average,Minimum,Maximum | bits/s      |
| `MySQL_OtherDiskSize`   |      MySQL Other Disk Usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| `MySQL_QPS`    |        MySQL Queries Per Second         | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_SlowQueries`  |       MySQL Slow Queries Per Second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_TPS`  |        MySQL Transactions Per Second         | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_TempDiskTableCreates` |    MySQL Temporary Tables Created Per Second     | userId,instanceId | Average,Maximum,Minimum | countSecond |
| `MySQL_ThreadsConnected` |        MySQL Threads Connected        | userId,instanceId | Average,Maximum,Minimum | count       |
| `MySQL_ThreadsRunning` |        MySQL Active Threads        | userId,instanceId | Average,Maximum,Minimum | count       |

## Objects {#object}

The collected Alibaba Cloud SLB object data structure can be seen in [Infrastructure - Custom].

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

*Note: The fields in `tags` and `fields` may change with subsequent updates.*

> Note: The value of `tags.name` is the instance ID, used as a unique identifier.
>
> Note 2: `fields.message` and `fields.ConnectionString` are JSON serialized strings.
>
> Note 3: The units for `fields.DiskUsed`, `fields.BackupSize`, `fields.LogSize`, `fields.BackupLogSize`, and `fields.BackupDataSize` are Bytes, while the unit for `fields.DBInstanceStorage` is GB.
>
> Note 4: `field.SSLExpireTime` is in UTC time.