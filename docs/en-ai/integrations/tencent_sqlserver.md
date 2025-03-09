---
title: 'Tencent Cloud SQLServer'
tags: 
  - Tencent Cloud
summary: 'Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/tencent_sqlserver'
dashboard:

  - desc: 'Tencent Cloud SQLServer built-in views'
    path: 'dashboard/en/tencent_sqlserver'

monitor:
  - desc: 'Tencent Cloud SQLServer Monitor'
    path: 'monitor/en/tencent_sqlserver'
---

<!-- markdownlint-disable MD025 -->
# Tencent Cloud SQLServer
<!-- markdownlint-enable -->

Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please proceed with script installation

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install SQLServer Collection Script

> Note: Please prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant read-only access `ReadOnlyAccess`)

To synchronize SQLServer monitoring data, install the corresponding collection script: "Guance Integration (Tencent Cloud-SQL Server Collection)" (ID: `guance_tencentcloud_sqlserver`)

Click 【Install】, then enter the required parameters: Tencent Cloud AK, Tencent Cloud account name.

Click 【Deploy Startup Script】. The system will automatically create a `Startup` script set and configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.

> If you need to collect logs, you also need to enable the corresponding log collection script. If you need to collect billing data, you need to enable the cloud billing collection script.

By default, we collect some configurations. For details, see [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}

### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and check the corresponding task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Tencent Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration. [Tencent Cloud Cloud Monitoring Metrics Details](https://cloud.tencent.com/document/product/248/45146){:target="_blank"}

### Monitoring Metrics

| Metric Name      | Description             | Meaning                        | Unit  | Dimension              |
| --------------- | ---------------------- | --------------------------- | ----- | ----------------- |
| `Cpu`  | CPU Usage     | Percentage of CPU consumed by the instance | %    | resourceId |
| Transactions | Transaction Count       | Average number of transactions per second                       | times/sec | resourceId |
| Connections | Connection Count       | Average number of user connections to the database per second           | count    | resourceId |
| Requests | Request Count       | Number of requests per second                           | times/sec | resourceId |
| Logins | Login Count     | Number of logins per second                           | times/sec | resourceId |
| Logouts | Logout Count     | Number of logouts per second                           | times/sec | resourceId |
| Storage | Used Storage Space | Total space occupied by database files and log files | GB    | resourceId |
| InFlow | Input Traffic     | Total size of input packets from all connections                 | KB/s  | resourceId |
| OutFlow | Output Traffic     | Total size of output packets from all connections                 | KB/s  | resourceId |
| Iops         | Disk IOPS    | Number of disk reads and writes per second                       | times/sec | resourceId |
| DiskReads    | Disk Reads    | Number of disk reads per second                       | times/sec | resourceId |
| DiskWrites   | Disk Writes   | Number of disk writes per second                       | times/sec | resourceId |
| ServerMemory | Memory Usage     | Actual memory consumption                         | MB    | resourceId |

### Performance Optimization Metrics

| Metric Name      | Description             | Meaning                        | Unit  | Dimension              |
| --------------- | ---------------------- | --------------------------- | ----- | ----------------- |
| SlowQueries | Slow Queries | Number of queries running longer than 1 second | count | resourceId |
| BlockedProcesses | Blocked Processes | Current number of blocked processes | count | resourceId |
| LockRequests | Lock Requests | Average number of lock requests per second | times/sec | resourceId |
| UserErrors | User Errors | Average number of errors per second | times/sec | resourceId |
| SqlCompilations | SQL Compilations | Average number of SQL compilations per second | times/sec | resourceId |
| SqlRecompilations | SQL Recompilations | Average number of SQL recompilations per second | times/sec | resourceId |
| FullScans | Full Table Scans | Number of unrestricted full scans per second | times/sec | resourceId |
| BufferCacheHitRatio | Buffer Cache Hit Ratio | Data cache (memory) hit ratio | % | resourceId |
| LatchWaits | Latch Waits | Number of latch waits per second | times/sec | resourceId |
| LockWaits | Average Lock Wait Delay | Average wait time for each lock request causing a wait | Ms | resourceId |
| NetworkIoWaits | IO Latency | Average network IO latency | Ms | resourceId |
| PlanCacheHitRatio | Execution Cache Hit Ratio | Each SQL has one execution plan, the hit ratio of the execution plan | % | resourceId |
| FreeStorage | Free Disk Capacity | Percentage of remaining disk capacity | % | resourceId |

## Objects {#object}

The collected Tencent Cloud SQLServer object data structure can be viewed in "Infrastructure - Custom"

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
      "account_name"    : "Tencent Cloud Account",
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
      "message"         : "{instance JSON data}"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
> Tip 1: `tags.name` value serves as unique identification.
> Tip 2: `fields.message`, `fields.InstanceNode` are serialized JSON strings.

### Appendix

#### TencentCloud-SQLServer「Regions and Availability」

Please refer to the official Tencent documentation:

- [TencentCloud-SQLServer Region List](https://cloud.tencent.com/document/api/238/19930#.E5.9C.B0.E5.9F.9F.E5.88.97.E8.A1.A8)