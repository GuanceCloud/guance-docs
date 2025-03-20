---
title: 'Volcengine MongoDB Replica Set'
tags: 
  - Volcengine
summary: 'Display of Volcengine MongoDB Replica Set Metrics, including CPU usage, memory usage, number of connections, latency, OPS, etc.'
__int_icon: 'icon/volcengine_mongodb'
dashboard:
  - desc: 'Volcengine MongoDB'
    path: 'dashboard/en/volcengine_mongodb_replica_set/'
---

<!-- markdownlint-disable MD025 -->
# Volcengine MongoDB Replica Set
<!-- markdownlint-enable -->


Display of Volcengine MongoDB Replica Set metrics, including CPU usage, memory usage, number of connections, latency, OPS, etc.

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - managed Func: all prerequisites are automatically installed. Please continue with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Please prepare a qualified Volcengine AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data of MongoDB cloud resources, we install the corresponding collection script: "Guance Integration (Volcengine-MongoDB Collection)" (ID: `guance_volcengine_mongodb_replica_set`)

After clicking 【Install】, enter the corresponding parameters: Volcengine AK, Volcengine account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you want to collect the corresponding logs, you also need to enable the corresponding log collection script. If you want to collect billing information, you need to enable the cloud billing collection script.


We default to collecting some configurations, details are shown in the metrics section.

[Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-volcengine-monitor/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configuration. You can also check the corresponding task records and logs to verify if there are any abnormalities.
2. On the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, under "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Volcengine-MongoDB Replica Set monitoring, the default metric set is as follows. You can collect more metrics via configuration. [Volcengine MongoDB Monitoring Metric Details](https://console.volcengine.com/cloud_monitor/metric?namespace=VCM_MongoDB_Replica){:target="_blank"}

|`MetricName` |`Subnamespace` |Metric Name |MetricUnit | Dimension|
| ---- |-------------------------------------| :----: |:----: |:----: |
|`AggregatedCpuUtil` |`instance` |CPU Usage |Percent | ResourceID|
|`AggregatedMemUtil` |`instance` |Memory Usage |Percent | ResourceID|
|`AggregatedTotalDiskUtil` |`instance` |Total Disk Space Usage |Percent | ResourceID|
|`NetworkReceiveThroughput` |`replica` |Network Input Rate |Bytes/Second(SI) | ResourceID,Node|
|`RunningConcurrentWriteRequest` |`replica` |Current Number of Concurrent Write Requests |Count | ResourceID,Node|
|`LogDiskUsage` |`replica` |Log Disk Usage |Bytes(SI) | ResourceID,Node|
|`RunningConcurrentReadRequest` |`replica` |Current Number of Concurrent Read Requests |Count | ResourceID,Node|
|`CommandOperationPerSec` |`replica` |Number of COMMAND Operations Per Second |Count/Second | ResourceID,Node|
|`ReplicationDelay` |`replica` |Master-Slave Replication Delay |Second | ResourceID,Node|
|`CurrConn` |`replica` |Current Number of Connections |Count | ResourceID,Node|
|`TotalDiskUsage` |`replica` |Total Disk Usage |Bytes(SI) | ResourceID,Node|
|`UpdateOperationPerSec` |`replica` |Number of UPDATE Operations Per Second |Count/Second | ResourceID,Node|
|`MaxDiskConfigured` |`replica` |Maximum Configured Available Disk Space |Bytes(SI) | ResourceID,Node|
|`TimeOutCursor` |`replica` |Number of Cursor Timeouts |Count | ResourceID,Node|
|`NetworkTransmitThroughput` |`replica` |Network Output Rate |Bytes/Second(SI) | ResourceID,Node|
|`GlobalWaitReadLockQueue` |`replica` |Length of Global Read Lock Wait Queue |Count | ResourceID,Node|
|`AvailConcurrentReadRequest` |`replica` |Available Number of Concurrent Read Requests |Count | ResourceID,Node|
|`DataDiskUsage` |`replica` |Data Disk Usage |Bytes(SI) | ResourceID,Node|
|`ReadIntoCachePerSec` |`replica` |Amount of Data Read into Cache Per Second |Bytes/Second(SI) | ResourceID,Node|
|`TotalDiskUtil` |`replica` |Total Disk Usage Rate |Percent | ResourceID,Node|
|`GlobalWaitWriteLockQueue` |`replica` |Length of Global Write Lock Wait Queue |Count | ResourceID,Node|
|`TotalOpenCursor` |`replica` |Total Number of Cursors Opened |Count | ResourceID,Node|
|`GetmoreOperationPerSec` |`replica` |Number of `GETMORE` Operations Per Second |Count/Second | ResourceID,Node|
|`MemUtil` |`replica` |Memory Usage Rate |Percent | ResourceID,Node|
|`GlobalWaitTotalLockQueue` |`replica` |Total Length of Global Lock Wait Queue |Count | ResourceID,Node|
|`CpuUtil` |`replica` |CPU Usage Rate |Percent | ResourceID,Node|
|`QueryOperationPerSec` |`replica` |Number of QUERY Operations Per Second |Count/Second | ResourceID,Node|
|`DeleteOperationPerSec` |`replica` |Number of DELETE Operations Per Second |Count/Second | ResourceID,Node|
|`AvailConcurrentWriteRequest` |`replica` |Available Number of Concurrent Write Requests |Count | ResourceID,Node|
|`InsertOperationPerSec` |`replica` |Number of INSERT Operations Per Second |Count/Second | ResourceID,Node|
|`WrittenFromCachePerSec` |`replica` |Amount of Data Written from Cache to Disk Per Second |Bytes/Second(SI) | ResourceID,Node|
|`NetworkRequestPerSec` |`replica` |Number of Network Requests Handled Per Second |Count/Second | ResourceID,Node|
|`SlowOpCount` |`replica` |Slow Query Count |Count | ResourceID,Node|
|`OplogAvailTime` |`replica` |`Oplog` Available Time |Second | ResourceID,Node|



## Objects {#object}

The structure of collected Volcengine MongoDB object data can be seen in "Infrastructure - Custom".

``` json
  {
    "category": "custom_object",
    "fields": {
      "NodeSpec": "rds.mysql.d1.n.1c1g",
      "TimeZone": "UTC +08:00",
      ...
    },
    "measurement": "volcengine_mongodb_replica_set",
    "tags": {
      "AllowListVersion": "initial",
      "DBEngineVersion": "MongoDB_5_7",
      "InstanceId": "mysql-xxx",
      "InstanceName": "mysql-xxx",
      "InstanceStatus": "Running",
      "InstanceType": "DoubleNode",
      "LowerCaseTableNames": "1",
      "NodeNumber": "2",
      "ProjectName": "default",
      "RegionId": "cn-beijing",
      "StorageSpace": "20",
      "StorageType": "LocalSSD",
      "SubnetId": "subnet-xxx",
      "VpcId": "vpc-xxx",
      "ZoneId": "cn-beijing-a",
      "name": "mysql-xxx"
    }
  }

```