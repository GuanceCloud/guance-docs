---
title: 'AWS RDS MySQL'
tags: 
  - AWS
summary: '使用脚本市场中「{{{ custom_key.brand_name }}}云同步」系列脚本包把云监控 云资产的数据同步到{{{ custom_key.brand_name }}}'
__int_icon: 'icon/aws_rds_mysql'
dashboard:

  - desc: 'AWS RDS MySQL 内置视图'
    path: 'dashboard/zh/aws_rds_mysql'

monitor:
  - desc: 'AWS RDS MySQL 监控器'
    path: 'monitor/zh/aws_rds_mysql'

cloudCollector:
  desc: '云采集器'
  path: 'cloud-collector/zh/aws_rds_mysql'
---


<!-- markdownlint-disable MD025 -->
# AWS RDS MySQL
<!-- markdownlint-enable -->


使用脚本市场中「{{{ custom_key.brand_name }}}云同步」系列脚本包把云监控 云资产的数据同步到{{{ custom_key.brand_name }}}


## 配置 {#config}

### 安装 Func

推荐开通 {{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 AWS RDS 的监控数据，我们安装对应的采集脚本：「{{{ custom_key.brand_name }}}集成（AWS-RDS采集）」(ID：`guance_aws_rds`)

点击【安装】后，输入相应的参数：亚马逊 AK、亚马逊账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在{{{ custom_key.brand_name }}}平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在{{{ custom_key.brand_name }}}平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好亚马逊-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [亚马逊云监控指标详情](https://docs.aws.amazon.com/zh_cn/AmazonRDS/latest/UserGuide/CHAP_Monitoring.html){:target="_blank"}

### Amazon RDS 的 Amazon CloudWatch 实例级指标

Amazon CloudWatch 中的 `AWS/RDS` 命名空间包括以下实例级指标。

注意:

Amazon RDS 控制台可能会以与发送到 Amazon CloudWatch 的单位不同的单位显示指标。例如，Amazon RDS 控制台可能会以兆字节 (MB) 为单位显示一个指标，同时以字节为单位将该指标发送到 Amazon CloudWatch。

| 指标                            | 控制台名称                                                   | 描述                                                         | 单位              |
| :------------------------------ | :----------------------------------------------------------- | :----------------------------------------------------------- | :---------------- |
| `BinLogDiskUsage`               | **二进制日志磁盘使用情况 (MB)**                              | 二进制日志所占的磁盘空间大小。如果为 MySQL 和 MariaDB 实例（包括只读副本）启用了自动备份，则会创建二进制日志。 | 字节              |
| `BurstBalance`                  | **突发余额（百分比）**                                       | 可用的通用型 SSD (GP2) 突增存储桶 I/O 点数的百分比。         | 百分比            |
| `CheckpointLag`                 | **检查点滞后（毫秒）**                                       | 自最近一次检查点以来的时间。仅适用于 RDS for PostgreSQL。    | 毫秒              |
| `ConnectionAttempts`            | **Connection Attempts (Count)** [连接尝试（计数）]           | 尝试连接实例的次数，无论成功与否。                           | 计数              |
| `CPUUtilization`                | **CPU 利用率（百分比）**                                     | CPU 使用百分率。                                             | 百分比            |
| `CPUCreditUsage`                | **CPU 额度使用（计数）**                                     | （T2 实例）实例为保持 CPU 使用率而花费的 CPU 积分数。一个 CPU 积分等于一个 vCPU 以 100% 的使用率运行一分钟或等同的 vCPU、使用率与时间的组合。例如，您可以有一个 vCPU 按 50% 使用率运行两分钟，或者两个 vCPU 按 25% 使用率运行两分钟。CPU 积分指标仅每 5 分钟提供一次。如果您指定一个大于五分钟的时间段，请使用`Sum` 统计数据，而非 `Average` 统计数据。 | 积分 (vCPU 分钟)  |
| `CPUCreditBalance`              | **CPU 额度余额（计数）**                                     | （T2 实例）实例自启动后已累积获得的 CPU 积分数。对于 T2 标准，`CPUCreditBalance` 还包含已累积的启动积分数。在获得积分后，积分将在积分余额中累积；在花费积分后，将从积分余额中扣除积分。积分余额具有最大值限制，这是由实例大小决定的。在达到限制后，将丢弃获得的任何新积分。对于 T2 标准，启动积分不计入限制。实例可以花费 `CPUCreditBalance` 中的积分，以便突增到基准 CPU 使用率以上。在实例运行过程中，`CPUCreditBalance` 中的积分不会过期。在实例停止时，`CPUCreditBalance` 不会保留，并且所有累积的积分都将丢失。CPU 信用指标仅每 5 分钟提供一次。启动积分在 Amazon RDS 中的作用方式与在 Amazon EC2 中的作用方式相同。有关更多信息，请参阅[适用于 Linux 实例的 Amazon Elastic Compute Cloud 用户指南](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances-standard-mode-concepts.html#launch-credits){:target="_blank"}中的*启动积分*。 | 积分（vCPU 分钟） |
| `DatabaseConnections`           | **数据库连接（计数）**                                       | 连接至数据库实例的客户端网络连接数。数据库会话数可能高于指标值，因为指标值不包括以下内容：不再具有网络连接但数据库尚未清理的会话数据库引擎出于自身目的创建的会话由数据库引擎的并行执行功能创建的会话由数据库引擎任务计划程序创建的会话Amazon RDS 连接 | 计数              |
| `DiskQueueDepth`                | **队列深度（计数）**                                         | 等待访问磁盘的未完成 I/O（读取/写入请求）的数量。            | 计数              |
| `EBSByteBalance%`               | **EBS 字节余额（百分比）**                                   | RDS 数据库突增存储桶中剩余的吞吐量积分的百分比 此指标仅对基本监控可用。该指标值基于包括根卷在内的所有卷的吞吐量和 IOPS，而不是仅基于那些包含数据库文件的卷。要查找支持此指标的实例大小，请参阅 *Amazon EC2 用户指南（适用于 Linux 实例）* 中[默认优化的 EBS 表](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-optimized.html#current){:target="_blank"}中带星号 (*) 的实例大小。`Sum` 统计数据不适用于该指标。 | 百分比            |
| `EBSIOBalance%`                 | **EBS IO 余额（百分比）**                                    | RDS 数据库突增存储桶中剩余的 I/O 积分的百分比 此指标仅对基本监控可用。该指标值基于包括根卷在内的所有卷的吞吐量和 IOPS，而不是仅基于那些包含数据库文件的卷。要查找支持此指标的实例大小，请参阅 *Amazon EC2 用户指南（适用于 Linux 实例）* 中[默认优化的 EBS 表](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-optimized.html#current){:target="_blank"}中带星号 (*) 的实例大小。`Sum` 统计数据不适用于该指标。这个指标不同于 `BurstBalance`。要了解如何使用此指标，请参阅[利用 Amazon EBS 优化型实例突发功能提升应用程序性能并降低成本](http://aws.amazon.com/blogs/compute/improving-application-performance-and-reducing-costs-with-amazon-ebs-optimized-instance-burst-capability/){:target="_blank"}。 | 百分比            |
| `FailedSQLServerAgentJobsCount` | **Failed SQL Server Agent Jobs Count (Count/Minute) (失败的 SQL Server Agent 作业计数（计数/分钟）)** | 过去 1 分钟内失败的 Microsoft SQL Server Agent 作业的数量。  | 每分钟计数        |
| `FreeableMemory`                | **可用内存 (MB)**                                            | 随机存取内存的可用大小。对于 MariaDB、MySQL、Oracle 和 PostgreSQL 数据库实例，此指标报告 `MemAvailable` 的 `/proc/meminfo` 字段的值。 | 字节              |
| `FreeLocalStorage`              | **Free Local Storage (MB)**（可用本地存储 (MB)）             | 可用本地存储空间的大小。此指标仅适用于具有 NVMe SSD 实例存储卷的数据库实例类。有关具有 NVMe SSD 实例存储卷的 Amazon EC2 实例的信息，请参阅[实例存储卷](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}。等效的 RDS 数据库实例类具有相同的实例存储卷。例如，db.m6gd 和 db.r6gd 数据库实例类具有 NVMe SSD 实例存储卷。（这不适用于 Aurora Serverless v2。） | 字节              |
| `FreeStorageSpace`              | **可用存储空间 (MB)**                                        | 可用存储空间的大小。                                         | 字节              |
| `MaximumUsedTransactionIDs`     | **最大已用事务 ID（计数）**                                  | 已使用的最大事务 ID。仅适用于 PostgreSQL。                   | 计数              |
| `NetworkReceiveThroughput`      | **网络接收吞吐量（MB/秒）**                                  | 数据库实例的传入（接收）网络流量，包括用于监控和复制的客户数据库流量和 Amazon RDS 流量。 | 每秒字节数        |
| `NetworkTransmitThroughput`     | **网络传输吞吐量（MB/秒）**                                  | 数据库实例的传出（传输）网络流量，包括用于监控和复制的客户数据库流量和 Amazon RDS 流量。 | 每秒字节数        |
| `OldestReplicationSlotLag`      | **最早副本槽滞后 (MB)**                                      | 在接收预写日志 (WAL) 数据方面最滞后的副本的滞后大小。适用于 PostgreSQL。 | 字节              |
| `ReadIOPS`                      | **读取 IOPS（计数/秒）**                                     | 每秒平均磁盘读取 I/O 操作数。                                | 每秒计数          |
| `ReadIOPSLocalStorage`          | **Read IOPS Local Storage (Count/Second)**（读取 IOPS 本地存储（计数/秒）） | 每秒至本地存储的平均磁盘读取输入/输出操作数。此指标仅适用于具有 NVMe SSD 实例存储卷的数据库实例类。有关具有 NVMe SSD 实例存储卷的 Amazon EC2 实例的信息，请参阅[实例存储卷](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}。等效的 RDS 数据库实例类具有相同的实例存储卷。例如，db.m6gd 和 db.r6gd 数据库实例类具有 NVMe SSD 实例存储卷。 | 每秒计数          |
| `ReadLatency`                   | **读取延迟（毫秒）**                                         | 每个磁盘 I/O 操作所需的平均时间。                            | 毫秒              |
| `ReadLatencyLocalStorage`       | **Read Latency Local Storage (Milliseconds)**（读取延迟本地存储（毫秒）） | 每个磁盘对本地存储输入/输出操作所需的平均时间。此指标仅适用于具有 NVMe SSD 实例存储卷的数据库实例类。有关具有 NVMe SSD 实例存储卷的 Amazon EC2 实例的信息，请参阅[实例存储卷](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}。等效的 RDS 数据库实例类具有相同的实例存储卷。例如，db.m6gd 和 db.r6gd 数据库实例类具有 NVMe SSD 实例存储卷。 | 毫秒              |
| `ReadThroughput`                | **读取吞吐量（MB/秒）**                                      | 每秒从磁盘读取的平均字节数。                                 | 每秒字节数        |
| `ReadThroughputLocalStorage`    | **Read Throughput Local Storage (MB/Second)**（读取吞吐量本地存储（MB/秒）） | 每秒从磁盘至本地存储读取的平均字节数。此指标仅适用于具有 NVMe SSD 实例存储卷的数据库实例类。有关具有 NVMe SSD 实例存储卷的 Amazon EC2 实例的信息，请参阅[实例存储卷](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}。等效的 RDS 数据库实例类具有相同的实例存储卷。例如，db.m6gd 和 db.r6gd 数据库实例类具有 NVMe SSD 实例存储卷。 | 每秒字节数        |
| `ReplicaLag`                    | **副本滞后（毫秒）**                                         | 对于只读副本配置，只读副本数据库实例滞后于源数据库实例的时间量。适用于 MariaDB、Microsoft SQL Server、MySQL、Oracle 和 PostgreSQL 只读副本。对于多可用区数据库集群，写入器数据库实例上的最新事务与读取器数据库实例上的最新应用事务之间的时间差异。 | 毫秒              |
| `ReplicationSlotDiskUsage`      | **副本插槽磁盘使用情况 (MB)**                                | 副本槽文件使用的磁盘空间。适用于 PostgreSQL。                | 字节              |
| `SwapUsage`                     | **交换区使用情况 (MB)**                                      | 数据库实例上使用的交换空间的大小。此指标对于 SQL Server 不可用。 | 字节              |
| `TransactionLogsDiskUsage`      | **事务日志磁盘使用情况 (MB)**                                | 事务日志使用的磁盘空间。适用于 PostgreSQL。                  | 字节              |
| `TransactionLogsGeneration`     | **事务日志生成（MB/秒）**                                    | 每秒生成的事务日志的大小。适用于 PostgreSQL。                | 每秒字节数        |
| `WriteIOPS`                     | **写入 IOPS (计数/秒)**                                      | 每秒平均磁盘写入 I/O 操作数。                                | 每秒计数          |
| `WriteIOPSLocalStorage`         | **Write IOPS Local Storage (Count/Second)**（写入 IOPS 本地存储（计数/秒）） | 本地存储上的每秒平均磁盘写入 I/O 操作数。此指标仅适用于具有 NVMe SSD 实例存储卷的数据库实例类。有关具有 NVMe SSD 实例存储卷的 Amazon EC2 实例的信息，请参阅[实例存储卷](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}。等效的 RDS 数据库实例类具有相同的实例存储卷。例如，db.m6gd 和 db.r6gd 数据库实例类具有 NVMe SSD 实例存储卷。 | 每秒计数          |
| `WriteLatency`                  | **写入延迟（毫秒）**                                         | 每个磁盘 I/O 操作所需的平均时间。                            | 毫秒              |
| `WriteLatencyLocalStorage`      | **Write Latency Local Storage (Milliseconds)**（写入延迟本地存储（毫秒）） | 本地存储上每个磁盘 I/O 操作所需的平均时间。此指标仅适用于具有 NVMe SSD 实例存储卷的数据库实例类。有关具有 NVMe SSD 实例存储卷的 Amazon EC2 实例的信息，请参阅[实例存储卷](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}。等效的 RDS 数据库实例类具有相同的实例存储卷。例如，db.m6gd 和 db.r6gd 数据库实例类具有 NVMe SSD 实例存储卷。 | 毫秒              |
| `WriteThroughput`               | **写入吞吐量（MB/秒）**                                      | 每秒写入磁盘的平均字节数。                                   | 每秒字节数        |
| `WriteThroughputLocalStorage`   | **Write Throughput Local Storage (MB/Second)**（写入吞吐量本地存储（MB/秒）） | 本地存储每秒写入磁盘的平均字节数。此指标仅适用于具有 NVMe SSD 实例存储卷的数据库实例类。有关具有 NVMe SSD 实例存储卷的 Amazon EC2 实例的信息，请参阅[实例存储卷](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes){:target="_blank"}。等效的 RDS 数据库实例类具有相同的实例存储卷。例如，db.m6gd 和 db.r6gd 数据库实例类具有 NVMe SSD 实例存储卷。 | 每秒字节数        |

### Amazon RDS 的 Amazon CloudWatch 用量指标

Amazon CloudWatch 中的 `AWS/Usage` 命名空间包括 Amazon RDS 服务配额的账户级用量指标。CloudWatch 自动收集所有 AWS 区域的使用量指标。

有关更多信息，请参阅《Amazon CloudWatch 用户指南》中的 [CloudWatch 用量指标](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Usage-Metrics.html){:target="_blank"}。有关配额的更多信息，请参阅《Service Quotas 用户指南》中 [Amazon RDS 的配额和限制](https://docs.aws.amazon.com/zh_cn/AmazonRDS/latest/UserGuide/CHAP_Limits.html){:target="_blank"}和[请求增加配额](https://docs.aws.amazon.com/servicequotas/latest/userguide/request-quota-increase.html){:target="_blank"}。

| 指标                       | 描述                                                         | 单位*    |
| :------------------------- | :----------------------------------------------------------- | :------- |
| `AllocatedStorage`         | 所有数据库实例的总存储空间。总和不包括临时迁移实例。         | 千兆字节 |
| `DBClusterParameterGroups` | 您的 AWS 账户 中的数据库集群参数组数量。该计数不包括默认参数组。 | 计数     |
| `DBClusters`               | 您的 AWS 账户 中的 Amazon Aurora 数据库集群数量。            | 计数     |
| `DBInstances`              | 您的 AWS 账户 中的数据库实例数量。                           | 计数     |
| `DBParameterGroups`        | 您的 AWS 账户 中的数据库参数组数量。该计数不包括默认数据库参数组。 | 计数     |
| `DBSecurityGroups`         | 您的 AWS 账户 中的安全组数量。该计数不包括默认安全组和默认 VPC 安全组。 | 计数     |
| `DBSubnetGroups`           | 您的 AWS 账户 中的数据库子网组数量。该计数不包括默认子网组。 | 计数     |
| `ManualClusterSnapshots`   | 您的 AWS 账户 中手动创建的数据库集群快照数量。该计数不包括无效快照。 | 计数     |
| `ManualSnapshots`          | 您的 AWS 账户 中手动创建的数据库快照数量。该计数不包括无效快照。 | 计数     |
| `OptionGroups`             | 您的 AWS 账户 中的选项组数量。该计数不包括默认选项组。       | 计数     |
| `ReservedDBInstances`      | 您的 AWS 账户 中的预留数据库实例数量。该计数不包括停用或被拒绝的实例。 | 计数     |

\* Amazon RDS 不会向 CloudWatch 发布用量指标的单位。这些单位仅出现在文档中。

## 对象 {#object}

采集到的AWS RDS MySQL 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aws_rds",
  "tags": {
    "name"                     : "xxxxx",
    "RegionId"                 : "cn-northwest-1",
    "Engine"                   : "mysql",
    "DBInstanceClass"          : "db.t3.medium",
    "DBInstanceIdentifier"     : "xxxxxx",
    "AvailabilityZone"         : "cn-northwest-1c",
    "SecondaryAvailabilityZone": "cn-northwest-1d"
  },
  "fields": {
    "InstanceCreateTime"  : "2018-03-28T19:54:07.871Z",
    "LatestRestorableTime": "2018-03-28T19:54:07.871Z",
    "Endpoint"            : "{连接地址 JSON 数据}",
    "AllocatedStorage"    : 100,
    "message"             : "{实例 JSON 数据}",
  }
}
```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
>
> 提示 2：`fields.message`、`fields.Endpoint`、均为 JSON 序列化后字符串
