---
title: 'HUAWEI GaussDB-Influx'
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.'
__int_icon: 'icon/HUAWEI CLOUD_gaussdb_influx'
dashboard:

  - desc: 'HUAWEI CLOUD GaussDB-Influx Dashboard'
    path: 'dashboard/zh/HUAWEI CLOUD_gaussdb_influx'

monitor:
  - desc: 'HUAWEI CLOUD GaussDB-Influx Monitor'
    path: 'monitor/zh/HUAWEI CLOUD_gaussdb_influx'

---


<!-- markdownlint-disable MD025 -->
# HUAWEI CLOUD GaussDB-Influx
<!-- markdownlint-enable -->

Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automate)」: All preconditions are installed automatically, Please continue with the script installation.

If you deploy Func yourself, Refer to  [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation script

> Tip：Please prepare HUAWEI CLOUD AK that meets the requirements in advance（For simplicity's sake, You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of  HUAWEI CLOUD GaussDB-Influx cloud resources, we install the corresponding collection script：「Guance Integration（HUAWEI CLOUD-GaussDB-Influx Collect）」(ID：`guance_HUAWEI CLOUDcloud_gaussdb_influx`)

Click 【Install】 and enter the corresponding parameters: HUAWEI CLOUD AK, HUAWEI CLOUD account name.

tap【Deploy startup Script】, The system automatically creates `Startup` script sets, And automatically configure the corresponding startup script.

After the script is installed, Find the script in「Development」in Func「Guance Integration（HUAWEI CLOUD-GaussDB-InfluxCollect）」, Expand to modify this script, find `collector_configs`and`monitor_configs`Edit the content in`region_projects`, Change the locale and Project ID to the actual locale and Project ID, Click Save Publish again.

In addition, the corresponding automatic trigger configuration is displayed in「Management / Crontab Config」. tap【Run】, It can be executed immediately once, without waiting for a periodic time. After a while, you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-ces/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure HUAWEI CLOUD - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [HUAWEI CLOUD Monitor Metrics Details](https://support.huaweicloud.com/intl/en-us/influxug-nosql/nosql_09_0036.html){:target="_blank"}

| **Metric ID**                 | Metric Name               | **Description**                                           | Value Range | Monitored Object                  | Monitoring Period (Raw Data) |
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| `nosql001_cpu_usage`       | CPU Usage                 | CPU usage of the monitored system. Unit: Percent          | 0~100  | GaussDB(for Influx) instance node | 1 minute                     |
| `nosql002_mem_usage`       | Memory Usage              | Memory usage of the monitored system. Unit: Percent       | 0–100       | GaussDB(for Influx) instance node | 1 minute                     |
| `nosql003_bytes_out`       | Network Output Throughput | Outgoing traffic in bytes per second.  Unit: **kbit/s**       | ≥ 0         | GaussDB(for Influx) instance node | 1 minute                     |
| `nosql004_bytes_in`        | Network Input Throughput  | Incoming traffic in bytes per second.  Unit: **kbit/s**       | ≥ 0         | GaussDB(for Influx) instance node | 1 minute                     |
| `nosql005_disk_usage`      | Disk Usage                | Storage space usage of the monitored object.Unit: Percent | 0~100       | GaussDB(for Influx) instance node | 1 minute                     |
| `nosql006_disk_total_size` | Total Storage Space       | Total storage space of the monitored object.  Unit: GB    | ≥ 0         | for Influx) instance node         | 1 minute                     |
| `nosql007_disk_used_size`  | Used Storage Space        | Used storage space of the monitored object.  Unit: GB     | ≥ 0         | GaussDB(for Influx) instance node | 1 minute                     |
| `influxdb001_series_num` | Time Series               | Total number of time series. Unit: count/s                | ≥ 0         | GaussDB(for Influx) instance node | 1 minute                     |
| `influxdb002_query_req_ps` | Query Requests Per Second | Number of query requests per second. Unit: count/s        | ≥ 0         | GaussDB(for Influx) instance node | 1 minute                     |
| `influxdb003_write_req_ps` | Write Requests Per Second | Number of write requests per second. Unit: count/s        | ≥ 0         | GaussDB(for Influx) instance node | 1 minute                     |
| `influxdb004_write_points_ps` | Write Points              | Number of write points per second. Unit: count/s          | ≥ 0         | GaussDB(for Influx) instance node | 1 minute                     |
| `influxdb005_write_concurrency` | Concurrent Write Requests | Number of concurrent write requests. Unit: count/s        | ≥ 0         | GaussDB(for Influx) instance node | 1 minute                     |
| `influxdb006_query_concurrency` | Concurrent Queries        | Number of concurrent query requests. Unit: count/s        | ≥ 0         | GaussDB(for Influx) instance node | 1 minute                     |

## Object {#object}

The collected HUAWEI CLOUD GaussDB-Influx  object data structure can see the object data from 「Infrastructure-Custom」

``` json
{
  "measurement": "HUAWEI CLOUDcloud_gaussdb_nosql",
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
    "backup_strategy" : "{Instance JSON data}",
    "datastore"       : "{Instance JSON data}",
    "groups"          : "[{Instance JSON data}]",
    "time_zone"       : "",
    "message"         : "{Instance JSON data}"
  }
}

```


> *notice：`tags`,`fields`The fields in this section may change with subsequent updates*
>
> Tips 1：`tags.name`The value is the instance ID for unique identification
>
> Tips 2：The following fields are JSON serialized strings
>
> - `fields.message`
> - `fields.backup_strategy`
> - `fields.datastore`
> - `fields.groups`
> - `fields.actions`
