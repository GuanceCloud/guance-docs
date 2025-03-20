---
title: '阿里云 RocketMQ5'
tags: 
  - 阿里云
summary: '阿里云 RocketMQ 5.0 的展示指标包括消息吞吐量、延迟、可靠性和水平扩展能力等。'
__int_icon: 'icon/aliyun_rocketmq'
dashboard:
  - desc: '阿里云 RocketMQ5 内置视图'
    path: 'dashboard/zh/aliyun_rocketmq5/'

monitor:
  - desc: '阿里云 RocketMQ5 监控器'
    path: 'monitor/zh/aliyun_rocketmq5/'
---

<!-- markdownlint-disable MD025 -->
# 阿里云 RocketMQ5
<!-- markdownlint-enable -->

阿里云 RocketMQ 5.0 的展示指标包括消息吞吐量、延迟、可靠性和水平扩展能力等。


## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步阿里云 RocketMQ5 的监控数据，我们安装对应的采集脚本：「 <<< custom_key.brand_name >>>集成（阿里云-RocketMQ 5.0）」(ID：`guance_aliyun_rocketmq5`)

点击【安装】后，输入相应的参数：阿里云 AK、阿里云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好阿里云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [阿里云云监控指标详情](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| MetricName | MetricCategory | MetricDescribe | Dimensions | Statistics | Unit | MinPeriods |
| :--------- | :------------- | :------------- | :--------- | :--------- | :--- | :--------- |
| `ConsumerLag`                         | **rocketmq** | 消息堆积量(Group)                      | userId,instanceId,groupId       | Sum     | count        | 60 s |
| `ConsumerLagLatencyPerGid`            | **rocketmq** | 消息处理延迟时间(GroupId)              | userId,instanceId,groupId       | Maximum | milliseconds | 60 s |
| `ConsumerLagLatencyPerGidTopic`       | **rocketmq** | 消息处理延迟时间(GroupId&Topic)        | userId,instanceId,topic,groupId | Maximum | milliseconds | 60 s |
| `ConsumerLagPerGidTopic`              | **rocketmq** | 消息堆积量(Group&Topic)                | userId,instanceId,groupId,topic | Sum     | count        | 60 s |
| `InstanceApiCallTps`                  | **rocketmq** | 实例API调用频率(Instance)              | userId,instanceId               | Sum     | countSecond  | 60 s |
| `InstanceInternetFlowoutBandwidth`    | **rocketmq** | 5.0 系列实例公网下行流量带宽           | userId,instanceId               | Sum     | bytes/Second | 60 s |
| `InstanceReceiveApiCallTps`           | **rocketmq** | 5.0 系列实例消费 API 调用 TPS 峰值     | userId,instanceId               | Maximum | countSecond  | 60 s |
| `InstanceSendApiCallTps`              | **rocketmq** | 5.0 系列实例发送 API 调用 TPS 峰值     | userId,instanceId               | Maximum | countSecond  | 60 s |
| `InstanceStorageSize`                 | **rocketmq** | 5.0 系列实例存储大小                   | userId,instanceId               | Sum     | Bytes        | 60 s |
| `ReadyMessageQueueTime`               | **rocketmq** | 已就绪消息排队时间(Group)              | userId,instanceId,groupId       | Maximum | milliseconds | 60 s |
| `ReadyMessageQueueTimePerGidTopic`    | **rocketmq** | 已就绪消息排队时间(Group&Topic)        | userId,instanceId,groupId,topic | Maximum | milliseconds | 60 s |
| `ReadyMessages`                       | **rocketmq** | 已就绪消息量(Group)                    | userId,instanceId,groupId       | Sum     | count        | 60 s |
| `ReadyMessagesPerGidTopic`            | **rocketmq** | 已就绪消息量(Group&Topic)              | userId,instanceId,groupId,topic | Sum     | count        | 60 s |
| `ReceiveMessageCountPerGid`           | **rocketmq** | 消费者每分钟接收消息数量(Group)        | userId,instanceId,groupId       | Sum     | count/min    | 60 s |
| `ReceiveMessageCountPerGidTopic`      | **rocketmq** | 消费者每分钟接收消息数量(Group&Topic)  | userId,instanceId,topic,groupId | Sum     | count/min    | 60 s |
| `ReceiveMessageCountPerInstance`      | **rocketmq** | 消费者每分钟接收消息数的数量(Instance) | userId,instanceId               | Sum     | count/min    | 60 s |
| `ReceiveMessageCountPerTopic`         | **rocketmq** | 消费者每分钟接收消息的数量(Topic)      | userId,instanceId,topic         | Sum     | count/min    | 60 s |
| `SendDLQMessageCountPerGid`           | **rocketmq** | 每分钟产生死信消息的数量(Group)        | userId,instanceId,groupId       | Sum     | count/min    | 60 s |
| `SendDLQMessageCountPerGidTopic`      | **rocketmq** | 每分钟产生死信消息的数量(Group&Topic)  | userId,instanceId,groupId,topic | Sum     | count/min    | 60 s |
| `SendMessageCountPerInstance`         | **rocketmq** | 生产者每分钟发送消息数量(Instance)     | userId,instanceId               | Sum     | count/min    | 60 s |
| `SendMessageCountPerTopic`            | **rocketmq** | 生产者每分钟发送消息数量(Topic)        | userId,instanceId,topic         | Sum     | count/min    | 60 s |
| `ThrottledReceiveRequestsPerGid`      | **rocketmq** | 每分钟(GroupId)消费被限流次数          | userId,instanceId,groupId       | Sum     | counts/min   | 60 s |
| `ThrottledReceiveRequestsPerGidTopic` | **rocketmq** | 每分钟(GroupId&Topic)消费被限流次数    | userId,instanceId,topic,groupId | Sum     | counts/min   | 60 s |
| `ThrottledReceiveRequestsPerInstance` | **rocketmq** | 每分钟(Instance)消费被限流次数         | userId,instanceId               | Sum     | counts/min   | 60 s |
| `ThrottledSendRequestsPerInstance`    | **rocketmq** | 每分钟(Instance)发送被限流次数         | userId,instanceId               | Sum     | counts/min   | 60 s |
| `ThrottledSendRequestsPerTopic`       | **rocketmq** | 每分钟(Topic)发送被限流次数            | userId,instanceId,topic         | Sum     | counts/min   | 60 s |

## 对象 {#object}

采集到的阿里云 RocketMQ5 的对象数据结构, 可以从「基础设施-自定义」里看到对象数据

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

