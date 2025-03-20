---
title: 'Huawei Cloud WAF Web Application Firewall'
tags: 
  - Huawei Cloud
summary: 'Collect Huawei Cloud WAF Metrics data'
__int_icon: 'icon/huawei_waf'
dashboard:
  - desc: 'Huawei Cloud WAF built-in views'
    path: 'dashboard/en/huawei_waf/'

monitor:
  - desc: 'Huawei Cloud WAF monitors'
    path: 'monitor/en/huawei_waf/'
---

Collect Huawei Cloud WAF Metrics data

## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> Integration - Extensions - Managed Func: all prerequisites are automatically installed, please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/)

> It is recommended to deploy the GSE version.

### Install Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize Huawei Cloud WAF monitoring data, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (Huawei Cloud-WAF Collection)" (ID: `guance_huaweicloud_waf`)

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK, Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set, and automatically configure the corresponding startup script.

After the script is installed, find the script "<<< custom_key.brand_name >>> Integration (Huawei Cloud-WAF Collection)" under "Development" in Func, and edit the content of `region_projects` in `collector_configs` and `monitor_configs`, changing the region and Project ID to the actual region and Project ID, then click Save and Publish.

In addition, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration, and you can also check the corresponding task records and logs to see if there are any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, under "Infrastructure / Custom", check if asset information exists.
3. On the <<< custom_key.brand_name >>> platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}

