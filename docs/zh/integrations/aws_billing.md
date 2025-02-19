---
title: 'AWS 云账单'
tags: 
  - AWS
summary: '采集 AWS 云账单信息'
__int_icon: 'icon/aws'
dashboard:
  - desc: '云账单分析视图'
    path: 'dashboard/zh/Intelligent_analysis_cloud_billing/'
---

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考[自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 AWS-账单采集监控数据，我们安装对应的采集脚本：「观测云集成（AWS-账单采集-实例维度）」(ID：`guance_aws_billing_by_instance`)

点击【安装】后，输入相应的参数：亚马逊 AK、亚马逊账户名、Area。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「云账单 / 账单分析」中查看是否存在对应的账单信息

