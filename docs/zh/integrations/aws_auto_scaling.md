---
title: 'AWS Auto Scaling'
tags: 
  - AWS
summary: 'AWS Auto Scaling，包括实例数、容量单位、暖池等。'
__int_icon: 'icon/aws_auto_scaling'
dashboard:

  - desc: 'AWS Auto Scaling 内置视图'
    path: 'dashboard/zh/aws_auto_scaling'

monitor:
  - desc: 'AWS Auto Scaling 监控器'
    path: 'monitor/zh/aws_auto_scaling'

---

<!-- markdownlint-disable MD025 -->
# AWS Auto Scaling
<!-- markdownlint-enable -->


 AWS Auto Scaling，包括实例数、容量单位、暖池等。


## 配置 {#config}

### 安装 Func

推荐开通 {{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 AWS Auto Scaling 的监控数据，我们安装对应的采集脚本：「{{{ custom_key.brand_name }}}集成（AWS-Auto Scaling采集）」(ID：`guance_aws_auto_scaling`)

点击【安装】后，输入相应的参数：亚马逊 AK、亚马逊账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。



### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在{{{ custom_key.brand_name }}}平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在{{{ custom_key.brand_name }}}平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好AWS Auto Scaling,默认的指标集如下, 可以通过配置的方式采集更多的指标 [AWS云监控指标详情](https://docs.aws.amazon.com/zh_cn/autoscaling/ec2/userguide/viewing-monitoring-graphs.html){:target="_blank"}



| 指标                                                         | 描述                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| `GroupMinSize`                                        | 自动扩缩组的最小大小 |
| `GroupMaxSize`                                        | 自动扩缩组的最大大小 |
| `GroupDesiredCapacity`                                          | Auto Scaling 组试图维护的实例数量 |
| `GroupInServiceInstances`                                              | 作为 Auto Scaling 组的一部分运行的实例数量。该指标不包括处于挂起或终止状态的实例      |
| `GroupPendingInstances`                                        | 处于挂起状态的实例数量。挂起的实例尚不可用。该指标不包括处于可用状态ss或终止状态的实例 |
| `GroupStandbyInstances`                                   | 处于 Standby 状态的实例数。处于此状态的实例仍在运行，但不能有效使用 |
| `GroupTerminatingInstances`                                       | 正处于终止过程中的实例的数量。该指标不包括处于可用状态或挂起状态的实例                    |
| `GroupTotalInstances`                                  | Auto Scaling 组中的实例总数。该指标用于标识处于可用状态、挂起状态和终止状态的实例的数量             |
| `GroupTotalCapacity`                                          | Auto Scaling 组中的容量单位总数                     |
| `GroupPendingCapacity`                                                      | 待处理的容量单位数 |
| `GroupStandbyCapacity`                                        | 处于 Standby 状态的容量单位数 |
| `GroupTerminatingCapacity`                                             | 正处于终止过程中的容量单位的数量 |
| `GroupTotalCapacity`                                           | Auto Scaling 组中的容量单位总数 |
| `WarmPoolMinSize`                                     | 暖池的最小大小 |
| `GroupAndWarmPoolDesiredCapacity`                                                 | Auto Scaling 组和暖池结合起来的所需容量 |
| `WarmPoolPendingCapacity`                                          | 暖池中待处理的容量数。该指标不包括处于运行、挂起或终止状态的实例 |
| `WarmPoolTerminatingCapacity`                                  | 暖池中处于终止过程的容量数。该指标不包括处于运行、已停止或挂起状态的实例 |
| `WarmPoolWarmedCapacity`                                     | 横向扩展期间可进入 Auto Scaling 组的容量数。该指标不包括处于挂起或终止状态的实例 |
| `WarmPoolTotalCapacity`                                   | 暖池的总容量，包括处于运行、已停止、挂起或终止状态的实例 |
| `GroupAndWarmPoolDesiredCapacity`                                    | Auto Scaling 组和暖池结合起来的所需容量 |
| `GroupAndWarmPoolTotalCapacity`                           | Auto Scaling 组和暖池结合起来的总容量。这包括处于运行、已停止、挂起、终止或服务中状态的实例 |
