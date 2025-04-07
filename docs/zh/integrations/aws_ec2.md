---
title: 'AWS EC2'
tags: 
  - AWS
summary: '使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>'
__int_icon: 'icon/aws_ec2'
dashboard:

  - desc: 'AWS EC2 内置视图'
    path: 'dashboard/zh/aws_ec2'

monitor:
  - desc: 'AWS EC2 监控器'
    path: 'monitor/zh/aws_ec2'

cloudCollector:
  desc: '云采集器'
  path: 'cloud-collector/zh/aws_ec2'
---


<!-- markdownlint-disable MD025 -->
# AWS EC2
<!-- markdownlint-enable -->

使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>


## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考[自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### 开通脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

#### 托管版开通脚本

1. 登陆<<< custom_key.brand_name >>>控制台
2. 点击【管理】菜单，选择【云帐号管理】
3. 点击【添加云帐号】，选择【AWS】，填写界面所需的信息，如之前已配置过云帐号信息，则忽略此步骤
4. 点击【测试】，测试成功后点击【保存】，如果测试失败，请检查相关配置信息是否正确，并重新测试
5. 点击【云帐号管理】列表上可以看到已添加的云账号，点击相应的云帐号，进入详情页
6. 点击云帐号详情页的【集成】按钮，在`未安装`列表下，找到`AWS EC2`，点击【安装】按钮，弹出安装界面安装即可。


#### 手动开通脚本

1. 登陆Func 控制台，点击【脚本市场】，进入官方脚本市场，搜索:`guance_aws_ec2`

2. 点击【安装】后，输入相应的参数：AWS AK ID 、AK Secret 及账户名。

3. 点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

4. 开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好亚马逊-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [亚马逊云监控指标详情](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/viewing_metrics_with_cloudwatch.html){:target="_blank"}

> 提示：如果发现内存、磁盘没有指标上报的情况， 前往 aws 控制台手动开启采集

### 实例指标

`AWS/EC2` 命名空间包括以下实例指标。

