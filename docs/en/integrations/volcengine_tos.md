---
title: 'Volcengine TOS Object Storage'
tags:
  - Volcengine
summary: 'Collect Volcengine TOS metric data'
__int_icon: 'icon/volcengine_tos'
dashboard:

  - desc: 'Volcengine TOS Built in View'
    path: 'dashboard/en/volcengine_tos'

monitor:
  - desc: 'Volcengine TOS Monitor'
    path: 'monitor/en/volcengine_tos'
---

Collect Volcengine TOS metric data

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip：Please prepare `Volcenine`  AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of TOS cloud resources, we install the corresponding collection script：「Guance Integration（Volcengine TOS Collect）」(ID：`guance_volcengine_tos`)

Click【Install】and enter the corresponding parameters: Volcenine AK, Volcenine account name, Volcenine regions.

Tap 【Deploy startup Script】, The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click "Run"，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs.

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task. In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure - Resource Catalog」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

Configure the Volcengine TOS monitoring metric to collect more metrics through configuration [Volcengine TOS metric Details](https://console.volcengine.com/cloud_monitor/docs?namespace=TOS){:target="_blank"}

|`MetricName` |`Subnamespace` | MetricName |MetricUnit | Dimension|
| ----------- |---------------| :----: |:--------: |:-------: |
| `AccountTotalStorage` | `account_overview` | Total billing capacity for user storage | Gibibytes | - |
| `AccountStandardStorage` | `account_overview` | User standard storage billing capacity | Gibibytes | - |
| `AccountIAStorage` | `account_overview` | User low-frequency storage billing capacity | Gibibytes | - |
| `AccountITStdStorage` | `account_overview` | User intelligent layered high-frequency access layer capacity | Gibibytes | - |
| `AccountITAchiveFrStorage` | `account_overview` | User intelligent layered archiving flashback access layer capacity | Gibibytes | - |
| `AccountStandardMultiAZStorage` | `account_overview` | User standard storage (multi AZ) billing capacity | Gibibytes | - |
| `TotalUploadBandwidthV2` | `bandwidth` | Total incoming bandwidth | Megabytes/Second | ResourceID |
| `InternetUploadBandwidthV2` | `bandwidth` | Internal network bandwidth inflow | Megabytes/Second | ResourceID |
| `TotalDownloadBandwidthV2` | `bandwidth` | Total bandwidth outflow from the public network | Megabytes/Second | ResourceID |
| `InternetDownloadBandwidthV2` | `bandwidth` | Public network outflow bandwidth | Megabits/Second | ResourceID |
| `GetRequestFirstByteP95Latency` | `bucket_latency` | GET request first byte P95 latency | Millisecond | ResourceID |
| `PutRequestFirstByteP95Latency` | `bucket_latency` | PUT request first byte P95 latency | Millisecond | ResourceID |
| `BucketTotalStorage` | `bucket_overview` | Total capacity of bucket objects | Gibibytes | ResourceID |
| `BucketITStdStorage` | `bucket_overview` | Bucket intelligent layered high-frequency access layer capacity | Gibibytes | ResourceID |
| `BucketArchiveStorage` | `bucket_overview` | Bucket archive storage billing capacity | Gibibytes | ResourceID |
| `ErrorRatio` | `bucket_status_code` | error rate | Gibibytes | ResourceID |
| `GetObjectQps` | `qps` | GetObject requests QPS | Gibibytes | ResourceID |
| `PutObjectQps` | `qps` | PutObject requests QPS | Gibibytes | ResourceID |
| `ListObjectsQps` | `qps` | ListObjects requests QPS | Gibibytes | ResourceID |
| `UploadPartQps` | `qps` |UploadPart requests QPS | Gibibytes | ResourceID |
| `DeleteObjectQps` | `qps` | DeleteObject requests QPS | Gibibytes | ResourceID |
| `PostObjectQps` | `qps` | PostObject requests QPS | Gibibytes | ResourceID |
| `DeleteObjectsQps` | `qps` | DeleteObjects requests QPS | Gibibytes | ResourceID |
| `TotalStorage` | `storage` | Total storage capacity | Gibibytes | ResourceID |
| `StandardStorage` | `storage` | Standard storage capacity | Gibibytes | ResourceID |
| `InfrequentAccessStorage` | `storage` | Low frequency storage capacity | Gibibytes | ResourceID |
