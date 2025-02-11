---
title: 'AWS Kinesis'
tags: 
  - AWS
summary: 'Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/aws_kinesis'
dashboard:

  - desc: 'AWS Kinesis Monitoring View'
    path: 'dashboard/en/aws_kinesis'

monitor:
  - desc: 'AWS Kinesis Monitor'
    path: 'monitor/en/aws_kinesis'

---


<!-- markdownlint-disable MD025 -->
# AWS Kinesis
<!-- markdownlint-enable -->

Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Deploy Func on Your Own](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data for AWS Kinesis cloud resources, we install the corresponding collection script: "Guance Integration (AWS-Kinesis Collection)" (ID: `guance_aws_kinesis`)

After clicking 【Install】, enter the corresponding parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the startup scripts accordingly.

Then, in the collection script, change the regions in `collector_configs` and `cloudwatch_configs` to the actual regions.

In addition, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to immediately execute it once without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations. For details, see the metrics section [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-aws-kinesis/){:target="_blank"}


### Verification

1. In 「Management / Automatic Trigger Configuration」confirm whether the corresponding automatic trigger configuration exists for the task, and check the task records and logs for any anomalies.
2. On the Guance platform, check under 「Infrastructure / Custom」whether asset information exists.
3. On the Guance platform, check under 「Metrics」whether there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric set is as follows. You can collect more metrics through configuration [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/streams/latest/dev/monitoring-with-cloudwatch.html){:target="_blank"}

### Instance Metrics

The `AWS/Kinesis` namespace includes the following instance metrics.

| Metric                                   | Description                                                                                                                                                                                                                       |
|:-------------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `IncomingBytes`                      | The number of bytes successfully placed into the Kinesis stream during the specified period. This metric includes bytes from `PutRecord` and `PutRecords`. Statistics Minimum, Maximum, and Average represent the number of bytes in a single put operation within the specified period. Shard-level metric name: IncomingBytes. Dimension: StreamName. Unit: Bytes                                                          |
| `IncomingRecords`                    | The number of records successfully placed into the Kinesis stream during the specified period. This metric includes records from `PutRecord` and `PutRecords`. Statistics Minimum, Maximum, and Average represent the number of records in a single put operation within the specified period. Shard-level metric name: IncomingRecords. Dimension: StreamName. Unit: Count                                                        |
| `WriteProvisionedThroughputExceeded` | The number of records rejected due to stream limits during the specified period. This metric includes limits from `PutRecord` and `PutRecords` operations. The most commonly used statistic for this metric is Average. When the Minimum value is not zero, records in the stream were throttled during the specified period. When the Maximum value is 0 (zero), no records in the stream were throttled during the specified period. Shard-level metric name: WriteProvisionedThroughputExceeded. Dimension: StreamName. Unit: Count |
| `PutRecords.Bytes`                   | The number of bytes placed into the Kinesis stream using `PutRecords` during the specified period. Dimension: StreamName. Unit: Bytes                                                                                                                                    |
| `PutRecords.Success`                 | The number of `PutRecords` operations measured in each Kinesis stream where at least one record was successful during the specified period. Dimension: StreamName. Unit: Count                                                                                                                                                      |
| `PutRecords.Latency`                 | The time taken for each `PutRecords` operation measured during the specified period. Dimension: StreamName. Unit: Milliseconds                                                                                                                                                                       |
| `PutRecords.FailedRecords`           | The number of records rejected due to internal failures. `PutRecords` operations measured in each Kinesis data stream during the specified period. Occasionally internal failures occur and should be retried. Dimension: StreamName. Unit: Count|
| `PutRecords.ThrottledRecords`        | The number of records rejected due to throttling. `PutRecords` operations measured in each Kinesis data stream during the specified period. Dimension: StreamName. Unit: Count|
| `PutRecords.TotalRecords`            | The total number of records measured in each Kinesis data stream during the specified period. Dimension: StreamName. Unit: Count|

## Objects {#object}

The structure of collected AWS Kinesis object data can be viewed in 「Infrastructure - Custom」

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

> *Note: Fields in `tags` may change with subsequent updates.*
>
> Tip 1: The `name` value is the instance name, used as a unique identifier.