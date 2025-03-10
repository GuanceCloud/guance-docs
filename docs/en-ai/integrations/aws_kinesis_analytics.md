---
title: 'AWS KinesisAnalytics'
tags: 
  - AWS
summary: 'Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/aws_kinesis_analytics'
dashboard:

  - desc: 'Built-in views for AWS KinesisAnalytics'
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

Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

We recommend enabling the Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize KinesisAnalytics cloud resource monitoring data, install the corresponding collection script: "Guance Integration (AWS KinesisAnalytics Collection)" (ID: `guance_aws_kinesis_analytics)

After clicking [Install], enter the corresponding parameters: Amazon AK and Amazon account name.

Click [Deploy Startup Script], and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Additionally, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Click [Execute] to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations; for more details, see the metrics section [Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. Confirm in "Manage / Automatic Trigger Configuration" whether the corresponding tasks have the automatic trigger configuration. You can also check the task records and logs for any anomalies.
2. In the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. In the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric set is as follows. You can collect more metrics through configuration [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/kinesisanalytics/latest/java/metrics-dimensions.html){:target="_blank"}

| Metric                    | Description                                                   | Unit       |
| :---------------------- | :---------------------------------------------------- | :----------|
| `cpuUtilization` | The overall percentage of CPU utilization in Task Managers. For example, if there are five Task Managers, Kinesis Data Analytics publishes five samples of this metric at each reporting interval. | Percentage  |
| `containerCPUUtilization` | The overall percentage of CPU utilization in Task Manager containers within the Flink application cluster. For example, if there are five Task Managers and thus five TaskManager containers, Kinesis Data Analytics reports 2 * 5 samples of this metric every 1 minute. | Percentage |
| `containerMemoryUtilization` | The overall percentage of memory utilization in Task Manager containers within the Flink application cluster. For example, if there are five Task Managers and thus five TaskManager containers, Kinesis Data Analytics reports 2 * 5 samples of this metric every 1 minute. | Percentage |
| `containerDiskUtilization` | The overall percentage of disk utilization in Task Manager containers within the Flink application cluster. For example, if there are five Task Managers and thus five TaskManager containers, Kinesis Data Analytics reports 2 * 5 samples of this metric every 1 minute. | Percentage |
| `heapMemoryUtilization` | The overall percentage of heap memory utilization in Task Managers. For example, if there are five Task Managers, Kinesis Data Analytics publishes five samples of this metric at each reporting interval. | Percentage |
| `oldGenerationGCCount` | The total number of old generation garbage collection operations across all Task Managers. | Count |
| `oldGenerationGCTime` | The total time spent performing old generation garbage collection operations. | Milliseconds |
| `threadCount` | The total number of live threads used by the application. | Count |


## Objects {#object}

The structure of collected AWS KinesisAnalytics object data can be viewed under "Infrastructure - Custom"

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
    "message"     : "{instance JSON data}"
  }
}

```

> *Note: The fields in `tags` and `fields` may change with subsequent updates*