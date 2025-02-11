---
title: 'Huawei Cloud OBS'
tags: 
  - Huawei Cloud
summary: 'Use the "Guance Cloud Sync" series of script packages from the Script Market to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/huawei_obs'
dashboard:

  - desc: 'Built-in View for Huawei Cloud OBS'
    path: 'dashboard/en/huawei_obs'

monitor:
  - desc: 'Huawei Cloud OBS Monitor'
    path: 'monitor/en/huawei_obs'

---

<!-- markdownlint-disable MD025 -->
# Huawei Cloud OBS
<!-- markdownlint-enable -->

Use the "Guance Cloud Sync" series of script packages from the Script Market to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

We recommend enabling the Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize Huawei Cloud OBS monitoring data, we install the corresponding collection script: "Guance Integration (Huawei Cloud-OBS Collection)" (ID: `guance_huaweicloud_obs`)

Click [Install], then input the required parameters: Huawei Cloud AK, Huawei Cloud account name.

Click [Deploy Startup Script], and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

After the script is installed, find the script "Guance Integration (Huawei Cloud-OBS Collection)" under "Development" in Func, expand and modify this script. Find `collector_configs` and replace the regions after `regions` with your actual regions. Then find `monitor_configs` under `region_projects`, change it to the actual region and Project ID. Click Save and Publish.

Additionally, in "Management / Automatic Trigger Configuration", you can see the corresponding automatic trigger configuration. Click [Execute] to run immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

