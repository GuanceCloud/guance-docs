---
title: 'AWS ElastiCache Redis'
tags: 
  - AWS
summary: 'Use the script package series of "<<< custom_key.brand_name >>> Cloud Sync" in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>'
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


Use the script package series of "<<< custom_key.brand_name >>> Cloud Sync" in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>


## Configuration {#config}

### Install Func

It is recommended to activate <<< custom_key.brand_name >>> Integration - Extension - Managed Func: All prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

#### Managed Edition Activation Script

1. Log in to <<< custom_key.brand_name >>> Console
2. Click on the 【Manage】 menu, select 【Cloud Account Management】
3. Click 【Add Cloud Account】, select 【AWS】, fill in the required information on the interface. If the cloud account information has been configured before, skip this step.
4. Click 【Test】, after the test succeeds, click 【Save】. If the test fails, check whether the related configuration information is correct and retest.
5. Click on the 【Cloud Account Management】 list to see the added cloud account. Click on the corresponding cloud account to enter the details page.
6. Click the 【Integration】 button on the cloud account detail page. In the `Not Installed` list, find `AWS ElastiCache Redis`, click the 【Install】 button, and the installation interface will pop up for installation.

#### Manual Activation Script

1. Log in to the Func console, click 【Script Market】, enter the official script market, and search for `guance_aws_elasticache`

2. After clicking 【Install】, input the corresponding parameters: AWS AK ID, AK Secret, and account name.

3. Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

4. After enabling, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the regular time. Wait a moment, and you can view the execution task records and corresponding logs.


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration, and at the same time, you can view the corresponding task records and logs to check for any abnormalities.
2. In <<< custom_key.brand_name >>>, under "Infrastructure / Custom", check if there is any asset information.
3. In <<< custom_key.brand_name >>>, under "Metrics", check if there are any corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon-Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration. [Amazon Cloud Monitoring Metric Details](https://docs.aws.amazon.com/en_us/AmazonElastiCache/latest/red-ug/CacheMetrics.html){:target="_blank"}

### Host-level Metrics

| Metric Name | Description | Unit | Dimension |
| :---: | :---: | :---: | :---: |
| CPUUtilization | Percentage of CPU utilization across the entire host | % | name |
| FreeableMemory | Available idle memory on the host. This is derived from RAM reported by the operating system as free, buffers, and caches. | byte | name |
| SwapUsage | Swap space usage on the host. | byte | name |
| NetworkBytesIn | Number of bytes read from the network by the host. | byte | name |
| NetworkBytesOut | Number of bytes sent over all network interfaces by the instance. | byte | name |
| NetworkPacketsIn | Number of packets received by the instance over all network interfaces. This metric identifies the volume of incoming traffic based on packet counts per single instance. | count | name |
| NetworkPacketsOut | Number of packets sent by the instance over all network interfaces. This metric identifies the volume of outgoing traffic based on packet counts per single instance. | count | name |

### Redis Metrics

| Metric Name | Description | Unit | Dimension |
| :---: | :---: | :---: | :---: |
| `ActiveDefragHits` | Number of value reassignments executed per minute by the active defragmentation process. | count | name |
| `BytesUsedForCache` | Total number of bytes used in memory for caching. | byte | name |
| `CacheHits` | Number of successful read-only key lookups in the main dictionary. | count | name |
| `CacheMisses` | Number of failed read-only key lookups in the main dictionary. | count | name |
| `CurrConnections` | Number of client connections, excluding connections from read-only replicas. | count | name |
| `CurrItems` | Number of items in the cache. | count | name |
| `CurrVolatileItems` | Total number of keys with ttl sets in all databases. | count | name |
| `DatabaseCapacityUsagePercentage` | Percentage of total data capacity in use within the cluster. | % | name |
| `DatabaseMemoryUsagePercentage` | Percentage of memory in use within the cluster. | % | name |
| `EngineCPUUtilization` | Provides CPU utilization for Redis engine threads. | % | name |
| `Evictions` | Number of keys evicted due to `maxmemory` limit. | count | name |
| `IsMaster` | Indicates whether the node is the primary node for the current shard/cluster. The metric can be 0 (non-primary) or 1 (primary). | count | name |
| `MasterLinkHealthStatus` | This status has two values: 0 or 1. A value of 0 indicates that the data in the Elasticache master node is not synchronized with Redis on EC2. A value of 1 indicates that the data is synchronized. | count | name |
| `MemoryFragmentationRatio` | Indicates the efficiency of memory allocation for the Redis engine. | count | name |

## Objects {#object}

The collected AWS ElastiCache Redis object data structure from Amazon can be viewed in "Infrastructure - Custom".

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
    "message"       : "{Instance JSON data}"
  }
}
```

> *Note: Fields in `tags`, `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, used as a unique identifier.
>
> Tip 2: `fields.message`, `fields.network_interfaces`, `fields.blockdevicemappings` are serialized JSON strings.