---
title: 'VolcEngine TOS Object Storage'
tags: 
  - VolcEngine
summary: 'Collect VolcEngine TOS Metrics data'
__int_icon: 'icon/volcengine_tos'
dashboard:

  - desc: 'VolcEngine TOS Built-in Views'
    path: 'dashboard/en/volcengine_tos'
monitor:

  - desc: 'VolcEngine TOS Monitor'
    path: 'monitor/en/volcengine_tos'
---

Collect VolcEngine TOS Metrics data

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - Extensions - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a qualified VolcEngine AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize TOS resource monitoring data, we install the corresponding collection script: 「Guance Integration (VolcEngine-TOS Collection)」(ID: `guance_volcengine_tos`)

After clicking 【Install】, enter the corresponding parameters: VolcEngine AK, VolcEngine account name, and Regions.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm that the corresponding task has an automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, under 「Infrastructure - Resource Catalog」, check if asset information exists.
3. On the Guance platform, under 「Metrics」, check if the corresponding monitoring data exists.

## Metrics {#metric}

To configure VolcEngine TOS monitoring metrics, you can collect more metrics by configuring them [VolcEngine TOS Extreme Speed Metrics Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_TOS){:target="_blank"}

### VolcEngine TOS Monitoring Metrics

|`MetricName` |`Subnamespace` | Metric Name | MetricUnit | Dimension|
| ----------- |---------------| :----: |:--------:  |:-------: |
| `AccountTotalStorage` | `account_overview` | Total User Storage Billing Capacity | Gibibytes | - |
| `AccountStandardStorage` | `account_overview` | Standard User Storage Billing Capacity | Gibibytes | - |
| `AccountIAStorage` | `account_overview` | Infrequent Access User Storage Billing Capacity | Gibibytes | - |
| `AccountITStdStorage` | `account_overview` | Intelligent Tiering High-Frequency Access Layer Capacity | Gibibytes | - |
| `AccountITAchiveFrStorage` | `account_overview` | Intelligent Tiering Archive Flashback Access Layer Capacity | Gibibytes | - |
| `AccountStandardMultiAZStorage` | `account_overview` | Multi-AZ Standard User Storage Billing Capacity | Gibibytes | - |
| `TotalUploadBandwidthV2` | `bandwidth` | Total Inbound Bandwidth | Megabytes/Second | ResourceID |
| `InternetUploadBandwidthV2` | `bandwidth` | Internal Network Inbound Bandwidth | Megabytes/Second | ResourceID |
| `TotalDownloadBandwidthV2` | `bandwidth` | Public Network Outbound Total Bandwidth | Megabytes/Second | ResourceID |
| `InternetDownloadBandwidthV2` | `bandwidth` | Public Network Outbound Bandwidth | Megabits/Second | ResourceID |
| `GetRequestFirstByteP95Latency` | `bucket_latency` | P95 Latency of First Byte for GET Requests | Millisecond | ResourceID |
| `PutRequestFirstByteP95Latency` | `bucket_latency` | P95 Latency of First Byte for PUT Requests | Millisecond | ResourceID |
| `BucketTotalStorage` | `bucket_overview` | Total Bucket Object Capacity | Gibibytes | ResourceID |
| `BucketITStdStorage` | `bucket_overview` | Intelligent Tiering High-Frequency Access Layer Capacity for Buckets | Gibibytes | ResourceID |
| `BucketArchiveStorage` | `bucket_overview` | Archive Storage Billing Capacity for Buckets | Gibibytes | ResourceID |
| `ErrorRatio` | `bucket_status_code` | Error Rate | Percentage | ResourceID |
| `GetObjectQps` | `qps` | GetObject Request QPS | Requests/Second | ResourceID |
| `PutObjectQps` | `qps` | PutObject Request QPS | Requests/Second | ResourceID |
| `ListObjectsQps` | `qps` | ListObjects Request QPS | Requests/Second | ResourceID |
| `UploadPartQps` | `qps` | UploadPart Request QPS | Requests/Second | ResourceID |
| `DeleteObjectQps` | `qps` | DeleteObject Request QPS | Requests/Second | ResourceID |
| `PostObjectQps` | `qps` | PostObject Request QPS | Requests/Second | ResourceID |
| `DeleteObjectsQps` | `qps` | DeleteObjects Request QPS | Requests/Second | ResourceID |
| `TotalStorage` | `storage` | Total Storage Capacity | Gibibytes | ResourceID |
| `StandardStorage` | `storage` | Standard Storage Capacity | Gibibytes | ResourceID |
| `InfrequentAccessStorage` | `storage` | Infrequent Access Storage Capacity | Gibibytes | ResourceID |
| `ErrorRatio` | `bucket_status_code` | Error Rate | Percentage | ResourceID |

Note: The unit for `ErrorRatio` was incorrectly listed as `Gibibytes`. It should be `Percentage`.