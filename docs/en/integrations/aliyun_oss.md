---
title: 'Alibaba Cloud OSS'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud OSS Metrics Display, including request counts, availability, network traffic, and request ratios.'
__int_icon: icon/aliyun_oss
dashboard:
  - desc: 'Alibaba Cloud OSS Built-in Views'
    path: 'dashboard/en/aliyun_oss/'
monitor:
  - desc: 'Alibaba Cloud OSS Monitors'
    path: 'monitor/en/aliyun_oss/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud OSS
<!-- markdownlint-enable -->


Alibaba Cloud OSS Metrics Display, including request counts, availability, network traffic, and request ratios.


## Configuration {#config}

### Install Func

It is recommended to enable the <<< custom_key.brand_name >>> Integration - Extension - Managed Func: all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data for Alibaba Cloud-OSS, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (Alibaba Cloud-OSS Collection)" (ID: `guance_aliyun_oss`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

We collect some configurations by default; for more details, see the metrics section.

[Customize Cloud Object Metrics Configuration](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-oss/){:target="_blank"}




### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has the automatic trigger configuration, and check the corresponding task records and logs for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, under "Infrastructure / Custom", check if asset information exists.
3. On the <<< custom_key.brand_name >>> platform, under "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud-OSS, the default metric set is as follows. You can collect more metrics through configuration. [Alibaba Cloud Monitoring Metrics Details](https://help.aliyun.com/document_detail/31879.html?){:target="_blank"}

| Metric Id                          |                   Metric Name                    | Dimensions                           | Statistics | Unit         |
| ---- | :----: | ---- | ---- | ---- |
| AppendObjectCount                  |              Successful AppendObject Requests              | userId,BucketName                    | Value      | Count        |
| AuthorizationErrorCount            |              Total Client Authorization Error Requests              | userId,BucketName                    | Value      | Count        |
| AuthorizationErrorRate             |              Percentage of Client Authorization Error Requests              | userId,BucketName                    | Value      | %            |
| Availability                       |                      Availability                      | userId,BucketName                    | Value      | %            |
| CdnRecv                            |                   CDN Inbound Traffic                    | userId,BucketName                    | Value      | bytes        |
| CdnSend                            |                   CDN Outbound Traffic                    | userId,BucketName                    | Value      | bytes        |
| ClientOtherErrorCount              |              Total Other Client Error Requests              | userId,BucketName                    | Value      | Count        |
| ClientOtherErrorRate               |              Percentage of Other Client Error Requests              | userId,BucketName                    | Value      | %            |
| ClientTimeoutErrorRate             |              Percentage of Client Timeout Error Requests              | userId,BucketName                    | Value      | %            |
| CopyObjectCount                    |               Successful CopyObject Requests               | userId,BucketName                    | Value      | Count        |
| GetObjectCount                     |               Successful GetObject Requests                | userId,BucketName                    | Value      | Frequency    |
| GetObjectE2eLatency                |             Average E2E Latency for GetObject Requests             | userId,BucketName                    | Value      | Milliseconds |
| GetObjectServerLatency             |           Average Server Latency for GetObject Requests            | userId,BucketName                    | Value      | Milliseconds |
| HeadObjectCount                    |               Successful HeadObject Requests               | userId,BucketName                    | Value      | Count        |
| InternetRecv                       |                   Public Network Inbound Traffic                   | userId,BucketName                    | Value      | bytes        |
| InternetRecvBandwidth              |                   Public Network Inbound Bandwidth                   | userId,BucketName                    | Value      | bps          |
| InternetSend                       |                   Public Network Outbound Traffic                   | userId,BucketName                    | Value      | bytes        |
| InternetSendBandwidth              |                   Public Network Outbound Bandwidth                   | userId,BucketName                    | Value      | bps          |
| IntranetRecv                       |                   Private Network Inbound Traffic                   | userId,BucketName                    | Value      | bytes        |
| IntranetRecvBandwidth              |                   Private Network Inbound Bandwidth                   | userId,BucketName                    | Value      | bps          |
| IntranetSend                       |                   Private Network Outbound Traffic                   | userId,BucketName                    | Value      | bytes        |
| IntranetSendBandwidth              |                   Private Network Outbound Bandwidth                   | userId,BucketName                    | Value      | bps          |
| MaxAppendObjectE2eLatency          |           Maximum E2E Latency for AppendObject Requests            | userId,BucketName                    | Value      | Milliseconds |
| MaxAppendObjectServerLatency       |          Maximum Server Latency for AppendObject Requests          | userId,BucketName                    | Value      | Milliseconds |
| MaxCopyObjectE2eLatency            |            Maximum E2E Latency for CopyObject Requests             | userId,BucketName                    | Value      | ms           |
| MaxCopyObjectServerLatency         |           Maximum Server Latency for CopyObject Requests           | userId,BucketName                    | Value      | ms           |
| MaxHeadObjectE2eLatency            |            Maximum E2E Latency for HeadObject Requests             | userId,BucketName                    | Value      | Milliseconds |
| MaxHeadObjectServerLatency         |           Maximum Server Latency for HeadObject Requests           | userId,BucketName                    | Value      | Milliseconds |
| MaxPostObjectE2eLatency            |            Maximum E2E Latency for PostObject Requests             | userId,BucketName                    | Value      | Milliseconds |
| MaxPostObjectServerLatency         |           Maximum Server Latency for PostObject Requests           | userId,BucketName                    | Value      | Milliseconds |
| MaxUploadPartE2eLatency            |            Maximum E2E Latency for UploadPart Requests             | userId,BucketName                    | Value      | Milliseconds |
| MaxUploadPartServerLatency         |           Maximum Server Latency for UploadPart Requests           | userId,BucketName                    | Value      | Milliseconds |
| NetworkErrorRate                   |                 Percentage of Network Error Requests                 | userId,BucketName                    | Value      | %            |
| PostObjectCount                    |               Successful PostObject Requests               | userId,BucketName                    | Value      | Count        |
| RedirectRate                       |                  Percentage of Redirect Requests                  | userId,BucketName                    | Value      | %            |
| RequestValidRate                   |                    Valid Request Rate                    | userId,BucketName                    | Value      | %            |
| ResourceNotFoundErrorCount         |           Total Client Resource Not Found Error Requests           | userId,BucketName                    | Value      | Count        |
| ResourceNotFoundErrorRate          |           Percentage of Client Resource Not Found Error Requests           | userId,BucketName                    | Value      | %            |
| ServerErrorRate                    |                Percentage of Server Error Requests                | userId,BucketName                    | Value      | %            |
| SuccessCount                       |                   Total Successful Requests                   | userId,BucketName                    | Value      | Count        |
| SuccessRate                        |                   Percentage of Successful Requests                   | userId,BucketName                    | Value      | %            |
| SyncRecv                           |                Cross-region Replication Inbound Traffic                | userId,BucketName                    | Value      | bytes        |
| SyncSend                           |                Cross-region Replication Outbound Traffic                | userId,BucketName                    | Value      | bytes        |
| TotalRequestCount                  |                     Total Requests                     | userId,BucketName                    | Value      | Count        |
| UploadPartCopyCount                |             Successful UploadPartCopy Requests             | userId,BucketName                    | Value      | Count        |


## Objects {#object}

The collected Alibaba Cloud OSS object data structure can be viewed under "Infrastructure - Custom".

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
    "message"          : "{Instance JSON Data}"
  }
}

```