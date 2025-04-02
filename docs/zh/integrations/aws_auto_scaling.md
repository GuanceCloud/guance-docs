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

cloudCollector:
  desc: '云采集器'
  path: 'cloud-collector/zh/aws_auto_scaling'
---

<!-- markdownlint-disable MD025 -->
# AWS Auto Scaling
<!-- markdownlint-enable -->


 AWS Auto Scaling，包括实例数、容量单位、暖池等。


## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}


### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

#### 托管版开通脚本

1. 登陆<<< custom_key.brand_name >>>控制台
2. 点击【管理】菜单，选择【云帐号管理】
3. 点击【添加云帐号】，选择【AWS】，填写界面所需的信息，如之前已配置过云帐号信息，则忽略此步骤
4. 点击【测试】，测试成功后点击【保存】，如果测试失败，请检查相关配置信息是否正确，并重新测试
5. 点击【云帐号管理】列表上可以看到已添加的云账号，点击相应的云帐号，进入详情页
6. 点击云帐号详情页的【集成】按钮，在`未安装`列表下，找到`AWS Auto Scaling`，点击【安装】按钮，弹出安装界面安装即可。


#### 手动开通脚本

1. 登陆Func 控制台，点击【脚本市场】，进入官方脚本市场，搜索:`guance_aws_auto_scaling`

2. 点击【安装】后，输入相应的参数：AWS AK ID 、AK Secret 及账户名。

3. 点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

4. 开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。



### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

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
