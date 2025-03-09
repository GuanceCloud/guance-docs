---
title: 'AWS KinesisAnalytics'
tags: 
  - AWS
summary: 'Use the script packages in the Script Market of Guance Cloud Sync series to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/aws_kinesis_analytics'
dashboard:

  - desc: 'Built-in views for AWS KinesisAnalytics'
    path: 'dashboard/en/aws_kinesis_analytics'

monitor:
  - desc: 'AWS DocumentDB Monitor'
    path: 'monitor/en/aws_kinesis_analytics'
---

<!-- markdownlint-disable MD025 -->
# AWS KinesisAnalytics
<!-- markdownlint-enable -->

Use the script packages in the Script Market of Guance Cloud Sync series to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed, please proceed with the script installation

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of KinesisAnalytics cloud resources, we install the corresponding collection script: "Guance Integration (AWS KinesisAnalytics Collection)" (ID: `guance_aws_kinesis_analytics`).

After clicking [Install], enter the corresponding parameters: Amazon AK, Amazon account name.

Click [Deploy Startup Script], the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

Additionally, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click [Execute] to immediately execute it once without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations; for more details, see the metrics section [Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric set is as follows. You can collect more metrics via configuration [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/en_us/kinesisanalytics/latest/java/metrics-dimensions.html){:target="_blank"}

| Metric                    | Description                                                   | Unit       |
| :---------------------- | :---------------------------------------------------- | :----------|
| `cpuUtilization` | Overall percentage of CPU utilization in Task Managers. For example, if there are five Task Managers, Kinesis Data Analytics will publish five samples of this metric at each reporting interval. | Percentage  |
| `containerCPUUtilization` | Overall percentage of CPU utilization in Task Manager containers of the Flink application cluster. For example, if there are five Task Managers, which correspond to five TaskManager containers, Kinesis Data Analytics publishes 2 * 5 samples of this metric every 1 minute. | Percentage |
| `containerMemoryUtilization` | Overall percentage of memory utilization in Task Manager containers of the Flink application cluster. For example, if there are five Task Managers, which correspond to five TaskManager containers, Kinesis Data Analytics publishes 2 * 5 samples of this metric every 1 minute. | Percentage |
| `containerDiskUtilization` | Overall percentage of disk utilization in Task Manager containers of the Flink application cluster. For example, if there are five Task Managers, which correspond to five TaskManager containers, Kinesis Data Analytics publishes 2 * 5 samples of this metric every 1 minute. | Percentage |
| `heapMemoryUtilization` | Overall heap memory utilization in Task Managers. For example, if there are five Task Managers, Kinesis Data Analytics will publish five samples of this metric at each reporting interval. | Percentage |
| `oldGenerationGCCount` | Total number of old generation garbage collection operations across all Task Managers. | Count |
| `oldGenerationGCTime` | Total time spent executing old generation garbage collection operations. | Milliseconds |
| `threadCount` | Total number of live threads used by the application. | Count |


## Objects {#object}

The structure of the collected AWS KinesisAnalytics object data can be viewed in "Infrastructure - Custom"

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
    "message"     : "{Instance JSON Data}"
  }
}

```

> *Note: The fields in `tags` and `fields` may change with subsequent updates*