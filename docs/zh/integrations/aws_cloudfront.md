---
title: 'AWS CloudFront'
tags: 
  - AWS
summary: 'AWS CloudFront的核心性能指标包括请求总数、数据传输量、HTTP 错误率、缓存命中率和延迟，这些可以帮助用户评估和优化内容分发网络的性能。'
__int_icon: 'icon/aws_cloudfront'
dashboard:

  - desc: 'AWS CloudFront 内置视图'
    path: 'dashboard/zh/aws_cloudfront'

monitor:
  - desc: 'AWS CloudFront 监控器'
    path: 'monitor/zh/aws_cloudfront'

cloudCollector:
  desc: '云采集器'
  path: 'cloud-collector/zh/aws_cloudfront'
---

<!-- markdownlint-disable MD025 -->
# AWS CloudFront
<!-- markdownlint-enable -->

AWS CloudFront的核心性能指标包括请求总数、数据传输量、HTTP 错误率、缓存命中率和延迟，这些可以帮助用户评估和优化内容分发网络的性能。

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 AWS CloudFront 云资源的监控数据，我们安装对应的采集脚本：「观测云集成（AWS-Gateway采集）」(ID：`guance_aws_cloudfront`)

点击【安装】后，输入相应的参数：亚马逊 AK、亚马逊账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aws-cloudfront/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好亚马逊-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [亚马逊云监控指标详情](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/viewing-cloudfront-metrics.html#monitoring-console.distributions-additional){:target="_blank"}

### 监控指标

| 指标英文名      | 指标中文名             | 含义                        |
| --------------- | ---------------------- | --------------------------- |
| **Requests** | 请求书            | CloudFront接收到的所有HTTP方法以及HTTP和HTTPS请求的查看器请求总数。 |
| **Bytes downloaded** | 下载字节数 | 查看器为GET、HEAD和OPTIONS请求下载的总字节数。 |
| **Bytes uploaded** | 上传字节数 | 查看器使用POST和PUT请求通过CloudFront上传到您的源位置的总字节数。 |
| **4xx error rate** | 4xx 错误数 | 响应的HTTP状态代码为4xx的所有查看器请求的百分比。 |
| **5xx error rate** | 5xx 错误数 | 响应的HTTP状态代码为5xx的所有查看器请求的百分比。 |
| **Total error rate** | 总错误数 | 响应的HTTP状态代码为4xx或5xx的所有查看器请求的百分比。 |

## 对象 {#object}

上报的数据示例如下：

```json
{
  "measurement": "aws_cloudfront",
  "tags": {
    "ARN": "arn:aws-cn:cloudfront::F",
    "DomainName": "d3q33pv83.cloudfront.cn",
    "Id": "E183FMUG1QDCZF",
    "Status": "Deployed",
    "name": "E183FMUG1ZF"
  },
  "fields": {
    "CreatedDate"              : "2022-03-09T06:13:31Z",
    "ApiKeySelectionExpression": "$request.header.",
    "DisableSchemaValidation"  : "xxxxx",
    "Description"              : "Created by AWS Lambda"
  }
}


```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

