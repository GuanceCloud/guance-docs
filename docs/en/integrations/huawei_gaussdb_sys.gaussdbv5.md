---
title: 'Huawei Cloud GaussDB SYS.GAUSSDBV5'
tags: 
  - Huawei Cloud
summary: 'Huawei Cloud GaussDB SYS.GAUSSDBV5 provides data on CPU, memory, disk, deadlocks, SQL response time metrics, etc.'
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

Huawei Cloud GaussDB `SYS.GAUSSDBV5` provides data on CPU, memory, disk, deadlocks, `SQL` response time metrics, etc.


## Configuration {#config}

### Install Func

It is recommended to enable Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant read-only access `ReadOnlyAccess`)

To synchronize monitoring data for GaussDB `SYS.GAUSSDBV5`, we install the corresponding collection script: "Guance Integration (Huawei Cloud - GaussDB Collection)" (ID: `guance_huaweicloud_gaussdb`).

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy Startup Script】. The system will automatically create a `Startup` script set and configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

We have collected some configurations by default; for more details, see the Metrics section.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-gaussdb/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm that the corresponding tasks have the corresponding automatic trigger configurations. You can also check the task records and logs to see if there are any abnormalities.
2. On the Guance platform, in "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, in "Metrics", check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring GaussDB `SYS.GAUSSDBV5`, the default metric set is as follows. More metrics can be collected through configuration. [Huawei Cloud Monitoring Metrics Details](https://support.huaweicloud.com/usermanual-opengauss/opengauss_01_0071.html){:target="_blank"}

| Metric ID                                             | Metric Name                          | Metric Description                                                     | Display Object      | Metric Unit               | Measurement Object |
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| rds005_instance_disk_used_size                     | Instance Disk Used Size              | This metric is used to count the instance data disk usage size, which is a real-time value. | Instance          | GB                     | Instance     |
| rds006_instance_disk_total_size                    | Instance Disk Total Size             | This metric is used to count the instance data disk total size, which is a real-time value.   | Instance          | GB                     | Instance     |
| rds007_instance_disk_usage                         | Instance Disk Usage Percentage       | This metric is used to count the instance data disk usage percentage, which is a real-time value.   | Instance          | %                      | Instance     |
| rds035_buffer_hit_ratio                            | Buffer Hit Ratio                     | This metric is used to count the database buffer hit ratio.                           | Instance          | %                      | Instance     |
| rds036_deadlocks                                   | Deadlock Count                       | This metric is used to count the number of transaction deadlocks in the database, taking the incremental value during this period. | Instance          | Count                  | Instance     |
| rds048_P80                                         | 80% SQL Response Time                | This metric is used to count the response time of 80% SQL queries in the database, which is a real-time value.        | Instance          | us                     | Instance     |
| rds049_P95                                         | 95% SQL Response Time                | This metric is used to count the response time of 95% SQL queries in the database, which is a real-time value.        | Instance          | us                     | Instance     |
| rds001_cpu_util                                    | CPU Utilization                      | This metric is used to count the CPU utilization of the measurement object.                          | Current Node      | %                      | Node     |
| rds002_mem_util                                    | Memory Utilization                   | This metric is used to count the memory utilization of the measurement object.                         | Current Node      | %                      | Node     |
| rds003_bytes_in                                    | Data Write Volume                    | This metric is used to count the network bytes sent by the corresponding VM of the measurement object, taking the average value over the time period | Current Node      | Byte/s                 | Node     |
| rds004_bytes_out                                   | Data Transfer Volume                 | This metric is used to count the network bytes received by the corresponding VM of the measurement object, taking the average value over the time period | Current Node      | Byte/s                 | Node     |
| rds014_iops                                        | Data Disk Read/Write Operations per Second | This metric is used to count the number of read/write operations per second on the node data disk of the measurement object, which is a real-time value. | Current Node      | Count/s                | Node     |
| rds016_disk_write_throughput                       | Data Disk Write Throughput           | This metric is used to count the write throughput per second on the node data disk of the measurement object, which is a real-time value. | Current Node      | Byte/s                 | Node     |
| rds017_disk_read_throughput                        | Data Disk Read Throughput            | This metric is used to count the read throughput per second on the node data disk of the measurement object, which is a real-time value. | Current Node      | Byte/s                 | Node     |
| rds020_avg_disk_ms_per_write                       | Average Time per Disk Write          | This metric is used to count the average time spent per disk write operation on the node data disk of the measurement object, taking the average value over the time period. | Current Node      | ms                     | Node     |
| rds021_avg_disk_ms_per_read                        | Average Time per Disk Read           | This metric is used to count the average time spent per disk read operation on the node data disk of the measurement object, taking the average value over the time period. | Current Node      | ms                     | Node     |
| io_bandwidth_usage                                 | Disk IO Bandwidth Usage              | The ratio of current disk IO bandwidth to maximum disk bandwidth                             | Current Node      | %                      | Node     |
| iops_usage                                         | IOPS Usage                           | The ratio of current IOPS to maximum disk IOPS                                   | Current Node      | %                      | Node     |
| rds069_swap_total_size                             | Swap Memory Total Size               | This metric describes the total swap memory size of the operating system, which is a real-time value.         | Current Node      | MB                     | Node     |
| rds068_swap_used_ratio                             | Swap Memory Usage Percentage         | This metric describes the swap memory usage percentage of the operating system, which is a real-time value.         | Current Node      | %                      | Node     |




## Objects {#object}

The structure of the collected GaussDB `SYS.GAUSSDBV5` object data can be viewed in "Infrastructure - Custom"

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
    "charge_info"          : "{Billing type information, supports pay-as-you-go and subscription}",
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
> Note 1: The value of `tags.name` is the instance ID, used for unique identification.
>
> Note 2: `fields.message`, `fields.charge_info`, `fields.flavor_info`, `fields.volume`, `fields.public_ips`, and `fields.nodes` are all JSON serialized strings.