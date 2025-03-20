---
title: '火山引擎 MongoDB 副本集'
tags: 
  - 火山引擎
summary: '火山引擎 MongoDB 副本集指标展示，包括 CPU 使用率、内存使用率、 连接数、延迟、OPS等。'
__int_icon: 'icon/volcengine_mongodb'
dashboard:
  - desc: '火山引擎 MongoDB'
    path: 'dashboard/zh/volcengine_mongodb_replica_set/'
---

<!-- markdownlint-disable MD025 -->
# 火山引擎 MongoDB 副本集
<!-- markdownlint-enable -->


火山引擎 MongoDB 副本集指标展示，包括 CPU 使用率、内存使用率、 连接数、延迟、OPS等。。

## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的火山引擎 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 MongoDB 云资源的监控数据，我们安装对应的采集脚本：「<<< custom_key.brand_name >>>集成（火山引擎-MongoDB采集）」(ID：`guance_volcengine_mongodb_replica_set`)

点击【安装】后，输入相应的参数：火山引擎 AK、火山引擎账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

> 如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。


我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://<<< custom_key.func_domain >>>/doc/script-market-guance-volcengine-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好火山引擎-MongoDB 副本集监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [火山引擎 MongoDB 监控指标详情](https://console.volcengine.com/cloud_monitor/metric?namespace=VCM_MongoDB_Replica){:target="_blank"}

|`MetricName` |`Subnamespace` |指标中文名称 |MetricUnit | Dimension|
| ---- |-------------------------------------| :----: |:----: |:----: |
|`AggregatedCpuUtil` |`instance` |CPU使用率 |Percent | ResourceID|
|`AggregatedMemUtil` |`instance` |内存使用率 |Percent | ResourceID|
|`AggregatedTotalDiskUtil` |`instance` |磁盘总空间使用率 |Percent | ResourceID|
|`NetworkReceiveThroughput` |`replica` |网络输入速率 |Bytes/Second(SI) | ResourceID,Node|
|`RunningConcurrentWriteRequest` |`replica` |当前写并发请求数 |Count | ResourceID,Node|
|`LogDiskUsage` |`replica` |日志磁盘使用量 |Bytes(SI) | ResourceID,Node|
|`RunningConcurrentReadRequest` |`replica` |当前读并发请求数 |Count | ResourceID,Node|
|`CommandOperationPerSec` |`replica` |每秒COMMAND操作数 |Count/Second | ResourceID,Node|
|`ReplicationDelay` |`replica` |主备延时 |Second | ResourceID,Node|
|`CurrConn` |`replica` |当前连接数 |Count | ResourceID,Node|
|`TotalDiskUsage` |`replica` |磁盘总使用量 |Bytes(SI) | ResourceID,Node|
|`UpdateOperationPerSec` |`replica` |每秒UPDATE操作数 |Count/Second | ResourceID,Node|
|`MaxDiskConfigured` |`replica` |配置最大可用磁盘空间 |Bytes(SI) | ResourceID,Node|
|`TimeOutCursor` |`replica` |cursor超时数 |Count | ResourceID,Node|
|`NetworkTransmitThroughput` |`replica` |网络输出速率 |Bytes/Second(SI) | ResourceID,Node|
|`GlobalWaitReadLockQueue` |`replica` |全局读锁的等待队列长度 |Count | ResourceID,Node|
|`AvailConcurrentReadRequest` |`replica` |可用读并发请求数 |Count | ResourceID,Node|
|`DataDiskUsage` |`replica` |数据磁盘使用量 |Bytes(SI) | ResourceID,Node|
|`ReadIntoCachePerSec` |`replica` |每秒读入cache的数据量 |Bytes/Second(SI) | ResourceID,Node|
|`TotalDiskUtil` |`replica` |磁盘总使用率 |Percent | ResourceID,Node|
|`GlobalWaitWriteLockQueue` |`replica` |全局写锁的等待队列长度 |Count | ResourceID,Node|
|`TotalOpenCursor` |`replica` |cursor打开总数 |Count | ResourceID,Node|
|`GetmoreOperationPerSec` |`replica` |每秒`GETMORE`操作数 |Count/Second | ResourceID,Node|
|`MemUtil` |`replica` |内存使用率 |Percent | ResourceID,Node|
|`GlobalWaitTotalLockQueue` |`replica` |全局锁的等待队列总长度 |Count | ResourceID,Node|
|`CpuUtil` |`replica` |CPU使用率 |Percent | ResourceID,Node|
|`QueryOperationPerSec` |`replica` |每秒QUERY操作数 |Count/Second | ResourceID,Node|
|`DeleteOperationPerSec` |`replica` |每秒DELETE操作数 |Count/Second | ResourceID,Node|
|`AvailConcurrentWriteRequest` |`replica` |可用写并发请求数 |Count | ResourceID,Node|
|`InsertOperationPerSec` |`replica` |每秒INSERT操作数 |Count/Second | ResourceID,Node|
|`WrittenFromCachePerSec` |`replica` |每秒从cache写到磁盘的数据量 |Bytes/Second(SI) | ResourceID,Node|
|`NetworkRequestPerSec` |`replica` |网络处理请求数 |Count/Second | ResourceID,Node|
|`SlowOpCount` |`replica` |慢查询数统计 |Count | ResourceID,Node|
|`OplogAvailTime` |`replica` |`Oplog`可用时间 |Second | ResourceID,Node|




## 对象 {#object}

采集到的火山引擎 MongoDB 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

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

