---
title: '阿里云 MongoDB'
tags: 
  - 阿里云
summary: '阿里云 MongoDB 副本集指标展示，包括 CPU 使用率、内存使用率、磁盘使用率、数据占用磁盘空间量、日志占用磁盘空间、每秒语句执行次数、请求数、连接数、网络流量、复制延迟、QPS 等。

阿里云 MongoDB 分片集群指标展示，包括 CPU 使用率、内存使用率、磁盘使用率、数据占用磁盘空间量、日志占用磁盘空间、每秒语句执行次数、请求数、连接数、网络流量、复制延迟、QPS 等。

阿里云 MongoDB 单节点实例指标展示，包括 CPU 使用率、内存使用率、磁盘使用率、数据占用磁盘空间量、每秒语句执行次数、请求数、连接数、网络流量、QPS 等。'
__int_icon: 'icon/aliyun_mongodb'

dashboard:
  - desc: '阿里云 MongoDB 副本集内置视图'
    path: 'dashboard/zh/aliyun_mongodb_replicaset/'
  - desc: '阿里云 MongoDB 分片集群内置视图'
    path: 'dashboard/zh/aliyun_mongodb_sharding/'
  - desc: '阿里云 MongoDB 单节点实例内置视图'
    path: 'dashboard/zh/aliyun_mongodb_singlenode/'

monitor:
  - desc: '阿里云 MongoDB 副本集监控器'
    path: 'monitor/zh/aliyun_mongodb_replicaset/'
  - desc: '阿里云 MongoDB 分片集群监控器'
    path: 'monitor/zh/aliyun_mongodb_sharding/'
  - desc: '阿里云 MongoDB 单节点实例监控器'
    path: 'monitor/zh/aliyun_mongodb_singlenode/'
---

<!-- markdownlint-disable MD025 -->

# 阿里云
<!-- markdownlint-enable -->


阿里云 MongoDB 副本集指标展示，包括 CPU 使用率、内存使用率、磁盘使用率、数据占用磁盘空间量、日志占用磁盘空间、每秒语句执行次数、请求数、连接数、网络流量、复制延迟、QPS 等。

阿里云 MongoDB 分片集群指标展示，包括 CPU 使用率、内存使用率、磁盘使用率、数据占用磁盘空间量、日志占用磁盘空间、每秒语句执行次数、请求数、连接数、网络流量、复制延迟、QPS 等。

阿里云 MongoDB 单节点实例指标展示，包括 CPU 使用率、内存使用率、磁盘使用率、数据占用磁盘空间量、每秒语句执行次数、请求数、连接数、网络流量、QPS 等。

## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装


如果自行部署 Func 参考 [自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}


> 推荐部署GSE版

### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 ECS 云资源的监控数据，我们安装对应的采集脚本：「<<< custom_key.brand_name >>>集成（阿里云-MongoDB 副本集采集）」(ID：`guance_aliyun_mongodb`)

点击【安装】后，输入相应的参数：阿里云 AK、阿里云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

> 如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。



