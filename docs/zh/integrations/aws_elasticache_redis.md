---
title: 'AWS ElastiCache Redis'
summary: '使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云'
__int_icon: 'icon/aws_elasticache_redis'
dashboard:

  - desc: 'AWS ElastiCache Redis内置视图'
    path: 'dashboard/zh/aws_elasticache_redis'

monitor:
  - desc: 'AWS ElastiCache Redis监控器'
    path: 'monitor/zh/aws_elasticache_redis'

---


<!-- markdownlint-disable MD025 -->
# AWS ElastiCache Redis
<!-- markdownlint-enable -->


使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 ElastiCache Redis 的监控数据，我们安装对应的采集脚本：「观测云集成（AWS-ElastiCache采集）」(ID：`guance_aws_elasticache`)

点击【安装】后，输入相应的参数：亚马逊 AK、亚马逊账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。



> 我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好亚马逊-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [亚马逊云监控指标详情](https://docs.aws.amazon.com/zh_cn/AmazonElastiCache/latest/red-ug/CacheMetrics.html){:target="_blank"}

### 主机级指标

| 指标                                       | 描述                                                         | 单位              |
| :----------------------------------------- | :----------------------------------------------------------- | :---------------- |
| `CPUUtilization`                           | 整个主机的 CPU 使用率百分比。由于 Redis 是单线程的，因此，我们建议您监控有 4 个或更多 vCPU 的节点的 `EngineCPUUtilization` 指标。 | 百分比            |
| `CPUCreditBalance`                         | 实例自启动后已累积获得的 CPU 积分数。对于 T2 标准，CPUCreditBalance 还包含已累积的启动积分数。在获得积分后，积分将在积分余额中累积；在花费积分后，将从积分余额中扣除积分。积分余额具有最大值限制，这是由实例大小决定的。在达到限制后，将丢弃获得的任何新积分。对于 T2 标准，启动积分不计入限制。实例可以花费 CPUCreditBalance 中的积分，以便突增到基准 CPU 使用率以上。CPU 信用指标仅每 5 分钟提供一次。这些指标对 T2 可突增性能实例不可用。 | 积分（vCPU 分钟） |
| `CPUCreditUsage`                           | 实例为保持 CPU 使用率而花费的 CPU 积分数。一个 CPU 积分等于一个 vCPU 按 100% 利用率运行一分钟，或者 vCPU、利用率和时间的等效组合（例如， 一个 vCPU 按 50% 利用率运行两分钟，或者两个 vCPU 按 25% 利用率运行两分钟）。CPU 信用指标仅每 5 分钟提供一次。如果您指定一个大于五分钟的时间段，请使用“Sum（总和）”统计数据，而非“Average（平均值）”统计数据。这些指标对 T2 可突增性能实例不可用。 | 积分（vCPU 分钟） |
| `FreeableMemory`                           | 主机上可用的闲置内存量。这是从操作系统报告为空闲的 RAM、缓冲区和缓存中派生出来的。 | 字节              |
| `NetworkBytesIn`                           | 主机已从网络读取的字节数。                                   | 字节              |
| `NetworkBytesOut`                          | 实例在所有网络接口上发送的字节数。                           | 字节              |
| `NetworkPacketsIn`                         | 实例在所有网络接口上收到的数据包的数量。此指标依据单个实例上的数据包数量来标识传入流量的量。 | 计数              |
| `NetworkPacketsOut`                        | 实例在所有网络接口上发送的数据包的数量。此指标依据单个实例上的数据包数量标识传出流量的量。 | 计数              |
| `NetworkBandwidthInAllowanceExceeded`      | 因入站聚合带宽超过实例的最大值而排队或丢弃的数据包的数量。   | 计数              |
| `NetworkConntrackAllowanceExceeded`        | 由于连接跟踪超过实例的最大值且无法建立新连接而丢弃的数据包的数量。这可能会导致进出实例的流量丢失数据包。 | 计数              |
| `NetworkLinkLocalAllowanceExceeded`        | 由于到本地代理服务的流量的 PPS 超出网络接口的最大值而丢弃的数据包数量。这会影响流向 DNS 服务、实例元数据服务和 Amazon Time Sync Service 的流量。 | 计数              |
| `NetworkBandwidthOutAllowanceExceeded`     | 因出站聚合带宽超过实例的最大值而排队或丢弃的数据包的数量。   | 计数              |
| `NetworkPacketsPerSecondAllowanceExceeded` | 因每秒双向数据包数量超过实例的最大值而排队或丢弃的数据包数量。 | 计数              |
| `SwapUsage`                                | 主机上的交换区使用量。                                       | 字节              |

### Redis的指标

| 指标                                             | 描述                                                         | 单位   |
| :----------------------------------------------- | :----------------------------------------------------------- | :----- |
| `ActiveDefragHits`                               | 活动碎片整理进程每分钟执行的值重新分配数。这是从 [Redis INFO](http://redis.io/commands/info){:target="_blank"} 的 `active_defrag_hits` 统计数据中得出的。 | 数字   |
| `AuthenticationFailures`                         | 使用 AUTH 命令向 Redis 进行身份验证的失败尝试总次数。您可以使用 [ACL LOG](https://redis.io/commands/acl-log){:target="_blank"} 命令查找有关个人身份验证失败的更多信息。我们建议为此设置告警以检测未经授权的访问尝试。 | 计数   |
| `BytesUsedForCache`                              | Redis 为所有目的（包括数据集、缓冲区等）分配的字节的总数。`Dimension: Tier=Memory`（对于使用[数据分层](https://docs.aws.amazon.com/zh_cn/AmazonElastiCache/latest/red-ug/data-tiering.html){:target="_blank"}功能的 Redis 集群）：内存中用于缓存的总字节数。这是 [Redis INFO](http://redis.io/commands/info){:target="_blank"} 的 `used_memory` 统计数据的值。`Dimension: Tier=SSD`（对于使用[数据分层](https://docs.aws.amazon.com/zh_cn/AmazonElastiCache/latest/red-ug/data-tiering.html){:target="_blank"}功能的 Redis 集群）：SSD 中用于缓存的总字节数。 | 字节   |
| `BytesReadFromDisk`                              | 每分钟从磁盘读取的总字节数。仅支持使用[数据分层](https://docs.aws.amazon.com/zh_cn/AmazonElastiCache/latest/red-ug/data-tiering.html){:target="_blank"}功能的集群。 | 字节   |
| `BytesWrittenToDisk`                             | 每分钟写入磁盘的总字节数。仅支持使用[数据分层](https://docs.aws.amazon.com/zh_cn/AmazonElastiCache/latest/red-ug/data-tiering.html){:target="_blank"}功能的集群。 | 字节   |
| `CacheHits`                                      | 主字典中成功的只读键查找次数。这是从 [Redis INFO](http://redis.io/commands/info){:target="_blank"} 的 `keyspace_hits` 统计数据中得出的。 | 计数   |
| `CacheMisses`                                    | 主字典中失败的只读键查找次数。这是从 [Redis INFO](http://redis.io/commands/info){:target="_blank"} 的 `keyspace_misses` 统计数据中得出的。 | 计数   |
| `CommandAuthorizationFailures`                   | 用户运行其无权限调用的命令的失败尝试次数。您可以使用 [ACL LOG](https://redis.io/commands/acl-log){:target="_blank"} 命令查找有关个人身份验证失败的更多信息。我们建议为此设置告警以检测未经授权的访问尝试。 | 计数   |
| `CacheHitRate`                                   | 指示 Redis 实例的使用效率。如果缓存比率低于 0.8 左右，则意味着大量的密钥被移出、过期或不存在。这是使用 `cache_hits` 和 `cache_misses` 统计数据按以下方式计算的：`cache_hits /(cache_hits + cache_misses)`。 | 百分比 |
| `ChannelAuthorizationFailures`                   | 用户访问其无权限访问的通道的失败尝试次数。您可以使用 [ACL LOG](https://redis.io/commands/acl-log){:target="_blank"} 命令查找有关个人身份验证失败的更多信息。我们建议为此指标设置告警以检测未经授权的访问尝试。 | 计数   |
| `CurrConnections`                                | 客户端连接数，不包括来自只读副本的连接。ElastiCache 使用两到四个连接来监控各种情况下的集群。这是根据 [Redis INFO](http://redis.io/commands/info){:target="_blank"} 中的 `connected_clients` 统计数据得出的。 | 计数   |
| `CurrItems`                                      | 缓存中的项目数。此值根据以下方法获得的 Redis `keyspace` 统计数据得出：计算整个键空间中所有键的总和。`Dimension: Tier=Memory`（对于使用[数据分层](https://docs.aws.amazon.com/zh_cn/AmazonElastiCache/latest/red-ug/data-tiering.html){:target="_blank"}功能的 Redis 集群）。内存中的项目数。`Dimension: Tier=SSD`（固态硬盘）（对于使用[数据分层](https://docs.aws.amazon.com/zh_cn/AmazonElastiCache/latest/red-ug/data-tiering.html){:target="_blank"}功能的 Redis 集群）。SSD 中的项目数。 | 计数   |
| `CurrVolatileItems`                              | 所有数据库中具有 ttl 集的键的总数。此值根据 Redis `expires` 统计数据得出，方式是将在整个键空间内有 ttl 集的所有键相加。 | 计数   |
| `DatabaseCapacityUsagePercentage`                | 集群的总数据容量中正在使用的百分比。该指标的计算方式如下：`used_memory/maxmemory`在数据分层实例上，该指标的计算方式如下：`(used_memory - mem_not_counted_for_evict + SSD used) / (maxmemory + SSD total capacity)`其中，`used_memory` 和 `maxmemory` 取自 [Redis 信息](https://redis.io/commands/info/){:target="_blank"}。 | 百分比 |
| `DatabaseCapacityUsageCountedForEvictPercentage` | 集群的总数据容量中正在使用的百分比（不含用于开销和 COB 的内存）。该指标的计算方式如下：`used_memory - mem_not_counted_for_evict/maxmemory`在数据分层实例上，该指标的计算方式如下：`(used_memory + SSD used) / (maxmemory + SSD total capacity)`其中，`used_memory` 和 `maxmemory` 取自 [Redis 信息](https://redis.io/commands/info/){:target="_blank"} | 百分比 |
| `DatabaseMemoryUsagePercentage`                  | 集群中正在使用的内存的百分比。这是使用 `used_memory/maxmemory` 从 [Redis INFO](http://redis.io/commands/info){:target="_blank"} 计算得来的。 | 百分比 |
| `DatabaseMemoryUsageCountedForEvictPercentage`   | 集群中正在使用的内存的百分比（不含用于开销和 COB 的内存）。这是使用 `used_memory-mem_not_counted_for_evict/maxmemory` 从 [Redis INFO](http://redis.io/commands/info){:target="_blank"} 计算得来的。 | 百分比 |
| `DB0AverageTTL`                                  | 根据 [Redis INFO](http://redis.io/commands/info){:target="_blank"} 命令中的 `keyspace` 统计数据中公开 DBO 的 `avg_ttl`。副本不会使密钥过期，而是等待主节点使密钥过期。当主节点使密钥过期（或由于 LRU 而将其逐出）时，它将合成一个 `DEL` 命令，该命令将传送到所有副本。因此，对于副本节点，DB0AverageTTL 为 0，因为它们不会使密钥过期，因而不会跟踪 TTL。 | 毫秒   |
| `EngineCPUUtilization`                           | 提供 Redis 引擎线程的 CPU 使用率。由于 Redis 是单线程的，您可以使用该指标来分析 Redis 进程本身的负载。`EngineCPUUtilization` 指标更精确地呈现了 Redis 流程。您可以将其与 `CPUUtilization` 指标配合使用。`CPUUtilization` 公开服务器实例整体的 CPU 使用率，包括其他操作系统和管理流程。对于有四个或更多 vCPU 的较大节点类型，可使用 `EngineCPUUtilization` 指标来监控和设置扩展阈值。注意在 ElastiCache 主机上，后台进程将监控主机以提供托管式数据库体验。这些后台进程可能会占用很大一部分 CPU 工作负载。这在具有两个以上 vCPU 的大型主机上影响不大，但在 vCPU 个数不超过 2 个的小型主机上影响较大。如果仅监控 `EngineCPUUtilization` 指标，您将无法发现因 Redis 或后台监控进程的 CPU 使用率过高而导致主机过载情况。因此，我们建议对于具有不超过两个 vCPU 的主机，还需要监控 `CPUUtilization` 指标。 | 百分比 |
| `Evictions`                                      | 由于 `maxmemory` 限制而被驱逐的密钥数。这是根据 [Redis INFO](http://redis.io/commands/info){:target="_blank"} 中的 `evicted_keys` 统计数据得出的。 | 计数   |
| `GlobalDatastoreReplicationLag`                  | 此为辅助区域的主节点与主区域的主节点之间的滞后。对于已启用集群模式的 Redis，滞后表示分片之间的最大延迟。 | 秒     |
| `IamAuthenticationExpirations`                   | 已过期的经过 IAM 身份验证的 Redis 连接总数。您可以在用户指南中找到有关 [使用 IAM 进行身份验证](https://docs.aws.amazon.com/zh_cn/AmazonElastiCache/latest/red-ug/auth-iam.html){:target="_blank"} 的更多信息。 | 计数   |
| `IamAuthenticationThrottling`                    | 受限的经过 IAM 身份验证的 Redis AUTH 或 HELLO 请求的总数。您可以在用户指南中找到有关 [使用 IAM 进行身份验证](https://docs.aws.amazon.com/zh_cn/AmazonElastiCache/latest/red-ug/auth-iam.html){:target="_blank"} 的更多信息。 | 计数   |
| `IsMaster`                                       | 指示节点是否为当前分片/集群的主节点。指标可以是 0（非主节点）或 1（主节点）。 | 计数   |
| `KeyAuthorizationFailures`                       | 用户访问其无权限访问的密钥的失败尝试次数。您可以使用 [ACL LOG](https://redis.io/commands/acl-log){:target="_blank"} 命令查找有关个人身份验证失败的更多信息。我们建议为此设置告警以检测未经授权的访问尝试。 | 计数   |
| `KeysTracked`                                    | Redis 密钥跟踪所跟踪的密钥数所占 `tracking-table-max-keys` 的百分比。密钥跟踪用于帮助客户端侧缓存，并在修改密钥时通知客户端。 | 计数   |
| `MemoryFragmentationRatio`                       | 指示 Redis 引擎的内存分配的效率。某些阈值将表示不同的行为。建议的值是让碎片化大于 1.0。这是根据 [Redis INFO](http://redis.io/commands/info){:target="_blank"} 中的 `mem_fragmentation_ratio statistic` 计算得来的。 | 数字   |
| `NewConnections`                                 | 在此期间，服务器接受的连接总数。这是根据 [Redis INFO](http://redis.io/commands/info){:target="_blank"} 中的 `total_connections_received` 统计数据得出的。注意如果您使用 ElastiCache for Redis 版本 5 或更低版本，则 ElastiCache 会使用该指标报告的两到四个连接来监控集群。但是，当使用 ElastiCache for Redis 版本 6 或更高版本时，ElastiCache 用于监控集群的连接不包含在此指标中。 | 计数   |
| `NumItemsReadFromDisk`                           | 每分钟从磁盘检索的项目总数。仅支持使用[数据分层](https://docs.aws.amazon.com/zh_cn/AmazonElastiCache/latest/red-ug/data-tiering.html){:target="_blank"}功能的集群。 | 计数   |
| `NumItemsWrittenToDisk`                          | 每分钟写入磁盘的项目总数。仅支持使用[数据分层](https://docs.aws.amazon.com/zh_cn/AmazonElastiCache/latest/red-ug/data-tiering.html){:target="_blank"}功能的集群。 | 计数   |
| `MasterLinkHealthStatus`                         | 此状态有两个值：0 或 1。值为 0 表示 Elasticache 主节点中的数据未与 EC2 上的 Redis 同步。值为 1 表示数据已同步。如需完成迁移，请使用 [CompleteMigration](https://docs.aws.amazon.com/AmazonElastiCache/latest/APIReference/API_CompleteMigration.html){:target="_blank"} API 操作。 | 布尔值 |
| `Reclaimed`                                      | 密钥过期事件的总数。这是根据 [Redis INFO](http://redis.io/commands/info){:target="_blank"} 中的 `expired_keys` 统计数据得出的。 | 计数   |
| `ReplicationBytes`                               | 对于重复配置中的节点，`ReplicationBytes` 报告主项向其所有副本发送的字节数。此指标代表复制组上的写入负载。这是根据 [Redis INFO](http://redis.io/commands/info){:target="_blank"} 中的 `master_repl_offset` 统计数据得出的。 | 字节   |
| `ReplicationLag`                                 | 该指标仅适用于作为只读副本运行的节点。它代表副本在应用主节点的改动方面滞后的时间（以秒为单位）。对于 Redis 引擎版本 5.0.6 和更高版本，滞后以毫秒计。 | 秒     |
| `SaveInProgress`                                 | 只要背景保存（forked 或 forkless）在进行中，此二进制指标均返回 1，否则会返回 0。在快照和同步期间，通常使用背景保存进程。这些操作会导致性能下降。使用 `SaveInProgress` 指标，您可以诊断性能下降是否由背景保存进程造成。这是根据 [Redis INFO](http://redis.io/commands/info){:target="_blank"} 中的 `rdb_bgsave_in_progress` 统计数据得出的。 | 布尔值 |
| `TrafficManagementActive`                        | 指示 ElastiCache for Redis 是否通过调整分配给传入命令、监控或复制的流量来主动管理流量。当发送到节点的命令多于 Redis 可以处理的命令时，流量就会受到管理，并用于保持引擎的稳定性和最佳运行状态。任何为 1 的数据点都可能表示节点对于所提供的工作负载而言规模过小。注意如果此指标持续处于活动状态，请评估集群以确定是否需要纵向扩展或横向扩展。相关指标包括 `NetworkBandwidthOutAllowanceExceeded` 和 `EngineCPUUtilization`。 | 布尔值 |

## 对象 {#object}

采集到的亚马逊 AWS ElastiCache Redis对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aws_elasticache",
  "tags": {
    "name"                     : "test",
    "CacheClusterId"           : "test",
    "CacheNodeType"            : "cache.t3.small",
    "Engine"                   : "redis",
    "EngineVersion"            : "6.2.5",
    "CacheClusterStatus"       : " available",
    "PreferredAvailabilityZone": "cn-northwest-1b",
    "ARN"                      : "arn:aws-cn:elasticache:cn-northwest-1:5881335135:cluster:test",
    "RegionId"                 : "cn-north-1"
  },
  "fields": {
    "SecurityGroups": "{安全组 JSON 数据}}",
    "NumCacheNodes" : "1",
    "message"       : "{实例 JSON 数据}"
  }
}
```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
>
> 提示 2：`fields.message`，`fields.network_interfaces`，`fields.blockdevicemappings`为 JSON 序列化后字符串
