---
title: 'Huawei Cloud GaussDB-Cassandra'
tags: 
  - Huawei Cloud
summary: 'The displayed metrics for Huawei Cloud GaussDB-Cassandra include read/write throughput, latency, data consistency, and scalability. These metrics reflect the performance and reliability of GaussDB-Cassandra in handling large-scale distributed data storage and access.'
__int_icon: 'icon/huawei_gaussdb_cassandra'
dashboard:

  - desc: 'Built-in Views for Huawei Cloud GaussDB-Cassandra'
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

We recommend enabling Guance Integration - Extensions - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

To synchronize monitoring data from Huawei Cloud DIS, we install the corresponding collection script: 「Guance Integration (Huawei Cloud-GaussDB-Cassandra Collection)」(ID: `guance_huaweicloud_gaussdb_cassandra`)

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK, Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once the script is installed, find the script 「Guance Integration (Huawei Cloud-GaussDB-Cassandra Collection)」 under 「Development」 in Func, expand and modify this script. Find `collector_configs` and `monitor_configs`, and edit the content of `region_projects` below, changing the region and Project ID to the actual region and Project ID, then click Save and Publish.

Additionally, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】 to run it immediately without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.

By default, we collect some configurations; for details, see [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-huaweicloud-ces/){:target="_blank"}


### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and check the task records and logs for any anomalies.
2. On the Guance platform, go to 「Infrastructure / Custom」 to check if asset information exists.
3. On the Guance platform, go to 「Metrics」 to check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Huawei Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration [Huawei Cloud Monitoring Metric Details](https://support.huaweicloud.com/cassandraug-nosql/nosql_03_0011.html){:target="_blank"}

| Metric ID                                | Metric Name             | Metric Description                                                     | Value Range      | Measurement Object | Monitoring Period (Original Metric)|
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| `cassandra001_cpu_usage`       | CPU Utilization      | This metric collects CPU usage at the system level. Unit: %                  | 0~100 %  | GaussDB(for Cassandra) instance node | 1 minute                                             |
| `cassandra002_mem_usage`       | Memory Utilization     | This metric collects memory usage at the system level. Unit: %                 | 0~100 %  | GaussDB(for Cassandra) instance node | 1 minute                |
| `cassandra003_bytes_out`       | Network Output Throughput | Statistics on average traffic output per second from all network adapters of the measurement object. Unit: kb/s | ≥ 0 kb/s | GaussDB(for Cassandra) instance node | 1 minute                |
| `cassandra004_bytes_in`    | Network Input Throughput | Statistics on average traffic input per second from all network adapters of the measurement object. Unit: kb/s | ≥ 0 kb/s | GaussDB(for Cassandra) instance node | 1 minute                |
| `nosql005_disk_usage`      | Disk Utilization     | This metric statistics disk utilization of the measurement object. Unit: %                 | 0~100 %  | GaussDB(for Cassandra) instance node | 1 minute                |
| `nosql006_disk_total_size` | Total Disk Size     | This metric statistics total disk size of the measurement object. Unit: GB                | ≥ 0 GB   | GaussDB(for Cassandra) instance node | 1 minute                |
| `nosql007_disk_used_size`  | Disk Used Size     | This metric statistics total used disk size of the measurement object. Unit: GB          | ≥ 0 GB   | GaussDB(for Cassandra) instance node | 1 minute                |
| `cassandra014_connections` | Active Connections | This metric statistics current active connections of the Cassandra instance node. Unit: Counts | ≥ 0 Counts | GaussDB(for Cassandra) instance node | 1 minute |
| `cassandra015_read_latency` | Read Latency | This metric statistics average time spent on database read requests. Unit: ms | ≥ 0 ms | GaussDB(for Cassandra) instance node | 1 minute |
| `cassandra016_write_latency` | Write Latency | This metric statistics average time spent on database write requests. Unit: ms | ≥ 0 ms | GaussDB(for Cassandra) instance node | 1 minute |
| `cassandra037_pending_write` | Pending Write Tasks | Describes the number of pending write tasks currently queued. Unit: Counts | ≥ 0 Counts | GaussDB(for Cassandra) instance node | 1 minute |
| `cassandra038_pending_read` | Pending Read Tasks | Describes the number of pending read tasks currently queued. Unit: Counts | ≥ 0 Counts | GaussDB(for Cassandra) instance node | 1 minute |

## Objects {#object}

The collected Huawei Cloud GaussDB-Cassandra object data structure can be viewed in 「Infrastructure - Custom」

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
> Tip 1: The value of `tags.name` is the instance ID, used as a unique identifier.
>
> Tip 2: The following fields are serialized JSON strings:
>
> - `fields.message`
> - `fields.backup_strategy`
> - `fields.datastore`
> - `fields.groups`
> - `fields.actions`
