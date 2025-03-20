---
title: 'Volcengine TOS Object Storage'
tags: 
  - Volcengine
summary: 'Collect Volcengine TOS Metrics data'
__int_icon: 'icon/volcengine_tos'
dashboard:

  - desc: 'Volcengine TOS Built-in Views'
    path: 'dashboard/en/volcengine_tos'
monitor:

  - desc: 'Volcengine TOS Monitors'
    path: 'monitor/en/volcengine_tos'
---

Collect Volcengine TOS Metrics data

## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> Integration - Extensions - DataFlux Func (Automata): all prerequisites will be automatically installed, please continue with the script installation.

If you deploy Func by yourself, refer to [Self-deploy Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a Volcengine AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize TOS resource monitoring data, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (Volcengine-TOS Collection)" (ID: `guance_volcengine_tos`)

After clicking 【Install】, input the corresponding parameters: Volcengine AK, Volcengine account name, Regions.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute it without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and at the same time, you can check the corresponding task records and logs to see if there are any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, in "Infrastructure - Resource Catalog", check if asset information exists.
3. On the <<< custom_key.brand_name >>> platform, in "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}

Configure Volcengine TOS monitoring metrics, and collect more metrics through configuration [Volcengine TOS Extreme Speed Metrics Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_TOS){:target="_blank"}

### Volcengine TOS Monitoring Metrics

|`MetricName` |`Subnamespace` | Metric Name | MetricUnit | Dimension|
| ----------- |---------------| :----: |:--------:  |:-------: |
| `AccountTotalStorage` | `account_overview` | Total user storage billing capacity | GiB | - |
| `AccountStandardStorage` | `account_overview` | User standard storage billing capacity | GiB | - |
| `AccountIAStorage` | `account_overview` | User infrequent access storage billing capacity | GiB | - |
| `AccountITStdStorage` | `account_overview` | User intelligent tiering high-frequency access layer capacity | GiB | - |
| `AccountITAchiveFrStorage` | `account_overview` | User intelligent tiering archive flash-back access layer capacity | GiB | - |
| `AccountStandardMultiAZStorage` | `account_overview` | User standard storage (multi-AZ) billing capacity | GiB | - |
| `TotalUploadBandwidthV2` | `bandwidth` | Total inbound bandwidth | MB/s | ResourceID |
| `InternetUploadBandwidthV2` | `bandwidth` | Internal network inbound bandwidth | MB/s | ResourceID |
| `TotalDownloadBandwidthV2` | `bandwidth` | Public network total outbound bandwidth | MB/s | ResourceID |
| `InternetDownloadBandwidthV2` | `bandwidth` | Public network outbound bandwidth | MB/s | ResourceID |
| `GetRequestFirstByteP95Latency` | `bucket_latency` | GET request first byte P95 latency | ms | ResourceID |
| `PutRequestFirstByteP95Latency` | `bucket_latency` | PUT request first byte P95 latency | ms | ResourceID |
| `BucketTotalStorage` | `bucket_overview` | Total bucket object capacity | GiB | ResourceID |
| `BucketITStdStorage` | `bucket_overview` | Bucket intelligent tiering high-frequency access layer capacity | GiB | ResourceID |
| `BucketArchiveStorage` | `bucket_overview` | Bucket archive storage billing capacity | GiB | ResourceID |
| `ErrorRatio` | `bucket_status_code` | Error rate | GiB | ResourceID |
| `GetObjectQps` | `qps` | GetObject request QPS | GiB | ResourceID |
| `PutObjectQps` | `qps` | PutObject request QPS | GiB | ResourceID |
| `ListObjectsQps` | `qps` | ListObjects request QPS | GiB | ResourceID |
| `UploadPartQps` | `qps` | UploadPart request QPS | GiB | ResourceID |
| `DeleteObjectQps` | `qps` | DeleteObject request QPS | GiB | ResourceID |
| `PostObjectQps` | `qps` | PostObject request QPS | GiB | ResourceID |
| `DeleteObjectsQps` | `qps` | DeleteObjects request QPS | GiB | ResourceID |
| `TotalStorage` | `storage` | Total storage capacity | GiB | ResourceID |
| `StandardStorage` | `storage` | Standard storage capacity | GiB | ResourceID |
| `InfrequentAccessStorage` | `storage` | Infrequent access storage capacity | GiB | ResourceID |