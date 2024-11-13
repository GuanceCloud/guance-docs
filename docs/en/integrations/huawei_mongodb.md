---
title: 'Huawei Cloud MongoDB'
tags: 
  - Huawei Cloud
summary: 'Collect Huawei Cloud MongoDB metric data'
__int_icon: 'icon/huawei_mongodb'
dashboard:

  - desc: 'Huawei Cloud MongoDB Monitoring View'
    path: 'dashboard/en/huawei_mongodb'

monitor:
  - desc: 'Huawei Cloud MongoDB Monitor'
    path: 'monitor/en/huawei_mongodb'
---

Collect Huawei Cloud MongoDB metric data.

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically,Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip: Please prepare HUAWEI CLOUD AK that meets the requirements in advance（For simplicity's sake,You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of  HUAWEI CLOUD MongoDB cloud resources, we install the corresponding collection script: 「Guance Integration（HUAWEI CLOUD-GaussDB-Mongo Collect）」(ID：`guance_huaweicloud_gaussdb_mongo`)

Click  [Install] and enter the corresponding parameters: HUAWEI CLOUD AK, HUAWEI CLOUD account name.

Tap [Deploy startup Script],The system automatically creates Startup script sets,And automatically configure the corresponding startup script.

After the script is installed,Find the script in「Development」in Func「Guance Integration（HUAWEI CLOUD-GaussDB-Mongo Collect）」,Expand to modify this script,find collector_configs and monitor_configs. Edit the content inregion_projects,Change the locale and Project ID to the actual locale and Project ID,Click Save Publish again.

In addition, in「Management / Automatic Trigger Configuration」 you can see the corresponding automatic trigger configuration. Click 【Execute】 to run it immediately, without waiting for the scheduled time. After a short moment, you can check the execution task records and corresponding logs.

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist.
2. On Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists.
3. On Guance platform, press 「Metrics」 to check whether monitoring data exists.

## Metric {#metric}

