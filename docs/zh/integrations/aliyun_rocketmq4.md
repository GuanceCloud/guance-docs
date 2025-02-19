---
title: '阿里云 RocketMQ4'
tags: 
  - 阿里云
summary: '阿里云 RocketMQ 4.0 的展示指标包括消息吞吐量、延迟、可靠性和水平扩展能力等。'
__int_icon: 'icon/aliyun_rocketmq'
dashboard:
  - desc: '阿里云 RocketMQ4 内置视图'
    path: 'dashboard/zh/aliyun_rocketmq4/'

monitor:
  - desc: '阿里云 RocketMQ4 监控器'
    path: 'monitor/zh/aliyun_rocketmq4/'
---

<!-- markdownlint-disable MD025 -->
# 阿里云 RocketMQ4
<!-- markdownlint-enable -->

阿里云 RocketMQ 4.0 的展示指标包括消息吞吐量、延迟、可靠性和水平扩展能力等。


## 配置 {#config}

### 安装 Func

推荐开通 {{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步阿里云 RocketMQ4 的监控数据，我们安装对应的采集脚本：「 {{{ custom_key.brand_name }}}集成（阿里云-RocketMQ 4.0）」(ID：`guance_aliyun_rocketmq4`)

点击【安装】后，输入相应的参数：阿里云 AK、阿里云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在{{{ custom_key.brand_name }}}平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在{{{ custom_key.brand_name }}}平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好阿里云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [阿里云云监控指标详情](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                | Metric Name      | Dimensions        | Statistics      | Uni     |
| ---- | ---- | ---- | ---- | ---- |
| ReadyMessages                       | 已就绪消息量(Group)                    | account_name,InstanceName | Average,Maximum | count      |
| ReadyMessagesPerGidTopic            | 已就绪消息量(Group&Topic)              | account_name,InstanceName | Average,Maximum | count      |
| ReceiveMessageCountPerGid           | 消费者每分钟接收消息数量(Group)        | account_name,InstanceName | Average,Maximum | count/min  |
| ReceiveMessageCountPerGidTopic      | 消费者每分钟接收消息数量(Group&Topic)  | account_name,InstanceName | Average,Maximum | count/min  |
| ReceiveMessageCountPerInstance      | 消费者每分钟接收消息数的数量(Instance) | account_name,InstanceName | Average,Maximum | count/min  |
| ReceiveMessageCountPerTopic         | 消费者每分钟接收消息的数量(Topic)      | account_name,InstanceName | Average,Maximum | count/min  |
| SendDLQMessageCountPerGid           | 每分钟产生死信消息的数量(Group)        | account_name,InstanceName | Average,Maximum | count/min  |
| SendDLQMessageCountPerGidTopic      | 每分钟产生死信消息的数量(Group&Topic)  | account_name,InstanceName | Average,Maximum | count/min  |
| SendMessageCountPerInstance         | 生产者每分钟发送消息数量(Instance)     | account_name,InstanceName | Average,Maximum | count/min  |
| SendMessageCountPerTopic            | 生产者每分钟发送消息数量(Topic)        | account_name,InstanceName | Average,Maximum | count/min  |
| ThrottledReceiveRequestsPerGid      | 每分钟(GroupId)消费被限流次数          | account_name,InstanceName | Average,Maximum | counts/min |
| ThrottledReceiveRequestsPerGidTopic | 每分钟(GroupId&Topic)消费被限流次数    | account_name,InstanceName | Average,Maximum | counts/min |
| ThrottledReceiveRequestsPerInstance | 每分钟(Instance)消费被限流次数         | account_name,InstanceName | Average,Maximum | counts/min |
| ThrottledSendRequestsPerInstance    | 每分钟(Instance)发送被限流次数         | account_name,InstanceName | Average,Maximum | counts/min |
| ThrottledSendRequestsPerTopic       | 每分钟(Topic)发送被限流次数            | account_name,InstanceName | Average,Maximum | counts/min |

## 对象 {#object}

采集到的阿里云 RocketMQ4 的对象数据结构, 可以从「基础设施-自定义」里看到对象数据

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
