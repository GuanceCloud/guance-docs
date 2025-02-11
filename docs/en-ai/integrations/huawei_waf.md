---
title: 'Huawei Cloud WAF Web Application Firewall'
tags: 
  - Huawei Cloud
summary: 'Collect Huawei Cloud WAF metrics data'
__int_icon: 'icon/huawei_waf'
dashboard:
  - desc: 'Built-in views for Huawei Cloud WAF'
    path: 'dashboard/en/huawei_waf/'

monitor:
  - desc: 'Huawei Cloud WAF monitors'
    path: 'monitor/en/huawei_waf/'
---

Collect Huawei Cloud WAF metrics data

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/)

> We recommend deploying the GSE version

### Install Script

> Note: Prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize Huawei Cloud WAF monitoring data, we install the corresponding collection script: "Guance Integration (Huawei Cloud-WAF Collection)" (ID: `guance_huaweicloud_waf`).

Click [Install], then input the required parameters: Huawei Cloud AK, Huawei Cloud account name.

Click [Deploy Startup Script], and the system will automatically create a `Startup` script set and configure the startup scripts accordingly.

After the script is installed, find the script "Guance Integration (Huawei Cloud-WAF Collection)" under "Development" in Func, expand it, and modify this script. Edit the contents of `collector_configs` and `monitor_configs` by changing the region and Project ID to the actual ones, then click Save and Publish.

Additionally, view the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click [Execute] to run immediately without waiting for the scheduled time. Wait a moment to check the execution task records and corresponding logs.

### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, go to "Infrastructure / Custom" to see if asset information exists.
3. On the Guance platform, go to "Metrics" to check if the corresponding monitoring data exists.

## Metrics {#metric}

