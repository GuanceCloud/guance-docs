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

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考[自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 AWS API Gateway 云资源的监控数据，我们安装对应的采集脚本：「观测云集成（AWS-Gateway采集）」(ID：`guance_aws_gateway`)

点击【安装】后，输入相应的参数：亚马逊 AK、亚马逊账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

然后，在采集脚本中，把collector_configs 和 cloudwatch_configs 中的 regions改成实际的地域

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aws-gateway/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

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
