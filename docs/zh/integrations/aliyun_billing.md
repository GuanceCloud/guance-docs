---
title: '阿里云 云账单'
tags: 
  - 阿里云
summary: '采集阿里云云账单信息'
__int_icon: 'icon/aliyun'
dashboard:
  - desc: '云账单分析视图'
    path: 'dashboard/zh/Intelligent_analysis_cloud_billing/'

---

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考[自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 CDN 云资源的监控数据，我们安装对应的采集脚本 ID：`guance_aliyun_billing_by_instance`

点击【安装】后，输入相应的参数：阿里云 AK、阿里云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

### 验证

在观测云平台，在菜单「云账单」中查看是否有对应云账单数据
