---
title: 'Volcengine MongoDB Replica Set'
tags: 
  - Volcengine
summary: 'Volcengine MongoDB replica set metrics display,including CPU usage, memory usage, number of connections, latency, OPS, etc.'
__int_icon: 'icon/volcengine_mongodb'
dashboard:
  - desc: 'Volcengine MongoDB Replica Set'
    path: 'dashboard/en/volcengine_mongodb_replica_set/'
---

<!-- markdownlint-disable MD025 -->
# `Volcengine` MongoDB Replica Set
<!-- markdownlint-enable -->


`Volcengine` MongoDB replica set metrics display,including CPU usage, memory usage, number of connections, latency, OPS, etc.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation script


> Tip：Please prepare `Volcengine`  AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of **ECS** cloud resources, we install the corresponding collection script：「Guance Integration（`Volcengine` -**MongoDB Replica Set** Collect）」(ID：`guance_volcengine_mongodb_replica_set`)

Click "Install" and enter the corresponding parameters: `Volcengine` AK, `Volcengine` account name.

tap "Deploy startup Script"，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click "Run"，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs.

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-volcengine-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists


## Metric  {#metric}
Configure `Volcengine` Cloud - MongoDB Replica monitoring. The default metric set is as follows. You can collect more metrics by configuring them [`Volcengine` MongoDB Replica Monitor Metrics Details](https://console.volcengine.com/cloud_monitor/metric?namespace=VCM_MongoDB_Replica){:target="_blank"}

|`MetricName` |`Subnamespace` |Description |MetricUnit | Dimension|
| ---- |-------------------------------------| :----: |:----: |:----: |
|`AggregatedCpuUtil` |`instance` |CPU usage |Percent | ResourceID|
|`AggregatedMemUtil` |`instance` |Memory usage |Percent | ResourceID|
|`AggregatedTotalDiskUtil` |`instance` |Total disk space usage |Percent | ResourceID|
|`NetworkReceiveThroughput` |`replica` |Network input rate |Bytes/Second(SI) | ResourceID,Node|
|`RunningConcurrentWriteRequest` |`replica` |Current number of concurrent write requests |Count | ResourceID,Node|
|`LogDiskUsage` |`replica` |Log disk usage |Bytes(SI) | ResourceID,Node|
|`RunningConcurrentReadRequest` |`replica` |Current number of concurrent read requests |Count | ResourceID,Node|
|`CommandOperationPerSec` |`replica` |COMMAND operations per second |Count/Second | ResourceID,Node|
|`ReplicationDelay` |`replica` |Master/slave delay |Second | ResourceID,Node|
|`CurrConn` |`replica` |Current number of connections |Count | ResourceID,Node|
|`TotalDiskUsage` |`replica` |Total disk usage |Bytes(SI) | ResourceID,Node|
|`UpdateOperationPerSec` |`replica` |Number of UPDATE operations per second |Count/Second | ResourceID,Node|
|`MaxDiskConfigured` |`replica` |Configure the maximum available disk space |Bytes(SI) | ResourceID,Node|
|`TimeOutCursor` |`replica` |Cursor timeout count |Count | ResourceID,Node|
|`NetworkTransmitThroughput` |`replica` |Network output rate |Bytes/Second(SI) | ResourceID,Node|
|`GlobalWaitReadLockQueue` |`replica` |The length of the waiting queue for the global read lock |Count | ResourceID,Node|
|`AvailConcurrentReadRequest` |`replica` |Available concurrent read requests |Count | ResourceID,Node|
|`DataDiskUsage` |`replica` |Data disk usage |Bytes(SI) | ResourceID,Node|
|`ReadIntoCachePerSec` |`replica` |The amount of data read into the cache per second |Bytes/Second(SI) | ResourceID,Node|
|`TotalDiskUtil` |`replica` |Total disk usage |Percent | ResourceID,Node|
|`GlobalWaitWriteLockQueue` |`replica` |The length of the waiting queue for the global write lock |Count | ResourceID,Node|
|`TotalOpenCursor` |`replica` |Total number of cursors opened |Count | ResourceID,Node|
|`GetmoreOperationPerSec` |`replica` |`GETMORE` operations per second |Count/Second | ResourceID,Node|
|`MemUtil` |`replica` |Memory usage |Percent | ResourceID,Node|
|`GlobalWaitTotalLockQueue` |`replica` |Total length of the waiting queue for the global lock |Count | ResourceID,Node|
|`CpuUtil` |`replica` |CPU usage |Percent | ResourceID,Node|
|`QueryOperationPerSec` |`replica` |QUERY operations per second |Count/Second | ResourceID,Node|
|`DeleteOperationPerSec` |`replica` |Number of DELETE operations per second |Count/Second | ResourceID,Node|
|`AvailConcurrentWriteRequest` |`replica` |Available concurrent write requests |Count | ResourceID,Node|
|`InsertOperationPerSec` |`replica` |Number of INSERT operations per second |Count/Second | ResourceID,Node|
|`WrittenFromCachePerSec` |`replica` |The amount of data written from cache to disk per second |Bytes/Second(SI) | ResourceID,Node|
|`NetworkRequestPerSec` |`replica` |Number of network processing requests |Count/Second | ResourceID,Node|
|`SlowOpCount` |`replica` |Slow query statistics |Count | ResourceID,Node|
|`OplogAvailTime` |`replica` |`Oplog` availability time |Second | ResourceID,Node|


## Object  {#object}
The collected `Volcengine` Cloud **MongoDB** object data structure can see the object data from 「Infrastructure-Custom」

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

