---
title: '火山引擎 MySQL'
tags: 
  - 火山引擎
summary: '火山引擎 MySQL 指标展示，包括 CPU 使用率、内存使用率、 IOPS、网络带宽、 InnoDB、 TPS、 QPS 等。'
__int_icon: 'icon/volcengine_mysql'
dashboard:
  - desc: '火山引擎 MySQL 视图'
    path: 'dashboard/zh/volcengine_mysql/'
---

<!-- markdownlint-disable MD025 -->
# 火山引擎 MySQL
<!-- markdownlint-enable -->


火山引擎 MySQL 指标展示，包括 CPU 使用率、内存使用率、 IOPS、网络带宽、 InnoDB、 TPS、 QPS 等。

## 配置 {#config}

### 安装 Func

推荐开通 {{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的火山引擎 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 MySQL 云资源的监控数据，我们安装对应的采集脚本：「{{{ custom_key.brand_name }}}集成（火山引擎-MySQL采集）」(ID：`guance_volcengine_mysql`)

点击【安装】后，输入相应的参数：火山引擎 AK、火山引擎账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

> 如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。


我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-volcengine-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在{{{ custom_key.brand_name }}}平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在{{{ custom_key.brand_name }}}平台，「指标」查看是否有对应监控数据

## 指标 {#metric}

配置好火山引擎-MySQL,默认的指标集如下, 可以通过配置的方式采集更多的指标 [火山引擎云监控指标详情](https://console.volcengine.com/cloud_monitor/metricDoc?tabKey=metric&namespace=VCM_MySQL){:target="_blank"}

|`MetricName` |`Subnamespace` |指标中文名称 |MetricUnit | Dimension|
| ---- |-------------------------------------| :----: |:----: |:----: |
|`ReplicationDelay` |`deploy_monitor_new` |从库复制延迟 |Second | ResourceID,Node|
|`SlowQueries` |`engine_monitor_new` |慢查询数 |Count/Second | ResourceID,Node|
|`ThreadsConnected` |`engine_monitor_new` |当前打开连接数 |Count | ResourceID,Node|
|`ThreadsCreated` |`engine_monitor_new` |已创建线程数 |Count | ResourceID,Node|
|`ThreadsRunning` |`engine_monitor_new` |运行线程数 |Count | ResourceID,Node|
|`SelectScan` |`engine_monitor_new` |全表扫描数 |Count/Second | ResourceID,Node|
|`OperationUpdate` |`engine_monitor_new` |更新数 |Count/Second | ResourceID,Node|
|`OperationDelete` |`engine_monitor_new` |删除数 |Count/Second | ResourceID,Node|
|`OperationInsert` |`engine_monitor_new` |插入数 |Count/Second | ResourceID,Node|
|`OperationReplace` |`engine_monitor_new` |覆盖数 |Count/Second | ResourceID,Node|
|`OperationCommit` |`engine_monitor_new` |提交数 |Count/Second | ResourceID,Node|
|`OperationRollback` |`engine_monitor_new` |回滚数 |Count/Second | ResourceID,Node|
|`CreatedTmpTables` |`engine_monitor_new` |临时表数量 |Count/Second | ResourceID,Node|
|`TableLocksWaited` |`engine_monitor_new` |等待表锁次数 |Count/Second | ResourceID,Node|
|`OpenedTables` |`engine_monitor_new` |打开表个数 |Count | ResourceID,Node|
|`InnodbCacheHitRate` |`engine_monitor_new` |Innodb缓存命中率 |Percent | ResourceID,Node|
|`InnodbCacheUtil` |`engine_monitor_new` |Innodb缓存使用率 |Percent | ResourceID,Node|
|`InnodbNumOpenFiles` |`engine_monitor_new` |Innodb当前打开表数量 |Count | ResourceID,Node|
|`InnodbDataRead` |`engine_monitor_new` |Innodb读取量 |Bytes/Second(SI) | ResourceID,Node|
|`InnodbDataWritten` |`engine_monitor_new` |Innodb写入量 |Bytes/Second(SI) | ResourceID,Node|
|`InnodbRowsDeleted` |`engine_monitor_new` |Innodb行删除量 |Count/Second | ResourceID,Node|
|`InnodbRowsUpdated` |`engine_monitor_new` |Innodb行更新量 |Count/Second | ResourceID,Node|
|`InnodbRowsInserted` |`engine_monitor_new` |Innodb行插入量 |Count/Second | ResourceID,Node|
|`InnodbDataReadBytes` |`engine_monitor_new` |Innodb行读取量 |Count/Second | ResourceID,Node|
|`InnodbRowsLockTimeAvg` |`engine_monitor_new` |Innodb平均获取行锁等待时间 |Millisecond | ResourceID,Node|
|`InnodbRowLockWaits` |`engine_monitor_new` |Innodb等待行锁次数 |Count/Second | ResourceID,Node|
|`CreatedTmpFiles` |`engine_monitor_new` |临时文件数量 |Count/Second | ResourceID,Node|
|`HandlerReadRndNext` |`engine_monitor_new` |读下一行请求数 |Count/Second | ResourceID,Node|
|`HandlerRollback` |`engine_monitor_new` |内部回滚数 |Count/Second | ResourceID,Node|
|`HandlerCommit` |`engine_monitor_new` |内部提交数 |Count/Second | ResourceID,Node|
|`InnodbBufferPoolPagesFree` |`engine_monitor_new` |Innodb空页数 |Count | ResourceID,Node|
|`TotalInnodbBufferPoolPages` |`engine_monitor_new` |Innodb总页数 |Count | ResourceID,Node|
|`InnodbBufferPoolReadRequests` |`engine_monitor_new` |Innodb逻辑读 |Count/Second | ResourceID,Node|
|`InnodbBufferPoolReads` |`engine_monitor_new` |Innodb物理读 |Count/Second | ResourceID,Node|
|`InnodbDataReadCounts` |`engine_monitor_new` |Innodb读取次数 |Count/Second | ResourceID,Node|
|`InnodbDataWriteCounts` |`engine_monitor_new` |Innodb写入次数 |Count/Second | ResourceID,Node|
|`CreatedTmpDiskTables` |`engine_monitor_new` |磁盘临时表数量 |Count/Second | ResourceID,Node|
|`InnodbBpDirtyPct` |`engine_monitor_new` |InnoDB Buffer Pool 脏页比率 |Percent | ResourceID,Node|
|`InnodbLogWrites` |`engine_monitor_new` |Innodb平均每秒物理写Redo Log File次数 |Count/Second | ResourceID,Node|
|`InnodbRowLockTimeMax` |`engine_monitor_new` |InnoDB 表最大等待row locks时间 |Millisecond | ResourceID,Node|
|`InnodbOsLogFsyncs` |`engine_monitor_new` |平均每秒向日志文件完成的fsync写数量 |Count/Second | ResourceID,Node|
|`InnodbBufferPoolPagesFlushed` |`engine_monitor_new` |InnoDB Buffer Pool 刷Page请求数量 |Count/Second | ResourceID,Node|
|`RedologSize` |`engine_monitor_new` |`Redolog`使用量 |Bytes(IEC) | ResourceID,Node|
|`InnodbDataFsyncs` |`engine_monitor_new` |InnoDB 平均每秒fsync操作次数 |Count/Second | ResourceID,Node|
|`SlowLogSize` |`engine_monitor_new` |慢日志使用量 |Bytes(IEC) | ResourceID,Node|
|`QPS` |`engine_monitor_new` |MySQL 每秒请求数 |Count/Second | ResourceID,Node|
|`TPS` |`engine_monitor_new` |每秒事务数 |Count/Second | ResourceID,Node|
|`InsertSelect` |`engine_monitor_new` |平均每秒insert select执行次数 |Count/Second | ResourceID,Node|
|`OpenFiles` |`engine_monitor_new` |打开文件个数 |Count | ResourceID,Node|
|`ConnUsage` |`engine_monitor_new` |MySQL连接数利用率 |Percent | ResourceID,Node|
|`CpuUtil` |`resource_monitor_new` |CPU使用率 |Percent | ResourceID,Node|
|`MemUtil` |`resource_monitor_new` |内存使用率 |Percent | ResourceID,Node|
|`DiskUtil` |`resource_monitor_new` |磁盘利用率 |Percent | ResourceID,Node|
|`NetworkReceiveThroughput` |`resource_monitor_new` |网络输入流量 |Bytes/Second(SI) | ResourceID,Node|
|`NetworkTransmitThroughput` |`resource_monitor_new` |网络输出流量 |Bytes/Second(SI) | ResourceID,Node|
|`IOPS` |`resource_monitor_new` |IOPS |Count/Second | ResourceID,Node|
|`DiskUsageBytes` |`resource_monitor_new` |磁盘使用量 |Bytes(SI) | ResourceID,Node|




## 对象 {#object}

采集到的火山引擎 MySQL 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

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
