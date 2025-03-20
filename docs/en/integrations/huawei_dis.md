---
title: 'Huawei Cloud DIS'
tags: 
  - Huawei Cloud
summary: 'Collect Huawei Cloud DIS Metrics data'
__int_icon: 'icon/huawei_dis'
dashboard:

  - desc: 'Huawei Cloud DIS built-in views'
    path: 'dashboard/en/huawei_dis'

monitor:
  - desc: 'Huawei Cloud DIS monitor'
    path: 'monitor/en/huawei_dis'

---

Collect Huawei Cloud DIS Metrics data

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of Huawei Cloud DIS, we install the corresponding collection script: "Guance Integration (Huawei Cloud-DIS Collection)" (ID: `guance_huaweicloud_dis`)

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK, Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After the script is installed, find the script "Guance Integration (Huawei Cloud-DIS Collection)" under "Development" in Func, expand and modify this script, find `collector_configs` and `monitor_configs` respectively, and edit the content of `region_projects`. Change the region and Project ID to the actual region and Project ID, then click Save and Publish.

In addition, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a while, you can view the execution task records and corresponding logs.

### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding automatic trigger configuration exists for the task, and you can also check the corresponding task records and logs to see if there are any abnormalities.
2. On the Guance platform, check whether there is asset information in "Infrastructure - Resource Catalog".
3. On the Guance platform, check whether there are corresponding monitoring data in "Metrics".

## Metrics {#metric}

Configure Huawei Cloud DIS Metrics, you can collect more Metrics through configuration [Huawei Cloud DIS Metrics Details](https://support.huaweicloud.com/usermanual-dis/dis_01_0131.html){:target="_blank"}

| Metric ID                                | Metric Name             | Metric Meaning                                                     | Value Range      | Measurement Object (Dimension) | Monitoring Period (Raw Metric) |
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| dis01_stream_put_bytes_rate   | Total Input Traffic             | This metric is used to count the amount of data uploaded to the channel within a specified time range. Unit: byte/s. | ≥ 0 bytes/s | Channel                              | 1 minute                                             |
| dis02_stream_get_bytes_rate              | Total Output Traffic             | This metric is used to count the amount of data downloaded from the channel within a specified time range. Unit: byte/s. | ≥ 0 bytes/s | Channel                              | 1 minute                    |
| dis03_stream_put_records                 | Total Input Records           | This metric is used to count the number of records uploaded to the channel within a specified time range. Unit: Count/s. | ≥ 0 Count/s | Channel                              | 1 minute                    |
| dis04_stream_get_records                 | Total Output Records           | This metric is used to count the number of records downloaded from the channel within a specified time range. Unit: Count/s. | ≥ 0 Count/s | Channel                              | 1 minute                    |
| dis05_stream_put_requests_succeed        | Successful Upload Requests         | This metric is used to count the number of successful upload requests to the channel within a specified time range. Unit: Count/s. | ≥ 0 Count/s | Channel                              | 1 minute                    |
| dis06_stream_get_requests_succeed        | Successful Download Requests         | This metric is used to count the number of successful download requests from the channel within a specified time range. Unit: Count/s. | ≥ 0 Count/s | Channel                              | 1 minute                    |
| dis07_stream_put_req_average_latency     | Average Processing Time for Upload Requests   | This metric is used to count the average latency of upload requests to the channel within a specified time range. Unit: ms. | 0~50ms      | Channel                              | 1 minute                    |
| dis08_stream_get_req_average_latency     | Average Processing Time for Download Requests   | This metric is used to count the average latency of download requests from the channel within a specified time range. Unit: ms. | 0~50ms      | Channel                              | 1 minute                    |
| dis09_stream_traffic_control_put_records | Number of Upload Requests Rejected Due to Flow Control | This metric is used to count the number of upload requests rejected by the channel due to flow control within a specified time range. Unit: Count/s. | 0~1Count/s  | Channel                              | 1 minute                    |
| dis10_stream_traffic_control_get_records | Number of Download Requests Rejected Due to Flow Control | This metric is used to count the number of download requests rejected by the channel due to flow control within a specified time range. Unit: Count/s. | 0~1Count/s  | Channel                              | 1 minute                    |

## Objects {#object}

The collected Huawei Cloud DIS object data structure can be seen in "Infrastructure -" 

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

Some parameter descriptions are as follows:

| Field                  | Type                   | Description                  |
| :------------------- | :--------------------- | :---------------------  |
| `create_time`        | integer | The creation time of the channel, 13-digit timestamp.|
| `retention_period`  | integer | Data retention period, unit is hours. |
| `status`  | str | Current status of the channel. CREATING: Creating RUNNING: Running TERMINATING: Deleting TERMINATED: Deleted |
| `stream_type`  | str | Channel type. COMMON: Common channel, indicating 1MB bandwidth. ADVANCED: Advanced channel, indicating 5MB bandwidth. |
| `data_type`  | str | Source data type. BLOB: A set of binary data stored in a database management system. JSON: An open file format based on readable text, used to transmit data objects composed of attribute values or sequential values. CSV: Tabular data stored in plain text form, delimiter defaults to comma. Default value: BLOB. |
| `auto_scale_enabled`  | bool | Whether auto-scaling is enabled. true: Auto-scaling is enabled. false: Auto-scaling is disabled. Default is not enabled. Default value: false |



> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, which serves as a unique identifier.
>
> Tip 2: The following fields are all JSON serialized strings.
>
> - fields.message