---
title: 'Huawei Cloud RDS SQLServer'
tags: 
  - Huawei Cloud
summary: 'Collect metrics data from Huawei Cloud RDS SQLServer'
__int_icon: 'icon/huawei_rds_sqlserver'
dashboard:

  - desc: 'Huawei Cloud RDS SQLServer monitoring view'
    path: 'dashboard/en/huawei_rds_sqlserver'

monitor:
  - desc: 'Huawei Cloud RDS SQLServer monitor'
    path: 'monitor/en/huawei_rds_sqlserver'

---

Collect metrics data from Huawei Cloud RDS SQLServer

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - Extensions - Managed Func: All prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-hosted Func Deployment](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize Huawei Cloud RDS SQLServer monitoring data, we need to install the corresponding collection script: "Guance Integration (Huawei Cloud-RDS-SQLServer Collection)" (ID: `guance_huaweicloud_rds_sqlserver`)

After clicking [Install], enter the required parameters: Huawei Cloud AK and Huawei Cloud account name.

Click [Deploy Startup Script], and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once the script is installed, find the script "Guance Integration (Huawei Cloud-RDS-SQLServer Collection)" under "Development" in Func, expand and modify this script. Edit the contents of `collector_configs` and `monitor_configs`, changing the region and Project ID to the actual ones, then click Save and Publish.

Additionally, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click [Execute] to run it immediately without waiting for the scheduled time. After a short wait, you can check the execution task records and corresponding logs.

### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, under "Metrics", check if the corresponding monitoring data exists.

## Metrics {#metric}

Configure Huawei Cloud RDS SQLServer metrics. You can collect more metrics through configuration. [Huawei Cloud RDS SQLServer Metrics Details](https://support.huaweicloud.com/usermanual-rds/rds_sqlserver_06_0001.html){:target="_blank"}

Performance monitoring metrics for RDS for SQLServer instances are as follows:

| Metric ID                                       | Metric Name                                | Metric Description                                                     | Value Range           | Monitoring Period (Raw Metric) |
| -------------------------------------------- | --------------------------------------- | ------------------------------------------------------------ | ------------------ | -------------------- |
| `rds001_cpu_util`                            | CPU Utilization                               | This metric measures the CPU utilization rate of the object, in percentage.            | 0-100%             | 1 minute 5 seconds 1 second          |
| `rds002_mem_util`                            | Memory Utilization                              | This metric measures the memory utilization rate of the object.           | 0～100%            | 1 minute          |
| `rds003_iops`                                | IOPS                                    | This metric measures the number of I/O requests processed by the system per unit time (average). | ≥ 0 counts/s       | 1 minute                |
| `rds004_bytes_in`                            | Network Input Throughput                          | This metric measures the average amount of traffic input per second from all network adapters of the object, in bytes/second. | ≥ 0 bytes/s        | 1 minute                |
| `rds005_bytes_out`                           | Network Output Throughput                          | This metric measures the average amount of traffic output per second from all network adapters of the object, in bytes/second. | ≥ 0 bytes/s        | 1 minute                |
| `rds039_disk_util`                           | Disk Utilization                          | This metric measures the disk utilization rate of the object.                                       | 0～100%         | 1 minute          |
| `rds047_disk_total_size`                     | Total Disk Size                           | This metric measures the total disk size of the object.             |    40GB～4000GB         | 1 minute          |
| `rds048_disk_used_size`                                 | Disk Usage                                     | This metric measures the used disk size of the object.   | 0GB～4000GB      | 1 minute          |
| `rds049_disk_read_throughput`                                 | Disk Read Throughput                                     | This metric measures the number of bytes read from the disk per second. | ≥0bytes/s | 1 minute          |
| `rds050_disk_write_throughput`                    | Disk Write Throughput                            | This metric measures the number of bytes written to the disk per second. | ≥0bytes/s                | 1 minute                |
| `rds053_avg_disk_queue_length`                      | Average Disk Queue Length                            | This metric measures the number of processes waiting to write to the object.           | ≥0                | 1 minute                |
| `rds054_db_connections_in_use`                    | Database Connections in Use                            | The number of connections users have to the database. | ≥0 counts                | 1 minute                |
| `rds055_transactions_per_sec`                        | Transactions per Second                    | This metric measures the number of transactions started per second by the database.  | ≥0counts/s        | 1 minute                |
| `rds056_batch_per_sec`                       | Batches per Second                    | This metric measures the number of Transact-SQL command batches received per second.  | ≥0counts/s        | 1 minute                |
| `rds057_logins_per_sec`                   | Logins per Second                  | This metric measures the total number of logins started per second. | ≥ 0 counts/s       | 1 minute                |
| `rds058_logouts_per_sec`                  | Logouts per Second                  | This metric measures the total number of logout operations started per second. | ≥ 0 counts/s       | 1 minute                |
| `rds059_cache_hit_ratio`          | Cache Hit Ratio                                         | This metric measures the percentage of pages found in the buffer cache without needing to be read from disk.        | 0~100%       | 1 minute                |
| `rds060_sql_compilations_per_sec`              | SQL Compilations per Second                | This metric measures the number of SQL compilations per second. | ≥ 0 counts/s       | 1 minute                |
| `rds061_sql_recompilations_per_sec`              | SQL Recompilations per Second             | This metric measures the number of statement recompilations per second.                      | ≥ 0 counts/s       | 1 minute                |
| `rds062_full_scans_per_sec`                       | Full Scans per Second                          | This metric measures the number of unrestricted full scans per second.          | ≥ 0 counts/s       | 1 minute                |
| `rds063_errors_per_sec`                    | User Errors per Second                          | This metric measures the number of user errors per second.                   | ≥0counts/s           | 1 minute                |
| `rds064_latch_waits_per_sec`                | Latch Waits per Second                     | This metric measures the number of latch requests not granted immediately per second.             | ≥0counts/s              | 1 minute                |
| `rds065_lock_waits_per_sec`                 | Lock Waits per Second                      | This metric measures the number of lock requests requiring the caller to wait per second.            | ≥0counts/s                | 1 minute                |
| `rds066_lock_requests_per_sec`             | Lock Requests per Second                      | This metric measures the number of new locks and lock conversions requested by the lock manager per second.          | ≥ 0 counts/s       | 1 minute                |
| `rds067_timeouts_per_sec`              | Lock Timeouts per Second                      | This metric measures the number of lock requests that timed out per second.          | ≥ 0 counts/s       | 1 minute                |
| `rds068_avg_lock_wait_time`              | Average Lock Wait Time                    | This metric measures the average wait time (in milliseconds) for each lock request that caused a wait.    | ≥0ms       | 1 minute                |
| `rds069_deadlocks_per_sec`               | Deadlocks per Second                    | This metric measures the number of deadlocks per second.    | ≥ 0 counts/s       | 1 minute                |
| `rds070_checkpoint_pages_per_sec`          | Checkpoint Pages Written per Second                     | This metric measures the number of pages flushed to disk per second by checkpoints refreshing all dirty pages or other operations.    | ≥0counts/s      | 1 minute                |
| `rds077_replication_delay`                    | Replication Delay                      | This metric measures the replication delay between primary and standby instances. Since SQL Server instance replication delays are at the database level, each database does its own synchronization, so the instance-level replication delay is the maximum value among the databases (single-node instances do not involve this and are all 0s).    | ≥ 0s      |  1 minute                |
| `mssql_mem_grant_pending`                | Pending Memory Grant Processes               | This metric measures the number of processes waiting to accept memory grants for use, indicating memory pressure. | ≥0counts      | 1 minute                |
| `mssql_lazy_write_per_sec`                    | Lazy Writes per Second                     | This metric measures the number of buffers written per second by the lazy writer.   | ≥0counts/s      | 1 minute                |
| `mssql_page_life_expectancy`                | Page Life Expectancy           | This metric measures the number of seconds a page stays in the buffer pool after it is no longer referenced. | ≥0s      | 1 minute                |
| `mssql_page_reads_per_sec`                    | Page Reads per Second                      | This metric measures the number of pages read per second.                   | ≥0counts/s      | 1 minute          |
| `mssql_tempdb_disk_size`                    | TempDB Disk Size                     | The current disk size occupied by the tempdb space.    | ≥ 0MB       | 1 minute          |
| `mssql_worker_threads_usage_rate`                | Worker Threads Usage Rate                              | The ratio of the current actual number of worker threads to the max worker threads value. |     0~100%        | 1 minute                |

## Objects {#object}

The structure of collected Huawei Cloud RDS SQLServer object data can be viewed under "Infrastructure - Custom":

```json
{
  "measurement": "huaweicloud_rds_sqlserver",
  "tags": {
    "name"                   : "1d0c91561f4644daxxxxx68304b0520din01",
    "id"                     : "1d0c91561f4644dxxxxxx68304b0520din01",
    "instance_name"          : "rds-xxxx",
    "status"                 : "ACTIVE",
    "port"                   : "3306",
    "type"                   : "Ha",
    "RegionId"               : "cn-south-1",
    "security_group_id"      : "9e5bd45e-0564-445f-xxxx-2c8954e2d99c",
    "switch_strategy"        : "xxx",
    "project_id"             : "c631f046252dxxxxxxxf253c62d48585",
    "time_zone"              : "China Standard Time",
    "enable_ssl"             : "True",
    "charge_info.charge_mode": "postPaid",
    "engine"                 : "SQLServer",
    "engine_version"         : "2022_SE"
  },
  "fields": {
    "created_time"    : "2024-11-03T15:26:45+0000",
    "updated_time"    : "2024-11-05T09:58:26+0000",
    "alias"           : "xxx",
    "private_ips"     : "[\"192.x.x.35\"]",
    "public_ips"      : "[]",
    "datastore"       : "{Instance JSON Data}",
    "cpu"             : "4",
    "mem"             : "8",
    "volume"          : "{Volume Information}",
    "nodes"           : "[{Primary and Standby Instance Information}]",
    "related_instance": "[]",
    "backup_strategy" : "{Backup Strategy}",
    "message"         : "{Instance JSON Data}"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Note 1: The value of `tags.name` is the instance ID, used as a unique identifier.
>
> Note 2: The following fields are JSON serialized strings:
>
> - `fields.message`
> - `fields.private_ips`
> - `fields.public_ips`
> - `fields.volume`
> - `fields.nodes`
> - `fields.related_instance`
> - `fields.backup_strategy`
>
> Note 3: The `type` field can take values "Single", "Ha", "Replica", or "Enterprise", corresponding to single-instance, primary-standby instance, read-only instance, and distributed instance (Enterprise Edition), respectively.