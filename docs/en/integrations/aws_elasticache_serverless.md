---
title: 'AWS ElastiCache Serverless'
tags: 
  - AWS
summary: 'Use the script packages in the Script Market of Guance to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/aws_elasticache_serverless'
dashboard:
  - desc: 'AWS ElastiCache Serverless'
    path: 'dashboard/en/aws_elasticache_serverless'
---


<!-- markdownlint-disable MD025 -->
# AWS ElastiCache Serverless
<!-- markdownlint-enable -->


Use the script packages in the Script Market of Guance to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable the hosted version of Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data from AWS ElastiCache Serverless cloud resources, install the corresponding collection script: "Guance Integration (AWS-ElastiCache Collection)" (ID: `guance_aws_elasticache_serverless`)

After clicking 【Install】, enter the required parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Additionally, you can see the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations; for more details, see [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. Confirm in 「Manage / Automatic Trigger Configuration」that the corresponding task has the automatic trigger configuration. You can also check the task records and logs for any anomalies.
2. In the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. In the Guance platform, under 「Metrics」, check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric set is as follows. More metrics can be collected through configuration. [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/AmazonElastiCache/latest/red-ug/serverless-metrics.html){:target="_blank"}

### Serverless Cache Metrics
| Metric | Description | Unit |
| --- | --- | --- |
| BytesUsedForCache | Total number of bytes used by data stored in the cache. | Bytes |
| ElastiCacheProcessingUnits | Total number of ElastiCache Processing Units (`ECPU`) consumed by requests on the cache. | Count |
| SuccessfulReadRequestLatency | Latency of successful read requests. | Microseconds |
| SuccessfulWriteRequestLatency | Latency of successful write requests. | Microseconds |
| `TotalCmdsCount` | Total number of commands executed on the cache. | Count |
| `CacheHitRate` | Represents the cache hit rate. This is calculated using cache_hits and cache_misses as follows: cache_hits /(cache_hits + cache_misses). | Percentage |
| `CacheHits` | Number of successful read-only key lookups in the cache. | Count |
| `CurrConnections` | Number of client connections to the cache. | Count |
| `ThrottledCmds` | Number of requests throttled by ElastiCache due to the workload expanding faster than ElastiCache can scale. | Count |
| NewConnections | Total number of connections accepted by the server during this period. | Count |
| `CurrItems` | Number of items in the cache. | Count |
| `CurrVolatileItems` | Number of items in the cache with TTL. | Count |
| NetworkBytesIn | Total number of bytes transmitted to the cache. | Bytes |
| NetworkBytesOut | Total number of bytes transmitted from the cache. | Bytes |
| IamAuthenticationExpirations | Total number of expired IAM-authenticated Redis connections. For more information about authenticating with IAM, see the user guide. | Count |
| IamAuthenticationThrottling | Total number of throttled IAM-authenticated Redis AUTH or HELLO requests. For more information about authenticating with IAM, see the user guide. | Count |
| KeyAuthorizationFailures | Number of failed attempts to access keys that the user does not have permission to access. We recommend setting up alerts to detect unauthorized access attempts. | Count |
| AuthenticationFailures | Total number of failed authentication attempts using the AUTH command to authenticate with Redis. We recommend setting up alerts to detect unauthorized access attempts. | Count |
| CommandAuthorizationFailures | Number of failed attempts to run commands that the user does not have permission to call. We recommend setting up alerts to detect unauthorized access attempts. | Count |

## Objects {#object}

Data structure of the collected AWS ElastiCache Serverless objects can be viewed under 「Infrastructure - Custom」

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

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Note 1: The value of `tags.name` is the instance ID, used for unique identification.
>
> Note 2: `fields.message`, `fields.network_interfaces`, `fields.blockdevicemappings` are JSON serialized strings.
