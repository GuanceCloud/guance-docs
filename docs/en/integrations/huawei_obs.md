---
title: 'HUAWEI OBS'
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.'
__int_icon: 'icon/huawei_obs'
dashboard:

  - desc: 'HUAWEI CLOUD OBS Monitoring View'
    path: 'dashboard/zh/huawei_obs'

monitor:
  - desc: 'HUAWEI CLOUD OBS Monitor'
    path: 'monitor/zh/huawei_obs'

---


<!-- markdownlint-disable MD025 -->
# HUAWEI CLOUD OBS
<!-- markdownlint-enable -->

Use the「Guance Synchronization」series script package in the script market to monitor the cloud ,The data of the cloud asset is synchronized to the observation cloud.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to  [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip:Please prepare HUAWEI CLOUD AK that meets the requirements in advance（For simplicity's sake,You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of  HUAWEI CLOUD OBS cloud resources, we install the corresponding collection script:「Guance Integration（HUAWEI CLOUD-OBSCollect）」(ID:`guance_huaweicloud_obs`)

Click [Install] and enter the corresponding parameters: HUAWEI CLOUD AK, HUAWEI CLOUD account name.

Tap [Deploy startup Script],The system automatically creates `Startup` script sets, And automatically configure the corresponding startup script.

After the script is installed,Find the script in「Development」in Func「Guance Integration（HUAWEI CLOUD-OBSCollect）」,Expand to modify this script,find`collector_configs`-`regions`,Change the region to your actual region,Then find `region_projects` under `monitor_configs`,Change to the actual locale and Project ID.Click Save Publish again

In addition, the corresponding automatic trigger configuration is displayed in「Management / Crontab Config」.Tap [Run], It can be executed immediately once, without waiting for a periodic time.After a while, you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-obs/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure HUAWEI CLOUD - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [HUAWEI CLOUD Monitor Metrics Details](https://support.huaweicloud.com/intl/en-us/ae-ad-1-usermanual-obs/obs_03_0010.html){:target="_blank"}

| Metric ID                       | Index name                                               | Metric meaning                                                      | Value range    | Measurement object (dimension)         | Monitoring cycle (raw metrics) |
|------------------------------------|----------------------------------------------------------| ------------------------------------------------------------ | ---------- | ---------------- | -------------------- |
| `get_request_count`                  | Number of GET class requests                             | This metric is used to count the GET requests of all buckets and objects in buckets. Unit: second       | ≥ 0 counts | bucket               | 1 min               |
| `put_request_count`                  | Number of PUT class requests                             | This metric counts the number of PUT requests of all buckets and objects in buckets. Unit: second      | ≥ 0 counts | bucket               | 1 min                |
| `first_byte_latency`                 | Average latency of the first byte of a GET class request | It takes the average time between receiving a complete request and returning a response to a GET operation in a statistical period. Unit: millisecond | ≥ 0 ms     | bucket               | 1 min                |
| `request_count_4xx`                  | 4xx Number of status codes                               | This metric is used to collect statistics on the number of response requests whose status code is 4xx. Unit: second        | ≥ 0 counts | Bucket interface       | 1 min                |
| `request_count_5xx`                  | 5xx Number of status codes                               | This metric is used to collect statistics on the number of response requests whose status code is 5xx. Unit: second       | ≥ 0 counts | Bucket interface       | 1 min                |
| `total_request_latency`              | Average latency of total requests                        | It takes the average time between receiving a complete request and receiving a response in a statistical period for all operations on all buckets. Unit: millisecond | ≥ 0 ms     | Bucket interface       | 1 min                |
| `request_count_per_second`           | Total TPS                                                | Average number of requests per second in the current statistical period. Unit: second                      | ≥ 0 counts | Bucket interface       | 1 min                |
| `request_count_get_per_second`       | The GET class requests TPS                               | Average number of GET requests per second in the current statistical period. Unit: second              | ≥ 0 counts | Bucket interface       | 1 min                |
| `request_count_put_per_second`       | The PUT class requests TPS                               | Average number of PUT requests per second in the current statistical period. Unit: second              | ≥ 0 counts | Bucket interface       | 1 min                |
| `request_count_delete_per_second`    | The DELETE class requests TPS                            | Average number of requests per second for all DELETE classes in the current statistical period. Unit: second           | ≥ 0 counts | Bucket interface       | 1 min                |
| `request_success_rate`               | Request success rate                                     | This metric is used to measure the system availability of storage services. Percentage of non-server error requests (return status code: 5xx) in total requests, calculated by: (1-5XX number/total requests)*100% unit: % | ≥ 0,≤100  | Bucket interface domain name   | 1 min                |
| `effective_request_rate`             | Effective request rate                                   | This metric is used to measure the validity of client requests. Percentage of valid requests in total requests, calculated by: (2XX, 3XX number returned by the client/total requests)*100% Unit: %| ≥ 0,≤100  | Bucket interface       | 1 min                |
| `request_break_rate`                 | Request interruption rate                                | This metric is used to measure the proportion of failures caused by client interrupt requests. It is calculated by (Number of client interrupt requests/Total number of requests) x 100% Unit: %| ≥ 0,≤100  | Bucket interface       | 1 min                |
| `request_code_count`                 | Number of HTTP status codes                              | This metric is used to collect statistics on the number of requests that respond to status codes on the server. unit:count | ≥ 0 counts | HTTP status code of the bucket interface | 1 min                |
| `api_request_count_per_second`       | The interface requested TPS. Procedure                   | Indicates the average number of requests per second for all buckets and objects in buckets in a statistical period.  | ≥ 0 counts | Bucket interface           | 1 min                |
| `request_count_monitor_2XX`          | 2xx Number of status codes                               | This metric is used to collect statistics on the number of response requests whose status code is 2xx. Unit: second      | ≥ 0 counts | Bucket domain name       | 1 min                |
| `request_count_monitor_3XX`          | 3xx Number of status codes                               | This metric is used to collect statistics on the number of response requests whose status code is 3xx. Unit: second        | ≥ 0 counts | Bucket domain name       | 1 min                |
| `download_bytes`                     | Total download bandwidth                                 | This metric is used to measure the size of downloaded objects per second in a statistical period. Unit: byte /s   | ≥ 0 byte/s | Bucket domain name       | 1min                |
| `download_bytes_extranet`            | `Extranet` download bandwidth                              | This metric is used to measure the total size of `Extranet` downloaded objects per second in the statistical period. Unit: byte /s | ≥ 0 byte/s | Bucket domain name       | 1 min                |
| `download_bytes_intranet`            | `Intranet` download bandwidth                              | This metric is used to measure the total size of Intranet downloaded objects per second within the statistical period. Unit: byte /s | ≥ 0 byte/s | Bucket domain name       | 1 min                |
| `upload_bytes`                       | Total upload bandwidth                                   | This metric is used to measure the size of objects uploaded per second in the statistical period. Unit: byte /s   | ≥ 0 byte/s | Bucket domain name       | 1 min                |
| `upload_bytes_extranet`              | `Extranet` transmission bandwidth                          | This metric is used to measure the average size of objects transferred to the `Extranet` per second in the statistical period. Unit: byte /s | ≥ 0 byte/s | Bucket domain name       | 1 min                |
| `upload_bytes_intranet`              | `Intranet` upload bandwidth                                | This metric is used to measure the average size of objects uploaded on the `Intranet` per second in the statistical period. Unit: byte /s | ≥ 0 byte/s | Bucket domain name       | 1 min                |
| `cdn_bytes`                          | cdn Return bandwidth                                     | This metric is used to measure the average size per second of the cdn return request object in a specified period. Currently, only outgoing traffic from the public network is measured. Unit: byte /s | ≥ 0 byte/s | bucket           | 1 min                |
| `download_traffic`                   | Total download traffic                                   | This metric is used to measure the total size of downloaded objects in a statistical period. Unit: byte            | ≥ 0 byte/s | Bucket domain name       | 1 min                |
| `download_traffic_extranet`          | `Extranet` download traffic                                | This metric is used to measure the total size of download objects on and off the `Extranet`. Unit: byte         | ≥ 0 bytes  | Bucket domain name       | 1 min                |
| `download_traffic_intranet`          | `Intranet` download traffic                                | This metric is used to measure the total size of download objects within a specified period. Unit: byte         | ≥ 0 bytes  | Bucket domain name       | 1 min                |
| `upload_traffic`                     | Total upload traffic                                     | This metric is used to measure the total size of uploaded objects in the statistical period. Unit: byte            | ≥ 0 bytes  | Bucket domain name       | 1 min                |
| `upload_traffic_extranet`            | `Extranet` traffic                                         | This metric is used to collect the total size of objects uploaded online within and outside a period. Unit: byte      | ≥ 0 bytes  | Bucket domain name       | 1 min                |
| `upload_traffic_intranet`            | `Intranet` upload traffic                                  | This metric is used to measure the total size of objects uploaded on the `Intranet` in a statistical period. Unit: byte         | ≥ 0 bytes  | Bucket domain name       | 1 min                |
| `cdn_traffic`                        | cdn Return traffic                                       | This metric is used to collect the total amount of inbound cdn traffic within a period. Currently, only outbound traffic of the public network is collected. Unit: byte | ≥ 0 bytes  | bucket           | 1 min                |
| `capacity_total`                     | Total storage usage                                      | This metric measures the storage space occupied by all data. Unit: byte    | ≥ 0 bytes | bucket   | 30 minutes               |
| `capacity_standard`                  | Standard storage usage                                   | This metric measures the storage space used by standard data storage. Unit: byte   | ≥ 0 bytes | bucket   | 30 minutes               |
| `capacity_infrequent_access`         | Low frequency storage usage                              | This metric measures the capacity of the storage space used for low-frequency data access. Unit: byte | ≥ 0 bytes | bucket   | 30 minutes               |
| `capacity_archive`                   | Archive storage usage                                    | This metric measures the storage space occupied by archive data. Unit: byte   | ≥ 0 bytes | bucket   | 30 minutes               |
| `capacity_deep_archive`              | Deep archive storage usage                               | This metric measures the storage space occupied by deep archive data. Unit: byte| ≥ 0 bytes | bucket   | 30 minutes               |
| `object_num_all`                     | Total number of stored objects                           | The object count is the total number of folders, files of the current version, and files of the historical version in the bucket. Unit: Unit | ≥ 0 counts     | bucket   | 30 minutes               |
| `object_num_standard_total`          | Total number of standard storage objects                 | This metric measures the total number of objects stored in the standard storage system. The number of objects is the total number of folders, files of the current version, and files of the historical version in the bucket. Unit: Unit | ≥ 0 counts     | bucket   | 30 minutes               |
| `object_num_infrequent_access_total` | Total number of low frequency storage objects            | This metric measures the total number of objects stored in the low-frequency access storage. The number of objects is the total number of folders, files of the current version, and files of the historical version in the bucket. Unit: Unit| ≥ 0 counts     | bucket   | 30 minutes               |
| `object_num_archive_total`           | Total number of archived storage objects                 | This metric measures the number of objects stored in the archive storage. The number of objects is the total number of folders, files of the current version, and files of the historical version in the bucket. Unit: Unit | ≥ 0 counts     | bucket   | 30 minutes               |
| `object_num_deep_archive_total`      | Number of deep archive storage objects                   | This metric measures the total number of objects stored in the deep archive storage. The object number is the total number of folders, files of current version, and files of historical version in the bucket. Unit: Unit | ≥ 0 counts     | bucket   | 30 minutes               |

## Object {#object}

The collected HUAWEI CLOUD OBS object data structure can see the object data from 「Infrastructure-Custom」

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

Some parameters are described as follows

bucket_type (Bucket type) The value meaning

| value     | Instructions         |
| :------- | :----------- |
| `OBJECT` | Object bucket   |
| `POSIX`  | Parallel file system |

> *notice:`tags`、`fields`The fields in this section may change with subsequent updates*
>
> Tips 1:`tags.name`The value is the bucket name as a unique identifier:`tags.name`The value is the bucket name, used as a unique identification
