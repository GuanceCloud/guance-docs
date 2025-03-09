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

It is recommended to enable the hosted version of Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data from AWS Kinesis cloud resources, we install the corresponding collection script: "Guance Integration (AWS-Kinesis Collection)" (ID: `guance_aws_kinesis`)

After clicking 【Install】, enter the corresponding parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Then, in the collection script, change the regions in `collector_configs` and `cloudwatch_configs` to the actual regions.

Additionally, view the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a while, you can check the execution task records and corresponding logs.

By default, we collect some configurations; for more details, see [Configuration of Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-kinesis/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration. You can also check the task records and logs to ensure there are no anomalies.
2. In the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. In the Guance platform, under "Metrics", check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric sets are as follows. More metrics can be collected through configuration [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/en_us/streams/latest/dev/monitoring-with-cloudwatch.html){:target="_blank"}

### Instance Metrics

The `AWS/Kinesis` namespace includes the following instance metrics.

| Metric                                   | Description                                                                                                                                                                                                                       |
|:-------------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `IncomingBytes`                      | The number of bytes successfully placed into the Kinesis stream during the specified period. This metric includes bytes from `PutRecord` and `PutRecords`. Statistics Minimum, Maximum, and Average represent the number of bytes per single put operation within the specified period. Shard-level metric name: IncomingBytes. Dimensions: StreamName. Unit: Bytes                                                          |
| `IncomingRecords`                    | The number of records successfully placed into the Kinesis stream during the specified period. This metric includes records from `PutRecord` and `PutRecords`. Statistics Minimum, Maximum, and Average represent the number of records per single put operation within the specified period. Shard-level metric name: IncomingRecords. Dimensions: StreamName. Unit: Count                                                        |
| `WriteProvisionedThroughputExceeded` | The number of records rejected due to stream limits during the specified period. This metric includes limits from `PutRecord` and `PutRecords` operations. The most commonly used statistic for this metric is Average. When the Minimum value is not zero, records in the stream were throttled during the specified period. When the Maximum value is 0 (zero), no records in the stream were throttled during the specified period. Shard-level metric name: WriteProvisionedThroughputExceeded. Dimensions: StreamName. Unit: Count |
| `PutRecords.Bytes`                   | The number of bytes placed into the Kinesis stream using `PutRecords` during the specified period. Dimensions: StreamName. Unit: Bytes                                                                                                                                    |
| `PutRecords.Success`                 | The number of `PutRecords` operations measured where at least one record was successful in each Kinesis stream during the specified period. Dimensions: StreamName. Unit: Count                                                                                                                                                      |
| `PutRecords.Latency`                 | The time taken for each `PutRecords` operation measured during the specified period. Dimensions: StreamName. Unit: Milliseconds                                                                                                                                                                       |
| `PutRecords.FailedRecords`           | The number of records rejected due to internal failures in `PutRecords` operations measured in each Kinesis stream during the specified period. Occasional internal failures should be retried. Dimensions: StreamName. Unit: Count |
| `PutRecords.ThrottledRecords`        | The number of records rejected due to throttling in `PutRecords` operations measured in each Kinesis stream during the specified period. Dimensions: StreamName. Unit: Count |
| `PutRecords.TotalRecords`            | The total number of records measured in `PutRecords` operations in each Kinesis stream during the specified period. Dimensions: StreamName. Unit: Count |

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

> *Note: Fields in `tags` may change with subsequent updates.*
>
> Tip 1: The `name` value is the instance name, used for unique identification.