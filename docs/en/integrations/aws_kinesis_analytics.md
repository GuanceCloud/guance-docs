---
title: 'AWS KinesisAnalytics'
tags: 
  - AWS
summary: 'Use the script market "Guance Cloud Sync" series script packages to synchronize cloud monitoring and cloud assets data to Guance'
__int_icon: 'icon/aws_kinesis_analytics'
dashboard:

  - desc: 'AWS KinesisAnalytics built-in views'
    path: 'dashboard/en/aws_kinesis_analytics'

monitor:
  - desc: 'AWS DocumentDB Monitor'
    path: 'monitor/en/aws_kinesis_analytics'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_kinesis_analytics'
---

<!-- markdownlint-disable MD025 -->
# AWS KinesisAnalytics
<!-- markdownlint-enable -->

Use the script market "Guance Cloud Sync" series script packages to synchronize cloud monitoring and cloud assets data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable Guance integration - extension - DataFlux Func (Automata): all prerequisites will be automatically installed, please continue with the script installation

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize KinesisAnalytics cloud resources monitoring data, we install the corresponding collection script: "Guance Integration (AWS KinesisAnalytics Collection)" (ID: `guance_aws_kinesis_analytics)

After clicking 【Install】, enter the corresponding parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the scheduled time. After a while, you can view the execution task records and corresponding logs.

We default collect some configurations, for details see the metrics section [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and you can also check the corresponding task records and logs to see if there are any abnormalities.
2. On the Guance platform, in "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, in "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon - CloudWatch, the default metric set is as follows, you can collect more metrics through configuration [Amazon CloudWatch Metric Details](https://docs.aws.amazon.com/zh_cn/kinesisanalytics/latest/java/metrics-dimensions.html){:target="_blank"}

| Metrics                    | Description                                                   | Unit       |
| :---------------------- | :---------------------------------------------------- | :----------|
| `cpuUtilization` | The overall percentage of CPU utilization in Task Managers. For example, if there are five Task Managers, Kinesis Data Analytics publishes five samples of this metric at each reporting interval. | Percentage  |
| `containerCPUUtilization` | The overall percentage of CPU utilization in Task Manager containers within the Flink application cluster. For example, if there are five Task Managers and correspondingly five TaskManager containers, Kinesis Data Analytics publishes 2 * 5 samples of this metric every 1 minute reporting interval. |Percentage|
| `containerMemoryUtilization` | The overall percentage of memory utilization in Task Manager containers within the Flink application cluster. For example, if there are five Task Managers and correspondingly five TaskManager containers, Kinesis Data Analytics publishes 2 * 5 samples of this metric every 1 minute reporting interval. |Percentage|
| `containerDiskUtilization` | The overall percentage of disk utilization in Task Manager containers within the Flink application cluster. For example, if there are five Task Managers and correspondingly five TaskManager containers, Kinesis Data Analytics publishes 2 * 5 samples of this metric every 1 minute reporting interval. |Percentage|
| `heapMemoryUtilization` | The overall heap memory utilization of Task Managers. For example, if there are five Task Managers, Kinesis Data Analytics publishes five samples of this metric at each reporting interval. |Percentage|
| `oldGenerationGCCount` | The total number of old garbage collection operations that occurred in all Task Managers. |Count|
| `oldGenerationGCTime` | The total time spent performing old garbage collection operations. |Milliseconds|
| `threadCount` | The total number of live threads used by the application. |Count|


## Objects {#object}

The collected AWS KinesisAnalytics object data structure can be seen from "Infrastructure - Custom"

```json
{
  "measurement": "aws_kinesis_analytics",
  "tags": {
    "ApplicationARN": "arn:aws-cn:xxxx:xxxx",
    "ApplicationMode": "STREAMING",
    "ApplicationName": "zsh_test",
    "ApplicationStatus": "RUNNING",
    "ApplicationVersionId": "3",
    "RegionId": "cn-northwest-1",
    "RuntimeEnvironment": "FLINK-1_15",
    "name": "zsh_test"
  },
  "fields": {
    "message"     : "{Instance JSON data}"
  }
}

```

> *Note: The fields in `tags` and `fields` may change with subsequent updates*