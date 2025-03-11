---
title: 'AWS ElastiCache Redis'
tags: 
  - AWS
summary: 'Use the script market "Guance Cloud Sync" series script packages to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/aws_elasticache_redis'
dashboard:

  - desc: 'Built-in views for AWS ElastiCache Redis'
    path: 'dashboard/en/aws_elasticache_redis'

monitor:
  - desc: 'AWS ElastiCache Redis monitor'
    path: 'monitor/en/aws_elasticache_redis'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_elasticache_redis'
---


<!-- markdownlint-disable MD025 -->
# AWS ElastiCache Redis
<!-- markdownlint-enable -->


Use the script market "Guance Cloud Sync" series script packages to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data of AWS ElastiCache Redis cloud resources, install the corresponding collection script: "Guance Integration (AWS-ElastiCache Collection)" (ID: `guance_aws_elasticache`)

After clicking [Install], enter the corresponding parameters: Amazon AK, Amazon account name.

Click [Deploy Startup Script], and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Additionally, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click [Execute] to immediately execute it once without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations; for more details, see [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any abnormalities.
2. On the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric set is as follows. You can collect more metrics through configuration [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/AmazonElastiCache/latest/red-ug/CacheMetrics.html){:target="_blank"}

### Host-level Metrics

| Metric Name | Description | Unit | Dimensions |
| :---: | :---: | :---: | :---: |
| CPUUtilization | The percentage of CPU utilization across the host | % | name |
| FreeableMemory | The amount of available idle memory on the host. This is derived from RAM reported as free by the operating system, buffers, and caches. | byte | name |
| SwapUsage | The amount of swap space used on the host. | byte | name |
| NetworkBytesIn | The number of bytes read from the network by the host. | byte | name |
| NetworkBytesOut | The number of bytes sent over all network interfaces by the instance. | byte | name |
| NetworkPacketsIn | The number of packets received over all network interfaces by the instance. This metric identifies the volume of incoming traffic based on the number of packets on a single instance. | count | name |
| NetworkPacketsOut | The number of packets sent over all network interfaces by the instance. This metric identifies the volume of outgoing traffic based on the number of packets on a single instance. | count | name |

### Redis Metrics

| Metric Name | Description | Unit | Dimensions |
| :---: | :---: | :---: | :---: |
| `ActiveDefragHits` | The number of value reassignments performed per minute by the active defragmentation process. | count | name |
| `BytesUsedForCache` | The total number of bytes used for caching in memory. | byte | name |
| `CacheHits` | The number of successful read-only key lookups in the main dictionary. | count | name |
| `CacheMisses` | The number of failed read-only key lookups in the main dictionary. | count | name |
| `CurrConnections` | The number of client connections, excluding connections from read-only replicas. | count | name |
| `CurrItems` | The number of items in the cache. | count | name |
| `CurrVolatileItems` | The total number of keys with TTL set across all databases. | count | name |
| `DatabaseCapacityUsagePercentage` | The percentage of the cluster's total data capacity currently in use. | % | name |
| `DatabaseMemoryUsagePercentage` | The percentage of memory currently in use within the cluster. | % | name |
| `EngineCPUUtilization` | Provides the CPU utilization of the Redis engine threads. | % | name |
| `Evictions` | The number of keys evicted due to the `maxmemory` limit. | count | name |
| `IsMaster` | Indicates whether the node is the master node for the current shard/cluster. The metric can be 0 (not master) or 1 (master). | count | name |
| `MasterLinkHealthStatus` | This status has two values: 0 or 1. A value of 0 indicates that the data in the Elasticache master node has not synchronized with Redis on EC2. A value of 1 indicates that the data has been synchronized. | count | name |
| `MemoryFragmentationRatio` | Indicates the efficiency of memory allocation by the Redis engine. | count | name |

## Objects {#object}

The structure of collected AWS ElastiCache Redis object data can be viewed in "Infrastructure - Custom"

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
    "SecurityGroups": "{JSON security group data}",
    "NumCacheNodes" : "1",
    "message"       : "{JSON instance data}"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Note 1: The value of `tags.name` is the instance ID, used as a unique identifier.
>
> Note 2: `fields.message`, `fields.network_interfaces`, `fields.blockdevicemappings` are JSON serialized strings.
