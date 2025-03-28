---
title: 'Alibaba Cloud RocketMQ5'
tags: 
  - Alibaba Cloud
summary: 'The display metrics of Alibaba Cloud RocketMQ 5.0 include message throughput, latency, reliability, and horizontal scalability.'
__int_icon: 'icon/aliyun_rocketmq'
dashboard:
  - desc: 'Alibaba Cloud RocketMQ5 built-in view'
    path: 'dashboard/en/aliyun_rocketmq5/'

monitor:
  - desc: 'Alibaba Cloud RocketMQ5 monitor'
    path: 'monitor/en/aliyun_rocketmq5/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud RocketMQ5
<!-- markdownlint-enable -->

The display metrics of Alibaba Cloud RocketMQ 5.0 include message throughput, latency, reliability, and horizontal scalability.


## Configuration {#config}

### Install Func

It is recommended to activate the <<< custom_key.brand_name >>> integration - extension - hosted Func: all prerequisites are automatically installed, please continue with the script installation

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of Alibaba Cloud RocketMQ5, we install the corresponding collection script: 「<<< custom_key.brand_name >>> Integration (Alibaba Cloud-RocketMQ 5.0)」(ID: `guance_aliyun_rocketmq5`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in the 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to execute it immediately without waiting for the scheduled time. Wait a moment, you can check the execution task records and corresponding logs.

We default collect some configurations, details see the Metrics section.

[Configure custom cloud object metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding task has the corresponding automatic trigger configuration, and at the same time, you can check the corresponding task records and logs for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, under 「Infrastructure / Custom」, check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud - Cloud Monitoring, the default metric sets are as follows, more metrics can be collected through configuration [Alibaba Cloud Cloud Monitoring Metric Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| MetricName | MetricCategory | MetricDescribe | Dimensions | Statistics | Unit | MinPeriods |
| :--------- | :------------- | :------------- | :--------- | :--------- | :--- | :--------- |
| `ConsumerLag`                         | **rocketmq** | Message backlog amount(Group)                      | userId,instanceId,groupId       | Sum     | count        | 60 s |
| `ConsumerLagLatencyPerGid`            | **rocketmq** | Message processing delay time(GroupId)              | userId,instanceId,groupId       | Maximum | milliseconds | 60 s |
| `ConsumerLagLatencyPerGidTopic`       | **rocketmq** | Message processing delay time(GroupId&Topic)        | userId,instanceId,topic,groupId | Maximum | milliseconds | 60 s |
| `ConsumerLagPerGidTopic`              | **rocketmq** | Message backlog amount(Group&Topic)                | userId,instanceId,groupId,topic | Sum     | count        | 60 s |
| `InstanceApiCallTps`                  | **rocketmq** | Instance API call frequency(Instance)              | userId,instanceId               | Sum     | countSecond  | 60 s |
| `InstanceInternetFlowoutBandwidth`    | **rocketmq** | Public network downstream traffic bandwidth for 5.0 series instances           | userId,instanceId               | Sum     | bytes/Second | 60 s |
| `InstanceReceiveApiCallTps`           | **rocketmq** | Consumption API call TPS peak for 5.0 series instances     | userId,instanceId               | Maximum | countSecond  | 60 s |
| `InstanceSendApiCallTps`              | **rocketmq** | Send API call TPS peak for 5.0 series instances     | userId,instanceId               | Maximum | countSecond  | 60 s |
| `InstanceStorageSize`                 | **rocketmq** | Storage size for 5.0 series instances                   | userId,instanceId               | Sum     | Bytes        | 60 s |
| `ReadyMessageQueueTime`               | **rocketmq** | Ready message queue time(Group)              | userId,instanceId,groupId       | Maximum | milliseconds | 60 s |
| `ReadyMessageQueueTimePerGidTopic`    | **rocketmq** | Ready message queue time(Group&Topic)        | userId,instanceId,groupId,topic | Maximum | milliseconds | 60 s |
| `ReadyMessages`                       | **rocketmq** | Ready message quantity(Group)                    | userId,instanceId,groupId       | Sum     | count        | 60 s |
| `ReadyMessagesPerGidTopic`            | **rocketmq** | Ready message quantity(Group&Topic)              | userId,instanceId,groupId,topic | Sum     | count        | 60 s |
| `ReceiveMessageCountPerGid`           | **rocketmq** | Number of messages received per minute by consumer(Group)        | userId,instanceId,groupId       | Sum     | count/min    | 60 s |
| `ReceiveMessageCountPerGidTopic`      | **rocketmq** | Number of messages received per minute by consumer(Group&Topic)  | userId,instanceId,topic,groupId | Sum     | count/min    | 60 s |
| `ReceiveMessageCountPerInstance`      | **rocketmq** | Number of messages received per minute by consumer(Instance) | userId,instanceId               | Sum     | count/min    | 60 s |
| `ReceiveMessageCountPerTopic`         | **rocketmq** | Number of messages received per minute by consumer(Topic)      | userId,instanceId,topic         | Sum     | count/min    | 60 s |
| `SendDLQMessageCountPerGid`           | **rocketmq** | Number of dead-letter messages generated per minute(Group)        | userId,instanceId,groupId       | Sum     | count/min    | 60 s |
| `SendDLQMessageCountPerGidTopic`      | **rocketmq** | Number of dead-letter messages generated per minute(Group&Topic)  | userId,instanceId,groupId,topic | Sum     | count/min    | 60 s |
| `SendMessageCountPerInstance`         | **rocketmq** | Number of messages sent per minute by producer(Instance)     | userId,instanceId               | Sum     | count/min    | 60 s |
| `SendMessageCountPerTopic`            | **rocketmq** | Number of messages sent per minute by producer(Topic)        | userId,instanceId,topic         | Sum     | count/min    | 60 s |
| `ThrottledReceiveRequestsPerGid`      | **rocketmq** | Number of throttled consumption requests per minute(GroupId)          | userId,instanceId,groupId       | Sum     | counts/min   | 60 s |
| `ThrottledReceiveRequestsPerGidTopic` | **rocketmq** | Number of throttled consumption requests per minute(GroupId&Topic)    | userId,instanceId,topic,groupId | Sum     | counts/min   | 60 s |
| `ThrottledReceiveRequestsPerInstance` | **rocketmq** | Number of throttled consumption requests per minute(Instance)         | userId,instanceId               | Sum     | counts/min   | 60 s |
| `ThrottledSendRequestsPerInstance`    | **rocketmq** | Number of throttled send requests per minute(Instance)         | userId,instanceId               | Sum     | counts/min   | 60 s |
| `ThrottledSendRequestsPerTopic`       | **rocketmq** | Number of throttled send requests per minute(Topic)            | userId,instanceId,topic         | Sum     | counts/min   | 60 s |

## Objects {#object}

The object data structure of Alibaba Cloud RocketMQ5 that has been collected can be viewed from 「Infrastructure-Custom」.

```json
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
  "regionId": "cn-hangzhou",
  "startTime": "2023-08-21 10:54:24",
  "accountInfo": "{\"username\": \"If02i2f3f4nYtUsA\"}",
  "class": "aliyun_rocketmq",
  "instanceQuotas": "[{\"quotaName\": \"MAX_TPS\", \"totalCount\": 500}, {\"quotaName\": \"SCALING_TPS_MAX\", \"totalCount\": 0}, {\"quotaName\": \"STORAGE_SIZE\", \"usedCount\": 0.109}, {\"quotaName\": \"TOPIC_COUNT\", \"totalCount\": 100, \"usedCount\": 1}, {\"quotaName\": \"CONSUMER_GROUP_COUNT\", \"totalCount\": 1000, \"usedCount\": 1}]",
  "releaseTime": "2123-08-29 00:00:00",
  "create_time": 1692600804719,
  "groupCount": "1",
  "networkInfo": "{\"endpoints\": [{\"endpointType\": \"TCP_VPC\", \"endpointUrl\": \"rmq-cn-wwo3cwoyn0b-vpc.cn-hangzhou.rmq.aliyuncs.com:8080\"}, {\"endpointType\": \"TCP_INTERNET\", \"endpointUrl\": \"rmq-cn-wwo3cwoyn0b.cn-hangzhou.rmq.aliyuncs.com:8080\"}], \"internetInfo\": {\"flowOutBandwidth\": 1, \"flowOutType\": \"payByBandwidth\", \"internetSpec\": \"enable\"}, \"vpcInfo\": {\"vSwitchId\": \"vsw-bp1qzepqz845moheet831\", \"vpcId\": \"vpc-bp1pftfpllxna4t75e73v\"}}",
  "instanceName": "rmq-cn-wwo3cwoyn0b",
  "resourceGroupId": "rg-acfmv3ro3xnfwaa",
  "commodityCode": "ons_rmqpost_public_cn",
  "seriesCode": "standard",
  "subSeriesCode": "single_node",
  "status": "RUNNING",
  "updateTime": "2023-08-21 10:57:31",
  "account_name": "guance",
  "bid": "26842",
  "date": 1692600804000,
  "name": "rmq-cn-wwo3cwoyn0b",
  "cloud_provider": "aliyun",
  "date_ns": 0,
  "instanceId": "rmq-cn-wwo3cwoyn0b",
  "productInfo": "{\"autoScaling\": false, \"messageRetentionTime\": 72, \"msgProcessSpec\": \"rmq.s1.micro\", \"sendReceiveRatio\": 0.5, \"supportAutoScaling\": false}"
}
```