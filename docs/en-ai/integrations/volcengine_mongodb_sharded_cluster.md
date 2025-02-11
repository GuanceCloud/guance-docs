---
title: 'VolcEngine MongoDB Sharded Cluster'
tags: 
  - VolcEngine
summary: 'Displays metrics for the VolcEngine MongoDB sharded cluster, including CPU usage, memory usage, connections, latency, OPS, etc.'
__int_icon: 'icon/volcengine_mongodb'
dashboard:
  - desc: 'VolcEngine MongoDB Sharded Cluster'
    path: 'dashboard/en/volcengine_mongodb_sharded_cluster/'
  - desc: 'VolcEngine MongoDB Sharded Cluster Shard View'
    path: 'dashboard/en/volcengine_mongodb_sharded_cluster_shard/'
  - desc: 'VolcEngine MongoDB Sharded Cluster ConfigServer View'
    path: 'dashboard/en/volcengine_mongodb_sharded_cluster_configserver/'
---


<!-- markdownlint-disable MD025 -->
# VolcEngine MongoDB Sharded Cluster
<!-- markdownlint-enable -->


Displays metrics for the VolcEngine MongoDB sharded cluster, including CPU usage, memory usage, connections, latency, OPS, etc.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-hosted Func Deployment](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Prepare a VolcEngine AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

To synchronize monitoring data of MongoDB cloud resources, we need to install the corresponding collection script:「Guance Integration (VolcEngine-MongoDB Collection)」(ID: `guance_volcengine_mongodb_sharded_cluster`)

After clicking 【Install】, enter the required parameters: VolcEngine AK and VolcEngine account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Once enabled, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click 【Execute】to run it immediately without waiting for the scheduled time. Wait a moment to view the execution task records and corresponding logs.

> If you want to collect logs, enable the corresponding log collection script. If you want to collect billing data, enable the cloud billing collection script.


By default, we collect some configurations; see the metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-volcengine-monitor/){:target="_blank"}


### Verification

1. Confirm in "Management / Automatic Trigger Configuration" whether the corresponding task has an automatic trigger configuration and check the task records and logs for any anomalies.
2. In the Guance platform, go to "Infrastructure / Custom" to check if asset information exists.
3. In the Guance platform, go to "Metrics" to check if the corresponding monitoring data is available.

## Metrics {#metric}

