---
title: 'AWS DynamoDB'
tags: 
  - AWS
summary: 'The displayed Metrics for AWS DynamoDB include throughput capacity units, latency, concurrent connections, and read/write throughput, etc. These metrics reflect the performance and scalability of DynamoDB when handling large-scale data storage and access.'
__int_icon: 'icon/aws_dynamodb'
dashboard:

  - desc: 'Built-in Views for AWS DynamoDB'
    path: 'dashboard/en/aws_dynamodb'

monitor:
  - desc: 'Monitors for AWS DynamoDB'
    path: 'monitor/en/aws_dynamodb'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_dynamodb'
---


<!-- markdownlint-disable MD025 -->
# AWS DynamoDB
<!-- markdownlint-enable -->


The displayed Metrics for AWS DynamoDB include throughput capacity units, latency, concurrent connections, and read/write throughput, etc. These metrics reflect the performance and scalability of **DynamoDB** when handling large-scale data storage and access.


## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func manually, refer to [Manual Deployment of Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

#### Script for Enabling Managed Version

1. Log in to the <<< custom_key.brand_name >>> console.
2. Click on the 【Manage】 menu, select 【Cloud Account Management】.
3. Click 【Add Cloud Account】, choose 【AWS】, and fill in the required information on the interface. If you have already configured cloud account information, skip this step.
4. Click 【Test】. After a successful test, click 【Save】. If the test fails, check whether the related configuration information is correct and retest.
5. In the 【Cloud Account Management】 list, you can see the added cloud account. Click the corresponding cloud account to enter the details page.
6. On the cloud account details page, click the 【Integration】 button. Under the `Not Installed` list, find `AWS DynamoDB`, click the 【Install】 button, and follow the installation interface to complete the installation.

#### Manual Script for Enabling

1. Log in to the Func console, click 【Script Market】, enter the official script market, and search for `guance_aws_dynamodb`.

2. After clicking 【Install】, input the corresponding parameters: AWS AK ID, AK Secret, and account name.

3. Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

4. After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to immediately execute it without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.


### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding task has the corresponding automatic trigger configuration, and you can also check the corresponding task records and logs for any anomalies.
2. In <<< custom_key.brand_name >>>, under 「Infrastructure / Custom」, check if there is asset information.
3. In <<< custom_key.brand_name >>>, under 「Metrics」, check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon-CloudWatch, the default Measurement set is as follows. You can collect more Metrics through configuration. [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/en_us/amazondynamodb/latest/developerguide/metrics-dimensions.html){:target="_blank"}

### ConditionalCheckFailedRequests

The number of failed attempts to perform conditional writes.

| Metric Name | Description | Unit | Dimension |
| :---: | :---: | :---: | :---: |
| ConditionalCheckFailedRequests_Average | Average number of error requests | Count | TableName |
| ConditionalCheckFailedRequests_Maximum | Maximum value of error requests | Count | TableName |
| ConditionalCheckFailedRequests_Minimum | Minimum value of error requests | Count | TableName |
| ConditionalCheckFailedRequests_SampleCount | Number of error requests | Count | TableName |
| ConditionalCheckFailedRequests_Sum | Total number of error requests | Count | TableName |

### ConsumedReadCapacityUnits

The number of read capacity units consumed during a specified time period, allowing you to track provisioned throughput usage.

| Metric Name | Description | Unit | Dimension |
| :---: | :---: | :---: | :---: |
| ConsumedReadCapacityUnits_Average | Average read capacity consumed per request | Count | TableName |
| ConsumedReadCapacityUnits_Maximum | Maximum read capacity units consumed by any request to a table or index | Count | TableName |
| ConsumedReadCapacityUnits_Minimum | Minimum read capacity units consumed by any request to a table or index | Count | TableName |
| ConsumedReadCapacityUnits_SampleCount | Number of read requests to DynamoDB, even if no read capacity was consumed | Count | TableName |
| ConsumedReadCapacityUnits_Sum | Total read capacity units consumed | Count | TableName |

### ConsumedWriteCapacityUnits

The number of write capacity units consumed during a specified time period, allowing you to track provisioned throughput usage.

| Metric Name | Description | Unit | Dimension |
| :---: | :---: | :---: | :---: |
| ConsumedWriteCapacityUnits_Average | Average write capacity consumed per request | Count | TableName |
| ConsumedWriteCapacityUnits_Maximum | Maximum write capacity units consumed by any request to a table or index | Count | TableName |
| ConsumedWriteCapacityUnits_Minimum | Minimum write capacity units consumed by any request to a table or index | Count | TableName |
| ConsumedWriteCapacityUnits_SampleCount | Number of write requests to DynamoDB, even if no read capacity was consumed | Count | TableName |
| ConsumedWriteCapacityUnits_Sum | Total write capacity units consumed | Count | TableName |

## Objects {#object}

The structure of the collected AWS DynamoDB object data, which can be viewed from 「Infrastructure - Custom」.

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
    "message"               : "{JSON instance information}"
  }
}

```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, used for unique identification.
>
> Tip 2: `fields.message`, `fields.Endpoint`, are strings serialized in JSON format.