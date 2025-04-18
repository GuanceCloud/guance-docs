---
title: 'AWS DocumentDB'
tags: 
  - AWS
summary: 'AWS DocumentDB 的展示指标包括读取和写入吞吐量、查询延迟和可扩展性等。'
__int_icon: 'icon/aws_documentdb'
dashboard:

  - desc: 'AWS DocumentDB 内置视图'
    path: 'dashboard/zh/aws_documentdb'

monitor:
  - desc: 'AWS DocumentDB 监控器'
    path: 'monitor/zh/aws_documentdb'

cloudCollector:
  desc: '云采集器'
  path: 'cloud-collector/zh/aws_documentdb'
---


<!-- markdownlint-disable MD025 -->
# AWS DocumentDB
<!-- markdownlint-enable -->

AWS DocumentDB 的展示指标包括读取和写入吞吐量、查询延迟和可扩展性等。


## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考[自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

#### 托管版开通脚本

1. 登陆<<< custom_key.brand_name >>>控制台
2. 点击【管理】菜单，选择【云帐号管理】
3. 点击【添加云帐号】，选择【AWS】，填写界面所需的信息，如之前已配置过云帐号信息，则忽略此步骤
4. 点击【测试】，测试成功后点击【保存】，如果测试失败，请检查相关配置信息是否正确，并重新测试
5. 点击【云帐号管理】列表上可以看到已添加的云账号，点击相应的云帐号，进入详情页
6. 点击云帐号详情页的【集成】按钮，在`未安装`列表下，找到`AWS DocumentDB`，点击【安装】按钮，弹出安装界面安装即可。

#### 手动开通脚本

1. 登陆Func 控制台，点击【脚本市场】，进入官方脚本市场，搜索:`guance_aws_documentdb`

2. 点击【安装】后，输入相应的参数：AWS AK ID 、AK Secret 及账户名。

3. 点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

