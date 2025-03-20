---
title: 'Huawei Cloud API'
tags: 
  - Huawei Cloud
summary: 'Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/huawei_apic'
dashboard:

  - desc: 'HUAWEI APIC Exclusive Plan Gateway Monitoring View'
    path: 'dashboard/en/huawei_api'

monitor:
  - desc: 'Huawei Cloud APIC Monitor'
    path: 'monitor/en/huawei_api'

---


<!-- markdownlint-disable MD025 -->
# Huawei Cloud API
<!-- markdownlint-enable -->

Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with the script installation

If you deploy Func by yourself, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize Huawei Cloud API monitoring data, we install the corresponding collection script: "Guance Integration (Huawei Cloud - **APIG** Collection)" (ID: `guance_huaweicloud_apig`)

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK, Huawei Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After the script installation is complete, find the script "Guance Integration (Huawei Cloud - **APIG** Collection)" under "Development" in Func, expand and modify this script. Find `collector_configs` and replace the region after `regions` with your actual region. Then find `monitor_configs` below and change `region_projects` to the actual region and Project ID. Click Save and Publish afterward.

In addition, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute it once without waiting for the scheduled time. After a while, you can check the execution task records and corresponding logs.

We default collect some configurations, details are in the metrics section [Customize Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-huaweicloud-apig/){:target="_blank"}

### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration, and you can check the corresponding task records and logs to check for any abnormalities.
2. On the Guance platform, under "Infrastructure / Custom", check if there is any asset information.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Huawei Cloud - Cloud Monitoring, the default metric sets are as follows. More metrics can be collected through configuration [Huawei Cloud Cloud Monitoring Metric Details](https://support.huaweicloud.com/usermanual-apig/apig-ug-180427085.html){:target="_blank"}

| Metric ID                                 | Metric Name  | Metric Meaning                                                 | Value Range     | Measured Object        | Monitoring Period (Raw Metric) |
|--------------------------------------|-------| -------------------------------------------------------- |----------| --------------- | -------------------- |
| `requests`                           | Interface Call Count | Statistics measure the number of times the api interface is called.| ≥0       | Exclusive Edition API Gateway Instance              | 1 minute                |
| `error_4xx`                          | 4xx Error Count | Statistics measure the number of times the api interface returns 4xx errors.   | ≥0       | Exclusive Edition API Gateway Instance              | 1 minute                |
| `error_5xx`                          | 5xx Error Count | Statistics measure the number of times the api interface returns 5xx errors | ≥0       | Exclusive Edition API Gateway Instance              | 1 minute                |
| `throttled_calls`                    | Throttled Call Count | Statistics measure the number of throttled calls to the api    | ≥0       | Exclusive Edition API Gateway Instance     | 1 minute                |
| `avg_latency`                        | Average Latency Milliseconds | Statistics measure the average response delay time of the api interface    | ≥0 Unit: milliseconds| Exclusive Edition API Gateway Instance      | 1 minute                |
| `max_latency`                        | Maximum Latency Milliseconds | Statistics measure the maximum response delay time of the api interface|  ≥0 Unit: milliseconds  | Exclusive Edition API Gateway Instance      | 1 minute                |
| `req_count`                          | Interface Call Count | This metric is used to count the number of times the api interface is called                |≥0| Single API     | 1 minute                |
| `req_count_2xx`                      | 2xx Call Count | This metric is used to count the number of times the api interface returns 2xx          | ≥ 0  | Single API       | 1 minute                |
| `req_count_4xx`                      | 4xx Error Count | This metric is used to count the number of times the api interface returns 4xx errors          | ≥ 0 | Single API      | 1 minute                |
| `req_count_5xx`                      | 5xx Error Count | This metric is used to count the number of times the api interface returns 5xx errors       | ≥ 0  | Single API      | 1 minute                |
| `req_count_error`               | Error Count | This metric is used to count the total number of errors returned by the api interface | ≥ 0| Single API  | 1 minute                |
| `avg_latency`             | Average Latency Milliseconds | This metric is used to count the average response delay time of the api interface | ≥0 Unit: milliseconds | Single API      | 1 minute                |
| `max_latency`                 | Maximum Latency Milliseconds | This metric is used to count the maximum response delay time of the api interface | ≥0 Unit: milliseconds | Single API      | 1 minute                |
| `input_throughput`                 | Input Throughput | This metric is used to count the request traffic of the api interface | ≥0. Unit: Byte/KB/MB/GB| Single API | 1 minute                |
| `output_throughput`       | Output Throughput | This metric is used to count the return traffic of the api interface | ≥0. Unit: Byte/KB/MB/GB | Single API          | 1 minute                |

## Objects {#object}

The structure of the collected Huawei Cloud API object data can be seen in "Infrastructure - Custom"

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


> *Note: The fields in `tags` may change with subsequent updates.*
>
> Note 1: The value of `instance_name` is the name, used as a unique identifier.
