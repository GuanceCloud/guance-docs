---
title: '阿里云 KafKa'
summary: '阿里云 KafKa 包括实例磁盘使用率、实例何topic 消息生产量、消息生产次数、消息消费量、消息消费次数等，这些指标反映了 Kafka 在处理大规模消息传递和实时数据流时的可靠性保证。
'
__int_icon: 'icon/aliyun_kafka'
dashboard:
  - desc: '阿里云 Kafka 内置视图'
    path: 'dashboard/zh/aliyun_kafka/'
monitor:
  - desc: '阿里云 KafKa 监控器'
    path: 'monitor/zh/aliyun_kafka/'
---

<!-- markdownlint-disable MD025 -->

# 阿里云 **KafKa**
<!-- markdownlint-enable -->

阿里云 `KafKa` 包括实例磁盘使用率、实例何topic 消息生产量、消息生产次数、消息消费量、消息消费次数等，这些指标反映了 Kafka 在处理大规模消息传递和实时数据流时的可靠性保证。


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步阿里云 `KafKa` 社区版的监控数据，我们安装对应的采集脚本：观测云集成（阿里云- `KafKa` 采集）」(ID：`startup__guance_aliyun_Kafka`)

点击【安装】后，输入相应的参数：阿里云 AK、阿里云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好阿里云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [阿里云云监控指标详情](https://cms.console.aliyun.com/metric-meta/acs_kafka/kafka?spm=a2c4g.11186623.0.0.2524166d7ZAGWy){:target="_blank"}

| Metric Id                | Metric Name      | Dimensions        | Statistics      | Unit     |
| ---- | ---- | ---- | ---- | ---- |
| instance_disk_capacity_Maximum | V2实例磁盘使用率 | userId,instanceId | Maximum | % |
| instance_message_input | 实例消息生产量 | userId,instanceId | Value | bytes/s |
| instance_message_num_input | 实例消息生产条数 | userId,instanceId | Value | countSecond |
| instance_message_output | 实例消息消费量    | userId,instanceId | Value | bytes/s |
| instance_reqs_input | 实例消息发送次数       | userId,instanceId | Value | countSecond   |
| instance_reqs_output | 实例消息消费次数   | userId,instanceId | Value | countSecond |
| topic_message_input | topic消息生产量 | userId,instanceId | Value | bytes/s |
| topic_message_num_input | topic消息生产条数 | userId,instanceId | Value | countSecond |
| topic_message_output | topic消息消费量 | userId,instanceId | Value | bytes/s |
| topic_reqs_input | topic消息发送次数 | userId,instanceId | Value | countSecond |
| topic_reqs_output | topic消息消费次数 | userId,instanceId | Value | countSecond |



## 对象 {#object}

采集到的阿里云 KafKa 的对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aliyun_kafka",
  "tags": {
    "InstanceId"        : "alikafka_post-cn-zsk3cluq100d",
    "InstanceName"      : "alikafka_post-cn-zsk3cluq100d",
    "RegionId"          : "cn-hangzhou",
    "ResourceGroupId"   : "rg-acfmv3ro3xnfwaa",
    "SpecType"          : "normal",
    "cloud_provider"    : "aliyun",
    "name"              : "alikafka_post-cn-zsk3cluq100d"
  },
  "fields": {
    "AllConfig"         : "{}",
    "CreateTime"        : 1692080715000,
    "DeployType"        : 5,
    "EipMax"            : 0,
    "ExpiredTime"       : 2007699914000,
    "IoMax"             : 20,
    "IoMaxSpec"         : "alikafka.hw.2xlarge",
    "PaidType"          : 1,
    "ServiceStatus"     : 0,
    "TopicNumLimit"     : 1000,
    "UsedGroupCount"    : 0,
    "UsedTopicCount"    : 0,
  }
}
```