Collecting Huawei Cloud WAF metrics can be done by configuring more metrics [Huawei Cloud WAF Metrics Details](https://support.huaweicloud.com/usermanual-waf/waf_01_0372.html){:target="_blank"}

| **Metric ID**            |          **Metric Name**   | **Metric Meaning** | **Value Range**      | **Measurement Object** | **Monitoring Period (Raw Metric)** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| `requests`            |  Request Volume   | This metric counts the total number of requests returned by WAF within the last 5 minutes. Unit: times  | ≥0 times  | Protection Domain | 5 minutes             |
| `waf_http_2xx`            |  WAF Response Code (2XX)   | This metric counts the number of 2XX status codes returned by WAF within the last 5 minutes. Unit: times  | ≥0 times  | Protection Domain | 5 minutes             |
| `waf_http_3xx`            |  WAF Response Code (3XX)   | This metric counts the number of 3XX status codes returned by WAF within the last 5 minutes. Unit: times  | ≥0 times  | Protection Domain | 5 minutes             |
| `waf_http_4xx`            |  WAF Response Code (4XX)   | This metric counts the number of 4XX status codes returned by WAF within the last 5 minutes. Unit: times  | ≥0 times  | Protection Domain | 5 minutes             |
| `waf_http_5xx`            |  WAF Response Code (5XX)   | This metric counts the number of 5XX status codes returned by WAF within the last 5 minutes. Unit: times  | ≥0 times  | Protection Domain | 5 minutes             |
| `waf_fused_counts`            |  WAF Circuit Breaker Count   | This metric counts the number of requests protected by WAF circuit breaker within the last 5 minutes. Unit: times  | ≥0 times  | Protection Domain | 5 minutes             |
| `inbound_traffic`            |  Total Inbound Traffic   | This metric counts the total inbound bandwidth size within the last 5 minutes. Unit: Mbit  | ≥0 Mbit | Protection Domain | 5 minutes             |
| `outbound_traffic`            |  Total Outbound Traffic   | This metric counts the total outbound bandwidth size within the last 5 minutes. Unit: Mbit  | ≥0 Mbit | Protection Domain | 5 minutes             |
| `waf_process_time_0`            |  WAF Processing Latency - Interval [0-10ms)   | This metric counts the total number of WAF processing latencies within the interval [0-10ms) over the last 5 minutes. Unit: times  | ≥0 times  | Protection Domain | 5 minutes             |
| `waf_process_time_10`            |  WAF Processing Latency - Interval [10-20ms)   | This metric counts the total number of WAF processing latencies within the interval [10-20ms) over the last 5 minutes. Unit: times  | ≥0 times  | Protection Domain | 5 minutes             |
| `waf_process_time_20`            |  WAF Processing Latency - Interval [20-50ms)   | This metric counts the total number of WAF processing latencies within the interval [20-50ms) over the last 5 minutes. Unit: times  | ≥0 times  | Protection Domain | 5 minutes             |
| `waf_process_time_50`            |  WAF Processing Latency - Interval [50-100ms)   | This metric counts the total number of WAF processing latencies within the interval [50-100ms) over the last 5 minutes. Unit: times  | ≥0 times  | Protection Domain | 5 minutes             |
| `waf_process_time_100`            |  WAF Processing Latency - Interval [100-1000ms)   | This metric counts the total number of WAF processing latencies within the interval [100-1000ms) over the last 5 minutes. Unit: times  | ≥0 times  | Protection Domain | 5 minutes             |
| `waf_process_time_1000`            |  WAF Processing Latency - Interval [1000+ms)   | This metric counts the total number of WAF processing latencies within the interval [1000+ms) over the last 5 minutes. Unit: times  | ≥0 times  | Protection Domain | 5 minutes             |
| `qps_peak`            |  QPS Peak   | This metric counts the peak QPS of the protection domain over the last 5 minutes. Unit: times  | ≥0 times  | Protection Domain | 5 minutes             |
| `qps_mean`            |  QPS Mean   | This metric counts the average QPS of the protection domain over the last 5 minutes. Unit: times  | ≥0 times  | Protection Domain | 5 minutes             |
| `waf_http_0`            |  No Returned WAF Status Code   | This metric counts the number of state response codes not returned by WAF within the last 5 minutes. Unit: times  | ≥0 times  | Protection Domain | 5 minutes             |
| `upstream_code_2xx`            |  Business Response Code (2XX)   | This metric counts the number of 2XX series status response codes returned by the business within the last 5 minutes. Unit: times  | ≥0 times  | Protection Domain | 5 minutes             |
| `upstream_code_3xx`            |  Business Response Code (3XX)   | This metric counts the number of 3XX series status response codes returned by the business within the last 5 minutes. Unit: times  | ≥0 times  | Protection Domain | 5 minutes             |
| `upstream_code_4xx`            |  Business Response Code (4XX)   | This metric counts the number of 4XX series status response codes returned by the business within the last 5 minutes. Unit: times  | ≥0 times  | Protection Domain | 5 minutes             |
| `upstream_code_5xx`            |  Business Response Code (5XX)   | This metric counts the number of 5XX series status response codes returned by the business within the last 5 minutes. Unit: times  | ≥0 times  | Protection Domain | 5 minutes             |
| `upstream_code_0`            |  No Returned WAF Status Code   | This metric counts the number of state response codes not returned by WAF within the last 5 minutes. Unit: times  | ≥0 times  | Protection Domain | 5 minutes             |
| `inbound_traffic_peak`            |  Peak Inbound Traffic   | This metric counts the peak inbound traffic of the protection domain over the last 5 minutes. Unit: Mbit/s  | ≥0 Mbit/s  | Protection Domain | 5 minutes             |
| `inbound_traffic_mean`            |  Average Inbound Traffic   | This metric counts the average inbound traffic of the protection domain over the last 5 minutes. Unit: Mbit/s  | ≥0 Mbit/s  | Protection Domain | 5 minutes             |
| `outbound_traffic_peak`            |  Peak Outbound Traffic   | This metric counts the peak outbound traffic of the protection domain over the last 5 minutes. Unit: Mbit/s  | ≥0 Mbit/s  | Protection Domain | 5 minutes             |
| `outbound_traffic_mean`            |  Average Outbound Traffic   | This metric counts the average outbound traffic of the protection domain over the last 5 minutes. Unit: Mbit/s  | ≥0 Mbit/s  | Protection Domain | 5 minutes             |
| `attacks`            |  Total Attack Attempts   | This metric counts the total number of attack requests within the last 5 minutes. Unit: times  | ≥0 times  | Protection Domain | 5 minutes             |
| `crawlers`            |  Crawler Attack Attempts   | This metric counts the total number of crawler attack requests within the last 5 minutes. Unit: times  |  ≥0 times  | Protection Domain | 5 minutes             |
| `base_protection_counts`            |  Basic Web Protection Attempts   | This metric counts the number of attacks defended by basic web protection rules within the last 5 minutes. Unit: times  | ≥0 times  | Protection Domain | 5 minutes             |
| `precise_protection_counts`            |  Precise Protection Attempts   | This metric counts the number of attacks defended by precise protection rules within the last 5 minutes. Unit: times  | ≥0 times  | Protection Domain | 5 minutes             |
| `cc_protection_counts`            |  CC Protection Attempts   | This metric counts the number of attacks defended by CC protection rules within the last 5 minutes. Unit: times  | ≥0 times | Protection Domain | 5 minutes             |

## Objects {#object}

The collected Huawei Cloud WAF object data structure can be viewed in "Infrastructure - Custom".

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
> Tip: The `id` value is the protection domain ID, used as a unique identifier.