---
title: 'Amazon MQ for RabbitMQ'
tags: 
  - AWS
summary: 'Amazon MQ supports industry standard APIs and protocols to manage and maintain message brokers, and automatically provides infrastructure for high availability.'
__int_icon: 'icon/aws_mq_rabbitmq'
dashboard:
  - desc: 'Amazon MQ for RabbitMQ'
    path: 'dashboard/en/aws_mq_rabbitmq'
---

<!-- markdownlint-disable MD025 -->
# Amazon MQ
<!-- markdownlint-enable -->

Amazon MQ supports industry standard APIs and protocols to manage and maintain message brokers, and automatically provides infrastructure for high availability.

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automate)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip：Please prepare AWS AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of MemoryDB cloud resources, we install the corresponding collection script: `ID:guance_aws_mq`

Click 【Install】 and enter the corresponding parameters: AWS AK, AWS account name.

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」. Click【Run】，you can immediately execute once, without waiting for a regular time. After a while, you can view task execution records and corresponding logs。

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

Configure AWS Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Amazon MQ](https://docs.amazonaws.cn/amazon-mq/latest/developer-guide/security-logging-monitoring-cloudwatch.html){:target="_blank"}

### Amazon MQ for RabbitMQ

| Metric | **Unit** | Description |
| :---: |  :---: | :---: |
|ExchangeCount|Count|The total number of exchanges configured on the broker.|
|QueueCount|Count|The total number of queues configured on the broker.|
|ConnectionCount|Count|The total number of connections established on the broker.|
|ChannelCount|Count|The total number of channels established on the broker.|
|ConsumerCount|Count|The total number of consumers connected to the broker.|
|MessageCount|Count|The total number of messages in the queues.The number produced is the total sum of ready and unacknowledged messages on the broker.|
|MessageReadyCount|Count|The total number of ready messages in the queues.|
|MessageUnacknowledgedCount|Count|The total number of unacknowledged messages in the queues.|
|PublishRate|Count|The rate at which messages are published to the broker.The number produced represents the number of messages per second at the time of sampling.|
|ConfirmRate|Count|The rate at which the RabbitMQ server is confirming published messages. You can compare this metric with PublishRate to better understand how your broker is performing.The number produced represents the number of messages per second at the time of sampling.|
|AckRate|Count|The rate at which messages are being acknowledged by consumers.The number produced represents the number of messages per second at the time of sampling.|
|SystemCpuUtilization|Percent|The percentage of allocated Amazon EC2 compute units that the broker currently uses. For cluster deployments, this value represents the aggregate of all three RabbitMQ nodes' corresponding metric values.|
|RabbitMQMemLimit|Bytes|The RAM limit for a RabbitMQ broker. For cluster deployments, this value represents the aggregate of all three RabbitMQ nodes' corresponding metric values.|
|RabbitMQMemUsed|Bytes|The volume of RAM used by a RabbitMQ broker. For cluster deployments, this value represents the aggregate of all three RabbitMQ nodes' corresponding metric values.|
|RabbitMQDiskFreeLimit|Bytes|The disk limit for a RabbitMQ broker. For cluster deployments, this value represents the aggregate of all three RabbitMQ nodes' corresponding metric values. This metric is different per instance size. For more information about Amazon MQ instance types, see Amazon MQ for RabbitMQ instance types.|
|RabbitMQDiskFree|Bytes|The total volume of free disk space available in a RabbitMQ broker. When disk usage goes above its limit, the cluster will block all producer connections. For cluster deployments, this value represents the aggregate of all three RabbitMQ nodes' corresponding metric values.|
|RabbitMQFdUsed|Count|Number of file descriptors used. For cluster deployments, this value represents the aggregate of all three RabbitMQ nodes' corresponding metric values.|
|`RabbitMQIOReadAverageTime`|Count|The average time (in milliseconds) for RabbitMQ to perform one read operation. The value is proportional to the message size.|
|`RabbitMQIOWriteAverageTime`|Count|The average time (in milliseconds) for RabbitMQ to perform one write operation. The value is proportional to the message size.|