4. 开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好亚马逊-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [亚马逊云监控指标详情](https://docs.aws.amazon.com/zh_cn/documentdb/latest/developerguide/cloud_watch.html#cloud_watch-metrics_list){:target="_blank"}

| 指标                    | 描述                                                         |
| :---------------------- | :----------------------------------------------------------- |
| `CPUUtilization` | 实例占用的 CPU 百分比。 |
| `FreeableMemory` | 随机存取内存的可用量 (以字节为单位)。 |
| `FreeLocalStorage` | 此指标报告每个实例中可用于临时表和日志的存储量。此值取决于实例类。您可通过为实例选择较大的实例类来增加对实例可用的存储空间量。 |
| `SwapUsage` | 实例上使用的交换空间的大小。 |
| `DatabaseConnections` | 以一分钟为频率在实例上打开的连接数。 |
| `DatabaseConnectionsMax` | 一分钟内实例上打开的最大数据库连接数。 |
| `DatabaseCursors` | 以一分钟为频率在实例上打开的游标数量。 |
| `DatabaseCursorsMax` | 一分钟内实例上打开的最大游标数。 |
| `DatabaseCursorsTimedOut` | 一分钟内超时的游标数量。 |
| `LowMemThrottleQueueDepth` | 因占用可用内存不足而限制的请求的队列深度，频率为一分钟。 |
| `LowMemThrottleMaxQueueDepth` | 一分钟内由于可用内存不足而受限制的请求的最大队列深度。 |
| `LowMemNumOperationsThrottled` | 一分钟内由于可用内存不足而被限制的请求数。 |
| `ReadThroughput` | 每秒从磁盘读取的平均字节数。 |
| `WriteThroughput` | 每秒写入磁盘的平均字节数。 |
| `ReadIOPS` | 每秒平均磁盘读取 I/O 操作数。Amazon DocumentDB 每分钟分别报告一次读取和写入 IOPS。 |
| `NetworkThroughput` | Amazon DocumentDB 集群中每个实例从客户端接收和发送到客户端的网络吞吐量，单位为每秒的字节数。此吞吐量不包括集群中的实例与集群卷之间的网络流量。 |
| `NetworkReceiveThroughput` | 集群中每个实例从客户端接收的网络吞吐量（以每秒字节数为单位）。此吞吐量不包括集群中的实例与集群卷之间的网络流量。 |
| `NetworkTransmitThroughput` | 集群中每个实例发送到客户端的网络吞吐量（以每秒字节数为单位）。此吞吐量不包括集群中的实例与集群卷之间的网络流量。 |
| `WriteIOPS` | 每秒平均磁盘写入 I/O 操作数。在集群级别使用时`WriteIOPs`，将在集群中的所有实例上进行评估。每分钟分别报告一次读取和写入 IOPS。 |
| `ReadLatency` | 每个磁盘 I/O 操作所需的平均时间。 |
| `WriteLatency` | 每个磁盘 I/O 操作所需的平均时间（以毫秒为单位）。 |
| `DBInstanceReplicaLag` | 在从主实例向副本实例复制更新时的滞后总量（以毫秒为单位）。 |
| `OpcountersQuery` | 一分钟内发出的查询数。 |
| `OpcountersCommand` | 一分钟内发出的命令数。 |
| `OpcountersDelete` | 一分钟内发出的删除操作的数量。 |
| `OpcountersGetmore` | 一分钟内发布的 get more 数量。 |
| `OpcountersInsert` | 一分钟内发出的插入操作数。 |
| `OpcountersUpdate` | 一分钟内发出的更新操作数。 |
| `DocumentsDeleted` | 一分钟内删除的文档数。 |
| `DocumentsInserted` | 一分钟内插入的文档数。 |
| `DocumentsReturned` | 一分钟内返回的文档数。 |
| `DocumentsUpdated` | 一分钟内更新的文档数。 |
| `TTLDeletedDocuments` | TTLMonitor 在一分钟内删除的文档数。 |
| `IndexBufferCacheHitRatio` | 缓存提供的索引请求的百分比。删除索引、集合或数据库后，您可能会立即看到该指标的峰值大于 100%。这将在 60 秒后自动更正。将在future 补丁更新中修复该限制。 |
| `BufferCacheHitRatio` | 缓冲区缓存提供的请求的百分比。 |
| `DiskQueueDepth` | 分布式存储卷的并发写入请求数。 |
| `EngineUptime` | 实例已运行的时间长度（以秒为单位）。 |


## 对象 {#object}

采集到的AWS DocumentDB 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aws_documentdb",
  "tags": {
    "AvailabilityZone"          : "cn-north-1a",
    "CACertificateIdentifier"   : "rds-ca-2019",
    "DBClusterIdentifier"       : "docdb-2023-06",
    "DBInstanceArn"             : "arn:aws-cn:rds:cn-north-1:",
    "DBInstanceClass"           : "db.t3.medium",
    "DBInstanceIdentifier"      : "docdb-2023-07",
    "DBInstanceStatus"          : "available",
    "DbiResourceId"             : "db-CKJQ",
    "Engine"                    : "docdb",
    "EngineVersion"             : "3.6.0",
    "KmsKeyId"                  : "arn:aws-cn:kms:cn-north-1:",
    "cloud_provider"            : "aws",
    "name"                      : "docdb-2023-07"
  },
  "fields": {
    "DBSubnetGroup": "{}",
    "Endpoint": "{\"Address\": \".docdb.cn-north-1.amazonaws.com.cn\", \"HostedZoneId\": \"Z010911BG9\", \"Port\": 27017}",
    "InstanceCreateTime": "2023-07-28T05:45:10.004000Z",
    "PendingModifiedValues": "{}",
    "PubliclyAccessible": "False",
    "StatusInfos": "{}",
    "VpcSecurityGroups": "[{\"Status\": \"active\", \"VpcSecurityGroupId\": \"sg-08895f59\"}]",
    "message": "{实例 json 信息}"
  }
}

```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
