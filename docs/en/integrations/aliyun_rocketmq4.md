---
title: 'Alibaba Cloud RocketMQ4'
tags: 
  - Alibaba Cloud
summary: 'The display metrics of Alibaba Cloud RocketMQ 4.0 include message throughput, latency, reliability, and horizontal scalability.'
__int_icon: 'icon/aliyun_rocketmq'
dashboard:
  - desc: 'Alibaba Cloud RocketMQ4 built-in views'
    path: 'dashboard/en/aliyun_rocketmq4/'

monitor:
  - desc: 'Alibaba Cloud RocketMQ4 monitors'
    path: 'monitor/en/aliyun_rocketmq4/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud RocketMQ4
<!-- markdownlint-enable -->

The display metrics of Alibaba Cloud RocketMQ 4.0 include message throughput, latency, reliability, and horizontal scalability.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Please prepare the required Alibaba Cloud AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of Alibaba Cloud RocketMQ4, we install the corresponding collection script: 「Guance Integration (Alibaba Cloud-RocketMQ 4.0)」(ID: `guance_aliyun_rocketmq4`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to immediately execute it once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

We default collect some configurations, details are shown in the metrics section.

[Customize cloud object metrics configuration](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding task has the corresponding automatic trigger configuration. You can also check the corresponding task records and logs to see if there are any abnormalities.
2. On the Guance platform, under 「Infrastructure / Custom」, check if there is asset information.
3. On the Guance platform, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud - Cloud Monitoring, the default metric sets are as follows. More metrics can be collected through configuration. [Alibaba Cloud Cloud Monitoring Metric Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                | Metric Name      | Dimensions        | Statistics      | Unit     |
| ---- | ---- | ---- | ---- | ---- |
| ReadyMessages                       | Ready messages count(Group)                    | account_name,InstanceName | Average,Maximum | count      |
| ReadyMessagesPerGidTopic            | Ready messages count(Group&Topic)              | account_name,InstanceName | Average,Maximum | count      |
| ReceiveMessageCountPerGid           | Number of messages received by consumer per minute(Group)        | account_name,InstanceName | Average,Maximum | count/min  |
| ReceiveMessageCountPerGidTopic      | Number of messages received by consumer per minute(Group&Topic)  | account_name,InstanceName | Average,Maximum | count/min  |
| ReceiveMessageCountPerInstance      | Number of messages received by consumer per minute(Instance) | account_name,InstanceName | Average,Maximum | count/min  |
| ReceiveMessageCountPerTopic         | Number of messages received by consumer per minute(Topic)      | account_name,InstanceName | Average,Maximum | count/min  |
| SendDLQMessageCountPerGid           | Number of dead-letter messages generated per minute(Group)        | account_name,InstanceName | Average,Maximum | count/min  |
| SendDLQMessageCountPerGidTopic      | Number of dead-letter messages generated per minute(Group&Topic)  | account_name,InstanceName | Average,Maximum | count/min  |
| SendMessageCountPerInstance         | Number of messages sent by producer per minute(Instance)     | account_name,InstanceName | Average,Maximum | count/min  |
| SendMessageCountPerTopic            | Number of messages sent by producer per minute(Topic)        | account_name,InstanceName | Average,Maximum | count/min  |
| ThrottledReceiveRequestsPerGid      | Number of throttling occurrences when consuming per minute(GroupId)          | account_name,InstanceName | Average,Maximum | counts/min |
| ThrottledReceiveRequestsPerGidTopic | Number of throttling occurrences when consuming per minute(GroupId&Topic)    | account_name,InstanceName | Average,Maximum | counts/min |
| ThrottledReceiveRequestsPerInstance | Number of throttling occurrences when consuming per minute(Instance)         | account_name,InstanceName | Average,Maximum | counts/min |
| ThrottledSendRequestsPerInstance    | Number of throttling occurrences when sending per minute(Instance)         | account_name,InstanceName | Average,Maximum | counts/min |
| ThrottledSendRequestsPerTopic       | Number of throttling occurrences when sending per minute(Topic)            | account_name,InstanceName | Average,Maximum | counts/min |

## Objects {#object}

The object data structure of Alibaba Cloud RocketMQ4 that has been collected can be seen in the object data from 「Infrastructure - Custom」

```json
{
  "Endpoints": "{\"HttpInternalEndpoint\": \"http://xxx.mqrest.cn-hangzhou-internal.aliyuncs.com\", \"HttpInternetEndpoint\": \"http://xxx.mqrest.cn-hangzhou.aliyuncs.com\", \"HttpInternetSecureEndpoint\": \"\", \"TcpEndpoint\": \"http://MQ_INST_xxx.cn-hangzhou.mq-vpc.aliyuncs.com:8080\", \"TcpInternetEndpoint\": \"http://MQ_INST_xxx.cn-hangzhou.mq.aliyuncs.com:80\"}",
  "Remark": "xxx",
  "time": 1692250532822,
  "IndependentNaming": "True",
  "InstanceId": "MQ_INST_xxx",
  "InstanceName": "xxx",
  "InstanceStatus": "5",
  "__namespace": "custom_object",
  "account_name": "Aliyun",
  "cloud_provider": "aliyun",
  "date_ns": 0,
  "name": "MQ_INST_xxx",
  "spInstanceType": "1",
  "CreateTime": "1692163416000",
  "class": "aliyun_rocketmq",
  "create_time": 1692250533041,
  "date": 1692250532000,
  "message": "{\"CreateTime\": 1692163416000, \"Endpoints\": {\"HttpInternalEndpoint\": \"http://xxx.mqrest.cn-hangzhou-internal.aliyuncs.com\", \"HttpInternetEndpoint\": \"http://xxx.mqrest.cn-hangzhou.aliyuncs.com\", \"HttpInternetSecureEndpoint\": \"\", \"TcpEndpoint\": \"http://MQ_INST_xxx.cn-hangzhou.mq-vpc.aliyuncs.com:8080\", \"TcpInternetEndpoint\": \"http://MQ_INST_xxx.cn-hangzhou.mq.aliyuncs.com:80\"}, \"IndependentNaming\": true, \"InstanceId\": \"MQ_INST_xxx\", \"InstanceName\": \"xxx\", \"InstanceStatus\": 5, \"InstanceType\": 1, \"Remark\": \"xxx\", \"spInstanceId\": \"\", \"spInstanceType\": 1}",
  "InstanceType": "1",
  "__docid": "CO_54a991d1b5a86d2dc82d796110ee3476"
}
```