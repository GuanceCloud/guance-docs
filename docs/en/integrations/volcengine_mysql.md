---
title: 'Volcengine MySQL'
tags: 
  - Volcengine
summary: 'Volcengine MySQL indicators display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc.'
__int_icon: 'icon/volcengine_mysql'
dashboard:
  - desc: 'Volcengine MySQL'
    path: 'dashboard/en/volcengine_mysql/'
---

<!-- markdownlint-disable MD025 -->
# `Volcengine` MySQL
<!-- markdownlint-enable -->

`Volcengine` MySQL indicators display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc.

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation script


> Tip：Please prepare `Volcengine`  AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of **MySQL** cloud resources, we install the corresponding collection script：「Guance Integration（`Volcengine`  -**MySQL** Collect）」(ID：`guance_volcengine_mysql`)

Click "Install" and enter the corresponding parameters: `Volcengine`  AK, `Volcengine`  account name.

tap "Deploy startup Script"，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click "Run"，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs.

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-volcengine-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists


## Metric  {#metric}
Configure `Volcengine` Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [`Volcengine` Cloud Monitor Metrics Details](https://console.volcengine.com/cloud_monitor/metricDoc?tabKey=metric&namespace=VCM_MySQL){:target="_blank"}

|`MetricName` |`Subnamespace` |Indicator Chinese name |MetricUnit | Dimension|
| ---- |-------------------------------------| :----: |:----: |:----: |
|`ReplicationDelay` |`deploy_monitor_new` |Slave replication delay |Second | ResourceID,Node|
|`SlowQueries` |`engine_monitor_new` |Number of slow queries |Count/Second | ResourceID,Node|
|`ThreadsConnected` |`engine_monitor_new` |Current number of open connections |Count | ResourceID,Node|
|`ThreadsCreated` |`engine_monitor_new` |Number of threads created |Count | ResourceID,Node|
|`ThreadsRunning` |`engine_monitor_new` |Number of running threads |Count | ResourceID,Node|
|`SelectScan` |`engine_monitor_new` |Number of full table scans |Count/Second | ResourceID,Node|
|`OperationUpdate` |`engine_monitor_new` |Number of updates |Count/Second | ResourceID,Node|
|`OperationDelete` |`engine_monitor_new` |Delete number |Count/Second | ResourceID,Node|
|`OperationInsert` |`engine_monitor_new` |Number of insertions |Count/Second | ResourceID,Node|
|`OperationReplace` |`engine_monitor_new` |Coverage |Count/Second | ResourceID,Node|
|`OperationCommit` |`engine_monitor_new` |Number of submissions |Count/Second | ResourceID,Node|
|`OperationRollback` |`engine_monitor_new` |Rollback number |Count/Second | ResourceID,Node|
|`CreatedTmpTables` |`engine_monitor_new` |Number of temporary tables |Count/Second | ResourceID,Node|
|`TableLocksWaited` |`engine_monitor_new` |Number of waits for table locks |Count/Second | ResourceID,Node|
|`OpenedTables` |`engine_monitor_new` |Number of open tables |Count | ResourceID,Node|
|`InnodbCacheHitRate` |`engine_monitor_new` |Innodb cache hit rate |Percent | ResourceID,Node|
|`InnodbCacheUtil` |`engine_monitor_new` |Innodb cache usage |Percent | ResourceID,Node|
|`InnodbNumOpenFiles` |`engine_monitor_new` |Number of Innodb currently open tables |Count | ResourceID,Node|
|`InnodbDataRead` |`engine_monitor_new` |Innodb read volume |Bytes/Second(SI) | ResourceID,Node|
|`InnodbDataWritten` |`engine_monitor_new` |Innodb write volume |Bytes/Second(SI) | ResourceID,Node|
|`InnodbRowsDeleted` |`engine_monitor_new` |Innodb row deletion amount |Count/Second | ResourceID,Node|
|`InnodbRowsUpdated` |`engine_monitor_new` |Innodb row update amount |Count/Second | ResourceID,Node|
|`InnodbRowsInserted` |`engine_monitor_new` |Innodb row insert amount |Count/Second | ResourceID,Node|
|`InnodbDataReadBytes` |`engine_monitor_new` |Innodb row reads |Count/Second | ResourceID,Node|
|`InnodbRowsLockTimeAvg` |`engine_monitor_new` |Innodb average waiting time for acquiring row locks |Millisecond | ResourceID,Node|
|`InnodbRowLockWaits` |`engine_monitor_new` |Innodb wait times for row locks |Count/Second | ResourceID,Node|
|`CreatedTmpFiles` |`engine_monitor_new` |Number of temporary files |Count/Second | ResourceID,Node|
|`HandlerReadRndNext` |`engine_monitor_new` |Number of read next line requests |Count/Second | ResourceID,Node|
|`HandlerRollback` |`engine_monitor_new` |Internal rollback number |Count/Second | ResourceID,Node|
|`HandlerCommit` |`engine_monitor_new` |Internal submissions |Count/Second | ResourceID,Node|
|`InnodbBufferPoolPagesFree` |`engine_monitor_new` |Innodb empty pages |Count | ResourceID,Node|
|`TotalInnodbBufferPoolPages` |`engine_monitor_new` |Innodb total pages |Count | ResourceID,Node|
|`InnodbBufferPoolReadRequests` |`engine_monitor_new` |Innodb logical read |Count/Second | ResourceID,Node|
|`InnodbBufferPoolReads` |`engine_monitor_new` |Innodb physical read |Count/Second | ResourceID,Node|
|`InnodbDataReadCounts` |`engine_monitor_new` |Innodb read count |Count/Second | ResourceID,Node|
|`InnodbDataWriteCounts` |`engine_monitor_new` |Innodb write count |Count/Second | ResourceID,Node|
|`CreatedTmpDiskTables` |`engine_monitor_new` |Number of temporary disk tables |Count/Second | ResourceID,Node|
|`InnodbBpDirtyPct` |`engine_monitor_new` |InnoDB Buffer Pool Dirty Page Ratio |Percent | ResourceID,Node|
|`InnodbLogWrites` |`engine_monitor_new` |Innodb average number of physical writes to Redo Log File per second |Count/Second | ResourceID,Node|
|`InnodbRowLockTimeMax` |`engine_monitor_new` |InnoDB table maximum waiting time for row locks |Millisecond | ResourceID,Node|
|`InnodbOsLogFsyncs` |`engine_monitor_new` |The average number of fsync writes completed to the log file per second |Count/Second | ResourceID,Node|
|`InnodbBufferPoolPagesFlushed` |`engine_monitor_new` |InnoDB Buffer Pool Page flush request number |Count/Second | ResourceID,Node|
|`RedologSize` |`engine_monitor_new` |`Redolog` usage |Bytes(IEC) | ResourceID,Node|
|`InnodbDataFsyncs` |`engine_monitor_new` |InnoDB average number of fsync operations per second |Count/Second | ResourceID,Node|
|`SlowLogSize` |`engine_monitor_new` |Slow log usage |Bytes(IEC) | ResourceID,Node|
|`SWC` |`engine_monitor_new` |MySQL requests per second |Count/Second | ResourceID,Node|
|`TPS` |`engine_monitor_new` |Transactions per second |Count/Second | ResourceID,Node|
|`InsertSelect` |`engine_monitor_new` |Average number of insert select executions per second |Count/Second | ResourceID,Node|
|`OpenFiles` |`engine_monitor_new` |Number of open files |Count | ResourceID,Node|
|`ConNuSage` |`engine_monitor_new` |MySQL connection utilization |Percent | ResourceID,Node|
|`CpuUtil` |`resource_monitor_new` |CPU usage |Percent | ResourceID,Node|
|`MemUtil` |`resource_monitor_new` |Memory usage |Percent | ResourceID,Node|
|`DiskUtil` |`resource_monitor_new` |Disk Utilization |Percent | ResourceID,Node|
|`NetworkReceiveThroughput` |`resource_monitor_new` |Network input traffic |Bytes/Second(SI) | ResourceID,Node|
|`NetworkTransmitThroughput` |`resource_monitor_new` |Network output traffic |Bytes/Second(SI) | ResourceID,Node|
|`IOPS` |`resource_monitor_new` |IOPS |Count/Second | ResourceID,Node|
|`DiskUsageBytes` |`resource_monitor_new` |Disk usage |Bytes(SI) | ResourceID,Node|



## Object  {#object}
The collected `Volcengine` Cloud **MySQL** object data structure can see the object data from 「Infrastructure-Custom」

``` json
  {
    "category": "custom_object",
    "fields": {
      "NodeSpec": "rds.mysql.d1.n.1c1g",
      "TimeZone": "UTC +08:00",
      ...
    },
    "measurement": "volcengine_mysql",
    "tags": {
      "AllowListVersion": "initial",
      "DBEngineVersion": "MySQL_5_7",
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

