---
title: 'Volcengine MySQL'
tags: 
  - Volcengine
summary: 'Volcengine MySQL Metrics Display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc.'
__int_icon: 'icon/volcengine_mysql'
dashboard:
  - desc: 'Volcengine MySQL View'
    path: 'dashboard/en/volcengine_mysql/'
---

<!-- markdownlint-disable MD025 -->
# Volcengine MySQL
<!-- markdownlint-enable -->


Volcengine MySQL Metrics Display, including CPU usage, memory usage, IOPS, network bandwidth, InnoDB, TPS, QPS, etc.

## Configuration {#config}

### Install Func

It is recommended to enable Guance Integration - Expansion - DataFlux Func (Automata): All prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Please prepare a qualified Volcengine AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data for cloud resources of MySQL, we install the corresponding collection script: "Guance Integration (Volcengine-MySQL Collection)" (ID: `guance_volcengine_mysql`)

After clicking 【Install】, input the corresponding parameters: Volcengine AK, Volcengine account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set, and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately run once without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.

> If you want to collect corresponding logs, you also need to enable the corresponding log collection script. If you want to collect billing information, you need to enable the cloud billing collection script.


We default collect some configurations, for details see the metrics section

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-volcengine-monitor/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configuration, and at the same time, check the corresponding task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}

