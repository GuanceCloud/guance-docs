---
title: 'VolcEngine MongoDB Replica Set'
tags: 
  - VolcEngine
summary: 'Displays VolcEngine MongoDB replica set metrics, including CPU usage, memory usage, connections, latency, OPS, etc.'
__int_icon: 'icon/volcengine_mongodb'
dashboard:
  - desc: 'VolcEngine MongoDB'
    path: 'dashboard/en/volcengine_mongodb_replica_set/'
---

<!-- markdownlint-disable MD025 -->
# VolcEngine MongoDB Replica Set
<!-- markdownlint-enable -->


Displays VolcEngine MongoDB replica set metrics, including CPU usage, memory usage, connections, latency, OPS, etc.

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Prepare a qualified VolcEngine AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data of MongoDB cloud resources, we install the corresponding collection script: "Guance Integration (VolcEngine-MongoDB Collection)" (ID: `guance_volcengine_mongodb_replica_set`)

After clicking 【Install】, enter the corresponding parameters: VolcEngine AK and VolcEngine account name.

Click 【Deploy Startup Script】; the system will automatically create a `Startup` script set and configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

> If you need to collect logs, you also need to enable the corresponding log collection script. If you need to collect billing information, you need to enable the cloud billing collection script.


We have collected some configurations by default; for more details, see the metrics section.

[Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-volcengine-monitor/){:target="_blank"}

### Verification

1. In "Manage / Automatic Trigger Configuration", confirm that the corresponding automatic trigger configuration exists for the task and check the task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring VolcEngine-MongoDB replica set monitoring, the default metric set is as follows. You can collect more metrics through configuration. [VolcEngine MongoDB Monitoring Metrics Details](https://console.volcengine.com/cloud_monitor/metric?namespace=VCM_MongoDB_Replica){:target="_blank"}

|`MetricName` |`Subnamespace` |Metric Name |MetricUnit | Dimension|
| ---- |-------------------------------------| :----: |:----: |:----: |
|`AggregatedCpuUtil` |`instance` |CPU Utilization |Percent | ResourceID|
|`AggregatedMemUtil` |`instance` |Memory Utilization |Percent | ResourceID|
|`AggregatedTotalDiskUtil` |`instance` |Total Disk Space Utilization |Percent | ResourceID|
|`NetworkReceiveThroughput` |`replica` |Network Input Rate |Bytes/Second(SI) | ResourceID,Node|
|`RunningConcurrentWriteRequest` |`replica` |Current Concurrent Write Requests |Count | ResourceID,Node|
|`LogDiskUsage` |`replica` |Log Disk Usage |Bytes(SI) | ResourceID,Node|
|`RunningConcurrentReadRequest` |`replica` |Current Concurrent Read Requests |Count | ResourceID,Node|
|`CommandOperationPerSec` |`replica` |COMMAND Operations Per Second |Count/Second | ResourceID,Node|
|`ReplicationDelay` |`replica` |Replication Delay |Second | ResourceID,Node|
|`CurrConn` |`replica` |Current Connections |Count | ResourceID,Node|
|`TotalDiskUsage` |`replica` |Total Disk Usage |Bytes(SI) | ResourceID,Node|
|`UpdateOperationPerSec` |`replica` |UPDATE Operations Per Second |Count/Second | ResourceID,Node|
|`MaxDiskConfigured` |`replica` |Configured Maximum Available Disk Space |Bytes(SI) | ResourceID,Node|
|`TimeOutCursor` |`replica` |Cursor Timeout Count |Count | ResourceID,Node|
|`NetworkTransmitThroughput` |`replica` |Network Output Rate |Bytes/Second(SI) | ResourceID,Node|
|`GlobalWaitReadLockQueue` |`replica` |Length of Global Read Lock Wait Queue |Count | ResourceID,Node|
|`AvailConcurrentReadRequest` |`replica` |Available Concurrent Read Requests |Count | ResourceID,Node|
|`DataDiskUsage` |`replica` |Data Disk Usage |Bytes(SI) | ResourceID,Node|
|`ReadIntoCachePerSec` |`replica` |Data Read into Cache Per Second |Bytes/Second(SI) | ResourceID,Node|
|`TotalDiskUtil` |`replica` |Total Disk Utilization |Percent | ResourceID,Node|
|`GlobalWaitWriteLockQueue` |`replica` |Length of Global Write Lock Wait Queue |Count | ResourceID,Node|
|`TotalOpenCursor` |`replica` |Total Open Cursors |Count | ResourceID,Node|
|`GetmoreOperationPerSec` |`replica` |GETMORE Operations Per Second |Count/Second | ResourceID,Node|
|`MemUtil` |`replica` |Memory Utilization |Percent | ResourceID,Node|
|`GlobalWaitTotalLockQueue` |`replica` |Total Length of Global Lock Wait Queue |Count | ResourceID,Node|
|`CpuUtil` |`replica` |CPU Utilization |Percent | ResourceID,Node|
|`QueryOperationPerSec` |`replica` |QUERY Operations Per Second |Count/Second | ResourceID,Node|
|`DeleteOperationPerSec` |`replica` |DELETE Operations Per Second |Count/Second | ResourceID,Node|
|`AvailConcurrentWriteRequest` |`replica` |Available Concurrent Write Requests |Count | ResourceID,Node|
|`InsertOperationPerSec` |`replica` |INSERT Operations Per Second |Count/Second | ResourceID,Node|
|`WrittenFromCachePerSec` |`replica` |Data Written from Cache to Disk Per Second |Bytes/Second(SI) | ResourceID,Node|
|`NetworkRequestPerSec` |`replica` |Network Request Processing Rate |Count/Second | ResourceID,Node|
|`SlowOpCount` |`replica` |Slow Query Count |Count | ResourceID,Node|
|`OplogAvailTime` |`replica` |Oplog Availability Time |Second | ResourceID,Node|

## Object {#object}

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
