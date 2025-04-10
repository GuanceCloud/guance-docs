---
title: 'AWS KinesisAnalytics'
tags: 
  - AWS
summary: '使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>'
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

使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>


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
6. 点击云帐号详情页的【集成】按钮，在`未安装`列表下，找到`AWS KinesisAnalytics`，点击【安装】按钮，弹出安装界面安装即可。

#### 手动开通脚本

1. 登陆Func 控制台，点击【脚本市场】，进入官方脚本市场，搜索:`guance_aws_kinesis_analytics`

2. 点击【安装】后，输入相应的参数：AWS AK ID 、AK Secret 及账户名。

3. 点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

4. 开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

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