After configuring Volcengine-MySQL, the default metric set is as follows, more metrics can be collected through configuration [Volcengine Cloud Monitoring Metric Details](https://console.volcengine.com/cloud_monitor/metricDoc?tabKey=metric&namespace=VCM_MySQL){:target="_blank"}

|`MetricName` |`Subnamespace` |Metric Name |MetricUnit | Dimension|
| ---- |-------------------------------------| :----: |:----: |:----: |
|`ReplicationDelay` |`deploy_monitor_new` |Replica Replication Delay |Second | ResourceID,Node|
|`SlowQueries` |`engine_monitor_new` |Slow Query Count |Count/Second | ResourceID,Node|
|`ThreadsConnected` |`engine_monitor_new` |Current Open Connections |Count | ResourceID,Node|
|`ThreadsCreated` |`engine_monitor_new` |Threads Created |Count | ResourceID,Node|
|`ThreadsRunning` |`engine_monitor_new` |Running Threads |Count | ResourceID,Node|
|`SelectScan` |`engine_monitor_new` |Full Table Scans |Count/Second | ResourceID,Node|
|`OperationUpdate` |`engine_monitor_new` |Updates |Count/Second | ResourceID,Node|
|`OperationDelete` |`engine_monitor_new` |Deletes |Count/Second | ResourceID,Node|
|`OperationInsert` |`engine_monitor_new` |Inserts |Count/Second | ResourceID,Node|
|`OperationReplace` |`engine_monitor_new` |Replaces |Count/Second | ResourceID,Node|
|`OperationCommit` |`engine_monitor_new` |Commits |Count/Second | ResourceID,Node|
|`OperationRollback` |`engine_monitor_new` |Rollbacks |Count/Second | ResourceID,Node|
|`CreatedTmpTables` |`engine_monitor_new` |Temporary Tables |Count/Second | ResourceID,Node|
|`TableLocksWaited` |`engine_monitor_new` |Table Lock Waits |Count/Second | ResourceID,Node|
|`OpenedTables` |`engine_monitor_new` |Opened Tables |Count | ResourceID,Node|
|`InnodbCacheHitRate` |`engine_monitor_new` |Innodb Cache Hit Rate |Percent | ResourceID,Node|
|`InnodbCacheUtil` |`engine_monitor_new` |Innodb Cache Utilization |Percent | ResourceID,Node|
|`InnodbNumOpenFiles` |`engine_monitor_new` |Innodb Open Files |Count | ResourceID,Node|
|`InnodbDataRead` |`engine_monitor_new` |Innodb Data Read |Bytes/Second(SI) | ResourceID,Node|
|`InnodbDataWritten` |`engine_monitor_new` |Innodb Data Written |Bytes/Second(SI) | ResourceID,Node|
|`InnodbRowsDeleted` |`engine_monitor_new` |Innodb Rows Deleted |Count/Second | ResourceID,Node|
|`InnodbRowsUpdated` |`engine_monitor_new` |Innodb Rows Updated |Count/Second | ResourceID,Node|
|`InnodbRowsInserted` |`engine_monitor_new` |Innodb Rows Inserted |Count/Second | ResourceID,Node|
|`InnodbDataReadBytes` |`engine_monitor_new` |Innodb Data Read Bytes |Count/Second | ResourceID,Node|
|`InnodbRowsLockTimeAvg` |`engine_monitor_new` |Innodb Avg Row Lock Time |Millisecond | ResourceID,Node|
|`InnodbRowLockWaits` |`engine_monitor_new` |Innodb Row Lock Waits |Count/Second | ResourceID,Node|
|`CreatedTmpFiles` |`engine_monitor_new` |Temporary Files |Count/Second | ResourceID,Node|
|`HandlerReadRndNext` |`engine_monitor_new` |Read Next Row Requests |Count/Second | ResourceID,Node|
|`HandlerRollback` |`engine_monitor_new` |Internal Rollbacks |Count/Second | ResourceID,Node|
|`HandlerCommit` |`engine_monitor_new` |Internal Commits |Count/Second | ResourceID,Node|
|`InnodbBufferPoolPagesFree` |`engine_monitor_new` |Innodb Free Pages |Count | ResourceID,Node|
|`TotalInnodbBufferPoolPages` |`engine_monitor_new` |Innodb Total Pages |Count | ResourceID,Node|
|`InnodbBufferPoolReadRequests` |`engine_monitor_new` |Innodb Logical Reads |Count/Second | ResourceID,Node|
|`InnodbBufferPoolReads` |`engine_monitor_new` |Innodb Physical Reads |Count/Second | ResourceID,Node|
|`InnodbDataReadCounts` |`engine_monitor_new` |Innodb Read Counts |Count/Second | ResourceID,Node|
|`InnodbDataWriteCounts` |`engine_monitor_new` |Innodb Write Counts |Count/Second | ResourceID,Node|
|`CreatedTmpDiskTables` |`engine_monitor_new` |Disk Temporary Tables |Count/Second | ResourceID,Node|
|`InnodbBpDirtyPct` |`engine_monitor_new` |InnoDB Buffer Pool Dirty Page Ratio |Percent | ResourceID,Node|
|`InnodbLogWrites` |`engine_monitor_new` |Innodb Physical Writes to Redo Log File Per Second |Count/Second | ResourceID,Node|
|`InnodbRowLockTimeMax` |`engine_monitor_new` |InnoDB Max Wait Time for Row Locks |Millisecond | ResourceID,Node|
|`InnodbOsLogFsyncs` |`engine_monitor_new` |fsync Writes to Log File Per Second |Count/Second | ResourceID,Node|
|`InnodbBufferPoolPagesFlushed` |`engine_monitor_new` |InnoDB Buffer Pool Flush Requests Per Second |Count/Second | ResourceID,Node|
|`RedologSize` |`engine_monitor_new` |`Redolog` Usage |Bytes(IEC) | ResourceID,Node|
|`InnodbDataFsyncs` |`engine_monitor_new` |fsync Operations Per Second |Count/Second | ResourceID,Node|
|`SlowLogSize` |`engine_monitor_new` |Slow Log Usage |Bytes(IEC) | ResourceID,Node|
|`QPS` |`engine_monitor_new` |Queries Per Second |Count/Second | ResourceID,Node|
|`TPS` |`engine_monitor_new` |Transactions Per Second |Count/Second | ResourceID,Node|
|`InsertSelect` |`engine_monitor_new` |Insert Select Executions Per Second |Count/Second | ResourceID,Node|
|`OpenFiles` |`engine_monitor_new` |Open Files |Count | ResourceID,Node|
|`ConnUsage` |`engine_monitor_new` |MySQL Connection Utilization |Percent | ResourceID,Node|
|`CpuUtil` |`resource_monitor_new` |CPU Utilization |Percent | ResourceID,Node|
|`MemUtil` |`resource_monitor_new` |Memory Utilization |Percent | ResourceID,Node|
|`DiskUtil` |`resource_monitor_new` |Disk Utilization |Percent | ResourceID,Node|
|`NetworkReceiveThroughput` |`resource_monitor_new` |Network Input Throughput |Bytes/Second(SI) | ResourceID,Node|
|`NetworkTransmitThroughput` |`resource_monitor_new` |Network Output Throughput |Bytes/Second(SI) | ResourceID,Node|
|`IOPS` |`resource_monitor_new` |IOPS |Count/Second | ResourceID,Node|
|`DiskUsageBytes` |`resource_monitor_new` |Disk Usage |Bytes(SI) | ResourceID,Node|



## Objects {#object}

Collected Volcengine MySQL object data structure, which can be viewed in "Infrastructure - Custom" objects data

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