我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好阿里云-云监控，默认采集指标如下，可以通过配置的方式采集更多的指标。
更多指标请参考：[阿里云云监控指标详情](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

### 云数据库 MongoDB 版 - 副本集

<!-- markdownlint-disable MD025 -->
| Metric Id                  |   MetricCategory   | Metric Name            | Dimensions             | Statistics                       | Unit      | Min Periods |
| ---- | :----: | ------ | ------ | ---- | ---- | ---- |
| `CPUUtilization`           | `mongodb_replicaset` | CPU使用率              | userId,instanceId,role | Average,Minimum,Maximum          | %         | 60 s        |
| `ConnectionAmount`         | `mongodb_replicaset` | 连接数使用量           | userId,instanceId,role | Average,Minimum,Maximum          | Count     | 60 s        |
| `ConnectionUtilization`    | `mongodb_replicaset` | 连接数使用率           | userId,instanceId,role | Average,Minimum,Maximum          | %         | 60 s        |
| `DataDiskAmount`           | `mongodb_replicaset` | 数据占用磁盘空间量     | userId,instanceId,role | Average,Minimum,Maximum          | bytes     | 60 s        |
| `DiskUtilization`          | `mongodb_replicaset` | 磁盘使用率             | userId,instanceId,role | Average,Minimum,Maximum          | %         | 60 s        |
| `IOPSUtilization`          | `mongodb_replicaset` | IOPS使用率             | userId,instanceId,role | Average,Minimum,Maximum          | %         | 60 s        |
| `InstanceDiskAmount`       | `mongodb_replicaset` | 实例占用磁盘空间量     | userId,instanceId,role | Average,Minimum,Maximum          | bytes     | 60 s        |
| `IntranetIn`               | `mongodb_replicaset` | 网络入流量             | userId,instanceId,role | Average,Minimum,Maximum          | bytes     | 60 s        |
| `IntranetOut`              | `mongodb_replicaset` | 网络出流量             | userId,instanceId,role | Average,Minimum,Maximum          | bytes     | 60 s        |
| `LogDiskAmount`            | `mongodb_replicaset` | 日志占用磁盘空间量     | userId,instanceId,role | Average,Minimum,Maximum          | bytes     | 60 s        |
| `MemoryUtilization`        | `mongodb_replicaset` | 内存使用率             | userId,instanceId,role | Average,Minimum,Maximum          | %         | 60 s        |
| `NumberRequests`           | `mongodb_replicaset` | 请求数                 | userId,instanceId,role | Average,Minimum,Maximum          | Count     | 60 s        |
| `OpCommand`                | `mongodb_replicaset` | Command操作次数        | userId,instanceId,role | Average,Minimum,Maximum          | Frequency | 60 s        |
| `OpDelete`                 | `mongodb_replicaset` | Delete操作次数         | userId,instanceId,role | Average,Minimum,Maximum          | Frequency | 60 s        |
| `OpGetmore`                | `mongodb_replicaset` | **Getmore**操作次数    | userId,instanceId,role | Average,Minimum,Maximum          | Frequency | 60 s        |
| `OpInsert`                 | `mongodb_replicaset` | Insert操作次数         | userId,instanceId,role | Average,Minimum,Maximum          | Count     | 60 s        |
| `OpQuery`                  | `mongodb_replicaset` | Query操作次数          | userId,instanceId,role | Average,Minimum,Maximum          | Frequency | 60 s        |
| `OpUpdate`                 | `mongodb_replicaset` | Update操作次数         | userId,instanceId,role | Average,Minimum,Maximum          | Frequency | 60 s        |
| `QPS`                      | `mongodb_replicaset` | 平均每秒SQL查询数      | userId,instanceId,role | Average,Minimum,Maximum          | Count     | 60 s        |
| `ReplicationLag`           | `mongodb_replicaset` | 复制延迟               | userId,instanceId,role | Average,Maximum,Minimum,cms_null | seconds   | 60 s        |

<!-- markdownlint-enable -->

### 云数据库 MongoDB 版-分片集群

<!-- markdownlint-disable MD025 -->

| Metric Id                          |  MetricCategory   | Metric Name                    | Dimensions                             | Statistics                 | Unit      | Min Periods |
|------------------------------------|:-----------------:|--------------------------------|----------------------------------------|----------------------------|-----------| ---- |
| `ShardingCPUUtilization`           | `mongodb_sharding` | CPU使用率                         | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | %         | 60 s        |
| `ShardingConnectionAmount`         | `mongodb_sharding` | 连接数使用量                         | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Count     | 60 s        |
| `ShardingConnectionUtilization`    | `mongodb_sharding` | 连接数使用率                         | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | %         | 60 s        |
| `ShardingDataDiskAmount`           | `mongodb_sharding` | 数据占用磁盘空间量                      | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Bytes     | 60 s        |
| `ShardingDataDiskAmountOriginal`   | `mongodb_sharding` | ShardingDataDiskAmountOriginal | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | -         | 60 s        |
| `ShardingDiskUtilization`          | `mongodb_sharding` | 磁盘使用率                          | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | %         | 60 s        |
| `ShardingIOPSUtilization`          | `mongodb_sharding` | IOPS使用率                        | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | %     | 60 s        |
| `ShardingInstanceDiskAmount`       | `mongodb_sharding` | 占用磁盘空间量                        | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Bytes     | 60 s        |
| `ShardingIntranetIn`               | `mongodb_sharding` | 网络入流量                          | `userId,instanceId,subinstanceId,role` | Average                    | Bytes     | 60 s        |
| `ShardingIntranetOut`              | `mongodb_sharding` | 网络出流量                          | `userId,instanceId,subinstanceId,role` | Average                    | Bytes     | 60 s        |
| `ShardingLogDiskAmount`            | `mongodb_sharding` | 日志占用的磁盘空间容量                    | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Bytes         | 60 s        |
| `ShardingMemoryUtilization`        | `mongodb_sharding` | 内存使用率                          | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | %     | 60 s        |
| `ShardingNumberRequests`           | `mongodb_sharding` | 请求数                            | `userId,instanceId,subinstanceId,role` | Average                    | Count | 60 s        |
| `ShardingOpCommand`                | `mongodb_sharding` | Command操作次数                    | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Count | 60 s        |
| `ShardingOpDelete`                 | `mongodb_sharding` | Delete操作次数                     | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Count | 60 s        |
| `ShardingOpGetmore`                | `mongodb_sharding` | **Getmore**操作次数                | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Count     | 60 s        |
| `ShardingOpInsert`                 | `mongodb_sharding` | Insert操作次数                     | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Count | 60 s        |
| `ShardingOpQuery`                  | `mongodb_sharding` | Query操作次数                      | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Count | 60 s        |

<!-- markdownlint-enable -->

### 云数据库 MongoDB 版-单节点实例

<!-- markdownlint-disable MD025 -->

| Metric Id                       |   MetricCategory   | Metric Name | Dimensions        | Statistics                 | Unit  | Min Periods |
|---------------------------------|:------------------:|-----------| ------ |----------------------------|-------| ---- |
| `SingleNodeCPUUtilization`      | `mongodb_singlenode` | CPU使用率    | userId,instanceId | Average,Minimum,Maximum    | %     | 60 s        |
| `SingleNodeConnectionAmount`    | `mongodb_singlenode` | 连接数使用量    | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| `SingleNodeConnectionUtilization` | `mongodb_singlenode` | 连接数使用率    | userId,instanceId | Average,Minimum,Maximum    | %     | 60 s        |
| `SingleNodeDataDiskAmount`      | `mongodb_singlenode` | 数据占用磁盘空间量 | userId,instanceId | Average,Minimum,Maximum    | bytes | 60 s        |
| `SingleNodeDiskUtilization`     | `mongodb_singlenode` | 磁盘使用率     | userId,instanceId | Average,Minimum,Maximum    | %     | 60 s        |
| `SingleNodeIntranetIn`          | `mongodb_singlenode` | 网络入流量     | userId,instanceId | Average,Minimum,Maximum    | bytes | 60 s        |
| `SingleNodeIntranetOut`         | `mongodb_singlenode` | 网络出流量     | userId,instanceId | Average,Minimum,Maximum    | bytes | 60 s        |
| `SingleNodeMemoryUtilization`   | `mongodb_singlenode` | 内存使用率     | userId,instanceId | Average,Minimum,Maximum    | %     | 60 s        |
| `SingleNodeNumberRequests`      | `mongodb_singlenode` | 请求数       | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| `SingleNodeOpCommand`           | `mongodb_singlenode` | Command操作次数 | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| `SingleNodeOpDelete`            | `mongodb_singlenode` | Delete操作次数 | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| `SingleNodeOpGetmore`           | `mongodb_singlenode` | **Getmore**操作次数 | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| `SingleNodeOpInsert`            | `mongodb_singlenode` | Insert操作次数 | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| `SingleNodeOpQuery`             | `mongodb_singlenode` | Query操作次数 | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| `SingleNodeOpUpdate`            | `mongodb_singlenode` | Update操作次数 | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| `SingleNodeQPS`                 | `mongodb_singlenode` | QPS       | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |

<!-- markdownlint-enable -->

## 对象 {#object}

采集到的阿里云 MongoDB 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aliyun_mongodb",
  "tags": {
    "name"                 : "dds-bpxxxxxxxx",
    "DBInstanceType"       : "replicate",
    "ChargeType"           : "PrePaid",
    "Engine"               : "MongoDB",
    "DBInstanceClass"      : "dds.xxxxxxxx",
    "DBInstanceId"         : "dds-bpxxxxxxx",
    "ZoneId"               : "cn-hangzhou",
    "RegionId"             : "cn-hangzhou-h",
    "VPCId"                : "vpc-bpxxxxxxxx",
    "EngineVersion"        : "4.2",
    "CurrentKernelVersion" : "mongodb_20210204_4.0.14",
    "StorageEngine"        : "WiredTiger",
    "DBInstanceDescription": "业务系统",
    "LockMode"             : "Unlock",
  },
  "fields": {
    "ExpireTime"       : "2020-11-18T08:47:11Z",
    "DBInstanceStorage": "20",
    "ReplicaSets"      : "{连接地址 JSON 数据}",
    "message"          : "{实例 JSON 数据}",
  }
}

