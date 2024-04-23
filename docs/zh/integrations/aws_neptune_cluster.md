---
title: 'AWS Neptune Cluster'
tags: 
  - AWS
summary: 'AWS Neptune Cluster的展示指标包括冷启动时间、执行时间、并发执行数和内存使用量，这些指标反映了Neptune Cluster函数的响应速度、可扩展性和资源利用情况。'
__int_icon: 'icon/aws_neptune_cluster'

dashboard:
  - desc: 'AWS Neptune Cluster 内置视图'
    path: 'dashboard/zh/aws_neptune_cluster'

monitor:
  - desc: 'AWS Neptune Cluster 监控器'
    path: 'monitor/zh/aws_neptune_cluster'

---


<!-- markdownlint-disable MD025 -->
# AWS Neptune Cluster
<!-- markdownlint-enable -->

AWS Neptune Cluster的展示指标包括冷启动时间、执行时间、并发执行数和内存使用量，这些指标反映了Neptune Cluster函数的响应速度、可扩展性和资源利用情况。


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### 安装脚本

> 提示：请提前准备好符合要求的亚马逊云 AK（简单起见，可直接授予CloudWatch只读权限`CloudWatchReadOnlyAccess`）

同步 ECS 云资源的监控数据，我们安装对应的采集脚本：「观测云集成（AWS-Neptune Cluster采集）」(ID：`guance_aws_lambda`)

点击【安装】后，输入相应的参数：AWS AK ID、AWS AK SECRET。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。在启动脚本中，需要注意'regions' 与 实例实际所在 regions 保持一致。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

> 如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。


我们默认采集了一些配置, 具体见指标一栏[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好亚马逊-云监控,默认的指标集如下.可以通过配置的方式采集更多的指标:

[亚马逊云监控  Neptune Cluster 指标详情](https://docs.aws.amazon.com/zh_cn/neptune/latest/userguide/cw-metrics.html){:target="_blank"}


### 指标

| 指标                                              | 描述                                                         |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `BackupRetentionPeriodStorageUsed`                           | 用于从 Neptune 数据库集群的备份保留窗口支持的备份存储总量（以字节为单位）。包含在 TotalBackupStorageBilled 指标报告的总数中。 |
| `BufferCacheHitRatio`                           | 缓冲区缓存提供的请求的百分比。此指标可用于诊断查询延迟，因为缓存失误会导致大量延迟。如果缓存命中率低于 99.9，请考虑升级实例类型以在内存中缓存更多数据。 |
| `ClusterReplicaLag`                           | 对于只读副本，从主实例中复制更新时的滞后总量 (以毫秒为单位)。 |
| `ClusterReplicaLagMaximum`                           | 数据库集群中主实例和每个 Neptune 数据库实例之间的最大延迟量，以毫秒为单位。 |
| `ClusterReplicaLagMinimum`                           | 数据库集群中主实例和每个 Neptune 数据库实例之间的最小延迟量，以毫秒为单位。 |
| `CPUUtilization`                           | CPU 使用百分率。 |
| `EngineUptime`                           | 实例运行时间长度 (以秒为单位)。 |
| `FreeableMemory`                           | 随机存取内存的可用量 (以字节为单位)。 |
| `GlobalDbDataTransferBytes`                           | 从主服务器传输的重做日志数据的字节数AWS 区域到中学AWS 区域在海王星全球数据库中。 |
| `GlobalDbReplicatedWriteIO`                           | 从主服务器复制的写入 I/O 操作的数量AWS 区域在全局数据库中存储到辅助数据库中的群集卷AWS 区域。

Neptune 全局数据库中每个数据库集群的账单计算使用VolumeWriteIOPS衡量在该集群内执行的写入操作的指标。对于主数据库集群，账单计算使用GlobalDbReplicatedWriteIO以考虑到辅助数据库集群的跨区域复制。 |
| `GlobalDbProgressLag`                           | 对于用户事务和系统事务，辅助群集落后于主群集的毫秒数。 |
| `GremlinRequestsPerSec`                           | 每秒对 Gremlin 引擎的请求数。 |
| `GremlinWebSocketOpenConnections`                           | 打开的次数WebSocket与海王星的连接。 |
| `LoaderRequestsPerSec`                           | 每秒的加载程序请求数。 |
| `MainRequestQueuePendingRequests`                           | 在输入队列中等待执行的请求数。当请求超过最大队列容量时，Neptune 会开始限制请求。 |
| `NCUUtilization`                           | 在集群层面，NCUUtilization报告整个集群使用的最大容量的百分比。 |
| `NetworkThroughput`                           | Neptune 数据库集群中每个实例从客户端接收和传输到客户端的网络吞吐量，以每秒字节数为单位。这个吞吐量确实如此不包括数据库集群中的实例与集群卷之间的网络流量。 |


## 对象 {#object}

采集到的AWS Neptune Cluster 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aws_neptune_cluster",
  "tags": {
    "DBClusterIdentifier"      :"test",
    "class"             :"aws_neptune_cluster",
    "cloud_provider"    :"aws",
    "FunctionName"      :"dataflux-alb",
    "name"              :"dataflux-alb",
    "PackageType"       :"Zip",
    "RegionId"          :"cn-northwest-1",
    "RevisionId"        :"5e52ff51-615a-4ecb-96b7-40083a7b4b62",
    "Role"              :"arn:aws-cn:iam::294654068288:role/service-role/s3--guance-role-3w34zo42",
    "Runtime"           :"python3.7",
    "Version"           :"$LATEST"
  },
  "fields": {
    "CreatedTime"         : "2022-03-09T06:13:31Z",
    "ListenerDescriptions": "{JSON 数据}",
    "AvailabilityZones"   : "{可用区 JSON 数据}",
    "message"             : "{实例 JSON 数据}"
  }
}
```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.account_name`值为实例 ID，作为唯一识别
