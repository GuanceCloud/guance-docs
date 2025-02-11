---
title: 'Huawei Cloud GaussDB-Influx'
tags: 
  - Huawei Cloud
summary: 'The metrics displayed for Huawei Cloud GaussDB-Influx include write throughput, query latency, data retention policies, and scalability. These metrics reflect the performance and reliability of GaussDB-Influx in handling large-scale time series data storage and queries.'
__int_icon: 'icon/huawei_gaussdb_influx'
dashboard:

  - desc: 'Built-in views for Huawei Cloud GaussDB-Influx'
    path: 'dashboard/en/huawei_gaussdb_influx'

monitor:
  - desc: 'Monitors for Huawei Cloud GaussDB-Influx'
    path: 'monitor/en/huawei_gaussdb_influx'

---


<!-- markdownlint-disable MD025 -->
# Huawei Cloud GaussDB-Influx
<!-- markdownlint-enable -->

The metrics displayed for Huawei Cloud GaussDB-Influx include write throughput, query latency, data retention policies, and scalability. These metrics reflect the performance and reliability of GaussDB-Influx in handling large-scale time series data storage and queries.


## Configuration {#config}

### Installing Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data from Huawei Cloud DIS, we install the corresponding collection script: 「Guance Integration (Huawei Cloud-GaussDB-Influx Collection)」(ID: `guance_huaweicloud_gaussdb_influx`)

After clicking 【Install】, enter the required parameters: Huawei Cloud AK, Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script.

After the script is installed, find the script 「Guance Integration (Huawei Cloud-GaussDB-Influx Collection)」 under "Development" in Func, expand and modify this script, locate `collector_configs` and `monitor_configs`, and edit the contents of `region_projects`, changing the region and Project ID to the actual values, then click Save and Publish.

Additionally, in 「Management / Automatic Trigger Configuration」, you can see the corresponding automatic trigger configuration. Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

By default, we collect some configurations; for more details, see the metrics section [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-ces/){:target="_blank"}


### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm that the corresponding task has an automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, in 「Infrastructure / Custom」, check if asset information exists.
3. On the Guance platform, in 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Huawei Cloud monitoring, the default metric set is as follows. You can collect more metrics through configuration [Huawei Cloud Monitoring Metric Details](https://support.huaweicloud.com/influxug-nosql/nosql_09_0036.html){:target="_blank"}

| Metric ID                                | Metric Name             | Metric Description                                                     | Value Range      | Measurement Object | Monitoring Period (Original Metric)|
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| `nosql001_cpu_usage`       | CPU Utilization      | This metric represents the CPU usage rate collected at the system level. Unit: %                  | 0~100 %  | GaussDB(for Influx) instance node | 1 minute                                             |
| `nosql002_mem_usage`       | Memory Utilization     | This metric represents the memory usage rate collected at the system level. Unit: %                 | 0~100 %  | GaussDB(for Influx) instance node | 1 minute                |
| `nosql003_bytes_out`       | Network Output Throughput | Statistics of the average traffic output per second from all network adapters of the measurement object. Unit: kb/s | ≥ 0 kb/s | GaussDB(for Influx) instance node | 1 minute                |
| `nosql004_bytes_in`        | Network Input Throughput | Statistics of the average traffic input per second from all network adapters of the measurement object. Unit: kb/s | ≥ 0 kb/s | GaussDB(for Influx) instance node | 1 minute                |
| `nosql005_disk_usage`      | Disk Utilization     | This metric is used to calculate the disk utilization of the measurement object. Unit: %                 | 0~100 %  | GaussDB(for Influx) instance node | 1 minute                |
| `nosql006_disk_total_size` | Total Disk Size     | This metric is used to calculate the total disk size of the measurement object. Unit: GB                | ≥ 0 GB   | GaussDB(for Influx) instance node | 1 minute                |
| `nosql007_disk_used_size`  | Disk Used Size     | This metric is used to calculate the total disk used size of the measurement object. Unit: GB          | ≥ 0 GB   | GaussDB(for Influx) instance node | 1 minute                |
| `influxdb001_series_num` | Time Series Count | Describes the total number of time series. Unit: Counts | ≥ 0 Counts | GaussDB(for Influx) instance node | 1 minute |
| `influxdb002_query_req_ps` | Queries Per Second | Describes the number of queries per second. Unit: Counts/s | ≥ 0 Counts/s | GaussDB(for Influx) instance node | 1 minute |
| `influxdb003_write_req_ps` | Writes Per Second | Describes the number of write requests per second. Unit: Counts/s | ≥ 0 Counts/s | GaussDB(for Influx) instance node | 1 minute |
| `influxdb004_write_points_ps` | Write Points Per Second | Describes the number of data points written per second. Unit: Counts/s | ≥ 0 Counts/s | GaussDB(for Influx) instance node | 1 minute |
| `influxdb005_write_concurrency` | Write Concurrency | Describes the number of concurrent write requests. Unit: Counts | ≥ 0 Counts | GaussDB(for Influx) instance node | 1 minute |
| `influxdb006_query_concurrency` | Query Concurrency | Describes the number of concurrent query requests. Unit: Counts | ≥ 0 Counts | GaussDB(for Influx) instance node | 1 minute |

## Objects {#object}

The structure of the collected Huawei Cloud GaussDB-Influx object data can be viewed in 「Infrastructure-Custom」.

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

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, which serves as a unique identifier.
>
> Tip 2: The following fields are serialized JSON strings:
>
> - `fields.message`
> - `fields.backup_strategy`
> - `fields.datastore`
> - `fields.groups`
> - `fields.actions`