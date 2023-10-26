---
title: 'AWS Lambda'
summary: 'AWS Lambda的展示指标包括冷启动时间、执行时间、并发执行数和内存使用量，这些指标反映了Lambda函数的响应速度、可扩展性和资源利用情况。'
__int_icon: 'icon/aws_lambda'

dashboard:
  - desc: 'AWS Lambda 内置视图'
    path: 'dashboard/zh/aws_lambda'

monitor:
  - desc: 'AWS Lambda 监控器'
    path: 'monitor/zh/aws_lambda'

---


<!-- markdownlint-disable MD025 -->
# AWS Lambda
<!-- markdownlint-enable -->

AWS Lambda的展示指标包括冷启动时间、执行时间、并发执行数和内存使用量，这些指标反映了Lambda函数的响应速度、可扩展性和资源利用情况。


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### 安装脚本

> 提示：请提前准备好符合要求的亚马逊云 AK（简单起见，可直接授予CloudWatch只读权限`CloudWatchReadOnlyAccess`）

同步 ECS 云资源的监控数据，我们安装对应的采集脚本：「观测云集成（AWS-Lambda采集）」(ID：`guance_aws_lambda`)

点击【安装】后，输入相应的参数：AWS AK ID、AWS AK SECRET。

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

[亚马逊云监控  Lambda 指标详情](https://docs.aws.amazon.com/zh_cn/lambda/latest/dg/monitoring-metrics.html){:target="_blank"}


### 调用指标

| 指标                                              | 描述                                                         |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `Invocations`                           | 函数代码的调用次数，包括成功调用和导致函数错误的调用。如果调用请求受到限制或导致调用错误，则不会记录调用。Invocations 的值等于计费的请求数。 |
| `Errors`                           | 导致出现函数错误的调用的次数。函数错误包括您的代码所引发的异常以及 Lambda 运行时所引发的异常。运行时返回因超时和配置错误等问题导致的错误。要计算错误率，请将 Errors 的值除以 Invocations 的值。请注意，错误指标上的时间戳反映的是调用函数的时间，而非错误发生的时间。 |
| `DeadLetterErrors`                           | 对于异步调用，Lambda 尝试将事件发送到死信队列（DLQ）但失败的次数。资源误配或大小限制可能会致发生死信错误。 |
| `DestinationDeliveryFailures`                           | 对于异步调用和支持的 事件源映射，Lambda 尝试将事件发送到 目标 但失败的次数。对于事件源映射，Lambda 支持流源（DynamoDB 和 Kinesis）的目标。权限错误、资源误配或大小限制可能会导致发生传输错误。如果您配置的目标是不支持的目标类型，例如 Amazon SQS FIFO 队列或 Amazon SNS FIFO 主题，则可能会发生这种错误。 |
| `Throttles`                           | 受限制的调用请求数。当所有函数实例都在处理请求并且没有可用于纵向扩展的并发时，Lambda 将拒绝其他请求，并出现 TooManyRequestsException 错误。受限制的请求和其他调用错误不会计为 Invocations 或 Errors。 |
| `ProvisionedConcurrencyInvocations`                           | 使用预置并发调用函数代码的次数。 |
| `ProvisionedConcurrencySpilloverInvocations`                           | 当所有预置并发均处于使用状态时，使用标准并发调用函数代码的次数。 |
| `RecursiveInvocationsDropped`                           | Lambda 因为检测到您的函数是无限递归循环的一部分而停止调用您函数的次数。Lambda 递归循环检测 通过跟踪由支持的 AWS 开发工具包添加的元数据，来监控函数作为请求链的一部分被调用的次数。如果您的函数作为请求链的一部分被调用的次数超过 16 次，Lambda 会中断下一次调用。 |

### 性能指标

性能指标提供了有关单个函数调用的性能详细信息。例如，Duration 指标指示函数处理事件所花费的时间量（以毫秒为单位）。要了解函数处理事件的速度，请使用 Average 或 Max 统计数据查看这些指标。

| 指标                                              | 描述                                                         |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `Duration`                         | 函数代码处理事件所花费的时间量。调用的计费持续时间是已舍入到最近的毫秒的 Duration 值。 |
| `PostRuntimeExtensionsDuration`    | 函数代码完成后，运行时为扩展运行代码所花费的累积时间。 |
| `IteratorAge`                    | 对于从流读取的事件源映射，为事件中最后一条记录的期限。该指标测量流接收记录的时间到事件源映射将事件发送到函数的时间之间的时间量。 |
| `OffsetLag`                           | 对于自行管理的 Apache Kafka 和 Amazon Managed Streaming for Apache Kafka（Amazon MSK）事件源，写入到主题的最后一条记录与函数的使用者组处理的最后一条记录之间的偏移量差值。尽管 Kafka 主题可以包含多个分区，但此指标仍可在主题级别衡量偏移延迟。 |

### 并发指标

Lambda 将并发指标报告为跨函数、版本、别名或 AWS 区域 处理事件的实例数的总计数。要查看接近并发限制的程度，请使用 Max 统计数据查看这些指标。

| 指标                                              | 描述                                                         |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `ConcurrentExecutions`    | 正在处理事件的函数实例的数目。如果此数目达到区域的并发执行配额或您在函数上配置的预留并发限制，则 Lambda 将会限制其他调用请求。 |
| `ProvisionedConcurrentExecutions`    | 使用预置并发处理事件的函数实例的数目。对于具有预置并发性的别名或版本的每次调用，Lambda 都会发出当前计数。 |
| `ProvisionedConcurrencyUtilization`    | 对于版本或别名，为将 ProvisionedConcurrentExecutions 值除以分配的预置并发总数。例如，.5 指明有 50% 的已分配预配置并发正在使用中。 |
| `UnreservedConcurrentExecutions`    | 对于区域，由不具有预留并发的函数处理的事件数。 |

### 异步调用指标

异步调用指标提供有关来自事件源的异步调用和直接调用的详细信息。您可以设置阈值和警报以通知您某些变化。例如，当排队等待处理的事件数量意外增加时 (AsyncEventsReceived)。或者，当一个事件等待了很长时间才完成处理时 (AsyncEventAge)。

| 指标                                              | 描述                                                         |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `AsyncEventsReceived`    | Lambda 成功排队等待处理的事件数。此指标可让您深入了解 Lambda 函数接收的事件数量。监控此指标并设置阈值警报以检查是否存在问题。例如，检测发送到 Lambda 的不良事件数量，并快速诊断因触发器或函数配置不正确而导致的问题。AsyncEventsReceived 和 Invocations 之间的不匹配可能表明处理过程存在差异、事件被丢弃或潜在的队列积压。 |
| `AsyncEventAge`    | Lambda 成功将事件排队到调用该函数之间的时间。当由于调用失败或节流而重试事件时，此指标的值会增加。监控此指标，并在出现队列积聚时针对不同统计信息的阈值设置警报。要解决该指标增加的问题，请查看 Errors 指标以识别函数错误，并查看 Throttles 指标以确定并发问题。 |
| `AsyncEventsDropped`    | 在未成功执行函数的情况下丢弃的事件数。如果您配置了死信队列（DLQ）或 OnFailure 目标，则事件会在丢弃之前发送到那里。事件因各种原因被丢弃。例如，事件可能超过最大事件期限或耗尽最大重试次数，或者预留并发可能设置为 0。要解决该指标被丢弃的问题，请查看 Errors 指标以识别函数错误，并查看 Throttles 指标以确定并发问题。 |

## 对象 {#object}

采集到的AWS Lambda 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aws_lambda",
  "tags": {
    "account_name"      :"AWS_Lambda",
    "class"             :"aws_lambda",
    "cloud_provider"    :"aws",
    "FunctionName"      :"dataflux-alb",
    "name"              :"dataflux-alb",
    "PackageType"       :"Zip",
    "RegionId"          :"cn-northwest-1",
    "RevisionId"        :"5e52ff51-615a-4ecb-96b7-40083a7b4b62",
    "Role"              :"arn:aws-cn:iam::294654068288:role/service-role/s3--guance-role-3w34zo42",
    "Runtime"           :"python3.7",
    "Version"           :"$LATEST"
  },
  "fields": {
    "CreatedTime"         : "2022-03-09T06:13:31Z",
    "ListenerDescriptions": "{JSON 数据}",
    "AvailabilityZones"   : "{可用区 JSON 数据}",
    "message"             : "{实例 JSON 数据}"
  }
}
```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.account_name`值为实例 ID，作为唯一识别
