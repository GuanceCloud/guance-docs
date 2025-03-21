---
title: 'AWS EventBridge'
tags: 
  - AWS
summary: 'AWS EventBridge 的展示指标包括事件传递延迟、吞吐量、事件规模和可伸缩性，这些指标反映了 EventBridge 在处理大规模事件流和实时数据传递时的性能表现和可靠性。'
__int_icon: 'icon/aws_eventbridge'
dashboard:

  - desc: 'AWS EventBridge 监控视图'
    path: 'dashboard/zh/aws_eventbridge'

monitor:
  - desc: 'AWS EventBridge 监控器'
    path: 'monitor/zh/aws_eventbridge'

cloudCollector:
  desc: '云采集器'
  path: 'cloud-collector/zh/aws_eventbridge'
---


<!-- markdownlint-disable MD025 -->
# AWS EventBridge
<!-- markdownlint-enable -->

**AWS** **EventBridge** 的展示指标包括事件传递延迟、吞吐量、事件规模和可伸缩性，这些指标反映了 **EventBridge** 在处理大规模事件流和实时数据传递时的性能表现和可靠性。


## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考[自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 AWS EventBridge 云资源的监控数据，我们安装对应的采集脚本：「<<< custom_key.brand_name >>>集成（AWS-EventBridge采集）」(ID：`guance_aws_eventbridge`)

点击【安装】后，输入相应的参数：亚马逊 AK、亚马逊账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

然后，在采集脚本中，把collector_configs 和 cloudwatch_configs 中的 regions改成实际的地域

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好亚马逊-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [亚马逊云监控指标详情](https://docs.aws.amazon.com/zh_cn/eventbridge/latest/userguide/eb-monitoring.html){:target="_blank"}

### 实例指标

`AWS/Events` 命名空间包括以下实例指标。

| 指标                     | 描述                                                         |
|:-----------------------| :----------------------------------------------------------- |
| `Invocations`          | 规则为响应事件而调用目标的次数。这包括成功和失败的调用，但不包括限制或重试的尝试，直到它们永久失败为止。它不包括DeadLetterInvocations。注意：EventBridge仅在不为CloudWatch零时才将此指标发送到。有效维度：RuleName。单位：计数 |
| `TriggeredRules`       | 已运行并与任何事件匹配的规则数量。在触发规则CloudWatch之前，你不会看到这个指标。有效维度：RuleName。单位：计数|
## 对象 {#object}

采集到的AWS EventBridge 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aws_eventbridge",
  "tags": {
    "Arn":             "arn:aws-cn:events:cn-north-1:294654068288:rule/hn-test-lambda",
    "class":           "aws_eventbridge",
    "cloud_provider":  "aws",
    "EventBusName":    "default",
    "name":            "arn:aws-cn:events:cn-north-1:294654068288:rule/hn-test-lambda",
    "RegionId":        "cn-north-1",
    "RuleName":        "hn-test-lambda"
  }
}
```

> *注意：`tags`中的字段可能会随后续更新有所变动*

