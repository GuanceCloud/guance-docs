---
title: 'AWS ElastiCache Redis'
tags: 
  - AWS
summary: 'Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.'
__int_icon: 'icon/aws_elasticache_redis'
dashboard:
  - desc: 'AWS ElastiCache Redis Monitoring View'
    path: 'dashboard/en/aws_elasticache_redis'
monitor:
  - desc: 'AWS ElastiCache RedisMonitor'
    path: 'monitor/en/aws_elasticache_redis'

cloudCollector:
  desc: 'cloud collector'
  path: 'cloud-collector/en/aws_elasticache_redis'
---


<!-- markdownlint-disable MD025 -->
# AWS ElastiCache Redis
<!-- markdownlint-enable -->


Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,[Refer to](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare AWS AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of ElastiCache Redis cloud resources, we install the corresponding collection script：「Guance Integration（AWS-ElastiCache Collect）」(ID：`guance_aws_elasticache`)

Click 【Install】 and enter the corresponding parameters: AWS AK, AWS account name.

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」.Click[Run],you can immediately execute once, without waiting for a regular time.After a while,you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

Configure AWS Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/AmazonElastiCache/latest/red-ug/CacheMetrics.html){:target="_blank"}

### Host-level metrics

| metric name | descriptive | unit | dimension |
| :---: | :---: | :---: | :---: |
| CPUUtilization | Percentage of CPU utilization for the entire host | % | name |
| FreeableMemory | The amount of free memory available on the host. This is derived from the RAM, buffers, and caches reported as free by the operating system. | byte | name |
| SwapUsage | The amount of switching zone usage on the host. | byte | name |
| NetworkBytesIn | The number of bytes the host has read from the network. | byte | name |
| NetworkBytesOut | The number of bytes sent by the instance on all network interfaces. | byte | name |
| NetworkPacketsIn | The number of packets received by the instance on all network interfaces. This metric identifies the amount of incoming traffic based on the number of packets on a single instance. | count | name |
| NetworkPacketsOut | The number of packets sent by the instance on all network interfaces. This metric identifies the amount of outgoing traffic based on the number of packets on a single instance. | count | name |

### Metrics for Redis

| metric name | descriptive | unit | dimension |
| :---: | :---: | :---: | :---: |
| `ActiveDefragHits` | The number of value reassignments per minute performed by the active defragmentation process. | count | name |
| BytesUsedForCache | The total number of bytes in memory used for caching. | byte | name |
| CacheHits | The number of successful read-only key lookups in the main dictionary. | count | name |
| CacheMisses | The number of failed read-only key lookups in the main dictionary. | count | name |
| `CurrConnections` | The number of client connections, excluding connections from read-only copies. | count | name |
| `CurrItems` | The number of items in the cache. | count | name |
| `CurrVolatileItems` | The total number of keys with ttl sets in all databases. | count | name |
| DatabaseCapacityUsagePercentage | The percentage of the cluster's total data capacity that is in use. | % | name |
| DatabaseMemoryUsagePercentage | The percentage of memory being used in the cluster. | % | name |
| EngineCPUUtilization | Provides the CPU utilization of the Redis engine threads. | % | name |
| Evictions | The number of keys evicted due to max memory limitations. | count | name |
| IsMaster | Indicates whether the node is the master node of the current slice/cluster. The metric can be 0 (non-master node) or 1 (master node). | count | name |
| MasterLinkHealthStatus | This status has two values: 0 or 1. A value of 0 means that the data in the Elasticache master node is not synchronized with Redis on EC2. A value of 1 means that the data has been synchronized. | count | name |
| MemoryFragmentationRatio | Indicates the efficiency of the Redis engine's memory allocation. | count | name |

## Object {#object}

Collected AWS ElastiCache Redis object data structure, you can see the object data from the "Infrastructure - Customize"

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
    "SecurityGroups": "{SecurityGroups JSON data}}",
    "NumCacheNodes" : "1",
    "message"       : "{Instance JSON data}"
  }
}
```

> *Note: Fields in `tags`, `fields` are subject to change with subsequent updates.*
>
> Tip 1: The `tags.name` value is the instance ID, which serves as a unique identifier.
> Tip 2: `fields.message`, `fields.NetworkInterfaces`, and `fields.BlockDeviceMappings` are JSON serialized strings.
