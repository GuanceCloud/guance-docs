---
title: 'AWS Kinesis'
tags: 
  - AWS
summary: 'Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>'
__int_icon: 'icon/aws_kinesis'
dashboard:

  - desc: 'AWS Kinesis monitoring view'
    path: 'dashboard/en/aws_kinesis'

monitor:
  - desc: 'AWS Kinesis monitor'
    path: 'monitor/en/aws_kinesis'

cloudCollector:
  desc: 'Cloud collector'
  path: 'cloud-collector/en/aws_kinesis'
---


<!-- markdownlint-disable MD025 -->
# AWS Kinesis
<!-- markdownlint-enable -->

Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>


## Configuration {#config}

### Install Func

It is recommended to enable the <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites will be automatically installed, please continue with the script installation

If you deploy Func yourself, refer to [Self-deploy Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

To synchronize the monitoring data of AWS Kinesis cloud resources, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (AWS-Kinesis Collection)" (ID: `guance_aws_kinesis`)

After clicking 【Install】, enter the corresponding parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set, and automatically configure the corresponding startup script.

Then, in the collection script, change the regions in `collector_configs` and `cloudwatch_configs` to the actual regions.

In addition, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the scheduled time. Wait for a moment, you can check the execution task records and corresponding logs.

We default to collecting some configurations, for details, see the metrics section [Customize Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aws-kinesis/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding automatic trigger configuration exists for the corresponding task, and at the same time, you can check the corresponding task records and logs to check for any abnormalities
2. On the <<< custom_key.brand_name >>> platform, in "Infrastructure / Custom", check if there is asset information
3. On the <<< custom_key.brand_name >>> platform, in "Metrics", check if there are corresponding monitoring data

## Metrics {#metric}
Configure Amazon-CloudWatch well, the default metric set is as follows, you can collect more metrics through configuration [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/streams/latest/dev/monitoring-with-cloudwatch.html){:target="_blank"}

### Instance Metrics

The `AWS/Kinesis` namespace includes the following instance metrics.

| Metric                                   | Description                                                                                                                                                                                                                       |
|:-------------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `IncomingBytes`                      | The number of bytes successfully placed into the Kinesis stream during the specified period. This metric includes bytes from `PutRecord` and `PutRecords`. Statistics Minimum, Maximum, and Average indicate the number of bytes in a single put operation on the stream during the specified period. Shard-level metric name: IncomingBytes. Dimension: StreamName. Unit: Bytes                                                          |
| `IncomingRecords`                    | The number of records successfully placed into the Kinesis stream during the specified period. This metric includes records from `PutRecord` and `PutRecords`. Statistics Minimum, Maximum, and Average indicate the number of records in a single put operation on the stream during the specified period. Shard-level metric name: IncomingRecords. Dimension: StreamName. Unit: Count                                                        |
| `WriteProvisionedThroughputExceeded` | The number of records rejected due to stream limits during the specified period. This metric includes limits from `PutRecord` and `PutRecords` operations. The most commonly used statistic for this metric is Average. When the value of the Minimum statistic is not zero, the stream's records will be throttled during the specified period. When the value of the Maximum statistic is 0 (zero), none of the stream's records will be throttled during the specified period. Shard-level metric name: WriteProvisionedThroughputExceeded. Dimension: StreamName. Unit: Count |
| `PutRecords.Bytes`                   | The number of bytes placed into the Kinesis stream using `PutRecords` during the specified period. Dimension: StreamName. Unit: Bytes                                                                                                                                    |
| `PutRecords.Success`                 | The number of `PutRecords` operations measured for each Kinesis stream during the specified period where at least one record was successful. Dimension: StreamName. Unit: Count                                                                                                                                                      |
| `PutRecords.Latency`                 | The time measured for each `PutRecords` operation during the specified period. Dimension: StreamName. Unit: Milliseconds                                                                                                                                                                       |
| `PutRecords.FailedRecords`           | The number of records rejected due to internal failures. `PutRecords` operations measured for each Kinesis data stream during the specified period. Occasional internal failures should be retried. Dimension: StreamName. Unit: Count|
| `PutRecords.ThrottledRecords`        | The number of records rejected due to throttling limits. `PutRecords` operations measured for each Kinesis data stream during the specified period. Dimension: StreamName. Unit: Count|
| `PutRecords.TotalRecords`             | The total number of records measured for each Kinesis data stream using `PutRecords` during the specified period. Dimension: StreamName. Unit: Count|

## Objects {#object}

The structure of the collected AWS Kinesis object data can be viewed in "Infrastructure - Custom"

```json
{
  "measurement": "aws_kinesis",
  "tags": {
    "class"          : "aws_kinesis",
    "cloud_provider" : "aws",
    "create_time"    : "2023/08/07 14:29:19",
    "date"           : "2023/08/07 14:29:19",
    "date_ns"        :"0",
    "EncryptionType" :"NONE",
    "HasMoreShards"  :"false",
    "name"           :"zsh_test",
    "RegionId"      :"cn-northwest-1",
    "RetentionPeriodHours":"24",
    "StreamARN":"arn:aws-cn:kinesis:cn-northwest-1:294654068288:stream/zsh_test",
    "StreamName":"zsh_test",
    "StreamStatus":"ACTIVE"
  }
}
```

> *Note: The fields in `tags` may change with subsequent updates.*
>
> Note 1: The `name` value is the instance name, used for unique identification.