After configuring the VolcEngine MongoDB sharded cluster monitoring, the default metric set is as follows. You can collect more metrics by configuring further. [VolcEngine MongoDB Monitoring Metric Details](https://console.volcengine.com/cloud_monitor/metric?namespace=VCM_MongoDB_Sharded_Cluster){:target="_blank"}


|`MetricName` |`Subnamespace` |Metric Description |MetricUnit | Dimension|
| ---- |-------------------------------------| :----: |:----: |:----: |
|`LogDiskUsage` |`config` |Log Disk Usage |Bytes(SI) | ResourceID,Node|
|`RunningConcurrentWriteRequest` |`config` |Current Concurrent Write Requests |Count | ResourceID,Node|
|`RunningConcurrentReadRequest` |`config` |Current Concurrent Read Requests |Count | ResourceID,Node|
|`CommandOperationPerSec` |`config` |COMMAND Operations per Second |Count/Second | ResourceID,Node|
|`ReplicationDelay` |`config` |Replication Delay |Second | ResourceID,Node|
|`NetworkReceiveThroughput` |`config` |Network Input Rate |Bytes/Second(SI) | ResourceID,Node|
|`TotalDiskUsage` |`config` |Total Disk Usage |Bytes(SI) | ResourceID,Node|
|`UpdateOperationPerSec` |`config` |UPDATE Operations per Second |Count/Second | ResourceID,Node|
|`MaxDiskConfigured` |`config` |Configured Maximum Available Disk Space |Bytes(SI) | ResourceID,Node|
|`TimeOutCursor` |`config` |Cursor Timeout Count |Count | ResourceID,Node|
|`CurrConn` |`config` |Current Connections |Count | ResourceID,Node|
|`DataDiskUsage` |`config` |Data Disk Usage |Bytes(SI) | ResourceID,Node|
|`ReadIntoCachePerSec` |`config` |Data Read into Cache per Second |Bytes/Second(SI) | ResourceID,Node|
|`TotalDiskUtil` |`config` |Total Disk Utilization |Percent | ResourceID,Node|
|`GlobalWaitWriteLockQueue` |`config` |Global Write Lock Wait Queue Length |Count | ResourceID,Node|
|`TotalOpenCursor` |`config` |Total Open Cursors |Count | ResourceID,Node|
|`NetworkTransmitThroughput` |`config` |Network Output Rate |Bytes/Second(SI) | ResourceID,Node|
|`GlobalWaitReadLockQueue` |`config` |Global Read Lock Wait Queue Length |Count | ResourceID,Node|
|`AvailConcurrentReadRequest` |`config` |Available Concurrent Read Requests |Count | ResourceID,Node|
|`MemUtil` |`config` |Memory Utilization |Percent | ResourceID,Node|
|`GlobalWaitTotalLockQueue` |`config` |Total Global Lock Wait Queue Length |Count | ResourceID,Node|
|`CpuUtil` |`config` |CPU Utilization |Percent | ResourceID,Node|
|`GetmoreOperationPerSec` |`config` |GETMORE Operations per Second |Count/Second | ResourceID,Node|
|`DeleteOperationPerSec` |`config` |DELETE Operations per Second |Count/Second | ResourceID,Node|
|`AvailConcurrentWriteRequest` |`config` |Available Concurrent Write Requests |Count | ResourceID,Node|
|`QueryOperationPerSec` |`config` |QUERY Operations per Second |Count/Second | ResourceID,Node|
|`WrittenFromCachePerSec` |`config` |Data Written from Cache per Second |Bytes/Second(SI) | ResourceID,Node|
|`NetworkRequestPerSec` |`config` |Network Requests per Second |Count/Second | ResourceID,Node|
|`InsertOperationPerSec` |`config` |INSERT Operations per Second |Count/Second | ResourceID,Node|
|`SlowOpCount` |`config` |Slow Query Count |Count | ResourceID,Node|
|`OplogAvailTime` |`config` |Oplog Available Time |Second | ResourceID,Node|
|`AggregatedCpuUtil` |`instance` |CPU Utilization |Percent | ResourceID|
|`AggregatedMemUtil` |`instance` |Memory Utilization |Percent | ResourceID|
|`AggregatedTotalDiskUtil` |`instance` |Total Disk Utilization |Percent | ResourceID|
|`ChunkNumber` |`instance` |Shard Chunk Count |Count | ResourceID,shard|
|`NetworkTransmitThroughput` |`mongos` |Network Output Rate |Bytes/Second(SI) | ResourceID,Node|
|`GetmoreOperationPerSec` |`mongos` |GETMORE Operations per Second |Count/Second | ResourceID,Node|
|`MemUtil` |`mongos` |Memory Utilization |Percent | ResourceID,Node|
|`CpuUtil` |`mongos` |CPU Utilization |Percent | ResourceID,Node|
|`QueryOperationPerSec` |`mongos` |QUERY Operations per Second |Count/Second | ResourceID,Node|
|`DeleteOperationPerSec` |`mongos` |DELETE Operations per Second |Count/Second | ResourceID,Node|
|`InsertOperationPerSec` |`mongos` |INSERT Operations per Second |Count/Second | ResourceID,Node|
|`NetworkRequestPerSec` |`mongos` |Network Requests per Second |Count/Second | ResourceID,Node|
|`NetworkReceiveThroughput` |`mongos` |Network Input Rate |Bytes/Second(SI) | ResourceID,Node|
|`CommandOperationPerSec` |`mongos` |COMMAND Operations per Second |Count/Second | ResourceID,Node|
|`CurrConn` |`mongos` |Current Connections |Count | ResourceID,Node|
|`UpdateOperationPerSec` |`mongos` |UPDATE Operations per Second |Count/Second | ResourceID,Node|
|`ReadIntoCachePerSec` |`shard` |Data Read into Cache per Second |Bytes/Second(SI) | ResourceID,Node|
|`TotalDiskUtil` |`shard` |Total Disk Utilization |Percent | ResourceID,Node|
|`GlobalWaitWriteLockQueue` |`shard` |Global Write Lock Wait Queue Length |Count | ResourceID,Node|
|`TotalOpenCursor` |`shard` |Total Open Cursors |Count | ResourceID,Node|
|`NetworkTransmitThroughput` |`shard` |Network Output Rate |Bytes/Second(SI) | ResourceID,Node|
|`GlobalWaitReadLockQueue` |`shard` |Global Read Lock Wait Queue Length |Count | ResourceID,Node|
|`AvailConcurrentReadRequest` |`shard` |Available Concurrent Read Requests |Count | ResourceID,Node|
|`DataDiskUsage` |`shard` |Data Disk Usage |Bytes(SI) | ResourceID,Node|
|`GlobalWaitTotalLockQueue` |`shard` |Total Global Lock Wait Queue Length |Count | ResourceID,Node|
|`CpuUtil` |`shard` |CPU Utilization |Percent | ResourceID,Node|
|`GetmoreOperationPerSec` |`shard` |GETMORE Operations per Second |Count/Second | ResourceID,Node|
|`MemUtil` |`shard` |Memory Utilization |Percent | ResourceID,Node|
|`AvailConcurrentWriteRequest` |`shard` |Available Concurrent Write Requests |Count | ResourceID,Node|
|`QueryOperationPerSec` |`shard` |QUERY Operations per Second |Count/Second | ResourceID,Node|
|`DeleteOperationPerSec` |`shard` |DELETE Operations per Second |Count/Second | ResourceID,Node|
|`NetworkRequestPerSec` |`shard` |Network Requests per Second |Count/Second | ResourceID,Node|
|`InsertOperationPerSec` |`shard` |INSERT Operations per Second |Count/Second | ResourceID,Node|
|`WrittenFromCachePerSec` |`shard` |Data Written from Cache per Second |Bytes/Second(SI) | ResourceID,Node|
|`RunningConcurrentWriteRequest` |`shard` |Current Concurrent Write Requests |Count | ResourceID,Node|
|`LogDiskUsage` |`shard` |Log Disk Usage |Bytes(SI) | ResourceID,Node|
|`CommandOperationPerSec` |`shard` |COMMAND Operations per Second |Count/Second | ResourceID,Node|
|`ReplicationDelay` |`shard` |Replication Delay |Second | ResourceID,Node|
|`NetworkReceiveThroughput` |`shard` |Network Input Rate |Bytes/Second(SI) | ResourceID,Node|
|`RunningConcurrentReadRequest` |`shard` |Current Concurrent Read Requests |Count | ResourceID,Node|
|`UpdateOperationPerSec` |`shard` |UPDATE Operations per Second |Count/Second | ResourceID,Node|
|`MaxDiskConfigured` |`shard` |Configured Maximum Available Disk Space |Bytes(SI) | ResourceID,Node|
|`TimeOutCursor` |`shard` |Cursor Timeout Count |Count | ResourceID,Node|
|`CurrConn` |`shard` |Current Connections |Count | ResourceID,Node|
|`TotalDiskUsage` |`shard` |Total Disk Usage |Bytes(SI) | ResourceID,Node|
|`SlowOpCount` |`shard` |Slow Query Count |Count | ResourceID,Node|
|`OplogAvailTime` |`shard` |Oplog Available Time |Second | ResourceID,Node|



## Objects {#object}

The structure of collected VolcEngine MongoDB object data can be viewed in "Infrastructure - Custom".

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