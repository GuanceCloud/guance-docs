---
title: 'Amazon MQ for RabbitMQ'
tags: 
  - AWS
summary: 'Amazon MQ supports industry-standard APIs and protocols, managing and maintaining message brokers, and automatically providing infrastructure for high availability.'
__int_icon: 'icon/aws_mq_rabbitmq'
dashboard:
  - desc: 'Amazon MQ for RabbitMQ'
    path: 'dashboard/en/aws_mq_rabbitmq'
---

<!-- markdownlint-disable MD025 -->
# Amazon MQ
<!-- markdownlint-enable -->

Amazon MQ supports industry-standard APIs and protocols, managing and maintaining message brokers, and automatically providing infrastructure for high availability.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Prepare an Amazon cloud AK that meets the requirements in advance (for simplicity, you can directly grant CloudWatch read-only access `CloudWatchReadOnlyAccess`).

To synchronize monitoring data from Amazon MQ, install the corresponding collection script: "Guance Integration (AWS-MQ Collection)" (ID: `guance_aws_mq`).

After clicking 【Install】, input the corresponding parameters: AWS AK ID, AWS AK SECRET, account_name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set, configuring the corresponding startup script automatically. In the startup script, ensure that 'regions' match the actual regions where instances are located.

After enabling, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately run it once without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, enable the corresponding log collection script. To collect billing data, enable the cloud billing collection script.

By default, we collect some configurations. For more details, see [Configuration Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}

### Verification

1. Confirm in "Manage / Automatic Trigger Configuration" whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any anomalies.
2. In the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. In the Guance platform, under "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}

After configuring Amazon CloudWatch, the default metric sets are as follows. You can configure to collect more metrics:

[Amazon CloudWatch Amazon MQ Metric Details](https://docs.amazonaws.cn/amazon-mq/latest/developer-guide/security-logging-monitoring-cloudwatch.html){:target="_blank"}

### Amazon MQ for RabbitMQ

| Metric Name | Unit | Description |
| :---: |  :---: | :---: |
|ExchangeCount|Count|The total number of exchanges configured on the broker.|
|QueueCount|Count|The total number of queues configured on the broker.|
|ConnectionCount|Count|The total number of connections established on the broker.|
|ChannelCount|Count|The total number of channels established on the broker.|
|ConsumerCount|Count|The total number of consumers connected to the broker.|
|MessageCount|Count|The total number of messages in the queue. The generated number is the sum of ready and unacknowledged messages on the broker.|
|MessageReadyCount|Count|The total number of ready messages in the queue.|
|MessageUnacknowledgedCount|Count|The total number of unacknowledged messages in the queue.|
|PublishRate|Count|The rate at which messages are published to the broker. The generated number represents the number of messages collected per second during sampling.|
|ConfirmRate|Count|The rate at which the RabbitMQ server confirms that messages have been published. This metric can be compared with PublishRate to better understand your broker's performance. The generated number represents the number of messages collected per second during sampling.|
|AckRate|Count|The rate at which consumers acknowledge messages. The generated number represents the number of messages collected per second during sampling.|
|SystemCpuUtilization|Percentage|The percentage of allocated Amazon EC2 compute units currently used by the broker. For cluster deployments, this value represents the sum of the corresponding metric values for all three RabbitMQ nodes.|
|RabbitMQMemLimit|Bytes|The RAM limit for the RabbitMQ broker. For cluster deployments, this value represents the sum of the corresponding metric values for all three RabbitMQ nodes.|
|RabbitMQMemUsed|Bytes|The amount of RAM capacity used by the RabbitMQ broker. For cluster deployments, this value represents the sum of the corresponding metric values for all three RabbitMQ nodes.|
|RabbitMQDiskFreeLimit|Bytes|The disk limit for the RabbitMQ broker. For cluster deployments, this value represents the sum of the corresponding metric values for all three RabbitMQ nodes. This metric varies by instance size. For more information about Amazon MQ instance types, see Amazon MQ for RabbitMQ Instance Types.|
|RabbitMQDiskFree|Bytes|The total amount of free disk space available in the RabbitMQ broker. When disk usage exceeds its limit, the cluster blocks all producer connections. For cluster deployments, this value represents the sum of the corresponding metric values for all three RabbitMQ nodes.|
|RabbitMQFdUsed|Count|The number of file descriptors used. For cluster deployments, this value represents the sum of the corresponding metric values for all three RabbitMQ nodes.|
|`RabbitMQIOReadAverageTime`|Count|The average time (in milliseconds) it takes for RabbitMQ to perform one read operation. This value is proportional to the message size.|
|`RabbitMQIOWriteAverageTime`|Count|The average time (in milliseconds) it takes for RabbitMQ to perform one write operation. This value is proportional to the message size.|
</translation>