---
title: 'Huawei Cloud GaussDB SYS.GAUSSDBV5'
tags: 
  - Huawei Cloud
summary: 'Huawei Cloud GaussDB SYS.GAUSSDBV5 provides data for cpu, memory, disk, deadlock, and SQL response time metrics.'
__int_icon: 'icon/huawei_gaussdb_sys.gaussdbv5'
dashboard:

  - desc: 'Huawei Cloud GaussDB SYS.GAUSSDBV5'
    path: 'dashboard/en/huawei_gaussdb_sys.gaussdbv5'

monitor:
  - desc: 'Huawei Cloud GaussDB SYS.GAUSSDBV5'
    path: 'monitor/en/huawei_gaussdb_sys.gaussdbv5'

---


<!-- markdownlint-disable MD025 -->
# Huawei Cloud GaussDB `SYS.GAUSSDBV5`
<!-- markdownlint-enable -->

Huawei Cloud GaussDB `SYS.GAUSSDBV5` provides data for cpu, memory, disk, deadlock, and `SQL` response time metrics.


## Configuration {#config}

### Install Func

It is recommended to enable Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data of GaussDB `SYS.GAUSSDBV5`, we install the corresponding collection script: 「Guance Integration (Huawei Cloud - GaussDB Collection)」(ID: `guance_huaweicloud_gaussdb`)

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK, Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to immediately execute once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

We default collect some configurations, details are listed under metrics.

[Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-gaussdb/){:target="_blank"}



### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding task has an automatic trigger configuration, and at the same time, you can check the corresponding task records and logs for any abnormalities.
2. On the Guance platform, in 「Infrastructure / Custom」, check if there is asset information.
3. On the Guance platform, in 「Metrics」, check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring GaussDB `SYS.GAUSSDBV5`, the default metric set is as follows. You can collect more metrics through configuration. [Huawei Cloud Monitoring Metric Details](https://support.huaweicloud.com/usermanual-opengauss/opengauss_01_0071.html){:target="_blank"}

| Metric ID                                             | Metric Name                          | Metric Meaning                                                     | Display Object      | Metric Unit               | Measurement Object |
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| rds005_instance_disk_used_size                     | Instance Data Disk Used Size            | This metric is used to count the used size of the instance data disk, which is a real-time value. | Instance          | GB                     | Instance     |
| rds006_instance_disk_total_size                    | Instance Data Disk Total Size                | This metric is used to count the total size of the instance data disk, which is a real-time value.   | Instance          | GB                     | Instance     |
| rds007_instance_disk_usage                         | Instance Data Disk Usage Percentage          | This metric is used to count the usage rate of the instance data disk, which is a real-time value.   | Instance          | %                      | Instance     |
| rds035_buffer_hit_ratio                            | Buffer Hit Ratio                      | This metric is used to count the database buffer hit ratio.                           | Instance          | %                      | Instance     |
| rds036_deadlocks                                   | Deadlock Count                          | This metric is used to count the number of transaction deadlocks in the database, taking the incremental value of this time period. | Instance          | Count                  | Instance     |
| rds048_P80                                         | 80% SQL Response Time                 | This metric is used to count the response time of 80% SQL in the database, which is a real-time value.        | Instance          | us                     | Instance     |
| rds049_P95                                         | 95% SQL Response Time                 | This metric is used to count the response time of 95% SQL in the database, which is a real-time value.        | Instance          | us                     | Instance     |
| rds001_cpu_util                                    | CPU Utilization                         | This metric is used to count the CPU utilization of the measurement object.                          | Current Node      | %                      | Node     |
| rds002_mem_util                                    | Memory Utilization                        | This metric is used to count the memory utilization of the measurement object.                         | Current Node      | %                      | Node     |
| rds003_bytes_in                                    | Data Write Volume                        | This metric is used to count the number of bytes sent by the network of the VM corresponding to the measurement object, taking the average value of the time period | Current Node      | Byte/s                 | Node     |
| rds004_bytes_out                                   | Data Transmission Volume                        | This metric is used to count the number of bytes received by the network of the VM corresponding to the measurement object, taking the average value of the time period | Current Node      | Byte/s                 | Node     |
| rds014_iops                                        | Data Disk Reads/Writes Per Second              | This metric is used to count the number of reads/writes per second of the node data disk of the measurement object, which is a real-time value. | Current Node      | Count/s                | Node     |
| rds016_disk_write_throughput                       | Data Disk Write Throughput                  | This metric is used to count the write throughput per second of the node data disk of the measurement object, which is a real-time value. | Current Node      | Byte/s                 | Node     |
| rds017_disk_read_throughput                        | Data Disk Read Throughput                  | This metric is used to count the read throughput per second of the node data disk of the measurement object, which is a real-time value. | Current Node      | Byte/s                 | Node     |
| rds020_avg_disk_ms_per_write                       | Average Time Spent Writing Once To Data Disk        | This metric is used to count the average time spent writing once to the node data disk of the measurement object, taking the average value of the time period. | Current Node      | ms                     | Node     |
| rds021_avg_disk_ms_per_read                        | Average Time Spent Reading Once From Data Disk        | This metric is used to count the average time spent reading once from the node data disk of the measurement object, taking the average value of the time period. | Current Node      | ms                     | Node     |
| io_bandwidth_usage                                 | Disk IO Bandwidth Usage Rate                  | The ratio of current disk IO bandwidth to maximum disk bandwidth                             | Current Node      | %                      | Node     |
| iops_usage                                         | IOPS Utilization Rate                        | The ratio of current IOPS to maximum disk IOPS                                   | Current Node      | %                      | Node     |
| rds069_swap_total_size                             | Total Swap Memory Size                    | This metric describes the total size of the operating system swap memory, which is a real-time value.         | Current Node      | MB                     | Node     |
| rds068_swap_used_ratio                             | Swap Memory Utilization Rate                    | This metric describes the utilization rate of the operating system swap memory, which is a real-time value.         | Current Node      | %                      | Node     |




## Objects {#object}

The collected GaussDB `SYS.GAUSSDBV5` object data structure can be seen in 「Infrastructure - Custom」

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
    "charge_info"          : "{Billing type information, supports on-demand and package cycles}",
    "flavor_info"          : "{Specification information}",
    "volume"               : "{Volume information}",
    "create_time"          : "2023-08-01T14:17:40+0800",
    "update_time"          : "2023-08-01T14:17:42+0800",
    "public_ips"           : "[\"192.168.0.223\"]",
    "nodes"                : "[]",
    "message"              : "{Instance JSON data}",
    "time_zone"            : "UTC+08:00"
  }
}

```


> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Note 1: The value of `tags.name` is the instance ID, used as unique identification.
>
> Note 2: `fields.message`, `fields.charge_info`, `fields.flavor_info`, `fields.volume`, `fields.public_ips`, `fields.nodes` are all serialized JSON strings.