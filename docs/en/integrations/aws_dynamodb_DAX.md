---
title: 'AWS DynamoDB DAX'
tags: 
  - AWS
summary: 'The displayed Metrics for AWS DynamoDB DAX include CPU usage of nodes or clusters, the number of bytes received or sent on all network interfaces, the number of packets, etc. These Metrics reflect the operational status of DynamoDB DAX.'
__int_icon: 'icon/aws_dynamodb_DAX'
dashboard:

  - desc: 'Built-in Views for AWS DynamoDB DAX'
    path: 'dashboard/en/aws_dynamodb_DAX'

monitor:
  - desc: 'Monitors for AWS DynamoDB DAX'
    path: 'monitor/en/aws_dynamodb_DAX'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_dynamodb_dax'
---


<!-- markdownlint-disable MD025 -->
# AWS DynamoDB DAX
<!-- markdownlint-enable -->


The displayed Metrics for AWS DynamoDB DAX include CPU usage of nodes or clusters, the number of bytes received or sent on all network interfaces, the number of packets, etc. These Metrics reflect the operational status of DynamoDB DAX.


## Configuration {#config}

### Install Func

It is recommended to activate Guance integration - extension - DataFlux Func (Automata): All prerequisites will be automatically installed, please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare an Amazon Cloud AK that meets the requirements in advance (for simplicity, you can directly grant CloudWatch read-only permission `CloudWatchReadOnlyAccess`)

To synchronize monitoring data for AWS-DynamoDB DAX, we install the corresponding collection script: "Guance Integration (AWS-DynamoDB DAX Collection)" (ID: `guance_aws_dynamodb_dax`)

After clicking 【Install】, enter the corresponding parameters: AWS AK ID, AWS AK SECRET, account_name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script. In the startup script, ensure that 'regions' matches the actual regions where the instances are located.

Once activated, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration." Click 【Execute】 to immediately run it once without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you want to collect corresponding logs, you also need to enable the corresponding log collection script. If you want to collect billing information, you need to enable the cloud billing collection script.


We default to collecting some configurations, see the Metrics column for details [Configuration Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. Confirm in "Manage / Automatic Trigger Configuration" whether the corresponding task has the corresponding automatic trigger configuration, and you can check the corresponding task records and logs to check for any abnormalities.
2. On the Guance platform, check under "Infrastructure / Custom" whether asset information exists.
3. On the Guance platform, check under "Metrics" whether there are corresponding monitoring data.

## Metrics {#metric}

After configuring Amazon CloudWatch, the default Measurement set is as follows. You can collect more Metrics through configuration:

[Amazon CloudWatch DynamoDB Accelerator (DAX) Metrics Details](https://docs.aws.amazon.com/zh_cn/amazondynamodb/latest/developerguide/dax-metrics-dimensions-dax.html){:target="_blank"}


| Metric Name | Description | Unit | Valid Statistics |
| :---: | :---: | :---: | :---: |
| `CPUUtilization` | The percentage of CPU usage for a node or cluster. | Percent | Minimum Maximum Average |
| `CacheMemoryUtilization` | The percentage of available cache memory used by item caching and query caching on a node or cluster. Cache data begins to be evicted before memory utilization reaches 100% (see the EvictedSize Metric). If CacheMemoryUtilization reaches 100% on any node, write requests will be throttled, and you should consider switching to a cluster with larger node types. | Percent | Minimum Maximum Average  |
| `NetworkBytesIn` | The number of bytes received by a node or cluster on all network interfaces. | Bytes | Minimum Maximum Average |
| `NetworkBytesOut` | The number of bytes sent by a node or cluster on all network interfaces. This Metric identifies outgoing traffic based on the number of packets on a single instance. | Bytes | Minimum Maximum Average |
| `NetworkPacketsIn`| The number of packets received by a node or cluster on all network interfaces. | Count | Minimum Maximum Average  |
| `NetworkPacketsOut` | The number of packets sent by a node or cluster on all network interfaces. This Metric identifies outgoing traffic based on the number of packets on a single instance. | Count | Minimum Maximum Average |
| `GetItemRequestCount`| The number of GetItem requests processed by a node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `BatchGetItemRequestCount`| The number of BatchGetItem requests processed by a node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `BatchWriteItemRequestCount` | The number of BatchWriteItem requests processed by a node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `DeleteItemRequestCount` | The number of DeleteItem requests processed by a node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `PutItemRequestCount` | The number of PutItem requests processed by a node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `UpdateItemRequestCount` | The number of UpdateItem requests processed by a node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `TransactWriteItemsCount` | The number of TransactWriteItems requests processed by a node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `TransactGetItemsCount`| The number of TransactGetItems requests processed by a node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `ItemCacheHits` | The number of times items were returned from the cache by a node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `ItemCacheMisses`| The number of times an item was not in the cache of a node or cluster and had to be retrieved from DynamoDB. | Count | Minimum Maximum Average SampleCount Sum |
| `QueryCacheHits` | The number of times query results were returned from the cache of a node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `QueryCacheMisses`| The number of times query results were not in the cache of a node or cluster and had to be retrieved from DynamoDB. | Count | Minimum Maximum Average SampleCount Sum |
| `ScanCacheHits`| The number of times scan results were returned from the cache of a node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `ScanCacheMisses`| The number of times scan results were not in the cache of a node or cluster and had to be retrieved from DynamoDB. | Count | Minimum Maximum Average SampleCount Sum |
| `TotalRequestCount`| The total number of requests processed by a node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `ErrorRequestCount`| The total number of requests that resulted in user errors reported by a node or cluster. Includes requests throttled by the node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `ThrottledRequestCount` | The total number of requests throttled by a node or cluster. Does not include requests throttled by DynamoDB, which can be monitored using DynamoDB Metrics. | Count | Minimum Maximum Average SampleCount Sum |
| `FaultRequestCount`| The total number of requests that resulted in internal errors reported by a node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `FailedRequestCount`| The total number of requests that resulted in errors reported by a node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `QueryRequestCount`| The number of query requests processed by a node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `ScanRequestCount`| The number of scan requests processed by a node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `ClientConnections`| The number of simultaneous connections established between clients and a node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `EstimatedDbSize`| An approximate value of the amount of data cached in item caches and query caches per node or cluster. | Bytes | Minimum Maximum Average |
| `EvictedSize`| The amount of data evicted by a node or cluster to make space for new requested data. If the error rate increases and you see this Metric growing, it may indicate that your working set has increased. You should consider switching to a cluster with larger node types. | Bytes | Minimum Maximum Average Sum |


## Objects {#object}

The structure of collected AWS DynamoDB objects data, which can be viewed under "Infrastructure - Custom" for object data.

```json
{
  "measurement": "aws_dynamodb_dax",
  "tags": {
      "RegionId"            : "cn-north-1",
      "ClusterArn"          : "arn:aws-cn:dynamodb:cn-north-1:",
      "NodeType"            : "0ce8d4f9b35",
      "ClusterName"         : "eks-tflock",
      "IamRoleArn"          : "ACTIVE",
      "Status"              : "ACTIVE"
  },
  "fields": {
    "Description"           : "[{\"AttributeName\": \"LockID\", \"AttributeType\": \"S\"}]",
    "TotalNodes"            : "1",
    "ActiveNodes"           : "1",
    "NodeType"              : "1",
    "PreferredMaintenanceWindow" : "[{\"AttributeName\": \"LockID\", \"KeyType\": \"HASH\"}]",
    "message"               : "{instance json info}"
  }
}
```

>*Note: Fields in `tags` and `fields` may change with subsequent updates*
