---
title: 'HUAWEI GaussDB SYS.GAUSSDBV5'
tags: 
  - Huawei Cloud
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.'
__int_icon: 'icon/huawei_gaussdb_sys.gaussdbv5'
dashboard:

  - desc: 'HUAWEI CLOUD GaussDB SYS.GAUSSDBV5'
    path: 'dashboard/zh/huawei_gaussdb_sys.gaussdbv5'

monitor:
  - desc: 'HUAWEI CLOUD GaussDB SYS.GAUSSDBV5'
    path: 'monitor/zh/huawei_gaussdb_sys.gaussdbv5'

---


<!-- markdownlint-disable MD025 -->
# HUAWEI CLOUD GaussDB **SYS.GAUSSDBV5**
<!-- markdownlint-enable -->

HUAWEI CLOUD GaussDB **SYS.GAUSSDBV5** includes metrics such as CPU, memory, disk, deadlock, and SQL response time metrics.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to  [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare HUAWEI CLOUD AK that meets the requirements in advance（For simplicity's sake,You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of  HUAWEI CLOUD GaussDB **SYS.GAUSSDBV5**, we install the corresponding collection script：「Guance Integration（HUAWEI CLOUD- GaussDB Collect）」(ID：`guance_huaweicloud_gaussdb`)

Click 【Install】 and enter the corresponding parameters: HUAWEI CLOUD AK, HUAWEI CLOUD account name.

tap【Deploy startup Script】,The system automatically creates `Startup` script sets,And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」,Click【Run】,you can immediately execute once, without waiting for a regular time,After a while, you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-gaussdb/){:target="_blank"}

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure GaussDB `SYS.GAUSSDBV5` monitoring. The default metric set is as follows. You can collect more metrics by configuring them [HUAWEI CLOUD Monitor Metrics Details](https://support.huaweicloud.com/intl/en-us/usermanual-opengauss/opengauss_01_0071.html){:target="_blank"}

| Metric ID                       | Index name                                               | Metric meaning                                                      | Value range    | Measurement object (dimension)         | Monitoring cycle (raw metrics) |
|------------------------------------|----------------------------------------------------------| ------------------------------------------------------------ | ---------- | ---------------- | -------------------- |
| rds005_instance_disk_used_size  | Used Instance Disk Size             | Real-time used data disk size of the monitored instance      | Instance     | Instance                       | 60s                            |
| rds006_instance_disk_total_size | Total Instance Disk Size            | Real-time total data disk size of the monitored instance     | Instance     | Instance                       | 60s                            |
| rds007_instance_disk_usage      | Instance Disk Usage                 | Real-time data disk usage of the monitored instance          | Instance     | Instance                       | 60s                            |
| rds035_buffer_hit_ratio         | Buffer Hit Rate                     | Buffer hit rate of the database                              | Instance     | Instance                       | 60s                            |
| rds036_deadlocks                | Deadlocks                           | Incremental number of database transaction deadlocks         | Instance     | Instance                       | 60s                            |
| rds048_P80                      | Response Time of 80% SQL Statements | Real-time response time of 80% of database SQL statements    | Instance     | Instance                       | 60s                            |
| rds049_P95                      | Response Time of 95% SQL Statements | Real-time response time of 95% of database SQL statements    | Instance     | Instance                       | 60s                            |
| rds001_cpu_util                 | CPU Usage                           | CPU usage of the monitored object                            | Current node | Node                           | 60s                            |
| rds002_mem_util                 | Memory Usage                        | Memory usage of the monitored object                         | Current node | Node                           | 60s                            |
| rds003_bytes_in                 | Data Write Volume                   | Average number of bytes sent by the VM of the monitored object in a measurement period | Current node | Node                           | 60s                            |
| rds004_bytes_out                | Outgoing Data Volume                | Average number of bytes received by the VM of the monitored object in a measurement period | Current node | Node                           | 60s                            |
| rds014_iops                     | Disk IOPS                           | Real-time value of data disk reads and writes per second of the monitored node | Current node | Node                           | 60s                            |
| rds016_disk_write_throughput    | Disk Write Throughput               | Real-time write throughput per second of the data disk on the monitored node | Current node | Node                           | 60s                            |
| rds017_disk_read_throughput     | Disk Read Throughput                | Real-time read throughput per second of the data disk on the monitored node | Current node | Node                           | 60s                            |
| rds020_avg_disk_ms_per_write    | Time Required for per Disk Write    | Average time required for a data disk write on the monitored node | Current node | Node                           | 60s                            |
| rds021_avg_disk_ms_per_read     | Time Required for per Disk Read     | Average time required for a data disk read on the monitored node | Current node | Node                           | 60s                            |
| io_bandwidth_usage              | Disk I/O Bandwidth Usage            | Percentage of current disk I/O bandwidth                     | Current node | Node                           | 60s                            |
| iops_usage                      | IOPS Usage                          | Percentage of used IOPS in the total IOPS                    | Current node | Node                           | 60s                            |
| rds069_swap_total_size          | Total Swap Memory                   | Real-time total swap memory size of the OS                   | Current node | Node                           | 60s                            |
| rds068_swap_used_ratio          | Swap Memory Usage                   | Real-time swap memory usage of the OS                        | Current node | Node                           | 60s                            |

## Object {#object}

The collected GaussDB `SYS.GAUSSDBV5` object data structure can see the object data from 「Infrastructure-Custom」

``` json
{
  "measurement": "huaweicloud_gaussdb",
  "tags": {
    "RegionId"                : "cn-north-4",
    "db_user_name"            : "root",
    "name"                    : "2e10f990e139xxxxxx5fac6b59de7eein07",
    "port"                    : "3306",
    "project_id"              : "c631f046252d4xxxxxxx5f253c62d48585",
    "status"                  : "BUILD",
    "type"                    : "Cluster",
    "instance_id"             : "1236a915462940xxxxxx879882200in02",
    "instance_name"           : "xxxxx-efa7"
  },
  "fields": {
    "charge_info"          : "{Accounting type information, including on demand and packet cycle}",
    "flavor_info"          : "{Specification information}",
    "volume"               : "{volume information}",
    "create_time"          : "2023-08-01T14:17:40+0800",
    "update_time"          : "2023-08-01T14:17:42+0800",
    "public_ips"           : "[\"192.168.0.223\"]",
    "nodes"                : "[]",
    "message"              : "{Instance JSON data}",
    "time_zone"            : "UTC+08:00"
  }
}

```


> *notice：`tags`,`fields`The fields in this section may change with subsequent updates*
>
> Tips 1：`tags.name`The value serves as the instance ID for unique identification
>
> Tips 2：`fields.message`,`fields.charge_info`,`fields.flavor_info`,`fields.volume`,`fields.public_ips`,`fields.nodes`,are all JSON-serialized string representations.

