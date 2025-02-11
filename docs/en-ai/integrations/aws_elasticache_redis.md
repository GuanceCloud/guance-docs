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

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data of AWS ElastiCache Redis cloud resources, we install the corresponding collection script: "Guance Integration (AWS-ElastiCache Collection)" (ID: `guance_aws_elasticache`)

After clicking 【Install】, enter the corresponding parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Additionally, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click 【Execute】to immediately execute once without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

We collect some configurations by default; for more details, see the metrics section [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. Confirm in "Management / Automatic Trigger Configuration" whether the corresponding task has the automatic trigger configuration, and check the task records and logs for any anomalies.
2. In the Guance platform, check if there is asset information under "Infrastructure / Custom".
3. In the Guance platform, check if there is corresponding monitoring data under "Metrics".

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric set is as follows. You can collect more metrics through configuration [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/AmazonElastiCache/latest/red-ug/CacheMetrics.html){:target="_blank"}

### Host-level Metrics

| Metric Name | Description | Unit | Dimensions |
| :---: | :---: | :---: | :---: |
| CPUUtilization | Percentage of CPU utilization across the host | % | name |
| FreeableMemory | Amount of idle memory available on the host. Derived from RAM reported as free by the OS, buffers, and caches. | byte | name |
| SwapUsage | Amount of swap space used on the host. | byte | name |
| NetworkBytesIn | Number of bytes read from the network by the host. | byte | name |
| NetworkBytesOut | Number of bytes sent by the instance over all network interfaces. | byte | name |
| NetworkPacketsIn | Number of packets received by the instance over all network interfaces. This metric identifies the volume of incoming traffic based on packet count per instance. | count | name |
| NetworkPacketsOut | Number of packets sent by the instance over all network interfaces. This metric identifies the volume of outgoing traffic based on packet count per instance. | count | name |

### Redis Metrics

| Metric Name | Description | Unit | Dimensions |
| :---: | :---: | :---: | :---: |
| `ActiveDefragHits` | Number of value reassignments performed by the active defragmentation process per minute. | count | name |
| `BytesUsedForCache` | Total number of bytes used for caching in memory. | byte | name |
| `CacheHits` | Number of successful read-only key lookups in the main dictionary. | count | name |
| `CacheMisses` | Number of failed read-only key lookups in the main dictionary. | count | name |
| `CurrConnections` | Number of client connections excluding connections from read-only replicas. | count | name |
| `CurrItems` | Number of items in the cache. | count | name |
| `CurrVolatileItems` | Total number of keys with TTL set across all databases. | count | name |
| `DatabaseCapacityUsagePercentage` | Percentage of total data capacity in use within the cluster. | % | name |
| `DatabaseMemoryUsagePercentage` | Percentage of memory in use within the cluster. | % | name |
| `EngineCPUUtilization` | CPU utilization of Redis engine threads. | % | name |
| `Evictions` | Number of keys evicted due to `maxmemory` limit. | count | name |
| `IsMaster` | Indicates whether the node is the primary node of the current shard/cluster. The metric can be 0 (not primary) or 1 (primary). | count | name |
| `MasterLinkHealthStatus` | This status has two values: 0 or 1. A value of 0 indicates that data in the ElastiCache master node has not synchronized with Redis on EC2. A value of 1 indicates that the data has synchronized. | count | name |
| `MemoryFragmentationRatio` | Indicates the efficiency of memory allocation by the Redis engine. | count | name |

## Objects {#object}

The collected AWS ElastiCache Redis object data structure from Amazon can be viewed under "Infrastructure - Custom"

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

> *Note: Fields in `tags`, `fields` may change with subsequent updates*
>
> Note 1: The value of `tags.name` is the instance ID, used for unique identification
>
> Note 2: `fields.message`, `fields.network_interfaces`, `fields.blockdevicemappings` are JSON serialized strings