---
title: 'VolcEngine MongoDB Replica Set'
tags: 
  - VolcEngine
summary: 'Displays VolcEngine MongoDB Replica Set metrics, including CPU utilization, memory utilization, connections, latency, OPS, etc.'
__int_icon: 'icon/volcengine_mongodb'
dashboard:
  - desc: 'VolcEngine MongoDB'
    path: 'dashboard/en/volcengine_mongodb_replica_set/'
---

<!-- markdownlint-disable MD025 -->
# VolcEngine MongoDB Replica Set
<!-- markdownlint-enable -->


Displays VolcEngine MongoDB Replica Set metrics, including CPU utilization, memory utilization, connections, latency, OPS, etc.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a VolcEngine AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data for MongoDB cloud resources, we install the corresponding collection script: 「Guance Integration (VolcEngine-MongoDB Collection)」(ID: `guance_volcengine_mongodb_replica_set`)

After clicking 【Install】, enter the required parameters: VolcEngine AK, VolcEngine account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Once enabled, you can see the corresponding automatic trigger configuration under 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. Wait a moment, then check the execution task records and corresponding logs.

> If you need to collect corresponding logs, enable the corresponding log collection script. If you need to collect billing information, enable the cloud billing collection script.


We default to collecting some configurations; see the Metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-volcengine-monitor/){:target="_blank"}

### Verification

1. Confirm in 「Management / Automatic Trigger Configuration」whether the corresponding tasks have the corresponding automatic trigger configurations, and check the corresponding task records and logs for any anomalies.
2. In the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. In the Guance platform, under 「Metrics」, check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring VolcEngine MongoDB Replica Set monitoring, the default metric set is as follows. You can collect more metrics through configuration. [VolcEngine MongoDB Monitoring Metric Details](https://console.volcengine.com/cloud_monitor/metric?namespace=VCM_MongoDB_Replica){:target="_blank"}

|`MetricName` |`Subnamespace` |Metric Name |MetricUnit | Dimension|
| ---- |-------------------------------------| :----: |:----: |:----: |
|`AggregatedCpuUtil` |`instance` |CPU Utilization |Percent | ResourceID|
|`AggregatedMemUtil` |`instance` |Memory Utilization |Percent | ResourceID|
|`AggregatedTotalDiskUtil` |`instance` |Total Disk Space Utilization |Percent | ResourceID|
|`NetworkReceiveThroughput` |`replica` |Network Input Rate |Bytes/Second(SI) | ResourceID,Node|
|`RunningConcurrentWriteRequest` |`replica` |Current Concurrent Write Requests |Count | ResourceID,Node|
|`LogDiskUsage` |`replica` |Log Disk Usage |Bytes(SI) | ResourceID,Node|
|`RunningConcurrentReadRequest` |`replica` |Current Concurrent Read Requests |Count | ResourceID,Node|
|`CommandOperationPerSec` |`replica` |COMMAND Operations per Second |Count/Second | ResourceID,Node|
|`ReplicationDelay` |`replica` |Replication Delay |Second | ResourceID,Node|
|`CurrConn` |`replica` |Current Connections |Count | ResourceID,Node|
|`TotalDiskUsage` |`replica` |Total Disk Usage |Bytes(SI) | ResourceID,Node|
|`UpdateOperationPerSec` |`replica` |UPDATE Operations per Second |Count/Second | ResourceID,Node|
|`MaxDiskConfigured` |`replica` |Configured Maximum Available Disk Space |Bytes(SI) | ResourceID,Node|
|`TimeOutCursor` |`replica` |Timeout Cursors |Count | ResourceID,Node|
|`NetworkTransmitThroughput` |`replica` |Network Output Rate |Bytes/Second(SI) | ResourceID,Node|
|`GlobalWaitReadLockQueue` |`replica` |Global Read Lock Queue Length |Count | ResourceID,Node|
|`AvailConcurrentReadRequest` |`replica` |Available Concurrent Read Requests |Count | ResourceID,Node|
|`DataDiskUsage` |`replica` |Data Disk Usage |Bytes(SI) | ResourceID,Node|
|`ReadIntoCachePerSec` |`replica` |Data Read into Cache per Second |Bytes/Second(SI) | ResourceID,Node|
|`TotalDiskUtil` |`replica` |Total Disk Utilization |Percent | ResourceID,Node|
|`GlobalWaitWriteLockQueue` |`replica` |Global Write Lock Queue Length |Count | ResourceID,Node|
|`TotalOpenCursor` |`replica` |Total Open Cursors |Count | ResourceID,Node|
|`GetmoreOperationPerSec` |`replica` |GETMORE Operations per Second |Count/Second | ResourceID,Node|
|`MemUtil` |`replica` |Memory Utilization |Percent | ResourceID,Node|
|`GlobalWaitTotalLockQueue` |`replica` |Total Global Lock Queue Length |Count | ResourceID,Node|
|`CpuUtil` |`replica` |CPU Utilization |Percent | ResourceID,Node|
|`QueryOperationPerSec` |`replica` |QUERY Operations per Second |Count/Second | ResourceID,Node|
|`DeleteOperationPerSec` |`replica` |DELETE Operations per Second |Count/Second | ResourceID,Node|
|`AvailConcurrentWriteRequest` |`replica` |Available Concurrent Write Requests |Count | ResourceID,Node|
|`InsertOperationPerSec` |`replica` |INSERT Operations per Second |Count/Second | ResourceID,Node|
|`WrittenFromCachePerSec` |`replica` |Data Written from Cache per Second |Bytes/Second(SI) | ResourceID,Node|
|`NetworkRequestPerSec` |`replica` |Network Request Handling per Second |Count/Second | ResourceID,Node|
|`SlowOpCount` |`replica` |Slow Query Count |Count | ResourceID,Node|
|`OplogAvailTime` |`replica` |Oplog Available Time |Second | ResourceID,Node|

## Objects {#object}

The collected VolcEngine MongoDB object data structure can be viewed in 「Infrastructure - Custom」

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