| 指标                    | 描述                                                         |
| :---------------------- | :----------------------------------------------------------- |
| `CPUUtilization`    | Amazon EC2 用于运行 EC2 实例的物理 CPU 时间的百分比，包括运行用户代码和 Amazon EC2 代码所花费的时间。在很高的级别上，`CPUUtilization` 是 guest `CPUUtilization` 和 hypervisor `CPUUtilization` 的总和。由于旧设备模拟、非旧设备配置、中断密集型工作负载、实时迁移和实时更新等因素，操作系统中的工具显示的百分比可能与 CloudWatch 不同。单位：百分比 |
| `DiskReadOps`       | 在指定时间段内从可供实例使用的所有实例存储卷完成的读取操作数。要计算该周期的每秒平均 I/O 操作数 (IOPS)，请将该周期的总操作数除以总秒数。如果没有实例存储卷，则值为 0 或不报告指标。单位：计数 |
| `DiskWriteOps`      | 在指定时间段内向可供实例使用的所有实例存储卷完成的写入操作数。要计算该周期的每秒平均 I/O 操作数 (IOPS)，请将该周期的总操作数除以总秒数。如果没有实例存储卷，则值为 0 或不报告指标。单位：计数 |
| `DiskReadBytes`     | 从可供实例使用的所有实例存储卷读取的字节数。该指标用来确定应用程序从实例的硬盘读取的数据量。它可以用来确定应用程序的速度。报告的数量是该期间内接收的字节数。如果您使用的是基本（5 分钟）监控，则可以将此数字除以 300 以获得字节/秒。如果您使用的是详细（1 分钟）监控，请将其除以 60。您也可以使用 CloudWatch 指标数学函数 `DIFF_TIME` 来查找每秒字节数。例如，如果您在 CloudWatch 中绘制 `DiskReadBytes` 为 `m1`，指标数学公式 `m1/(DIFF_TIME(m1))` 会返回以字节/秒为单位的指标。有关 `DIFF_TIME` 和其他指标数学函数的更多信息，请参阅《Amazon CloudWatch 用户指南》中的[使用指标数学](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html){:target="_blank"}。如果没有实例存储卷，则值为 0 或不报告指标。单位：字节 |
| `DiskWriteBytes`    | 向可供实例使用的所有实例存储卷写入的字节数。该指标用来确定应用程序向实例的硬盘写入的数据量。它可以用来确定应用程序的速度。报告的数量是该期间内接收的字节数。如果您使用的是基本（5 分钟）监控，则可以将此数字除以 300 以获得字节/秒。如果您使用的是详细（1 分钟）监控，请将其除以 60。您也可以使用 CloudWatch 指标数学函数 `DIFF_TIME` 来查找每秒字节数。例如，如果您在 CloudWatch 中绘制 `DiskWriteBytes` 为 `m1`，指标数学公式 `m1/(DIFF_TIME(m1))` 会返回以字节/秒为单位的指标。有关 `DIFF_TIME` 和其他指标数学函数的更多信息，请参阅《Amazon CloudWatch 用户指南》中的[使用指标数学](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html){:target="_blank"}。如果没有实例存储卷，则值为 0 或不报告指标。单位：字节 |
| `MetadataNoToken`   | 在没有令牌的情况下成功访问实例元数据服务的次数。该指标用于确定是否有任何进程正在使用 实例元数据服务版本 1 访问实例元数据，但未使用令牌。如果所有请求都使用支持令牌的会话（即 实例元数据服务版本 2），则该值为 0。有关更多信息，请参阅[转换为使用 实例元数据服务版本 2](https://docs.aws.amazon.com/zh_cn/AWSEC2/latest/UserGuide/instance-metadata-transition-to-version-2.html){:target="_blank"}。单位：计数 |
| `NetworkIn`         | 实例在所有网络接口上收到的字节数。此指标用于确定流向单个实例的传入网络流量。报告的数量是该期间内接收的字节数。如果您使用的是基本（5 分钟）监控且统计数据为 Sum，则可以将此数字除以 300 以获得字节/秒。如果您使用的是详细（1 分钟）监控且统计数据为 Sum，请将其除以 60。您也可以使用 CloudWatch 指标数学函数 `DIFF_TIME` 来查找每秒字节数。例如，如果您在 CloudWatch 中绘制 `NetworkIn` 为 `m1`，指标数学公式 `m1/(DIFF_TIME(m1))` 会返回以字节/秒为单位的指标。有关 `DIFF_TIME` 和其他指标数学函数的更多信息，请参阅《Amazon CloudWatch 用户指南》中的[使用指标数学](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html){:target="_blank"}。单位：字节 |
| `NetworkOut`        | 实例在所有网络接口上发送的字节数。此指标用于确定来自单个实例的传出网络流量。报告的数字是该时间段内发送的字节数。如果您使用的是基本（5 分钟）监控且统计数据为 Sum，则可以将此数字除以 300 以获得字节/秒。如果您使用的是详细（1 分钟）监控且统计数据为 Sum，请将其除以 60。您也可以使用 CloudWatch 指标数学函数 `DIFF_TIME` 来查找每秒字节数。例如，如果您在 CloudWatch 中绘制 `NetworkOut` 为 `m1`，指标数学公式 `m1/(DIFF_TIME(m1))` 会返回以字节/秒为单位的指标。有关 `DIFF_TIME` 和其他指标数学函数的更多信息，请参阅《Amazon CloudWatch 用户指南》中的[使用指标数学](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html){:target="_blank"}。单位：字节 |
| `NetworkPacketsIn`  | 实例在所有网络接口上收到的数据包数。此指标依据单个实例上的数据包数量来标识传入流量的量。此指标仅可用于基本监控（5 分钟期间）。要计算实例 5 分钟内每秒收到的数据包数 (PPS)，请将 Sum 统计数据除以 300。您也可以使用 CloudWatch 指标数学函数 `DIFF_TIME` 来查找每秒数据包数。例如，如果您在 CloudWatch 中绘制 `NetworkPacketsIn` 为 `m1`，指标数学公式 `m1/(DIFF_TIME(m1))` 会返回以数据包/秒为单位的指标。有关 `DIFF_TIME` 和其他指标数学函数的更多信息，请参阅《Amazon CloudWatch 用户指南》中的[使用指标数学](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html){:target="_blank"}。单位：计数 |
| `NetworkPacketsOut` | 实例在所有网络接口上发送的数据包数。此指标依据单个实例上的数据包数量标识传出流量的量。此指标仅可用于基本监控（5 分钟期间）。要计算实例 5 分钟内每秒发送的数据包数（PPS），请将 Sum 统计数据除以 300。您也可以使用 CloudWatch 指标数学函数 `DIFF_TIME` 来查找每秒数据包数。例如，如果您在 CloudWatch 中绘制 `NetworkPacketsOut` 为 `m1`，指标数学公式 `m1/(DIFF_TIME(m1))` 会返回以数据包/秒为单位的指标。有关 `DIFF_TIME` 和其他指标数学函数的更多信息，请参阅《Amazon CloudWatch 用户指南》中的[使用指标数学](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html){:target="_blank"}。单位：计数 |

### CPU 指标

`AWS/EC2` 命名空间包括 [可突增性能实例](https://docs.aws.amazon.com/zh_cn/AWSEC2/latest/UserGuide/burstable-performance-instances.html){:target="_blank"}的以下 CPU 积分指标。

| 指标                           | 描述                                                         |
| :----------------------------- | :----------------------------------------------------------- |
| `CPUCreditUsage`           | 实例为保持 CPU 使用率而花费的 CPU 积分数。一个 CPU 积分等于一个 vCPU 按 100% 利用率运行一分钟，或者 vCPU、利用率和时间的等效组合（例如， 一个 vCPU 按 50% 利用率运行两分钟，或者两个 vCPU 按 25% 利用率运行两分钟）。CPU 信用指标仅每 5 分钟提供一次。如果您指定一个大于五分钟的时间段，请使用`Sum` 统计数据，而非 `Average` 统计数据。单位：积分 (vCPU 分钟) |
| `CPUCreditBalance`         | 实例自启动后已累积获得的 CPU 积分数。对于 T2 标准，`CPUCreditBalance` 还包含已累积的启动积分数。在获得积分后，积分将在积分余额中累积；在花费积分后，将从积分余额中扣除积分。积分余额具有最大值限制，这是由实例大小决定的。在达到限制后，将丢弃获得的任何新积分。对于 T2 标准，启动积分不计入限制。实例可以花费 `CPUCreditBalance` 中的积分，以便突增到基准 CPU 使用率以上。在实例运行过程中，`CPUCreditBalance` 中的积分不会过期。在 T3 或 T3a 实例停止时，`CPUCreditBalance` 值将保留七天。之后，所有累积的积分都将丢失。在 T2 实例停止时，`CPUCreditBalance` 值不会保留，并且所有累积的积分都将丢失。CPU 信用指标仅每 5 分钟提供一次。单位：积分 (vCPU 分钟) |
| `CPUSurplusCreditBalance`  | 在 `unlimited` 值为零时，`CPUCreditBalance` 实例花费的超额积分数。`CPUSurplusCreditBalance` 值由获得的 CPU 积分支付。如果超额积分数超出实例可在 24 小时周期内获得的最大积分数，则超出最大积分数的已花费超额积分将产生额外费用。CPU 信用指标仅每 5 分钟提供一次。单位：积分 (vCPU 分钟) |
| `CPUSurplusCreditsCharged` | 未由获得的 CPU 积分支付并且会产生额外费用的已花费超额积分数。在出现以下任一情况时，将对花费的超额积分收费：花费的超额积分超出实例可在 24 小时周期内获得的最大积分数。对于超出最大积分数的所花费超额积分，将在该小时结束时向您收费。实例已停止或终止。实例从 `unlimited` 切换为 `standard`。CPU 信用指标仅每 5 分钟提供一次。单位：积分 (vCPU 分钟) |


### 状态检查指标
AWS/EC2 命名空间包括以下状态检查指标。默认情况下，状态检查指标可在 1 分钟的频率下免费提供。对于新启动的实例，状态检查指标数据仅在实例完成初始化状态之后 (实例进入运行状态的几分钟之内) 提供。有关 EC2 状态检查的更多信息，请参阅[实例的状态检查](https://docs.aws.amazon.com/zh_cn/AWSEC2/latest/UserGuide/monitoring-system-instance-status-check.html){:target="_blank"}。
| 指标                           | 描述                                                         |
| :----------------------------- | :----------------------------------------------------------- |
|`StatusCheckFailed`|报告实例在上一分钟是否通过了实例状态检查和系统状态检查。此指标可以是 0 (通过) 或 1 (失败)。默认情况下，此指标可在 1 分钟的频率下免费提供。单位：计数|
|`StatusCheckFailed_Instance`|报告实例在上个 1 分钟内是否通过了 实例状况检查。此指标可以是 0 (通过) 或 1 (失败)。默认情况下，此指标可在 1 分钟的频率下免费提供。单位：计数|
|`StatusCheckFailed_System`|报告实例在上一分钟内是否通过了 系统状况检查。此指标可以是 0 (通过) 或 1 (失败)。默认情况下，此指标可在 1 分钟的频率下免费提供。单位：计数|

## 对象 {#object}

采集到的AWS EC2 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aws_ec2",
  "tags": {
    "name"           : "i-0d7620xxxxxxx",
    "InstanceId"     : "i-0d7620xxxxxxx",
    "InstanceType"   : "c6g.xlarge",
    "PlatformDetails": "Linux/UNIX",
    "RegionId"       : "cn-northwest-1",
    "InstanceName"   : "test",
    "State"          : "running",
    "StateReason_Code"   : "Client.UserInitiatedHibernate",
    "AvailabilityZone": "cn-northwest-1",
  },
  "fields": {
    "BlockDeviceMappings": "{设备 JSON 数据}",
    "LaunchTime"         : "2021-10-26T07:00:44Z",
    "NetworkInterfaces"  : "{网络 JSON 数据}",
    "Placement"          : "{可用区 JSON 数据}",
    "message"            : "{实例 JSON 数据}"
  }
}
```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示1：`tags.name`值为实例 ID，作为唯一识别
> 提示2：`fields.message`，`fields.NetworkInterfaces`，`fields.BlockDeviceMappings`为 JSON 序列化后字符串
