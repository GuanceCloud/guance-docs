---
title: 'AWS DynamoDB'
tags: 
  - AWS
summary: 'The metrics displayed for AWS DynamoDB include throughput capacity units, latency, concurrent connections, and read/write throughput. These metrics reflect the performance and scalability of DynamoDB in handling large-scale data storage and access.'
__int_icon: 'icon/aws_dynamodb'
dashboard:

  - desc: 'Built-in Views for AWS DynamoDB'
    path: 'dashboard/en/aws_dynamodb'

monitor:
  - desc: 'AWS DynamoDB Monitor'
    path: 'monitor/en/aws_dynamodb'

---


<!-- markdownlint-disable MD025 -->
# AWS DynamoDB
<!-- markdownlint-enable -->


The metrics displayed for AWS DynamoDB include throughput capacity units, latency, concurrent connections, and read/write throughput. These metrics reflect the performance and scalability of **DynamoDB** in handling large-scale data storage and access.


## Configuration {#config}

### Install Func

We recommend enabling Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare a qualified Amazon AK in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

To synchronize monitoring data from AWS DynamoDB, we install the corresponding collection script: "Guance Integration (AWS-DynamoDB Collection)" (ID: `guance_aws_dynamodb`)

After clicking 【Install】, enter the required parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the startup script accordingly.

Additionally, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations; for details, see [Configuration of Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In 「Management / Automatic Trigger Configuration」confirm that the corresponding task has an automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, in 「Infrastructure / Custom」check if asset information exists.
3. On the Guance platform, in 「Metrics」check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric set is as follows. You can collect more metrics through configuration [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/amazondynamodb/latest/developerguide/metrics-dimensions.html){:target="_blank"}

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

Number of read capacity units consumed during a specified period, which allows tracking of provisioned throughput usage.

| Metric Name | Description | Unit | Dimensions |
| :---: | :---: | :---: | :---: |
| ConsumedReadCapacityUnits_Average | Average read capacity consumed per request | Count | TableName |
| ConsumedReadCapacityUnits_Maximum | Maximum read capacity units consumed by any request to the table or index | Count | TableName |
| ConsumedReadCapacityUnits_Minimum | Minimum read capacity units consumed by any request to the table or index | Count | TableName |
| ConsumedReadCapacityUnits_SampleCount | Number of read requests to DynamoDB, even if no read capacity was consumed | Count | TableName |
| ConsumedReadCapacityUnits_Sum | Total read capacity units consumed | Count | TableName |

### ConsumedWriteCapacityUnits

Number of write capacity units consumed during a specified period, which allows tracking of provisioned throughput usage.

| Metric Name | Description | Unit | Dimensions |
| :---: | :---: | :---: | :---: |
| ConsumedWriteCapacityUnits_Average | Average write capacity consumed per request | Count | TableName |
| ConsumedWriteCapacityUnits_Maximum | Maximum write capacity units consumed by any request to the table or index | Count | TableName |
| ConsumedWriteCapacityUnits_Minimum | Minimum write capacity units consumed by any request to the table or index | Count | TableName |
| ConsumedWriteCapacityUnits_SampleCount | Number of write requests to DynamoDB, even if no read capacity was consumed | Count | TableName |
| ConsumedWriteCapacityUnits_Sum | Total write capacity units consumed | Count | TableName |

## Objects {#object}

Data structure of collected AWS DynamoDB objects, which can be viewed in 「Infrastructure - Custom」

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
    "message"               : "{instance JSON information}"
  }
}

```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Note 1: The value of `tags.name` is the instance ID, used as a unique identifier.
>
> Note 2: `fields.message`, `fields.Endpoint` are serialized JSON strings.