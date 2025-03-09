---
title: 'Huawei Cloud RDS MariaDB'
tags: 
  - Huawei Cloud
summary: 'Collect Huawei Cloud RDS MariaDB Metrics data'
__int_icon: 'icon/huawei_rds_mariadb'
dashboard:

  - desc: 'Huawei Cloud RDS MariaDB monitoring view'
    path: 'dashboard/en/huawei_rds_mariadb'

monitor:
  - desc: 'Huawei Cloud RDS MariaDB monitor'
    path: 'monitor/en/huawei_rds_mariadb'

---

Collect Huawei Cloud RDS MariaDB Metrics data

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> It is recommended to deploy the GSE version

### Install Script

> Note: Prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of Huawei Cloud RDS MariaDB, we need to install the corresponding collection script: 「Guance Integration (Huawei Cloud-RDS-MariaDB Collection)」(ID: `guance_huaweicloud_rds_mariadb`)

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK, Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create the `Startup` script set and configure the corresponding startup scripts.

After the script installation is complete, find the script 「Guance Integration (Huawei Cloud-RDS-MariaDB Collection)」 under "Development" in Func, expand and modify this script. Find and edit the content of `collector_configs` and `monitor_configs`, changing the region and Project ID to the actual region and Project ID, then click Save and Publish.

Additionally, in "Management / Automatic Trigger Configuration", you can see the corresponding automatic trigger configuration. Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.

### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configurations. You can also check the corresponding task records and logs to ensure there are no anomalies.
2. On the Guance platform, in "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, in "Metrics", check if the corresponding monitoring data exists.

## Metrics {#metric}

