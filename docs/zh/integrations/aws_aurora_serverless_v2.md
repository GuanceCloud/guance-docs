---
title: 'AWS Aurora Serverless V2'
tags: 
  - AWS
summary: 'AWS Aurora Serverless V2，包括连接数、IOPS、队列、读写延迟、网络吞吐量等。'
__int_icon: 'icon/aws_aurora_serverless_v2'
dashboard:

  - desc: 'AWS Aurora Serverless V2 内置视图'
    path: 'dashboard/zh/aws_aurora_serverless_v2'

monitor:
  - desc: 'Amazon Aurora Serverless V2 监控器'
    path: 'monitor/zh/aws_aurora_serverless_v2'

---

<!-- markdownlint-disable MD025 -->
# AWS Aurora Serverless V2
<!-- markdownlint-enable -->


 AWS Aurora Serverless V2，包括连接数、IOPS、队列、读写延迟、网络吞吐量等。


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 AWS Aurora Serverless V2 的监控数据，我们安装对应的采集脚本：「观测云集成（`AWS-RDS-Aurora-postgresql 采集`）」(ID：`guance_aws_rds_aurora_postgresql`)

点击【安装】后，输入相应的参数：亚马逊 AK、亚马逊账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aws-rds-aurora-postgresql/){:target="_blank"}



### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好AWS Aurora Serverless V2,默认的指标集如下, 可以通过配置的方式采集更多的指标 [AWS云监控指标详情](https://docs.amazonaws.cn/AmazonRDS/latest/AuroraUserGuide/Aurora.AuroraMonitoring.Metrics.html){:target="_blank"}



