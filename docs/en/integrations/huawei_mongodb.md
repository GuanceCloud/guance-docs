---
title: 'HUAWEI MongoDB'
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.'
__int_icon: 'icon/huawei_mongodb'
dashboard:
  - desc: 'HUAWEI CLOUD MongoDB Monitoring View'
    path: 'dashboard/zh/huawei_mongodb/'

monitor:
  - desc: 'HUAWEI CLOUD MongoDB Monitor'
    path: 'monitor/zh/huawei_mongodb/'
---


<!-- markdownlint-disable MD025 -->
# HUAWEI CLOUD MongoDB
<!-- markdownlint-enable -->

Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to  [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> Recommended deployment of GSE version

### Installation script

> Tip：Please prepare HUAWEI CLOUD AK that meets the requirements in advance（For simplicity's sake, you can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of  HUAWEI CLOUD MongoDB cloud resources, we install the corresponding collection script：「Guance Integration（HUAWEI CLOUD-MongoDB）」(ID：guance_huaweicloud_gaussdb_mongo)

Click 【Install】 and enter the corresponding parameters: HUAWEI CLOUD AK, HUAWEI CLOUD account name.

Tap【Deploy startup Script】, the system automatically creates `Startup` script sets, and automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」.Click【Run】, you can immediately execute once, without waiting for a regular time.After a while, you can view task execution records and corresponding logs.

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column
[Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-gaussdb-nosql/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure HUAWEI CLOUD - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them  [HUAWEI CLOUD Monitor Metrics Details](https://support.huaweicloud.com/mongoug-nosql/nosql_08_0106.html){:target="_blank"}

| **MetricID**            |          **Metric Name**   | **Metric Meaning** | **Value Range**      | **Measured Object** | **Monitoring Period (Raw Metric)** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| nosql001_cpu_usage            | CPU Utilization | This metric represents the CPU utilization collected from the system level. Unit：% | 0~100 %      | GaussDB(for Mongo) Nodes of the instance | 1 Min               |
| nosql002_mem_usage            |      Memory Utilization      | This metric represents the memory utilization collected from the system level. Unit：% | 0~100 %      | GaussDB(for Mongo) Nodes of the instance | 1 Min               |
| nosql003_bytes_out            |    Network Out Throughput    | This metric calculates the average amount of network traffic output from all network adapters of the measurement object per second. Unit：bytes/s | ≥ 0 bytes/s  | GaussDB(for Mongo) Nodes of the instance | 1 Min               |
| nosql004_bytes_in             |    Network In Throughput    | This metric calculates the average amount of network traffic input into all network adapters of the measurement object per second. Unit：bytes/s | ≥ 0 bytes/s  | GaussDB(for Mongo) Nodes of the instance | 1 Min               |
| nosql005_disk_usage           |      Disk Utilization      | This metric is used to measure the disk utilization of the measurement object. Unit：% | 0~100 %      | GaussDB(for Mongo)Instance       | 1 Min               |
| nosql006_disk_total_size      |      Total Disk Size      | This metric is used to measure the total disk size of the measurement object. Unit：GB | ≥ 0 GB       | GaussDB(for Mongo)Instance       | 1 Min               |
| nosql007_disk_used_size       |      Disk Usage      | This metric is used to measure the total used disk size of the measurement object. Unit：GB | ≥ 0 GB       | GaussDB(for Mongo)Instance       | 1 Min               |
| mongodb001_command_ps         |   command Execution Frequency   | This metric is used to measure the average number of command statements executed per second on the node. Unit：Counts/s | ≥ 0 Counts/s | GaussDB(for Mongo) Nodes of the instance | 1 Min               |
| mongodb002_delete_ps          |  delete Statement Execution Frequency  | This metric is used to measure the average number of "DELETE" statements executed per second on the node. Unit：Counts/s | ≥ 0 Counts/s | GaussDB(for Mongo) Nodes of the instance | 1 Min               |
| mongodb003_insert_ps          |  insert Statement Execution Frequency  | This metric is used to measure the average number of "INSERT" statements executed per second on the node. Unit：Counts/s | ≥ 0 Counts/s | GaussDB(for Mongo) Nodes of the instance | 1 Min               |
| mongodb004_query_ps           | query Statement Execution Frequency | This metric is used to measure the average number of "QUERY" statements executed per second on the node. Unit：Counts/s | ≥ 0 Counts/s | GaussDB(for Mongo) Nodes of the instance | 1 Min               |
| mongodb005_update_ps          |  update Statement Execution Frequency  | This metric is used to calculate the average number of "UPDATE" statements executed per second. Unit：Counts/s | ≥ 0 Counts/s | GaussDB(for Mongo) Nodes of the instance | 1 Min               |
| mongodb006_getmore_ps         | getmore Statement Execution Frequency | This metric is used to calculate the average number of "getmore" statements executed per second on the node. Unit：Counts/s | ≥ 0 Counts/s | GaussDB(for Mongo) Nodes of the instance | 1 Min               |
| mongodb007_connections        |    Current Active Connections    | This metric is used to calculate the number of attempted connections to the instance node. Unit：Counts | ≥ 0 Counts   | GaussDB(for Mongo) Nodes of the instance | 1 Min              |
| mongodb007_connections_usage  | Current Active Connections Percentage | This metric is used to calculate the percentage of attempted connections to the instance node compared to the available connections. Unit：% | 0~100 %      | GaussDB(for Mongo) Nodes of the instance | 1 Min               |
| mongodb008_mem_resident       |       Resident Memory       | This metric is used to measure the current size of resident memory. Unit：MB | ≥ 0 MB       | GaussDB(for Mongo) Nodes of the instance | 1 Min               |
| mongodb009_mem_virtual        |       Virtual Memory       | This metric is used to measure the current size of virtual memory. Unit：MB | ≥ 0 MB       | GaussDB(for Mongo) Nodes of the instance | 1 Min               |
| mongodb010_regular_asserts_ps |     Regular Assertion Frequency     | This metric is used to measure the frequency of regular assertions. Unit：Counts/s | ≥ 0 Counts/s | GaussDB(for Mongo) Nodes of the instance | 1 Min               |
| mongodb011_warning_asserts_ps |       Warning Frequency       | This metric is used to measure the frequency of warnings. Unit：Counts/s | ≥ 0 Counts/s | GaussDB(for Mongo) Nodes of the instance | 1 Min               |
| mongodb012_msg_asserts_ps     |     Message Assertion Frequency     | This metric is used to measure the frequency of message assertions. Unit：Counts/s | ≥ 0 Counts/s | GaussDB(for Mongo) Nodes of the instance | 1 Min               |
| mongodb013_user_asserts_ps    |     User Assertion Frequency     | This metric is used to measure the frequency of user assertions. Unit：Counts/s | ≥ 0 Counts/s | GaussDB(for Mongo) Nodes of the instance | 1 Min               |
| mongodb014_queues_total       |    Number of Operations Waiting for Lock    | This metric is used to count the number of operations currently waiting for a lock. Unit：Counts | ≥ 0 Counts   | GaussDB(for Mongo) Nodes of the instance | 1 Min               |
| mongodb015_queues_readers     |   Number of Operations Waiting for Read Lock   | This metric is used to count the number of operations currently waiting for a read lock. Unit：Counts | ≥ 0 Counts   | GaussDB(for Mongo) Nodes of the instance | 1 Min               |
| mongodb016_queues_writers     |   Number of Operations Waiting for Write Lock   | This metric is used to count the number of operations currently waiting for a write lock. Unit：Counts | ≥ 0 Counts   | GaussDB(for Mongo) Nodes of the instance | 1 Min               |
| mongodb017_page_faults        |      Page Fault Count      | This metric is used to count the number of page faults (also known as page swaps or page errors) that have occurred on the current node. Unit：Counts | ≥ 0 Counts   | GaussDB(for Mongo) Nodes of the instance | 1 Min               |
| mongodb018_porfling_num       |       Slow Query Count       | This metric is used to count the number of slow queries that have occurred on the current node. Unit：Counts | ≥ 0 Counts   | GaussDB(for Mongo) Nodes of the instance | 1 Min               |
| mongodb019_cursors_open       |    Current Maintenance Cursor Count    | This metric is used to count the number of maintenance cursors on the current node. Unit：Counts | ≥ 0 Counts   | GaussDB(for Mongo) Nodes of the instance | 1 Min               |
| mongodb020_cursors_timeout    |    Service Timeout Cursor Count    | This metric is used to count the number of service timeout cursors on the current node. Unit：Counts | ≥ 0 Counts   | GaussDB(for Mongo) Nodes of the instance | 1 Min               |

## Object {#object}

The collected HUAWEI CLOUD ELB object data structure can see the object data from 「Infrastructure-custom-defined」

```json
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

