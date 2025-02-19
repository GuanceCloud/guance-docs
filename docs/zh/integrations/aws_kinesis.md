---
title: 'AWS Kinesis'
tags: 
  - AWS
summary: '使用脚本市场中「{{{ custom_key.brand_name }}}云同步」系列脚本包把云监控 云资产的数据同步到{{{ custom_key.brand_name }}}'
__int_icon: 'icon/aws_kinesis'
dashboard:

  - desc: 'AWS Kinesis 监控视图'
    path: 'dashboard/zh/aws_kinesis'

monitor:
  - desc: 'AWS Kinesis 监控器'
    path: 'monitor/zh/aws_kinesis'

---


<!-- markdownlint-disable MD025 -->
# AWS Kinesis
<!-- markdownlint-enable -->

使用脚本市场中「{{{ custom_key.brand_name }}}云同步」系列脚本包把云监控 云资产的数据同步到{{{ custom_key.brand_name }}}


## 配置 {#config}

### 安装 Func

推荐开通 {{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考[自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 AWS Kinesis 云资源的监控数据，我们安装对应的采集脚本：「{{{ custom_key.brand_name }}}集成（AWS-Kinesis采集）」(ID：`guance_aws_kinesis`)

点击【安装】后，输入相应的参数：亚马逊 AK、亚马逊账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

然后，在采集脚本中，把collector_configs 和 cloudwatch_configs 中的 regions改成实际的地域

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aws-kinesis/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在{{{ custom_key.brand_name }}}平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在{{{ custom_key.brand_name }}}平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好亚马逊-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [亚马逊云监控指标详情](https://docs.aws.amazon.com/zh_cn/streams/latest/dev/monitoring-with-cloudwatch.html){:target="_blank"}

### 实例指标

`AWS/Kinesis` 命名空间包括以下实例指标。

| 指标                                   | 描述                                                                                                                                                                                                                       |
|:-------------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `IncomingBytes`                      | 在指定时段内成功放置到 Kinesis 流的字节数。该指标包含来自 PutRecord 和 PutRecords 的字节数。统计数据 Minimum、Maximum 和 Average 表示指定时段内流的单个 put 操作中的字节数。分片级别指标名称：IncomingBytes。维度：StreamName。单位：字节                                                          |
| `IncomingRecords`                    | 在指定时段内成功放置到 Kinesis 流的记录数。该指标包含来自 PutRecord 和 PutRecords 的记录数。统计数据 Minimum、Maximum 和 Average 表示指定时段内流的单个 put 操作中的记录数。分片级别指标名称：IncomingRecords。维度：StreamName。单位：计数                                                        |
| `WriteProvisionedThroughputExceeded` | 在指定时段内因流限制而被拒绝的记录数。该指标包含来自 PutRecord 和 PutRecords 操作的限制。此指标的最常用的统计数据为 Average。当统计数据 Minimum 的值不为零时，流的记录在指定时段内将受限。当统计数据 Maximum 的值为 0（零）时，流的任何记录在指定时段内将不受限。分片级别指标名称：WriteProvisionedThroughputExceeded。维度：StreamName。单位：计数 |
| `PutRecords.Bytes`                   | 使用放置到 Kinesis 流的字节数PutRecords在指定时间段内的操作。维度：StreamName。单位：字节                                                                                                                                    |
| `PutRecords.Success`                 | 的数量PutRecords在指定时段内测得的每个 Kinesis 流中至少有一个记录成功的操作。维度：StreamName。单位：计数                                                                                                                                                      |
| `PutRecords.Latency`                 | 在指定时段内测量的每个 PutRecords 操作所用的时间。维度：StreamName.单位：毫秒                                                                                                                                                                       |
| `PutRecords.FailedRecords`           |因内部故障而被拒绝的记录的数目。PutRecords在指定时段内测量的每个 Kinesis 数据流的操作数。偶尔会出现内部故障，应该重试。维度：StreamName.单位：计数|
| `PutRecords.ThrottledRecords`        |由于存在限制而被拒绝的记录数PutRecords在指定时段内测量的每个 Kinesis 数据流的操作数。维度：StreamName.单位：计数|
| `utRecords.TotalRecords`             |在PutRecords在指定时段内测量的每个 Kinesis 数据流的操作数。维度：StreamName.单位：计数|
## 对象 {#object}

采集到的AWS Kinesis 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aws_kinesis",
  "tags": {
    "class"          : "aws_kinesis",
    "cloud_provider" : "aws",
    "create_time"    : "2023/08/07 14:29:19",
    "date"           : "2023/08/07 14:29:19",
    "date_ns"        :"0",
    "EncryptionType" :"NONE",
    "HasMoreShards"  :"false",
    "name"           :"zsh_test",
    "RegionId"      :"cn-northwest-1",
    "RetentionPeriodHours":"24",
    "StreamARN":"arn:aws-cn:kinesis:cn-northwest-1:294654068288:stream/zsh_test",
    "StreamName":"zsh_test",
    "StreamStatus":"ACTIVE"
  }
}
```

> *注意：`tags`中的字段可能会随后续更新有所变动*
>
> 提示1：`name`值为实例名，作为唯一识别
