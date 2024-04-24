---
title: '火山引擎 MongoDB 分片集'
tags: 
  - 火山引擎
summary: '火山引擎 MongoDB 分片集指标展示，包括 CPU 使用率、内存使用率、 连接数、延迟、OPS等。'
__int_icon: 'icon/volcengine_mongodb'
dashboard:
  - desc: '火山引擎 MongoDB'
    path: 'dashboard/zh/volcengine_mongodb_sharded_cluster/'
---

<!-- markdownlint-disable MD025 -->
# 火山引擎 MongoDB 分片集
<!-- markdownlint-enable -->


火山引擎 MongoDB 分片集指标展示，包括 CPU 使用率、内存使用率、 连接数、延迟、OPS等。。

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的火山引擎 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 MongoDB 云资源的监控数据，我们安装对应的采集脚本：「观测云集成（火山引擎-MongoDB采集）」(ID：`guance_volcengine_mongodb_sharded_cluster`)

点击【安装】后，输入相应的参数：火山引擎 AK、火山引擎账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

> 如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。


我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-volcengine-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好火山引擎-MongoDB 分片集监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [火山引擎 MongoDB 监控指标详情](https://console.volcengine.com/cloud_monitor/metricDoc?tabKey=metric&namespace=VCM_MongoDB_Sharded_Cluster){:target="_blank"}

> 注意：需要在 `volcengine` MongoDB 控制台安装监控插件

| Metric | Description                          | Unit |
| ---- |-------------------------------------| :----: |
|`CpuUtil` |CPU使用率|Percent|
|`MemUtil` |内存使用率|Percent|
|`TotalDiskUtil` | 磁盘使用率 |Percent|
|`CurrConn` | 当前连接数 |Count|
|`DataDiskUsage`|数据磁盘使用量|Bytes(SI)|
|`ReplicationDelay`|主备延时| Second |
|`GetmoreOperationPerSec`| 每秒 `GETMORE` 操作数 | Count/Second |
|`QueryOperationPerSec`|每秒 QUERY 操作数| Count/Second |
|`DeleteOperationPerSec`| 每秒 DELETE 操作数 | Count/Second |
|`InsertOperationPerSec`| 每秒 INSERT 操作数 | Count/Second|
|`UpdateOperationPerSec`| 每秒 UPDATE 操作数 | Count/Second|
|`CommandOperationPerSec`| 每秒 COMMAND 操作数 | Count/Second|



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

