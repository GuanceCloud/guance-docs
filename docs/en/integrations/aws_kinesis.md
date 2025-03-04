---
title: 'AWS Kinesis'
tags: 
  - AWS
summary: 'Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.'
__int_icon: 'icon/aws_kinesis'
dashboard:

  - desc: 'AWS Kinesis Monitoring View'
    path: 'dashboard/en/aws_kinesis'

monitor:
  - desc: 'AWS Kinesis Monitor'
    path: 'monitor/en/aws_kinesis'

cloudCollector:
  desc: 'cloud collector'
  path: 'cloud-collector/en/aws_kinesis'
---


<!-- markdownlint-disable MD025 -->
# AWS Kinesis
<!-- markdownlint-enable -->

Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.


## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip：Please prepare AWS AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of AWS Kinesis cloud resources, we install the corresponding collection script: `ID:guance_aws_kinesis`

Click 【Install】 and enter the corresponding parameters: AWS AK, AWS account name.

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

Then, in the collection script, add the collector_configs and cloudwatch_change the regions in configs to the actual regions

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aws-kinesis/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure AWS Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/streams/latest/dev/monitoring-with-cloudwatch.html){:target="_blank"}

### Metric

`AWS/Kinesis` The namespace includes the following instance metrics 。

| Metric                                   | Description                                                                                                                                                                                                                                                                                                                                                                             |
|:-------------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `IncomingBytes`                      | The number of bytes successfully put to the Kinesis stream over the specified time period. This metric includes bytes from PutRecord and PutRecords operations. Minimum, Maximum, and Average statistics represent the bytes in a single put operation for the stream in the specified time period.Shard-level metric name: IncomingBytes.Dimensions: StreamName.Units: Bytes  |
| `IncomingRecords`                    | The number of records successfully put to the Kinesis stream over the specified time period. This metric includes record counts from PutRecord and PutRecords operations. Minimum, Maximum, and Average statistics represent the records in a single put operation for the stream in the specified time period.Shard-level metric name: IncomingRecords.Dimensions: StreamName.Units: Count      |
| `WriteProvisionedThroughputExceeded` | The number of records rejected due to throttling for the stream over the specified time period. This metric includes throttling from PutRecord and PutRecords operations. The most commonly used statistic for this metric is Average.When the Minimum statistic has a non-zero value, records were being throttled for the stream during the specified time period.When the Maximum statistic has a value of 0 (zero), no records were being throttled for the stream during the specified time period.Shard-level metric name: WriteProvisionedThroughputExceeded.Dimensions: StreamName.Units: Count |
| `PutRecords.Bytes`                   | The number of bytes put to the Kinesis stream using the PutRecords operation over the specified time period.Dimensions: StreamName.Units: Bytes                                          |
| `PutRecords.Success`                 | The number of PutRecords operations where at least one record succeeded, per Kinesis stream, measured over the specified time period.Dimensions: StreamName.Units: Count                                                                                                                                                                                                                                                       |
| `PutRecords.Latency`                 | The time taken per PutRecords operation, measured over the specified time period.Dimensions: StreamName.Units: Milliseconds                                                                                                                                                                                                                                                                                                                          |
| `PutRecords.FailedRecords`           | The number of records rejected due to internal failures in a PutRecords operation per Kinesis data stream, measured over the specified time period. Occasional internal failures are to be expected and should be retried.Dimensions: StreamName.Units: Count                                                                                                                                                                                                                                                                           |
| `PutRecords.ThrottledRecords`        | The number of records rejected due to throttling in a PutRecords operation per Kinesis data stream, measured over the specified time period.Dimensions: StreamName.Units: Count                                                                                                                                                                                                                                                                                                  |
| `utRecords.TotalRecords`             | The total number of records sent in a PutRecords operation per Kinesis data stream, measured over the specified time period.Dimensions: StreamName.Units: Count                                                                                                                                                                                                                                                                                                                     |
## Object {#object}

The collected AWS Kinesis object data structure, You can see the object data from「Infrastructure-Custom」

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

> *Note: The fields in 'tags' may change with subsequent updates*
>
> Tip 1: The 'name' value is the instance name and serves as a unique identifier
