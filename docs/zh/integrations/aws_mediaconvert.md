---
title: 'AWS MediaConvert'
tags: 
  - AWS
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

推荐开通 {{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 AWS MediaConvert 的监控数据，我们安装对应的采集脚本：「{{{ custom_key.brand_name }}}集成（AWS-MediaConvert 采集）」(ID：`guance_aws_mediaconvert`)

点击【安装】后，输入相应的参数：亚马逊 AK、亚马逊账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。




### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在{{{ custom_key.brand_name }}}平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在{{{ custom_key.brand_name }}}平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好 AWS MediaConvert,默认的指标集如下, 可以通过配置的方式采集更多的指标 [AWS MediaConvert 指标详情](https://docs.amazonaws.cn/mediaconvert/latest/ug/what-is.html){:target="_blank"}

### 指标

| TH | TH | TH |
| -- | -- | -- |
| `AvgBitrateBottom` | 平均数据传输速率 | B/S |
| `AvgBitrateTop` | 数据传输速率最高值 | B/S |
| `BlackVideoDetectedRatio` | 黑屏百分比 | % |
| `BlackVideoDetected` | 黑屏发生时间 | seconds |
| `Errors` | 视频错误数量 | count |
| `JobsCanceledCount` | 作业取消数量 | count |
| `JobsCompletedCount` | 作业完成数 | count |
| `JobsErroredCount` | 作业报错数 | count |
| `QVBRAvgQualityHighBitrate` | 视频可变比特率 | % |
| `SDOutputDuration` | 标清输出检测 | seconds |
| `StandbyTime` | 待机时间 | seconds |
| `VideoPaddingInsertedRatio` | 视频填充比例 | % |
| `VideoPaddingInserted` | 是否有视频填充 | count |