Configure Huawei Cloud RDS MariaDB metrics; more metrics can be collected through configuration [Huawei Cloud RDS MariaDB Metrics Details](https://support.huaweicloud.com/usermanual-rds/maria_03_0087.html){:target="_blank"}

RDS for MariaDB instance performance monitoring metrics are listed in the table below.

| Metric ID                                       | Metric Name                                | Metric Meaning                                                     | Value Range           | Monitoring Period (Original Metric) |
| -------------------------------------------- | --------------------------------------- | ------------------------------------------------------------ | ------------------ | -------------------- |
| `rds001_cpu_util`                            | CPU Utilization                               | This metric measures the CPU utilization rate of the object, in percentage.            | 0-100%             | 1 minute          |
| `rds002_mem_util`                            | Memory Utilization                              | This metric measures the memory utilization rate of the object.           | 0～100%            | 1 minute          |
| `rds003_iops`                                | IOPS                                    | This metric measures the number of I/O requests processed by the system per unit time (average). | ≥ 0 counts/s   | 1 minute          |
| `rds004_bytes_in`                            | Network Input Throughput                          | This metric measures the average traffic input from all network adapters of the object per second, in bytes/second. | ≥ 0 bytes/s        | 1 minute                |
| `rds005_bytes_out`                           | Network Output Throughput                          | This metric measures the average traffic output from all network adapters of the object per second, in bytes/second. | ≥ 0 bytes/s        | 1 minute                |
| `rds006_conn_count`                           | Total Database Connections                          | This metric measures the total number of connections attempting to connect to the MariaDB server, in counts. | ≥ 0 counts        | 1 minute                |
| `rds007_conn_active_count`                           | Active Connections                          | This metric measures the number of currently open connections, in counts.       | ≥ 0 counts        | 1 minute                |
| `rds008_qps`                           | Queries Per Second                          | This metric measures the number of SQL query executions including stored procedures, in queries/second.                    | ≥ 0 queries/s        | 1 minute                |
| `rds009_tps`                           | Transactions Per Second                          | This metric measures the number of transaction executions including committed and rolled back, in transactions/second. | ≥ 0 transactions/s        | 1 minute                |
| `rds010_innodb_buf_usage`                     | Buffer Pool Usage                          | This metric measures the ratio of idle pages to the total number of pages in the InnoDB buffer pool, in percentage. | 0-1        | 1 minute                |
| `rds011_innodb_buf_hit`                        | Buffer Pool Hit Rate                          | This metric measures the ratio of read hits to read requests, in percentage. |  0-1        | 1 minute                |
| `rds012_innodb_buf_dirty`                        | Buffer Pool Dirty Pages Rate                          | This metric measures the ratio of dirty pages to used pages in the InnoDB buffer pool, in percentage. |  0-1        | 1 minute                |
| `rds013_innodb_reads`                        | InnoDB Read Throughput                          | This metric measures the average number of bytes read per second by InnoDB, in bytes/second. |  ≥ 0 bytes/s        | 1 minute                |
| `rds014_innodb_writes`                        | InnoDB Write Throughput                          | This metric measures the average number of bytes written per second by InnoDB, in bytes/second. |  ≥ 0 bytes/s        | 1 minute                |
| `rds015_innodb_read_count`                        | InnoDB File Read Frequency                        | This metric measures the average number of file reads per second by InnoDB, in counts/second. |  ≥ 0 counts/s       | 1 minute                |
| `rds016_innodb_write_count`                        | InnoDB File Write Frequency                       | This metric measures the average number of file writes per second by InnoDB, in counts/second. |  ≥ 0 counts/s       | 1 minute                |
| `rds017_innodb_log_write_req_count`               | InnoDB Log Write Request Frequency                      | This metric measures the average number of log write requests per second, in counts/second. |  ≥ 0 counts/s               | 1 minute                |
| `rds018_innodb_log_write_count`                        | InnoDB Log Physical Write Frequency                          | This metric measures the average number of physical writes to the log file per second, in counts/second. |  ≥ 0 counts/s        | 1 minute                |
| `rds019_innodb_log_fsync_count`                        | InnoDB Log fsync() Write Frequency                          | This metric measures the average number of fsync() writes completed to the log file per second, in counts/second. |  0-1        | 1 minute                |
| `rds020_temp_tbl_rate`                        | Temporary Table Creation Rate                         | This metric measures the number of temporary tables created on disk per second, in counts/second. |  ≥ 0 counts/s       | 1 minute                |
| `rds021_myisam_buf_usage`                        | Key Buffer Usage                          | This metric measures the utilization rate of the MyISAM Key buffer, in percentage. |  0-1        | 1 minute                |
| `rds022_myisam_buf_write_hit`                        | Key Buffer Write Hit Rate                          | This metric measures the write hit rate of the MyISAM Key buffer, in percentage. |  0-1        | 1 minute                |
| `rds023_myisam_buf_read_hit`                        | Key Buffer Read Hit Rate                          | This metric measures the read hit rate of the MyISAM Key buffer, in percentage. |  0-1        | 1 minute                |
| `rds024_myisam_disk_write_count`                        | MyISAM Disk Write Frequency                          | This metric measures the number of index writes to disk per second, in counts/second. |  ≥ 0 counts/s       | 1 minute                |
| `rds025_myisam_disk_read_count`                        | MyISAM Disk Read Frequency                         | This metric measures the number of index reads from disk per second, in counts/second. |  ≥ 0 counts/s        | 1 minute                |
| `rds026_myisam_buf_write_count`                        | MyISAM Buffer Pool Write Frequency                         | This metric measures the number of index write requests to the buffer pool per second, in counts/second. |  ≥ 0 counts/s        | 1 minute                |
| `rds027_myisam_buf_read_count`                        | MyISAM Buffer Pool Read Frequency                         | This metric measures the number of index read requests from the buffer pool per second, in counts/second. |  ≥ 0 counts/s        | 1 minute                |
| `rds028_comdml_del_count`                        | Delete Statement Execution Frequency                         | This metric measures the average number of Delete statement executions per second, in queries/second. |  ≥ 0 queries/s        | 1 minute                |
| `rds029_comdml_ins_count`                        | Insert Statement Execution Frequency                         | This metric measures the average number of Insert statement executions per second, in queries/second. |  ≥ 0 queries/s        | 1 minute                |
| `rds030_comdml_ins_sel_count`                        | Insert_Select Statement Execution Frequency          | This metric measures the average number of Insert_Select statement executions per second, in queries/second. |  ≥ 0 queries/s        | 1 minute                |
| `rds031_comdml_rep_count`                        | Replace Statement Execution Frequency                    | This metric measures the average number of Replace statement executions per second, in queries/second. | ≥ 0 queries/s        | 1 minute                |
| `rds032_comdml_rep_sel_count`                        | Replace_Selection Statement Execution Frequency      | This metric measures the average number of Replace_Selection statement executions per second, in queries/second. |  ≥ 0 queries/s        | 1 minute         |
| `rds033_comdml_sel_count`                        | Select Statement Execution Frequency             | This metric measures the average number of Select statement executions per second. |  ≥ 0 queries/s        | 1 minute                |
| `rds034_comdml_upd_count`                        | Update Statement Execution Frequency              | This metric measures the average number of Update statement executions per second, in queries/second. |  ≥ 0 queries/s        | 1 minute                |
| `rds035_innodb_del_row_count`                        | Row Deletion Rate                  | This metric measures the average number of rows deleted per second from InnoDB tables, in rows/second. |  ≥ 0 rows/s      | 1 minute                |
| `rds036_innodb_ins_row_count`                        | Row Insertion Rate                   | This metric measures the average number of rows inserted per second into InnoDB tables, in rows/second | ≥ 0 rows/s        | 1 minute                |
| `rds037_innodb_read_row_count`                        | Row Read Rate                   | This metric measures the average number of rows read per second from InnoDB tables, in rows/second. |  ≥ 0 rows/s        | 1 minute                |
| `rds038_innodb_upd_row_count`                        | Row Update Rate                   | This metric measures the average number of rows updated per second in InnoDB tables, in rows/second. |  ≥ 0 rows/s        | 1 minute                |
| `rds039_disk_util`                        | Disk Utilization                              | This metric measures the disk utilization rate of the object, in percentage. |  0-100%        | 1 minute                |
| `rds047_disk_total_size`                      | Total Disk Size                          | This metric measures the total size of the object's disk. |  40GB~4000GB        | 1 minute                |
| `rds048_disk_used_size`                        | Disk Usage                          | This metric measures the used size of the object's disk. |  0GB~4000GB        | 1 minute                |
| `rds049_disk_read_throughput`                        | Disk Read Throughput                   | This metric measures the number of bytes read from disk per second. |  ≥ 0 bytes/s        | 1 minute                |
| `rds050_disk_write_throughput`                        | Disk Write Throughput                  | This metric measures the number of bytes written to disk per second. |  ≥ 0 bytes/s        | 1 minute                |
| `rds072_conn_usage`                        | Connection Usage Rate                             | This metric measures the connection usage rate, in percentage. |  0-100%       | 1 minute                |
| `rds073_replication_delay`                        | Real-time Replication Delay                      | This metric measures the real-time delay between the standby or read-only replica and the master, corresponding to `seconds_behind_master`. |  ≥ 0 s        | 1 minute                |
| `rds074_slow_queries`                        | Slow Query Count                          | This metric displays the number of slow queries generated by MariaDB per minute. |  ≥ 0        | 1 minute                |
| `rds075_avg_disk_ms_per_read`                        | Average Disk Read Time                      | This metric measures the average time taken to read from the disk over a period. |  ≥ 0 ms       | 1 minute                |
| `rds076_avg_disk_ms_per_write`                        | Average Disk Write Time                     | This metric measures the average time taken to write to the disk over a period. |  ≥ 0 ms        | 1 minute                |
| `rds077_vma`                        | VMA Count                                         | This metric monitors the size of virtual memory regions of the RDS process |  ≥ 0 counts        | 1 minute                |
| `rds078_threads`                        | Number of Threads in Process                                | Monitors the number of threads in the RDS process, in counts |  ≥ 0 counts        | 1 minute                |
| `rds079_vm_hwm`                        | Peak Physical Memory Usage of Process                          | Monitors the peak physical memory usage of the RDS process, in KB. |  ≥ 0 KB        | 1 minute                |
| `rds080_vm_peak`                        | Peak Virtual Memory Usage of Process                          | Monitors the peak virtual memory usage of the RDS process, in KB. |  ≥ 0 KB       | 1 minute                |
| `rds082_semi_sync_tx_avg_wait_time`                        | Average Transaction Wait Time            | Monitors the average wait time in semi-sync replication mode, in microseconds. | ≥ 0 μs        | 1 minute                |
| `rds173_replication_delay_avg`                        | Average Replication Delay                     | This metric measures the average delay between the standby or read-only replica and the master, corresponding to `seconds_behind_master` |  ≥ 0 s        | 1 minute                |
| `rds_buffer_pool_wait_free`                        | Buffer Pool Idle Page Wait Count                 | This metric measures the number of times InnoDB buffer pool waits for idle pages. |  ≥ 0 ms        | 1 minute                |
| `rds_bytes_recv_rate`                        | Bytes Received per Second by Database                         | This metric measures the number of bytes received per second by the database, in bytes/second. |  ≥ 0 bytes/s        | 1 minute                |
| `rds_bytes_sent_rate`                        | Bytes Sent per Second by Database                         | This metric measures the number of bytes sent per second by the database, in bytes/second. |  ≥ 0 bytes/s        | 1 minute                |
| `rds_conn_active_usage`                        | Active Connection Usage Rate                         | This metric measures the ratio of active connections to the maximum allowed connections, in percentage. |  0-100%        | 1 minute                |
| `rds_created_tmp_tables_rate`                        | Temporary Tables Created per Second                         | This metric measures the number of temporary tables created per second, in counts/second. | ≥ 0 counts/s        | 1 minute                |
| `rds_innodb_buffer_pool_pages_flushed_rate`                        | Innodb_buffer_pool Pages Flushed per Second                         | This metric measures the number of pages flushed per second from the innodb_buffer_pool, in counts/second. |  ≥ 0 counts/s        | 1 minute                |
| `rds_innodb_buffer_pool_read_requests_rate`                        | Innodb_buffer_pool Read Requests per Second                         | This metric measures the number of read requests per second from the innodb_buffer_pool, in counts/second. |  ≥ 0 counts/s        | 1 minute                |
| `rds_innodb_buffer_pool_write_requests_rate`                        | Innodb_buffer_pool Write Requests per Second                         | This metric measures the number of write requests per second from the innodb_buffer_pool, in counts/second. |  ≥ 0 counts/s        | 1 minute                |
| `rds_innodb_lock_waits`                        | Waiting Row Lock Transactions                         | This metric measures the number of InnoDB transactions currently waiting for row locks, in counts. |  ≥ 0 counts        | 1 minute                |
| `rds_innodb_log_waits_count`                        | Log Waits Count                         | This metric measures the number of log waits, in counts. | ≥ 0 counts       | 1 minute                |
| `rds_innodb_log_waits_rate`                        | Log Waits Due to Insufficient Log Buffer                         | This metric measures the number of flushes to disk due to insufficient log buffer, in counts/second. | ≥ 0 counts       | 1 minute                |
| `rds_innodb_os_log_written_rate`                        | Average Size Written to Redo Log per Second                         | This metric measures the average size written to the redo log per second, in bytes/second. | ≥ 0 bytes/s       | 1 minute                |
| `rds_innodb_pages_read_rate`                        | Average Data Read per Second by Innodb                         | This metric measures the average amount of data read per second by Innodb, in pages/second. | ≥ 0 Pages/s      | 1 minute                |
| `rds_innodb_pages_written_rate`                        | Average Data Written per Second by Innodb                        | This metric measures the average amount of data written per second by Innodb, in pages/second. | ≥ 0 Pages/s       | 1 minute                |
| `rds_innodb_row_lock_current_waits`                        | Current Row Lock Waits                         | This metric measures the current number of InnoDB row lock waits, in counts. | ≥ 0 counts       | 1 minute                |
| `rds_innodb_row_lock_time_avg`                        | Average Row Lock Wait Time                         | This metric measures the average wait time for row locks, in milliseconds. | ≥ 0 ms       | 1 minute                |
| `rds_wait_thread_count`                        | Waiting Thread Count                         | This metric measures the number of waiting threads, in counts. | ≥ 0 counts       | 1 minute                |

## Object {#object}

The structure of collected Huawei Cloud RDS MariaDB object data can be viewed in "Infrastructure - Custom".

```json
{
  "measurement": "huaweicloud_rds_mariadb",
  "tags": {
    "id"                     : "1d0c91561f4644dxxxxxx68304b0520din01",
    "instance_name"          : "rds-xxxx",
    "status"                 : "ACTIVE",
    "port"                   : "3306",
    "type"                   : "Ha",
    "RegionId"               : "cn-south-1",
    "security_group_id"      : "9e5bd45e-0564-445f-xxxx-2c8954e2d99c",
    "switch_strategy"        : "reliability",
    "project_id"             : "c631f046252dxxxxxxxf253c62d48585",
    "time_zone"              : "China Standard Time",
    "enable_ssl"             : "True",
    "charge_info.charge_mode": "postPaid",
    "engine"                 : "MariaDB",
    "engine_version"         : "10.5"
  },
  "fields": {
    "created_time"      : "2024-11-12T06:31:07+0000",
    "updated_time"      : "2024-11-12T07:45:54+0000",
    "private_ips"       : "[\"192.x.x.35\"]",
    "public_ips"        : "[]",
    "datastore"         : "{Instance JSON data}",
    "cpu"               : "4",
    "mem"               : "8",
    "volume"            : "{Volume information}",
    "nodes"             : "[{Primary-standby instance information}]",
    "related_instance"  : "[]",
    "backup_strategy"   : "{Backup strategy}"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, serving as a unique identifier.
>
> Tip 2: The following fields are JSON serialized strings:
>
> - `fields.private_ips`
> - `fields.public_ips`
> - `fields.volume`
> - `fields.nodes`
> - `fields.related_instance`
> - `fields.backup_strategy`
>
> Tip 3: The `type` field can take values "Single", "Ha", "Replica", or "Enterprise", corresponding to single-instance, primary-standby instance, read-only instance, and distributed instance (enterprise edition), respectively.