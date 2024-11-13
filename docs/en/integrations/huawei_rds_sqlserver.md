---
title: 'Huawei Cloud RDS SQLServer'
tags: 
  - Huawei Cloud
summary: 'Collect Huawei Cloud RDS SQLServer metric data'
__int_icon: 'icon/huawei_rds_sqlserver'
dashboard:

  - desc: 'Huawei Cloud RDS SQLServer Monitoring View'
    path: 'dashboard/en/huawei_rds_sqlserver'

monitor:
  - desc: 'Huawei Cloud RDS SQLServer Monitor'
    path: 'monitor/en/huawei_rds_sqlserver'
---


Collect Huawei Cloud RDS SQLServer metric data.

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically,Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> Recommend deploying GSE (Game Server Engine) edition translation.

### Installation script

> Tip:Please prepare a Huawei Cloud AK that meets the requirements in advance (For simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of Huawei Cloud RDS SQLServer, we install the corresponding collection script: 「Guance Cloud Integration (Huawei Cloud RDS-SQLServer Collection)」 (ID: `guance_ huaweicloud_rds_sqlserver`)

Click 【Install】 and enter the corresponding parameters: HUAWEI CLOUD AK, HUAWEI CLOUD account name.

Tap【Deploy startup Script】, the system automatically creates `Startup` script sets, and automatically configure the corresponding startup script.

After installing the script, find the script 「Guance Cloud Integration (Huawei Cloud RDS-SQLServer data collection)」 in the 「Development」 section of Func. Expand and modify the script, find collector_configs and monitor_configs, and edit the content in region_projects below. Change the region and Project ID to the actual region and Project ID, and then click save and publish.

In addition, in「Management / Automatic Trigger Configuration」 you can see the corresponding automatic trigger configuration. Click 【Execute】 to run it immediately, without waiting for the scheduled time. After a short moment, you can check the execution task records and corresponding logs.

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the guance cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the guance cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

Configure Huawei Cloud RDS SQLServer metrics to collect more metrics through configuration [Huawei Cloud RDS SQLServer Metric Details](https://support.huaweicloud.com/usermanual-rds/rds_sqlserver_06_0001.html){:target="_blank"}

The performance monitoring metrics for RDS for SQLServer instances are shown in the following table.

| **MetricID**                                       | **Metric Name**                                | **Metric Meaning**                                                     | **Value Range**           | **Monitoring Period (Raw Metric)** |
| -------------------------------------------- | --------------------------------------- | ------------------------------------------------------------ | ------------------ | -------------------- |
| `rds001_cpu_util`                            | CPU usage rate                               | This metric is used to calculate the CPU usage rate of the measured object, measured in units of ratios.            | 0-100%             | 1 minute 5 seconds 1 second          |
| `rds002_mem_util`                            | Memory usage rate                              | This metric is used to measure the memory utilization of the measured object.           | 0～100%            | 1 minute          |
| `rds003_iops`                                | IOPS                                    | This metric is used to calculate the average number of I/O requests processed by the system per unit time for the current instance. | ≥ 0 counts/s       | 1 minute                |
| `rds004_bytes_in`                            | Network input throughput                          | This metric is used to calculate the average traffic input from all network adapters of the measurement object per second, measured in bytes per second. | ≥ 0 bytes/s        | 1 minute                |
| `rds005_bytes_out`                           | Network output throughput                          | This metric is used to calculate the average traffic output per second from all network adapters of the measurement object, measured in bytes per second. | ≥ 0 bytes/s        | 1 minute                |
| `rds039_disk_util`                           | Disk utilization rate                          | This metric is used to measure the disk utilization of the object being measured.                                       | 0～100%         | 1 minute          |
| `rds047_disk_total_size`                     | Total disk size                           | This metric is used to calculate the total disk size of the measured object.             |    40GB～4000GB         | 1 minute          |
| `rds048_disk_used_size`                                 | Disk usage                                     | This metric is used to calculate the disk usage size of the measured object.   | 0GB～4000GB      | 1 minute          |
| `rds049_disk_read_throughput`                                 | Hard disk read throughput                                     | This metric is used to count the number of bytes read from the disk per second. | ≥0bytes/s | 1分          |
| `rds050_disk_write_throughput`                    | Hard disk write throughput                            | This metric is used to count the number of bytes written to the disk per second. | ≥0bytes/s                | 1 minute                |
| `rds053_avg_disk_queue_length`                      | Average queue length of disk                            | This metric is used to count the number of processes waiting to write measurement objects.           | ≥0                | 1 minute                |
| `rds054_db_connections_in_use`                    | Number of database connections in use                            | The number of user connections to the database. | ≥0 counts                | 1 minute                |
| `rds055_transactions_per_sec`                        | Average number of transactions per second                    | This metric is used to count the number of transactions started per second in the database.  | ≥0counts/s        | 1 minute                |
| `rds056_batch_per_sec`                       | Average number of batches per second                    | This metric is used to count the number of batches of SQL commands received per second.  | ≥0counts/s        | 1 minute                |
| `rds057_logins_per_sec`                   | Login attempts per second                  | This metric is used to count the total number of logins started per second. | ≥ 0 counts/s       | 1 minute                |
| `rds058_logouts_per_sec`                  | Log out times per second                  | This metric is used to count the total number of logout operations initiated per second. | ≥ 0 counts/s       | 1 minute                |
| `rds059_cache_hit_ratio`          | cache hit rate                                          | This metric is used to calculate the percentage of pages found in the buffer cache that do not need to be read from disk.        | 0~100%       | 1 minute                |
| `rds060_sql_compilations_per_sec`              | Average number of SQL compilations per second                | This metric is used to count the number of SQL compilations per second. | ≥ 0 counts/s       | 1 minute                |
| `rds061_sql_recompilations_per_sec`              | Average number of SQL retranslations per second             | This metric is used to count the number of times statements are recompiled per second                      | ≥ 0 counts/s       | 1 minute                |
| `rds062_full_scans_per_sec`                       | Full table scans per second                          | This metric is used to count the unrestricted number of complete scans per second.          | ≥ 0 counts/s       | 1 minute                |
| `rds063_errors_per_sec`                    | Number of user errors per second                          | This metric is used to count the number of user errors per second.                   | ≥0counts/s           | 1 minute                |
| `rds064_latch_waits_per_sec`                | Latch waiting times per second                     | This metric is used to count the number of latch requests that cannot be immediately granted per second.             | ≥0counts/s              | 1 minute                |
| `rds065_lock_waits_per_sec`                 | Lock wait times per second                      | This metric is used to count the number of lock requests that the caller is required to wait for per second.            | ≥0counts/s                | 1 minute                |
| `rds066_lock_requests_per_sec`             | Lock requests per second                      | This metric is used to count the number of new locks and lock conversions requested by the lock manager per second.          | ≥ 0 counts/s       | 1 minute                |
| `rds067_timeouts_per_sec`              | Lock timeout times per second                      | This metric is used to count the number of lock requests that timeout per second.          | ≥ 0 counts/s       | 1 minute                |
| `rds068_avg_lock_wait_time`              | Average lock waiting delay                    | This metric is used to calculate the average waiting time (in milliseconds) for each lock request that causes waiting.    | ≥0ms       | 1 minute                |
| `rds069_deadlocks_per_sec`               | Deadlock occurrences per second                    | This metric is used to count the number of pages refreshed to disk per second by checkpoints or other operations that refresh all dirty pages.    | ≥ 0 counts/s       | 1 minute                |
| `rds070_checkpoint_pages_per_sec`          | Number of page writes per second for checkpoint                     | This metric is used to count the number of pages refreshed to disk per second by checkpoints or other operations that refresh all dirty pages.    | ≥0counts/s      | 1 minute                |
| `rds077_replication_delay`                    | Data synchronization delay                      | This metric is used to calculate the replication latency of primary and backup instances. Since the replication latency of SQL Server instances is at the library level, and each library is synchronizing separately, the instance level replication latency is the value of the library with the highest replication latency (0s for standalone systems).    | ≥ 0s      |  1 minute                |
| `mssql_mem_grant_pending`                | Number of processes waiting for memory authorization               | This metric is used to count the total number of processes waiting to receive memory authorization for use, indicating the memory pressure situation. | ≥0counts      | 1 minute                |
| `mssql_lazy_write_per_sec`                    | Number of lazy writes to cache per second                     | This metric is used to count the number of buffers written by the Lazy writer per second.   | ≥0counts/s      | 1 minute                |
| `mssql_page_life_expectancy`                | No reference page buffer pool dwell time           | This metric is used to count the number of seconds a page stays in the buffer pool after it is not referenced. | ≥0s      | 1 minute                |
| `mssql_page_reads_per_sec`                    | Page reads per second                      | This metric is used to count the number of pages read per second.                   | ≥0counts/s      | 1 minute          |
| `mssql_tempdb_disk_size`                    | Temporary tablespace size                     | The current temporary tablespace occupies disk size.    | ≥ 0MB       | 1 minute          |
| `mssql_worker_threads_usage_rate`                | Work thread utilization rate                              | The ratio of the current total number of actual worker threads to the value of max worker threads. |     0~100%        | 1 minute                |

## Object {#object}

The collected Huawei Cloud RDS SQLServer object data structure can be viewed in the 「Infrastructure Customization」section for object data

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
    "datastore"       : "{Instance JSON data}",
    "cpu"             : "4",
    "mem"             : "8",
    "volume"          : "{volume message}",
    "nodes"           : "[{Primary and backup instance information}]",
    "related_instance": "[]",
    "backup_strategy" : "{Backup strategy}",
    "message"         : "{Instance JSON data}"
  }
}
```

> *notice：`tags`、`fields`The fields in this section may change with subsequent updates*
>
> Tips 1：The value of `tags.name` is the instance ID, which serves as a unique identifier
>
> Tips 2：The following fields are JSON serialized strings
>
> - `fields.message`
> - `fields.private_ips`
> - `fields.public_ips`
> - `fields.volume`
> - `fields.nodes`
> - `fields.related_instance`
> - `fields.backup_strategy`
>
> Tips 3：The value of `type` is "Single","Ha" or "Replica","Enterprise",corresponding to single machine instance, primary/backup instance, read-only instance, and distributed instance (Enterprise Edition), respectively.
