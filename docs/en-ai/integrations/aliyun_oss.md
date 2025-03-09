---
title: 'Alibaba Cloud OSS'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud OSS metrics display, including request count, availability, network traffic, request ratio, etc.'
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


Alibaba Cloud OSS metrics display, including request count, availability, network traffic, request ratio, etc.


## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize Alibaba Cloud-OSS monitoring data, we install the corresponding collection script:「Guance integration (Alibaba Cloud-OSS collection)」(ID: `guance_aliyun_oss`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy and Start Script】, the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.

We default to collecting some configurations; see the metrics section for details.

[Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-oss/){:target="_blank"}




### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding task has an automatic trigger configuration. You can also check the task records and logs to verify if there are any abnormalities.
2. On the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. On the Guance platform, under 「Metrics」, check if corresponding monitoring data exists.

## Metrics {#metric}
After configuring Alibaba Cloud-OSS, the default metric set is as follows. More metrics can be collected through configuration. [Alibaba Cloud Monitoring Metrics Details](https://help.aliyun.com/document_detail/31879.html?){:target="_blank"}

| Metric Id                          |                   Metric Name                    | Dimensions                           | Statistics | Unit         |
| ---- | :----: | ---- | ---- | ---- |
| AppendObjectCount                  |              Number of successful AppendObject requests              | userId,BucketName                    | Value      | Count        |
| AuthorizationErrorCount            |              Total number of client authorization error requests              | userId,BucketName                    | Value      | Count        |
| AuthorizationErrorRate             |              Percentage of client authorization error requests              | userId,BucketName                    | Value      | %            |
| Availability                       |                      Availability                      | userId,BucketName                    | Value      | %            |
| CdnRecv                            |                   CDN inbound traffic                    | userId,BucketName                    | Value      | bytes        |
| CdnSend                            |                   CDN outbound traffic                    | userId,BucketName                    | Value      | bytes        |
| ClientOtherErrorCount              |              Total number of other client error requests              | userId,BucketName                    | Value      | Count        |
| ClientOtherErrorRate               |              Percentage of other client error requests              | userId,BucketName                    | Value      | %            |
| ClientTimeoutErrorRate             |              Percentage of client timeout error requests              | userId,BucketName                    | Value      | %            |
| CopyObjectCount                    |               Number of successful CopyObject requests               | userId,BucketName                    | Value      | Count        |
| GetObjectCount                     |               Number of successful GetObject requests                | userId,BucketName                    | Value      | Frequency    |
| GetObjectE2eLatency                |             Average E2E latency of GetObject requests             | userId,BucketName                    | Value      | Milliseconds |
| GetObjectServerLatency             |           Average server latency of GetObject requests            | userId,BucketName                    | Value      | Milliseconds |
| HeadObjectCount                    |               Number of successful HeadObject requests               | userId,BucketName                    | Value      | Count        |
| InternetRecv                       |                   Public network inbound traffic                   | userId,BucketName                    | Value      | bytes        |
| InternetRecvBandwidth              |                   Public network inbound bandwidth                   | userId,BucketName                    | Value      | bps          |
| InternetSend                       |                   Public network outbound traffic                   | userId,BucketName                    | Value      | bytes        |
| InternetSendBandwidth              |                   Public network outbound bandwidth                   | userId,BucketName                    | Value      | bps          |
| IntranetRecv                       |                   Private network inbound traffic                   | userId,BucketName                    | Value      | bytes        |
| IntranetRecvBandwidth              |                   Private network inbound bandwidth                   | userId,BucketName                    | Value      | bps          |
| IntranetSend                       |                   Private network outbound traffic                   | userId,BucketName                    | Value      | bytes        |
| IntranetSendBandwidth              |                   Private network outbound bandwidth                   | userId,BucketName                    | Value      | bps          |
| MaxAppendObjectE2eLatency          |           Maximum E2E latency of AppendObject requests            | userId,BucketName                    | Value      | Milliseconds |
| MaxAppendObjectServerLatency       |          Maximum server latency of AppendObject requests          | userId,BucketName                    | Value      | Milliseconds |
| MaxCopyObjectE2eLatency            |            Maximum E2E latency of CopyObject requests             | userId,BucketName                    | Value      | ms           |
| MaxCopyObjectServerLatency         |           Maximum server latency of CopyObject requests           | userId,BucketName                    | Value      | ms           |
| MaxHeadObjectE2eLatency            |            Maximum E2E latency of HeadObject requests             | userId,BucketName                    | Value      | Milliseconds |
| MaxHeadObjectServerLatency         |           Maximum server latency of HeadObject requests           | userId,BucketName                    | Value      | Milliseconds |
| MaxPostObjectE2eLatency            |            Maximum E2E latency of PostObject requests             | userId,BucketName                    | Value      | Milliseconds |
| MaxPostObjectServerLatency         |           Maximum server latency of PostObject requests           | userId,BucketName                    | Value      | Milliseconds |
| MaxUploadPartE2eLatency            |            Maximum E2E latency of UploadPart requests             | userId,BucketName                    | Value      | Milliseconds |
| MaxUploadPartServerLatency         |           Maximum server latency of UploadPart requests           | userId,BucketName                    | Value      | Milliseconds |
| NetworkErrorRate                   |                 Percentage of network error requests                 | userId,BucketName                    | Value      | %            |
| PostObjectCount                    |               Number of successful PostObject requests               | userId,BucketName                    | Value      | Count        |
| RedirectRate                       |                  Percentage of redirect requests                  | userId,BucketName                    | Value      | %            |
| RequestValidRate                   |                    Valid request rate                    | userId,BucketName                    | Value      | %            |
| ResourceNotFoundErrorCount         |           Total number of client resource not found error requests           | userId,BucketName                    | Value      | Count        |
| ResourceNotFoundErrorRate          |           Percentage of client resource not found error requests           | userId,BucketName                    | Value      | %            |
| ServerErrorRate                    |                Percentage of server error requests                | userId,BucketName                    | Value      | %            |
| SuccessCount                       |                   Total number of successful requests                   | userId,BucketName                    | Value      | Count        |
| SuccessRate                        |                   Percentage of successful requests                   | userId,BucketName                    | Value      | %            |
| SyncRecv                           |                Cross-region replication inbound traffic                | userId,BucketName                    | Value      | bytes        |
| SyncSend                           |                Cross-region replication outbound traffic                | userId,BucketName                    | Value      | bytes        |
| TotalRequestCount                  |                     Total number of requests                     | userId,BucketName                    | Value      | Count        |
| UploadPartCopyCount                |             Number of successful UploadPartCopy requests             | userId,BucketName                    | Value      | Count        |


## Objects {#object}

The structure of Alibaba Cloud OSS objects collected can be seen under 「Infrastructure-Custom」.

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
    "message"          : "{instance JSON data}"
  }
}

```