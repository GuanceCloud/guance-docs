---
title: 'Volcengine MongoDB Sharded Cluster'
tags: 
  - Volcengine
summary: 'Display of Volcengine MongoDB sharded cluster metrics, including CPU usage, memory usage, connections, latency, OPS, etc.'
__int_icon: 'icon/volcengine_mongodb'
dashboard:
  - desc: 'Volcengine MongoDB Sharded Cluster'
    path: 'dashboard/en/volcengine_mongodb_sharded_cluster/'
  - desc: 'Volcengine MongoDB Sharded Cluster Shard View'
    path: 'dashboard/en/volcengine_mongodb_sharded_cluster_shard/'
  - desc: 'Volcengine MongoDB Sharded Cluster ConfigServer View'
    path: 'dashboard/en/volcengine_mongodb_sharded_cluster_configserver/'
---


<!-- markdownlint-disable MD025 -->
# Volcengine MongoDB Sharded Cluster
<!-- markdownlint-enable -->


Display of Volcengine MongoDB sharded cluster metrics, including CPU usage, memory usage, connections, latency, OPS, etc.

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - managed Func: all prerequisites are automatically installed. Please continue with script installation.

If you deploy Func yourself, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Please prepare a Volcengine AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data for MongoDB cloud resources, we install the corresponding collection script: "Guance Integration (Volcengine-MongoDB Collection)" (ID: `guance_volcengine_mongodb_sharded_cluster`)

After clicking 【Install】, enter the corresponding parameters: Volcengine AK and Volcengine account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

> If you want to collect corresponding logs, you also need to enable the corresponding log collection script. If you want to collect bills, you need to enable the cloud bill collection script.


We default to collecting some configurations; see the metrics section for details.

[Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-volcengine-monitor/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have corresponding automatic trigger configurations, and you can check the corresponding task records and logs to see if there are any abnormalities.
2. On the Guance platform, in "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, under "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}

