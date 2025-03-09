---
title: 'Alibaba Cloud KafKa'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud KafKa includes instance disk usage, instance and topic message production volume, message production frequency, message consumption volume, and message consumption frequency. These metrics reflect the reliability of Kafka in handling large-scale message transmission and real-time data streams.'
__int_icon: 'icon/aliyun_kafka'
dashboard:
  - desc: 'Alibaba Cloud Kafka built-in views'
    path: 'dashboard/en/aliyun_kafka/'
monitor:
  - desc: 'Alibaba Cloud KafKa monitor'
    path: 'monitor/en/aliyun_kafka/'
---

<!-- markdownlint-disable MD025 -->

# Alibaba Cloud **KafKa**
<!-- markdownlint-enable -->

Alibaba Cloud `KafKa` includes instance disk usage, instance and topic message production volume, message production frequency, message consumption volume, and message consumption frequency. These metrics reflect the reliability of Kafka in handling large-scale message transmission and real-time data streams.


## Configuration {#config}

### Install Func

We recommend enabling Guance integration - expansion - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare the required Alibaba Cloud AK in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize monitoring data for the community edition of Alibaba Cloud `KafKa`, we install the corresponding collection script: Guance Integration (Alibaba Cloud - `KafKa` Collection) (ID: `startup__guance_aliyun_Kafka`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Additionally, you can see the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations; see the Metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」confirm that the corresponding automatic trigger configuration exists for the task and check the task records and logs for any anomalies.
2. On the Guance platform, under 「Infrastructure / Custom」check if asset information exists.
3. On the Guance platform, under 「Metrics」check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud CloudMonitor, the default metric set is as follows. You can collect more metrics through configuration. [Alibaba Cloud CloudMonitor Metric Details](https://cms.console.aliyun.com/metric-meta/acs_kafka/kafka?spm=a2c4g.11186623.0.0.2524166d7ZAGWy){:target="_blank"}

| Metric Id                | Metric Name      | Dimensions        | Statistics      | Unit     |
| ---- | ---- | ---- | ---- | ---- |
| instance_disk_capacity_Maximum | V2 Instance Disk Usage | userId,instanceId | Maximum | % |
| instance_message_input | Instance Message Production Volume | userId,instanceId | Value | bytes/s |
| instance_message_num_input | Instance Message Production Count | userId,instanceId | Value | countSecond |
| instance_message_output | Instance Message Consumption Volume | userId,instanceId | Value | bytes/s |
| instance_reqs_input | Instance Message Send Frequency | userId,instanceId | Value | countSecond   |
| instance_reqs_output | Instance Message Consumption Frequency | userId,instanceId | Value | countSecond |
| topic_message_input | Topic Message Production Volume | userId,instanceId | Value | bytes/s |
| topic_message_num_input | Topic Message Production Count | userId,instanceId | Value | countSecond |
| topic_message_output | Topic Message Consumption Volume | userId,instanceId | Value | bytes/s |
| topic_reqs_input | Topic Message Send Frequency | userId,instanceId | Value | countSecond |
| topic_reqs_output | Topic Message Consumption Frequency | userId,instanceId | Value | countSecond |



## Objects {#object}

The object data structure collected from Alibaba Cloud KafKa can be viewed under 「Infrastructure - Custom」

```json
{
  "measurement": "aliyun_kafka",
  "tags": {
    "InstanceId"        : "alikafka_post-cn-zsk3cluq100d",
    "InstanceName"      : "alikafka_post-cn-zsk3cluq100d",
    "RegionId"          : "cn-hangzhou",
    "ResourceGroupId"   : "rg-acfmv3ro3xnfwaa",
    "SpecType"          : "normal",
    "cloud_provider"    : "aliyun",
    "name"              : "alikafka_post-cn-zsk3cluq100d"
  },
  "fields": {
    "AllConfig"         : "{}",
    "CreateTime"        : 1692080715000,
    "DeployType"        : 5,
    "EipMax"            : 0,
    "ExpiredTime"       : 2007699914000,
    "IoMax"             : 20,
    "IoMaxSpec"         : "alikafka.hw.2xlarge",
    "PaidType"          : 1,
    "ServiceStatus"     : 0,
    "TopicNumLimit"     : 1000,
    "UsedGroupCount"    : 0,
    "UsedTopicCount"    : 0,
  }
}
```