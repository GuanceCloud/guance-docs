---
title: 'AWS DynamoDB DAX'
tags: 
  - AWS
summary: 'The metrics displayed for AWS DynamoDB DAX include CPU utilization of nodes or clusters, the number of bytes received or sent on all network interfaces, the number of packets, etc. These metrics reflect the operational status of DynamoDB DAX.'
__int_icon: 'icon/aws_dynamodb_DAX'
dashboard:

  - desc: 'Built-in views for AWS DynamoDB DAX'
    path: 'dashboard/en/aws_dynamodb_DAX'

monitor:
  - desc: 'AWS DynamoDB DAX monitors'
    path: 'monitor/en/aws_dynamodb_DAX'

---


<!-- markdownlint-disable MD025 -->
# AWS DynamoDB DAX
<!-- markdownlint-enable -->


The metrics displayed for AWS DynamoDB DAX include CPU utilization of nodes or clusters, the number of bytes received or sent on all network interfaces, the number of packets, etc. These metrics reflect the operational status of DynamoDB DAX.


## Configuration {#config}

### Install Func

It is recommended to enable Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare an Amazon Cloud AK that meets the requirements in advance (for simplicity, you can directly grant `CloudWatchReadOnlyAccess` permission).

To synchronize monitoring data from AWS-DynamoDB DAX, we install the corresponding collection script: 「Guance integration (AWS-DynamoDB DAX collection)」(ID: `guance_aws_dynamodb_dax`)

After clicking 【Install】, enter the required parameters: AWS AK ID, AWS AK SECRET, account_name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup scripts. Ensure that the 'regions' in the startup script match the actual regions where the instances reside.

After enabling, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.

> If you need to collect logs, enable the corresponding log collection script. If you need to collect billing data, enable the cloud billing collection script.


By default, we collect some configurations. For more details, see the metrics section [Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm whether the corresponding tasks have the automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. On the Guance platform, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}

After configuring Amazon CloudWatch, the default metric sets are as follows. You can collect more metrics through configuration:

[Amazon CloudWatch DynamoDB Accelerator (DAX) Metrics Details](https://docs.aws.amazon.com/zh_cn/amazondynamodb/latest/developerguide/dax-metrics-dimensions-dax.html){:target="_blank"}


| Metric Name | Description | Unit | Valid Statistics |
| :---: | :---: | :---: | :---: |
| `CPUUtilization` | Percentage of CPU utilization of nodes or clusters. | Percent | Minimum Maximum Average |
| `CacheMemoryUtilization` | Percentage of available cache memory used by item caching and query caching on nodes or clusters. Cache data starts being evicted when memory utilization reaches 100% (see EvictedSize metric). If CacheMemoryUtilization reaches 100% on any node, write requests will be throttled, and you should consider switching to a cluster with larger node types. | Percent | Minimum Maximum Average  |
| `NetworkBytesIn` | Number of bytes received on all network interfaces of nodes or clusters. | Bytes | Minimum Maximum Average |
| `NetworkBytesOut` | Number of bytes sent on all network interfaces of nodes or clusters. This metric identifies outbound traffic based on the number of packets on individual instances. | Bytes | Minimum Maximum Average |
| `NetworkPacketsIn`| Number of packets received on all network interfaces of nodes or clusters. | Count | Minimum Maximum Average  |
| `NetworkPacketsOut` | Number of packets sent on all network interfaces of nodes or clusters. This metric identifies outbound traffic based on the number of packets on individual instances. | Count | Minimum Maximum Average |
| `GetItemRequestCount`| Number of GetItem requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `BatchGetItemRequestCount`| Number of BatchGetItem requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `BatchWriteItemRequestCount` | Number of BatchWriteItem requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `DeleteItemRequestCount` | Number of DeleteItem requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `PutItemRequestCount` | Number of PutItem requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `UpdateItemRequestCount` | Number of UpdateItem requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `TransactWriteItemsCount` | Number of TransactWriteItems requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `TransactGetItemsCount`| Number of TransactGetItems requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `ItemCacheHits` | Number of times items were returned from the cache by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `ItemCacheMisses`| Number of times items were not found in the cache of nodes or clusters and had to be retrieved from DynamoDB. | Count | Minimum Maximum Average SampleCount Sum |
| `QueryCacheHits` | Number of times query results were returned from the cache of nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `QueryCacheMisses`| Number of times query results were not found in the cache of nodes or clusters and had to be retrieved from DynamoDB. | Count | Minimum Maximum Average SampleCount Sum |
| `ScanCacheHits`| Number of times scan results were returned from the cache of nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `ScanCacheMisses`| Number of times scan results were not found in the cache of nodes or clusters and had to be retrieved from DynamoDB. | Count | Minimum Maximum Average SampleCount Sum |
| `TotalRequestCount`| Total number of requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `ErrorRequestCount`| Total number of requests causing user errors reported by nodes or clusters. Includes throttled requests. | Count | Minimum Maximum Average SampleCount Sum |
| `ThrottledRequestCount` | Total number of throttled requests by nodes or clusters. Does not include throttled requests by DynamoDB, which can be monitored using DynamoDB metrics. | Count | Minimum Maximum Average SampleCount Sum |
| `FaultRequestCount`| Total number of requests causing internal errors reported by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `FailedRequestCount`| Total number of requests causing errors reported by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `QueryRequestCount`| Total number of query requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `ScanRequestCount`| Total number of scan requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `ClientConnections`| Number of simultaneous connections established by clients to nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `EstimatedDbSize`| Approximate amount of data cached in item caches and query caches of nodes or clusters. | Bytes | Minimum Maximum Average |
| `EvictedSize`| Amount of data evicted by nodes or clusters to make space for new request data. If error rates increase and this metric also grows, it may indicate that your working set has increased. Consider switching to a cluster with larger node types. | Bytes | Minimum Maximum Average Sum |


## Objects {#object}

The structure of AWS DynamoDB objects collected can be viewed in 「Infrastructure - Custom」

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
    "message"               : "{instance JSON info}"
  }
}
```

>*Note: Fields in `tags` and `fields` may change with subsequent updates*