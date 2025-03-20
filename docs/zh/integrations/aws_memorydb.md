---
title: 'AWS MemoryDB'
tags: 
  - AWS
summary: '使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>'
__int_icon: 'icon/aws_memorydb'
dashboard:

  - desc: 'AWS MemoryDB 内置视图'
    path: 'dashboard/zh/aws_memorydb'

monitor:
  - desc: 'AWS MemoryDB 监控器'
    path: 'monitor/zh/aws_memorydb'

---

<!-- markdownlint-disable MD025 -->

# AWS MemoryDB
<!-- markdownlint-enable -->

使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>


## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考[自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 MemoryDB 云资源的监控数据，我们安装对应的采集脚本：「<<< custom_key.brand_name >>>集成（AWS MemoryDB采集）」(ID：`guance_aws_memorydb`)

点击【安装】后，输入相应的参数：亚马逊 AK、亚马逊账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好亚马逊-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [亚马逊云监控指标详情](https://docs.aws.amazon.com/zh_cn/memorydb/latest/devguide/metrics.memorydb.html){:target="_blank"}

| 指标                    | 描述                                                          |单位     |
| :---------------------- | :----------------------------------------------------------- |:------- |
| `ActiveDefragHits`                  | 活动碎片整理进程每分钟执行的值重新分配数。这是从 [Redis INFO](http://redis.io/commands/info) 的 `active_defrag_hits` 统计数据中得出的。 | 数字       |
| `AuthenticationFailures` | 使用 AUTH 命令向 Redis 进行身份验证的失败尝试总次数。您可以使用 [ACL LOG](https://redis.io/commands/acl-log) 命令查找有关个人身份验证失败的更多信息。我们建议为此设置告警以检测未经授权的访问尝试。 |计数|
| `BytesUsedForMemoryDB` | MemoryDB 为所有目的（包括数据集、缓冲区等）分配的字节的总数。 |字节|
| `CommandAuthorizationFailures` | 用户运行其无权限调用的命令的失败尝试次数。您可以使用 [ACL LOG](https://redis.io/commands/acl-log) 命令查找有关个人身份验证失败的更多信息。我们建议为此设置告警以检测未经授权的访问尝试。 |计数|
| `CurrConnections` | 客户端连接数，不包括来自只读副本的连接。MemoryDB 使用两到四个连接来监控各种情况下的集群。这是根据 [Redis INFO](http://redis.io/commands/info) 中的 `connected_clients` 统计数据得出的。 |计数|
| `CurrItems` | 缓存中的项目数。此值根据以下方法获得的 Redis `keyspace` 统计数据得出：计算整个密钥空间中所有密钥的总和。 |计数|
| `DatabaseMemoryUsagePercentage` | 正在使用的集群的可用内存的百分比。这是使用 `used_memory/maxmemory` 从 [Redis INFO](http://redis.io/commands/info) 计算得来的。 |百分比|
| `EngineCPUUtilization` | 提供 Redis 引擎线程的 CPU 使用率。由于 Redis 是单线程的，您可以使用该指标来分析 Redis 进程本身的负载。`EngineCPUUtilization` 指标更精确地呈现了 Redis 流程。您可以将其与 `CPUUtilization` 指标配合使用。`CPUUtilization` 公开服务器实例整体的 CPU 使用率，包括其他操作系统和管理流程。对于有四个或更多 vCPU 的较大节点类型，可使用 `EngineCPUUtilization` 指标来监控和设置扩展阈值。注意在 MemoryDB 主机上，后台进程将监控主机以提供托管式数据库体验。这些后台进程可能会占用很大一部分 CPU 工作负载。这在具有两个以上 vCPU 的大型主机上影响不大，但在 vCPU 个数不超过 2 个的小型主机上影响较大。如果仅监控 `EngineCPUUtilization` 指标，您将无法发现因 Redis 或后台监控进程的 CPU 使用率过高而导致主机过载情况。因此，我们建议对于具有不超过两个 vCPU 的主机，还需要监控 `CPUUtilization` 指标。 |百分比|
| `Evictions` | 由于 `maxmemory` 限制而被驱逐的密钥数。这是根据 [Redis INFO](http://redis.io/commands/info) 中的 `evicted_keys` 统计数据得出的。 |计数|
| `IsPrimary` | 指示节点是否为当前分区的主节点。指标可以是 0（非主节点）或 1（主节点）。 |计数|
| `KeyAuthorizationFailures` | 用户访问其无权限访问的密钥的失败尝试次数。您可以使用 [ACL LOG](https://redis.io/commands/acl-log) 命令查找有关个人身份验证失败的更多信息。我们建议为此设置告警以检测未经授权的访问尝试。 |计数|
| `KeyspaceHits` | 主字典中成功的只读键查找次数。这是从 [Redis INFO](http://redis.io/commands/info) 的 `keyspace_hits` 统计数据中得出的。 |计数|
| `KeyspaceMisses` | 主字典中失败的只读键查找次数。这是从 [Redis INFO](http://redis.io/commands/info) 的 `keyspace_misses` 统计数据中得出的。 |计数|
| `KeysTracked` | Redis 密钥跟踪所跟踪的密钥数所占 `tracking-table-max-keys` 的百分比。密钥跟踪用于帮助客户端侧缓存，并在修改密钥时通知客户端。 |计数|
| `MaxReplicationThroughput` | 在上一个测量周期内观察到的最大复制吞吐量。 |每秒字节数|
| `MemoryFragmentationRatio` | 指示 Redis 引擎的内存分配的效率。某些阈值将表示不同的行为。建议的值是让碎片化大于 1.0。这是根据 [Redis INFO](http://redis.io/commands/info) 中的 `mem_fragmentation_ratio statistic` 计算得来的。 |数字|
| `NewConnections` | 在此期间，服务器接受的连接总数。这是根据 [Redis INFO](http://redis.io/commands/info) 中的 `total_connections_received` 统计数据得出的。 |计数|
| `PrimaryLinkHealthStatus` | 此状态有两个值：0 或 1。值为 0 表示 MemoryDB 主节点中的数据未与 EC2 上的 Redis 同步。值为 1 表示数据已同步。 |布尔值|
| `Reclaimed` | 密钥过期事件的总数。这是根据 [Redis INFO](http://redis.io/commands/info) 中的 `expired_keys` 统计数据得出的。 |计数|
| `ReplicationBytes` | 对于重复配置中的节点，`ReplicationBytes` 报告主项向其所有副本发送的字节数。此指标表示集群上的写入负载。这是根据 [Redis INFO](http://redis.io/commands/info) 中的 `master_repl_offset` 统计数据得出的。 |字节|
| `ReplicationDelayedWriteCommands` | 由于超过最大复制吞吐量而延迟的命令数量。 |计数|
| `ReplicationLag`                    | 该指标仅适用于作为只读副本运行的节点。它代表副本在应用主节点的改动方面滞后的时间（以秒为单位）。 |秒|
| `CPUUtilization`                    | 整个主机的 CPU 使用率百分比。因为 Redis 是单线程的，我们建议您监控具有 4 个或更多 vCPUs 的节点的`EngineCPUUtilization`指标。 | 百分比     |
| `FreeableMemory`                    | 主机上可用的闲置内存量。这是从 RAM、缓冲区中派生出来的，操作系统报告为空闲状态。 | 字节       |
| `NetworkBytesIn`                    | 主机已从网络读取的字节数。                                   | 字节       |
| `NetworkBytesOut`                   | 实例在所有网络接口上发送的字节数。                           |字节|
| `NetworkConntrackAllowanceExceeded` | 由于连接跟踪超过实例的最大值且无法建立新连接而形成的数据包的数量。这可能会导致进出实例的流量丢失数据包。 |计数|
| `SwapUsage` | 主机上的交换区使用量。 |字节|


## 对象 {#object}

采集到的AWS MemoryDB 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aws_memorydb",
  "tags": {
    "RegionId"              : "cn-north-1",
    "Status"                : "xxxx",
    "ClusterName"           : "xxxxxx",
    "AvailabilityMode"      : "xxxxxx",
    "NodeType"              : "xxxxxx",
    "EngineVersion"         : "xxxxxx",
    "EnginePatchVersion"    : "xxxxxx",
    "ParameterGroupName"    : "xxxxxx",
    "ParameterGroupStatus"  : "xxxxxx",
    "ARN"                   : "arn:aws-cn:kms:cn-northwest-1:xxxx",
    "SnsTopicStatus"        : "xxxxxx",
    "SnsTopicArn"           : "xxxxxx",
    "MaintenanceWindow"     : "xxxxxx",
    "SnapshotWindow"        : "xxxxxx",
    "ACLName"               : "xxxxxx",
    "name"                  : "xxxxxx"
  },
  "fields": {
    "Description": "xxxxxx",
    "SecurityGroups": "xxxxxx",
    "NumberOfShards": "xxxxxx",
    "TLSEnabled": "xxxxxx",
    "SnapshotRetentionLimit": "xxxxxx",
    "AutoMinorVersionUpgrade": "xxxxxx",
    "NumberOfShards" : "1",
    "message"     : "{实例 JSON 数据}"
  }
}
```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
