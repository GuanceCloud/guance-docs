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
  - desc: 'Huawei Cloud MongoDB Monitor'
    path: 'monitor/en/huawei_mongodb/'
---


Collecting Huawei Cloud MongoDB Metrics data

## Configuration {#config}

### Installing Func

It is recommended to enable Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/)

> It is recommended to deploy the GSE version.

### Installing Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize Huawei Cloud MongoDB monitoring data, we install the corresponding collection script: "Guance Integration (Huawei Cloud-GaussDB-Mongo)" (ID: `guance_huaweicloud_gaussdb_mongo`)

After clicking 【Install】, input the corresponding parameters: Huawei Cloud AK, Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After the script is installed, find the script "Guance Integration (Huawei Cloud-GaussDB-Mongo Collection)" under "Development" in Func, expand and modify this script. Find `collector_configs` and `monitor_configs`, and edit the content of `region_projects` below. Change the region and Project ID to the actual region and Project ID, then click Save and Publish.

In addition, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.

### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and you can check the corresponding task records and logs for any anomalies.
2. On the Guance platform, in "Infrastructure - Resource Catalog", check if there is asset information.
3. On the Guance platform, in "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}

Configure Huawei Cloud MongoDB Metrics, you can collect more metrics through configuration [Huawei Cloud MongoDB Metrics Details](https://support.huaweicloud.com/mongoug-nosql/nosql_08_0106.html){:target="_blank"}

| **Metric ID**            |          **Metric Name**   | **Metric Meaning** | **Value Range**      | **Measurement Object** | **Monitoring Cycle (Raw Metric)** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| `nosql001_cpu_usage`            |   CPU Utilization    | This metric collects CPU usage from the system level. Unit: %   | 0~100 %  | GeminiDB Mongo instance nodes | 1 minute             |
| `nosql002_mem_usage`            |   Memory Utilization   | This metric collects memory usage from the system level. Unit: %  | 0~100 %  | GeminiDB Mongo instance nodes | 1 minute             |
| `nosql003_bytes_out`            |  Network Output Throughput | Statistics of average traffic output per second from all network adapters of the measurement object. Unit: bytes/s | ≥ 0 bytes/s    | GeminiDB Mongo instance nodes | 1 minute       |
| `nosql004_bytes_in`             |  Network Input Throughput | Statistics of average traffic input per second from all network adapters of the measurement object. Unit: bytes/s | ≥ 0 bytes/s  | GeminiDB Mongo instance nodes | 1 minute            |
| `nosql005_disk_usage`           |  Storage Capacity Usage Rate | This metric represents the storage capacity usage rate. Unit: %   |   0~100 %    | GeminiDB Mongo instance nodes       | 1 minute                |
| `nosql006_disk_total_size`      |  Total Storage Capacity | This metric represents the total storage capacity of the instance. Unit: GB   | ≥ 0 GB | GeminiDB Mongo instance nodes       | 1 minute                |
| `nosql007_disk_used_size`       |  Used Storage Capacity | This metric represents the used storage capacity of the instance. Unit: GB   | ≥ 0 GB | GeminiDB Mongo instance nodes       | 1 minute                |
| `mongodb001_command_ps`         |  command Execution Frequency | This metric counts the average number of times the command statement is executed on the node per second. Unit: Counts/s           | ≥ 0 Counts/s | GeminiDB Mongo instance nodes | 1 minute         |
| `mongodb002_delete_ps`          |  delete Statement Execution Frequency  | This metric counts the average number of times the delete statement is executed on the node per second. Unit: Counts/s           | ≥ 0 Counts/s | GeminiDB Mongo instance nodes | 1 minute        |
| `mongodb003_insert_ps`          |  insert Statement Execution Frequency  | This metric counts the average number of times the insert statement is executed on the node per second. Unit: Counts/s          | ≥ 0 Counts/s | GeminiDB Mongo instance nodes | 1 minute          |
| `mongodb004_query_ps`           |  query Statement Execution Frequency   | This metric counts the average number of times the query statement is executed on the node per second. Unit: Counts/s          | ≥ 0 Counts/s   | GeminiDB Mongo instance nodes | 1 minute        |
| `mongodb005_update_ps`          |  update Statement Execution Frequency  | This metric counts the average number of times the update statement is executed on the node per second. Unit: Counts/s          | ≥ 0 Counts/s | GeminiDB Mongo instance nodes | 1 minute          |
| `mongodb006_getmore_ps`         | getmore Statement Execution Frequency  | This metric counts the average number of times the getmore statement is executed on the node per second. Unit: Counts/s          | ≥ 0 Counts/s | GeminiDB Mongo instance nodes | 1 minute          |
| `mongodb007_connections_usage`  |  Percentage of Current Active Connections | This metric counts the percentage of connection attempts to the instance node out of available connections. Unit: %          | 0~100 %      | GeminiDB Mongo instance nodes | 1 minute          |
| `mongodb008_mem_resident`       |  Resident Memory           | This metric counts the current size of resident memory. Unit: MB            | ≥ 0 MB      | GeminiDB Mongo instance nodes | 1 minute               |
| `mongodb009_mem_virtual`       |   Virtual Memory           | This metric counts the current size of virtual memory. Unit: MB           | ≥ 0 MB       | GeminiDB Mongo instance nodes | 1 minute              |
| `mongodb010_regular_asserts_ps` |  Regular Assertion Frequency        | This metric counts the regular assertion frequency. Unit: Counts/s          | ≥ 0 Counts/s       | GeminiDB Mongo instance nodes | 1 minute         |
| `mongodb011_warning_asserts_ps` |   Warning Frequency           | This metric counts the warning frequency. Unit: Counts/s             | ≥ 0 Counts/s | GeminiDB Mongo instance nodes      | 1 minute                 |
| `mongodb012_msg_asserts_ps` |       Message Assertion Frequency       | This metric counts the message assertion frequency. Unit: Counts/s          | ≥ 0 Counts/s | GeminiDB Mongo instance nodes | 1 minute              |
| `mongodb013_user_asserts_ps`     |     User Assertion Frequency    | This metric counts the user assertion frequency. Unit: Counts/s          | ≥ 0 Counts/s | Nodes of GeminiDB Mongo instance nodes | 1 minute        |
| `mongodb014_queues_total`    |     Number of Operations Waiting for Locks     | This metric counts the current number of operations waiting for locks. Unit: Counts         |   ≥ 0 Counts |  GeminiDB Mongo instance nodes       | 1 minute                |
| `mongodb015_queues_readers`       |    Number of Operations Waiting for Read Locks    | This metric counts the current number of operations waiting for read locks. Unit: Counts               | ≥ 0 Counts   | GeminiDB Mongo instance nodes  | 1 minute      |
| `mongodb016_queues_writers`     |   Number of Operations Waiting for Write Locks        | This metric counts the current number of operations waiting for write locks. Unit: Counts                   | ≥ 0 Counts   | GeminiDB Mongo instance nodes | 1 minute                    |
| `mongodb017_page_faults`     |   Page Faults   | This metric counts the current page faults on the node. Unit: Counts             | ≥ 0 Counts   | GeminiDB Mongo instance nodes | 1 minute                    |
| `mongodb018_porfling_num`        |      Slow Queries      | This metric counts the current slow queries on the node. Unit: Counts          | ≥ 0 Counts   | GeminiDB Mongo instance nodes | 1 minute                    |
| `mongodb019_cursors_open`       |       Currently Maintained Cursors       | This metric counts the maintained cursors on the current node. Unit: Counts             | ≥ 0 Counts   | GeminiDB Mongo instance nodes   | 1 minute                    |
| `mongodb020_cursors_timeout`       |    Service Timeout Cursors    | This metric counts the service timeout cursors on the current node. Unit: Counts           | ≥ 0 Counts       | GeminiDB Mongo instance nodes | 1 minute                    |

## Objects {#object}

After data synchronization is normal, you can view the data in the "Infrastructure - Resource Catalog" of Guance.

```json
{
  "measurement": "huaweicloud_gaussdb_mongo",
  "tags": {
    "RegionId"             : "cn-south-1",
    "project_id"           : "756ada1aa17e4049b2a16ea41912e52d",
    "instance_id"          : "16b35ebaba1c44c39d9c24bae742ca97in02",
    "enterprise_project_id": "0824ss-xxxx-xxxx-xxxx-12334fedffg",
    "instance_name"        : "dds-3ed3",
    "status"               : "normal",
    "engine"               : "rocksDB"
  },
  "fields": {
    "port"              : "8635", 
    "db_user_name"      : "rwuser",
    "vpc_id"            : "674e9b42-xxxx-xxxx-xxxx-5abcc565b961",
    "subnet_id"         : "f1df08c5-xxxx-xxxx-xxxx-de435a51007b",
    "security_group_id" : "7aa51dbf-xxxx-xxxx-xxxx-dad3c4828b58",
    "pay_mode"          : "0",
    "create_time"       : "2024-11-09T15:28:46",
    "update_time"       : "2024-11-08T13:21:35",
    "backup_strategy"   : "{Instance JSON data}",
    "datastore"         : "{Instance JSON data}",
    "groups"            : "[{Instance JSON data}]",
    "time_zone"         : "xxxx",
    "message"           : "{Instance JSON data}"
  }
}
```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.instance_id` is the instance ID, used as a unique identifier.
>
> Tip 2:
>
> - `fields.message`
> - `fields.backup_strategy`
> - `fields.datastore`
> - `fields.groups`
> - `fields.actions`