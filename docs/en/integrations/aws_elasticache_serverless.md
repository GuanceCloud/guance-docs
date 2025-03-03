---
title: 'AWS ElastiCache Serverless'
tags: 
  - AWS
summary: 'Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.'
__int_icon: 'icon/aws_elasticache_serverless'
dashboard:
  - desc: 'AWS ElastiCache Serverless'
    path: 'dashboard/en/aws_elasticache_serverless'
---


<!-- markdownlint-disable MD025 -->
# AWS ElastiCache Serverless
<!-- markdownlint-enable -->

Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,[Refer to](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare AWS AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of ElastiCache Redis cloud resources, we install the corresponding collection script：「Guance Integration（AWS-elasticache-serverless Collect）」(ID：`guance_aws_elasticache_serverless`)

Click 【Install】 and enter the corresponding parameters: AWS AK, AWS account name.

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」.Click[Run],you can immediately execute once, without waiting for a regular time.After a while,you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

Configure AWS Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/AmazonElastiCache/latest/red-ug/serverless-metrics.html){:target="_blank"}

### Serverless Metrics
| metric name | descriptive | unit |
| -- | -- | -- |
|BytesUsedForCache|The total number of bytes used by the data stored in your cache.|Bytes|
|ElastiCacheProcessingUnits|The total number of lastCacheProcessingUnits (`ECPU`) consumed by executing requests on the cache|Count|
|SuccessfulReadRequestLatency|Delay in successfully reading requests.|Microseconds|
|SuccessfulWriteRequestLatency|Delay in successfully writing requests|Microseconds|
|`TotalCmdsCount`|The total number of all commands executed in the cache|Count|
|`CacheHitRate`|Indicates the hit rate of the cache. This is calculated using the cache_hits and cache_misses statistics Count data as follows：cache_hits /(cache_hits + cache_misses).|Percent|
|`CacheHits`|Number of successful read-only key lookups in cache.|Count|
|`CurrConnections`|Number of cached client connections.|Count|
|`ThrottledCmds`|The number of requests throttled by ElastiCache due to the workload scaling speed exceeding the speed that ElastiCache can scale.|Count|
|NewConnections|The total number of connections accepted by the server during this period.|Count|
|`CurrItems`|Number of items in cache.|Count|
|`CurrVolatileItems`|Number of items in cache with TTL.|Count|
|NetworkBytesIn|Total bytes transferred in to cache|Bytes|
|NetworkBytesOut|Total bytes transferred out of cache|Bytes|
|IamAuthenticationExpirations|The total number of expired Redis connections authenticated by IAM. You can find more information about using IAM for authentication in the user guide.|Count|
|IamAuthenticationThrottling|The total number of throttled IAM-authenticated Redis AUTH or HELLO requests. You can find more information about Authenticating with IAM in the user guide.|Count|
|KeyAuthorizationFailures|The total number of failed attempts by users to access keys they don’t have permission to access. We suggest setting an alarm on this to detect unauthorized access attempts.|Count|
|The total number of failed attempts to authenticate to Redis using the AUTH command. We suggest setting an alarm on this to detect unauthorized access attempts.|Count|
|CommandAuthorizationFailures|The total number of failed attempts by users to run commands they don’t have permission to call. We suggest setting an alarm on this to detect unauthorized access attempts.|Count|

## Object {#object}

Collected AWS ElastiCache Redis object data structure, you can see the object data from the "Infrastructure - Customize"

```json
{
    "category": "custom_object",
    "fields": {
      "CreateTime": "2024-04-10T02:45:41.921000Z",
      "DailySnapshotTime": "00:00",
      "Description": " ",
      "Endpoint": "{\"Address\": \"test-es-serverless-xxxx.serverless.cnw1.cache.amazonaws.com.cn\", \"Port\": 6379}",
      "ReaderEndpoint": "{\"Address\": \"test-es-serverless-xxxx.serverless.cnw1.cache.amazonaws.com.cn\", \"Port\": 6380}",
      "SecurityGroupIds": "[\"sg-099fc30041cxxxx\"]",
      "SubnetIds": "",
      "message": {}
    },
    "measurement": "aws_elasticache",
    "tags": {
      "ARN": "arn:aws-cn:elasticache:cn-northwest-1:xxxxx:serverlesscache:test-es-serverless",
      "Engine": "redis",
      "FullEngineVersion": "7.1",
      "MajorEngineVersion": "7",
      "RegionId": "cn-northwest-1",
      "ServerlessCacheName": "test-es-serverless",
      "Status": "available",
      "name": "test-es-serverless"
    }
  }
```

> *Note: Fields in `tags`, `fields` are subject to change with subsequent updates.*
>
> Tip 1: The `tags.name` value is the instance ID, which serves as a unique identifier.
> Tip 2: `fields.message`, `fields.NetworkInterfaces`, and `fields.BlockDeviceMappings` are JSON serialized strings.
