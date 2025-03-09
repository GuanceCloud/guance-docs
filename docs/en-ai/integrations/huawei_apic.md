---
title: 'Huawei Cloud API'
tags: 
  - Huawei Cloud
summary: 'Use the "Guance Cloud Sync" series script packages from the script market to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/huawei_apic'
dashboard:

  - desc: 'HUAWEI APIC Exclusive Plan Gateway Monitoring View'
    path: 'dashboard/zh/huawei_api'

monitor:
  - desc: 'Huawei Cloud APIC Monitor'
    path: 'monitor/zh/huawei_api'

---

<!-- markdownlint-disable MD025 -->
# Huawei Cloud API
<!-- markdownlint-enable -->

Use the "Guance Cloud Sync" series script packages from the script market to synchronize cloud monitoring and cloud asset data to Guance

## Configuration {#config}

### Install Func

We recommend enabling the Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed, please proceed with script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize Huawei Cloud API monitoring data, we install the corresponding collection script: "Guance Integration (Huawei Cloud - **APIG** Collection)" (ID: `guance_huaweicloud_apig`)

Click [Install], then enter the corresponding parameters: Huawei Cloud AK, Huawei Cloud account name.

Click [Deploy Startup Script], and the system will automatically create a `Startup` script set and configure the corresponding startup script.

After the script is installed, find the script "Guance Integration (Huawei Cloud - **APIG** Collection)" under "Development" in Func, expand and modify this script. Find `collector_configs`, replace the region after `regions` with your actual region, and change `region_projects` under `monitor_configs` to the actual region and Project ID. Click Save and Publish.

Additionally, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click [Execute] to run it immediately without waiting for the scheduled time. After a while, you can view the execution task records and corresponding logs.

By default, we collect some configurations, see the metrics section for details [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-apig/){:target="_blank"}

### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any abnormalities.
2. In the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. In the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Huawei Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration [Huawei Cloud Cloud Monitoring Metrics Details](https://support.huaweicloud.com/usermanual-apig/apig-ug-180427085.html){:target="_blank"}

| Metric ID                                | Metric Name | Metric Meaning                                               | Value Range     | Measurement Object        | Monitoring Period (Raw Metric) |
|--------------------------------------|-------|------------------------------------------------------------|----------|---------------|--------------------|
| `requests`                           | API Call Count | Counts the number of times the API interface is called. | ≥0       | Exclusive Plan API Gateway Instance | 1 minute                |
| `error_4xx`                          | 4xx Error Count | Counts the number of times the API interface returns a 4xx error. | ≥0       | Exclusive Plan API Gateway Instance | 1 minute                |
| `error_5xx`                          | 5xx Error Count | Counts the number of times the API interface returns a 5xx error | ≥0       | Exclusive Plan API Gateway Instance | 1 minute                |
| `throttled_calls`                    | Throttled Call Count | Counts the number of throttled calls to the API. | ≥0       | Exclusive Plan API Gateway Instance | 1 minute                |
| `avg_latency`                        | Average Latency (ms) | Measures the average response delay time of the API interface | ≥0 Unit: ms | Exclusive Plan API Gateway Instance | 1 minute                |
| `max_latency`                        | Maximum Latency (ms) | Measures the maximum response delay time of the API interface | ≥0 Unit: ms | Exclusive Plan API Gateway Instance | 1 minute                |
| `req_count`                          | API Call Count | This metric counts the number of times the API interface is called | ≥0 | Single API | 1 minute                |
| `req_count_2xx`                      | 2xx Call Count | This metric counts the number of times the API interface returns a 2xx status | ≥0 | Single API | 1 minute                |
| `req_count_4xx`                      | 4xx Error Count | This metric counts the number of times the API interface returns a 4xx error | ≥0 | Single API | 1 minute                |
| `req_count_5xx`                      | 5xx Error Count | This metric counts the number of times the API interface returns a 5xx error | ≥0 | Single API | 1 minute                |
| `req_count_error`               | Total Error Count | This metric counts the total number of errors returned by the API interface | ≥0 | Single API | 1 minute                |
| `avg_latency`             | Average Latency (ms) | This metric measures the average response delay time of the API interface | ≥0 Unit: ms | Single API | 1 minute                |
| `max_latency`                 | Maximum Latency (ms) | This metric measures the maximum response delay time of the API interface | ≥0 Unit: ms | Single API | 1 minute                |
| `input_throughput`                 | Input Throughput | This metric measures the request traffic of the API interface | ≥0 Unit: Byte/KB/MB/GB | Single API | 1 minute                |
| `output_throughput`       | Output Throughput | This metric measures the response traffic of the API interface | ≥0 Unit: Byte/KB/MB/GB | Single API | 1 minute                |

## Objects {#object}

The structure of collected Huawei Cloud API object data can be viewed in "Infrastructure - Custom"

``` json
{
  "measurement": "huaweicloud_apig",
  "tags": {
            "account_name":"Huawei",
            "class":"huaweicloud_apig",
            "cloud_provider":"huaweicloud",
            "instance_name":"apig-d0m1",
            "instance_status":"6",
            "loadbalancer_provider":"elb",
            "RegionId":"cn-north-4",
            "spec":"BASIC",
            "status":"Running",
            "type":"apig"
          },
}
```

> *Note: Fields in `tags` may change with subsequent updates.*
>
> Tip 1: The value of `instance_name` is the name, used for unique identification.