---
title: 'Huawei Cloud RDS SQLServer'
tags: 
  - Huawei Cloud
summary: 'Collect Huawei Cloud RDS SQLServer Metrics data'
__int_icon: 'icon/huawei_rds_sqlserver'
dashboard:

  - desc: 'Huawei Cloud RDS SQLServer monitoring view'
    path: 'dashboard/en/huawei_rds_sqlserver'

monitor:
  - desc: 'Huawei Cloud RDS SQLServer monitor'
    path: 'monitor/en/huawei_rds_sqlserver'

---

Collect Huawei Cloud RDS SQLServer Metrics data

## Configuration {#config}

### Install Func

We recommend enabling the <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize Huawei Cloud RDS SQLServer monitoring data, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (Huawei Cloud-RDS-SQLServer Collection)" (ID: `guance_huaweicloud_rds_sqlserver`)

After clicking 【Install】, input the corresponding parameters: Huawei Cloud AK, Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set, and automatically configure the corresponding startup script.

After the script is installed, find the script "<<< custom_key.brand_name >>> Integration (Huawei Cloud-RDS-SQLServer Collection)" under "Development" in Func, expand and modify this script. Find `collector_configs` and `monitor_configs` respectively, and edit the content of `region_projects`. Change the region and Project ID to the actual region and Project ID, then click Save and Publish.

In addition, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.

### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and at the same time, you can view the corresponding task records and log checks for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, check whether asset information exists under "Infrastructure - Resource Catalog".
3. On the <<< custom_key.brand_name >>> platform, check whether there are corresponding monitoring data under "Metrics".

## Metrics {#metric}

