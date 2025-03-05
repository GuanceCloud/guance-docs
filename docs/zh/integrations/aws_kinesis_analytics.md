---
title: 'AWS KinesisAnalytics'
tags: 
  - AWS
summary: '使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云'
__int_icon: 'icon/aws_kinesis_analytics'
dashboard:

  - desc: 'AWS KinesisAnalytics 内置视图'
    path: 'dashboard/zh/aws_kinesis_analytics'

monitor:
  - desc: 'AWS DocumentDB 监控器'
    path: 'monitor/zh/aws_kinesis_analytics'

cloudCollector:
  desc: '云采集器'
  path: 'cloud-collector/zh/aws_kinesis_analytics'
---

<!-- markdownlint-disable MD025 -->
# AWS KinesisAnalytics
<!-- markdownlint-enable -->

使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考[自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 KinesisAnalytics 云资源的监控数据，我们安装对应的采集脚本：「观测云集成（AWS KinesisAnalytics 采集）」(ID：`guance_aws_kinesis_analytics)

点击【安装】后，输入相应的参数：亚马逊 AK、亚马逊账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好亚马逊-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [亚马逊云监控指标详情](https://docs.aws.amazon.com/zh_cn/kinesisanalytics/latest/java/metrics-dimensions.html){:target="_blank"}

| 指标                    | 描述                                                   |  单位       |
| :---------------------- | :---------------------------------------------------- | :----------|
| `cpuUtilization` | 任务管理器中 CPU 利用率的总体百分比。例如，如果有五个任务管理器，Kinesis Data Analytics 会在每个报告间隔发布该指标的五个样本。 | 百分比  |
| `containerCPUUtilization` | Flink 应用程序集群中任务管理器容器中 CPU 利用率的总百分比。例如，如果有五个任务管理器，则相应地有五个TaskManager容器，Kinesis Data Analytics 每 1 分钟报告间隔发布该指标的 2 * 5 个样本。 |百分比|
| `containerMemoryUtilization` | Flink 应用程序集群中任务管理器容器内存利用率的总体百分比。例如，如果有五个任务管理器，则相应地有五个TaskManager容器，Kinesis Data Analytics 每 1 分钟报告间隔发布该指标的 2 * 5 个样本。 |百分比|
| `containerDiskUtilization` | Flink 应用程序集群中任务管理器容器中磁盘利用率的总体百分比。例如，如果有五个任务管理器，则相应地有五个TaskManager容器，Kinesis Data Analytics 每 1 分钟报告间隔发布该指标的 2 * 5 个样本。 |百分比|
| `heapMemoryUtilization` | 任务管理器的总体堆内存利用率。例如，如果有五个任务管理器，Kinesis Data Analytics 会在每个报告间隔发布该指标的五个样本。 |百分比|
| `oldGenerationGCCount` | 所有任务管理器中发生的旧垃圾收集操作的总数。 |计数|
| `oldGenerationGCTime` | 执行旧垃圾收集操作所花费的总时间。 |毫秒|
| `threadCount` | 应用程序使用的实时线程总数。 |计数|


## 对象 {#object}

采集到的AWS KinesisAnalytics 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aws_kinesis_analytics",
  "tags": {
    "ApplicationARN": "arn:aws-cn:xxxx:xxxx",
    "ApplicationMode": "STREAMING",
    "ApplicationName": "zsh_test",
    "ApplicationStatus": "RUNNING",
    "ApplicationVersionId": "3",
    "RegionId": "cn-northwest-1",
    "RuntimeEnvironment": "FLINK-1_15",
    "name": "zsh_test"
  },
  "fields": {
    "message"     : "{实例 JSON 数据}"
  }
}

```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
