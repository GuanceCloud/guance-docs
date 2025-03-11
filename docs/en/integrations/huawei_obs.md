---
title: 'Huawei Cloud OBS'
tags: 
  - Huawei Cloud
summary: 'Use the script packages in the Script Market, such as "Guance Cloud Sync", to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/huawei_obs'
dashboard:

  - desc: 'Built-in View for Huawei Cloud OBS'
    path: 'dashboard/en/huawei_obs'

monitor:
  - desc: 'Monitor for Huawei Cloud OBS'
    path: 'monitor/en/huawei_obs'

---


<!-- markdownlint-disable MD025 -->
# Huawei Cloud OBS
<!-- markdownlint-enable -->

Use the script packages in the Script Market, such as "Guance Cloud Sync", to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable the Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant read-only access `ReadOnlyAccess`)

To synchronize Huawei Cloud OBS monitoring data, install the corresponding collection script: "Guance Integration (Huawei Cloud-OBS Collection)" (ID: `guance_huaweicloud_obs`).

Click [Install], then input the corresponding parameters: Huawei Cloud AK, Huawei Cloud account name.

Click [Deploy Startup Script], and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

After the script is installed, find the script "Guance Integration (Huawei Cloud-OBS Collection)" under "Development" in Func, expand and modify this script. Find `collector_configs`, replace the regions after `regions` with your actual regions, then find `monitor_configs` under `region_projects` and change it to your actual region and Project ID. Click Save and Publish.

Additionally, view the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click [Execute] to run it immediately without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.

By default, we collect some configurations; for details, see the metrics section [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-obs/){:target="_blank"}


### Verification