By default, some configurations are collected; for more details, see [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-huaweicloud-obs/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and check the task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Huawei Cloud Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration [Huawei Cloud Cloud Monitoring Metric Details](https://support.huaweicloud.com/usermanual-obs/obs_03_0010.html){:target="_blank"}

| Metric ID                        | Metric Name              | Metric Description                                                       | Value Range   | Measurement Object | Monitoring Period (Raw Metric) |
| -------------------------------- | ------------------------ | ------------------------------------------------------------------------ | ------------- | ------------------ | ------------------------------ |
| `get_request_count`              | GET Request Count        | This metric counts the number of GET requests for all buckets and objects within the bucket. Unit: count | ≥ 0 counts    | Bucket             | 1 minute                      |
| `put_request_count`              | PUT Request Count        | This metric counts the number of PUT requests for all buckets and objects within the bucket. Unit: count | ≥ 0 counts    | Bucket             | 1 minute                      |
| `first_byte_latency`             | Average First Byte Latency of GET Requests | This metric calculates the average time taken from receiving a complete request to starting the response for GET operations. Unit: ms | ≥ 0 ms        | Bucket             | 1 minute                      |
| `request_count_4xx`              | Number of 4xx Status Codes | This metric counts the number of requests with server response status codes 4xx. Unit: count | ≥ 0 counts    | User Bucket Interface | 1 minute                      |
| `request_count_5xx`              | Number of 5xx Status Codes | This metric counts the number of requests with server response status codes 5xx. Unit: count | ≥ 0 counts    | User Bucket Interface | 1 minute                      |
| `total_request_latency`          | Average Total Request Latency | This metric calculates the average time taken from receiving a complete request to ending the response for all operations on all buckets. Unit: ms | ≥ 0 ms        | User Bucket Interface | 1 minute                      |
| `request_count_per_second`       | Total TPS                | This metric calculates the average number of requests per second during the current statistical period. Unit: count | ≥ 0 counts    | User Bucket Domain | 1 minute                      |
| `request_count_get_per_second`   | GET Request TPS          | This metric calculates the average number of GET requests per second during the current statistical period. Unit: count | ≥ 0 counts    | User Bucket Domain | 1 minute                      |
| `request_count_put_per_second`   | PUT Request TPS          | This metric calculates the average number of PUT requests per second during the current statistical period. Unit: count | ≥ 0 counts    | User Bucket Domain | 1 minute                      |
| `request_count_delete_per_second`| DELETE Request TPS       | This metric calculates the average number of DELETE requests per second during the current statistical period. Unit: count | ≥ 0 counts    | User Bucket Domain | 1 minute                      |
| `request_success_rate`           | Request Success Rate     | This metric measures the availability of the storage service. It is calculated as (1 - number of 5XX responses / total number of requests) * 100%. Unit: % | ≥ 0, ≤100     | User Bucket Interface Domain | 1 minute                      |
| `effective_request_rate`         | Effective Request Rate   | This metric measures the effectiveness of client requests. It is calculated as (number of client responses with status codes 2XX, 3XX / total number of requests) * 100%. Unit: % | ≥ 0, ≤100     | User Bucket Interface | 1 minute                      |
| `request_break_rate`             | Request Break Rate       | This metric measures the failure rate due to client interruptions. It is calculated as (number of interrupted requests / total number of requests) * 100%. Unit: % | ≥ 0, ≤100     | User Bucket Interface | 1 minute                      |
| `request_code_count`             | HTTP Status Code Counts  | This metric counts the number of requests with specific server response status codes. See [HTTP Status Codes](https://support.huaweicloud.com/usermanual-obs/obs_03_0010.html#section5){:target="_blank"}. Unit: count | ≥ 0 counts    | Bucket Interface HTTP Status Code | 1 minute                      |
| `api_request_count_per_second`   | API Request TPS          | This metric calculates the average number of requests per second for a specific interface of all buckets and objects within the bucket during the current statistical period. Supported interfaces are listed in [Request Interfaces](https://support.huaweicloud.com/usermanual-obs/obs_03_0010.html#section4){:target="_blank"}. Unit: count | ≥ 0 counts    | Bucket Interface | 1 minute                      |
| `request_count_monitor_2XX`      | Number of 2xx Status Codes | This metric counts the number of requests with server response status codes 2xx. Unit: count | ≥ 0 counts    | User Bucket Domain | 1 minute                      |
| `request_count_monitor_3XX`      | Number of 3xx Status Codes | This metric counts the number of requests with server response status codes 3xx. Unit: count | ≥ 0 counts    | User Bucket Domain | 1 minute                      |
| `download_bytes`                 | Total Download Bandwidth | This metric calculates the average total size of downloaded objects per second during the current statistical period. Unit: bytes/s | ≥ 0 bytes/s   | User Bucket Domain | 1 minute                      |
| `download_bytes_extranet`        | Extranet Download Bandwidth | This metric calculates the average total size of downloaded objects from the extranet per second during the current statistical period. Unit: bytes/s | ≥ 0 bytes/s   | User Bucket Domain | 1 minute                      |
| `download_bytes_intranet`        | Intranet Download Bandwidth | This metric calculates the average total size of downloaded objects from the intranet per second during the current statistical period. Unit: bytes/s | ≥ 0 bytes/s   | User Bucket Domain | 1 minute                      |
| `upload_bytes`                   | Total Upload Bandwidth   | This metric calculates the average total size of uploaded objects per second during the current statistical period. Unit: bytes/s | ≥ 0 bytes/s   | User Bucket Domain | 1 minute                      |
| `upload_bytes_extranet`          | Extranet Upload Bandwidth | This metric calculates the average total size of uploaded objects from the extranet per second during the current statistical period. Unit: bytes/s | ≥ 0 bytes/s   | User Bucket Domain | 1 minute                      |
| `upload_bytes_intranet`          | Intranet Upload Bandwidth | This metric calculates the average total size of uploaded objects from the intranet per second during the current statistical period. Unit: bytes/s | ≥ 0 bytes/s   | User Bucket Domain | 1 minute                      |
| `cdn_bytes`                      | CDN Backsource Bandwidth | This metric calculates the average size of CDN backsource requests per second during the current statistical period. Currently, only public network outflow is counted. Unit: bytes/s | ≥ 0 bytes/s   | User Bucket | 1 minute                      |
| `download_traffic`               | Total Download Traffic   | This metric calculates the total size of downloaded objects during the current statistical period. Unit: bytes | ≥ 0 bytes/s   | User Bucket Domain | 1 minute                      |
| `download_traffic_extranet`      | Extranet Download Traffic | This metric calculates the total size of downloaded objects from the extranet during the current statistical period. Unit: bytes | ≥ 0 bytes     | User Bucket Domain | 1 minute                      |
| `download_traffic_intranet`      | Intranet Download Traffic | This metric calculates the total size of downloaded objects from the intranet during the current statistical period. Unit: bytes | ≥ 0 bytes     | User Bucket Domain | 1 minute                      |
| `upload_traffic`                 | Total Upload Traffic     | This metric calculates the total size of uploaded objects during the current statistical period. Unit: bytes | ≥ 0 bytes     | User Bucket Domain | 1 minute                      |
| `upload_traffic_extranet`        | Extranet Upload Traffic  | This metric calculates the total size of uploaded objects from the extranet during the current statistical period. Unit: bytes | ≥ 0 bytes     | User Bucket Domain | 1 minute                      |
| `upload_traffic_intranet`        | Intranet Upload Traffic  | This metric calculates the total size of uploaded objects from the intranet during the current statistical period. Unit: bytes | ≥ 0 bytes     | User Bucket Domain | 1 minute                      |
| `cdn_traffic`                    | CDN Backsource Traffic   | This metric calculates the total traffic of CDN backsource requests during the current statistical period. Currently, only public network outflow is counted. Unit: bytes | ≥ 0 bytes     | User Bucket | 1 minute                      |
| `capacity_total`                 | Total Storage Capacity   | This metric calculates the total storage space capacity occupied by all data. Unit: bytes | ≥ 0 bytes     | User Bucket | 30 minutes                    |
| `capacity_standard`              | Standard Storage Capacity | This metric calculates the total storage space capacity occupied by standard storage data. Unit: bytes | ≥ 0 bytes     | User Bucket | 30 minutes                    |
| `capacity_infrequent_access`     | Infrequent Access Storage Capacity | This metric calculates the total storage space capacity occupied by infrequent access storage data. Unit: bytes | ≥ 0 bytes     | User Bucket | 30 minutes                    |
| `capacity_archive`               | Archive Storage Capacity | This metric calculates the total storage space capacity occupied by archive storage data. Unit: bytes | ≥ 0 bytes     | User Bucket | 30 minutes                    |
| `capacity_deep_archive`          | Deep Archive Storage Capacity | This metric calculates the total storage space capacity occupied by deep archive storage data. Unit: bytes | ≥ 0 bytes     | User Bucket | 30 minutes                    |
| `object_num_all`                 | Total Number of Stored Objects | This metric calculates the total number of stored objects of all types. The object count includes folders, current version files, and historical version files within the bucket. Unit: count | ≥ 0 items     | User Bucket | 30 minutes                    |
| `object_num_standard_total`      | Total Number of Standard Stored Objects | This metric calculates the total number of stored objects in standard storage. The object count includes folders, current version files, and historical version files within the bucket. Unit: count | ≥ 0 items     | User Bucket | 30 minutes                    |
| `object_num_infrequent_access_total` | Total Number of Infrequent Access Stored Objects | This metric calculates the total number of stored objects in infrequent access storage. The object count includes folders, current version files, and historical version files within the bucket. Unit: count | ≥ 0 items     | User Bucket | 30 minutes                    |
| `object_num_archive_total`       | Total Number of Archive Stored Objects | This metric calculates the total number of stored objects in archive storage. The object count includes folders, current version files, and historical version files within the bucket. Unit: count | ≥ 0 items     | User Bucket | 30 minutes                    |
| `object_num_deep_archive_total`  | Total Number of Deep Archive Stored Objects | This metric calculates the total number of stored objects in deep archive storage. The object count includes folders, current version files, and historical version files within the bucket. Unit: count | ≥ 0 items     | User Bucket | 30 minutes                    |

## Objects {#object}

The structure of the collected Huawei Cloud OBS object data can be viewed in "Infrastructure - Custom"

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
    "message"    : "{instance JSON data}"
  }
}
```

Parameter explanations for some fields:

bucket_type (Bucket Type) value meanings

| Value     | Description         |
| :------- | :----------- |
| `OBJECT` | Object Storage Bucket   |
| `POSIX`  | Parallel File System |

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Note 1: The value of `tags.name` is the bucket name, used as a unique identifier.