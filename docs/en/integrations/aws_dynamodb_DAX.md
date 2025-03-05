---
title: 'AWS DynamoDB DAX'
tags: 
  - AWS
summary: 'The display metrics of AWS DynamoDB DAX include CPU usage of nodes or clusters, number of bytes received or sent on all network interfaces, number of packets, etc. These metrics reflect the running status of DynamoDB DAX.'
__int_icon: 'icon/aws_dynamodb_DAX'
dashboard:

  - desc: 'AWS DynamoDB DAX Dashboard'
    path: 'dashboard/en/aws_dynamodb_DAX'

monitor:
  - desc: 'AWS DynamoDB DAX Monitor'
    path: 'monitor/en/aws_dynamodb_DAX'

cloudCollector:
  desc: 'cloud collector'
  path: 'cloud-collector/en/aws_dynamodb_dax'
---


<!-- markdownlint-disable MD025 -->
# AWS DynamoDB DAX
<!-- markdownlint-enable -->


The display metrics of AWS DynamoDB DAX include CPU usage of nodes or clusters, number of bytes received or sent on all network interfaces, number of packets, etc. These metrics reflect the running status of **DynamoDB DAX**.


## config {#config}

### Install Func

Recommend opening [ Integrations - Extension - DataFlux Func (Automata) ]: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip: Please prepare AWS AK that meets the requirements in advance (For simplicity's sake, you can directly grant the global read-only permission for CloudWatch `CloudWatchReadOnlyAccess`)

To synchronize the monitoring data of AWS ELB cloud resources, we install the corresponding collection script: `ID:guance_aws_lambda`

Click [ Install ] and enter the corresponding parameters: AWS AK, AWS account name.

Tap [Deploy startup Script], the system automatically creates `Startup` script sets, And automatically configure the corresponding startup script.

Then, in the collection script, add the collector_configs and cloudwatch_change the regions in configs to the actual regions

After this function is enabled, you can view the automatic triggering configuration in [Management / Crontab Config]. Click [Run], you can immediately execute once, without waiting for a regular time. After a while, you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verify

1. In [ Management / Crontab Config ] check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click [ Infrastructure / Custom ] to check whether asset information exists
3. On the Guance platform, press [ Metrics ] to check whether monitoring data exists

## Metric {#metric}
Configure AWS Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them.

[The metrics of Amazon CloudWatch for DynamoDB Accelerator (DAX)](https://docs.aws.amazon.com/zh_cn/amazondynamodb/latest/developerguide/dax-metrics-dimensions-dax.html){:target="_blank"}


| Metric | Description | Units | Valid Statistics |
| :---: | :---: | :---: | :---: |
| `CPUUtilization` | The percentage of CPU utilization of the node or cluster. | Percent | Minimum Maximum Average |
| `CacheMemoryUtilization` | The percentage of available cache memory that is in use by the item cache and query cache on the node or cluster. Cached data starts to be evicted prior to memory utilization reaching 100% (see **EvictedSize** metric). If **CacheMemoryUtilization** reaches 100% on any node, write requests will be throttled and you should consider switching to a cluster with a larger node type. | Percent | Minimum Maximum Average  |
| `NetworkBytesIn` | The number of bytes received on all network interfaces by the node or cluster. | Bytes | Minimum Maximum Average |
| `NetworkBytesOut` | The number of bytes sent out on all network interfaces by the node or cluster. This metric identifies the volume of outgoing traffic in terms of the number of bytes on a single node or cluster. | Bytes | Minimum Maximum Average |
| `NetworkPacketsIn` | The number of packets received on all network interfaces by the node or cluster. | Count | Minimum Maximum Average  |
| `NetworkPacketsOut` | The number of packets sent out on all network interfaces by the node or cluster. This metric identifies the volume of outgoing traffic in terms of the number of packets on a single node or cluster. | Count | Minimum Maximum Average |
| `GetItemRequestCount` | The number of GetItem requests handled by the node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `BatchGetItemRequestCount` | The number of BatchGetItem requests handled by the node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `BatchWriteItemRequestCount` | The number of BatchWriteItem requests handled by the node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `DeleteItemRequestCount` | The number of DeleteItem requests handled by the node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `PutItemRequestCount` | The number of PutItem requests handled by the node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `UpdateItemRequestCount` | The number of UpdateItem requests handled by the node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `TransactWriteItemsCount` | The number of TransactWriteItems requests handled by the node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `TransactGetItemsCount`| The number of TransactGetItems requests handled by the node or cluster.| Count | Minimum Maximum Average SampleCount Sum |
| `ItemCacheHits` | The number of times an item was returned from the cache by the node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `ItemCacheMisses` | The number of times an item was not in the node or cluster cache, and had to be retrieved from DynamoDB. | Count | Minimum Maximum Average SampleCount Sum |
| `QueryCacheHits` | The number of times a query result was returned from the node or cluster cache. | Count | Minimum Maximum Average SampleCount Sum |
| `QueryCacheMisses` | The number of times a query result was not in the node or cluster cache, and had to be retrieved from DynamoDB. | Count | Minimum Maximum Average SampleCount Sum |
| `ScanCacheHits` | The number of times a scan result was returned from the node or cluster cache. | Count | Minimum Maximum Average SampleCount Sum |
| `ScanCacheMisses` | The number of times a scan result was not in the node or cluster cache, and had to be retrieved from DynamoDB. | Count | Minimum Maximum Average SampleCount Sum |
| `TotalRequestCount` | Total number of requests handled by the node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `ErrorRequestCount` | Total number of requests that resulted in a user error reported by the node or cluster. Requests that were throttled by the node or cluster are included. | Count | Minimum Maximum Average SampleCount Sum |
| `ThrottledRequestCount` | Total number of requests throttled by the node or cluster. Requests that were throttled by DynamoDB are not included, and can be monitored using DynamoDB Metrics. | Count | Minimum Maximum Average SampleCount Sum |
| `FaultRequestCount` | Total number of requests that resulted in an internal error reported by the node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `FailedRequestCount` | Total number of requests that resulted in an error reported by the node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `QueryRequestCount` | The number of query requests handled by the node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `ScanRequestCount` | The number of scan requests handled by the node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `ClientConnections` | The number of simultaneous connections made by clients to the node or cluster. | Count | Minimum Maximum Average SampleCount Sum |
| `EstimatedDbSize` | An approximation of the amount of data cached in the item cache and the query cache by the node or cluster. | Bytes | Minimum Maximum Average |
| `EvictedSize` | The amount of data that was evicted by the node or cluster to make room for newly requested data. If the miss rate goes up, and you see this metric also growing, it probably means that your working set has increased. You should consider switching to a cluster with a larger node type. | Bytes | Minimum Maximum Average Sum |


## Object {#object}

The collected AWS DynamoDB object data structure can be seen from the [ Infrastructure - Custom]  object data

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
    "message"               : "{Instance json}"
  }
}

```

> *Note: The fields in 'tags' and' fields' may change with subsequent updates*
