---
title: 'HUAWEI API Gateway'
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the APIervation cloud.'
__int_icon: 'icon/huawei_API'
dashboard:

  - desc: 'HUAWEI CLOUD APIC Dedicated Gateway Dashboard'
    path: 'dashboard/zh/huawei_API'

monitor:
  - desc: 'HUAWEI CLOUD APIC Monitor'
    path: 'monitor/zh/huawei_API'

---


<!-- markdownlint-disable MD025 -->
# HUAWEI CLOUD API Gateway
<!-- markdownlint-enable -->

Use the「Guance Synchronization」series script package in the script market to monitor the cloud ,The data of the cloud asset is synchronized to the **APIervation** cloud.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation
,
If you deploy Func yourself,Refer to  [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare HUAWEI CLOUD AK that meets the requirements in advance（For simplicity's sake,You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of  HUAWEI CLOUD API resources, we install the corresponding collection script：「Guance Integration（HUAWEI CLOUD-APIG Collect）」(ID：`guance_huaweicloud_apig`)

Click 【Install】 and enter the corresponding parameters: HUAWEI CLOUD AK, HUAWEI CLOUD account name.

tap【Deploy startup Script】,The system automatically creates `Startup` script sets,And automatically configure the corresponding startup script.

After the script is installed,Find the script in「Development」in Func「HUAWEI CLOUD-APIG Collect」,Expand to modify this script,find`collector_configs`-`regions`,Change the region to your actual region,Then find `region_projects` under `monitor_configs`,Change to the actual locale and Project ID.Click Save Publish again

In addition, the corresponding automatic trigger configuration is displayed in「Management / Crontab Config」.tap【Run】,It can be executed immediately once, without waiting for a periodic time.After a while, you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-apig/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the **APIervation** cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the **APIervation** cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure HUAWEI CLOUD - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [HUAWEI CLOUD Monitor Metrics Details](https://support.huaweicloud.com/usermanual-apig/apig-ug-180427085.html){:target="_blank"}

| Metric ID| Metric Name            | Metric Meaning                                                | Value range     | Measurement object       | Monitoring cycle (original metric) |
|-------------------------------------|---------------------------| -------------------------------------------------------- |----------| --------------- | -------------------- |
| `requests`                          | Number of interface calls | Count the number of times the API interface has been called.| ≥0       | Exclusive version API gateway instance              | 1 minute                |
| `error_4xx`                         | 4xx abnormal times        | Count the number of 4xx errors returned by the measurement API interface.   | ≥0       | Exclusive version API gateway instance              | 1 minute                |
| `error_5xx`                         | 5xx abnormal times        | Count the number of times the measurement API interface returns 5xx errors | ≥0       | Exclusive version API gateway instance              | 1 minute                |
| `throttled_calls`                   | Number of calls controlled by flow                  | Count the number of calls to the measurement API that have been flow-controlled    | ≥0       | Exclusive version API gateway instance     | 1 minute                |
| `avg_latency`                       | Average latency milliseconds                   | Statistical measurement of average response delay time of API interfaces    | ≥0 Unit: milliseconds| Exclusive version API gateway instance      | 1 minute                |
| `max_latency`                       | Maximum Delay Milliseconds                   |Statistical measurement of the maximum response delay time of the API interface|  ≥0 Unit: milliseconds  | Exclusive version API gateway instance      | 1 minute                |
| `req_count`                         | Number of interface calls                    | This metric is used to count and measure the number of API interface calls              |≥0|Single API     | 1 minute                |
| `req_count_2xx`                     | 2xx calls                   | This metric is used to measure the number of times API interface calls 2xx         | ≥ 0  | Single API       | 1 minute                |
| `req_count_4xx`                     | 4xx abnormal times                   | This metric is used to count the number of 4xx errors returned by the measurement API interface          | ≥ 0 | Single API      | 1 minute                |
| `req_count_5xx`                     | 5xx abnormal times                   | This metric is used to count the number of times the API interface returns 5xx errors      | ≥ 0  | Single API      | 1 minute                |
| `req_count_error`              | Number of anomalies                      | This metric is used to measure the total number of errors in the API interface | ≥ 0| Single API  | 1 minute                |
| `avg_latency`            | Average latency milliseconds                   | This metric is used to measure the average response delay time of API interfaces| ≥0 Unit: milliseconds | Single API      | 1 minute                |
| `max_latency`                | Maximum Delay Milliseconds                   | This metric is used to measure the maximum response delay time of API interfaces | ≥0 Unit: milliseconds | Single API      | 1 minute                |
| `input_throughput`                | Inflow flow                      | This metric is used for statistical measurement of API interface request traffic | ≥0.Unit：Byte/KB/MB/GB| Single API | 1 minute                |
| `output_throughput`      | Outflow flow                      | This metric is used for statistical measurement of API interface return traffic | ≥0.Unit：Byte/KB/MB/GB | Single API          | 1 minute                |


## Object {#object}

The collected HUAWEI CLOUD API object data structure can see the object data from 「Infrastructure-Custom」

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

> *notice：`tags`The fields in this section may change with subsequent updates*
>
> Tips 1：`instance_name` value is the name for unique identification