| 指标                               | 控制台名称                                            | 描述                                                         | 适用于                            | 单位                                |
| :--------------------------------- | :---------------------------------------------------- | ------------------------------------------------------------ | --------------------------------- | ----------------------------------- |
| `CPUUtilization`                   | **CPU 利用率（百分比）**                              | Aurora 数据库实例占用的 CPU 百分比。                         | Aurora MySQL 和 Aurora PostgreSQL | 百分比                              |
| `DatabaseConnections`              | **数据库连接（计数）**                                | 连接至数据库实例的客户端网络连接数。数据库会话数可能高于指标值，因为指标值不包括以下内容：不再具有网络连接但数据库尚未清理的会话数据库引擎出于自身目的创建的会话由数据库引擎的并行执行功能创建的会话由数据库引擎任务计划程序创建的会话Amazon Aurora 连接 | Aurora MySQL 和 Aurora PostgreSQL | 计数                                |
| `FreeableMemory`                   | **可用内存 (MB)**                                     | 随机存取内存的可用大小。                                     | Aurora MySQL 和 Aurora PostgreSQL | 字节                                |
| `WriteIOPS`                        | **写入 IOPS (计数/秒)**                               | 每秒生成的 Aurora 存储写入记录数。这或多或少是由数据库生成的日志记录数。这些不对应于 8K 页写入次数，也不对应于发送的网络数据包。 | Aurora MySQL 和 Aurora PostgreSQL | 每秒计数                            |
| `ReadIOPS`                         | **读取 IOPS（计数/秒）**                              | 每秒平均磁盘 I/O 操作数，但报告会每隔一分钟分别进行读取和写入。 | Aurora MySQL 和 Aurora PostgreSQL | 每秒计数                            |
| `DiskQueueDepth`                   | **队列深度（计数）**                                  | 等待访问磁盘的未完成读取/写入请求的数量。                    | Aurora MySQL 和 Aurora PostgreSQL | 计数                                |
| `WriteThroughput`                  | **写入吞吐量（MB/秒）**                               | 平均每秒写入持久性存储的字节数。                             | Aurora MySQL 和 Aurora PostgreSQL | 每秒字节数                          |
| `ReadThroughput`                   | **读取吞吐量（MB/秒）**                               | 每秒从磁盘读取的平均字节数。                                 | Aurora MySQL 和 Aurora PostgreSQL | 每秒字节数                          |
| `SwapUsage`                        | **交换区使用情况 (MB)**                               | 已使用的交换空间量。此指标不适用于以下数据库实例类：db.r3.*、db.r4.* 和 db.r7g.*（Aurora MySQL）db.serverless 和 db.r7g.*（Aurora PostgreSQL） | Aurora MySQL 和 Aurora PostgreSQL | 字节                                |
| `WriteLatency`                     | **Write Latency (写入延迟)**                          | 每个磁盘 I/O 操作所需的平均时间。                            | Aurora MySQL 和 Aurora PostgreSQL | 秒                                  |
| `ReadLatency`                      | **Read Latency (读取延迟)**                           | 每个磁盘 I/O 操作所需的平均时间。                            | Aurora MySQL 和 Aurora PostgreSQL | 秒                                  |
| `NetworkReceiveThroughput`         | **网络接收吞吐量（MB/秒）**                           | Aurora MySQL 数据库集群中每个实例从客户端接收的网络吞吐量。此吞吐量不包括 Aurora 数据库集群中的实例与集群卷之间的网络流量。 | Aurora MySQL 和 Aurora PostgreSQL | 每秒字节数（控制台显示“兆字节/秒”） |
| `NetworkTransmitThroughput`        | **网络传输吞吐量（MB/秒）**                           | Aurora 数据库集群中每个实例发送到客户端的网络吞吐量。此吞吐量不包括 数据库集群中的实例与集群卷之间的网络流量。 | Aurora MySQL 和 Aurora PostgreSQL | 每秒字节数（控制台显示“兆字节/秒”） |
| `TransactionLogsDiskUsage`         | **事务日志磁盘使用情况 (MB)**                         | Aurora PostgreSQL 数据库实例上的事务日志所占的磁盘空间量。此指标仅在 Aurora PostgreSQL 使用逻辑复制或 Amazon Database Migration Service 时生成。默认情况下，Aurora PostgreSQL 使用日志记录，而不是事务日志。未使用事务日志时，此指标的值为 `-1`。 | 适用于 Aurora PostgreSQL 的主实例 | 字节                                |
| `EBSIOBalance%`                    | **EBS IO 余额（百分比）**                             | RDS 数据库突增存储桶中剩余的 I/O 积分的百分比 此指标仅对基本监控可用。要查找支持此指标的实例大小，请参阅 *Amazon EC2 用户指南（适用于 Linux 实例）* 中[默认优化的 EBS 表](https://docs.amazonaws.cn/AWSEC2/latest/UserGuide/ebs-optimized.html#current)中带星号 (*) 的实例大小。`Sum` 统计数据不适用于该指标。这个指标不同于 `BurstBalance`。要了解如何使用此指标，请参阅[利用 Amazon EBS 优化型实例突发功能提升应用程序性能并降低成本](http://www.amazonaws.cn/blogs/compute/improving-application-performance-and-reducing-costs-with-amazon-ebs-optimized-instance-burst-capability/)。 | Aurora MySQL 和 Aurora PostgreSQL | 百分比                              |
| `EBSByteBalance%`                  | **EBS 字节余额（百分比）**                            | RDS 数据库突增存储桶中剩余的吞吐量积分的百分比 此指标仅对基本监控可用。要查找支持此指标的实例大小，请参阅 *Amazon EC2 用户指南（适用于 Linux 实例）* 中[默认优化的 EBS 表](https://docs.amazonaws.cn/AWSEC2/latest/UserGuide/ebs-optimized.html#current)中带星号 (*) 的实例大小。`Sum` 统计数据不适用于该指标。 | Aurora MySQL 和 Aurora PostgreSQL | 百分比                              |
| `FreeLocalStorage`                 | **Free Local Storage (Bytes)** [可用本地存储（字节）] | 可用的本地存储空间量。与其他数据库引擎不同，对于 Aurora 数据库实例，该指标报告每个数据库实例的可用存储量。此值取决于数据库实例类（有关定价信息，请参阅 [Amazon RDS 定价页](http://www.amazonaws.cn/rds/pricing)）。您可通过为实例选择较大的数据库实例类来增加对实例可用的存储空间量。（这不适用于 Aurora Serverless v2。） | Aurora MySQL 和 Aurora PostgreSQL | 字节                                |
| `EngineUptime`                     | **引擎正常运行时间（秒）**                            | 实例运行的时间长度。                                         | Aurora MySQL 和 Aurora PostgreSQL | 秒                                  |
| `StorageNetworkReceiveThroughput`  | **网络接收吞吐量（MB/秒）**                           | 数据库集群中每个实例从 Aurora 存储子系统接收的网络吞吐量。   | Aurora MySQL 和 Aurora PostgreSQL | 每秒字节数                          |
| `StorageNetworkThroughput`         | **网络吞吐量（字节/秒）**                             | Aurora MySQL 数据库集群中每个实例从 Aurora 存储子系统接收与发送的网络吞吐量。 | Aurora MySQL 和 Aurora PostgreSQL | 每秒字节数                          |
| `StorageNetworkTransmitThroughput` | **网络传输吞吐量（MB/秒）**                           | Aurora MySQL 数据库集群中每个实例发送到 Aurora 存储子系统的网络吞吐量。 | Aurora MySQL 和 Aurora PostgreSQL | 每秒字节数                          |

## 对象 {#object}

采集到的AWS Aurora Serverless V2 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json

{
  "measurement": "aws_rds_aurora_postgresql",
  "tags": {
    "SecondaryAvailabilityZone" : "cn-northwest-1d",
    "AvailabilityZone"          : "cn-northwest-1c",
    "DBInstanceClass"           : "db.t4g.large",
    "DBInstanceIdentifier"      : "aurora-mh0908-instance-1",
    "DBInstanceStatus"          : "available",
    "Endpoint.Address"          : "aurora-xxxxxxx-instance-xx.xxxxx.rds.cn-northwest-1.amazonaws.com.cn",
    "Engine"                    : "aurora-postgresql",
    "RegionId"                  : "cn-northwest-1",
    "name"                      : "aurora-xxxxxxx-instance-xxx"
  },
  "fields": {
    "InstanceCreateTime"  : "2018-03-28T19:54:07.871Z",
    "Endpoint"            : "{连接地址 JSON 数据}",
    "AllocatedStorage"    : 100,
    "message"             : "{实例 JSON 数据}"
  }
}


```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
> 提示 2：`fields.message`、`fields.Endpoint`、均为 JSON 序列化后字符串
