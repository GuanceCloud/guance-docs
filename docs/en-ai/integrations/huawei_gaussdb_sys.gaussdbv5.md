---
title: 'Huawei Cloud GaussDB SYS.GAUSSDBV5'
tags: 
  - Huawei Cloud
summary: 'Huawei Cloud GaussDB SYS.GAUSSDBV5 provides data for metrics such as CPU, memory, disk, deadlocks, and SQL response time.'
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

Huawei Cloud GaussDB `SYS.GAUSSDBV5` provides data for metrics such as CPU, memory, disk, deadlocks, and `SQL` response time.


## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data for GaussDB `SYS.GAUSSDBV5`, we install the corresponding collection script: 「Guance Integration (Huawei Cloud - GaussDB Collection)」(ID: `guance_huaweicloud_gaussdb`)

After clicking 【Install】, enter the required parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration under 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

We have collected some configurations by default; see the Metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-gaussdb/){:target="_blank"}


### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm whether the corresponding tasks have been configured with automatic triggers, and check the task records and logs for any anomalies.
2. On the Guance platform, go to 「Infrastructure / Custom」to check if asset information exists.
3. On the Guance platform, go to 「Metrics」to check if the corresponding monitoring data is available.

## Metrics {#metric}
After configuring GaussDB `SYS.GAUSSDBV5`, the default metric set is as follows. You can collect more metrics through configuration. [Huawei Cloud Monitoring Metrics Details](https://support.huaweicloud.com/usermanual-opengauss/opengauss_01_0071.html){:target="_blank"}

| Metric ID                                             | Metric Name                          | Metric Description                                                     | Display Object      | Metric Unit               | Measurement Object |
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| rds005_instance_disk_used_size                     | Instance Data Disk Used Size            | This metric measures the used size of the instance data disk.          | Instance          | GB                     | Instance     |
| rds006_instance_disk_total_size                    | Instance Data Disk Total Size                | This metric measures the total size of the instance data disk.         | Instance          | GB                     | Instance     |
| rds007_instance_disk_usage                         | Instance Data Disk Usage Percentage          | This metric measures the usage percentage of the instance data disk.   | Instance          | %                      | Instance     |
| rds035_buffer_hit_ratio                            | Buffer Hit Ratio                      | This metric measures the database buffer hit ratio.                           | Instance          | %                      | Instance     |
| rds036_deadlocks                                   | Deadlock Count                          | This metric counts the number of transaction deadlocks in the database, taken as an incremental value over the period. | Instance          | Count                  | Instance     |
| rds048_P80                                         | 80% SQL Response Time                 | This metric measures the response time for 80% of SQL queries.        | Instance          | us                     | Instance     |
| rds049_P95                                         | 95% SQL Response Time                 | This metric measures the response time for 95% of SQL queries.        | Instance          | us                     | Instance     |
| rds001_cpu_util                                    | CPU Utilization                         | This metric measures the CPU utilization.                          | Current Node      | %                      | Node     |
| rds002_mem_util                                    | Memory Utilization                        | This metric measures the memory utilization.                         | Current Node      | %                      | Node     |
| rds003_bytes_in                                    | Data Write Volume                        | This metric measures the network bytes sent by the corresponding VM over the period, taken as an average. | Current Node      | Byte/s                 | Node     |
| rds004_bytes_out                                   | Data Read Volume                        | This metric measures the network bytes received by the corresponding VM over the period, taken as an average. | Current Node      | Byte/s                 | Node     |
| rds014_iops                                        | Data Disk IOPS              | This metric measures the number of reads and writes per second on the node's data disk. | Current Node      | Count/s                | Node     |
| rds016_disk_write_throughput                       | Data Disk Write Throughput                  | This metric measures the write throughput of the node's data disk per second. | Current Node      | Byte/s                 | Node     |
| rds017_disk_read_throughput                        | Data Disk Read Throughput                  | This metric measures the read throughput of the node's data disk per second. | Current Node      | Byte/s                 | Node     |
| rds020_avg_disk_ms_per_write                       | Average Time Per Disk Write                       | This metric measures the average time spent per disk write over the period. | Current Node      | ms                     | Node     |
| rds021_avg_disk_ms_per_read                        | Average Time Per Disk Read                        | This metric measures the average time spent per disk read over the period. | Current Node      | ms                     | Node     |
| io_bandwidth_usage                                 | Disk IO Bandwidth Usage Rate                  | This metric measures the ratio of current disk IO bandwidth to maximum disk IO bandwidth.                             | Current Node      | %                      | Node     |
| iops_usage                                         | IOPS Usage Rate                        | This metric measures the ratio of current IOPS to maximum disk IOPS.                                   | Current Node      | %                      | Node     |
| rds069_swap_total_size                             | Swap Memory Total Size                    | This metric describes the total size of the operating system swap memory.         | Current Node      | MB                     | Node     |
| rds068_swap_used_ratio                             | Swap Memory Usage Rate                    | This metric describes the usage rate of the operating system swap memory.         | Current Node      | %                      | Node     |




## Objects {#object}

The structure of the collected GaussDB `SYS.GAUSSDBV5` object data can be viewed under 「Infrastructure - Custom」

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
    "charge_info"          : "{Billing type information, supports on-demand and subscription}",
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

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, which serves as a unique identifier.
>
> Tip 2: `fields.message`, `fields.charge_info`, `fields.flavor_info`, `fields.volume`, `fields.public_ips`, and `fields.nodes` are serialized JSON strings.