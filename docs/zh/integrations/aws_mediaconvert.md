---
title: 'AWS MediaConvert'
summary: ' AWS MediaConvert，包括数据传输、视频报错、作业数、填充等。'
__int_icon: 'icon/aws_mediaconvert'
dashboard:

  - desc: 'AWS MediaConvert 内置视图'
    path: 'dashboard/zh/aws_mediaconvert'

monitor:
  - desc: 'AWS MediaConvert 监控器'
    path: 'monitor/zh/aws_mediaconvert'

---

<!-- markdownlint-disable MD025 -->
# AWS MediaConvert
<!-- markdownlint-enable -->


 AWS MediaConvert，包括数据传输、视频报错、作业数、填充等。


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 AWS MediaConvert 的监控数据，我们安装对应的采集脚本：「观测云集成（AWS-MediaConvert 采集）」(ID：`guance_aws_mediaconvert`)

点击【安装】后，输入相应的参数：亚马逊 AK、亚马逊账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。




### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好AWS Aurora Serverless V2,默认的指标集如下, 可以通过配置的方式采集更多的指标 [AWS云监控指标详情](https://docs.amazonaws.cn/mediaconvert/latest/ug/what-is.html){:target="_blank"}


