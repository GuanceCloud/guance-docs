---
title: 'AWS Neptune Cluster'
summary: 'Use the「观测云云同步」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud'
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

The display metrics for the AWS Neptune Cluster include cold start time, execution time, number of concurrent executions, and memory usage, which reflect the responsiveness, scalability, and resource utilization of the Neptune Cluster functions.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install

> Tip：Please prepare AWS AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of Neptune Cluster cloud resources, we install the corresponding collection script：「观测云集成（AWS-Neptune Cluster采集）」(ID：`guance_aws_neptune_cluster`)

Click 【Install】 and enter the corresponding parameters: AWS AK, AWS account name.

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

After configuring Amazon CloudWatch - cloud monitoring, the default set of metrics is as follows. You can collect more metrics by configuring [Amazon Neptune Cluster Metrics Details](https://docs.aws.amazon.com/zh_cn/neptune/latest/userguide/cw-metrics.html){:target="_blank"}

### Metric

| Metric                                              | Describe                                                         |
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


## Object {#object}

The collected AWS Neptune Cluster object data structure can be viewed in "Infrastructure - Custom" under the object data.

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
