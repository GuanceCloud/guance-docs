---
title: 'AWS API Gateway'
tags: 
  - AWS
summary: 'AWS API Gateway的展示指标包括请求响应时间、吞吐量、并发连接数和错误率，这些指标反映了API Gateway在处理API请求和流量管理时的性能表现和可靠性。'
__int_icon: 'icon/aws_api_gateway'
dashboard:

  - desc: 'AWS API Gateway 监控视图'
    path: 'dashboard/zh/aws_api_gateway'

monitor:
  - desc: 'AWS API Gateway 监控器'
    path: 'monitor/zh/aws_api_gateway'

cloudCollector:
  desc: '云采集器'
  path: 'cloud-collector/zh/aws_api_gateway'
---


<!-- markdownlint-disable MD025 -->
# AWS API Gateway
<!-- markdownlint-enable -->

AWS API Gateway的展示指标包括请求响应时间、吞吐量、并发连接数和错误率，这些指标反映了API Gateway在处理API请求和流量管理时的性能表现和可靠性。


## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考[自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

#### 托管版开通脚本

1. 登陆<<< custom_key.brand_name >>>控制台
2. 点击【管理】菜单，选择【云帐号管理】
3. 点击【添加云帐号】，选择【AWS】，填写界面所需的信息，如之前已配置过云帐号信息，则忽略此步骤
4. 点击【测试】，测试成功后点击【保存】，如果测试失败，请检查相关配置信息是否正确，并重新测试
5. 点击【云帐号管理】列表上可以看到已添加的云账号，点击相应的云帐号，进入详情页
6. 点击云帐号详情页的【集成】按钮，在`未安装`列表下，找到`AWS API Gateway`，点击【安装】按钮，弹出安装界面安装即可。


#### 手动开通脚本

1. 登陆Func 控制台，点击【脚本市场】，进入官方脚本市场，搜索 `guance_aws_gateway`

2. 点击【安装】后，输入相应的参数：AWS AK ID 、AK Secret 及账户名。

3. 点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

4. 开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好亚马逊-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [亚马逊云监控指标详情](https://docs.aws.amazon.com/zh_cn/apigateway/latest/developerguide/api-gateway-metrics-and-dimensions.html){:target="_blank"}

### 实例指标

`AWS/ApiGateway` 命名空间包括以下实例指标。

| 指标                    | 描述                                                         |
| :---------------------- | :----------------------------------------------------------- |
| `4XXError`    | 在给定期间捕获的客户端错误数。 Sum 统计数据表示此指标，即给定期间内 4XXError 错误的总计数。Average 统计数据表示 4XXError 错误率，即 4XXError 错误的总计数除以该期间中的请求总数。分母对应于 Count 指标 (见下)。 Unit: Count |
| `5XXError`       | 在给定期间捕获的服务器端错误数。 Sum 统计数据表示此指标，即给定期间内 5XXError 错误的总计数。Average 统计数据表示 5XXError 错误率，即 5XXError 错误的总计数除以该期间中的请求总数。分母对应于 Count 指标 (见下)。 Unit: Count |
| `Count`      | 给定期间内的 API 请求总数。 SampleCount 统计数据表示此指标。 Unit: Count |
| `Latency`     | 从 API Gateway 从客户端收到请求到其将响应返回给客户端所经过的时间。延迟包括集成延迟和其他 API Gateway 开销。Unit: Millisecond  |

## 对象 {#object}

采集到的AWS API Gateway 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aws_gateway",
  "tags": {
    "account_name"   : "AWS",
    "api_name"       : "helloworld-API",
    "ApiId"          : "c72z3thtq8",
    "ApiKeySelectionExpression": "$request.header.x-api-key",
    "class"          : "aws_gateway",
    "cloud_provider" : "aws",
    "create_time"    : "2023/08/07 14:29:19",
    "CreatedDate"    : "2022-11-11T09:17:35Z",
    "date"           : "2023/08/07 14:29:19",
    "date_ns"        :"0",
    "Description"    :"Created by AWS Lambda",
    "instance_tags"  :"{}",
    "name"           :"c72z3thtq8",
    "ProtocolType"   :"HTTP",
    "region_id"      :"cn-northwest-1"
  }
}
```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示1：`ApiId`值为实例 ID，作为唯一识别
