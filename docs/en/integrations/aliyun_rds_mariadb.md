---
title: 'Aliyun RDS MariaDB'
summary: 'Use the「Guance Cloud Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.'
__int_icon: 'icon/aliyun_rds_mariadb'
dashboard:
  - desc: '阿里云 RDS MariaDB 内置视图'
    path: 'dashboard/zh/aliyun_rds_mariadb/'

monitor:
  - desc: '阿里云 RDS MariaDB 监控器'
    path: 'monitor/zh/aliyun_rds_mariadb/'
---


<!-- markdownlint-disable MD025 -->
# Aliyun RDS MariaDB
<!-- markdownlint-enable -->

Use the「Guance Cloud Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.

## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> Recommended deployment of GSE version

### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of RDS cloud resources, we install the corresponding collection script：「观测云集成（阿里云- RDS 采集）」(ID：`guance_aliyun_rds`)

Click 【Install】 and enter the corresponding parameters: Aliyun AK, Aliyun account name.。

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-rds/){:target="_blank"}

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure Ali Cloud - cloud monitoring. The default indicator set is as follows. You can collect more indicators by configuring them [Alibaba Cloud Monitor Metrics Details](https://cms.console.aliyun.com/metric-meta/acs_rds_dashboard/rds){:target="_blank"}

| Metric Id                    |          Metric Name           | Dimensions        | Statistics              | Unit        |
| ---- | :----: | ------ | ------ | ---- |
| ConnectionUsage       |          Connection usage rate        | userId,instanceId | Average,Minimum,Maximum | %           |
| CpuUsage          |           CPU usage rate             | userId,instanceId | Average,Minimum,Maximum | %           |
| DiskUsage             |           Disk usage rate           | userId,instanceId | Average,Minimum,Maximum | %           |
| IOPSUsage           |           IOPS usage rate           | userId,instanceId | Average,Minimum,Maximum | %           |
| MemoryUsage          |           Memory usage rate           | userId,instanceId | Average,Minimum,Maximum | %           |
| MySQL_ComDelete       |       MySQL Deletes per second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| MySQL_ComInsert      |       MySQL Inserts per second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| MySQL_ComInsertSelect     |    MySQL InsertSelects per second     | userId,instanceId | Average,Maximum,Minimum | countSecond |
| MySQL_ComReplace     |       MySQL Replaces per second       | userId,instanceId | Average,Maximum,Minimum | countSecond |
| MySQL_ComReplaceSelect    |    MySQL ReplaceSelects per second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| MySQL_ComSelect    |       MySQL Selects per second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| MySQL_ComUpdate     |       MySQL Updates per second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| MySQL_DataDiskSize      |      MySQL data disk usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| MySQL_IbufDirtyRatio    |       MySQL Buffer Pool Dirty Page Percentage       | userId,instanceId | Average,Maximum,Minimum | %           |
| MySQL_IbufReadHit    |        MySQL Buffer Pool Read Hit Rate        | userId,instanceId | Average,Maximum,Minimum | %           |
| MySQL_IbufRequestR      |      MySQL Logical Reads per second       | userId,instanceId | Average,Maximum,Minimum | countSecond |
| MySQL_IbufRequestW      |      MySQL Logical Writes per second       | userId,instanceId | Average,Maximum,Minimum | countSecond |
| MySQL_IbufUseRatio     |         MySQL Buffer Pool Utilization Rate         | userId,instanceId | Average,Maximum,Minimum | %           |
| MySQL_InnoDBDataRead    |   MySQL InnoDB Reads per second   | userId,instanceId | Average,Maximum,Minimum | Kbyte       |
| MySQL_InnoDBDataWritten  |   MySQL InnoDB Writes per second   | userId,instanceId | Average,Maximum,Minimum | Kbyte       |
| MySQL_InnoDBLogFsync     |  MySQL InnoDB Log fsyncs per second   | userId,instanceId | Average,Maximum,Minimum | countSecond |
| MySQL_InnoDBLogWriteRequests | MySQL InnoDB Log Write Requests per second | userId,instanceId | Average,Maximum,Minimum | countSecond |
| MySQL_InnoDBLogWrites   | MySQL InnoDB Log Physical Writes per second | userId,instanceId | Average,Maximum,Minimum | countSecond |
| MySQL_InnoDBRowDelete    |    MySQL InnoDB Deletes per second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| MySQL_InnoDBRowInsert   |    MySQL InnoDB Inserts per second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| MySQL_InnoDBRowRead   |    MySQL InnoDB Reads per second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| MySQL_InnoDBRowUpdate   |    MySQL InnoDB Updates per second    | userId,instanceId | Average,Maximum,Minimum | countSecond |
| MySQL_InstanceDiskSize     |      MySQL instance disk usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| MySQL_LogDiskSize     |      MySQL log disk usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| MySQL_NetworkInNew     |       MySQL inbound network bandwidth        | userId,instanceId | Average,Minimum,Maximum | bits/s      |
| MySQL_NetworkOutNew      |       MySQL outbound network bandwidth        | userId,instanceId | Average,Minimum,Maximum | bits/s      |
| MySQL_OtherDiskSize     |      MySQL other disk usage      | userId,instanceId | Average,Maximum,Minimum | Megabytes   |
| MySQL_QPS      |        MySQL Queries per second         | userId,instanceId | Average,Maximum,Minimum | countSecond |
| MySQL_SlowQueries    |       MySQL Slow Queries per second        | userId,instanceId | Average,Maximum,Minimum | countSecond |
| MySQL_TPS    |        MySQL Transactions per second         | userId,instanceId | Average,Maximum,Minimum | countSecond |
| MySQL_TempDiskTableCreates  |    MySQL Temporary Tables Created per second     | userId,instanceId | Average,Maximum,Minimum | countSecond |
| MySQL_ThreadsConnected   |        MySQL thread connection count        | userId,instanceId | Average,Maximum,Minimum | count       |
| MySQL_ThreadsRunning    |        MySQL active thread count        | userId,instanceId | Average,Maximum,Minimum | count       |


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

Note: The fields in `tags` and `fields` may change in subsequent updates.

> Tip: The value of `tags.name` is the instance ID, which serves as a unique identifier.
>
> Tip 2: `fields.message` and `fields.ConnectionString` are both JSON-serialized strings.
>
> Tip 3：`fields.DiskUsed`、`fields.BackupSize`、`fields.LogSize`、`fields.BackupLogSize`、`fields.BackupDataSize Unit：Byte，`fields.DBInstanceStorage` Unit：GB。
>
> Tip 4：`field.SSLExpireTime` In UTC time.
