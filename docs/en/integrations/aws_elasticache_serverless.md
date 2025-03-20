---
title: 'AWS ElastiCache Serverless'
tags: 
  - AWS
summary: 'Use the script packages in the "<<< custom_key.brand_name >>> Cloud Sync" series from the Script Market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>'
__int_icon: 'icon/aws_elasticache_serverless'
dashboard:
  - desc: 'AWS ElastiCache Serverless'
    path: 'dashboard/en/aws_elasticache_serverless'
---


<!-- markdownlint-disable MD025 -->
# AWS ElastiCache Serverless
<!-- markdownlint-enable -->


Use the script packages in the "<<< custom_key.brand_name >>> Cloud Sync" series from the Script Market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>


## Configuration {#config}

### Install Func

It is recommended to enable the <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with the script installation

If you deploy Func on your own, refer to [Self-deploy Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Please prepare a qualified Amazon AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data of AWS ElastiCache Serverless cloud resources, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (AWS-ElastiCache Collection)" (ID: `guance_aws_elasticache_serverless`)

After clicking 【Install】, enter the corresponding parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute it once without waiting for the scheduled time. After a while, you can view the execution task records and corresponding logs.

We default to collecting some configurations, for details, see the Metrics section [Customize Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration, and at the same time, you can check the corresponding task records and logs for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, in "Infrastructure / Custom", check if there is any asset information.
3. On the <<< custom_key.brand_name >>> platform, in "Metrics", check if there is any corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon - Cloud Monitoring, the default metric set is as follows, more metrics can be collected through configuration [Amazon Cloud Monitoring Metric Details](https://docs.aws.amazon.com/en_us/AmazonElastiCache/latest/red-ug/serverless-metrics.html){:target="_blank"}

### Serverless Cache Metrics
|Metrics |Description |Unit|
| -- | -- | -- |
|BytesUsedForCache | Total number of bytes used by data stored in the cache.|bytes|
|ElastiCacheProcessingUnits|Total number of `lastiCacheProcessingUnits` (`ECPU`) consumed executing requests on the cache|count|
|SuccessfulReadRequestLatency|Latency of successful read requests.|microseconds|
|SuccessfulWriteRequestLatency|Latency of successful write requests|microseconds|
|`TotalCmdsCount`|Total number of all commands executed in the cache|count|
|`CacheHitRate`|Represents the cache hit rate. This is calculated using the cache_hits and cache_misses statistics as follows: cache_hits /(cache_hits + cache_misses).|percentage|
|`CacheHits`|Number of successful read-only key lookups in the cache.|count|
|`CurrConnections`|Number of client connections to the cache.|count|
|`ThrottledCmds`|Number of requests throttled by ElastiCache because the workload expanded faster than ElastiCache could expand.|count|
|NewConnections|Total number of connections accepted by the server during this period.|count|
|`CurrItems`|Number of items in the cache.|count|
|`CurrVolatileItems`|Number of items in the cache with TTL.|count|
|NetworkBytesIn|Total number of bytes transmitted to the cache|bytes|
|NetworkBytesOut|Total number of bytes transmitted out of the cache|bytes|
|IamAuthenticationExpirations|Total number of expired IAM-authenticated Redis connections. You can find more information about authenticating with IAM in the user guide.|count|
|IamAuthenticationThrottling|Total number of throttled IAM-authenticated Redis AUTH or HELLO requests. You can find more information about authenticating with IAM in the user guide.|count|
|KeyAuthorizationFailures|Number of failed attempts by users to access keys they do not have permission to access. We recommend setting an alarm for this to detect unauthorized access attempts.|count|
|AuthenticationFailures|Total number of failed authentication attempts using the AUTH command to authenticate with Redis. We recommend setting an alarm for this to detect unauthorized access attempts.|count|
|CommandAuthorizationFailures|Number of failed attempts by users to run commands they do not have permission to call. We recommend setting an alarm for this to detect unauthorized access attempts.|count|

## Objects {#object}

The structure of the AWS ElastiCache Serverless object data collected from Amazon, which can be viewed under "Infrastructure - Custom"

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

> *Note: The fields in `tags` and `fields` may change with subsequent updates*
>
> Note 1: The value of `tags.name` is the instance ID, used as unique identification
>
> Note 2: `fields.message`, `fields.network_interfaces`, `fields.blockdevicemappings` are JSON serialized strings