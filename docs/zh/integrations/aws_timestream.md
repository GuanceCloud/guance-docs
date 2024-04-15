---
title: 'AWS Timestream'
summary: 'AWS Timestream 的展示指标包括系统错误数（内部服务错误数）、当前 AWS 区域和当前 AWS 帐户的无效请求的总和、成功请求经过的时间和样本数量、存储在内存中的数据量，以及存储在磁存储器中的数据量等。'
__int_icon: 'icon/aws_timestream'
dashboard:

  - desc: 'AWS Timestream 内置视图'
    path: 'dashboard/zh/aws_timestream'

monitor:
  - desc: 'AWS Timestream 监控器'
    path: 'monitor/zh/aws_timestream'

---

<!-- markdownlint-disable MD025 -->
# AWS **Timestream**
<!-- markdownlint-enable -->


AWS **Timestream** 的展示指标包括系统错误数（内部服务错误数）、当前 AWS 区域和当前 AWS 帐户的无效请求的总和、成功请求经过的时间和样本数量、存储在内存中的数据量，以及存储在磁存储器中的数据量等。

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### 安装脚本

> 提示：请提前准备好符合要求的亚马逊云 AK（简单起见，可直接授予 CloudWatch 只读权限`CloudWatchReadOnlyAccess`）

同步 AWS **Timestream** 的监控数据，我们安装对应的采集脚本：「观测云集成（AWS-**Timestream** 采集）」(ID：`guance_aws_timestream`)

点击【安装】后，输入相应的参数：AWS AK ID、AWS AK SECRET、account_name。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。在启动脚本中，需要注意'regions' 与 实例实际所在 regions 保持一致。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

> 如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。


我们默认采集了一些配置, 具体见指标一栏[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}

配置好亚马逊-云监控,默认的指标集如下.可以通过配置的方式采集更多的指标:

[亚马逊云监控 AWS **Timestream** 指标详情](https://docs.aws.amazon.com/zh_cn/timestream/latest/developerguide/metrics-dimensions.html){:target="_blank"}


| 指标名称 | 描述 | 单位 | 有效统计数据 |
| :---: | :---: | :---: | :---: |
| `SystemErrors` | 在指定的时间段内生成系统错误的对 **Timestream** 的请求。系统错误通常表示内部服务错误。 | 计数 | 总和 Sum、数据样本 SampleCount（在 Amazon **Timestream** 控制台中显示为样本数） |
| `UserErrors` | 在指定的时间段内生成 InvalidRequest 错误的 **Timestream** 请求。 InvalidRequest 通常表示客户端错误，例如无效的参数组合、试图更新不存在的表或错误的请求签名。UserErrors表示当前AWS区域和当前AWS帐户的无效请求的总和。 | 计数 | 总和 Sum、数据样本 SampleCount（在 Amazon **Timestream** 控制台中显示为样本数） |
| `SuccessfulRequestLatency` | 在指定时间段内对 **Timestream** 的成功请求。SuccessfulRequestLatency 可以提供两种不同类型的信息:成功请求的运行时间(最小 Minimum、最大 Maximum、总和 Sum 或平均)。成功请求的数量 (SampleCount)。SuccessfulRequestLatency 仅反映 **Timestream** 内的活动，不考虑网络延迟或客户端活动。 | 毫秒 | 平均值 Average、最小值 Minimum、最大值 Maximum、总和 Sum、数据样本 SampleCount（在 Amazon **Timestream** 控制台中显示为样本数） |
| `MemoryCumulativeBytesMetered` | 存储在内存中的数据量，以字节为单位。 | 字节 | 平均值 Average |
| `MagneticCumulativeBytesMetered`| 磁存储器中存储的数据量，以字节为单位。 | 字节 | 平均值 Average  |

