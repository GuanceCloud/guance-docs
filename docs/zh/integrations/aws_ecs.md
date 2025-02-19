---
title: 'AWS ECS'
tags: 
  - AWS
summary: 'Amazon ECS 功能与 亚马逊云科技 Fargate 无服务器计算引擎集成，使用观测云监控其服务运行态。'
__int_icon: 'icon/aws_ecs'
dashboard:
  - desc: 'AWS ECS'
    path: 'dashboard/zh/aws_ecs'
monitor:
  - desc: 'No'
    path: '-'
---

<!-- markdownlint-disable MD025 -->
# AWS ECS
<!-- markdownlint-enable -->

Amazon ECS 功能与 亚马逊云科技 `Fargate` 无服务器计算引擎集成，使用观测云监控其服务运行态。

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考[自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 EC2 云资源的监控数据，我们安装对应的采集脚本：「观测云集成（AWS-ECS采集）」(ID：`guance_aws_ecs`)

点击【安装】后，输入相应的参数：亚马逊 AK、亚马逊账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好亚马逊-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [亚马逊云监控指标详情](https://docs.amazonaws.cn/AmazonECS/latest/developerguide/viewing_cloudwatch_metrics.html){:target="_blank"}

### 实例指标

`AWS/ECS` 相关指标。

| 指标                    | 描述                                                         |
| :---------------------- | :----------------------------------------------------------- |
| `CPUUtilization`    | 服务 CPU 使用率（按 ClusterName 和 ServiceName 进行筛选的指标）是通过将属于服务的任务所使用的总 CPU 单位数除以为属于服务的任务预留的总 CPU 单位数计算得到的。服务 CPU 利用率指标用于使用 `Fargate` 和 EC2 启动类型的任务。单位：百分比 |
| `MemoryUtilization`       | 服务内存使用率（按 ClusterName 和 ServiceName 进行筛选的指标）是通过将属于服务的任务所使用的总内存量除以为属于服务的任务预留的总内存量计算得到的。服务内存利用率指标用于使用 `Fargate` 和 EC2 启动类型的任务。单位：百分比 |


## 对象 {#object}

采集到的 AWS ECS 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aws_ecs",
  "tags": {
      "RegionId": "cn-northwest-1",
      "clusterArn": "arn:aws-cn:***",
      "clusterName": "Harry_NodeJs",
      "name": "Harry_NodeJs",
      "status": "ACTIVE"
  },
  "fields": {
    "activeServicesCount": 1,
    "configuration": "{}",
    "message"            : "{实例 JSON 数据}",
    "pendingTasksCount": 0,
    "registeredContainerInstancesCount": 0,
    "runningTasksCount": 1,
    "statistics": "[]"
  }
}
```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

