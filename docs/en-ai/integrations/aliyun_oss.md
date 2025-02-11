---
title: 'Alibaba Cloud OSS'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud OSS Metrics display, including request counts, availability, network traffic, request ratios, etc.'
__int_icon: icon/aliyun_oss
dashboard:
  - desc: 'Alibaba Cloud OSS built-in views'
    path: 'dashboard/en/aliyun_oss/'
monitor:
  - desc: 'Alibaba Cloud OSS monitors'
    path: 'monitor/en/aliyun_oss/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud OSS
<!-- markdownlint-enable -->


Alibaba Cloud OSS Metrics display, including request counts, availability, network traffic, request ratios, etc.


## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize monitoring data from Alibaba Cloud-OSS, we install the corresponding collection script: 「Guance Integration (Alibaba Cloud-OSS Collection)」(ID: `guance_aliyun_oss`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy and Start Script】and the system will automatically create a `Startup` script set and configure the startup scripts accordingly.

Once enabled, you can view the corresponding automatic trigger configurations under 「Management / Automatic Trigger Configurations」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.

We have collected some configurations by default; see the metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-oss/){:target="_blank"}




### Verification

1. Confirm in 「Management / Automatic Trigger Configurations」whether the corresponding tasks have the automatic trigger configurations, and check the task records and logs for any anomalies.
2. In the Guance platform, check under 「Infrastructure / Custom」if asset information exists.
3. In the Guance platform, check under 「Metrics」if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Alibaba Cloud-OSS, the default metric set is as follows. You can collect more metrics through configuration [Alibaba Cloud Monitoring Metric Details](https://help.aliyun.com/document_detail/31879.html?){:target="_blank"}

| Metric Id                          |                   Metric Name                    | Dimensions                           | Statistics | Unit         |
| ---- | :----: | ---- | ---- | ---- |
| AppendObjectCount                  |              Successful AppendObject Requests              | userId,BucketName                    | Value      | Count        |
| AuthorizationErrorCount            |              Total Client Authorization Error Requests              | userId,BucketName                    | Value      | Count        |
| AuthorizationErrorRate             |              Ratio of Client Authorization Error Requests              | userId,BucketName                    | Value      | %            |
| Availability                       |                      Availability                      | userId,BucketName                    | Value      | %            |
| CdnRecv                            |                   CDN Inbound Traffic                    | userId,BucketName                    | Value      | bytes        |
| CdnSend                            |                   CDN Outbound Traffic                    | userId,BucketName                    | Value      | bytes        |
| ClientOtherErrorCount              |              Total Other Client Error Requests              | userId,BucketName                    | Value      | Count        |
| ClientOtherErrorRate               |              Ratio of Other Client Error Requests              | userId,BucketName                    | Value      | %            |
| ClientTimeoutErrorRate             |              Ratio of Client Timeout Error Requests              | userId,BucketName                    | Value      | %            |
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
| NetworkErrorRate                   |                 Ratio of Network Error Requests                 | userId,BucketName                    | Value      | %            |
| PostObjectCount                    |               Successful PostObject Requests               | userId,BucketName                    | Value      | Count        |
| RedirectRate                       |                  Ratio of Redirect Requests                  | userId,BucketName                    | Value      | %            |
| RequestValidRate                   |                    Valid Request Rate                    | userId,BucketName                    | Value      | %            |
| ResourceNotFoundErrorCount         |           Total Client Resource Not Found Error Requests           | userId,BucketName                    | Value      | Count        |
| ResourceNotFoundErrorRate          |           Ratio of Client Resource Not Found Error Requests           | userId,BucketName                    | Value      | %            |
| ServerErrorRate                    |                Ratio of Server Error Requests                | userId,BucketName                    | Value      | %            |
| SuccessCount                       |                   Total Successful Requests                   | userId,BucketName                    | Value      | Count        |
| SuccessRate                        |                   Successful Request Rate                   | userId,BucketName                    | Value      | %            |
| SyncRecv                           |                Cross-region Replication Inbound Traffic                | userId,BucketName                    | Value      | bytes        |
| SyncSend                           |                Cross-region Replication Outbound Traffic                | userId,BucketName                    | Value      | bytes        |
| TotalRequestCount                  |                     Total Requests                     | userId,BucketName                    | Value      | Count        |
| UploadPartCopyCount                |             Successful UploadPartCopy Requests             | userId,BucketName                    | Value      | Count        |


## Objects {#object}

The structure of collected Alibaba Cloud OSS object data can be viewed under 「Infrastructure - Custom」

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