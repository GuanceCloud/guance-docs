---
title: 'Alibaba Cloud RocketMQ4'
tags: 
  - Alibaba Cloud
summary: 'The displayed metrics for Alibaba Cloud RocketMQ 4.0 include message throughput, latency, reliability, and horizontal scalability.'
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

The displayed metrics for Alibaba Cloud RocketMQ 4.0 include message throughput, latency, reliability, and horizontal scalability.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Tip: Prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant read-only permissions `ReadOnlyAccess`)

To synchronize monitoring data from Alibaba Cloud RocketMQ4, we install the corresponding collection script: 「Guance Integration (Alibaba Cloud-RocketMQ 4.0)」(ID: `guance_aliyun_rocketmq4`).

After clicking 【Install】, enter the required parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Additionally, you can see the corresponding automatic trigger configuration under 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

We default to collecting some configurations; for details, see the Metrics section.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. Confirm in 「Management / Automatic Trigger Configuration」that the corresponding task has the corresponding automatic trigger configuration. You can also check the task records and logs to see if there are any abnormalities.
2. In the Guance platform, check under 「Infrastructure / Custom」whether asset information exists.
3. In the Guance platform, check under 「Metrics」whether the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Alibaba Cloud Cloud Monitor, the default metric set is as follows. More metrics can be collected through configuration. [Details of Alibaba Cloud Cloud Monitor Metrics](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                | Metric Name      | Dimensions        | Statistics      | Unit     |
| ---- | ---- | ---- | ---- | ---- |
| ReadyMessages                       | Ready Messages (Group)                    | account_name,InstanceName | Average,Maximum | count      |
| ReadyMessagesPerGidTopic            | Ready Messages (Group&Topic)              | account_name,InstanceName | Average,Maximum | count      |
| ReceiveMessageCountPerGid           | Number of Messages Received per Minute by Consumer (Group)        | account_name,InstanceName | Average,Maximum | count/min  |
| ReceiveMessageCountPerGidTopic      | Number of Messages Received per Minute by Consumer (Group&Topic)  | account_name,InstanceName | Average,Maximum | count/min  |
| ReceiveMessageCountPerInstance      | Number of Messages Received per Minute by Consumer (Instance) | account_name,InstanceName | Average,Maximum | count/min  |
| ReceiveMessageCountPerTopic         | Number of Messages Received per Minute by Consumer (Topic)      | account_name,InstanceName | Average,Maximum | count/min  |
| SendDLQMessageCountPerGid           | Number of Dead Letter Messages Generated per Minute (Group)        | account_name,InstanceName | Average,Maximum | count/min  |
| SendDLQMessageCountPerGidTopic      | Number of Dead Letter Messages Generated per Minute (Group&Topic)  | account_name,InstanceName | Average,Maximum | count/min  |
| SendMessageCountPerInstance         | Number of Messages Sent per Minute by Producer (Instance)     | account_name,InstanceName | Average,Maximum | count/min  |
| SendMessageCountPerTopic            | Number of Messages Sent per Minute by Producer (Topic)        | account_name,InstanceName | Average,Maximum | count/min  |
| ThrottledReceiveRequestsPerGid      | Number of Throttled Consumption Requests per Minute (GroupId)          | account_name,InstanceName | Average,Maximum | counts/min |
| ThrottledReceiveRequestsPerGidTopic | Number of Throttled Consumption Requests per Minute (GroupId&Topic)    | account_name,InstanceName | Average,Maximum | counts/min |
| ThrottledReceiveRequestsPerInstance | Number of Throttled Consumption Requests per Minute (Instance)         | account_name,InstanceName | Average,Maximum | counts/min |
| ThrottledSendRequestsPerInstance    | Number of Throttled Sending Requests per Minute (Instance)         | account_name,InstanceName | Average,Maximum | counts/min |
| ThrottledSendRequestsPerTopic       | Number of Throttled Sending Requests per Minute (Topic)            | account_name,InstanceName | Average,Maximum | counts/min |

## Objects {#object}

The object data structure of Alibaba Cloud RocketMQ4 collected can be viewed under 「Infrastructure-Custom」.

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