---
title: 'AWS KinesisAnalytics'
tags: 
  - AWS
summary: 'Use the script market "<<< custom_key.brand_name >>> cloud sync" series script package to synchronize cloud monitoring and cloud assets data to <<< custom_key.brand_name >>>'
__int_icon: 'icon/aws_kinesis_analytics'
dashboard:

  - desc: 'AWS KinesisAnalytics built-in views'
    path: 'dashboard/en/aws_kinesis_analytics'

monitor:
  - desc: 'AWS DocumentDB monitor'
    path: 'monitor/en/aws_kinesis_analytics'

cloudCollector:
  desc: 'Cloud collector'
  path: 'cloud-collector/en/aws_kinesis_analytics'
---

<!-- markdownlint-disable MD025 -->
# AWS KinesisAnalytics
<!-- markdownlint-enable -->

Use the script market "<<< custom_key.brand_name >>> cloud sync" series script package to synchronize cloud monitoring and cloud assets data to <<< custom_key.brand_name >>>


## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - managed Func: all prerequisites are automatically installed, please continue with script installation.

If you deploy Func by yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Script Installation

> Note: Please prepare the required Amazon AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

#### Managed Edition Script Activation

1. Log in to <<< custom_key.brand_name >>> console
2. Click on the 【Manage】 menu, select 【Cloud Account Management】
3. Click 【Add Cloud Account】, choose 【AWS】, fill in the required information on the interface; if cloud account information has been configured before, skip this step
4. Click 【Test】, after a successful test click 【Save】, if the test fails, check whether the related configuration information is correct and retest
5. Click on the 【Cloud Account Management】 list to see the added cloud accounts, click on the corresponding cloud account, go to the detail page
6. Click the 【Integration】 button on the cloud account detail page, under the `Not Installed` list, find `AWS KinesisAnalytics`, click the 【Install】 button, a pop-up installation interface will appear for installation.

#### Manual Script Activation

1. Log in to the Func console, click 【Script Market】, enter the official script market, search:`guance_aws_kinesis_analytics`

2. After clicking 【Install】, input the corresponding parameters: AWS AK ID, AK Secret, and account name.

3. Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set, and automatically configure the corresponding startup script.

4. After enabling, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】, it will immediately execute once without waiting for the scheduled time. Wait a moment, you can view the execution task records and corresponding logs.

### Verification

1. In 「Management / Automatic Trigger Configuration」 confirm that the corresponding task has an automatic trigger configuration, and at the same time, you can view the corresponding task records and logs to check for any abnormalities.
2. In <<< custom_key.brand_name >>>, 「Infrastructure / Custom」 check if asset information exists.
3. In <<< custom_key.brand_name >>>, 「Metrics」 check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon-CloudWatch, the default metric set is as follows. You can collect more metrics through configuration. [Amazon CloudWatch Metric Details](https://docs.aws.amazon.com/en_us/kinesisanalytics/latest/java/metrics-dimensions.html){:target="_blank"}

| Metric                    | Description                                                   | Unit       |
| :---------------------- | :---------------------------------------------------- | :----------|
| `cpuUtilization` | Overall percentage of CPU utilization in the Task Manager. For example, if there are five Task Managers, Kinesis Data Analytics will publish five samples of this metric at each reporting interval. | Percentage  |
| `containerCPUUtilization` | Total percentage of CPU utilization in the Task Manager containers in the Flink application cluster. For example, if there are five Task Managers and thus five TaskManager containers, Kinesis Data Analytics publishes 2 * 5 samples of this metric every 1 minute reporting interval. |Percentage|
| `containerMemoryUtilization` | Overall percentage of memory utilization in the Task Manager containers in the Flink application cluster. For example, if there are five Task Managers and thus five TaskManager containers, Kinesis Data Analytics publishes 2 * 5 samples of this metric every 1 minute reporting interval. |Percentage|
| `containerDiskUtilization` | Overall percentage of disk utilization in the Task Manager containers in the Flink application cluster. For example, if there are five Task Managers and thus five TaskManager containers, Kinesis Data Analytics publishes 2 * 5 samples of this metric every 1 minute reporting interval. |Percentage|
| `heapMemoryUtilization` | Overall heap memory utilization of the Task Managers. For example, if there are five Task Managers, Kinesis Data Analytics will publish five samples of this metric at each reporting interval. |Percentage|
| `oldGenerationGCCount` | Total number of old garbage collection operations occurred across all Task Managers. |Count|
| `oldGenerationGCTime` | Total time spent executing old garbage collection operations. |Milliseconds|
| `threadCount` | Total number of live threads used by the application. |Count|


## Objects {#object}

The collected AWS KinesisAnalytics object data structure can be seen from 「Infrastructure-Custom」.

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

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
</translation>