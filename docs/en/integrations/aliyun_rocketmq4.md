---
title: 'Aliyun RocketMQ4'
tags: 
  - Alibaba Cloud
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.'
__int_icon: 'icon/aliyun_rocketmq4'
dashboard:
  - desc: 'Aliyun RocketMQ4 Built-in Dashboard'
    path: 'dashboard/zh/aliyun_rocketmq4/'

monitor:
  - desc: 'Aliyun RocketMQ4 Monitor'
    path: 'monitor/zh/aliyun_rocketmq4/'
---

<!-- markdownlint-disable MD025 -->
# Aliyun RocketMQ4
<!-- markdownlint-enable -->

Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation
If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance(For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`)

To synchronize the monitoring data of  Aliyun RocketMQ cloud resources, we install the corresponding collection script：「 Guance Integration（Aliyun -RocketMQ 4.0）」(ID：`guance_aliyun_rocketmq4`)

Click "Install" and enter the corresponding parameters: Aliyun AK, Aliyun account name.。

tap "Deploy startup Script"，The system automatically creates Startup script sets，And automatically configure the corresponding startup script。
After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click "Run"，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column

[Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric  {#metric}
Configure Aliyun - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Aliyun CloudMonitor Metrics Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                | Metric Name      | Dimensions        | Statistics      | Uni     |
| ---- | ---- | ---- | ---- | ---- |
| ReadyMessages                       | ready messages(Group)                    | account_name,InstanceName | Average,Maximum | count      |
| ReadyMessagesPerGidTopic            | ready messages(Group&Topic)              | account_name,InstanceName | Average,Maximum | count      |
| ReceiveMessageCountPerGid           | receive message count(Group)        | account_name,InstanceName | Average,Maximum | count/min  |
| ReceiveMessageCountPerGidTopic      | receive message count(Group&Topic)  | account_name,InstanceName | Average,Maximum | count/min  |
| ReceiveMessageCountPerInstance      | receive message count per min(Instance) | account_name,InstanceName | Average,Maximum | count/min  |
| ReceiveMessageCountPerTopic         | receive message count per min(Topic)      | account_name,InstanceName | Average,Maximum | count/min  |
| SendDLQMessageCountPerGid           | send DLQ message count per min(Group)        | account_name,InstanceName | Average,Maximum | count/min  |
| SendDLQMessageCountPerGidTopic      | send DLQ message count per min(Group&Topic)  | account_name,InstanceName | Average,Maximum | count/min  |
| SendMessageCountPerInstance         | Send message count per min(Instance)     | account_name,InstanceName | Average,Maximum | count/min  |
| SendMessageCountPerTopic            | Send message count per min(Topic)        | account_name,InstanceName | Average,Maximum | count/min  |
| ThrottledReceiveRequestsPerGid      | throttled receive requests per min(GroupId)          | account_name,InstanceName | Average,Maximum | counts/min |
| ThrottledReceiveRequestsPerGidTopic | throttled receive requests per min(GroupId&Topic)    | account_name,InstanceName | Average,Maximum | counts/min |
| ThrottledReceiveRequestsPerInstance | throttled receive requests per min(Instance)         | account_name,InstanceName | Average,Maximum | counts/min |
| ThrottledSendRequestsPerInstance    | throttled send requests per min(Instance)         | account_name,InstanceName | Average,Maximum | counts/min |
| ThrottledSendRequestsPerTopic       | throttled send requests per min(Topic)            | account_name,InstanceName | Average,Maximum | counts/min |

## Object {#object}

The collected Aliyun RocketMQ4 object data structure can see the object data from 「Infrastructure-custom-defined」

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
