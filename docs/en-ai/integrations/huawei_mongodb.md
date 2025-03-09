---
title: 'Huawei Cloud MongoDB'
tags: 
  - Huawei Cloud
summary: 'Collecting Huawei Cloud MongoDB Metrics data'
__int_icon: 'icon/huawei_mongodb'
dashboard:
  - desc: 'Huawei Cloud MongoDB built-in views'
    path: 'dashboard/en/huawei_mongodb/'

monitor:
  - desc: 'Huawei Cloud MongoDB monitor'
    path: 'monitor/en/huawei_mongodb/'
---


Collecting Huawei Cloud MongoDB Metrics data

## Configuration {#config}

### Installing Func

It is recommended to enable the Guance Integration - Extensions - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with script installation.

If you deploy Func on your own, refer to [Deploying Func](https://func.guance.com/doc/script-market-guance-integration/)

> It is recommended to deploy the GSE version

### Installing Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize Huawei Cloud MongoDB monitoring data, we install the corresponding collection script: "Guance Integration (Huawei Cloud-GaussDB-Mongo)" (ID: `guance_huaweicloud_gaussdb_mongo`).

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script.

After the script is installed, find the script "Guance Integration (Huawei Cloud-GaussDB-Mongo Collection)" under "Development" in Func, expand and modify this script. Edit the contents of `collector_configs` and `monitor_configs` for the `region_projects`, changing the region and Project ID to the actual region and Project ID, then click Save and Publish.

Additionally, view the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short wait, you can check the execution task records and corresponding logs.

### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any abnormalities.
2. On the Guance platform, in "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, in "Metrics", check if the corresponding monitoring data exists.

## Metrics {#metric}

Configure Huawei Cloud MongoDB metrics, which can collect more metrics through configuration [Huawei Cloud MongoDB Metrics Details](https://support.huaweicloud.com/mongoug-nosql/nosql_08_0106.html){:target="_blank"}

| **Metric ID**            |          **Metric Name**   | **Metric Meaning** | **Value Range**      | **Measurement Object** | **Monitoring Period (Original Metric)** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| `nosql001_cpu_usage`            |   CPU Utilization    | This metric collects CPU usage from the system level. Unit: %   | 0~100 %  | GeminiDB Mongo instance node | 1 minute             |
| `nosql002_mem_usage`            |   Memory Utilization   | This metric collects memory usage from the system level. Unit: %  | 0~100 %  | GeminiDB Mongo instance node | 1 minute             |
| `nosql003_bytes_out`            |  Network Output Throughput | Statistics of the average traffic output per second from all network adapters of the measurement object. Unit: bytes/s | ≥ 0 bytes/s    | GeminiDB Mongo instance node | 1 minute       |
| `nosql004_bytes_in`             |  Network Input Throughput | Statistics of the average traffic input per second from all network adapters of the measurement object. Unit: bytes/s | ≥ 0 bytes/s  | GeminiDB Mongo instance node | 1 minute            |
| `nosql005_disk_usage`           |  Storage Capacity Usage Rate | This metric is the storage capacity usage rate. Unit: %   |   0~100 %    | GeminiDB Mongo instance node       | 1 minute                |
| `nosql006_disk_total_size`      |  Total Storage Capacity | This metric is the total storage capacity of the instance. Unit: GB   | ≥ 0 GB | GeminiDB Mongo instance node       | 1 minute                |
| `nosql007_disk_used_size`       |  Used Storage Capacity | This metric is the used storage capacity of the instance. Unit: GB   | ≥ 0 GB | GeminiDB Mongo instance node       | 1 minute                |
| `mongodb001_command_ps`         |  Command Execution Frequency | This metric counts the average number of command statements executed per second on the node. Unit: Counts/s           | ≥ 0 Counts/s | GeminiDB Mongo instance node | 1 minute         |
| `mongodb002_delete_ps`          |  Delete Statement Execution Frequency  | This metric counts the average number of delete statements executed per second on the node. Unit: Counts/s           | ≥ 0 Counts/s | GeminiDB Mongo instance node | 1 minute        |
| `mongodb003_insert_ps`          |  Insert Statement Execution Frequency  | This metric counts the average number of insert statements executed per second on the node. Unit: Counts/s          | ≥ 0 Counts/s | GeminiDB Mongo instance node | 1 minute          |
| `mongodb004_query_ps`           |  Query Statement Execution Frequency   | This metric counts the average number of query statements executed per second on the node. Unit: Counts/s          | ≥ 0 Counts/s   | GeminiDB Mongo instance node | 1 minute        |
| `mongodb005_update_ps`          |  Update Statement Execution Frequency  | This metric counts the average number of update statements executed per second on the node. Unit: Counts/s          | ≥ 0 Counts/s | GeminiDB Mongo instance node | 1 minute          |
| `mongodb006_getmore_ps`         | Getmore Statement Execution Frequency  | This metric counts the average number of getmore statements executed per second on the node. Unit: Counts/s          | ≥ 0 Counts/s | GeminiDB Mongo instance node | 1 minute          |
| `mongodb007_connections_usage`  |  Percentage of Active Connections | This metric counts the percentage of connection attempts to the instance node out of available connections. Unit: %          | 0~100 %      | GeminiDB Mongo instance node | 1 minute          |
| `mongodb008_mem_resident`       |  Resident Memory           | This metric counts the current size of resident memory. Unit: MB            | ≥ 0 MB      | GeminiDB Mongo instance node | 1 minute               |
| `mongodb009_mem_virtual`       |   Virtual Memory           | This metric counts the current size of virtual memory. Unit: MB           | ≥ 0 MB       | GeminiDB Mongo instance node | 1 minute              |
| `mongodb010_regular_asserts_ps` |  Regular Assertion Frequency        | This metric counts the regular assertion frequency. Unit: Counts/s          | ≥ 0 Counts/s       | GeminiDB Mongo instance node | 1 minute         |
| `mongodb011_warning_asserts_ps` |   Warning Frequency           | This metric counts the warning frequency. Unit: Counts/s             | ≥ 0 Counts/s | GeminiDB Mongo instance node      | 1 minute                 |
| `mongodb012_msg_asserts_ps` |       Message Assertion Frequency       | This metric counts the message assertion frequency. Unit: Counts/s          | ≥ 0 Counts/s | GeminiDB Mongo instance node | 1 minute              |
| `mongodb013_user_asserts_ps`     |     User Assertion Frequency    | This metric counts the user assertion frequency. Unit: Counts/s          | ≥ 0 Counts/s | GeminiDB Mongo instance node | 1 minute        |
| `mongodb014_queues_total`    |     Number of Operations Waiting for Lock     | This metric counts the number of operations currently waiting for a lock. Unit: Counts         |   ≥ 0 Counts |  GeminiDB Mongo instance node       | 1 minute                |
| `mongodb015_queues_readers`       |    Number of Operations Waiting for Read Lock    | This metric counts the number of operations currently waiting for a read lock. Unit: Counts               | ≥ 0 Counts   | GeminiDB Mongo instance node  | 1 minute      |
| `mongodb016_queues_writers`     |   Number of Operations Waiting for Write Lock        | This metric counts the number of operations currently waiting for a write lock. Unit: Counts                   | ≥ 0 Counts   | GeminiDB Mongo instance node | 1 minute                    |
| `mongodb017_page_faults`     |   Page Fault Count   | This metric counts the number of page faults on the current node. Unit: Counts             | ≥ 0 Counts   | GeminiDB Mongo instance node | 1 minute                    |
| `mongodb018_porfling_num`        |      Slow Query Count      | This metric counts the number of slow queries on the current node. Unit: Counts          | ≥ 0 Counts   | GeminiDB Mongo instance node | 1 minute                    |
| `mongodb019_cursors_open`       |       Current Open Cursors       | This metric counts the number of open cursors on the current node. Unit: Counts             | ≥ 0 Counts   | GeminiDB Mongo instance node   | 1 minute                    |
| `mongodb020_cursors_timeout`       |    Service Timeout Cursors    | This metric counts the number of service timeout cursors on the current node. Unit: Counts           | ≥ 0 Counts       | GeminiDB Mongo instance node | 1 minute                    |

## Objects {#object}

After data synchronization is normal, you can view the data in the "Infrastructure / Custom (Objects)" section of Guance.

```json
{
  "measurement": "huaweicloud_gaussdb_mongo",
  "tags": {
    "RegionId"          : "cn-south-1",
    "db_user_name"      : "rwuser",
    "engine"            : "rocksDB",
    "instance_id"       : "16b35ebaba1c44c39d9c24bae742ca97in02",
    "instance_name"     : "dds-3ed3",
    "name"              : "16b35ebaba1c44c39d9c24bae742ca97in02",
    "pay_mode"          : "0",
    "port"              : "8635",
    "project_id"        : "756ada1aa17e4049b2a16ea41912e52d",
    "security_group_id" : "7aa51dbf-xxxx-xxxx-xxxx-dad3c4828b58",
    "status"            : "normal",
    "subnet_id"         : "f1df08c5-xxxx-xxxx-xxxx-de435a51007b",
    "vpc_id"            : "674e9b42-xxxx-xxxx-xxxx-5abcc565b961"
  },
  "fields": {
    "actions"         : "[]",
    "create_time"     : "2024-11-09T15:28:46",
    "update_time"     : "2024-11-08T13:21:35",
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
> Tip 1: The value of `tags.name` is the instance ID, used as a unique identifier.
>
> Tip 2:
>
> - `fields.message`
> - `fields.backup_strategy`
> - `fields.datastore`
> - `fields.groups`
> - `fields.actions`