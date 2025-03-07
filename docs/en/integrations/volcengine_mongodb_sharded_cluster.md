---
title: 'Volcengine MongoDB Sharded Cluster'
tags: 
  - Volcengine
summary: 'Volcengine MongoDB Sharded Cluster metrics display,including CPU usage, memory usage, number of connections, latency, OPS, etc.'
__int_icon: 'icon/volcengine_mongodb'
dashboard:
  - desc: 'Volcengine Mongodb Sharded Cluster'
    path: 'dashboard/en/volcengine_mongodb_sharded_cluster/'
  - desc: 'Volcengine Mongodb Sharded Cluster for Shard'
    path: 'dashboard/en/volcengine_mongodb_sharded_cluster_shard/'
  - desc: 'Volcengine Mongodb Sharded Cluster for ConfigServer'
    path: 'dashboard/en/volcengine_mongodb_sharded_cluster_configserver/'
---

<!-- markdownlint-disable MD025 -->
# `Volcengine` MongoDB Sharded Cluster
<!-- markdownlint-enable -->


`Volcengine` MongoDB Sharded Cluster metrics display,including CPU usage, memory usage, number of connections, latency, OPS, etc.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation script


> Tip：Please prepare `Volcengine`  AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of **ECS** cloud resources, we install the corresponding collection script：「Guance Integration（`Volcengine` -**MongoDB Sharded Cluster** Collect）」(ID：`guance_volcengine_mongodb_sharded_cluster`)

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
Configure `Volcengine` - MongoDB Sharded Cluster monitoring. The default metric set is as follows. You can collect more metrics by configuring them [`Volcengine` MongoDB Replica Monitor Metrics Details](https://console.volcengine.com/cloud_monitor/metric?namespace=VCM_MongoDB_Sharded_Cluster){:target="_blank"}

|`MetricName` |`Subnamespace` |Description |MetricUnit | Dimension|
| ---- |-------------------------------------| :----: |:----: |:----: |
|`LogDiskUsage` |`config` |Log disk usage |Bytes(SI) | ResourceID|
|`RunningConcurrentWriteRequest` |`config` |Current number of concurrent write requests |Count | ResourceID|
|`RunningConcurrentReadRequest` |`config` |Current number of concurrent read requests |Count | ResourceID|
|`CommandOperationPerSec` |`config` |COMMAND operations per second |Count/Second | ResourceID,Node|
|`ReplicationDelay` |`config` |Master/slave delay |Second | ResourceID,Node|
|`NetworkReceiveThroughput` |`config` |Network input rate |Bytes/Second(SI) | ResourceID,Node|
|`TotalDiskUsage` |`config` |Total disk usage |Bytes(SI) | ResourceID,Node|
|`UpdateOperationPerSec` |`config` |Number of UPDATE operations per second |Count/Second | ResourceID,Node|
|`MaxDiskConfigured` |`config` |Configure the maximum available disk space |Bytes(SI) | ResourceID,Node|
|`TimeOutCursor` |`config` |Cursor timeout count |Count | ResourceID,Node|
|`CurrConn` |`config` |Current number of connections |Count | ResourceID,Node|
|`DataDiskUsage` |`config` |Data disk usage |Bytes(SI) | ResourceID,Node|
|`ReadIntoCachePerSec` |`config` |The amount of data read into the cache per second |Bytes/Second(SI) | ResourceID,Node|
|`TotalDiskUtil` |`config` |Total disk usage |Percent | ResourceID,Node|
|`GlobalWaitWriteLockQueue` |`config` |The length of the waiting queue for the global write lock |Count | ResourceID,Node|
|`TotalOpenCursor` |`config` |Total number of cursors opened |Count | ResourceID,Node|
|`NetworkTransmitThroughput` |`config` |Network output rate |Bytes/Second(SI) | ResourceID,Node|
|`GlobalWaitReadLockQueue` |`config` |The length of the waiting queue for the global read lock |Count | ResourceID,Node|
|`AvailConcurrentReadRequest` |`config` |Available concurrent read requests |Count | ResourceID,Node|
|`MemUtil` |`config` |Memory usage |Percent | ResourceID,Node|
|`GlobalWaitTotalLockQueue` |`config` |Total length of the waiting queue for the global lock |Count | ResourceID,Node|
|`CpuUtil` |`config` |CPU usage |Percent | ResourceID,Node|
|`GetmoreOperationPerSec` |`config` |`GETMORE` operations per second |Count/Second | ResourceID,Node|
|`DeleteOperationPerSec` |`config` |Number of DELETE operations per second |Count/Second | ResourceID,Node|
|`AvailConcurrentWriteRequest` |`config` |Available concurrent write requests |Count | ResourceID,Node|
|`QueryOperationPerSec` |`config` |QUERY operations per second |Count/Second | ResourceID,Node|
|`WrittenFromCachePerSec` |`config` |The amount of data written from cache to disk per second |Bytes/Second(SI) | ResourceID,Node|
|`NetworkRequestPerSec` |`config` |Number of network processing requests |Count/Second | ResourceID,Node|
|`InsertOperationPerSec` |`config` |Number of INSERT operations per second |Count/Second | ResourceID,Node|
|`SlowOpCount` |`config` |Slow query statistics |Count | ResourceID,Node|
|`OplogAvailTime` |`config` |Oplog availability time |Second | ResourceID,Node|
|`AggregatedCpuUtil` |`instance` |CPU usage |Percent | ResourceID,Node|
|`AggregatedMemUtil` |`instance` |Memory usage |Percent | ResourceID,Node|
|`AggregatedTotalDiskUtil` |`instance` |Total disk space usage |Percent | ResourceID,Node|
|`ChunkNumber` |`instance` |Number of fragment chunks |Count | ResourceID,shard|
|`NetworkTransmitThroughput` |`mongos` |Network output rate |Bytes/Second(SI) | ResourceID,Node|
|`GetmoreOperationPerSec` |`mongos` |`GETMORE` operations per second |Count/Second | ResourceID,Node|
|`MemUtil` |`mongos` |Memory usage |Percent | ResourceID,Node|
|`CpuUtil` |`mongos` |CPU usage |Percent | ResourceID,Node|
|`QueryOperationPerSec` |`mongos` |QUERY operations per second |Count/Second | ResourceID,Node|
|`DeleteOperationPerSec` |`mongos` |Number of DELETE operations per second |Count/Second | ResourceID,Node|
|`InsertOperationPerSec` |`mongos` |Number of INSERT operations per second |Count/Second | ResourceID,Node|
|`NetworkRequestPerSec` |`mongos` |Number of network processing requests |Count/Second | ResourceID,Node|
|`NetworkReceiveThroughput` |`mongos` |Network input rate |Bytes/Second(SI) | ResourceID,Node|
|`CommandOperationPerSec` |`mongos` |COMMAND operations per second |Count/Second | ResourceID,Node|
|`CurrConn` |`mongos` |Current number of connections |Count | ResourceID,Node|
|`UpdateOperationPerSec` |`mongos` |Number of UPDATE operations per second |Count/Second | ResourceID,Node|
|`ReadIntoCachePerSec` |`Shard` |The amount of data read into the cache per second |Bytes/Second(SI) | ResourceID,Node|
|`TotalDiskUtil` |`Shard` |Total disk usage |Percent | ResourceID,Node|
|`GlobalWaitWriteLockQueue` |`Shard` |The length of the waiting queue for the global write lock |Count | ResourceID,Node|
|`TotalOpenCursor` |`Shard` |Total number of cursors opened |Count | ResourceID,Node|
|`NetworkTransmitThroughput` |`Shard` |Network output rate |Bytes/Second(SI) | ResourceID,Node|
|`GlobalWaitReadLockQueue` |`Shard` |The length of the waiting queue for the global read lock |Count | ResourceID,Node|
|`AvailConcurrentReadRequest` |`Shard` |Available concurrent read requests |Count | ResourceID,Node|
|`DataDiskUsage` |`Shard` |Data disk usage |Bytes(SI) | ResourceID,Node|
|`GlobalWaitTotalLockQueue` |`Shard` |Total length of the waiting queue for the global lock |Count | ResourceID,Node|
|`CpuUtil` |`Shard` |CPU usage |Percent | ResourceID,Node|
|`GetmoreOperationPerSec` |`Shard` |`GETMORE` operations per second |Count/Second | ResourceID,Node|
|`MemUtil` |`Shard` |Memory usage |Percent | ResourceID,Node|
|`AvailConcurrentWriteRequest` |`Shard` |Available concurrent write requests |Count | ResourceID,Node|
|`QueryOperationPerSec` |`Shard` |QUERY operations per second |Count/Second | ResourceID,Node|
|`DeleteOperationPerSec` |`Shard` |Number of DELETE operations per second |Count/Second | ResourceID,Node|
|`NetworkRequestPerSec` |`Shard` |Number of network processing requests |Count/Second | ResourceID,Node|
|`InsertOperationPerSec` |`Shard` |Number of INSERT operations per second |Count/Second | ResourceID,Node|
|`WrittenFromCachePerSec` |`Shard` |The amount of data written from cache to disk per second |Bytes/Second(SI) | ResourceID,Node|
|`RunningConcurrentWriteRequest` |`Shard` |Current number of concurrent write requests |Count | ResourceID,Node|
|`LogDiskUsage` |`Shard` |Log disk usage |Bytes(SI) | ResourceID,Node|
|`CommandOperationPerSec` |`Shard` |COMMAND operations per second |Count/Second | ResourceID,Node|
|`ReplicationDelay` |`Shard` |Master/slave delay |Second | ResourceID,Node|
|`NetworkReceiveThroughput` |`Shard` |Network input rate |Bytes/Second(SI) | ResourceID,Node|
|`RunningConcurrentReadRequest` |`Shard` |Current number of concurrent read requests |Count | ResourceID,Node|
|`UpdateOperationPerSec` |`Shard` |Number of UPDATE operations per second |Count/Second | ResourceID,Node|
|`MaxDiskConfigured` |`Shard` |Configure the maximum available disk space |Bytes(SI) | ResourceID,Node|
|`TimeOutCursor` |`Shard` |Cursor timeout count |Count | ResourceID,Node|
|`CurrConn` |`Shard` |Current number of connections |Count | ResourceID,Node|
|`TotalDiskUsage` |`Shard` |Total disk usage |Bytes(SI) | ResourceID,Node|
|`SlowOpCount` |`Shard` |Slow query statistics |Count | ResourceID,Node|
|`OplogAvailTime` |`Shard` |`Oplog` availability time |Second | ResourceID,Node|


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

