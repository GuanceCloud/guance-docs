---
title: 'Aliyun OSS'
tags: 
  - Alibaba Cloud
summary: 'Aliyun OSS metrics display, including request volume, availability, network traffic, request ratio, and more.'
__int_icon: icon/aliyun_oss
dashboard:
  - desc: 'Aliyun OSS Built-in Dashboard'
    path: 'dashboard/zh/aliyun_oss/'
monitor:
  - desc: 'Aliyun OSS Monitor'
    path: 'monitor/zh/aliyun_oss/'
---

<!-- markdownlint-disable MD025 -->

# Aliyun OSS
<!-- markdownlint-enable -->


Aliyun OSS metrics display, including request volume, availability, network traffic, request ratio, and more.


## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of ECS cloud resources, we install the corresponding collection script：「Guance Integration（Aliyun -OSSCollect）」(ID：`guance_aliyun_oss`)

Click 【Install】 and enter the corresponding parameters: Aliyun AK, Aliyun account name.。

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-oss/){:target="_blank"}

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

Configure Aliyun OSS monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Aliyun Monitor Metrics Details](https://help.aliyun.com/document_detail/31879.html?){:target="_blank"}

| Metric Id                          |                   Metric Name                    | Dimensions                           | Statistics | Unit         |
| ---- | :----: | ---- | ---- | ---- |
| AppendObjectCount                  |              Successful AppendObject requests count              | userId,BucketName                    | Value      | Count        |
| AuthorizationErrorCount            |              Total number of client authorization errors              | userId,BucketName                    | Value      | Count        |
| AuthorizationErrorRate             |              Percentage of client authorization errors in total requests              | userId,BucketName                    | Value      | %            |
| Availability                       |                      Availability                      | userId,BucketName                    | Value      | %            |
| CdnRecv                            |                   CDN inbound traffic                    | userId,BucketName                    | Value      | bytes        |
| CdnSend                            |                   CDN outbound traffic                    | userId,BucketName                    | Value      | bytes        |
| ClientOtherErrorCount              |              Total number of other client errors              | userId,BucketName                    | Value      | Count        |
| ClientOtherErrorRate               |              Percentage of other client errors in total requests              | userId,BucketName                    | Value      | %            |
| ClientTimeoutErrorRate             |              Percentage of client timeout errors in total requests              | userId,BucketName                    | Value      | %            |
| CopyObjectCount                    |               Successful CopyObject requests count               | userId,BucketName                    | Value      | Count        |
| GetObjectCount                     |               Successful GetObject requests count                | userId,BucketName                    | Value      | Frequency    |
| GetObjectE2eLatency                |             Average End-to-End (E2E) latency of GetObject requests             | userId,BucketName                    | Value      | Milliseconds |
| GetObjectServerLatency             |           Average server latency of GetObject requests            | userId,BucketName                    | Value      | Milliseconds |
| HeadObjectCount                    |               Successful HeadObject requests count               | userId,BucketName                    | Value      | Count        |
| InternetRecv                       |                   Public inbound traffic                   | userId,BucketName                    | Value      | bytes        |
| InternetRecvBandwidth              |                   Public inbound bandwidth                   | userId,BucketName                    | Value      | bps          |
| InternetSend                       |                   Public outbound traffic                   | userId,BucketName                    | Value      | bytes        |
| InternetSendBandwidth              |                   Public outbound bandwidth                   | userId,BucketName                    | Value      | bps          |
| IntranetRecv                       |                   Private network inbound traffic                   | userId,BucketName                    | Value      | bytes        |
| IntranetRecvBandwidth              |                   Private network inbound bandwidth                   | userId,BucketName                    | Value      | bps          |
| IntranetSend                       |                   Private network outbound traffic                   | userId,BucketName                    | Value      | bytes        |
| IntranetSendBandwidth              |                   Private network outbound bandwidth                   | userId,BucketName                    | Value      | bps          |
| MaxAppendObjectE2eLatency          |           Maximum End-to-End (E2E) latency of AppendObject requests            | userId,BucketName                    | Value      | Milliseconds |
| MaxAppendObjectServerLatency       |          Maximum server latency of AppendObject requests          | userId,BucketName                    | Value      | Milliseconds |
| MaxCopyObjectE2eLatency            |            Maximum End-to-End (E2E) latency of CopyObject requests             | userId,BucketName                    | Value      | ms           |
| MaxCopyObjectServerLatency         |           Maximum server latency of CopyObject requests           | userId,BucketName                    | Value      | ms           |
| MaxHeadObjectE2eLatency            |            Maximum End-to-End (E2E) latency of HeadObject requests             | userId,BucketName                    | Value      | Milliseconds |
| MaxHeadObjectServerLatency         |           Maximum server latency of HeadObject requests           | userId,BucketName                    | Value      | Milliseconds |
| MaxPostObjectE2eLatency            |            Maximum End-to-End (E2E) latency of PostObject requests             | userId,BucketName                    | Value      | Milliseconds |
| MaxPostObjectServerLatency         |           Maximum server latency of PostObject requests           | userId,BucketName                    | Value      | Milliseconds |
| MaxUploadPartE2eLatency            |            Maximum End-to-End (E2E) latency of UploadPart requests             | userId,BucketName                    | Value      | Milliseconds |
| MaxUploadPartServerLatency         |           Maximum server latency of UploadPart requests           | userId,BucketName                    | Value      | Milliseconds |
| NetworkErrorRate                   |                 Percentage of network error requests in total requests                 | userId,BucketName                    | Value      | %            |
| PostObjectCount                    |               Successful PostObject requests count               | userId,BucketName                    | Value      | Count        |
| RedirectRate                       |                  Percentage of redirect requests in total requests                  | userId,BucketName                    | Value      | %            |
| RequestValidRate                   |                    Request success rate                   | userId,BucketName                    | Value      | %            |
| ResourceNotFoundErrorCount         |           Total number of client errors for non-existent resources           | userId,BucketName                    | Value      | Count        |
| ResourceNotFoundErrorRate          |           Percentage of client errors for non-existent resources in total requests           | userId,BucketName                    | Value      | %            |
| ServerErrorRate                    |                Percentage of server errors in total requests                | userId,BucketName                    | Value      | %            |
| SuccessCount                       |                   Total number of successful requests                   | userId,BucketName                    | Value      | Count        |
| SuccessRate                        |                   Percentage of successful requests in total requests                   | userId,BucketName                    | Value      | %            |
| SyncRecv                           |                Cross-region replication inbound traffic                | userId,BucketName                    | Value      | bytes        |
| SyncSend                           |                Cross-region replication outbound traffic                | userId,BucketName                    | Value      | bytes        |
| TotalRequestCount                  |                     Total number of requests                   | userId,BucketName                    | Value      | Count        |
| UploadPartCopyCount                |             Successful UploadPartCopy requests count             | userId,BucketName                    | Value      | Count        |


## Object {#object}

The collected Aliyun ECS object data structure can see the object data from 「Infrastructure-Custom」

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
    "message"          : "{Instance JSON data}"
  }
}

```
