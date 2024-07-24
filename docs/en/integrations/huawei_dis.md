---
title: 'HUAWEI DIS'
tags: 
  - Huawei Cloud
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.'
__int_icon: 'icon/huawei_dis'
dashboard:

  - desc: 'HUAWEI CLOUD DIS Built-in Dashboard'
    path: 'dashboard/zh/huawei_dis'

monitor:
  - desc: 'HUAWEI CLOUD DIS Monitor'
    path: 'monitor/zh/huawei_dis'

---


<!-- markdownlint-disable MD025 -->
# HUAWEI CLOUD DIS
<!-- markdownlint-enable -->

Use the「Guance Synchronization」series script package in the script market to monitor the cloud ,The data of the cloud asset is synchronized to the observation cloud.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to  [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation script

> Tip：Please prepare HUAWEI CLOUD AK that meets the requirements in advance（For simplicity's sake, You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of  HUAWEI CLOUD OBS cloud resources, we install the corresponding collection script：「Guance Integration（HUAWEI CLOUD-DIS Collect）」(ID：`guance_huaweicloud_dis`)

Click 【Install】 and enter the corresponding parameters: HUAWEI CLOUD AK, HUAWEI CLOUD account name.

tap【Deploy startup Script】, The system automatically creates `Startup` script sets, And automatically configure the corresponding startup script.

After the script is installed, Find the script in「Development」in Func「Guance Integration（HUAWEI CLOUD-DIS Collect）」, Expand to modify this script, find `collector_configs`and`monitor_configs`Edit the content in`region_projects`, Change the locale and Project ID to the actual locale and Project ID, Click Save Publish again.

In addition, the corresponding automatic trigger configuration is displayed in「Management / Crontab Config」. tap【Run】, It can be executed immediately once, without waiting for a periodic time. After a while, you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-ces/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure HUAWEI CLOUD - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [HUAWEI CLOUD Monitor Metrics Details](https://support.huaweicloud.com/intl/en-us/usermanual-dis/dis_01_0131.html){:target="_blank"}


| Metric Name                                | Description                                                     | Value Range      | Monitored Object | Monitoring Period (Raw Data) |
| ------------------------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| Total Input Traffic                  | The amount of data uploaded through a stream during a specific period. Unit: byte/s | ≥ 0         | Stream                        | 1 minute                     |
| Total Output Traffic              | The amount of data downloaded through a stream during a specific period.  Unit: byte/s | ≥ 0         | Stream                        | 1 minute                     |
| Total Input Records                 | The number of records uploaded through a stream during a specific period. Unit: count/s | ≥ 0         | Stream                        | 1 minute                     |
| Total Output Records                 | The number of records downloaded through a stream during a specific period. Unit: count/s | ≥ 0         | Stream                        | 1 minute                     |
| Successful Upload Requests        | The number of successful requests for uploading data through a stream during a specific period. Unit: count/s | ≥ 0         | Stream                        | 1 minute                     |
| Successful Download Requests        | The number of successful requests for downloading data through a stream during a specific period.  Unit: count/s | ≥ 0         | Stream                        | 1 minute                     |
| Average Processing Time of Upload Requests     | Average upload request delay of a stream during a specific period. Unit: ms | 0 to 50 ms  | Stream                        | 1 minute                     |
| Average Processing Time of Download Requests    | Average download request delay of a stream during a specific period. Unit: ms | 0 to 50 ms  | Stream                        | 1 minute                     |
| Throttled Upload Requests | The number of rejected upload requests due to flow control. Unit: count/s | 0 to 1      | Stream                        | 1 minute                     |
| Throttled Download Requests | The number of rejected download requests due to flow control. Unit: count/s | 0 to 1      | Stream                        | 1 minute            |

## Object {#object}

The collected HUAWEI CLOUD DIS object data structure can see the object data from 「Infrastructure-Custom」


``` json
{
  "measurement": "huaweicloud_dis",
  "tags": {
    "RegionId"    : "cn-north-4",
    "data_type"   : "BLOB",
    "name"        : "dis-YoME",
    "project_id"  : "c631f04625xxxxexxxxxx253c62d48585",
    "status"      : "RUNNING",
    "stream_name" : "dis-YoME",
    "stream_type" : "COMMON"
  },
  "fields": {
    "partition_count"    : 1,
    "retention_period"   : 24,
    "auto_scale_enabled" : false,
    "create_time"        : 1691484876645,
    "message"            : "{Instance JSON data}"
  }
}
```

Some parameters are described as follows：

| Parameter                  | Type                   |   Description                  |
| :------------------- | :--------------------- | :---------------------  |
| `create_time`        | integer               |  Time when the stream is created. The value is a 13-bit timestamp. |
| `retention_period`   | integer               | Period for storing data in units of hours. |
| `status`  | str      | Current status of the stream: CREATING: creating, RUNNING: running, TERMINATING: deleting, TERMINATED: deleted. Enumeration values: CREATING, RUNNING, TERMINATING, FROZEN |
| `stream_type`  | str               | Stream type: COMMON: a common stream with a bandwidth of 1 MB/s, ADVANCED: an advanced stream with a bandwidth of 5 MB/s. Enumeration values: COMMON, ADVANCED |
| `data_type`  | str               | Source data type: BLOB: a collection of binary data stored as a single entity in a database management system, JSON: an open-standard file format that uses human-readable text to transmit data objects consisting of attribute-value pairs and array data types, CSV: a simple text format for storing tabular data in a plain text file. Commas are used as delimiters, Default value: BLOB. Enumeration values: BLOB, JSON, CSV |
| `auto_scale_enabled`  | bool               | Whether to enable auto scaling: true: Auto scaling is enabled, false: Auto scaling is disabled, By default, this function is disabled. Default: false |

> *notice：`tags`、`fields`The fields in this section may change with subsequent updates*
>
> Tips 1：`tags.name`The value is the instance ID for unique identification
>
> Tips 2：The following fields are JSON serialized strings
>
> - fields.message
