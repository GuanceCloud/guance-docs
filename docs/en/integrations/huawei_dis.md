---
title: 'Huawei Cloud DIS'
tags: 
  - Huawei Cloud
summary: 'Use the "Guance Cloud Sync" series script packages from the script market to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/huawei_dis'
dashboard:

  - desc: 'Huawei Cloud DIS Built-in Views'
    path: 'dashboard/en/huawei_dis'

monitor:
  - desc: 'Huawei Cloud DIS Monitor'
    path: 'monitor/en/huawei_dis'

---


<!-- markdownlint-disable MD025 -->
# Huawei Cloud DIS
<!-- markdownlint-enable -->

Use the "Guance Cloud Sync" series script packages from the script market to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable the Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize Huawei Cloud DIS monitoring data, we install the corresponding collection script: "Guance Integration (Huawei Cloud-DIS Collection)" (ID: `guance_huaweicloud_dis`)

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy Start Script】, the system will automatically create a `Startup` script set and configure the corresponding start scripts automatically.

After the script is installed, find the script "Guance Integration (Huawei Cloud-DIS Collection)" under "Development" in Func, expand and modify this script. Find `collector_configs` and `monitor_configs` and edit the content of `region_projects` below, change the region and Project ID to the actual region and Project ID, then click Save and Publish.

In addition, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click 【Execute】to immediately execute once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

We default collect some configurations, for more details see the metrics section [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-ces/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any anomalies.
2. In the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. In the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Huawei Cloud Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration [Huawei Cloud Cloud Monitoring Metric Details](https://support.huaweicloud.com/usermanual-dis/dis_01_0131.html){:target="_blank"}

| Metric ID                                | Metric Name             | Description                                                     | Value Range      | Measurement Object (Dimension) | Monitoring Period (Original Metric)|
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| dis01_stream_put_bytes_rate   | Total Input Traffic             | This metric is used to count the amount of data uploaded to the channel within the specified time range. Unit: byte/s. | ≥ 0 bytes/s | Channel                              | 1 minute                                             |
| dis02_stream_get_bytes_rate              | Total Output Traffic             | This metric is used to count the amount of data downloaded from the channel within the specified time range. Unit: byte/s. | ≥ 0 bytes/s | Channel                              | 1 minute                    |
| dis03_stream_put_records                 | Total Input Record Count           | This metric is used to count the number of records uploaded to the channel within the specified time range. Unit: Count/s. | ≥ 0 Count/s | Channel                              | 1 minute                    |
| dis04_stream_get_records                 | Total Output Record Count           | This metric is used to count the number of records downloaded from the channel within the specified time range. Unit: Count/s. | ≥ 0 Count/s | Channel                              | 1 minute                    |
| dis05_stream_put_requests_succeed        | Successful Upload Requests         | This metric is used to count the number of successful upload requests to the channel within the specified time range. Unit: Count/s. | ≥ 0 Count/s | Channel                              | 1 minute                    |
| dis06_stream_get_requests_succeed        | Successful Download Requests         | This metric is used to count the number of successful download requests from the channel within the specified time range. Unit: Count/s. | ≥ 0 Count/s | Channel                              | 1 minute                    |
| dis07_stream_put_req_average_latency     | Average Upload Request Processing Time   | This metric is used to count the average latency of upload requests to the channel within the specified time range. Unit: ms. | 0~50ms      | Channel                              | 1 minute                    |
| dis08_stream_get_req_average_latency     | Average Download Request Processing Time   | This metric is used to count the average latency of download requests from the channel within the specified time range. Unit: ms. | 0~50ms      | Channel                              | 1 minute                    |
| dis09_stream_traffic_control_put_records | Upload Requests Rejected Due to Flow Control | This metric is used to count the number of upload requests rejected due to flow control within the specified time range. Unit: Count/s. | 0~1Count/s  | Channel                              | 1 minute                    |
| dis10_stream_traffic_control_get_records | Download Requests Rejected Due to Flow Control | This metric is used to count the number of download requests rejected due to flow control within the specified time range. Unit: Count/s. | 0~1Count/s  | Channel                              | 1 minute                    |

## Objects {#object}

The collected Huawei Cloud DIS object data structure can be viewed under "Infrastructure - Custom"

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
    "message"            : "{instance JSON data}"
  }
}
```

Some parameter descriptions are as follows:

| Field                  | Type                   | Description                  |
| :------------------- | :--------------------- | :---------------------  |
| `create_time`        | integer | Channel creation time, 13-digit timestamp.|
| `retention_period`  | integer | Data retention duration, unit is hours. |
| `status`  | str | Current status of the channel. CREATING: Creating  RUNNING: Running  TERMINATING: Terminating  TERMINATED: Terminated |
| `stream_type`  | str | Channel type. COMMON: Common channel, indicating 1MB bandwidth. ADVANCED: Advanced channel, indicating 5MB bandwidth. |
| `data_type`  | str | Source data type. BLOB: A set of binary data stored in a database management system. JSON: An open file format based on readable text used to transmit data objects composed of attribute values or sequential values. CSV: Tabular data stored in plain text form, with delimiter defaulting to comma. Default value: BLOB. |
| `auto_scale_enabled`  | bool | Whether auto-scaling is enabled. true: Auto-scaling is enabled. false: Auto-scaling is disabled. Default value: false |



> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, used for unique identification.
>
> Tip 2: The following fields are serialized JSON strings:
>
> - fields.message
