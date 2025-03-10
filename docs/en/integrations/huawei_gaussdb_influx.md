---
title: 'Huawei Cloud GaussDB-Influx'
tags: 
  - Huawei Cloud
summary: 'The displayed metrics for Huawei Cloud GaussDB-Influx include write throughput, query latency, data retention policy, and scalability. These metrics reflect the performance and reliability of GaussDB-Influx when handling large-scale time series data storage and queries.'
__int_icon: 'icon/huawei_gaussdb_influx'
dashboard:

  - desc: 'Built-in views for Huawei Cloud GaussDB-Influx'
    path: 'dashboard/en/huawei_gaussdb_influx'

monitor:
  - desc: 'Monitor for Huawei Cloud GaussDB-Influx'
    path: 'monitor/en/huawei_gaussdb_influx'

---

<!-- markdownlint-disable MD025 -->
# Huawei Cloud GaussDB-Influx
<!-- markdownlint-enable -->

The displayed metrics for Huawei Cloud GaussDB-Influx include write throughput, query latency, data retention policy, and scalability. These metrics reflect the performance and reliability of GaussDB-Influx when handling large-scale time series data storage and queries.


## Configuration {#config}

### Install Func

We recommend enabling Guance integration - Extensions - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data from Huawei Cloud DIS, we install the corresponding collection script: 「Guance Integration (Huawei Cloud-GaussDB-Influx Collection)」(ID: `guance_huaweicloud_gaussdb_influx`)

Click 【Install】and input the corresponding parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script.

After the script is installed, find the script 「Guance Integration (Huawei Cloud-GaussDB-Influx Collection)」in the "Development" section of Func, expand and modify this script. Find `collector_configs` and `monitor_configs`, and edit the content under `region_projects`, changing the region and Project ID to the actual ones, then click Save and Publish.

Additionally, in the 「Management / Automatic Trigger Configuration」section, you can see the corresponding automatic trigger configuration. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations. For more details, see [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-ces/){:target="_blank"}


### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm whether the corresponding task has an automatic trigger configuration. You can also check the task records and logs for any anomalies.
2. In the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. In the Guance platform, under 「Metrics」, check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Huawei Cloud Monitoring, the default metric set is as follows. More metrics can be collected through configuration [Huawei Cloud Monitoring Metric Details](https://support.huaweicloud.com/influxug-nosql/nosql_09_0036.html){:target="_blank"}

| Metric ID                                | Metric Name             | Metric Description                                                     | Value Range      | Measurement Object | Monitoring Period (Original Metric)|
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| `nosql001_cpu_usage`       | CPU Utilization      | This metric collects CPU usage at the system level. Unit: %                  | 0~100 %  | GaussDB(for Influx) instance node | 1 minute                                             |
| `nosql002_mem_usage`       | Memory Utilization     | This metric collects memory usage at the system level. Unit: %                 | 0~100 %  | GaussDB(for Influx) instance node | 1 minute                |
| `nosql003_bytes_out`       | Network Output Throughput | Statistics on average traffic output per second from all network adapters of the measurement object. Unit: kb/s | ≥ 0 kb/s | GaussDB(for Influx) instance node | 1 minute                |
| `nosql004_bytes_in`        | Network Input Throughput | Statistics on average traffic input per second from all network adapters of the measurement object. Unit: kb/s | ≥ 0 kb/s | GaussDB(for Influx) instance node | 1 minute                |
| `nosql005_disk_usage`      | Disk Utilization     | This metric collects disk utilization statistics. Unit: %                 | 0~100 %  | GaussDB(for Influx) instance node | 1 minute                |
| `nosql006_disk_total_size` | Total Disk Size     | This metric collects total disk size statistics. Unit: GB                | ≥ 0 GB   | GaussDB(for Influx) instance node | 1 minute                |
| `nosql007_disk_used_size`  | Disk Usage     | This metric collects total used disk size statistics. Unit: GB          | ≥ 0 GB   | GaussDB(for Influx) instance node | 1 minute                |
| `influxdb001_series_num` | Time Series Count | Describes the total number of time series. Unit: Counts | ≥ 0 Counts | GaussDB(for Influx) instance node | 1 minute |
| `influxdb002_query_req_ps` | Queries Per Second | Describes the number of queries per second. Unit: Counts/s | ≥ 0 Counts/s | GaussDB(for Influx) instance node | 1 minute |
| `influxdb003_write_req_ps` | Writes Per Second | Describes the number of write requests per second. Unit: Counts/s | ≥ 0 Counts/s | GaussDB(for Influx) instance node | 1 minute |
| `influxdb004_write_points_ps` | Points Written Per Second | Describes the number of data points written per second. Unit: Counts/s | ≥ 0 Counts/s | GaussDB(for Influx) instance node | 1 minute |
| `influxdb005_write_concurrency` | Write Concurrency | Describes the number of concurrent write requests. Unit: Counts | ≥ 0 Counts | GaussDB(for Influx) instance node | 1 minute |
| `influxdb006_query_concurrency` | Query Concurrency | Describes the number of concurrent query requests. Unit: Counts | ≥ 0 Counts | GaussDB(for Influx) instance node | 1 minute |

## Objects {#object}

The collected Huawei Cloud GaussDB-Influx object data structure can be viewed in 「Infrastructure - Custom」

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
    "backup_strategy" : "{JSON data for instance}",
    "datastore"       : "{JSON data for instance}",
    "groups"          : "[{JSON data for instance}]",
    "time_zone"       : "",
    "message"         : "{JSON data for instance}"
  }
}

```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Note 1: The value of `tags.name` is the instance ID, which serves as a unique identifier.
>
> Note 2: The following fields are JSON serialized strings:
>
> - `fields.message`
> - `fields.backup_strategy`
> - `fields.datastore`
> - `fields.groups`
> - `fields.actions`