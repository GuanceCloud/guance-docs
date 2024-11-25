---
title: 'Huawei Cloud WAF Web Application Firewall'
tags: 
  - Huawei Cloud
summary: 'Collect Huawei Cloud WAF metric data'
__int_icon: 'icon/huawei_waf'
dashboard:
  - desc: 'Huawei Cloud WAF Built in View'
    path: 'dashboard/en/huawei_waf/'

monitor:
  - desc: 'Huawei Cloud WAF Monitor'
    path: 'monitor/en/huawei_waf/'
---

Collect Huawei Cloud WAF metric data.

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically,Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> Recommend deploying GSE (Game Server Engine) edition translation.

### Installation script

> Tip:Please prepare a Huawei Cloud AK that meets the requirements in advance (For simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of Huawei Cloud WAF, we install the corresponding collection script: 「Guance Cloud Integration (Huawei Cloud WAF Collection)」 (ID: `guance_huaweicloud_waf`)

Click 【Install】 and enter the corresponding parameters: HUAWEI CLOUD AK, HUAWEI CLOUD account name.

Tap【Deploy startup Script】, the system automatically creates `Startup` script sets, and automatically configure the corresponding startup script.

After installing the script, find the script 「Guance Cloud Integration (Huawei Cloud WAF Collection)」 in the 「Development」 section of Func. Expand and modify the script, find collector_configs and monitor_configs, and edit the content in region_projects below. Change the region and Project ID to the actual region and Project ID, and then click save and publish.

In addition, in「Management / Automatic Trigger Configuration」 you can see the corresponding automatic trigger configuration. Click 【Execute】 to run it immediately, without waiting for the scheduled time. After a short moment, you can check the execution task records and corresponding logs.

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the guance cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the guance cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

Collect Huawei Cloud WAF metrics to collect more metrics through configuration [Huawei Cloud WAF Metric Details](https://support.huaweicloud.com/usermanual-waf/waf_01_0372.html){:target="_blank"}

| **MetricID**            |          **MetricName**   | **MetricMeaning** | **ValueRange**      | **Measurement object** | **Monitoring Period (Raw Metric)** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| `requests`            |  Request quantity   | This metric is used to count the total number of requests returned by WAF in the past 5 minutes for the measured object. Unit: times  | ≥0 times  | Protecting Domain Names | 5 minutes             |
| `waf_http_2xx`            |  WAF return code (2XX)   | This metric is used to count the number of 2XX status codes returned by WAF in the past 5 minutes for the measured object. Unit: times  | ≥0 times  | Protecting Domain Names | 5 minutes             |
| `waf_http_3xx`            |  WAF return code (3XX)   | This metric is used to count the number of 3XX status codes returned by WAF in the past 5 minutes for the measured object. Unit: times  | ≥0 times  | Protecting Domain Names | 5 minutes             |
| `waf_http_4xx`            |  WAF return code (4XX)   | This metric is used to count the number of 4XX status codes returned by WAF in the past 5 minutes for the measured object. Unit: times  | ≥0 times  | Protecting Domain Names | 5 minutes             |
| `waf_http_5xx`            |  WAF return code (5XX)   | This metric is used to count the number of 5XX status codes returned by WAF in the past 5 minutes for the measured object. Unit: times  | ≥0 times  | Protecting Domain Names | 5 minutes             |
| `waf_fused_counts`            |  WAF circuit breaker amount   | This metric is used to count the number of requests for WAF meltdown protection of the measured object in the past 5 minutes. Unit: times  | ≥0 times  | Protecting Domain Names | 5 minutes             |
| `inbound_traffic`            |  Total network traffic   | This metric is used to calculate the total bandwidth of the measured object in the past 5 minutes. Unit: Mbit  | ≥0 Mbit | Protecting Domain Names | 5 minutes             |
| `outbound_traffic`            |  Total outbound traffic   | This metric is used to calculate the total bandwidth output of the measured object in the past 5 minutes. Unit: Mbit  | ≥0 Mbit | Protecting Domain Names | 5 minutes             |
| `waf_process_time_0`            |  WAF processing latency - interval [0-10ms)   | This metric is used to calculate the total number of WAF processing delays within the interval of [0-10ms) in the past 5 minutes for the measured object. Unit: times  | ≥0 times  | Protecting Domain Names | 5 minutes             |
| `waf_process_time_10`            |  WAF processing latency - interval [10-20ms)   | This metric is used to calculate the total number of WAF processing delays within the interval of [10-20ms) in the past 5 minutes for the measured object. Unit: times  | ≥0 times  | Protecting Domain Names | 5 minutes             |
| `waf_process_time_20`            |  WAF processing latency - interval [20-50ms)   | This metric is used to calculate the total number of WAF processing delays within the interval of [20-50ms) in the past 5 minutes for the measured object. Unit: times  | ≥0 times  | Protecting Domain Names | 5 minutes             |
| `waf_process_time_50`            | WAF processing latency - interval [50-100ms)   | This metric is used to calculate the total number of WAF processing delays within the interval of [50-100ms) in the past 5 minutes for the measured object. Unit: times  | ≥0 times  | Protecting Domain Names | 5 minutes             |
| `waf_process_time_100`            |  WAF processing latency - interval [100-1000ms)   | This metric is used to calculate the total number of WAF processing delays within the interval of [100-1000ms in the past 5 minutes for the measured object. Unit: times  | ≥0 times  | Protecting Domain Names | 5 minutes             |
| `waf_process_time_1000`            |  WAF processing latency - interval [1000+ms)   | This metric is used to calculate the total number of WAF processing delays within the interval of [1000+ms) in the past 5 minutes for the measured object. Unit: times  | ≥0 times  | Protecting Domain Names | 5 minutes             |
| `qps_peak`            |  QPS peak value   | This metric is used to calculate the QPS peak of Protecting Domain Names in the past 5 minutes. Unit: times  | ≥0 times  | Protecting Domain Names | 5 minutes             |
| `qps_mean`            |  QPS mean   | This metric is used to calculate the QPS mean of Protecting Domain Names in the past 5 minutes. Unit: times  | ≥0 times  | Protecting Domain Names | 5 minutes             |
| `waf_http_0`            |  No WAF status code returned   | This metric is used to count the number of WAF status response codes that have not been returned by the measurement object in the past 5 minutes. Unit: times  | ≥0 times  | Protecting Domain Names | 5 minutes             |
| `upstream_code_2xx`            |  Business return code (2XX)   | This metric is used to count the number of 2XX series status response codes returned by the measurement object in the past 5 minutes. Unit: times  | ≥0 times  | Protecting Domain Names | 5 minutes             |
| `upstream_code_3xx`            |  Business return code (3XX)   | This metric is used to count the number of 3XX series status response codes returned by the measurement object in the past 5 minutes. Unit: times  | ≥0 times  | Protecting Domain Names | 5 minutes             |
| `upstream_code_4xx`            |  Business return code (4XX)   | This metric is used to count the number of 4XX series status response codes returned by the measurement object in the past 5 minutes. Unit: times  | ≥0 times  |  Protecting Domain Names | 5 minutes            |
| `upstream_code_5xx`            |  Business return code (5XX)   | This metric is used to count the number of 5XX series status response codes returned by the measurement object in the past 5 minutes. Unit: times | ≥0 times  | Protecting Domain Names | 5 minutes             |
| `upstream_code_0`              |  No WAF status code returned   | This metric is used to count the number of WAF status response codes that have not been returned by the measurement object in the past 5 minutes. Unit: times  | ≥0 times  | Protecting Domain Names | 5 minutes             |
| `inbound_traffic_peak`            |  Peak of network traffic  | This metric is used to calculate the peak network traffic of Protecting Domain Names in the past 5 minutes. Unit: Mbit/s  | ≥0 Mbit/s  | Protecting Domain Names | 5 minutes             |
| `inbound_traffic_mean`            |  Mean of network traffic  | This metric is used to calculate the average network traffic of Protecting Domain Names in the past 5 minutes. Unit: Mbit/s  | ≥0 Mbit/s  | Protecting Domain Names | 5 minutes             |
| `outbound_traffic_peak`            |  Peak of outbound traffic  | This metric is used to calculate the peak outbound traffic of Protecting Domain Names in the past 5 minutes. Unit: Mbit/s  | ≥0 Mbit/s  | Protecting Domain Names | 5 minutes             |
| `outbound_traffic_mean`            |  Mean of outbound traffic  | This metric is used to calculate the average outbound traffic of Protecting Domain Names in the past 5 minutes. Unit: Mbit/s | ≥0 Mbit/s  | Protecting Domain Names | 5 minutes             |
| `attacks`            |  Total number of attacks  | This metric is used to count the total number of Protection Domain Names attack requests in the past 5 minutes. Unit: times  | ≥0 times  | Protecting Domain Names | 5 minutes             |
| `crawlers`            |  Number of crawler attacks  |This metric is used to count the total number of requests for Protecting Domain Names crawler attacks in the past 5 minutes. Unit: times  |  ≥0 times  | Protecting Domain Names | 5 minutes             |
| `base_protection_counts`            |  Number of basic web protection attempts  | This metric is used to count the number of attacks protected by web basic protection rules in the past 5 minutes. Unit: times  | ≥0 times  | Protecting Domain Names | 5 minutes             |
| `precise_protection_counts`            |  Precision protection frequency  | This metric is used to count the number of attacks protected by precision protection rules in the past 5 minutes. Unit: times | ≥0 times  | Protecting Domain Names | 5 minutes             |
| `cc_protection_counts`            |  CC protection frequency  | This metric is used to count the number of attacks protected by CC protection rules in the past 5 minutes. Unit: times | ≥0 times | Protecting Domain Names | 5 minutes             |

## Object {#object}

The collected Huawei Cloud WAF object data structure can be viewed in the 「Infrastructure - Customization」 section for object data.

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
    "flag"              : "[JSON data]",
    "proxy"             : "False",
    "timestamp"         : "1731653371361",
    "protect_status"    : "1",
    "access_status"     : "1",
    "exclusive_ip"      : "False",
    "web_tag"           : "waf"
  }
}
```

> *notice：`tags`、`fields`The fields in this section may change with subsequent updates*
>
> Tip : The `id` value is the protected domain ID, which serves as a unique identifier
