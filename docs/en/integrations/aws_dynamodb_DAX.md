---
title: 'AWS DynamoDB DAX'
tags: 
  - AWS
summary: 'The metrics displayed for AWS DynamoDB DAX include CPU utilization of nodes or clusters, bytes received or transmitted on all network interfaces, number of packets, etc. These metrics reflect the operational status of DynamoDB DAX.'
__int_icon: 'icon/aws_dynamodb_DAX'
dashboard:

  - desc: 'Built-in views for AWS DynamoDB DAX'
    path: 'dashboard/en/aws_dynamodb_DAX'

monitor:
  - desc: 'AWS DynamoDB DAX monitor'
    path: 'monitor/en/aws_dynamodb_DAX'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_dynamodb_dax'
---


<!-- markdownlint-disable MD025 -->
# AWS DynamoDB DAX
<!-- markdownlint-enable -->


The metrics displayed for AWS DynamoDB DAX include CPU utilization of nodes or clusters, bytes received or transmitted on all network interfaces, number of packets, etc. These metrics reflect the operational status of DynamoDB DAX.


## Configuration {#config}

### Install Func

We recommend enabling Guance integration - expansion - DataFlux Func (Automata): All prerequisites are automatically installed, please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare an Amazon Cloud AK that meets the requirements in advance (for simplicity, you can directly grant `CloudWatchReadOnlyAccess` permission)

To synchronize monitoring data from AWS-DynamoDB DAX, we install the corresponding collection script: "Guance Integration (AWS-DynamoDB DAX Collection)" (ID: `guance_aws_dynamodb_dax`)

After clicking 【Install】, enter the required parameters: AWS AK ID, AWS AK SECRET, account_name.

Click 【Deploy Startup Script】 and the system will automatically create a `Startup` script set and configure the startup script accordingly. Ensure that 'regions' in the startup script match the actual regions where instances are located.

After enabling, you can see the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short wait, you can view the task execution records and corresponding logs.

> If you need to collect logs, enable the corresponding log collection script. If you need to collect billing data, enable the cloud billing collection script.


By default, we collect some configurations; for more details, see [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. Confirm in 「Manage / Automatic Trigger Configuration」 whether the corresponding task has the automatic trigger configuration, and check the task records and logs for any abnormalities.
2. In the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. In the Guance platform, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}

After configuring Amazon CloudWatch, the default metric set is as follows. More metrics can be collected through configuration:

[Amazon CloudWatch DynamoDB Accelerator (DAX) Metric Details](https://docs.aws.amazon.com/en_us/amazondynamodb/latest/developerguide/dax-metrics-dimensions-dax.html){:target="_blank"}


| Metric Name | Description | Unit | Valid Statistics |
| :---: | :---: | :---: | :---: |
| `CPUUtilization` | Percentage of CPU utilization for nodes or clusters. | Percent | Minimum Maximum Average |
| `CacheMemoryUtilization` | Percentage of available cache memory used by item cache and query cache on nodes or clusters. Cache data starts to be evicted when memory utilization reaches 100% (see EvictedSize metric). If CacheMemoryUtilization reaches 100% on any node, write requests will be throttled, and you should consider switching to a cluster with larger node types. | Percent | Minimum Maximum Average  |
| `NetworkBytesIn` | Number of bytes received by nodes or clusters on all network interfaces. | Bytes | Minimum Maximum Average |
| `NetworkBytesOut` | Number of bytes sent by nodes or clusters on all network interfaces. This metric identifies outbound traffic based on packet counts on individual instances. | Bytes | Minimum Maximum Average |
| `NetworkPacketsIn`| Number of packets received by nodes or clusters on all network interfaces. | Count | Minimum Maximum Average  |
| `NetworkPacketsOut` | Number of packets sent by nodes or clusters on all network interfaces. This metric identifies outbound traffic based on packet counts on individual instances. | Count | Minimum Maximum Average |
| `GetItemRequestCount`| Number of GetItem requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `BatchGetItemRequestCount`| Number of BatchGetItem requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `BatchWriteItemRequestCount` | Number of BatchWriteItem requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `DeleteItemRequestCount` | Number of DeleteItem requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `PutItemRequestCount` | Number of PutItem requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `UpdateItemRequestCount` | Number of UpdateItem requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `TransactWriteItemsCount` | Number of TransactWriteItems requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `TransactGetItemsCount`| Number of TransactGetItems requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `ItemCacheHits` | Number of times items were returned from cache by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `ItemCacheMisses`| Number of times items were not found in the cache of nodes or clusters and had to be retrieved from DynamoDB. | Count | Minimum Maximum Average SampleCount Sum |
| `QueryCacheHits` | Number of times query results were returned from the cache of nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `QueryCacheMisses`| Number of times query results were not found in the cache of nodes or clusters and had to be retrieved from DynamoDB. | Count | Minimum Maximum Average SampleCount Sum |
| `ScanCacheHits`| Number of times scan results were returned from the cache of nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `ScanCacheMisses`| Number of times scan results were not found in the cache of nodes or clusters and had to be retrieved from DynamoDB. | Count | Minimum Maximum Average SampleCount Sum |
| `TotalRequestCount`| Total number of requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `ErrorRequestCount`| Total number of user error requests that caused nodes or clusters to report errors. Includes throttled requests. | Count | Minimum Maximum Average SampleCount Sum |
| `ThrottledRequestCount` | Total number of throttled requests by nodes or clusters. Does not include throttled requests by DynamoDB, which can be monitored using DynamoDB metrics. | Count | Minimum Maximum Average SampleCount Sum |
| `FaultRequestCount`| Total number of internal error requests reported by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `FailedRequestCount`| Total number of failed requests reported by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `QueryRequestCount`| Total number of query requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `ScanRequestCount`| Total number of scan requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `ClientConnections`| Number of simultaneous connections established between clients and nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `EstimatedDbSize`| Approximate amount of data cached in item cache and query cache per node or cluster. | Bytes | Minimum Maximum Average |
| `EvictedSize`| Amount of data evicted by nodes or clusters to make space for new request data. If error rates increase and this metric also grows, it may indicate an increase in your working set. Consider switching to a cluster with larger node types. | Bytes | Minimum Maximum Average Sum |


## Objects {#object}

The structure of AWS DynamoDB objects collected can be viewed under 「Infrastructure - Custom」

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

>*Note: Fields in `tags` and `fields` may change with subsequent updates.*
