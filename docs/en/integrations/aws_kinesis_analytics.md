---
title: 'AWS KinesisAnalytics'
tags: 
  - AWS
summary: 'Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance'
__int_icon: 'icon/aws_kinesis_analytics'
dashboard:

  - desc: 'AWS KinesisAnalytics Monitoring View'
    path: 'dashboard/en/aws_kinesis_analytics'

monitor:
  - desc: 'AWS DocumentDB Monitor'
    path: 'monitor/en/aws_kinesis_analytics'

cloudCollector:
  desc: 'cloud collector'
  path: 'cloud-collector/en/aws_kinesis_analytics'
---

<!-- markdownlint-disable MD025 -->
# AWS KinesisAnalytics
<!-- markdownlint-enable -->

 Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation

> Tip：Please prepare AWS AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of KinesisAnalytics cloud resources, we install the corresponding collection script：「Guance Integration（AWS KinesisAnalyticsCollect）」(ID：`guance_aws_kinesis_analytics`)

Click 【Install】 and enter the corresponding parameters: AWS AK, AWS account name.

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

Configure AWS Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/kinesisanalytics/latest/java/metrics-dimensions.html){:target="_blank"}


| Metric                    | Description                                                   |  Unit       |
| :---------------------- | :---------------------------------------------------- | :----------|
| `cpuUtilization` | Overall percentage of CPU utilization across task managers. For example, if there are five task managers, Kinesis Data Analytics publishes five samples of this metric per reporting interval. | Percentage  |
| `containerCPUUtilization` | Overall percentage of CPU utilization across task manager containers in Flink application cluster. For example, if there are five task managers, correspondingly there are five TaskManager containers and Kinesis Data Analytics publishes 2 * five samples of this metric per 1 minute reporting interval. |Percentage|
| `containerMemoryUtilization` | Overall percentage of memory utilization across task manager containers in Flink application cluster. For example, if there are five task managers, correspondingly there are five TaskManager containers and Kinesis Data Analytics publishes 2 * five samples of this metric per 1 minute reporting interval. |Percentage|
| `containerDiskUtilization` | Overall percentage of disk utilization across task manager containers in Flink application cluster. For example, if there are five task managers, correspondingly there are five TaskManager containers and Kinesis Data Analytics publishes 2 * five samples of this metric per 1 minute reporting interval. |Percentage|
| `heapMemoryUtilization` | Overall heap memory utilization across task managers. For example, if there are five task managers, Kinesis Data Analytics publishes five samples of this metric per reporting interval.   |Percentage|
| `oldGenerationGCCount` | The total number of old garbage collection operations that have occurred across all task managers. |Count |
| `oldGenerationGCTime` | The total time spent performing old garbage collection operations. |Milliseconds|
| `threadCount` | The total number of live threads used by the application. |Count|


## Object {#object}

The collected AWS KinesisAnalytics object data structure can be viewed in "Infrastructure - Custom" under the object data.

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

> *Note: The fields in `tags` and `fields` may be subject to changes in subsequent updates.*
