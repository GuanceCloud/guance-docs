---
title: 'Volcengine MySQL'
tags: 
  - `Volcengine`
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

| Metric | Description                          | Unit |
| ---- |-------------------------------------| :----: |
|`CpuUtil` |CPU usage rate|Percent|
|`MemUtil` |Memory usage rate|Percent|
|`DiskUtil` | Disk usage rate |Percent|
|`IOPS` | IOPS usage rate |Percent|
|`ThreadsConnected`| Current number of open connections |Count|
|`ThreadsRunning`| Number of running threads | Count |
|`ConnUsage`|MySQL connection utilization rate|Percent|
|`NetworkReceiveThroughput`| Network inflow rate | Bytes/Second(SI) |
|`NetworkTransmitThroughput`|Network outflow rate| Bytes/Second(SI) |
|`IOPS`|IOPS|Count/Second|
|`DiskUsageBytes`| Disk usage | Bytes(SI) |
|`TPS`| Transactions per Second |Count/Second|
|`QPS`| MySQL requests per second |Count/Second|
|`OperationUpdate`| Update | Count/Second |
|`OperationDelete`| Delete | Count/Second |
|`OperationInsert`| Insert | Count/Second |
|`OperationReplace`| Replace | Count/Second|
|`OperationCommit`| Commit | Count/Second|
|`OperationRollback`| Rollback | Count/Second|
|`InnodbBufferPoolReadRequests`| Innodb logical read | Count/Second|
|`InnodbBpDirtyPct`| InnoDB Buffer Pool dirty page ratio | Percent|
|`CreatedTmpTables`| Temporary Table Quantity | Count/Second|
|`SlowQueries`| Slow queries | Count/Second|
|`InnodbDataRead`| Innodb read volume | Bytes/Second(SI)|
|`InnodbDataWritten`| Innodb write volume | Bytes/Second(SI) |
|`InnodbRowsUpdated`|Innodb Update | Count/Second |
|`InnodbRowsDeleted`|Innodb Delete| Count/Second |
|`InnodbRowsInserted`| Innodb Insert | Count/Second |
|`InnodbDataReadBytes`| Innodb row read volume | Count/Second|
|`InnodbOsLogFsyncs`| The average number of fsync writes completed to the log file per second | Count/Second|



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

