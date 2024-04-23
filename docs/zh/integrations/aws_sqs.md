---
title: 'AWS Simple Queue Service'
tags: 
  - AWS
summary: 'AWS Simple Queue Service 的展示指标包括队列中最旧的未删除消息的大约存在时间、延迟且无法立即读取的消息数量、处于空中状态的消息的数量、可从队列取回的消息数量等。'
__int_icon: 'icon/aws_sqs'
dashboard:

  - desc: 'AWS Simple Queue Service内置视图'
    path: 'dashboard/zh/aws_sqs'

monitor:
  - desc: 'AWS Simple Queue Service监控器'
    path: 'monitor/zh/aws_sqs'

---

<!-- markdownlint-disable MD025 -->
# AWS Simple Queue Service
<!-- markdownlint-enable -->


AWS Simple Queue Service 的展示指标包括队列中最旧的未删除消息的大约存在时间、延迟且无法立即读取的消息数量、处于空中状态的消息的数量、可从队列取回的消息数量等。


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### 安装脚本

> 提示：请提前准备好符合要求的亚马逊云 AK（简单起见，可直接授予CloudWatch只读权限`CloudWatchReadOnlyAccess`）

同步 AWS Simple Queue Service 的监控数据，我们安装对应的采集脚本：「观测云集成（AWS-Simple Queue Service 采集）」(ID：`guance_aws_sqs`)

点击【安装】后，输入相应的参数：AWS AK ID、AWS AK SECRET、account_name。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。在启动脚本中，需要注意'regions' 与 实例实际所在 regions 保持一致。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

> 如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。


我们默认采集了一些配置, 具体见指标一栏[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}

配置好亚马逊-云监控,默认的指标集如下.可以通过配置的方式采集更多的指标:

[亚马逊云监控 AWS Simple Queue Service 指标详情](https://docs.aws.amazon.com/zh_cn/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-available-cloudwatch-metrics.html){:target="_blank"}


| 指标名称 | 描述 | 单位 | 有效统计数据 |
| :---: | :---: | :---: | :---: |
| `ApproximateAgeOfOldestMessage` | 队列中最旧的未删除消息的大约存在时间。**注意**: 在接收消息三次（或以上）且未处理时，该消息将会移至队列的后面，而 ApproximateAgeOfOldestMessage 指标会指示尚未接收超过三次的第二旧的消息。即使队列具有重新驱动策略，也会发生此操作。由于单个毒丸消息（多次接收但从未删除）会扭曲此指标，直到成功使用毒丸消息之前，指标中都不会包含毒丸消息的使用期限。如果队列有重新驱动策略，当达到配置的最大接收数目后，消息将会移至死信队列。当消息移至死信队列，死信队列的ApproximateAgeOfOldestMessage 指标表示该消息移至死信队列的时间（而不是该消息发送的原始时间）。报告标准：如果队列处于活动状态，则报告非负值。 | 秒 | 平均值、最小值、最大值、总和、数据样本（在 Amazon SQS 控制台中显示为样本数） |
| `ApproximateNumberOfMessagesDelayed` | 队列中延迟且无法立即读取的消息数量。如果队列被配置为延迟队列，或者使用了延迟参数来发送消息，则会出现这种情况。报告标准：如果队列处于活动状态，则报告非负值。 | 计数 | 平均值、最小值、最大值、总和、数据样本（在 Amazon SQS 控制台中显示为样本数） |
| `ApproximateNumberOfMessagesNotVisible` | 处于空中状态的消息的数量。如果消息已发送到客户端，但尚未删除或尚未到达其可见性窗口末尾，则消息被视为处于飞行状态。报告标准：如果队列处于活动状态，则报告非负值。 | 计数 | 平均值、最小值、最大值、总和、数据样本（在 Amazon SQS 控制台中显示为样本数） |
| `ApproximateNumberOfMessagesVisible` | 可从队列取回的消息数量。报告标准：如果队列处于活动状态，则报告非负值。 | 计数 | 平均值、最小值、最大值、总和、数据样本（在 Amazon SQS 控制台中显示为样本数） |
| `NumberOfEmptyReceives`| 未返回消息的 ReceiveMessage API 调用数量。报告标准：如果队列处于活动状态，则报告非负值。 | 计数 | 平均值、最小值、最大值、总和、数据样本（在 Amazon SQS 控制台中显示为样本数）  |
| `NumberOfMessagesDeleted` |从队列删除的消息数量。报告标准：如果队列处于活动状态，则报告非负值。 | 计数 | 平均值、最小值、最大值、总和、数据样本（在 Amazon SQS 控制台中显示为样本数）|
| `NumberOfMessagesReceived`| 调用 ReceiveMessage 操作返回的消息数量。报告标准：如果队列处于活动状态，则报告非负值。 | 计数 | 平均值、最小值、最大值、总和、数据样本（在 Amazon SQS 控制台中显示为样本数） |
| `NumberOfMessagesSent`| 添加到队列的消息数量。报告标准：如果队列处于活动状态，则报告非负值。 | 计数 | 平均值、最小值、最大值、总和、数据样本（在 Amazon SQS 控制台中显示为样本数） |
| `SentMessageSize` | 添加到队列的消息大小。报告标准：如果队列处于活动状态，则报告非负值。 | 字节 | 平均值、最小值、最大值、总和、数据样本（在 Amazon SQS 控制台中显示为样本数） |
