---
title: 'Amazon EC2 Spot'
tags: 
  - AWS
summary: ' Amazon EC2 Spot，包括请求容量池、目标容量池、中止容量等。'
__int_icon: 'icon/aws_ec2_spot'
dashboard:

  - desc: 'Amazon EC2 Spot 内置视图'
    path: 'dashboard/zh/aws_ec2_spot'

monitor:
  - desc: 'Amazon EC2 Spot'
    path: 'monitor/zh/aws_ec2_spot'

---

<!-- markdownlint-disable MD025 -->
# Amazon EC2 Spot
<!-- markdownlint-enable -->


 Amazon EC2 Spot，包括请求容量池、目标容量池、中止容量等。


## 配置 {#config}

### 安装 Func

推荐开通 {{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 Amazon EC2 Spot 的监控数据，我们安装对应的采集脚本：「{{{ custom_key.brand_name }}}集成（AWS-EC2 Spot采集）」(ID：`guance_aws_ec2_spot`)

点击【安装】后，输入相应的参数：亚马逊 AK、亚马逊账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。



### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在{{{ custom_key.brand_name }}}平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在{{{ custom_key.brand_name }}}平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好Amazon EC2 Spot,默认的指标集如下, 可以通过配置的方式采集更多的指标 [AWS云监控指标详情](https://docs.aws.amazon.com/zh_cn/AWSEC2/latest/UserGuide/spot-fleet-cloudwatch-metrics.html){:target="_blank"}



| 指标                                                         | 描述                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| `AvailableInstancePoolsCount`                                        | Spot 队列请求中指定的 Spot 容量池 |
| `BidsSubmittedForCapacity`                                        | Amazon EC2 已提交 Spot 队列请求的容量 |
| `EligibleInstancePoolCount`                                | 在 Amazon EC2 可以完成请求的 Spot 队列请求中指定的 Spot 容量池。 |
| `FulfilledCapacity`                             | Amazon EC2 已执行的容量      |
| `MaxPercentCapacityAllocation`                               | 竞价型实例集请求中指定的所有竞价型实例集池间的 PercentCapacityAllocation 最大值 |
| `PercentCapacityAllocation`                               | 针对所指定维度的 Spot 容量池分配的容量 |
| `TargetCapacity`                           | Spot 队列请求的目标容量                    |
| `TerminatingCapacity`                                 | 因预置容量大于目标容量而终止的容量             |

