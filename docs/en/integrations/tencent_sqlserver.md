---
title: 'Tencent Cloud SQLServer'
tags: 
  - Tencent Cloud
summary: 'Use the "Guance Cloud Sync" series script package in the script market to synchronize cloud monitoring and cloud asset data to Guance'
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

Use the "Guance Cloud Sync" series script package in the script market to synchronize cloud monitoring and cloud asset data to Guance

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites will be automatically installed, please continue with the script installation

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Install SQLServer Collection Script

> Note: Please prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize SQLServer monitoring data, install the corresponding collection script: "Guance Integration (Tencent Cloud-SQL Server Collection)" (ID: `guance_tencentcloud_sqlserver`)

After clicking 【Install】, enter the corresponding parameters: Tencent Cloud AK, Tencent Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.

> If you want to collect the corresponding logs, you also need to enable the corresponding log collection script. If you want to collect billing information, you need to enable the cloud billing collection script.

We default to collecting some configurations, for details see the metrics section [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration, and at the same time, you can check the corresponding task records and logs to see if there are any abnormalities.
2. On the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Tencent Cloud - Cloud Monitoring, the default metric sets are as follows. You can collect more metrics through configuration [Tencent Cloud Cloud Monitoring Metrics Details](https://cloud.tencent.com/document/product/248/45146){:target="_blank"}

### Monitoring Metrics

| Metric Name      | Metric Description             | Meaning                        | Unit  | Dimensions              |
| --------------- | ---------------------- | --------------------------- | ----- | ----------------- |
| `Cpu`  | CPU Usage     | Percentage of CPU consumed by the instance | %    | resourceId |
| Transactions | Number of Transactions       | Average number of transactions per second                       | Times/second | resourceId |
| Connections | Number of Connections       | Average number of user connections to the database per second           | Count    | resourceId |
| Requests | Number of Requests       | Number of requests per second                           | Times/second | resourceId |
| Logins | Number of Logins     | Number of logins per second                           | Times/second | resourceId |
| Logouts | Number of Logouts     | Number of logouts per second                           | Times/second | resourceId |
| Storage | Used Storage Space | Total space occupied by database files and log files of the instance | GB    | resourceId |
| InFlow | Input Traffic     | Total size of input packets for all connections                 | KB/s  | resourceId |
| OutFlow | Output Traffic     | Total size of output packets for all connections                 | KB/s  | resourceId |
| Iops         | Disk IOPS    | Number of disk reads/writes per second                       | Times/second | resourceId |
| DiskReads    | Disk Reads    | Number of disk reads per second                       | Times/second | resourceId |
| DiskWrites   | Disk Writes    | Number of disk writes per second                       | Times/second | resourceId |
| ServerMemory | Memory Usage     | Actual memory consumption                         | MB    | resourceId |

### Performance Optimization Metrics

| Metric Name      | Metric Description             | Meaning                        | Unit  | Dimensions              |
| --------------- | ---------------------- | --------------------------- | ----- | ----------------- |
| SlowQueries | Slow Queries | Number of queries running longer than 1 second | Count | resourceId |
| BlockedProcesses | Blocked Processes | Current number of blocked processes | Count | resourceId |
| LockRequests | Lock Request Counts | Average number of lock requests per second | Times/second | resourceId |
| UserErrors | User Error Counts | Average number of errors per second | Times/second | resourceId |
| SqlCompilations | SQL Compilation Counts | Average number of SQL compilations per second | Times/second | resourceId |
| SqlRecompilations | SQL Recompilation Counts | Average number of SQL recompilations per second | Times/second | resourceId |
| FullScans | Full Table Scans per Second | Unrestricted full scan count per second | Times/second | resourceId |
| BufferCacheHitRatio | Buffer Cache Hit Ratio | Data cache (memory) hit ratio | % | resourceId |
| LatchWaits | Latch Wait Counts | Number of latch waits per second | Times/second | resourceId |
| LockWaits | Average Lock Wait Delay | Average wait time for each lock request that causes waiting | Ms | resourceId |
| NetworkIoWaits | IO Latency Time | Average network IO latency time | Ms | resourceId |
| PlanCacheHitRatio | Execution Cache Hit Ratio | Each SQL has an execution plan, the hit rate of the execution plan | % | resourceId |
| FreeStorage | Free Disk Space | Percentage of free disk space | % | resourceId |

## Objects {#object}

The collected Tencent Cloud SQLServer object data structure can be seen from "Infrastructure - Custom"

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
      "message"         : "{Instance JSON Data}"
  }
}
```

> *Note: The fields in `tags`, `fields` may change with subsequent updates.*
> Tip 1: The value of `tags.name` serves as unique identification.
> Tip 2: `fields.message`, `fields.InstanceNode` are strings serialized in JSON format.

### Appendix

#### TencentCloud-SQLServer「Regions and Availability」

Refer to the official Tencent documentation:

- [TencentCloud-SQLServer Region List](https://cloud.tencent.com/document/api/238/19930#.E5.9C.B0.E5.9F.9F.E5.88.97.E8.A1.A8)