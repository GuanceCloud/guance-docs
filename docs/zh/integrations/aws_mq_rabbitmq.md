---
title: 'Amazon MQ for RabbitMQ'
tags: 
  - AWS
summary: 'Amazon MQ 支持行业标准 API 和协议，对消息代理的管理和维护进行管理，并自动为高可用性提供基础设施。'
__int_icon: 'icon/aws_mq_rabbitmq'
dashboard:
  - desc: 'Amazon MQ for RabbitMQ'
    path: 'dashboard/zh/aws_mq_rabbitmq'
---

<!-- markdownlint-disable MD025 -->
# Amazon MQ
<!-- markdownlint-enable -->

Amazon MQ 支持行业标准 API 和协议，对消息代理的管理和维护进行管理，并自动为高可用性提供基础设施。


## 配置 {#config}

### 安装 Func

推荐开通 {{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### 安装脚本

> 提示：请提前准备好符合要求的亚马逊云 AK（简单起见，可直接授予CloudWatch只读权限`CloudWatchReadOnlyAccess`）

同步 Amazon MQ 的监控数据，我们安装对应的采集脚本：「{{{ custom_key.brand_name }}}集成（AWS-MQ 采集）」(ID：`guance_aws_mq`)

点击【安装】后，输入相应的参数：AWS AK ID、AWS AK SECRET、account_name。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。在启动脚本中，需要注意'regions' 与 实例实际所在 regions 保持一致。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

> 如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。

我们默认采集了一些配置, 具体见指标一栏[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在{{{ custom_key.brand_name }}}平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在{{{ custom_key.brand_name }}}平台，「指标」查看是否有对应监控数据

## 指标 {#metric}

配置好亚马逊-云监控,默认的指标集如下.可以通过配置的方式采集更多的指标:

[亚马逊云监控 Amazon MQ 指标详情](https://docs.amazonaws.cn/amazon-mq/latest/developer-guide/security-logging-monitoring-cloudwatch.html){:target="_blank"}

### Amazon MQ for RabbitMQ

| 指标名称 | 单位 | 描述 |
| :---: |  :---: | :---: |
|ExchangeCount|计数|在代理上配置的交换器总数。|
|QueueCount|计数|在代理上配置的队列总数。|
|ConnectionCount|计数|在代理上建立的连接总数。|
|ChannelCount|计数|在代理上建立的通道总数。|
|ConsumerCount|计数|连接到代理的使用者总数。|
|MessageCount|计数|队列中的消息总数。生成的数字是代理上已就绪和未确认的消息总和。|
|MessageReadyCount|计数|队列中已就绪的消息总数。|
|MessageUnacknowledgedCount|计数|队列中未确认的消息总数。|
|PublishRate|计数|向代理发布消息的速率。生成的数字表示采样时每秒采集的消息数。|
|ConfirmRate|计数|RabbitMQ 服务器确认已发布消息的速率。您可以将此指标与 PublishRate 进行比较，以更好地了解您的代理的表现。生成的数字表示采样时每秒采集的消息数。|
|AckRate|计数|使用者确认消息的速率。生成的数字表示采样时每秒采集的消息数。|
|SystemCpuUtilization|百分比|代理当前正在使用的已分配 Amazon EC2 计算单位的百分比。对于集群部署，此值表示所有三个 RabbitMQ 节点的相应指标值的总和。|
|RabbitMQMemLimit|字节|RabbitMQ 代理的 RAM 限制。对于集群部署，此值表示所有三个 RabbitMQ 节点的相应指标值的总和。|
|RabbitMQMemUsed|字节|RabbitMQ 代理使用的 RAM 容量。对于集群部署，此值表示所有三个 RabbitMQ 节点的相应指标值的总和。|
|RabbitMQDiskFreeLimit|字节|RabbitMQ 代理的磁盘限制。对于集群部署，此值表示所有三个 RabbitMQ 节点的相应指标值的总和。该指标因实例大小而异。有关 Amazon MQ 实例类型的更多信息，请参阅 Amazon MQ for RabbitMQ 实例类型。|
|RabbitMQDiskFree|字节|RabbitMQ 代理中可用的免费磁盘空间总量。当磁盘使用量超过其限制时，集群将阻止所有生产者连接。对于集群部署，此值表示所有三个 RabbitMQ 节点的相应指标值的总和。|
|RabbitMQFdUsed|计数|使用的文件描述符数。对于集群部署，此值表示所有三个 RabbitMQ 节点的相应指标值的总和。|
|`RabbitMQIOReadAverageTime`|计数|RabbitMQ 执行一次读取操作的平均时间（以毫秒为单位）。该值与消息大小成正比。|
|`RabbitMQIOWriteAverageTime`|计数|RabbitMQ 执行一次写入操作的平均时间（以毫秒为单位）。该值与消息大小成正比。|
