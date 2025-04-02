---
title: 'AWS DynamoDB'
tags: 
  - AWS
summary: 'AWS DynamoDB的展示指标包括吞吐量容量单位、延迟、并发连接数和读写吞吐量等，这些指标反映了 DynamoDB 在处理大规模数据存储和访问时的性能表现和可扩展性。'
__int_icon: 'icon/aws_dynamodb'
dashboard:

  - desc: 'AWS DynamoDB 内置视图'
    path: 'dashboard/zh/aws_dynamodb'

monitor:
  - desc: 'AWS DynamoDB 监控器'
    path: 'monitor/zh/aws_dynamodb'

cloudCollector:
  desc: '云采集器'
  path: 'cloud-collector/zh/aws_dynamodb'
---


<!-- markdownlint-disable MD025 -->
# AWS DynamoDB
<!-- markdownlint-enable -->


AWS DynamoDB的展示指标包括吞吐量容量单位、延迟、并发连接数和读写吞吐量等，这些指标反映了 **DynamoDB** 在处理大规模数据存储和访问时的性能表现和可扩展性。


## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

#### 托管版开通脚本

1. 登陆<<< custom_key.brand_name >>>控制台
2. 点击【管理】菜单，选择【云帐号管理】
3. 点击【添加云帐号】，选择【AWS】，填写界面所需的信息，如之前已配置过云帐号信息，则忽略此步骤
4. 点击【测试】，测试成功后点击【保存】，如果测试失败，请检查相关配置信息是否正确，并重新测试
5. 点击【云帐号管理】列表上可以看到已添加的云账号，点击相应的云帐号，进入详情页
6. 点击云帐号详情页的【集成】按钮，在`未安装`列表下，找到`AWS DynamoDB`，点击【安装】按钮，弹出安装界面安装即可。

#### 手动开通脚本

1. 登陆Func 控制台，点击【脚本市场】，进入官方脚本市场，搜索:`guance_aws_dynamodb`

2. 点击【安装】后，输入相应的参数：AWS AK ID 、AK Secret 及账户名。

3. 点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

4. 开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

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