```

## 日志 {#logging}

### 慢查询日志

#### 前提条件

> 提示：本脚本的代码运行依赖 mongodb 实例对象采集，如果未配置 mongodb 的自定义对象采集，慢日志脚本无法采集到慢日志数据

#### 安装慢查询采集脚本

在之前的基础上，需要再安装一个对应 **MongoDB 慢查询采集的脚本**

在「脚本市场 - 官方脚本市场」中，进入「详情」， 点击安装对应的脚本包：

- 「<<< custom_key.brand_name >>>集成（阿里云-MongoDB慢查询日志采集）」(ID：`guance_aliyun_mongodb`)

数据正常同步后，可以在<<< custom_key.brand_name >>>的「日志」中查看数据。

上报的数据示例如下：

```json
{
  "measurement": "aliyun_mongodb_slowlog",
  "tags": {
    "name"                 : "dds-bpxxxxxxxx",
    "DBInstanceType"       : "replicate",
    "ChargeType"           : "PrePaid",
    "Engine"               : "MongoDB",
    "DBInstanceClass"      : "dds.xxxxxxxx",
    "DBInstanceId"         : "dds-bpxxxxxxx",
    "ZoneId"               : "cn-hangzhou",
    "RegionId"             : "cn-hangzhou-h",
    "VPCId"                : "vpc-bpxxxxxxxx",
    "EngineVersion"        : "4.2",
    "CurrentKernelVersion" : "mongodb_20210204_4.0.14",
    "StorageEngine"        : "WiredTiger",
    "DBInstanceDescription": "业务系统",
    "DBName"               : "local",
    "AccountName"          : "脚本开发用阿里云账号",
    "HostAddress"          : "11.xxx.xxx.xx",
    "TableName"            : "oplog",
  },
  "fields": {
    "SQLText"           : "{SQL 语句}",
    "ExecutionStartTime": "1",
    "QueryTimes"        : "1",
    "ReturnRowCounts"   : "1",
    "KeysExamined"      : "1",
    "DocsExamined"      : "1",
  }
}

```

部分参数说明如下：

<!-- markdownlint-disable MD025 -->

| 字段                 | 类型 | 说明                 |
| :------------------- | :--- | :------------------- |
| `QueryTimes`         | Int  | 执行时长，单位为毫秒 |
| `ExecutionStartTime` | Str  | 执行开始时间,UTC时间 |

<!-- markdownlint-enable -->

> *注意：`tags`、`fields` 中的字段可能会随后续更新有所变动*
>
> 提示：`fields.message` 为 JSON 序列化后字符串