After configuring the Volcengine-MongoDB sharded cluster monitoring, the default metric sets are as follows. You can collect more metrics through configuration. [Details of Volcengine MongoDB Monitoring Metrics](https://console.volcengine.com/cloud_monitor/metric?namespace=VCM_MongoDB_Sharded_Cluster){:target="_blank"}


|`MetricName` |`Subnamespace` |Metric Name |MetricUnit | Dimension|
| ---- |-------------------------------------| :----: |:----: |:----: |
|`LogDiskUsage` |`config` |Log Disk Usage |Bytes(SI) | ResourceID,Node|
|`RunningConcurrentWriteRequest` |`config` |Current Number of Concurrent Write Requests |Count | ResourceID,Node|
|`RunningConcurrentReadRequest` |`config` |Current Number of Concurrent Read Requests |Count | ResourceID,Node|
|`CommandOperationPerSec` |`config` |Number of COMMAND Operations per Second |Count/Second | ResourceID,Node|
|`ReplicationDelay` |`config` |Replication Delay |Second | ResourceID,Node|
|`NetworkReceiveThroughput` |`config` |Network Input Rate |Bytes/Second(SI) | ResourceID,Node|
|`TotalDiskUsage` |`config` |Total Disk Usage |Bytes(SI) | ResourceID,Node|
|`UpdateOperationPerSec` |`config` |Number of UPDATE Operations per Second |Count/Second | ResourceID,Node|
|`MaxDiskConfigured` |`config` |Maximum Configured Available Disk Space |Bytes(SI) | ResourceID,Node|
|`TimeOutCursor` |`config` |Number of Cursor Timeouts |Count | ResourceID,Node|
|`CurrConn` |`config` |Current Number of Connections |Count | ResourceID,Node|
|`DataDiskUsage` |`config` |Data Disk Usage |Bytes(SI) | ResourceID,Node|
|`ReadIntoCachePerSec` |`config` |Amount of Data Read into Cache per Second |Bytes/Second(SI) | ResourceID,Node|
|`TotalDiskUtil` |`config` |Total Disk Utilization |Percent | ResourceID,Node|
|`GlobalWaitWriteLockQueue` |`config` |Length of Global Write Lock Wait Queue |Count | ResourceID,Node|
|`TotalOpenCursor` |`config` |Total Number of Cursors Opened |Count | ResourceID,Node|
|`NetworkTransmitThroughput` |`config` |Network Output Rate |Bytes/Second(SI) | ResourceID,Node|
|`GlobalWaitReadLockQueue` |`config` |Length of Global Read Lock Wait Queue |Count | ResourceID,Node|
|`AvailConcurrentReadRequest` |`config` |Available Number of Concurrent Read Requests |Count | ResourceID,Node|
|`MemUtil` |`config` |Memory Utilization |Percent | ResourceID,Node|
|`GlobalWaitTotalLockQueue` |`config` |Total Length of Global Lock Wait Queue |Count | ResourceID,Node|
|`CpuUtil` |`config` |CPU Utilization |Percent | ResourceID,Node|
|`GetmoreOperationPerSec` |`config` |Number of `GETMORE` Operations per Second |Count/Second | ResourceID,Node|
|`DeleteOperationPerSec` |`config` |Number of DELETE Operations per Second |Count/Second | ResourceID,Node|
|`AvailConcurrentWriteRequest` |`config` |Available Number of Concurrent Write Requests |Count | ResourceID,Node|
|`QueryOperationPerSec` |`config` |Number of QUERY Operations per Second |Count/Second | ResourceID,Node|
|`WrittenFromCachePerSec` |`config` |Amount of Data Written from Cache to Disk per Second |Bytes/Second(SI) | ResourceID,Node|
|`NetworkRequestPerSec` |`config` |Number of Network Requests Handled |Count/Second | ResourceID,Node|
|`InsertOperationPerSec` |`config` |Number of INSERT Operations per Second |Count/Second | ResourceID,Node|
|`SlowOpCount` |`config` |Slow Query Count Statistics |Count | ResourceID,Node|
|`OplogAvailTime` |`config` |`Oplog` Available Time |Second | ResourceID,Node|
|`AggregatedCpuUtil` |`instance` |CPU Utilization |Percent | ResourceID|
|`AggregatedMemUtil` |`instance` |Memory Utilization |Percent | ResourceID|
|`AggregatedTotalDiskUtil` |`instance` |Total Disk Space Utilization |Percent | ResourceID|
|`ChunkNumber` |`instance` |Number of Sharded Chunks |Count | ResourceID,shard|
|`NetworkTransmitThroughput` |`mongos` |Network Output Rate |Bytes/Second(SI) | ResourceID,Node|
|`GetmoreOperationPerSec` |`mongos` |Number of `GETMORE` Operations per Second |Count/Second | ResourceID,Node|
|`MemUtil` |`mongos` |Memory Utilization |Percent | ResourceID,Node|
|`CpuUtil` |`mongos` |CPU Utilization |Percent | ResourceID,Node|
|`QueryOperationPerSec` |`mongos` |Number of QUERY Operations per Second |Count/Second | ResourceID,Node|
|`DeleteOperationPerSec` |`mongos` |Number of DELETE Operations per Second |Count/Second | ResourceID,Node|
|`InsertOperationPerSec` |`mongos` |Number of INSERT Operations per Second |Count/Second | ResourceID,Node|
|`NetworkRequestPerSec` |`mongos` |Number of Network Requests Handled |Count/Second | ResourceID,Node|
|`NetworkReceiveThroughput` |`mongos` |Network Input Rate |Bytes/Second(SI) | ResourceID,Node|
|`CommandOperationPerSec` |`mongos` |Number of COMMAND Operations per Second |Count/Second | ResourceID,Node|
|`CurrConn` |`mongos` |Current Number of Connections |Count | ResourceID,Node|
|`UpdateOperationPerSec` |`mongos` |Number of UPDATE Operations per Second |Count/Second | ResourceID,Node|
|`ReadIntoCachePerSec` |`shard` |Amount of Data Read into Cache per Second |Bytes/Second(SI) | ResourceID,Node|
|`TotalDiskUtil` |`shard` |Total Disk Utilization |Percent | ResourceID,Node|
|`GlobalWaitWriteLockQueue` |`shard` |Length of Global Write Lock Wait Queue |Count | ResourceID,Node|
|`TotalOpenCursor` |`shard` |Total Number of Cursors Opened |Count | ResourceID,Node|
|`NetworkTransmitThroughput` |`shard` |Network Output Rate |Bytes/Second(SI) | ResourceID,Node|
|`GlobalWaitReadLockQueue` |`shard` |Length of Global Read Lock Wait Queue |Count | ResourceID,Node|
|`AvailConcurrentReadRequest` |`shard` |Available Number of Concurrent Read Requests |Count | ResourceID,Node|
|`DataDiskUsage` |`shard` |Data Disk Usage |Bytes(SI) | ResourceID,Node|
|`GlobalWaitTotalLockQueue` |`shard` |Total Length of Global Lock Wait Queue |Count | ResourceID,Node|
|`CpuUtil` |`shard` |CPU Utilization |Percent | ResourceID,Node|
|`GetmoreOperationPerSec` |`shard` |Number of `GETMORE` Operations per Second |Count/Second | ResourceID,Node|
|`MemUtil` |`shard` |Memory Utilization |Percent | ResourceID,Node|
|`AvailConcurrentWriteRequest` |`shard` |Available Number of Concurrent Write Requests |Count | ResourceID,Node|
|`QueryOperationPerSec` |`shard` |Number of QUERY Operations per Second |Count/Second | ResourceID,Node|
|`DeleteOperationPerSec` |`shard` |Number of DELETE Operations per Second |Count/Second | ResourceID,Node|
|`NetworkRequestPerSec` |`shard` |Number of Network Requests Handled |Count/Second | ResourceID,Node|
|`InsertOperationPerSec` |`shard` |Number of INSERT Operations per Second |Count/Second | ResourceID,Node|
|`WrittenFromCachePerSec` |`shard` |Amount of Data Written from Cache to Disk per Second |Bytes/Second(SI) | ResourceID,Node|
|`RunningConcurrentWriteRequest` |`shard` |Current Number of Concurrent Write Requests |Count | ResourceID,Node|
|`LogDiskUsage` |`shard` |Log Disk Usage |Bytes(SI) | ResourceID,Node|
|`CommandOperationPerSec` |`shard` |Number of COMMAND Operations per Second |Count/Second | ResourceID,Node|
|`ReplicationDelay` |`shard` |Replication Delay |Second | ResourceID,Node|
|`NetworkReceiveThroughput` |`shard` |Network Input Rate |Bytes/Second(SI) | ResourceID,Node|
|`RunningConcurrentReadRequest` |`shard` |Current Number of Concurrent Read Requests |Count | ResourceID,Node|
|`UpdateOperationPerSec` |`shard` |Number of UPDATE Operations per Second |Count/Second | ResourceID,Node|
|`MaxDiskConfigured` |`shard` |Maximum Configured Available Disk Space |Bytes(SI) | ResourceID,Node|
|`TimeOutCursor` |`shard` |Number of Cursor Timeouts |Count | ResourceID,Node|
|`CurrConn` |`shard` |Current Number of Connections |Count | ResourceID,Node|
|`TotalDiskUsage` |`shard` |Total Disk Usage |Bytes(SI) | ResourceID,Node|
|`SlowOpCount` |`shard` |Slow Query Count Statistics |Count | ResourceID,Node|
|`OplogAvailTime` |`shard` |`Oplog` Available Time |Second | ResourceID,Node|



## Objects {#object}

The structure of the Volcengine MongoDB object data collected can be viewed in "Infrastructure - Custom".

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