Configure HUAWEI CLOUD MongoDB metric. You can collect more metrics by configuring them [HUAWEI CLOUD MongoDB Metrics Details](https://support.huaweicloud.com/mongoug-nosql/nosql_08_0106.html){:target="_blank"}

| **MetricID**            |          **Metric Name**   | **Metric Meaning** | **Value Range**      | **Measured Object** | **Monitoring Period (Raw Metric)** |
| ------------------------------------------ | --------------------------------------- | ------------------------------------------------------------ | -------------------|------------------ | -------------------- |
| `nosql001_cpu_usage` |   CPU Utilization   | This metric is the CPU usage rate collected from the system level. Unit: %   | 0~100 %  | GeminiDB Mongo instance nodes   | 1 minute |
| `nosql002_mem_usage` |   Memory Utilization| This metric is the memory usage rate collected from the system level. Unit: %   | 0~100 %  | GeminiDB Mongo instance nodes  | 1 minute  |
|`nosql003_bytes_out`|Network Output Throughput| This metric is the average traffic output from all network adapters of the measurement object per second. Unit: bytes/s| ≥ 0 bytes/s| GeminiDB Mongo instance nodes| 1 minute|
| `nosql004_bytes_in`  |  Network Input Throughput  | This metric is the average traffic input from all network adapters of the measurement object per second. Unit: bytes/s | ≥ 0 bytes/s|GeminiDB Mongo instance nodes|1 minute|
| `nosql005_disk_usage`   |  Storage Capacity Usage Rate  | This metric is the storage capacity usage rate. Unit: %|   0~100 %| GeminiDB Mongo instance nodes| 1 minute |
| `nosql006_disk_total_size`  |  Storage Capacity Total Capacity  | This metric is the total capacity of the instance's storage capacity. Unit: GB   | ≥ 0 GB | GeminiDB Mongo instance nodes| 1 minute |
| `nosql007_disk_used_size`   |  Storage Capacity Usage  | This metric is the usage of the instance's storage capacity. Unit: GB   | ≥ 0 GB | GeminiDB Mongo instance nodes| 1 minute |
| `mongodb001_command_ps` |  Command Execution Frequency  | This metric is used to count the average number of command statements executed per second on the node. Unit: Counts/s | ≥ 0 Counts/s | GeminiDB Mongo instance nodes  | 1 minute |
| `mongodb002_delete_ps`  |  Delete Statement Execution Frequency   | This metric is used to count the average number of delete statements executed per second on the node. Unit: Counts/s | ≥ 0 Counts/s | GeminiDB Mongo instance nodes  | 1 minute|
| `mongodb003_insert_ps`  |  Insert Statement Execution Frequency   | This metric is used to count the average number of insert statements executed per second on the node. Unit: Counts/s   | ≥ 0 Counts/s | GeminiDB Mongo instance nodes  | 1 minute  |
| `mongodb004_query_ps`   |  Query Statement Execution Frequency| This metric is used to count the average number of query statements executed per second on the node. Unit: Counts/s   | ≥ 0 Counts/s   | GeminiDB Mongo instance nodes  | 1 minute|
| `mongodb005_update_ps`  |  Update Statement Execution Frequency   | This metric is used to count the average number of update statements executed per second on the node. Unit: Counts/s   | ≥ 0 Counts/s | GeminiDB Mongo instance nodes  | 1 minute  |
| `mongodb006_getmore_ps` | Getmore Statement Execution Frequency   | This metric is used to count the average number of getmore statements executed per second on the node. Unit: Counts/s   | ≥ 0 Counts/s | GeminiDB Mongo instance nodes  | 1 minute  |
| `mongodb007_connections_usage`  |  Current Active Connection Percentage  | This metric is used to count the percentage of connection attempts to the instance node's available connections. Unit: %   | 0~100 %  | GeminiDB Mongo instance nodes  | 1 minute  |
| `mongodb008_mem_resident`   |  Resident Memory | This metric is used to count the current size of resident memory. Unit: MB  | ≥ 0 MB  | GeminiDB Mongo instance nodes  | 1 minute|
| `mongodb009_mem_virtual`   |   Virtual Memory | This metric is used to count the current size of virtual memory. Unit: MB | ≥ 0 MB   | GeminiDB Mongo instance nodes  | 1 minute   |
| `mongodb010_regular_asserts_ps` |  Regular Assertion Frequency | This metric is used to count the regular assertion frequency. Unit: Counts/s   | ≥ 0 Counts/s   | GeminiDB Mongo instance nodes  | 1 minute |
| `mongodb011_warning_asserts_ps` |   Warning Frequency | This metric is used to count the warning frequency. Unit: Counts/s  | ≥ 0 Counts/s | GeminiDB Mongo instance nodes   | 1 minute  |
| `mongodb012_msg_asserts_ps` |   Message Assertion Frequency| This metric is used to count the message assertion frequency. Unit: Counts/s  | ≥ 0 Counts/s | GeminiDB Mongo instance nodes  | 1 minute   |
| `mongodb013_user_asserts_ps` | User Assertion Frequency | This metric is used to count the user assertion frequency. Unit: Counts/s  | ≥ 0 Counts/s | GeminiDB Mongo instance nodes  | 1 minute|
| `mongodb014_queues_total`| Number of Operations Waiting for Lock  | This metric is used to count the current number of operations waiting for a lock. Unit: Counts  |   ≥ 0 Counts |  GeminiDB Mongo instance nodes| 1 minute |
|`mongodb015_queues_readers`|Number of Operations Waiting for Read Lock | This metric is used to count the current number of operations waiting for a read lock. Unit: Counts | ≥ 0 Counts   | GeminiDB Mongo instance nodes   | 1 minute  |
| `mongodb016_queues_writers` |   Number of Operations Waiting for Write Lock | This metric is used to count the current number of operations waiting for a write lock. Unit: Counts | ≥ 0 Counts   | GeminiDB Mongo instance nodes  | 1 minute |
| `mongodb017_page_faults` |   Number of Page Faults| This metric is used to count the current number of page faults on the node. Unit: Counts   | ≥ 0 Counts   | GeminiDB Mongo instance nodes  | 1 minute |
| `mongodb018_porfling_num`|  Slow query count  | This indicator is used to count the number of slow queries on the current node. Unit: Counts  | ≥ 0 Counts   | GeminiDB Mongo instance nodes  | 1 minute |
| `mongodb019_cursors_open`   |   Current number of cursor maintenance   | This indicator is used to count the number of maintenance pointers on the current node. Unit: Counts  | ≥ 0 Counts   | GeminiDB Mongo instance nodes| 1 minute |
| `mongodb020_cursors_timeout`   |Service timeout cursor count| This indicator is used to count the number of service timeout pointers on the current node. Unit: Counts   | ≥ 0 Counts   | GeminiDB Mongo instance nodes  | 1 minute |

## Object {#object}

The collected HUAWEI CLOUD ELB object data structure can see the object data from 「Infrastructure-custom-defined」

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
    "backup_strategy" : "{Instance JSON data}",
    "datastore"       : "{Instance JSON data}",
    "groups"          : "[{Instance JSON data}]",
    "time_zone"       : "",
    "message"         : "{Instance JSON data}"
  }
}
```

> *notice：`tags`、`fields`The fields in this section may change with subsequent updates*
>
> Tips 1：`tags.name`The value is the instance ID for unique identification
>
> Tips 2：
>
> - `fields.message`
> - `fields.backup_strategy`
> - `fields.datastore`
> - `fields.groups`
> - `fields.actions`
