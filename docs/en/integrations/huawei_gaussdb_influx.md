---
title: 'Huawei Cloud GaussDB-Influx'
tags: 
  - Huawei Cloud
summary: 'The display Metrics of Huawei Cloud GaussDB-Influx include write throughput, query latency, data retention policies, and scalability. These Metrics reflect the performance and reliability of GaussDB-Influx when handling large-scale time series data storage and queries.'
__int_icon: 'icon/huawei_gaussdb_influx'
dashboard:

  - desc: 'Huawei Cloud GaussDB-Influx built-in views'
    path: 'dashboard/en/huawei_gaussdb_influx'

monitor:
  - desc: 'Huawei Cloud GaussDB-Influx monitors'
    path: 'monitor/en/huawei_gaussdb_influx'

---


<!-- markdownlint-disable MD025 -->
# Huawei Cloud GaussDB-Influx
<!-- markdownlint-enable -->

The display Metrics of Huawei Cloud GaussDB-Influx include write throughput, query latency, data retention policies, and scalability. These Metrics reflect the performance and reliability of GaussDB-Influx when handling large-scale time series data storage and queries.


## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites will be automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize Huawei Cloud DIS monitoring data, we install the corresponding collection script: 「<<< custom_key.brand_name >>> Integration (Huawei Cloud-GaussDB-Influx Collection)」(ID: `guance_huaweicloud_gaussdb_influx`)

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After the script is installed, find the script 「<<< custom_key.brand_name >>> Integration (Huawei Cloud-GaussDB-Influx Collection)」in the "Development" section of Func, expand and modify this script. Find `collector_configs` and `monitor_configs`, respectively edit the content of `region_projects`, change the region and Project ID to the actual region and Project ID, then click Save and Publish.

In addition, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to immediately execute once without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

We default collect some configurations, for details see the Metrics column [Customize cloud object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-huaweicloud-ces/){:target="_blank"}


### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm whether the corresponding task has the corresponding automatic trigger configuration, and at the same time, you can check the corresponding task records and logs to see if there are any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, under 「Infrastructure / Custom」, check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, under 「Metrics」, check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Huawei Cloud - Cloud Monitoring, the default Measurement set is as follows. You can collect more Metrics through configuration [Huawei Cloud Cloud Monitoring Metrics Details](https://support.huaweicloud.com/influxug-nosql/nosql_09_0036.html){:target="_blank"}

| Metric ID                                | Metric Name             | Metric Meaning                                                     | Value Range      | Measurement Object | Monitoring Period (Raw Metric)|
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| `nosql001_cpu_usage`       | CPU Utilization      | This Metric collects CPU usage from the system level. Unit: %                  | 0~100 %  | GaussDB(for Influx) instance nodes | 1 minute                                             |
| `nosql002_mem_usage`       | Memory Utilization     | This Metric collects memory usage from the system level. Unit: %                 | 0~100 %  | GaussDB(for Influx) instance nodes | 1 minute                |
| `nosql003_bytes_out`       | Network Output Throughput | Statistics of the average traffic output per second from all network adapters of the measurement object. Unit: kb/s | ≥ 0 kb/s | GaussDB(for Influx) instance nodes | 1 minute                |
| `nosql004_bytes_in`        | Network Input Throughput | Statistics of the average traffic input per second from all network adapters of the measurement object. Unit: kb/s | ≥ 0 kb/s | GaussDB(for Influx) instance nodes | 1 minute                |
| `nosql005_disk_usage`      | Disk Utilization     | This Metric statistics the disk utilization of the measurement object. Unit: %                 | 0~100 %  | GaussDB(for Influx) instance nodes | 1 minute                |
| `nosql006_disk_total_size` | Total Disk Size     | This Metric statistics the total disk size of the measurement object. Unit: GB                | ≥ 0 GB   | GaussDB(for Influx) instance nodes | 1 minute                |
| `nosql007_disk_used_size`  | Used Disk Size     | This Metric statistics the total used disk size of the measurement object. Unit: GB          | ≥ 0 GB   | GaussDB(for Influx) instance nodes | 1 minute                |
| `influxdb001_series_num` | Time Series Count | Describes the total number of time series. Unit: Counts | ≥ 0 Counts | GaussDB(for Influx) instance nodes | 1 minute |
| `influxdb002_query_req_ps` | Queries Per Second | Describes the number of queries per second. Unit: Counts/s | ≥ 0 Counts/s | GaussDB(for Influx) instance nodes | 1 minute |
| `influxdb003_write_req_ps` | Writes Per Second | Describes the number of writes per second. Unit: Counts/s | ≥ 0 Counts/s | GaussDB(for Influx) instance nodes | 1 minute |
| `influxdb004_write_points_ps` | Written Data Points | Describes the number of data points written per second. Unit: Counts/s | ≥ 0 Counts/s | GaussDB(for Influx) instance nodes | 1 minute |
| `influxdb005_write_concurrency` | Write Concurrency | Describes the number of concurrent write requests. Unit: Counts | ≥ 0 Counts | GaussDB(for Influx) instance nodes | 1 minute |
| `influxdb006_query_concurrency` | Query Concurrency | Describes the number of concurrent query requests. Unit: Counts | ≥ 0 Counts | GaussDB(for Influx) instance nodes | 1 minute |

## Objects {#object}

The collected Huawei Cloud GaussDB-Influx object data structure can be viewed under 「Infrastructure - Custom」

``` json
{
  "measurement": "huaweicloud_gaussdb_nosql",
  "tags": {
    "RegionId"          : "cn-north-4",
    "db_user_name"      : "rwuser",
    "engine"            : "rocksDB",
    "instance_id"       : "1236a915462940xxxxxx879882200in02",
    "instance_name"     : "nosql-efa7",
    "name"              : "1236a915462940xxxxxx879882200in02",
    "pay_mode"          : "0",
    "port"              : "8635",
    "project_id"        : "15c6ce1c12dxxxx0xxxx2076643ac2b9",
    "security_group_id" : "7aa51dbf-xxxx-xxxx-xxxx-dad3c4828b58",
    "status"            : "normal",
    "subnet_id"         : "f1df08c5-xxxx-xxxx-xxxx-de435a51007b",
    "vpc_id"            : "674e9b42-xxxx-xxxx-xxxx-5abcc565b961"
  },
  "fields": {
    "actions"         : "[]",
    "create_time"     : "2023-08-01T14:17:40+0800",
    "update_time"     : "2023-08-01T14:17:42+0800",
    "backup_strategy" : "{Instance JSON Data}",
    "datastore"       : "{Instance JSON Data}",
    "groups"          : "[{Instance JSON Data}]",
    "time_zone"       : "",
    "message"         : "{Instance JSON Data}"
  }
}

```



> *Note: The fields in `tags` and `fields` may vary with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, which serves as a unique identifier.
>
> Tip 2: The following fields are all strings serialized in JSON format:
>
> - `fields.message`
> - `fields.backup_strategy`
> - `fields.datastore`
> - `fields.groups`
> - `fields.actions`