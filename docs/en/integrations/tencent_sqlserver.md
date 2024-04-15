---
title: 'Tencent Cloud SQLServer'
summary: 'Use the 「Guance Synchronization」 series of script packages in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.'
__int_icon: 'icon/tencent_sqlserver'
dashboard:

  - desc: 'Tencent Cloud SQLServer Dashboard'
    path: 'dashboard/zh/tencent_sqlserver'

monitor:
  - desc: 'Tencent Cloud SQLServer Monitor'
    path: 'monitor/zh/tencent_sqlserver'

---

<!-- markdownlint-disable MD025 -->
# Tencent Cloud SQLServer
<!-- markdownlint-enable -->

Use the 「Guance Synchronization」 series of script packages in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of SQL Server cloud resources, we install the corresponding collection script：「Guance Integration（Tencent Cloud-SQLServerCollect）」(ID：`guance_tencentcloud_sqlserver`)

Click 【Install】 and enter the corresponding parameters: Aliyun AK, Aliyun account name.

Click [Deploy Startup Scripts], the system will automatically create the `Startup` script set and automatically configure the corresponding startup scripts.

You can see the corresponding auto-trigger configuration in "Management / Auto-trigger Configuration" after you turn it on. Click "Execute" to execute the task immediately without waiting for the regular time. Wait for a while, you can check the record and log of the executed task.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist.
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists.
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists.

## Metric {#metric}

Configure Tencent Cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Tencent Cloud Monitor Metrics Details](https://cloud.tencent.com/document/product/248/45146){:target="_blank"}

### Common metrics

| Parameter    | Metric Name            | Description             | Unit | Dimension  |
| --------------- | ---------------------- | --------------------------- | ----- | ----------------- |
| `Cpu`  | CPU utilization        | Percentage of instance CPU usage                             | %    | resourceId |
| Transactions | Number of transactions | Average number of transactions per second                    | Times/sec | resourceId |
| Connections | Number of connections  | Average number of databases connected by users per second    | Count | resourceId |
| Requests | Number of requests     | Number of requests per second                                | Times/sec | resourceId |
| Logins | Number of logins       | Number of logins per second                                  | Times/sec | resourceId |
| Logouts | Number of logouts      | Number of logouts per second                                 | Times/sec | resourceId |
| Storage | Used storage           | Sum of storage space consumed by instance database files and log files | GB    | resourceId |
| InFlow | Inbound traffic        | Sum of inbound packet sizes for all connections              | KB/s  | resourceId |
| OutFlow | Outbound traffic       | Sum of outbound packet sizes for all connections             | KB/s  | resourceId |
| Iops         | Disk IOPS              | Disk read/write operations per second                        | Times/sec | resourceId |
| DiskReads    | Number of disk reads   | Number of disk reads per second                              | Times/sec | resourceId |
| DiskWrites   | Number of disk writes  | Number of disk writes per second                             | Times/sec | resourceId |
| ServerMemory | Memory usage           | Actual memory usage                                          | MB    | resourceId |

### Performance optimization metrics

| Parameter           | Metric Name                                   | Description                                                  | Unit | Dimension  |
| --------------- | ---------------------- | --------------------------- | ----- | ----------------- |
| SlowQueries | Slow queries                                  | Number of slow queries with a running time greater than one second | Count | resourceId |
| BlockedProcesses | Number of blocked processes                   | Number of currently blocked processes                        | Count     | resourceId |
| LockRequests | Number of lock requests                       | Average number of lock requests per second                   | Times/sec | resourceId |
| UserErrors | Number of user errors                         | Average number of user errors per second                     | Times/sec | resourceId |
| SqlCompilations | Number of SQL compilations                    | Average number of SQL compilations per second                | Times/sec | resourceId |
| SqlRecompilations | Number of SQL recompilations                  | Average number of SQL recompilations per second              | Times/sec | resourceId |
| FullScans | Number of full-table scans for SQL per second | Number of full scans without limitations per second          | Times/sec | resourceId |
| BufferCacheHitRatio | Buffer cache hit rate                         | Data cache (memory) hit rate                                 | % | resourceId |
| LatchWaits | Number of latch waits                         | Number of latch waits per second                             | Times/sec | resourceId |
| LockWaits | Average latency on a lock wait                | Average wait time of each lock request resulting in lock wait | Ms | resourceId |
| NetworkIoWaits | I/O wait time                                 | Average network I/O wait time                                | Ms | resourceId |
| PlanCacheHitRatio | Plan cache hit rate                           | The hit rate of a plan. Each SQL statement has a plan with a hit rate | % | resourceId |
| FreeStorage | Residual capacity of the hard disk            | Percentage of the residual capacity of the hard disk         | % | resourceId |

## Object {#object}

Collected Tencent Cloud SQLServer object data structure, you can see the object data from "Infrastructure - Customize".

```json
{
  "measurement": "tencentcloud_sqlserver",
  "tags": {
      "BackupCycleType": "daily",
      "CrossBackupEnabled": "disable",
      "InstanceId"      : "mssql-nmquc",
      "InstanceType"    : "SI",
      "Model"           : "2",
      "PayMode"         : "0",
      "Pid"             : "10036",
      "ProjectId"       : "0",
      "Region"          : "ap-shanghai",
      "RegionId"        : "ap-shanghai",
      "RenewFlag"       : "0",
      "Status"          : "2",
      "SubnetId"        : "68021",
      "Type"            : "CLOUD_BSSD",
      "Uid"             : "gamedb.sh1000.cdb.db",
      "UniqSubnetId"    : "subnet-b",
      "UniqVpcId"       : "vpc-xxxxx",
      "Version"         : "2016SP1",
      "VersionName"     : "SQL Server 2016 Enterprise",
      "Vip"             : "xxxxx",
      "VpcId"           : "80484",
      "Vport"           : "14",
      "Zone"            : "ap-shanghai-2",
      "ZoneId"          : "200002",
      "account_name"    : "腾讯云账号",
      "cloud_provider"  : "tencentcloud",
      "name"            : "mssql-nmqu"
    },
  "fields": {
      "Cpu"             : "2",
      "CreateTime"      : "2023-07-20 14:07:05",
      "EndTime"         : "0000-00-00 00:00:00",
      "IsolateTime"     : "0000-00-00 00:00:00",
      "Memory"          : "4",
      "StartTime"       : "2023-07-20 14:07:05",
      "Storage"         : "20",
      "UpdateTime"      : "2023-07-20 14:14:13",
      "UsedStorage"     : "0",
      "message"         : "{Instance JSON data}"
  }
}
```

> *Note: Fields in `tags`, `fields` are subject to change with subsequent updates.*
>
> Tip 1: The `tags.name` value is the instance ID, which serves as a unique identifier.
> Tip 2: `fields.message`, `fields.InstanceNode`、 are JSON serialized strings.
