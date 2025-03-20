---
title: 'AWS ElastiCache Redis'
tags: 
  - AWS
summary: '使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>'
__int_icon: 'icon/aws_elasticache_redis'
dashboard:

  - desc: 'AWS ElastiCache Redis内置视图'
    path: 'dashboard/zh/aws_elasticache_redis'

monitor:
  - desc: 'AWS ElastiCache Redis监控器'
    path: 'monitor/zh/aws_elasticache_redis'

cloudCollector:
  desc: '云采集器'
  path: 'cloud-collector/zh/aws_elasticache_redis'
---


<!-- markdownlint-disable MD025 -->
# AWS ElastiCache Redis
<!-- markdownlint-enable -->


使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>


## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考[自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 AWS ElastiCache Redis 云资源的监控数据，我们安装对应的采集脚本：「<<< custom_key.brand_name >>>集成（AWS-ElastiCache采集）」(ID：`guance_aws_elasticache`)

点击【安装】后，输入相应的参数：亚马逊 AK、亚马逊账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好亚马逊-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [亚马逊云监控指标详情](https://docs.aws.amazon.com/zh_cn/AmazonElastiCache/latest/red-ug/CacheMetrics.html){:target="_blank"}

### 主机级指标

| 指标名称 | 描述 | 单位 | 维度 |
| :---: | :---: | :---: | :---: |
| CPUUtilization | 整个主机的 CPU 使用率百分比 | % | name |
| FreeableMemory | 主机上可用的闲置内存量。这是从操作系统报告为空闲的 RAM、缓冲区和缓存中派生出来的。 | byte | name |
| SwapUsage | 主机上的交换区使用量。 | byte | name |
| NetworkBytesIn | 主机已从网络读取的字节数。 | byte | name |
| NetworkBytesOut | 实例在所有网络接口上发送的字节数。 | byte | name |
| NetworkPacketsIn | 实例在所有网络接口上收到的数据包的数量。此指标依据单个实例上的数据包数量来标识传入流量的量。 | count | name |
| NetworkPacketsOut | 实例在所有网络接口上发送的数据包的数量。此指标依据单个实例上的数据包数量标识传出流量的量。 | count | name |

### Redis的指标

| 指标名称 | 描述 | 单位 | 维度 |
| :---: | :---: | :---: | :---: |
| `ActiveDefragHits` | 活动碎片整理进程每分钟执行的值重新分配数。 | count | name |
| `BytesUsedForCache` | 内存中用于缓存的总字节数。 | byte | name |
| `CacheHits` | 主字典中成功的只读键查找次数。 | count | name |
| `CacheMisses` | 主字典中失败的只读键查找次数。 | count | name |
| `CurrConnections` | 客户端连接数，不包括来自只读副本的连接。 | count | name |
| `CurrItems` | 缓存中的项目数。 | count | name |
| `CurrVolatileItems` | 所有数据库中具有 ttl 集的键的总数。 | count | name |
| `DatabaseCapacityUsagePercentage` | 集群的总数据容量中正在使用的百分比。 | % | name |
| `DatabaseMemoryUsagePercentage` | 集群中正在使用的内存的百分比。 | % | name |
| `EngineCPUUtilization` | 提供 Redis 引擎线程的 CPU 使用率。 | % | name |
| `Evictions` | 由于 `maxmemory` 限制而被驱逐的密钥数。 | count | name |
| `IsMaster` | 指示节点是否为当前分片/集群的主节点。指标可以是 0（非主节点）或 1（主节点）。 | count | name |
| `MasterLinkHealthStatus` | 此状态有两个值：0 或 1。值为 0 表示 Elasticache 主节点中的数据未与 EC2 上的 Redis 同步。值为 1 表示数据已同步。 | count | name |
| `MemoryFragmentationRatio` | 指示 Redis 引擎的内存分配的效率。 | count | name |

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
