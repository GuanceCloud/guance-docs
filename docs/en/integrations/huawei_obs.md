---
title: 'Huawei Cloud OBS'
tags: 
  - Huawei Cloud
summary: 'Collect Huawei Cloud OBS Metrics data'
__int_icon: 'icon/huawei_obs'
dashboard:

  - desc: 'Huawei Cloud OBS built-in views'
    path: 'dashboard/en/huawei_obs'

monitor:
  - desc: 'Huawei Cloud OBS monitor'
    path: 'monitor/en/huawei_obs'

---

Collect Huawei Cloud OBS Metrics data

## Configuration {#config}

### Install Func

It is recommended to enable the <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func by yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize Huawei Cloud OBS monitoring data, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (Huawei Cloud-OBS Collection)" (ID: `guance_huaweicloud_obs`)

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy Start Script】, and the system will automatically create a `Startup` script set, and automatically configure the corresponding start script.

After the script is installed, find the script "<<< custom_key.brand_name >>> Integration (Huawei Cloud-OBS Collection)" under "Development" in Func, expand and modify this script. Find `collector_configs`, replace the regions after `regions` with your actual region, then find `monitor_configs` below `region_projects`, change it to the actual region and Project ID. Then click Save and Publish.

In addition, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click 【Execute】to immediately execute once without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.

### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and at the same time, you can view the corresponding task records and logs to check for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, in "Infrastructure - Resource Catalog", check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, in "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}

