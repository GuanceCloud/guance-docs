---
title: 'Aliyun RocketMQ 5'
tags: 
  - Alibaba Cloud
summary: 'Aliyun RocketMQ 5.0 display metrics including message throughput, latency, reliability, and horizontal scalability.'
__int_icon: 'icon/aliyun_rocketmq5'
dashboard:
  - desc: 'Aliyun  RocketMQ5 Monitoring View'
    path: 'dashboard/en/aliyun_rocketmq5/'

monitor:
  - desc: 'Aliyun  RocketMQ4 Monitor'
    path: 'monitor/en/aliyun_rocketmq5/'
---

<!-- markdownlint-disable MD025 -->
# Aliyun RocketMQ 5
<!-- markdownlint-enable -->

Aliyun RocketMQ 5.0 display metrics including message throughput, latency, reliability, and horizontal scalability.

## Configuration {#config}

### Install Func

It is recommended to enable the Observability Cloud Integration - Extension - Managed Edition Func: All prerequisites are automatically installed, please proceed with the script installation.

If you want to deploy Func on your own, please refer to [Deploy Func on Your Own](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare Aliyun Access Key (AK) that meets the requirements in advance (For simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data from Aliyun RocketMQ 5, we will install the corresponding collection script: "Observability Cloud Integration (Aliyun - RocketMQ 5.0)" (ID: `guance_aliyun_rocketmq5`).

After clicking "Install", enter the corresponding parameters: Aliyun AK, Aliyun account name.

Click "Deploy Startup Script", and the system will automatically create a `Startup` script collection and configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in "Management / Auto Trigger Configuration". Click "Execute" to perform immediately without waiting for the regular interval. After a brief moment, you can view the execution task records and corresponding logs.

We have default collections for certain configurations, details are in the "Metrics" section.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}

### Verification

1. In "Management / Auto Trigger Configuration", confirm whether the corresponding task has the automatic trigger configuration and check for task records and logs for any abnormalities.
2. In the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. In the Guance platform, under "Metrics", check for corresponding monitoring data.

## Metrics {#metric}
After configuring Aliyun Cloud Monitor, the default set of metrics are as follows. You can collect more metrics by configuring [Aliyun Cloud Monitor Metrics Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| MetricName | MetricCategory | MetricDescribe | Dimensions | Statistics | Unit | MinPeriods |
| :--------- | :------------- | :------------- | :--------- | :--------- | :--- | :--------- |
| ConsumerLag                         | **rocketmq** | Message Accumulation (Group)                | userId,instanceId,groupId       | Sum     | count        | 60 s |
| ConsumerLagLatencyPerGid            | **rocketmq** | Message Processing Latency (GroupId)       | userId,instanceId,groupId       | Maximum | milliseconds | 60 s |
| ConsumerLagLatencyPerGidTopic       | **rocketmq** | Message Processing Latency (GroupId&Topic) | userId,instanceId,topic,groupId | Maximum | milliseconds | 60 s |
| ConsumerLagPerGidTopic              | **rocketmq** | Message Accumulation (Group&Topic)          | userId,instanceId,groupId,topic | Sum     | count        | 60 s |
| InstanceApiCallTps                  | **rocketmq** | Instance API Call Frequency (Instance)     | userId,instanceId               | Sum     | countSecond  | 60 s |
| **InstanceInternetFlowoutBandwidth**    | **rocketmq** | 5.0 Series Instance Public Network Downstream Bandwidth | userId,instanceId               | Sum     | bytes/Second | 60 s |
| InstanceReceiveApiCallTps           | **rocketmq** | 5.0 Series Instance Consumer API Call TPS Peak | userId,instanceId               | Maximum | countSecond  | 60 s |
| InstanceSendApiCallTps              | **rocketmq** | 5.0 Series Instance Producer API Call TPS Peak | userId,instanceId               | Maximum | countSecond  | 60 s |
| InstanceStorageSize                 | **rocketmq** | 5.0 Series Instance Storage Size           | userId,instanceId               | Sum     | Bytes        | 60 s |
| ReadyMessageQueueTime               | **rocketmq** | Ready Message Queuing Time (Group)         | userId,instanceId,groupId       | Maximum | milliseconds | 60 s |
| ReadyMessageQueueTimePerGidTopic    | **rocketmq** | Ready Message Queuing Time (Group&Topic)   | userId,instanceId,groupId,topic | Maximum | milliseconds | 60 s |
| ReadyMessages                       | **rocketmq** | Ready Messages (Group)                    | userId,instanceId,groupId       | Sum     | count        | 60 s |
| ReadyMessagesPerGidTopic            | **rocketmq** | Ready Messages (Group&Topic)              | userId,instanceId,groupId,topic | Sum     | count        | 60 s |
| ReceiveMessageCountPerGid           | **rocketmq** | Consumer Received Message Count per Minute (Group) | userId,instanceId,groupId       | Sum     | count/min    | 60 s |
| ReceiveMessageCountPerGidTopic      | **rocketmq** | Consumer Received Message Count per Minute (Group&Topic) | userId,instanceId,topic,groupId | Sum     | count/min    | 60 s |
| ReceiveMessageCountPerInstance      | **rocketmq** | Consumer Received Message Count per Minute (Instance) | userId,instanceId               | Sum     | count/min    | 60 s |
| ReceiveMessageCountPerTopic         | **rocketmq** | Consumer Received Message Count per Minute (Topic) | userId,instanceId,topic         | Sum     | count/min    | 60 s |
| SendDLQMessageCountPerGid           | **rocketmq** | Number of Dead Letter Messages Generated per Minute (Group) | userId,instanceId,groupId       | Sum     | count/min    | 60 s |
| SendDLQMessageCountPerGidTopic      | **rocketmq** | Number of Dead Letter Messages Generated per Minute (Group&Topic) | userId,instanceId,groupId,topic | Sum     | count/min    | 60 s |
| SendMessageCountPerInstance         | **rocketmq** | Producer Sent Message Count per Minute (Instance) | userId,instanceId               | Sum     | count/min    | 60 s |
| SendMessageCountPerTopic            | **rocketmq** | Producer Sent Message Count per Minute (Topic) | userId,instanceId,topic         | Sum     | count/min    | 60 s |
| ThrottledReceiveRequestsPerGid      | **rocketmq** | Throttled Receive Requests per Minute (GroupId) | userId,instanceId,groupId       | Sum     | counts/min   | 60 s |
| ThrottledReceiveRequestsPerGidTopic | **rocketmq** | Throttled Receive Requests per Minute (GroupId&Topic) | userId,instanceId,topic,groupId | Sum     | counts/min   | 60 s |
| ThrottledReceiveRequestsPerInstance | **rocketmq** | Throttled Receive Requests per Minute (Instance) | userId,instanceId               | Sum     | counts/min   | 60 s |
| ThrottledSendRequestsPerInstance    | **rocketmq** | Throttled Send Requests per Minute (Instance) | userId,instanceId               | Sum     | counts/min   | 60 s |
| ThrottledSendRequestsPerTopic       | **rocketmq** | Throttled Send Requests per Minute (Topic) | userId,instanceId,topic         | Sum     | counts/min   | 60 s |

## Object {#object}

The data structure of Aliyun RocketMQ 5 collected, which can be seen from "Infrastructure - Custom"

```txt
{
  "serviceCode": "rmq",
  "__namespace": "custom_object",
  "createTime": "2023-08-21 10:54:25",
  "expireTime": "2123-08-22 00:00:00",
  "time": 1692600804692,
  "topicCount": "1",
  "userId": "1067807587588864",
  "__docid": "CO_d3bed3ab447566645796455f37fcb66c",
  "message": "{\"accountInfo\": {\"username\": \"If02i2f3f4nYtUsA\"}, \"aclInfo\": {\"aclType\": \"default\"}, \"bid\": \"26842\", \"commodityCode\": \"ons_rmqpost_public_cn\", \"createTime\": \"2023-08-21 10:54:25\", \"expireTime\": \"2123-08-22 00:00:00\", \"extConfig\": {\"aclType\": \"default\", \"autoScaling\": false, \"flowOutBandwidth\": 1, \"flowOutType\": \"payByBandwidth\", \"internetSpec\": \"enable\", \"messageRetentionTime\": 72, \"msgProcessSpec\": \"rmq.s1.micro\", \"sendReceiveRatio\": 0.5, \"supportAutoScaling\": false}, \"groupCount\": 1, \"instanceId\": \"rmq-cn-wwo3cwoyn0b\", \"instanceName\": \"rmq-cn-wwo3cwoyn0b\", \"instanceQuotas\": [{\"quotaName\": \"MAX_TPS\", \"totalCount\": 500}, {\"quotaName\": \"SCALING_TPS_MAX\", \"totalCount\": 0}, {\"quotaName\": \"STORAGE_SIZE\", \"usedCount\": 0.109}, {\"quotaName\": \"TOPIC_COUNT\", \"totalCount\": 100, \"usedCount\": 1}, {\"quotaName\": \"CONSUMER_GROUP_COUNT\", \"totalCount\": 1000, \"usedCount\": 1}], \"networkInfo\": {\"endpoints\": [{\"endpointType\": \"TCP_VPC\", \"endpointUrl\": \"rmq-cn-wwo3cwoyn0b-vpc.cn-hangzhou.rmq.aliyuncs.com:8080\"}, {\"endpointType\": \"TCP_INTERNET\", \"endpointUrl\": \"rmq-cn-wwo3cwoyn0b.cn-hangzhou.rmq.aliyuncs.com:8080\"}], \"internetInfo\": {\"flowOutBandwidth\": 1, \"flowOutType\": \"payByBandwidth\", \"internetSpec\": \"enable\"}, \"vpcInfo\": {\"vSwitchId\": \"vsw-bp1qzepqz845moheet831\", \"vpcId\": \"vpc-bp1pftfpllxna4t75e73v\"}}, \"paymentType\": \"PayAsYouGo\", \"productInfo\": {\"autoScaling\": false, \"messageRetentionTime\": 72, \"msgProcessSpec\": \"rmq.s1.micro\", \"sendReceiveRatio\": 0.5, \"supportAutoScaling\": false}, \"regionId\": \"cn-hangzhou\", \"releaseTime\": \"2123-08-29 00:00:00\", \"resourceGroupId\": \"rg-acfmv3ro3xnfwaa\", \"seriesCode\": \"standard\", \"serviceCode\": \"rmq\", \"software\": {\"maintainTime\": \"02:00-06:00\", \"softwareVersion\": \"5.0-rmq-20230818-2\"}, \"startTime\": \"2023-08-21 10:54:24\", \"status\": \"RUNNING\", \"subSeriesCode\": \"single_node\", \"tags\": [{\"key\": \"acs:rm:rgId\", \"value\": \"rg-acfmv3ro3xnfwaa\"}], \"topicCount\": 1, \"updateTime\": \"2023-08-21 10:57:31\", \"userId\": \"1067807587588864\"}",
  "paymentType": "PayAsYouGo",
  "regionId": "**cn-hangzhou**",
  "startTime": "2023-08-21 10:54:24",
  "accountInfo": "{\"username\": \"If02i2f3f4nYtUsA\"}",
  "class": "**aliyun_rocketmq**",
  "instanceQuotas": "[{\"quotaName\": \"MAX_TPS\", \"totalCount\": 500}, {\"quotaName\": \"SCALING_TPS_MAX\", \"totalCount\": 0}, {\"quotaName\": \"STORAGE_SIZE\", \"usedCount\": 0.109}, {\"quotaName\": \"TOPIC_COUNT\", \"totalCount\": 100, \"usedCount\": 1}, {\"quotaName\": \"CONSUMER_GROUP_COUNT\", \"totalCount\": 1000, \"usedCount\": 1}]",
  "releaseTime": "2123-08-29 00:00:00",
  "create_time": 1692600804719,
  "groupCount": "1",
  "networkInfo": "{\"endpoints\": [{\"endpointType\": \"TCP_VPC\", \"endpointUrl\": \"rmq-cn-wwo3cwoyn0b-vpc.cn-hangzhou.rmq.aliyuncs.com:8080\"}, {\"endpointType\": \"TCP_INTERNET\", \"endpointUrl\": \"rmq-cn-wwo3cwoyn0b.cn-hangzhou.rmq.aliyuncs.com:8080\"}], \"internetInfo\": {\"flowOutBandwidth\": 1, \"flowOutType\": \"payByBandwidth\", \"internetSpec\": \"enable\"}, \"vpcInfo\": {\"vSwitchId\": \"vsw-bp1qzepqz845moheet831\", \"vpcId\": \"**vpc-bp1pftfpllxna4t75e73v**\"}}",
  "instanceName": "**rmq-cn-wwo3cwoyn0b**",
  "resourceGroupId": "**rg-acfmv3ro3xnfwaa**",
  "commodityCode": "ons_rmqpost_public_cn",
  "seriesCode": "standard",
  "subSeriesCode": "single_node",
  "status": "RUNNING",
  "updateTime": "2023-08-21 10:57:31",
  "account_name": "guance",
  "bid": "26842",
  "date": 1692600804000,
  "name": "**rmq-cn-wwo3cwoyn0b**",
  "cloud_provider": "**aliyun**",
  "date_ns": 0,
  "instanceId": "**rmq-cn-wwo3cwoyn0b**",
  "productInfo": "{\"autoScaling\": false, \"messageRetentionTime\": 72, \"msgProcessSpec\": \"rmq.s1.micro\", \"sendReceiveRatio\": 0.5, \"supportAutoScaling\": false}"
}
