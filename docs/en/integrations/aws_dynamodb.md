---
title: 'AWS DynamoDB'
tags: 
  - AWS
summary: 'The displayed metrics for AWS DynamoDB include throughput capacity units, latency, concurrent connections, and read/write throughput, among others. These metrics reflect the performance and scalability of DynamoDB when handling large-scale data storage and access.'
__int_icon: 'icon/aws_dynamodb'
dashboard:

  - desc: 'AWS DynamoDB built-in views'
    path: 'dashboard/en/aws_dynamodb'

monitor:
  - desc: 'AWS DynamoDB monitors'
    path: 'monitor/en/aws_dynamodb'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_dynamodb'
---


<!-- markdownlint-disable MD025 -->
# AWS DynamoDB
<!-- markdownlint-enable -->


The displayed metrics for AWS DynamoDB include throughput capacity units, latency, concurrent connections, and read/write throughput, among others. These metrics reflect the performance and scalability of **DynamoDB** when handling large-scale data storage and access.


## Configuration {#config}

### Install Func

It is recommended to enable the <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites will be automatically installed, please continue with script installation.

If you deploy Func manually, refer to [Manual Deployment of Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

To synchronize monitoring data from AWS DynamoDB, we install the corresponding collection script: 「<<< custom_key.brand_name >>> Integration (AWS-DynamoDB Collection)」(ID: `guance_aws_dynamodb`)

After clicking 【Install】, input the corresponding parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to immediately execute it once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

We collect some configurations by default; for more details, see the metrics section [Customize Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding task has an automatic trigger configuration, and you can also check the corresponding task records and logs for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, in 「Infrastructure / Custom」, check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, in 「Metrics」, check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric set is as follows. You can collect more metrics via configuration [Amazon CloudWatch Metric Details](https://docs.aws.amazon.com/zh_cn/amazondynamodb/latest/developerguide/metrics-dimensions.html){:target="_blank"}

### ConditionalCheckFailedRequests

Number of failed attempts to perform conditional writes.

| Metric Name | Description | Unit | Dimensions |
| :---: | :---: | :---: | :---: |
| ConditionalCheckFailedRequests_Average | Average number of failed requests | Count | TableName |
| ConditionalCheckFailedRequests_Maximum | Maximum value of failed requests | Count | TableName |
| ConditionalCheckFailedRequests_Minimum | Minimum value of failed requests | Count | TableName |
| ConditionalCheckFailedRequests_SampleCount | Number of failed requests | Count | TableName |
| ConditionalCheckFailedRequests_Sum | Total number of failed requests | Count | TableName |

### ConsumedReadCapacityUnits

Number of read capacity units consumed during a specified time period, allowing you to track the usage of provisioned throughput.

| Metric Name | Description | Unit | Dimensions |
| :---: | :---: | :---: | :---: |
| ConsumedReadCapacityUnits_Average | Average read capacity consumed per request | Count | TableName |
| ConsumedReadCapacityUnits_Maximum | Maximum read capacity units consumed by any request to the table or index | Count | TableName |
| ConsumedReadCapacityUnits_Minimum | Minimum read capacity units consumed by any request to the table or index | Count | TableName |
| ConsumedReadCapacityUnits_SampleCount | Number of read requests to DynamoDB, even if no read capacity was consumed | Count | TableName |
| ConsumedReadCapacityUnits_Sum | Total read capacity units consumed | Count | TableName |

### ConsumedWriteCapacityUnits

Number of write capacity units consumed during a specified time period, allowing you to track the usage of provisioned throughput.

| Metric Name | Description | Unit | Dimensions |
| :---: | :---: | :---: | :---: |
| ConsumedWriteCapacityUnits_Average | Average write capacity consumed per request | Count | TableName |
| ConsumedWriteCapacityUnits_Maximum | Maximum write capacity units consumed by any request to the table or index | Count | TableName |
| ConsumedWriteCapacityUnits_Minimum | Minimum write capacity units consumed by any request to the table or index | Count | TableName |
| ConsumedWriteCapacityUnits_SampleCount | Number of write requests to DynamoDB, even if no read capacity was consumed | Count | TableName |
| ConsumedWriteCapacityUnits_Sum | Total write capacity units consumed | Count | TableName |

## Objects {#object}

The structure of the collected AWS DynamoDB object data can be viewed in 「Infrastructure - Custom」

```json
{
  "measurement": "aws_dynamodb",
  "tags": {
      "RegionId"        : "cn-north-1",
      "TableArn"        : "arn:aws-cn:dynamodb:cn-north-1:",
      "TableId"         : "0ce8d4f9b35",
      "TableName"       : "eks-tflock",
      "TableStatus"     : "ACTIVE",
      "name"            : "eks-tflock"
  },
  "fields": {
    "AttributeDefinitions"  : "[{\"AttributeName\": \"LockID\", \"AttributeType\": \"S\"}]",
    "BillingModeSummary"    : "{}",
    "CreationDateTime"      : "2023-03-22T23:39:42.352000+08:00",
    "ItemCount"             : "1",
    "KeySchema"             : "[{\"AttributeName\": \"LockID\", \"KeyType\": \"HASH\"}]",
    "LocalSecondaryIndexes" : "{}",
    "TableSizeBytes"        : "96",
    "message"               : "{instance json information}"
  }
}

```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, used as a unique identifier.
>
> Tip 2: `fields.message`, `fields.Endpoint` are serialized JSON strings.