Huawei Cloud OBS Metrics data can be collected via configuration methods. For more Metrics, refer to [Huawei Cloud OBS Metrics Details](https://support.huaweicloud.com/usermanual-obs/obs_03_0010.html){:target="_blank"}

| Metric ID                        | Metric Name             | Metric Meaning                                                     | Value Range   | Measurement Object         | Monitoring Period (Raw Metric) |
| ------------------------------- | ----------------------- | ------------------------------------------------------------ | ---------- | ---------------- | -------------------- |
| `get_request_count`             | GET request count       | This metric counts the number of GET requests for all buckets and objects within them. Unit: times        | ≥ 0 counts | Bucket               | 1 minute                |
| `put_request_count`             | PUT request count       | This metric counts the number of PUT requests for all buckets and objects within them. Unit: times        | ≥ 0 counts | Bucket               | 1 minute                |
| `first_byte_latency`            | GET request first byte average latency | This metric counts the average time from when the system receives a complete GET request to when it begins returning a response. Unit: milliseconds | ≥ 0 ms     | Bucket               | 1 minute                |
| `request_count_4xx`             | Number of 4xx status codes | This metric counts the number of requests where the server responds with a 4xx status code. Unit: times        | ≥ 0 counts | User bucket interface       | 1 minute                |
| `request_count_5xx`             | Number of 5xx status codes | This metric counts the number of requests where the server responds with a 5xx status code. Unit: times        | ≥ 0 counts | User bucket interface       | 1 minute                |
| `total_request_latency`         | Total request average latency | This metric counts the average time from when the system receives a complete request to when it finishes returning a response for all operations on all buckets. Unit: milliseconds | ≥ 0 ms     | User bucket interface       | 1 minute                |
| `request_count_per_second`     | Total TPS              | Average number of requests per second during the current statistical period. Unit: times                       | ≥ 0 counts | User bucket domain       | 1 minute                |
| `request_count_get_per_second`  | GET request TPS        | Average number of GET requests per second during the current statistical period. Unit: times              | ≥ 0 counts | User bucket domain       | 1 minute                |
| `request_count_put_per_second`  | PUT request TPS        | Average number of PUT requests per second during the current statistical period. Unit: times              | ≥ 0 counts | User bucket domain       | 1 minute                |
| `request_count_delete_per_second` | DELETE request TPS     | Average number of DELETE requests per second during the current statistical period. Unit: times           | ≥ 0 counts | User bucket domain       | 1 minute                |
| `request_success_rate`          | Request success rate    | This metric measures the availability of the storage service system. The percentage of non-server error requests (with 5xx status codes) out of total requests, calculated as: (1-5XX quantity/total request quantity)*100%. Unit: % | ≥ 0, ≤100  | User bucket interface domain   | 1 minute                |
| `effective_request_rate`        | Effective request rate  | This metric measures the effectiveness of client requests. The percentage of effective requests out of total requests, calculated as: (client returns 2XX, 3XX quantity/total request quantity)*100%. Unit: % | ≥ 0, ≤100  | User bucket interface       | 1 minute                |
| `request_break_rate`            | Request interruption rate | This metric measures the failure ratio due to client interruptions, calculated as: (client interrupt request quantity/total request quantity)*100%. Unit: % | ≥ 0, ≤100  | User bucket interface       | 1 minute                |
| `request_code_count`            | HTTP status code count | This metric counts the number of requests with specific server response status codes. See supported [HTTP status codes](https://support.huaweicloud.com/usermanual-obs/obs_03_0010.html#section5){:target="_blank"}. Unit: times | ≥ 0 counts | Bucket interface HTTP status code | 1 minute                |
| `api_request_count_per_second`  | Interface request TPS   | This metric counts the average number of requests per second for a specific interface of all buckets and objects within them during the current statistical period. Supported interface types are listed in [Request Interfaces](https://support.huaweicloud.com/usermanual-obs/obs_03_0010.html#section4){:target="_blank"}. | ≥ 0 counts | Bucket interface           | 1 minute                |
| `request_count_monitor_2XX`     | Number of 2xx status codes | This metric counts the number of requests where the server responds with a 2xx status code. Unit: times        | ≥ 0 counts | User bucket domain       | 1 minute                |
| `request_count_monitor_3XX`     | Number of 3xx status codes | This metric counts the number of requests where the server responds with a 3xx status code. Unit: times        | ≥ 0 counts | User bucket domain       | 1 minute                |
| `download_bytes`                | Total download bandwidth | This metric counts the sum of object sizes downloaded per second during the period. Unit: bytes/s   | ≥ 0 bytes/s | User bucket domain       | 1 minute                |
| `download_bytes_extranet`       | Extranet download bandwidth | This metric counts the sum of object sizes downloaded per second over the extranet during the period. Unit: bytes/s | ≥ 0 bytes/s | User bucket domain       | 1 minute                |
| `download_bytes_intranet`       | Intranet download bandwidth | This metric counts the sum of object sizes downloaded per second over the intranet during the period. Unit: bytes/s | ≥ 0 bytes/s | User bucket domain       | 1 minute                |
| `upload_bytes`                  | Total upload bandwidth  | This metric counts the sum of object sizes uploaded per second during the period. Unit: bytes/s   | ≥ 0 bytes/s | User bucket domain       | 1 minute                |
| `upload_bytes_extranet`         | Extranet upload bandwidth | This metric counts the sum of object sizes uploaded per second over the extranet during the period. Unit: bytes/s | ≥ 0 bytes/s | User bucket domain       | 1 minute                |
| `upload_bytes_intranet`         | Intranet upload bandwidth | This metric counts the sum of object sizes uploaded per second over the intranet during the period. Unit: bytes/s | ≥ 0 bytes/s | User bucket domain       | 1 minute                |
| `cdn_bytes`                     | CDN back-to-source bandwidth | This metric counts the average size per second of CDN back-to-source requests during the period. Currently only public network traffic is counted. Unit: bytes/s | ≥ 0 bytes/s | User bucket           | 1 minute                |
| `download_traffic`              | Total download traffic  | This metric counts the sum of object sizes downloaded during the period. Unit: bytes             | ≥ 0 bytes/s | User bucket domain       | 1 minute                |
| `download_traffic_extranet`     | Extranet download traffic | This metric counts the sum of object sizes downloaded over the extranet during the period. Unit: bytes         | ≥ 0 bytes  | User bucket domain       | 1 minute                |
| `download_traffic_intranet`     | Intranet download traffic | This metric counts the sum of object sizes downloaded over the intranet during the period. Unit: bytes         | ≥ 0 bytes  | User bucket domain       | 1 minute                |
| `upload_traffic`                | Total upload traffic    | This metric counts the sum of object sizes uploaded during the period. Unit: bytes             | ≥ 0 bytes  | User bucket domain       | 1 minute                |
| `upload_traffic_extranet`       | Extranet upload traffic | This metric counts the sum of object sizes uploaded over the extranet during the period. Unit: bytes         | ≥ 0 bytes  | User bucket domain       | 1 minute                |
| `upload_traffic_intranet`       | Intranet upload traffic | This metric counts the sum of object sizes uploaded over the intranet during the period. Unit: bytes         | ≥ 0 bytes  | User bucket domain       | 1 minute                |
| `cdn_traffic`                   | CDN back-to-source traffic | This metric counts the sum of traffic for CDN back-to-source requests during the period. Currently only public network traffic is counted. Unit: bytes | ≥ 0 bytes  | User bucket           | 1 minute                |
| `capacity_total`                | Total storage usage     | This metric counts the total storage space occupied by all data. Unit: bytes       | ≥ 0 bytes | User bucket   | 30 minutes               |
| `capacity_standard`             | Standard storage usage  | This metric counts the total storage space occupied by standard storage data. Unit: bytes   | ≥ 0 bytes | User bucket   | 30 minutes               |
| `capacity_infrequent_access`    | Infrequent access storage usage | This metric counts the total storage space occupied by infrequent access storage data. Unit: bytes | ≥ 0 bytes | User bucket   | 30 minutes               |
| `capacity_archive`              | Archive storage usage   | This metric counts the total storage space occupied by archive storage data. Unit: bytes   | ≥ 0 bytes | User bucket   | 30 minutes               |
| `capacity_deep_archive`         | Deep archive storage usage | This metric counts the total storage space occupied by deep archive storage data. Unit: bytes | ≥ 0 bytes | User bucket   | 30 minutes               |
| `object_num_all`               | Total stored objects    | This metric counts the total number of objects stored across all storage types, including folders, current version files, and historical version files within the bucket. Unit: items | ≥ 0 items     | User bucket   | 30 minutes               |
| `object_num_standard_total`     | Total standard stored objects | This metric counts the total number of objects stored in standard storage, including folders, current version files, and historical version files within the bucket. Unit: items | ≥ 0 items     | User bucket   | 30 minutes               |
| `object_num_infrequent_access_total` | Total infrequent access stored objects | This metric counts the total number of objects stored in infrequent access storage, including folders, current version files, and historical version files within the bucket. Unit: items | ≥ 0 items     | User bucket   | 30 minutes               |
| `object_num_archive_total`      | Total archive stored objects | This metric counts the total number of objects stored in archive storage, including folders, current version files, and historical version files within the bucket. Unit: items | ≥ 0 items     | User bucket   | 30 minutes               |
| `object_num_deep_archive_total` | Total deep archive stored objects | This metric counts the total number of objects stored in deep archive storage, including folders, current version files, and historical version files within the bucket. Unit: items | ≥ 0 items     | User bucket   | 30 minutes               |

## Objects {#object}

The collected Huawei Cloud OBS object data structure can be viewed in "Infrastructure - Resource Catalog".

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
    "message"    : "{Instance JSON data}"
  }
}
```

Explanation of some parameters:

`bucket_type` (Bucket type) value meanings

| Value     | Description         |
| :------- | :----------- |
| `OBJECT` | Object storage bucket   |
| `POSIX`  | Parallel file system |

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the bucket name, used as unique identification.