Collect Huawei Cloud WAF Metrics, more Metrics can be collected through configuration [Huawei Cloud WAF Metrics Details](https://support.huaweicloud.com/usermanual-waf/waf_01_0372.html){:target="_blank"}

| **Metric ID**            |          **Metric Name**   | **Metric Meaning** | **Value Range**      | **Measurement Object** | **Monitoring Period (Raw Metric)** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| `requests`            |  Requests   | This metric counts the total number of requests returned by WAF in the last 5 minutes. Unit: times  | ≥0 times  | Protected Domain | 5 minutes             |
| `waf_http_2xx`            |  WAF Response Code (2XX)   | This metric counts the number of 2XX status codes returned by WAF in the last 5 minutes. Unit: times  | ≥0 times  | Protected Domain | 5 minutes             |
| `waf_http_3xx`            |  WAF Response Code (3XX)   | This metric counts the number of 3XX status codes returned by WAF in the last 5 minutes. Unit: times  | ≥0 times  | Protected Domain | 5 minutes             |
| `waf_http_4xx`            |  WAF Response Code (4XX)   | This metric counts the number of 4XX status codes returned by WAF in the last 5 minutes. Unit: times  | ≥0 times  | Protected Domain | 5 minutes             |
| `waf_http_5xx`            |  WAF Response Code (5XX)   | This metric counts the number of 5XX status codes returned by WAF in the last 5 minutes. Unit: times  | ≥0 times  | Protected Domain | 5 minutes             |
| `waf_fused_counts`            |  WAF Circuit Breaker Count   | This metric counts the number of requests protected by WAF circuit breaker in the last 5 minutes. Unit: times  | ≥0 times  | Protected Domain | 5 minutes             |
| `inbound_traffic`            |  Total Inbound Traffic   | This metric counts the total inbound bandwidth size in the last 5 minutes. Unit: Mbit  | ≥0 Mbit | Protected Domain | 5 minutes             |
| `outbound_traffic`            |  Total Outbound Traffic   | This metric counts the total outbound bandwidth size in the last 5 minutes. Unit: Mbit  | ≥0 Mbit | Protected Domain | 5 minutes             |
| `waf_process_time_0`            |  WAF Processing Latency - Interval [0-10ms)   | This metric counts the total number of WAF processing latencies within the interval [0-10ms) in the last 5 minutes. Unit: times  | ≥0 times  | Protected Domain | 5 minutes             |
| `waf_process_time_10`            |  WAF Processing Latency - Interval [10-20ms)   | This metric counts the total number of WAF processing latencies within the interval [10-20ms) in the last 5 minutes. Unit: times  | ≥0 times  | Protected Domain | 5 minutes             |
| `waf_process_time_20`            |  WAF Processing Latency - Interval [20-50ms)   | This metric counts the total number of WAF processing latencies within the interval [20-50ms) in the last 5 minutes. Unit: times  | ≥0 times  | Protected Domain | 5 minutes             |
| `waf_process_time_50`            | WAF Processing Latency - Interval [50-100ms)   | This metric counts the total number of WAF processing latencies within the interval [50-100ms) in the last 5 minutes. Unit: times  | ≥0 times  | Protected Domain | 5 minutes             |
| `waf_process_time_100`            |  WAF Processing Latency - Interval [100-1000ms)   | This metric counts the total number of WAF processing latencies within the interval [100-1000ms) in the last 5 minutes. Unit: times  | ≥0 times  | Protected Domain | 5 minutes             |
| `waf_process_time_1000`            |  WAF Processing Latency - Interval [1000+ms)   | This metric counts the total number of WAF processing latencies within the interval [1000+ms) in the last 5 minutes. Unit: times  | ≥0 times  | Protected Domain | 5 minutes             |
| `qps_peak`            |  QPS Peak   | This metric counts the QPS peak of the protected domain in the last 5 minutes. Unit: times  | ≥0 times  | Protected Domain | 5 minutes             |
| `qps_mean`            |  QPS Average   | This metric counts the QPS average of the protected domain in the last 5 minutes. Unit: times  | ≥0 times  | Protected Domain | 5 minutes             |
| `waf_http_0`            |  No Returned WAF Status Codes   | This metric counts the number of no responses from WAF status codes in the last 5 minutes. Unit: times  | ≥0 times  | Protected Domain | 5 minutes             |
| `upstream_code_2xx`            |  Business Response Code (2XX)   | This metric counts the number of 2XX series status response codes returned by the business in the last 5 minutes. Unit: times  | ≥0 times  | Protected Domain | 5 minutes             |
| `upstream_code_3xx`            |  Business Response Code (3XX)   | This metric counts the number of 3XX series status response codes returned by the business in the last 5 minutes. Unit: times  | ≥0 times  | Protected Domain | 5 minutes             |
| `upstream_code_4xx`            |  Business Response Code (4XX)   | This metric counts the number of 4XX series status response codes returned by the business in the last 5 minutes. Unit: times  | ≥0 times  | Protected Domain | 5 minutes             |
| `upstream_code_5xx`            |  Business Response Code (5XX)   | This metric counts the number of 5XX series status response codes returned by the business in the last 5 minutes. Unit: times  | ≥0 times  | Protected Domain | 5 minutes             |
| `upstream_code_0`            |  No Returned WAF Status Codes   | This metric counts the number of no responses from WAF status codes in the last 5 minutes. Unit: times  | ≥0 times  | Protected Domain | 5 minutes             |
| `inbound_traffic_peak`            |  Peak Inbound Traffic   | This metric counts the peak inbound traffic of the protected domain in the last 5 minutes. Unit: Mbit/s  | ≥0 Mbit/s  | Protected Domain | 5 minutes             |
| `inbound_traffic_mean`            |  Average Inbound Traffic   | This metric counts the average inbound traffic of the protected domain in the last 5 minutes. Unit: Mbit/s  | ≥0 Mbit/s  | Protected Domain | 5 minutes             |
| `outbound_traffic_peak`            |  Peak Outbound Traffic   | This metric counts the peak outbound traffic of the protected domain in the last 5 minutes. Unit: Mbit/s  | ≥0 Mbit/s  | Protected Domain | 5 minutes             |
| `outbound_traffic_mean`            |  Average Outbound Traffic   | This metric counts the average outbound traffic of the protected domain in the last 5 minutes. Unit: Mbit/s  | ≥0 Mbit/s  | Protected Domain | 5 minutes             |
| `attacks`            |  Total Attack Counts   | This metric counts the total number of attack requests for the protected domain in the last 5 minutes. Unit: times  | ≥0 times  | Protected Domain | 5 minutes             |
| `crawlers`            |  Crawler Attack Counts   | This metric counts the total number of crawler attack requests for the protected domain in the last 5 minutes. Unit: times  |  ≥0 times  | Protected Domain | 5 minutes             |
| `base_protection_counts`            |  Web Basic Protection Counts   | This metric counts the number of attacks protected by web basic protection rules in the last 5 minutes. Unit: times  | ≥0 times  | Protected Domain | 5 minutes             |
| `precise_protection_counts`            |  Precise Protection Counts   | This metric counts the number of attacks protected by precise protection rules in the last 5 minutes. Unit: times  | ≥0 times  | Protected Domain | 5 minutes             |
| `cc_protection_counts`            |  CC Protection Counts   | This metric counts the number of attacks protected by CC protection rules in the last 5 minutes. Unit: times  | ≥0 times | Protected Domain | 5 minutes             |

## Objects {#object}

The structure of the collected Huawei Cloud WAF object data can be viewed under "Infrastructure - Custom".

```json
{
  "measurement": "huaweicloud_waf",
  "tags": {
    "RegionId"          : "cn-south-1",
    "hostname"          : "xxxxxxxxx.cn",
    "id"                : "9c877f3c83594d10af5aec52bcc1c707",
    "paid_type"         : "prePaid",
    "project_id"        : "756ada1aa17e4049b2a16ea41912e52d"
  },
  "fields": {
    "flag"              : "[JSON Data]",
    "proxy"             : "False",
    "timestamp"         : "1731653371361",
    "protect_status"    : "1",
    "access_status"     : "1",
    "exclusive_ip"      : "False",
    "web_tag"           : "waf"
  }
}
```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Hint: The `id` value is the ID of the protected domain, used as a unique identifier.