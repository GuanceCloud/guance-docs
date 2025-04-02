---
title: 'AWS Kinesis'
tags: 
  - AWS
summary: 'Use the script packages in the script market named «<<< custom_key.brand_name >>> Cloud Sync» series to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>.'
__int_icon: 'icon/aws_kinesis'
dashboard:

  - desc: 'AWS Kinesis Monitoring View'
    path: 'dashboard/en/aws_kinesis'

monitor:
  - desc: 'AWS Kinesis Monitor'
    path: 'monitor/en/aws_kinesis'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_kinesis'
---


<!-- markdownlint-disable MD025 -->
# AWS Kinesis
<!-- markdownlint-enable -->

Use the script packages in the script market named «<<< custom_key.brand_name >>> Cloud Sync» series to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>.


## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> Integration - Extension - DataFlux Func (Automata): All prerequisites are automatically installed. Please continue with script installation.

If you deploy Func by yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a qualified Amazon AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

#### Enable Script for Hosted Version

1. Log in to <<< custom_key.brand_name >>> Console
2. Click on the 【Manage】 menu, select 【Cloud Account Management】
3. Click 【Add Cloud Account】, choose 【AWS】, fill in the required information on the interface. If you have already configured cloud account information before, skip this step.
4. Click 【Test】, after successful testing click 【Save】. If the test fails, check whether the relevant configuration information is correct and retest.
5. In the 【Cloud Account Management】 list, you can see the added cloud accounts. Click the corresponding cloud account and go to the details page.
6. Click the 【Integration】 button on the cloud account detail page. Under the `Not Installed` list, find `AWS Kinesis`, click the 【Install】 button, and install it via the pop-up installation interface.

#### Manually Enable Script

1. Log in to the Func console, click 【Script Market】, enter the official script market, and search: `guance_aws_kinesis`

2. After clicking 【Install】, input the corresponding parameters: AWS AK ID, AK Secret, and account name.

3. Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

4. After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to immediately run once without waiting for the scheduled time. Wait for a moment, then you can view the execution task records and corresponding logs.


### Verification

1. In 「Manage / Automatic Trigger Configuration」 confirm that the corresponding tasks have an automatic trigger configuration, and you can view the corresponding task records and logs to check for any abnormalities.
2. In <<< custom_key.brand_name >>>, 「Infrastructure / Custom」 check if there is asset information.
3. In <<< custom_key.brand_name >>>, 「Metrics」 check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon-Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration [Amazon Cloud Monitoring Metric Details](https://docs.aws.amazon.com/en_us/streams/latest/dev/monitoring-with-cloudwatch.html){:target="_blank"}

### Instance Metrics

The `AWS/Kinesis` namespace includes the following instance metrics.

| Metric                                   | Description                                                                                                                                                                                                                       |
|:-------------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `IncomingBytes`                      | The number of bytes successfully placed into the Kinesis stream during the specified period. This metric includes bytes from `PutRecord` and `PutRecords`. Statistics Minimum, Maximum, and Average indicate the number of bytes in a single put operation within the specified period. Shard-level metric name: IncomingBytes. Dimension: StreamName. Unit: Bytes                                                          |
| `IncomingRecords`                    | The number of records successfully placed into the Kinesis stream during the specified period. This metric includes records from `PutRecord` and `PutRecords`. Statistics Minimum, Maximum, and Average indicate the number of records in a single put operation within the specified period. Shard-level metric name: IncomingRecords. Dimension: StreamName. Unit: Count                                                        |
| `WriteProvisionedThroughputExceeded` | The number of records rejected due to stream limits during the specified period. This metric includes limits from `PutRecord` and `PutRecords` operations. The most commonly used statistic for this metric is Average. When the value of the Minimum statistic is not zero, records on the stream will be throttled during the specified period. When the value of the Maximum statistic is 0 (zero), no records on the stream will be throttled during the specified period. Shard-level metric name: WriteProvisionedThroughputExceeded. Dimension: StreamName. Unit: Count |
| `PutRecords.Bytes`                   | The number of bytes placed into the Kinesis stream using `PutRecords` during the specified time period. Dimension: StreamName. Unit: Bytes                                                                                                                                    |
| `PutRecords.Success`                 | The number of `PutRecords` operations measured per Kinesis stream during the specified period where at least one record succeeded. Dimension: StreamName. Unit: Count                                                                                                                                                      |
| `PutRecords.Latency`                 | The time taken for each `PutRecords` operation measured during the specified period. Dimension: StreamName. Unit: Milliseconds                                                                                                                                                                       |
| `PutRecords.FailedRecords`           | The number of records rejected due to internal errors. Measured for each `PutRecords` operation per Kinesis data stream during the specified period. Occasional internal failures should be retried. Dimension: StreamName. Unit: Count|
| `PutRecords.ThrottledRecords`        | The number of records rejected due to throttling limits. Measured for each `PutRecords` operation per Kinesis data stream during the specified period. Dimension: StreamName. Unit: Count|
| `PutRecords.TotalRecords`             | The total number of records measured for each `PutRecords` operation per Kinesis data stream during the specified period. Dimension: StreamName. Unit: Count|

## Objects {#object}

The collected AWS Kinesis object data structure can be viewed in 「Infrastructure - Custom」

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
> Tip 1: The value of `name` is the instance name, used for unique identification.
```