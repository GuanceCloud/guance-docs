---
title: 'AWS DynamoDB'
summary: 'AWS DynamoDB的展示指标包括吞吐量容量单位、延迟、并发连接数和读写吞吐量等，这些指标反映了 DynamoDB 在处理大规模数据存储和访问时的性能表现和可扩展性。'
__int_icon: 'icon/aws_dynamodb'
dashboard:

  - desc: 'AWS DynamoDB 内置视图'
    path: 'dashboard/zh/aws_dynamodb'

monitor:
  - desc: 'AWS DynamoDB 监控器'
    path: 'monitor/zh/aws_dynamodb'

---


<!-- markdownlint-disable MD025 -->
# AWS DynamoDB
<!-- markdownlint-enable -->


AWS DynamoDB的展示指标包括吞吐量容量单位、延迟、并发连接数和读写吞吐量等，这些指标反映了 **DynamoDB** 在处理大规模数据存储和访问时的性能表现和可扩展性。


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 AWS DynamoDB 的监控数据，我们安装对应的采集脚本：「观测云集成（AWS-DynamoDB采集）」(ID：`guance_aws_dynamodb`)

点击【安装】后，输入相应的参数：亚马逊 AK、亚马逊账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好亚马逊-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [亚马逊云监控指标详情](https://docs.aws.amazon.com/zh_cn/amazondynamodb/latest/developerguide/metrics-dimensions.html){:target="_blank"}

### ConditionalCheckFailedRequests

执行条件写入的尝试失败次数。

| 指标名称 | 描述 | 单位 | 维度 |
| :---: | :---: | :---: | :---: |
| ConditionalCheckFailedRequests_Average | 错误请求平均数 | Count | TableName |
| ConditionalCheckFailedRequests_Maximum | 错误请求最大值 | Count | TableName |
| ConditionalCheckFailedRequests_Minimum | 错误请求最小值 | Count | TableName |
| ConditionalCheckFailedRequests_SampleCount | 错误请求数 | Count | TableName |
| ConditionalCheckFailedRequests_Sum | 错误请求总数 | Count | TableName |

### ConsumedReadCapacityUnits

指定时间段内占用的读取容量单位数，这样可以跟踪预置吞吐量的使用。

| 指标名称 | 描述 | 单位 | 维度 |
| :---: | :---: | :---: | :---: |
| ConsumedReadCapacityUnits_Average | 每个请求占用的平均读取容量 | Count | TableName |
| ConsumedReadCapacityUnits_Maximum | 对表或索引的任何请求占用的最大读取容量单位数 | Count | TableName |
| ConsumedReadCapacityUnits_Minimum | 对表或索引的任何请求占用的最小读取容量单位数 | Count | TableName |
| ConsumedReadCapacityUnits_SampleCount | 对 DynamoDB 的读取请求数，即使未占用读取容量 | Count | TableName |
| ConsumedReadCapacityUnits_Sum | 占用的总读取容量单位 | Count | TableName |

### ConsumedWriteCapacityUnits

指定时间段内占用的写入容量单位数，这样可以跟踪预置吞吐量的使用。

| 指标名称 | 描述 | 单位 | 维度 |
| :---: | :---: | :---: | :---: |
| ConsumedWriteCapacityUnits_Average | 每个请求占用的平均写入容量 | Count | TableName |
| ConsumedWriteCapacityUnits_Maximum | 对表或索引的任何请求占用的最大写入容量单位数 | Count | TableName |
| ConsumedWriteCapacityUnits_Minimum | 对表或索引的任何请求占用的最小写入容量单位数 | Count | TableName |
| ConsumedWriteCapacityUnits_SampleCount | 对 DynamoDB 的写入请求数，即使未占用读取容量 | Count | TableName |
| ConsumedWriteCapacityUnits_Sum | 占用的总写入容量单位 | Count | TableName |

## 对象 {#object}

采集到的AWS DynamoDB 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aws_dynamodb",
  "tags": {
      "RegionId"        : "cn-north-1",
      "TableArn"        : "arn:aws-cn:dynamodb:cn-north-1:",
      "TableId"         : "0ce8d4f9b35",
      "TableName"       : "eks-tflock",
      "TableStatus"     : "ACTIVE",
      "name"            : "eks-tflock"
  },
  "fields": {
    "AttributeDefinitions"  : "[{\"AttributeName\": \"LockID\", \"AttributeType\": \"S\"}]",
    "BillingModeSummary"    : "{}",
    "CreationDateTime"      : "2023-03-22T23:39:42.352000+08:00",
    "ItemCount"             : "1",
    "KeySchema"             : "[{\"AttributeName\": \"LockID\", \"KeyType\": \"HASH\"}]",
    "LocalSecondaryIndexes" : "{}",
    "TableSizeBytes"        : "96",
    "message"               : "{实例 json 信息}"
  }
}

```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
>
> 提示 2：`fields.message`、`fields.Endpoint`、均为 JSON 序列化后字符串