Configure Huawei Cloud RDS SQLServer Metrics. You can collect more Metrics through configuration [Huawei Cloud RDS SQLServer Metrics Details](https://support.huaweicloud.com/usermanual-rds/rds_sqlserver_06_0001.html){:target="_blank"}

RDS for SQLServer instance performance monitoring Metrics are shown in the following table.

| Metric ID                                       | Metric Name                                | Metric Meaning                                                     | Value Range           | Monitoring Period (Original Metric) |
| -------------------------------------------- | --------------------------------------- | ------------------------------------------------------------ | ------------------ | -------------------- |
| `rds001_cpu_util`                            | CPU Utilization                               | This Metric is used to statistically measure the CPU utilization rate of the measurement object, in percentage units.            | 0-100%             | 1 minute 5 seconds 1 second          |
| `rds002_mem_util`                            | Memory Utilization                              | This Metric is used to statistically measure the memory utilization rate of the measurement object.           | 0～100%            | 1 minute          |
| `rds003_iops`                                | IOPS                                    | This Metric is used to statistically measure the number of I/O requests processed by the current instance within a unit of time (average value). | ≥ 0 counts/s       | 1 minute                |
| `rds004_bytes_in`                            | Network Input Throughput                          | This Metric is used to statistically measure the average traffic input from all network adapters of the measurement object per second, in bytes/second. | ≥ 0 bytes/s        | 1 minute                |
| `rds005_bytes_out`                           | Network Output Throughput                          | This Metric is used to statistically measure the average traffic output from all network adapters of the measurement object per second, in bytes/second. | ≥ 0 bytes/s        | 1 minute                |
| `rds039_disk_util`                           | Disk Utilization                          | This Metric is used to statistically measure the disk utilization rate of the measurement object.                                       | 0～100%         | 1 minute          |
| `rds047_disk_total_size`                     | Total Disk Size                           | This Metric is used to statistically measure the total disk size of the measurement object.             |    40GB～4000GB         | 1 minute          |
| `rds048_disk_used_size`                                 | Disk Usage                                     | This Metric is used to statistically measure the disk usage size of the measurement object.   | 0GB～4000GB      | 1 minute          |
| `rds049_disk_read_throughput`                                 | Disk Read Throughput                                     | This Metric is used to statistically measure the number of bytes read from the disk per second. | ≥0bytes/s | 1 minute          |
| `rds050_disk_write_throughput`                    | Disk Write Throughput                            | This Metric is used to statistically measure the number of bytes written to the disk per second. | ≥0bytes/s                | 1 minute                |
| `rds053_avg_disk_queue_length`                      | Average Disk Queue Length                            | This Metric is used to statistically measure the number of processes waiting to write to the measurement object.           | ≥0                | 1 minute                |
| `rds054_db_connections_in_use`                    | Database Connections in Use                            | The number of user connections to the database. | ≥0 counts                | 1 minute                |
| `rds055_transactions_per_sec`                        | Average Transactions Per Second                    | This Metric is used to statistically measure the number of transactions started by the database per second.  | ≥0counts/s        | 1 minute                |
| `rds056_batch_per_sec`                       | Average Batch Per Second                    | This Metric is used to statistically measure the number of Transact-SQL command batches received per second.  | ≥0counts/s        | 1 minute                |
| `rds057_logins_per_sec`                   | Logins Per Second                  | This Metric is used to statistically measure the total number of logins started per second. | ≥ 0 counts/s       | 1 minute                |
| `rds058_logouts_per_sec`                  | Logouts Per Second                  | This Metric is used to statistically measure the total number of logout operations started per second. | ≥ 0 counts/s       | 1 minute                |
| `rds059_cache_hit_ratio`          | Cache Hit Ratio                                         | This Metric is used to statistically measure the percentage of pages found in the buffer cache without needing to be read from the disk.        | 0~100%       | 1 minute                |
| `rds060_sql_compilations_per_sec`              | Average SQL Compilations Per Second                | This Metric is used to statistically measure the number of SQL compilations per second. | ≥ 0 counts/s       | 1 minute                |
| `rds061_sql_recompilations_per_sec`              | Average SQL Recompilations Per Second             | This Metric is used to statistically measure the number of statement recompilations per second                      | ≥ 0 counts/s       | 1 minute                |
| `rds062_full_scans_per_sec`                       | Full Scans Per Second                          | This Metric is used to statistically measure the number of unrestricted full scans per second.          | ≥ 0 counts/s       | 1 minute                |
| `rds063_errors_per_sec`                    | User Errors Per Second                          | This Metric is used to statistically measure the number of user errors per second.                   | ≥0counts/s           | 1 minute                |
| `rds064_latch_waits_per_sec`                | Latch Waits Per Second                     | This Metric is used to statistically measure the number of latch requests that could not be granted immediately per second.             | ≥0counts/s              | 1 minute                |
| `rds065_lock_waits_per_sec`                 | Lock Waits Per Second                      | This Metric is used to statistically measure the number of lock requests that require the caller to wait per second.            | ≥0counts/s                | 1 minute                |
| `rds066_lock_requests_per_sec`             | Lock Requests Per Second                      | This Metric is used to statistically measure the number of new locks and lock conversions requested by the lock manager per second.          | ≥ 0 counts/s       | 1 minute                |
| `rds067_timeouts_per_sec`              | Lock Timeouts Per Second                      | This Metric is used to statistically measure the number of lock requests that timeout per second.          | ≥ 0 counts/s       | 1 minute                |
| `rds068_avg_lock_wait_time`              | Average Lock Wait Delay                    | This Metric is used to statistically measure the average wait time in milliseconds for each lock request that causes a wait.    | ≥0ms       | 1 minute                |
| `rds069_deadlocks_per_sec`               | Deadlocks Per Second                    | This Metric is used to statistically measure the number of pages refreshed to disk per second by checkpoints or other operations that refresh all dirty pages.    | ≥ 0 counts/s       | 1 minute                |
| `rds070_checkpoint_pages_per_sec`          | Checkpoint Writes Pages Per Second                     | This Metric is used to statistically measure the number of pages refreshed to disk per second by checkpoints or other operations that refresh all dirty pages.    | ≥0counts/s      | 1 minute                |
| `rds077_replication_delay`                    | Data Synchronization Delay                      | This Metric is used to statistically measure the replication delay of the master-slave instances. Since SQL Server instance replication delays are at the database level, each database synchronizes independently, so the instance-level replication delay is the value of the database with the largest replication delay (single-machine instances are not involved, all are 0s).    | ≥ 0s      |  1 minute                |
| `mssql_mem_grant_pending`                | Pending Memory Grant Processes               | This Metric is used to statistically measure the total number of processes waiting to accept memory grants for use, indicating memory pressure. | ≥0counts      | 1 minute                |
| `mssql_lazy_write_per_sec`                    | Lazy Writes Per Second                     | This Metric is used to statistically measure the number of buffers written per second by the lazy writer.   | ≥0counts/s      | 1 minute                |
| `mssql_page_life_expectancy`                | Unreferenced Page Buffer Pool Stay Time           | This Metric is used to statistically measure the number of seconds a page stays in the buffer pool after it has not been referenced. | ≥0s      | 1 minute                |
| `mssql_page_reads_per_sec`                    | Page Reads Per Second                      | This Metric is used to statistically measure the number of pages read per second.                   | ≥0counts/s      | 1 minute          |
| `mssql_tempdb_disk_size`                    | Temporary Table Space Size                     | Current temporary table space disk usage.    | ≥ 0MB       | 1 minute          |
| `mssql_worker_threads_usage_rate`                | Worker Threads Utilization                              | The ratio of the current actual number of worker threads to the max worker threads value. |     0~100%        | 1 minute                |

## Objects {#object}

The collected Huawei Cloud RDS SQLServer object data structure can be seen in the "Infrastructure - Resource Catalog".

```json
{
  "measurement": "huaweicloud_rds_sqlserver",
  "tags": {
    "RegionId"               : "cn-south-1",
    "project_id"             : "c631f046252dxxxxxxxf253c62d48585",
    "enterprise_project_id"  : "o78hhbss-xxxx-xxxx-xxxx-cba3d38cf2f9",
    "instance_id"            : "1d0c91561f4644dxxxxxx68304b0520din01",
    "instance_name"          : "rds-xxxx",
    "engine"                 : "SQLServer",
    "type"                   : "Ha",
    "status"                 : "ACTIVE",
  },
  "fields": {
    "port"                   : "3306",
    "security_group_id"      : "9e5bd45e-0564-445f-xxxx-2c8954e2d99c",
    "switch_strategy"        : "xxx",
    "time_zone"              : "China Standard Time",
    "enable_ssl"             : "True",
    "charge_info.charge_mode": "postPaid",
    "engine_version"         : "2022_SE",
    "created_time"           : "2024-11-03T15:26:45+0000",
    "updated_time"           : "2024-11-05T09:58:26+0000",
    "alias"                  : "xxx",
    "private_ips"            : "[\"192.x.x.35\"]",
    "public_ips"             : "[]",
    "datastore"              : "{Instance JSON data}",
    "cpu"                    : "4",
    "mem"                    : "8",
    "volume"                 : "{volume information}",
    "nodes"                  : "[{master-slave instance information}]",
    "related_instance"       : "[]",
    "backup_strategy"        : "{backup strategy}",
    "message"                : "{Instance JSON data}"
  }
}
```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.instance_id` is the instance ID, which serves as a unique identifier.
>
> Tip 2: The following fields are all serialized JSON strings:
>
> - `fields.message`
> - `fields.private_ips`
> - `fields.public_ips`
> - `fields.volume`
> - `fields.nodes`
> - `fields.related_instance`
> - `fields.backup_strategy`
>
> Tip 3: The value of `type` is "Single", "Ha", "Replica", or "Enterprise", corresponding to single-instance, master-slave instance, read-only instance, and distributed instance (Enterprise Edition), respectively.