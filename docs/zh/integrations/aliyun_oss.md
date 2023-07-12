---
title: '阿里云 OSS'
summary: '阿里云 OSS 指标展示，包括请求数、可用性、网络流量、请求占比等。'
<<<<<<< HEAD
icon: icon/aliyun_oss
=======
__int_icon: icon/aliyun_oss
>>>>>>> bcdb7fa10debda85713fee55db2e1181e9301f46
dashboard:
  - desc: '阿里云 OSS 内置视图'
    path: 'dashboard/zh/aliyun_oss/'

---
# 阿里云 OSS 

阿里云 OSS 指标展示，包括请求数、可用性、网络流量、请求占比等。


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func ](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步云资源的监控数据，我们一般情况下要安装采集云监控信息的脚本。

如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。

分别在「管理 / 脚本市场」中，依次点击并按照对应的脚本包：

- 「观测云集成（阿里云-云监控）」(ID：`guance_aliyun_monitor`)
- 「观测云集成（阿里云-OSS采集）」(ID：`guance_aliyun_oss`)

点击【安装】后，输入相应的参数：阿里云 AK、阿里云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标] (https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好阿里云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [阿里云云监控指标详情](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                          |                   Metric Name                    | Dimensions                           | Statistics | Unit         |
| ---- | :----: | ---- | ---- | ---- |
| AppendObjectCount                  |              AppendObject成功请求数              | userId,BucketName                    | Value      | Count        |
| AppendObjectE2eLatency             |           AppendObject请求平均E2E延时            | userId,BucketName                    | Value      | Milliseconds |
| AppendObjectServerLatency          |          AppendObject请求平均服务器延时          | userId,BucketName                    | Value      | Milliseconds |
| AuthorizationErrorCount            |              客户端授权错误请求总数              | userId,BucketName                    | Value      | Count        |
| AuthorizationErrorRate             |              客户端授权错误请求占比              | userId,BucketName                    | Value      | %            |
| Availability                       |                      可用性                      | userId,BucketName                    | Value      | %            |
| CdnRecv                            |                   cdn流入流量                    | userId,BucketName                    | Value      | bytes        |
| CdnSend                            |                   cdn流出流量                    | userId,BucketName                    | Value      | bytes        |
| ClientOtherErrorCount              |              客户端其他错误请求总数              | userId,BucketName                    | Value      | Count        |
| ClientOtherErrorRate               |              客户端其他错误请求占比              | userId,BucketName                    | Value      | %            |
| ClientTimeoutErrorCount            |              客户端超时错误请求总数              | userId,BucketName                    | Value      | Count        |
| ClientTimeoutErrorRate             |              客户端超时错误请求占比              | userId,BucketName                    | Value      | %            |
| CopyObjectCount                    |               CopyObject成功请求数               | userId,BucketName                    | Value      | Count        |
| CopyObjectE2eLatency               |            CopyObject请求平均E2E延时             | userId,BucketName                    | Value      | ms           |
| CopyObjectServerLatency            |           CopyObject请求平均服务器延时           | userId,BucketName                    | Value      | ms           |
| DeleteObjectCount                  |              DeleteObject成功请求数              | userId,BucketName                    | Value      | Count        |
| DeleteObjectsCount                 |             DeleteObjects成功请求数              | userId,BucketName                    | Value      | Count        |
| GetObjectCount                     |               GetObject成功请求数                | userId,BucketName                    | Value      | Frequency    |
| GetObjectE2eLatency                |             GetObject请求平均E2E延时             | userId,BucketName                    | Value      | Milliseconds |
| GetObjectServerLatency             |           GetObject请求平均服务器延时            | userId,BucketName                    | Value      | Milliseconds |
| HeadObjectCount                    |               HeadObject成功请求数               | userId,BucketName                    | Value      | Count        |
| HeadObjectE2eLatency               |            HeadObject请求平均E2E延时             | userId,BucketName                    | Value      | Milliseconds |
| HeadObjectServerLatency            |           HeadObject请求平均服务器延时           | userId,BucketName                    | Value      | Milliseconds |
| InternetRecv                       |                   公网流入流量                   | userId,BucketName                    | Value      | bytes        |
| InternetRecvBandwidth              |                   公网流入带宽                   | userId,BucketName                    | Value      | bps          |
| InternetRecvBandwidthUsageRate     |                公网上行带宽使用率                | userId,BucketName                    | Value      | %            |
| InternetSend                       |                   公网流出流量                   | userId,BucketName                    | Value      | bytes        |
| InternetSendBandwidth              |                   公网流出带宽                   | userId,BucketName                    | Value      | bps          |
| InternetSendBandwidthUsageRate     |                公网下行带宽使用率                | userId,BucketName                    | Value      | %            |
| IntranetRecv                       |                   内网流入流量                   | userId,BucketName                    | Value      | bytes        |
| IntranetRecvBandwidth              |                   内网流入带宽                   | userId,BucketName                    | Value      | bps          |
| IntranetRecvBandwidthUsageRate     |                内网上行带宽使用率                | userId,BucketName                    | Value      | %            |
| IntranetSend                       |                   内网流出流量                   | userId,BucketName                    | Value      | bytes        |
| IntranetSendBandwidth              |                   内网流出带宽                   | userId,BucketName                    | Value      | bps          |
| IntranetSendBandwidthUsageRate     |                内网下行带宽使用率                | userId,BucketName                    | Value      | %            |
| MaxAppendObjectE2eLatency          |           AppendObject请求最大E2E延时            | userId,BucketName                    | Value      | Milliseconds |
| MaxAppendObjectServerLatency       |          AppendObject请求最大服务器延时          | userId,BucketName                    | Value      | Milliseconds |
| MaxCopyObjectE2eLatency            |            CopyObject请求最大E2E延迟             | userId,BucketName                    | Value      | ms           |
| MaxCopyObjectServerLatency         |           CopyObject请求最大服务器延时           | userId,BucketName                    | Value      | ms           |
| MaxGetObjectE2eLatency             |             GetObject请求最大E2E延时             | userId,BucketName                    | Value      | Milliseconds |
| MaxGetObjectServerLatency          |           GetObject请求最大服务器延时            | userId,BucketName                    | Value      | Milliseconds |
| MaxHeadObjectE2eLatency            |            HeadObject请求最大E2E延时             | userId,BucketName                    | Value      | Milliseconds |
| MaxHeadObjectServerLatency         |           HeadObject请求最大服务器延时           | userId,BucketName                    | Value      | Milliseconds |
| MaxPostObjectE2eLatency            |            PostObject请求最大E2E延时             | userId,BucketName                    | Value      | Milliseconds |
| MaxPostObjectServerLatency         |           PostObject请求最大服务器延时           | userId,BucketName                    | Value      | Milliseconds |
| MaxPutObjectE2eLatency             |             PutObject请求最大E2E延时             | userId,BucketName                    | Value      | Milliseconds |
| MaxPutObjectServerLatency          |           PutObject请求最大服务器延时            | userId,BucketName                    | Value      | Milliseconds |
| MaxUploadPartCopyE2eLatency        |          UploadPartCopy请求最大E2E延时           | userId,BucketName                    | Value      | Milliseconds |
| MaxUploadPartCopyServerLatency     |         UploadPartCopy请求最大服务器延时         | userId,BucketName                    | Value      | Milliseconds |
| MaxUploadPartE2eLatency            |            UploadPart请求最大E2E延时             | userId,BucketName                    | Value      | Milliseconds |
| MaxUploadPartServerLatency         |           UploadPart请求最大服务器延时           | userId,BucketName                    | Value      | Milliseconds |
| MeteringCdnRX                      |                 cdn流入计量流量                  | userId,BucketName,region,storageType | Value      | bytes        |
| MeteringCdnTX                      |                 cdn流出计量流量                  | userId,BucketName,region,storageType | Value      | bytes        |
| MeteringGetRequest                 |                   Get类请求数                    | userId,BucketName,region,storageType | Value      | Count        |
| MeteringInternetRX                 |                 公网流入计量流量                 | userId,BucketName,region,storageType | Value      | bytes        |
| MeteringInternetTX                 |                 公网流出计量流量                 | userId,BucketName,region,storageType | Value      | bytes        |
| MeteringIntranetRX                 |                MeteringIntranetRX                | userId,BucketName,region,storageType | Value      | bytes        |
| MeteringIntranetTX                 |                MeteringIntranetTX                | userId,BucketName,region,storageType | Value      | bytes        |
| MeteringPutRequest                 |                   Put类请求数                    | userId,BucketName,region,storageType | Value      | Count        |
| MeteringStorageUtilization         |                     存储大小                     | userId,BucketName,region,storageType | Value      | bytes        |
| MeteringSyncRX                     |              跨区域复制流入计量流量              | userId,BucketName,region,storageType | Value      | bytes        |
| MeteringSyncTX                     |              跨区域复制流出计量流量              | userId,BucketName,region,storageType | Value      | bytes        |
| MirrorAverageLatency               |     [镜像回源]指定回源源站的正常请求平均延时     | userId,BucketName,Host               | Value      | milliseconds |
| MirrorAverageLatencyByStatus       |   [镜像回源]指定返回值和回源源站的请求平均延时   | userId,BucketName,Host,Status        | Value      | milliseconds |
| MirrorRequestCount                 |       [镜像回源]指定回源源站的正常请求总数       | userId,BucketName,Host               | Value      | frequency    |
| MirrorRequestCountByStatus         |     [镜像回源]指定返回值和回源源站的请求总数     | userId,BucketName,Host,Status        | Value      | frequency    |
| MirrorRequestTransferSpeed         |   [镜像回源]指定回源源站的正常请求平均传输速度   | userId,BucketName,Host               | Value      | Bytes/s      |
| MirrorRequestTransferSpeedByStatus | [镜像回源]指定返回值和回源源站的请求平均传输速度 | userId,BucketName,Host,Status        | Value      | Bytes/s      |
| MirrorTraffic                      |     [镜像回源]指定回源源站的正常请求流入流量     | userId,BucketName,Host               | Value      | Bytes        |
| MirrorTrafficByStatus              |   [镜像回源]指定返回值和回源源站的请求流入流量   | userId,BucketName,Host,Status        | Value      | Bytes        |
| NetworkErrorCount                  |                 网络错误请求总数                 | userId,BucketName                    | Value      | Count        |
| NetworkErrorRate                   |                 网络错误请求占比                 | userId,BucketName                    | Value      | %            |
| PostObjectCount                    |               PostObject成功请求数               | userId,BucketName                    | Value      | Count        |
| PostObjectE2eLatency               |            PostObject请求平均E2E延时             | userId,BucketName                    | Value      | Milliseconds |
| PostObjectServerLatency            |           PostObject请求平均服务器延时           | userId,BucketName                    | Value      | Milliseconds |
| PutObjectCount                     |               PutObject成功请求数                | userId,BucketName                    | Value      | Count        |
| PutObjectE2eLatency                |             PutObject请求平均E2E延时             | userId,BucketName                    | Value      | Milliseconds |
| PutObjectServerLatency             |           PutObject请求平均服务器延时            | userId,BucketName                    | Value      | Milliseconds |
| QosCpuMaxQps                       |             图片处理核数qps流控阈值              | userId,BucketName                    | Value      | Count/s      |
| QosCpuMaxRecvFlow                  |             图片处理核数下载流控阈值             | userId,BucketName                    | Value      | Byte/s       |
| QosCpuMaxSendFlow                  |             图片处理核数上传流控阈值             | userId,BucketName                    | Value      | Byte/s       |
| QosGetBucketMaxQps                 |             GetBucket请求qps流控阈值             | userId,BucketName                    | Value      | Count/s      |
| QosGetBucketMaxRecvFlow            |            GetBucket请求下载流控阈值             | userId,BucketName                    | Value      | Byte/s       |
| QosGetBucketMaxSendFlow            |            GetBucket请求上传流控阈值             | userId,BucketName                    | Value      | Byte/s       |
| QosGetObjectMaxQps                 |             GetObject请求qps流控阈值             | userId,BucketName                    | Value      | Count/s      |
| QosGetObjectMaxRecvFlow            |            GetObject请求下载流控阈值             | userId,BucketName                    | Value      | Byte/s       |
| QosGetObjectMaxSendFlow            |            GetObject请求上传流控阈值             | userId,BucketName                    | Value      | Byte/s       |
| QosMaxExtranetQps                  |                 外网qps流控阈值                  | userId,BucketName                    | Value      | Count/s      |
| QosMaxExtranetRecvFlow             |               外网下载带宽流控阈值               | userId,BucketName                    | Value      | Byte/s       |
| QosMaxExtranetSendFlow             |               外网上传带宽流控阈值               | userId,BucketName                    | Value      | Byte/s       |
| QosMaxIntranetQps                  |                 内网qps流控阈值                  | userId,BucketName                    | Value      | Count/s      |
| QosMaxIntranetRecvFlow             |               内网下载带宽流控阈值               | userId,BucketName                    | Value      | Byte/s       |
| QosMaxIntranetSendFlow             |               内网上传带宽流控阈值               | userId,BucketName                    | Value      | Byte/s       |
| QosMaxTotalQps                     |                  总qps流控阈值                   | userId,BucketName                    | Value      | Count/s      |
| QosMaxTotalRecvFlow                |                总下载带宽流控阈值                | userId,BucketName                    | Value      | Byte/s       |
| QosMaxTotalSendFlow                |                总上传带宽流控阈值                | userId,BucketName                    | Value      | Byte/s       |
| QosMirrorMaxQps                    |               镜像回源qps流控阈值                | userId,BucketName                    | Value      | Count/s      |
| QosMirrorMaxRecvFlow               |               镜像回源下载流控阈值               | userId,BucketName                    | Value      | Byte/s       |
| QosMirrorMaxSendFlow               |               镜像回源上传流控阈值               | userId,BucketName                    | Value      | Byte/s       |
| QosPutObjectMaxQps                 |             PutObject请求qps流控阈值             | userId,BucketName                    | Value      | Count/s      |
| QosPutObjectMaxRecvFlow            |            PutObject请求下载流控阈值             | userId,BucketName                    | Value      | Byte/s       |
| QosPutObjectMaxSendFlow            |            PutObject请求上传流控阈值             | userId,BucketName                    | Value      | Byte/s       |
| RedirectCount                      |                  重定向请求总数                  | userId,BucketName                    | Value      | Count        |
| RedirectRate                       |                  重定向请求占比                  | userId,BucketName                    | Value      | %            |
| RequestValidRate                   |                    有效请求率                    | userId,BucketName                    | Value      | %            |
| ResourceNotFoundErrorCount         |           客户端资源不存在错误请求总数           | userId,BucketName                    | Value      | Count        |
| ResourceNotFoundErrorRate          |           客户端资源不存在错误请求占比           | userId,BucketName                    | Value      | %            |
| ServerErrorCount                   |                服务端错误请求总数                | userId,BucketName                    | Value      | Count        |
| ServerErrorRate                    |                服务端错误请求占比                | userId,BucketName                    | Value      | %            |
| SuccessCount                       |                   成功请求总数                   | userId,BucketName                    | Value      | Count        |
| SuccessRate                        |                   成功请求占比                   | userId,BucketName                    | Value      | %            |
| SyncRecv                           |                跨区域复制流入流量                | userId,BucketName                    | Value      | bytes        |
| SyncSend                           |                跨区域复制流出流量                | userId,BucketName                    | Value      | bytes        |
| TotalRecvBandwidthUsageRate        |                 总上传带宽使用率                 | userId,BucketName                    | Value      | %            |
| TotalRequestCount                  |                     总请求数                     | userId,BucketName                    | Value      | Count        |
| TotalSendBandwidthUsageRate        |                 总下载带宽使用率                 | userId,BucketName                    | Value      | %            |
| UploadPartCopyCount                |             UploadPartCopy成功请求数             | userId,BucketName                    | Value      | Count        |
| UploadPartCopyE2eLatency           |          UploadPartCopy请求平均E2E延时           | userId,BucketName                    | Value      | Milliseconds |
| UploadPartCopyServerLatency        |         UploadPartCopy请求平均服务器延时         | userId,BucketName                    | Value      | Milliseconds |
| UploadPartCount                    |               UploadPart成功请求数               | userId,BucketName                    | Value      | Count        |
| UploadPartE2eLatency               |            UploadPart请求平均E2E延时             | userId,BucketName                    | Value      | Milliseconds |
| UploadPartServerLatency            |           UploadPart请求平均服务器延时           | userId,BucketName                    | Value      | Milliseconds |
| UserAuthorizationErrorCount        |          用户层级客户端授权错误请求总数          | userId                               | Value      | Count        |
| UserAuthorizationErrorRate         |          用户层级客户端授权错误请求占比          | userId                               | Value      | %            |
| UserAvailability                   |                  用户层级可用性                  | userId                               | Value      | %            |
| UserCdnRecv                        |               用户层级cdn流入流量                | userId                               | Value      | bytes        |
| UserCdnSend                        |               用户层级cdn流出流量                | userId                               | Value      | bytes        |
| UserClientOtherErrorCount          |          用户层级客户端其他错误请求总数          | userId                               | Value      | Count        |
| UserClientOtherErrorRate           |              客户端超时错误请求占比              | userId                               | Value      | %            |
| UserClientTimeoutErrorCount        |          用户层级客户端超时错误请求总数          | userId                               | Value      | Count        |
| UserClientTimeoutErrorRate         |          用户层级客户端超时错误请求占比          | userId                               | Value      | %            |
| UserInternetRecv                   |               用户层级公网流入流量               | userId                               | Value      | bytes        |
| UserInternetSend                   |               用户层级公网流出流量               | userId                               | Value      | bytes        |
| UserIntranetRecv                   |               用户层级内网流入流量               | userId                               | Value      | bytes        |
| UserIntranetSend                   |               用户层级内网流出流量               | userId                               | Value      | bytes        |
| UserNetworkErrorCount              |             用户层级网络错误请求总数             | userId                               | Value      | Count        |
| UserNetworkErrorRate               |             用户层级网络错误请求占比             | userId                               | Value      | %            |
| UserRedirectCount                  |              用户层级重定向请求总数              | userId                               | Value      | Count        |
| UserRedirectRate                   |              用户层级重定向请求占比              | userId                               | Value      | %            |
| UserRequestValidRate               |                用户层级有效请求率                | userId                               | Value      | %            |
| UserResourceNotFoundErrorCount     |       用户层级客户端资源不存在错误请求总数       | userId                               | Value      | Count        |
| UserResourceNotFoundErrorRate      |       用户层级客户端资源不存在错误请求占比       | userId                               | Value      | %            |
| UserServerErrorCount | 用户层级服务端错误请求总数 | userId | Value | Count |
| UserServerErrorRate | 用户层级服务端错误请求占比 | userId | Value | % |
| UserSuccessCount | 用户层级成功请求总数 | userId | Value | Count |
| UserSuccessRate | 用户层级成功请求占比 | userId | Value | % |
| UserSyncRecv | 用户层级跨区域复制流入流量 | userId | Value | bytes |
| UserSyncSend | 用户层级跨区域复制流出流量 | userId | Value | bytes |
| UserTotalRequestCount | 用户层级总请求数 | userId | Value | Count |
| UserValidRequestCount | 用户层级有效请求数 | userId | Value | Count |
| ValidRequestCount | 有效请求数 | userId,BucketName | Value | Count |

## 对象 {#object}

采集到的阿里云 OSS 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```
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

## 
