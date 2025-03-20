---
title: 'AWS ElastiCache Redis'
tags: 
  - AWS
summary: 'Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance.'
__int_icon: 'icon/aws_elasticache_redis'
dashboard:

  - desc: 'AWS ElastiCache Redis built-in views'
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


Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites will be automatically installed, please continue with the script installation.

If you deploy Func yourself, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of AWS ElastiCache Redis cloud resources, we install the corresponding collection script: "Guance Integration (AWS-ElastiCache Collection)" (ID: `guance_aws_elasticache`)

After clicking 【Install】, enter the corresponding parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the regular time. After a while, you can view the execution task records and corresponding logs.

We default collect some configurations, for details see the metrics column [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration, and at the same time, you can check the corresponding task records and logs to see if there are any abnormalities.
2. On the Guance platform, in "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, in "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
Configure Amazon - CloudWatch properly, and the default metric set is as follows. You can collect more metrics through configuration [Amazon CloudWatch Metric Details](https://docs.aws.amazon.com/zh_cn/AmazonElastiCache/latest/red-ug/CacheMetrics.html){:target="_blank"}

### HOST-level Metrics

| Metric Name | Description | Unit | Dimensions |
| :---: | :---: | :---: | :---: |
| CPUUtilization | Percentage of CPU utilization across the entire host | % | name |
| FreeableMemory | The amount of idle memory available on the host. This is derived from RAM reported by the operating system as free, buffers, and caches. | byte | name |
| SwapUsage | The amount of swap space used on the host. | byte | name |
| NetworkBytesIn | The number of bytes the host has read from the network. | byte | name |
| NetworkBytesOut | The number of bytes sent over all network interfaces by the instance. | byte | name |
| NetworkPacketsIn | The number of packets received over all network interfaces by the instance. This metric identifies the volume of incoming traffic based on packet counts per single instance. | count | name |
| NetworkPacketsOut | The number of packets sent over all network interfaces by the instance. This metric identifies the volume of outgoing traffic based on packet counts per single instance. | count | name |

### Redis Metrics

| Metric Name | Description | Unit | Dimensions |
| :---: | :---: | :---: | :---: |
| `ActiveDefragHits` | Number of value reassignments performed per minute by the active defragmentation process. | count | name |
| `BytesUsedForCache` | Total number of bytes used in memory for caching. | byte | name |
| `CacheHits` | Number of successful read-only key lookups in the main dictionary. | count | name |
| `CacheMisses` | Number of failed read-only key lookups in the main dictionary. | count | name |
| `CurrConnections` | Number of client connections, excluding connections from read-only replicas. | count | name |
| `CurrItems` | Number of items in the cache. | count | name |
| `CurrVolatileItems` | Total number of keys with ttl sets across all databases. | count | name |
| `DatabaseCapacityUsagePercentage` | Percentage of total data capacity in use within the cluster. | % | name |
| `DatabaseMemoryUsagePercentage` | Percentage of memory in use within the cluster. | % | name |
| `EngineCPUUtilization` | Provides CPU utilization for Redis engine threads. | % | name |
| `Evictions` | Number of keys evicted due to the `maxmemory` limit. | count | name |
| `IsMaster` | Indicates whether the node is the primary node for the current shard/cluster. The metric can be 0 (non-primary) or 1 (primary). | count | name |
| `MasterLinkHealthStatus` | This status has two values: 0 or 1. A value of 0 indicates that data in the Elasticache master node has not been synchronized with Redis on EC2. A value of 1 indicates that the data has been synchronized. | count | name |
| `MemoryFragmentationRatio` | Indicates the efficiency of memory allocation for the Redis engine. | count | name |

## Objects {#object}

The structure of the collected AWS ElastiCache Redis object data from Amazon, which can be seen in "Infrastructure - Custom"

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
    "SecurityGroups": "{JSON security group data}}",
    "NumCacheNodes" : "1",
    "message"       : "{JSON instance data}"
  }
}
```

> *Note: Fields in `tags`, `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, used as a unique identifier.
>
> Tip 2: `fields.message`, `fields.network_interfaces`, `fields.blockdevicemappings` are JSON serialized strings.