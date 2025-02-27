---
title: 'AWS DynamoDB'
tags: 
  - AWS
summary: 'Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance .'
__int_icon: 'icon/aws_dynamodb'
dashboard:
  - desc: 'AWS DynamoDB Monitoring View'
    path: 'dashboard/en/aws_dynamodb'
monitor:
  - desc: 'AWS DynamoDB Monitor'
    path: 'monitor/en/aws_dynamodb'

cloudCollector:
  desc: 'cloud collector'
  path: 'cloud-collector/en/aws_dynamodb'
---


<!-- markdownlint-disable MD025 -->
# AWS DynamoDB
<!-- markdownlint-enable -->


Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance .


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,[Refer to](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare AWS AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of DynamoDB cloud resources, we install the corresponding collection script：「Guance Integration（AWS-DynamoDBCollect）」(ID：`guance_aws_dynamodb`)

Click 【Install】 and enter the corresponding parameters: AWS AK, AWS account name.

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」.Click[Run],you can immediately execute once, without waiting for a regular time.After a while,you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance  platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance  platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure AWS Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/amazondynamodb/latest/developerguide/metrics-dimensions.html){:target="_blank"}

### ConditionalCheckFailedRequests

The number of failed attempts to perform conditional writes.

| metric name | descriptive | unit  | dimension  |
| :---: | :---: | :---: | :---: |
| ConditionalCheckFailedRequests_Average | Average number of erroneous requests | Count | TableName |
| ConditionalCheckFailedRequests_Maximum | Error Request Maximum | Count | TableName |
| ConditionalCheckFailedRequests_Minimum | Error Request Minimum | Count | TableName |
| ConditionalCheckFailedRequests_SampleCount | Number of erroneous requests | Count | TableName |
| ConditionalCheckFailedRequests_Sum | Total number of erroneous requests | Count | TableName |

### ConsumedReadCapacityUnits
Specifies the number of read capacity units occupied during the time period so that you can track the use of preset throughput.

| metric name | descriptive | unit | dimension |
| :---: | :---: | :---: | :---: |
| ConsumedReadCapacityUnits_Average | Average read capacity per request | Count | TableName |
| ConsumedReadCapacityUnits_Maximum | Maximum number of read capacity units occupied by any request to a table or index | Count | TableName |
| ConsumedReadCapacityUnits_Minimum | Minimum number of read capacity units occupied by any request to a table or index | Count | TableName |
| ConsumedReadCapacityUnits_SampleCount | Number of read requests to DynamoDB, even if the read capacity is not occupied | Count | TableName |
| ConsumedReadCapacityUnits_Sum | Total read capacity units occupied | Count | TableName |

### ConsumedWriteCapacityUnits
Specifies the number of write capacity units occupied during the time period so that you can track the use of preset throughput.

| metric name | descriptive | unit | dimension |
| :---: | :---: | :---: | :---: |
| ConsumedWriteCapacityUnits_Average | Average write capacity occupied per request | Count | TableName |
| ConsumedWriteCapacityUnits_Maximum | Maximum number of write capacity units occupied by any request to a table or index | Count | TableName |
| ConsumedWriteCapacityUnits_Minimum | Minimum number of write capacity units occupied by any request to a table or index | Count | TableName |
| ConsumedWriteCapacityUnits_SampleCount | Number of write requests to DynamoDB, even if read capacity is not occupied | Count | TableName |
| ConsumedWriteCapacityUnits_Sum | Total Write Capacity Units Occupied | Count | TableName |

## Object {#object}

Collected AWS DynamoDB object data structure, you can see the object data from the "Infrastructure - Customize"

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
    "message"               : "{Instance json}"
  }
}

```

> *Note: Fields in `tags`, `fields` are subject to change with subsequent updates.*
>
> Tip 1: The `tags.name` value is the instance ID, which serves as a unique identifier.
> Tip 2: `fields.message`, `fields.NetworkInterfaces`, and `fields.BlockDeviceMappings` are JSON serialized strings.