1. Confirm in "Management / Automatic Trigger Configuration" whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any anomalies.
2. In the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. In the Guance platform, under "Metrics", check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Huawei Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration [Huawei Cloud Cloud Monitoring Metric Details](https://support.huaweicloud.com/usermanual-obs/obs_03_0010.html){:target="_blank"}

| Metric ID                          | Metric Name                | Description                                                     | Value Range   | Measurement Object         | Monitoring Period (Original Metric) |
| ----------------------------------- | --------------------------- | --------------------------------------------------------------- | ------------- | -------------------------- | ----------------------------------- |
| `get_request_count`                | GET Request Count           | Counts the number of GET requests for all buckets and objects. Unit: count | ≥ 0 counts    | Bucket                     | 1 minute                           |
| `put_request_count`                | PUT Request Count           | Counts the number of PUT requests for all buckets and objects. Unit: count | ≥ 0 counts    | Bucket                     | 1 minute                           |
| `first_byte_latency`               | Average First Byte Latency  | Averages the time from receiving a complete GET request to starting the response within a statistical period. Unit: milliseconds | ≥ 0 ms        | Bucket                     | 1 minute                           |
| `request_count_4xx`                | Number of 4xx Status Codes  | Counts the number of requests with a server response status code of 4xx. Unit: count | ≥ 0 counts    | User Bucket Interface      | 1 minute                           |
| `request_count_5xx`                | Number of 5xx Status Codes  | Counts the number of requests with a server response status code of 5xx. Unit: count | ≥ 0 counts    | User Bucket Interface      | 1 minute                           |
| `total_request_latency`            | Average Total Request Latency | Averages the time from receiving a complete request to ending the response for all operations on all buckets within a statistical period. Unit: milliseconds | ≥ 0 ms        | User Bucket Interface      | 1 minute                           |
| `request_count_per_second`         | Total TPS                   | Average number of requests per second in the current statistical period. Unit: count | ≥ 0 counts    | User Bucket Domain         | 1 minute                           |
| `request_count_get_per_second`     | GET Request TPS             | Average number of GET requests per second in the current statistical period. Unit: count | ≥ 0 counts    | User Bucket Domain         | 1 minute                           |
| `request_count_put_per_second`     | PUT Request TPS             | Average number of PUT requests per second in the current statistical period. Unit: count | ≥ 0 counts    | User Bucket Domain         | 1 minute                           |
| `request_count_delete_per_second`  | DELETE Request TPS          | Average number of DELETE requests per second in the current statistical period. Unit: count | ≥ 0 counts    | User Bucket Domain         | 1 minute                           |
| `request_success_rate`             | Request Success Rate        | Measures the availability of the storage service. The percentage of non-server error requests (status codes 5xx) out of total requests. Calculation method: (1 - 5XX count / Total Request Count) * 100%. Unit: % | ≥ 0%, ≤100%   | User Bucket Interface Domain | 1 minute                           |
| `effective_request_rate`           | Effective Request Rate      | Measures the effectiveness of client requests. The percentage of valid requests out of total requests. Calculation method: (Client returns 2XX, 3XX count / Total Request Count) * 100%. Unit: % | ≥ 0%, ≤100%   | User Bucket Interface      | 1 minute                           |
| `request_break_rate`               | Request Break Rate          | Measures the failure rate due to client interruption of requests. Calculation method: (Client interrupt request count / Total Request Count) * 100%. Unit: % | ≥ 0%, ≤100%   | User Bucket Interface      | 1 minute                           |
| `request_code_count`               | HTTP Status Code Count      | Counts the number of requests with specific server response status codes. See [HTTP Status Codes](https://support.huaweicloud.com/usermanual-obs/obs_03_0010.html#section5){:target="_blank"}. Unit: count | ≥ 0 counts    | Bucket Interface HTTP Status Code | 1 minute                           |
| `api_request_count_per_second`     | API Request TPS             | Averages the number of requests per second for a specific interface across all buckets and objects within a statistical period. Supported interface types are listed in [Request Interfaces](https://support.huaweicloud.com/usermanual-obs/obs_03_0010.html#section4){:target="_blank"}. Unit: count | ≥ 0 counts    | Bucket Interface            | 1 minute                           |
| `request_count_monitor_2XX`        | Number of 2xx Status Codes  | Counts the number of requests with a server response status code of 2xx. Unit: count | ≥ 0 counts    | User Bucket Domain         | 1 minute                           |
| `request_count_monitor_3XX`        | Number of 3xx Status Codes  | Counts the number of requests with a server response status code of 3xx. Unit: count | ≥ 0 counts    | User Bucket Domain         | 1 minute                           |
| `download_bytes`                   | Total Download Bandwidth    | Averages the total size of downloaded objects per second within a statistical period. Unit: bytes/s | ≥ 0 byte/s    | User Bucket Domain         | 1 minute                           |
| `download_bytes_extranet`          | External Network Download Bandwidth | Averages the total size of externally downloaded objects per second within a statistical period. Unit: bytes/s | ≥ 0 byte/s    | User Bucket Domain         | 1 minute                           |
| `download_bytes_intranet`          | Internal Network Download Bandwidth | Averages the total size of internally downloaded objects per second within a statistical period. Unit: bytes/s | ≥ 0 byte/s    | User Bucket Domain         | 1 minute                           |
| `upload_bytes`                     | Total Upload Bandwidth      | Averages the total size of uploaded objects per second within a statistical period. Unit: bytes/s | ≥ 0 byte/s    | User Bucket Domain         | 1 minute                           |
| `upload_bytes_extranet`            | External Network Upload Bandwidth | Averages the total size of externally uploaded objects per second within a statistical period. Unit: bytes/s | ≥ 0 byte/s    | User Bucket Domain         | 1 minute                           |
| `upload_bytes_intranet`            | Internal Network Upload Bandwidth | Averages the total size of internally uploaded objects per second within a statistical period. Unit: bytes/s | ≥ 0 byte/s    | User Bucket Domain         | 1 minute                           |
| `cdn_bytes`                        | CDN Origin Fetch Bandwidth  | Averages the size of CDN origin fetch requests per second within a statistical period, currently only public network egress is counted. Unit: bytes/s | ≥ 0 byte/s    | User Bucket                | 1 minute                           |
| `download_traffic`                 | Total Download Traffic      | Totals the size of downloaded objects within a statistical period. Unit: bytes | ≥ 0 byte/s    | User Bucket Domain         | 1 minute                           |
| `download_traffic_extranet`        | External Network Download Traffic | Totals the size of externally downloaded objects within a statistical period. Unit: bytes | ≥ 0 bytes     | User Bucket Domain         | 1 minute                           |
| `download_traffic_intranet`        | Internal Network Download Traffic | Totals the size of internally downloaded objects within a statistical period. Unit: bytes | ≥ 0 bytes     | User Bucket Domain         | 1 minute                           |
| `upload_traffic`                   | Total Upload Traffic        | Totals the size of uploaded objects within a statistical period. Unit: bytes | ≥ 0 bytes     | User Bucket Domain         | 1 minute                           |
| `upload_traffic_extranet`          | External Network Upload Traffic | Totals the size of externally uploaded objects within a statistical period. Unit: bytes | ≥ 0 bytes     | User Bucket Domain         | 1 minute                           |
| `upload_traffic_intranet`          | Internal Network Upload Traffic | Totals the size of internally uploaded objects within a statistical period. Unit: bytes | ≥ 0 bytes     | User Bucket Domain         | 1 minute                           |
| `cdn_traffic`                      | CDN Origin Fetch Traffic    | Totals the traffic of CDN origin fetch requests within a statistical period, currently only public network egress is counted. Unit: bytes | ≥ 0 bytes     | User Bucket                | 1 minute                           |
| `capacity_total`                   | Total Storage Usage         | Totals the storage space capacity used by all data. Unit: bytes | ≥ 0 bytes     | User Bucket                | 30 minutes                         |
| `capacity_standard`                | Standard Storage Usage      | Totals the storage space capacity used by standard storage data. Unit: bytes | ≥ 0 bytes     | User Bucket                | 30 minutes                         |
| `capacity_infrequent_access`       | Infrequent Access Storage Usage | Totals the storage space capacity used by infrequent access storage data. Unit: bytes | ≥ 0 bytes     | User Bucket                | 30 minutes                         |
| `capacity_archive`                 | Archive Storage Usage       | Totals the storage space capacity used by archive storage data. Unit: bytes | ≥ 0 bytes     | User Bucket                | 30 minutes                         |
| `capacity_deep_archive`            | Deep Archive Storage Usage  | Totals the storage space capacity used by deep archive storage data. Unit: bytes | ≥ 0 bytes     | User Bucket                | 30 minutes                         |
| `object_num_all`                   | Total Number of Stored Objects | Totals the number of all types of stored objects, including folders, current version files, and historical version files within the bucket. Unit: count | ≥ 0 items     | User Bucket                | 30 minutes                         |
| `object_num_standard_total`        | Total Number of Standard Stored Objects | Totals the number of standard stored objects, including folders, current version files, and historical version files within the bucket. Unit: count | ≥ 0 items     | User Bucket                | 30 minutes                         |
| `object_num_infrequent_access_total` | Total Number of Infrequent Access Stored Objects | Totals the number of infrequent access stored objects, including folders, current version files, and historical version files within the bucket. Unit: count | ≥ 0 items     | User Bucket                | 30 minutes                         |
| `object_num_archive_total`         | Total Number of Archive Stored Objects | Totals the number of archive stored objects, including folders, current version files, and historical version files within the bucket. Unit: count | ≥ 0 items     | User Bucket                | 30 minutes                         |
| `object_num_deep_archive_total`    | Total Number of Deep Archive Stored Objects | Totals the number of deep archive stored objects, including folders, current version files, and historical version files within the bucket. Unit: count | ≥ 0 items     | User Bucket                | 30 minutes                         |

## Objects {#object}

The structure of collected Huawei Cloud OBS object data can be viewed in "Infrastructure - Custom"

``` json
{
  "measurement": "huaweicloud_obs",
  "tags": {
    "name"       : "test0-6153",
    "RegionId"   : "cn-north-4",
    "bucket_type": "OBJECT",
    "location"   : "cn-north-4"
  },
  "fields": {
    "create_date": "2022/06/16 10:51:16",
    "message"    : "{Instance JSON Data}"
  }
}
```

Explanation of some parameters:

bucket_type (Bucket Type) value meanings

| Value     | Explanation         |
| :------- | :----------- |
| `OBJECT` | Object Storage Bucket   |
| `POSIX`  | Parallel File System |

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the bucket name, used as a unique identifier.
