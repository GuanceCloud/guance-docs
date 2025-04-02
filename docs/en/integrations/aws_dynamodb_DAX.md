---
title: 'AWS DynamoDB DAX'
tags: 
  - AWS
summary: 'The displayed Metrics for AWS DynamoDB DAX include CPU usage of nodes or clusters, the number of bytes received or sent on all network interfaces, the number of packets, etc. These Metrics reflect the operational status of DynamoDB DAX.'
__int_icon: 'icon/aws_dynamodb_DAX'
dashboard:

  - desc: 'Built-in views for AWS DynamoDB DAX'
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

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): All prerequisites are automatically installed, please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare an Amazon Cloud AK that meets the requirements in advance (for simplicity, you can directly grant CloudWatch read-only permission `CloudWatchReadOnlyAccess`)

#### Script for Enabling Managed Version

1. Log in to the <<< custom_key.brand_name >>> console.
2. Click on the 【Manage】 menu and select 【Cloud Account Management】.
3. Click 【Add Cloud Account】, choose 【AWS】, and fill in the required information on the interface. If you have already configured cloud account information, ignore this step.
4. Click 【Test】, if the test succeeds, click 【Save】. If the test fails, check whether the relevant configuration information is correct and retest.
5. In the 【Cloud Account Management】 list, you can see the added cloud account. Click the corresponding cloud account to enter the details page.
6. On the cloud account details page, click the 【Integration】 button. In the `Not Installed` list, find `AWS DynamoDB DAX`, click the 【Install】 button, and follow the prompts to install.

#### Manual Script for Enabling 

1. Log in to the Func console, click 【Script Market】, go to the official script market, and search for `guance_aws_dynamodb_dax`.

2. After clicking 【Install】, input the corresponding parameters: AWS AK ID, AK Secret, and account name.

3. Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and configure the corresponding startup script.

4. After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to immediately execute it once without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.


### Verification

1. In 「Manage / Automatic Trigger Configuration」 confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and at the same time, you can check the corresponding task records and logs for any abnormalities.
2. In <<< custom_key.brand_name >>>, under 「Infrastructure / Custom」, check if there is asset information.
3. In <<< custom_key.brand_name >>>, under 「Metrics」, check if there are corresponding monitoring data.

## Metrics {#metric}

After configuring Amazon-Cloud Monitoring, the default Measurement set is as follows. You can collect more Metrics through configuration:

[Amazon Cloud Monitoring DynamoDB Accelerator (DAX) Metrics Details](https://docs.aws.amazon.com/en_us/amazondynamodb/latest/developerguide/dax-metrics-dimensions-dax.html){:target="_blank"}


| Metric Name | Description | Unit | Valid Statistics |
| :---: | :---: | :---: | :---: |
| `CPUUtilization` | The percentage of CPU usage for nodes or clusters. | Percent | Minimum Maximum Average |
| `CacheMemoryUtilization` | The percentage of available cache memory used by item caching and query caching on nodes or clusters. Cache data starts being evicted before the memory utilization reaches 100% (see the EvictedSize Metric). If CacheMemoryUtilization reaches 100% on any node, write requests will be throttled, and you should consider switching to a cluster with larger node types. | Percent | Minimum Maximum Average  |
| `NetworkBytesIn` | The number of bytes received by nodes or clusters on all network interfaces. | Bytes | Minimum Maximum Average |
| `NetworkBytesOut` | The number of bytes sent by nodes or clusters on all network interfaces. This Metric identifies outgoing traffic based on the number of packets on individual instances. | Bytes | Minimum Maximum Average |
| `NetworkPacketsIn`| The number of packets received by nodes or clusters on all network interfaces. | Count | Minimum Maximum Average  |
| `NetworkPacketsOut` | The number of packets sent by nodes or clusters on all network interfaces. This Metric identifies outgoing traffic based on the number of packets on individual instances. | Count | Minimum Maximum Average |
| `GetItemRequestCount`| The number of GetItem requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `BatchGetItemRequestCount`| The number of BatchGetItem requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `BatchWriteItemRequestCount` | The number of BatchWriteItem requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `DeleteItemRequestCount` | The number of DeleteItem requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `PutItemRequestCount` | The number of PutItem requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `UpdateItemRequestCount` | The number of UpdateItem requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `TransactWriteItemsCount` | The number of TransactWriteItems requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `TransactGetItemsCount`| The number of TransactGetItems requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `ItemCacheHits` | The number of times items were returned from the cache by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `ItemCacheMisses`| The number of times items were not in the cache of nodes or clusters and had to be retrieved from DynamoDB. | Count | Minimum Maximum Average SampleCount Sum |
| `QueryCacheHits` | The number of times query results were returned from the cache of nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `QueryCacheMisses`| The number of times query results were not in the cache of nodes or clusters and had to be retrieved from DynamoDB. | Count | Minimum Maximum Average SampleCount Sum |
| `ScanCacheHits`| The number of times scan results were returned from the cache of nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `ScanCacheMisses`| The number of times scan results were not in the cache of nodes or clusters and had to be retrieved from DynamoDB. | Count | Minimum Maximum Average SampleCount Sum |
| `TotalRequestCount`| The total number of requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `ErrorRequestCount`| The total number of requests leading to user errors reported by nodes or clusters. Includes requests throttled by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `ThrottledRequestCount` | The total number of requests throttled by nodes or clusters. Does not include requests throttled by DynamoDB, which can be monitored using DynamoDB Metrics. | Count | Minimum Maximum Average SampleCount Sum |
| `FaultRequestCount`| The total number of requests leading to internal errors reported by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `FailedRequestCount`| The total number of requests leading to errors reported by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `QueryRequestCount`| The number of query requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `ScanRequestCount`| The number of scan requests processed by nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `ClientConnections`| The number of simultaneous connections established between clients and nodes or clusters. | Count | Minimum Maximum Average SampleCount Sum |
| `EstimatedDbSize`| The approximate amount of data cached in item caching and query caching per node or cluster. | Bytes | Minimum Maximum Average |
| `EvictedSize`| The amount of data evicted by nodes or clusters to make space for new request data. If the error rate rises and you see this Metric growing, it may mean your working set has increased. You should consider switching to a cluster with larger node types. | Bytes | Minimum Maximum Average Sum |


## Objects {#object}

Data structure of collected AWS DynamoDB objects, visible under 「Infrastructure - Custom」

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
    "message"               : "{instance json information}"
  }
}
```

>*Note: Fields in `tags` and `fields` may change with subsequent updates.*
