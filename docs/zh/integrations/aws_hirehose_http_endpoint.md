---
title     : 'AWS Firehose HTTP Endpoint'
summary   : '将 Firehose 的日志或者指标发送到{{{ custom_key.brand_name }}}'
tags      :
  - 'Amazon Firehose'
  - 'HTTP Endpoint'
  - 'Kinesis Data Stream'

---


本篇主要介绍在 Firehose 中创建自定义 `HTTP Endpoint` 所接收的 `log` 和 `metric` 数据的三种方式。

1. 将 Kinesis Stream 数据发送到 Firehose
2. 将 CloudWatch Log 数据发送到 Firehose
3. 将 CloudWatch 指标流数据发送 Firehose


## 将 Kinesis Stream 发送到 Firehose {#stream}

使用 [Amazon Agent 代理](https://github.com/awslabs/amazon-kinesis-agent) 或者使用 [AWS 开发工具包](https://github.com/aws/aws-sdk-java-v2) 将日志发送到 Kinesis Stream 中，都可以通过
Firehose 将日志发送到{{{ custom_key.brand_name }}}。

### 创建数据流 {creat_stream}

在 Amazon Kinesis 中创建数据流，输入数据流名称即可。

如果已经创建好了数据流，这里不用重复创建。

### 创建 firehose 流 {#creat_firehose}

在 Amazon Data Firehose 中选择 *创建 firehose 流*

选择源 : `Amazon Kinesis Data Streams`

目标： `HTTP 终端节点`

HTTP 终端节点配置注意事项：

- 选择一个来源，必须是： `Amazon Kinesis Data Streams`
- 选择目标： `HTTP 终端节点`
- Firehose 名称：可以自定义，也可以使用默认值。
- 源设置：选择一个创建的数据流即可。
- 目标设置 HTTP 终端节点 URL ：必须是 https 协议且端口必须是 443 ，作为日志一定要携带参数 `category=logging`,例如：`https://openway.guance.com/v1/input/firehose?category=logging`.
- 访问秘钥： 填入用户 token 如： `tkn_zxxzxxzxx`
- 内容编码（可选）。
- 参数：这里要设置 `source` 用来后续的 pipeline 操作，如：  `source=my_source` 或者添加服务名 `service=my_service`
- 后续设置使用默认值即可。

> 注意， token 和 参数 source 是必填的。

### 后续 Pipeline 处理 {#pipeline}

日志类型的数据发送到{{{ custom_key.brand_name }}}中后，将是明文显示。可以根据事先配置的 `source` 创建 Pipeline 脚本。


## CloudWatch 日志数据发送到 Firehose {#cloudwatch-log}

需要使用 cli ，在此之前需要预设环境变量：

```shell
export AWS_ACCESS_KEY_ID=<AK>
export AWS_SECRET_ACCESS_KEY=<SK>
export AWS_DEFAULT_REGION=<us-west-2>
```

### 创建日志组、日志流 {#creat-log-group}

这里可以通过 cli 或者控制台创建

### 创建流、角色 {#creat-log-role}

在实践过程中发现，要用 cli 创建流和角色以及赋予角色权限

[请仔细阅读 CLI 操作文档](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/SubscriptionFilters.html#DestinationKinesisExample) 需要做前6个步骤即可：

1. 创建流
2. 查看流
3. 创建IAM文件
4. 创建角色
5. 创建权限策略
6. 赋予角色权限

> 要仔细阅读文档 文档的示例中标红的需要手动填写。

下面的步骤就可以通过控制台操作了 这样更加直观：

在日志组列表界面，选择日志组点击进入操作界面，**操作** 选择 **订阅筛选条件** 选择 **创建 Kinesis 订阅筛选条件**  进入创建Kinesis订阅筛选条件页面。

**目标** 选择使用命令行创建的数据流

**授予权限** 选择命令行创建的角色名称


以上 从 CloudWatch 到 Stream 已经打通，下一步 创建 Firehose 将 stream数据打到 HTTP Endpoint。

### 创建 Firehose

在**创建Firehose 流**页面需要注意的：

选择源 : `Amazon Kinesis Data Streams`

目标： `HTTP 终端节点`

firehose 流名称： 默认即可

Kinesis 数据流： 刚刚通过命令行创建的流

转换记录（Lambda）：创建函数，选择**一般Amazon Data Firehose 处理**  在创建函数中搜索 `Process records sent to an Firehose stream` 选择 并创建函数名称。 再回到创建Firehose页面 刷新 选择已经创建的函数。

目标设置： 目标设置 HTTP 终端节点 URL ：必须是 https 协议且端口必须是 443 ，作为日志一定要携带参数 `category=logging`,例如：`https://openway.guance.com/v1/input/firehose?category=logging`.

访问秘钥： 用户token 以tkn开头的字符串

添加参数：这里可以定义 `source = apache_xx` `service=my_service`

最后 创建Firehose 流。

当日志从日志流发送到 Kinesis 流的时候，数据是进行过一次压缩的，所以要在发送到 HTTP 端的时候要先进行一次解压缩，这就是为什么必须要配置 `Lmabda` 的原因。

## 将 CloudWatch 指标流数据发送 Firehose {#cloudwatch-metric}

### 创建 Firehose {#firehose}

在选择**源**的时候 要选择 `Direct PUT`

在选择**目标**的时候，选择 `HTTP Endpoint`

HTTP Endpoint 配置：

目标设置： 目标设置 HTTP 终端节点 URL ：必须是 https 协议且端口必须是 443 ，作为指标一定要携带参数 `category=metric`,例如：`https://openway.guance.com/v1/input/firehose?category=metric`

访问秘钥： 用户token 以tkn开头的字符串

添加参数：这里可以定义 `source = apache_xx` `service=my_service`

其余默认即可。

> 这里有两点注意：源要选择 `Direct PUT` ， 请求参数要是 `category=metric`

## 创建指标流

在 `Cloudwatch` 指标中，选择**流**，选择创建**指标流**

这里有几点注意事项：

1. 目标选择 **Firehose 的自定义设置**
2. Firehose 流选择刚刚创建的 **Direct PUT** 为源的名称。
3. （可选）服务角色
4. （必须）更改输出格式 `OpenTelemetry 1.0`
5. 要流式传输的指标：可自主选择

创建好之后，指标就会流式发送到Firehose目标上

## 其他参考文档 {#docs}

- [What is Amazon Data Firehose](https://docs.aws.amazon.com/firehose/latest/dev/what-is-this-service.html){:target="_blank"}
- [HTTP endpoint Request and Response Data](https://docs.aws.amazon.com/firehose/latest/dev/httpdeliveryrequestresponse.html){:target="_blank"}
- [Use Metric streams](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Metric-Streams.html){:target="_blank"}
- [OPenTelemetry 1.0.0](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-metric-streams-formats-opentelemetry-100.html){:target="_blank"}


