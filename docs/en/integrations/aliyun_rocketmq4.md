---
title: 'Alibaba Cloud RocketMQ4'
tags: 
  - Alibaba Cloud
summary: 'The displayed metrics for Alibaba Cloud RocketMQ 4.0 include message throughput, latency, reliability, and horizontal scalability.'
__int_icon: 'icon/aliyun_rocketmq'
dashboard:
  - desc: 'Built-in views for Alibaba Cloud RocketMQ4'
    path: 'dashboard/en/aliyun_rocketmq4/'

monitor:
  - desc: 'Monitors for Alibaba Cloud RocketMQ4'
    path: 'monitor/en/aliyun_rocketmq4/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud RocketMQ4
<!-- markdownlint-enable -->

The displayed metrics for Alibaba Cloud RocketMQ 4.0 include message throughput, latency, reliability, and horizontal scalability.


## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - Extensions - DataFlux Func (Automata): All prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data from Alibaba Cloud RocketMQ4, we install the corresponding collection script: 「Guance Integration (Alibaba Cloud-RocketMQ 4.0)」(ID: `guance_aliyun_rocketmq4`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the startup script accordingly.

Additionally, you can see the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations; for more details, see the Metrics section.

[Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding tasks have the automatic trigger configuration, and check the task records and logs for any anomalies.
2. In the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. In the Guance platform, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud CloudMonitor, the default metric set is as follows. You can collect more metrics through configuration. [Details of Alibaba Cloud CloudMonitor metrics](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                | Metric Name      | Dimensions        | Statistics      | Unit     |
| ---- | ---- | ---- | ---- | ---- |
| ReadyMessages                       | Ready Messages Count(Group)                    | account_name,InstanceName | Average,Maximum | count      |
| ReadyMessagesPerGidTopic            | Ready Messages Count(Group&Topic)              | account_name,InstanceName | Average,Maximum | count      |
| ReceiveMessageCountPerGid           | Consumer Message Receive Count per Minute(Group) | account_name,InstanceName | Average,Maximum | count/min  |
| ReceiveMessageCountPerGidTopic      | Consumer Message Receive Count per Minute(Group&Topic) | account_name,InstanceName | Average,Maximum | count/min  |
| ReceiveMessageCountPerInstance      | Consumer Message Receive Count per Minute(Instance) | account_name,InstanceName | Average,Maximum | count/min  |
| ReceiveMessageCountPerTopic         | Consumer Message Receive Count per Minute(Topic) | account_name,InstanceName | Average,Maximum | count/min  |
| SendDLQMessageCountPerGid           | Dead Letter Queue Message Count per Minute(Group) | account_name,InstanceName | Average,Maximum | count/min  |
| SendDLQMessageCountPerGidTopic      | Dead Letter Queue Message Count per Minute(Group&Topic) | account_name,InstanceName | Average,Maximum | count/min  |
| SendMessageCountPerInstance         | Producer Message Send Count per Minute(Instance) | account_name,InstanceName | Average,Maximum | count/min  |
| SendMessageCountPerTopic            | Producer Message Send Count per Minute(Topic) | account_name,InstanceName | Average,Maximum | count/min  |
| ThrottledReceiveRequestsPerGid      | Throttled Receive Requests per Minute(Group) | account_name,InstanceName | Average,Maximum | counts/min |
| ThrottledReceiveRequestsPerGidTopic | Throttled Receive Requests per Minute(Group&Topic) | account_name,InstanceName | Average,Maximum | counts/min |
| ThrottledReceiveRequestsPerInstance | Throttled Receive Requests per Minute(Instance) | account_name,InstanceName | Average,Maximum | counts/min |
| ThrottledSendRequestsPerInstance    | Throttled Send Requests per Minute(Instance) | account_name,InstanceName | Average,Maximum | counts/min |
| ThrottledSendRequestsPerTopic       | Throttled Send Requests per Minute(Topic) | account_name,InstanceName | Average,Maximum | counts/min |

## Objects {#object}

The object data structure collected from Alibaba Cloud RocketMQ4 can be viewed under 「Infrastructure - Custom」.

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