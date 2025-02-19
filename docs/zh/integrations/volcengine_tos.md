---
title: '火山引擎 TOS 对象存储'
tags: 
  - 火山引擎
summary: '采集火山引擎 TOS 指标数据'
__int_icon: 'icon/volcengine_tos'
dashboard:

  - desc: '火山引擎 TOS 内置视图'
    path: 'dashboard/zh/volcengine_tos'
monitor:

  - desc: '火山引擎 TOS 监控器'
    path: 'monitor/zh/volcengine_tos'
---

采集火山引擎 TOS 指标数据

## 配置 {#config}

### 安装 Func

推荐开通 {{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的火山引擎 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 TOS 资源的监控数据，我们安装对应的采集脚本：「{{{ custom_key.brand_name }}}集成（火山引擎-TOS采集）」(ID：`guance_volcengine_tos`)

点击【安装】后，输入相应的参数：火山引擎 AK、火山引擎账户名、地域Regions。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在{{{ custom_key.brand_name }}}平台，「基础设施 - 资源目录」中查看是否存在资产信息
3. 在{{{ custom_key.brand_name }}}平台，「指标」查看是否有对应监控数据

## 指标 {#metric}

配置火山引擎 TOS 监控指标，可以通过配置的方式采集更多的指标 [火山引擎 TOS 极速型指标详情](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_TOS){:target="_blank"}

### 火山引擎 TOS 监控指标

|`MetricName` |`Subnamespace` |指标名称 | MetricUnit | Dimension|
| ----------- |---------------| :----: |:--------:  |:-------: |
| `AccountTotalStorage` | `account_overview` | 用户存储总计费容量 | Gibibytes | - |
| `AccountStandardStorage` | `account_overview` | 用户标准存储计费容量 | Gibibytes | - |
| `AccountIAStorage` | `account_overview` | 用户低频存储计费容量 | Gibibytes | - |
| `AccountITStdStorage` | `account_overview` | 用户智能分层高频访问层容量 | Gibibytes | - |
| `AccountITAchiveFrStorage` | `account_overview` | 用户智能分层归档闪回访问层容量 | Gibibytes | - |
| `AccountStandardMultiAZStorage` | `account_overview` | 用户标准存储（多AZ）计费容量 | Gibibytes | - |
| `TotalUploadBandwidthV2` | `bandwidth` | 总流入带宽 | Megabytes/Second | ResourceID |
| `InternetUploadBandwidthV2` | `bandwidth` | 内网流入带宽 | Megabytes/Second | ResourceID |
| `TotalDownloadBandwidthV2` | `bandwidth` | 公网流出总带宽 | Megabytes/Second | ResourceID |
| `InternetDownloadBandwidthV2` | `bandwidth` | 公网流出带宽 | Megabits/Second | ResourceID |
| `GetRequestFirstByteP95Latency` | `bucket_latency` | GET请求首字节P95时延 | Millisecond | ResourceID |
| `PutRequestFirstByteP95Latency` | `bucket_latency` | PUT请求首字节P95时延 | Millisecond | ResourceID |
| `BucketTotalStorage` | `bucket_overview` | 桶对象总容量 | Gibibytes | ResourceID |
| `BucketITStdStorage` | `bucket_overview` | 桶智能分层高频访问层容量 | Gibibytes | ResourceID |
| `BucketArchiveStorage` | `bucket_overview` | 桶归档存储计费容量 | Gibibytes | ResourceID |
| `ErrorRatio` | `bucket_status_code` | 错误率 | Gibibytes | ResourceID |
| `GetObjectQps` | `qps` | GetObject请求QPS | Gibibytes | ResourceID |
| `PutObjectQps` | `qps` | PutObject请求QPS | Gibibytes | ResourceID |
| `ListObjectsQps` | `qps` | ListObjects请求QPS | Gibibytes | ResourceID |
| `UploadPartQps` | `qps` |UploadPart请求QPS | Gibibytes | ResourceID |
| `DeleteObjectQps` | `qps` | DeleteObject请求QPS | Gibibytes | ResourceID |
| `PostObjectQps` | `qps` | PostObject请求QPS | Gibibytes | ResourceID |
| `DeleteObjectsQps` | `qps` | DeleteObjects请求QPS | Gibibytes | ResourceID |
| `TotalStorage` | `storage` | 总存储容量 | Gibibytes | ResourceID |
| `StandardStorage` | `storage` | 标准存储容量 | Gibibytes | ResourceID |
| `InfrequentAccessStorage` | `storage` | 低频存储容量 | Gibibytes | ResourceID |
