---
title: 'Huawei Cloud GaussDB-Cassandra'
tags: 
  - Huawei Cloud
summary: 'The displayed metrics for Huawei Cloud GaussDB-Cassandra include read/write throughput, latency, data consistency, and scalability. These metrics reflect the performance and reliability of GaussDB-Cassandra in handling large-scale distributed data storage and access.'
__int_icon: 'icon/huawei_gaussdb_cassandra'
dashboard:

  - desc: 'Built-in views for Huawei Cloud GaussDB-Cassandra'
    path: 'dashboard/en/huawei_gaussdb_cassandra'

monitor:
  - desc: 'Monitors for Huawei Cloud GaussDB-Cassandra'
    path: 'monitor/en/huawei_gaussdb_cassandra'

---


<!-- markdownlint-disable MD025 -->
# Huawei Cloud GaussDB-Cassandra
<!-- markdownlint-enable -->

The displayed metrics for Huawei Cloud GaussDB-Cassandra include read/write throughput, latency, data consistency, and scalability. These metrics reflect the performance and reliability of GaussDB-Cassandra in handling large-scale distributed data storage and access.


## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - Extension - DataFlux Func (Automata): All prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data from Huawei Cloud DIS, we install the corresponding collection script: 「Guance Integration (Huawei Cloud-GaussDB-Cassandra Collection)」(ID: `guance_huaweicloud_gaussdb_cassandra`)

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once the script is installed, find the script 「Guance Integration (Huawei Cloud-GaussDB-Cassandra Collection)」 under "Development" in Func, expand and modify this script. Find `collector_configs` and `monitor_configs`, and edit the content under `region_projects`. Change the region and Project ID to the actual ones, then click Save and Publish.

Additionally, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short wait, you can view the task execution records and corresponding logs.

By default, we collect some configurations; for details, see [Configuration of Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-ces/){:target="_blank"}


### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm whether the corresponding tasks have the automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, in 「Infrastructure / Custom」, check if asset information exists.
3. On the Guance platform, in 「Metrics」, check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Huawei Cloud Cloud Monitoring, the default metric set is as follows. You can collect more metrics by configuration [Details of Huawei Cloud Cloud Monitoring Metrics](https://support.huaweicloud.com/cassandraug-nosql/nosql_03_0011.html){:target="_blank"}

| Metric ID                                | Metric Name             | Metric Meaning                                                     | Value Range      | Measurement Object | Monitoring Period (Original Metric)|
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| `cassandra001_cpu_usage`       | CPU Utilization      | This metric represents the CPU usage collected at the system level. Unit: %                  | 0~100 %  | Node of GaussDB(for Cassandra) instance | 1 minute                                             |
| `cassandra002_mem_usage`       | Memory Utilization     | This metric represents the memory usage collected at the system level. Unit: %                 | 0~100 %  | Node of GaussDB(for Cassandra) instance | 1 minute                |
| `cassandra003_bytes_out`       | Network Output Throughput | Statistics of the average traffic output from all network adapters of the measurement object per second. Unit: kb/s | ≥ 0 kb/s | Node of GaussDB(for Cassandra) instance | 1 minute                |
| `cassandra004_bytes_in`    | Network Input Throughput | Statistics of the average traffic input to all network adapters of the measurement object per second. Unit: kb/s | ≥ 0 kb/s | Node of GaussDB(for Cassandra) instance | 1 minute                |
| `nosql005_disk_usage`      | Disk Utilization     | This metric is used to statistically measure the disk utilization. Unit: %                 | 0~100 %  | Node of GaussDB(for Cassandra) instance | 1 minute                |
| `nosql006_disk_total_size` | Total Disk Size     | This metric is used to statistically measure the total disk size. Unit: GB                | ≥ 0 GB   | Node of GaussDB(for Cassandra) instance | 1 minute                |
| `nosql007_disk_used_size`  | Used Disk Size     | This metric is used to statistically measure the total used disk size. Unit: GB          | ≥ 0 GB   | Node of GaussDB(for Cassandra) instance | 1 minute                |
| `cassandra014_connections` | Active Connections | This metric counts the number of active connections on the current Cassandra instance node. Unit: Counts | ≥ 0 Counts | Node of GaussDB(for Cassandra) instance | 1 minute |
| `cassandra015_read_latency` | Queries Per Second | This metric measures the average response time of database read requests. Unit: ms | ≥ 0 ms | Node of GaussDB(for Cassandra) instance | 1 minute |
| `cassandra016_write_latency` | Writes Per Second | This metric measures the average response time of database write requests. Unit: ms | ≥ 0 ms | Node of GaussDB(for Cassandra) instance | 1 minute |
| `cassandra037_pending_write` | Pending Write Tasks | Describes the number of write tasks currently queued. Unit: Counts | ≥ 0 Counts | Node of GaussDB(for Cassandra) instance | 1 minute |
| `cassandra038_pending_read` | Pending Read Tasks | Describes the number of read tasks currently queued. Unit: Counts | ≥ 0 Counts | Node of GaussDB(for Cassandra) instance | 1 minute |

## Objects {#object}

The structure of the collected Huawei Cloud GaussDB-Cassandra object data can be viewed in 「Infrastructure - Custom」

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
    "backup_strategy" : "{Instance JSON data}",
    "datastore"       : "{Instance JSON data}",
    "groups"          : "[{Instance JSON data}]",
    "time_zone"       : "",
    "message"         : "{Instance JSON data}"
  }
}

```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, serving as a unique identifier.
>
> Tip 2: The following fields are serialized JSON strings:
>
> - `fields.message`
> - `fields.backup_strategy`
> - `fields.datastore`
> - `fields.groups`
> - `fields.actions`