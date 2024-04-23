---
title: '阿里云 OSS'
tags: 
  - 阿里云
summary: '阿里云 OSS 指标展示，包括请求数、可用性、网络流量、请求占比等。'
__int_icon: icon/aliyun_oss
dashboard:
  - desc: '阿里云 OSS 内置视图'
    path: 'dashboard/zh/aliyun_oss/'
monitor:
  - desc: '阿里云 OSS 监控器'
    path: 'monitor/zh/aliyun_oss/'
---

<!-- markdownlint-disable MD025 -->
# 阿里云 OSS
<!-- markdownlint-enable -->


阿里云 OSS 指标展示，包括请求数、可用性、网络流量、请求占比等。


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 阿里云-OSS 的监控数据，我们安装对应的采集脚本：「观测云集成（阿里云-OSS采集）」(ID：`guance_aliyun_oss`)

点击【安装】后，输入相应的参数：阿里云 AK、阿里云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aliyun-oss/){:target="_blank"}




### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好阿里云-OSS,默认的指标集如下, 可以通过配置的方式采集更多的指标 [阿里云云监控指标详情](https://help.aliyun.com/document_detail/31879.html?){:target="_blank"}

| Metric Id                          |                   Metric Name                    | Dimensions                           | Statistics | Unit         |
| ---- | :----: | ---- | ---- | ---- |
| AppendObjectCount                  |              AppendObject成功请求数              | userId,BucketName                    | Value      | Count        |
| AuthorizationErrorCount            |              客户端授权错误请求总数              | userId,BucketName                    | Value      | Count        |
| AuthorizationErrorRate             |              客户端授权错误请求占比              | userId,BucketName                    | Value      | %            |
| Availability                       |                      可用性                      | userId,BucketName                    | Value      | %            |
| CdnRecv                            |                   cdn流入流量                    | userId,BucketName                    | Value      | bytes        |
| CdnSend                            |                   cdn流出流量                    | userId,BucketName                    | Value      | bytes        |
| ClientOtherErrorCount              |              客户端其他错误请求总数              | userId,BucketName                    | Value      | Count        |
| ClientOtherErrorRate               |              客户端其他错误请求占比              | userId,BucketName                    | Value      | %            |
| ClientTimeoutErrorRate             |              客户端超时错误请求占比              | userId,BucketName                    | Value      | %            |
| CopyObjectCount                    |               CopyObject成功请求数               | userId,BucketName                    | Value      | Count        |
| GetObjectCount                     |               GetObject成功请求数                | userId,BucketName                    | Value      | Frequency    |
| GetObjectE2eLatency                |             GetObject请求平均E2E延时             | userId,BucketName                    | Value      | Milliseconds |
| GetObjectServerLatency             |           GetObject请求平均服务器延时            | userId,BucketName                    | Value      | Milliseconds |
| HeadObjectCount                    |               HeadObject成功请求数               | userId,BucketName                    | Value      | Count        |
| InternetRecv                       |                   公网流入流量                   | userId,BucketName                    | Value      | bytes        |
| InternetRecvBandwidth              |                   公网流入带宽                   | userId,BucketName                    | Value      | bps          |
| InternetSend                       |                   公网流出流量                   | userId,BucketName                    | Value      | bytes        |
| InternetSendBandwidth              |                   公网流出带宽                   | userId,BucketName                    | Value      | bps          |
| IntranetRecv                       |                   内网流入流量                   | userId,BucketName                    | Value      | bytes        |
| IntranetRecvBandwidth              |                   内网流入带宽                   | userId,BucketName                    | Value      | bps          |
| IntranetSend                       |                   内网流出流量                   | userId,BucketName                    | Value      | bytes        |
| IntranetSendBandwidth              |                   内网流出带宽                   | userId,BucketName                    | Value      | bps          |
| MaxAppendObjectE2eLatency          |           AppendObject请求最大E2E延时            | userId,BucketName                    | Value      | Milliseconds |
| MaxAppendObjectServerLatency       |          AppendObject请求最大服务器延时          | userId,BucketName                    | Value      | Milliseconds |
| MaxCopyObjectE2eLatency            |            CopyObject请求最大E2E延迟             | userId,BucketName                    | Value      | ms           |
| MaxCopyObjectServerLatency         |           CopyObject请求最大服务器延时           | userId,BucketName                    | Value      | ms           |
| MaxHeadObjectE2eLatency            |            HeadObject请求最大E2E延时             | userId,BucketName                    | Value      | Milliseconds |
| MaxHeadObjectServerLatency         |           HeadObject请求最大服务器延时           | userId,BucketName                    | Value      | Milliseconds |
| MaxPostObjectE2eLatency            |            PostObject请求最大E2E延时             | userId,BucketName                    | Value      | Milliseconds |
| MaxPostObjectServerLatency         |           PostObject请求最大服务器延时           | userId,BucketName                    | Value      | Milliseconds |
| MaxUploadPartE2eLatency            |            UploadPart请求最大E2E延时             | userId,BucketName                    | Value      | Milliseconds |
| MaxUploadPartServerLatency         |           UploadPart请求最大服务器延时           | userId,BucketName                    | Value      | Milliseconds |
| NetworkErrorRate                   |                 网络错误请求占比                 | userId,BucketName                    | Value      | %            |
| PostObjectCount                    |               PostObject成功请求数               | userId,BucketName                    | Value      | Count        |
| RedirectRate                       |                  重定向请求占比                  | userId,BucketName                    | Value      | %            |
| RequestValidRate                   |                    有效请求率                    | userId,BucketName                    | Value      | %            |
| ResourceNotFoundErrorCount         |           客户端资源不存在错误请求总数           | userId,BucketName                    | Value      | Count        |
| ResourceNotFoundErrorRate          |           客户端资源不存在错误请求占比           | userId,BucketName                    | Value      | %            |
| ServerErrorRate                    |                服务端错误请求占比                | userId,BucketName                    | Value      | %            |
| SuccessCount                       |                   成功请求总数                   | userId,BucketName                    | Value      | Count        |
| SuccessRate                        |                   成功请求占比                   | userId,BucketName                    | Value      | %            |
| SyncRecv                           |                跨区域复制流入流量                | userId,BucketName                    | Value      | bytes        |
| SyncSend                           |                跨区域复制流出流量                | userId,BucketName                    | Value      | bytes        |
| TotalRequestCount                  |                     总请求数                     | userId,BucketName                    | Value      | Count        |
| UploadPartCopyCount                |             UploadPartCopy成功请求数             | userId,BucketName                    | Value      | Count        |


## 对象 {#object}

采集到的阿里云 OSS 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aliyun_oss",
  "tags": {
    "name"         : "ack-backup-hangzhou",
    "RegionId"     : "oss-cn-hangzhou",
    "storage_class": "IA",
    "location"     : "oss-cn-hangzhou",
    "grant"        : "private"
  },
  "fields": {
    "extranet_endpoint": "oss-cn-hangzhou.aliyuncs.com",
    "intranet_endpoint": "oss-cn-hangzhou-internal.aliyuncs.com",
    "creation_date"    : 1638415082,
    "message"          : "{实例 JSON 数据}"
  }
}

```
