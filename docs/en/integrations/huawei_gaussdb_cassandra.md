---
title: 'Huawei Cloud GaussDB-Cassandra'
tags: 
  - Huawei Cloud
summary: 'The displayed Metrics for Huawei Cloud GaussDB-Cassandra include read/write throughput, latency, data consistency, and scalability. These Metrics reflect the performance and reliability of GaussDB-Cassandra when handling large-scale distributed data storage and access.'
__int_icon: 'icon/huawei_gaussdb_cassandra'
dashboard:

  - desc: 'Huawei Cloud GaussDB-Cassandra built-in views'
    path: 'dashboard/en/huawei_gaussdb_cassandra'

monitor:
  - desc: 'Huawei Cloud GaussDB-Cassandra monitors'
    path: 'monitor/en/huawei_gaussdb_cassandra'

---


<!-- markdownlint-disable MD025 -->
# Huawei Cloud GaussDB-Cassandra
<!-- markdownlint-enable -->

The displayed Metrics for Huawei Cloud GaussDB-Cassandra include read/write throughput, latency, data consistency, and scalability. These Metrics reflect the performance and reliability of GaussDB-Cassandra when handling large-scale distributed data storage and access.


## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare the required Huawei Cloud AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data from Huawei Cloud DIS, we install the corresponding collection script: 「<<< custom_key.brand_name >>> Integration (Huawei Cloud-GaussDB-Cassandra Collection)」(ID: `guance_huaweicloud_gaussdb_cassandra`)

After clicking 【Install】, input the corresponding parameters: Huawei Cloud AK, Huawei Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After the script is installed, find the script 「<<< custom_key.brand_name >>> Integration (Huawei Cloud-GaussDB-Cassandra Collection)」in the "Development" section of Func, expand and modify this script. Find `collector_configs` and `monitor_configs` respectively, edit the content of `region_projects`, change the region and Project ID to the actual region and Project ID, then click Save and Publish.

In addition, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to immediately execute it once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

We default collect some configurations, for details see the Metrics section [Customize Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-huaweicloud-ces/){:target="_blank"}


### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm whether the corresponding task has an automatic trigger configuration, and you can also check the corresponding task records and logs for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, under 「Infrastructure / Custom」, check if there is any asset information.
3. On the <<< custom_key.brand_name >>> platform, under 「Metrics」, check if there is any corresponding monitoring data.

## Metrics {#metric}
After configuring Huawei Cloud - Cloud Monitoring, the default Measurement set is as follows. You can collect more Metrics through configuration [Huawei Cloud Cloud Monitoring Metric Details](https://support.huaweicloud.com/cassandraug-nosql/nosql_03_0011.html){:target="_blank"}

| Metric ID                                | Metric Name             | Metric Meaning                                                     | Value Range      | Measurement Object | Monitoring Period (Original Metric)|
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| `cassandra001_cpu_usage`       | CPU Utilization      | This Metric collects the CPU usage rate at the system level. Unit: %                  | 0~100 %  | Nodes of GaussDB(for Cassandra) instance | 1 minute                                             |
| `cassandra002_mem_usage`       | Memory Utilization     | This Metric collects the memory usage rate at the system level. Unit: %                 | 0~100 %  | Nodes of GaussDB(for Cassandra) instance | 1 minute                |
| `cassandra003_bytes_out`       | Network Output Throughput | It counts the average traffic output per second from all network adapters of the measurement object. Unit: kb/s | ≥ 0 kb/s | Nodes of GaussDB(for Cassandra) instance | 1 minute                |
| `cassandra004_bytes_in`    | Network Input Throughput | It counts the average traffic input per second from all network adapters of the measurement object. Unit: kb/s | ≥ 0 kb/s | Nodes of GaussDB(for Cassandra) instance | 1 minute                |
| `nosql005_disk_usage`      | Disk Utilization     | This Metric counts the disk utilization of the measurement object. Unit: %                 | 0~100 %  | Nodes of GaussDB(for Cassandra) instance | 1 minute                |
| `nosql006_disk_total_size` | Total Disk Size     | This Metric counts the total disk size of the measurement object. Unit: GB                | ≥ 0 GB   | Nodes of GaussDB(for Cassandra) instance | 1 minute                |
| `nosql007_disk_used_size`  | Used Disk Size     | This Metric counts the total used disk size of the measurement object. Unit: GB          | ≥ 0 GB   | Nodes of GaussDB(for Cassandra) instance | 1 minute                |
| `cassandra014_connections` | Active Connections | This Metric counts the active connections of the current Cassandra instance node. Unit: Counts | ≥ 0 Counts | Nodes of GaussDB(for Cassandra) instance | 1 minute |
| `cassandra015_read_latency` | Queries Per Second | This Metric counts the average response time for database read requests. Unit: ms | ≥ 0 ms | Nodes of GaussDB(for Cassandra) instance | 1 minute |
| `cassandra016_write_latency` | Writes Per Second | This Metric counts the average response time for database write requests. Unit: ms | ≥ 0 ms | Nodes of GaussDB(for Cassandra) instance | 1 minute |
| `cassandra037_pending_write` | Pending Write Tasks | Describes the number of queued pending write tasks. Unit: Counts | ≥ 0 Counts | Nodes of GaussDB(for Cassandra) instance | 1 minute |
| `cassandra038_pending_read` | Pending Read Tasks | Describes the number of queued pending read tasks. Unit: Counts | ≥ 0 Counts | Nodes of GaussDB(for Cassandra) instance | 1 minute |

## Objects {#object}

The collected Huawei Cloud GaussDB-Cassandra object data structure can be viewed in the "Infrastructure - Custom" section.

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
> Tip 1: The value of `tags.name` is the Instance ID, which serves as a unique identifier.
>
> Tip 2: The following fields are serialized JSON strings:
>
> - `fields.message`
> - `fields.backup_strategy`
> - `fields.datastore`
> - `fields.groups`
> - `fields.actions`