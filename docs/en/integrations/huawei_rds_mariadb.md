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

It is recommended to activate the Guance integration - extension - hosted Func: all prerequisites are automatically installed, please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> It is recommended to deploy the GSE version

### Install Script

> Note: Please prepare a Huawei Cloud AK in advance that meets the requirements (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize Huawei Cloud RDS MariaDB monitoring data, we install the corresponding collection script: "Guance Integration (Huawei Cloud-RDS-MariaDB Collection)" (ID: `guance_huaweicloud_rds_mariadb`)

After clicking 【Install】, input the corresponding parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After the script is installed, find the script "Guance Integration (Huawei Cloud-RDS-MariaDB Collection)" under "Development" in Func, expand and modify this script. Find and edit the contents of `collector_configs` and `monitor_configs` for `region_projects`, changing the region and Project ID to the actual region and Project ID, then click Save and Publish.

In addition, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the regular time. After a short while, you can check the execution task records and corresponding logs.

### Verification

1. Confirm in "Manage / Automatic Trigger Configuration" whether the corresponding task has the corresponding automatic trigger configuration, and at the same time, you can check the corresponding task records and logs for any abnormalities.
2. On the Guance platform, check in "Infrastructure - Resource Catalog" whether asset information exists.
3. On the Guance platform, check in "Metrics" whether there are corresponding monitoring data.

## Metrics {#metric}

Configure Huawei Cloud RDS MariaDB Metrics, which can collect more metrics through configuration [Huawei Cloud RDS MariaDB Metrics Details](https://support.huaweicloud.com/usermanual-rds/maria_03_0087.html){:target="_blank"}

RDS for MariaDB instance performance monitoring metrics are as follows:

| Metric ID                                       | Metric Name                                | Metric Meaning                                                     | Value Range           | Monitoring Period (Original Metric) |
| -------------------------------------------- | --------------------------------------- | ------------------------------------------------------------ | ------------------ | -------------------- |
| `rds001_cpu_util`                            | CPU Utilization                               | This metric is used to measure the CPU utilization rate of the object, in percentage units.            | 0-100%             | 1 minute          |
| `rds002_mem_util`                            | Memory Utilization                              | This metric is used to measure the memory utilization rate of the object.           | 0～100%            | 1 minute          |
| `rds003_iops`                                | IOPS                                    | This metric is used to count the number of I/O requests processed by the current instance per unit of time (average). | ≥ 0 counts/s   | 1 minute          |
| `rds004_bytes_in`                            | Network Input Throughput                          | This metric is used to count the average traffic input from all network adapters of the measured object per second, in bytes/second. | ≥ 0 bytes/s        | 1 minute                |
| `rds005_bytes_out`                           | Network Output Throughput                          | This metric is used to count the average traffic output from all network adapters of the measured object per second, in bytes/second. | ≥ 0 bytes/s        | 1 minute                |
| `rds006_conn_count`                           | Total Database Connections                          | This metric is used to count the total number of connections attempting to connect to the MariaDB server, in units. | ≥ 0 counts        | 1 minute                |
| `rds007_conn_active_count`                           | Current Active Connections                          | This metric is used to count the number of currently open connections, in units.       | ≥ 0 counts        | 1 minute                |
| `rds008_qps`                           | QPS                          | This metric is used to count the number of SQL statement queries, including stored procedures, in queries/second.                    | ≥ 0 queries/s        | 1 minute                |
| `rds009_tps`                           | TPS                          | This metric is used to count the number of transaction executions, including committed and rolled back, in transactions/second. | ≥ 0 transactions/s        | 1 minute                |
| `rds010_innodb_buf_usage`                     | Buffer Pool Utilization                          | This metric is used to count the ratio of idle pages to the total number of buffer pool pages in the InnoDB cache, in percentage units. | 0-1        | 1 minute                |
| `rds011_innodb_buf_hit`                        | Buffer Pool Hit Rate                          | This metric is used to count the ratio of read hits to read requests, in percentage units. |  0-1        | 1 minute                |
| `rds012_innodb_buf_dirty`                        | Buffer Pool Dirty Block Rate                          | This metric is used to count the ratio of dirty data in the InnoDB cache to the used pages in the InnoDB cache, in percentage units. |  0-1        | 1 minute                |
| `rds013_innodb_reads`                        | InnoDB Read Throughput                          | This metric is used to count the average number of bytes read per second by Innodb, in bytes/second. |  ≥ 0 bytes/s        | 1 minute                |
| `rds014_innodb_writes`                        | InnoDB Write Throughput                          | This metric is used to count the average number of bytes written per second by Innodb, in bytes/second. |  ≥ 0 bytes/s        | 1 minute                |
| `rds015_innodb_read_count`                        | InnoDB File Read Frequency                        | This metric is used to count the average number of reads from files per second by Innodb, in counts/second. |  ≥ 0 counts/s       | 1 minute                |
| `rds016_innodb_write_count`                        | InnoDB File Write Frequency                       | This metric is used to count the average number of writes to files per second by Innodb, in counts/second. |  ≥ 0 counts/s       | 1 minute                |
| `rds017_innodb_log_write_req_count`               | InnoDB Log Write Request Frequency                      | This metric is used to count the average number of log write requests per second, in counts/second. |  ≥ 0 counts/s               | 1 minute                |
| `rds018_innodb_log_write_count`                        | InnoDB Log Physical Write Frequency                          | This metric is used to count the average number of physical writes to log files per second, in counts/second. |  ≥ 0 counts/s        | 1 minute                |
| `rds019_innodb_log_fsync_count`                        | InnoDB Log fsync() Write Frequency                          | This metric is used to count the average number of completed fsync() writes to log files per second, in counts/second. |  0-1        | 1 minute                |
| `rds020_temp_tbl_rate`                        | Temporary Table Creation Rate                         | This metric is used to count the number of temporary tables created on disk per second, in counts/second. |  ≥ 0 counts/s       | 1 minute                |
| `rds021_myisam_buf_usage`                        | Key Buffer Utilization                          | This metric is used to count the utilization rate of the MyISAM Key buffer, in percentage units. |  0-1        | 1 minute                |
| `rds022_myisam_buf_write_hit`                        | Key Buffer Write Hit Rate                          | This metric is used to count the write hit rate of the MyISAM Key buffer, in percentage units. |  0-1        | 1 minute                |
| `rds023_myisam_buf_read_hit`                        | Key Buffer Read Hit Rate                          | This metric is used to count the read hit rate of the MyISAM Key buffer, in percentage units. |  0-1        | 1 minute                |
| `rds024_myisam_disk_write_count`                        | MyISAM Disk Write Frequency                          | This metric is used to count the number of index writes to disk per second, in counts/second. |  ≥ 0 counts/s       | 1 minute                |
| `rds025_myisam_disk_read_count`                        | MyISAM Disk Read Frequency                         | This metric is used to count the number of index reads from disk per second, in counts/second. |  ≥ 0 counts/s        | 1 minute                |
| `rds026_myisam_buf_write_count`                        | MyISAM Buffer Pool Write Frequency                         | This metric is used to count the number of index write requests to the buffer pool per second, in counts/second. |  ≥ 0 counts/s        | 1 minute                |
| `rds027_myisam_buf_read_count`                        | MyISAM Buffer Pool Read Frequency                         | This metric is used to count the number of index read requests from the buffer pool per second, in counts/second. |  ≥ 0 counts/s        | 1 minute                |
| `rds028_comdml_del_count`                        | Delete Statement Execution Frequency                         | This metric is used to count the average number of Delete statements executed per second, in queries/second. |  ≥ 0 queries/s        | 1 minute                |
| `rds029_comdml_ins_count`                        | Insert Statement Execution Frequency                         | This metric is used to count the average number of Insert statements executed per second, in queries/second. |  ≥ 0 queries/s        | 1 minute                |
| `rds030_comdml_ins_sel_count`                        | Insert_Select Statement Execution Frequency          | This metric is used to count the average number of Insert_Select statements executed per second, in queries/second. |  ≥ 0 queries/s        | 1 minute                |
| `rds031_comdml_rep_count`                        | Replace Statement Execution Frequency                    | This metric is used to count the average number of Replace statements executed per second, in queries/second. | ≥ 0 queries/s        | 1 minute                |
| `rds032_comdml_rep_sel_count`                        | Replace_Selection Statement Execution Frequency      | This metric is used to count the average number of Replace_Selection statements executed per second, in queries/second. |  ≥ 0 queries/s        | 1 minute         |
| `rds033_comdml_sel_count`                        | Select Statement Execution Frequency             | This metric is used to count the average number of Select statements executed per second. |  ≥ 0 queries/s        | 1 minute                |
| `rds034_comdml_upd_count`                        | Update Statement Execution Frequency              | This metric is used to count the average number of Update statements executed per second, in queries/second. |  ≥ 0 queries/s        | 1 minute                |
| `rds035_innodb_del_row_count`                        | Row Deletion Rate                  | This metric is used to count the average number of rows deleted per second from the InnoDB table, in rows/second. |  ≥ 0 rows/s      | 1 minute                |
| `rds036_innodb_ins_row_count`                        | Row Insertion Rate                   | This metric is used to count the average number of rows inserted per second into the InnoDB table, in rows/second. | ≥ 0 rows/s        | 1 minute                |
| `rds037_innodb_read_row_count`                        | Row Reading Rate                   | This metric is used to count the average number of rows read per second from the InnoDB table, in rows/second. |  ≥ 0 rows/s        | 1 minute                |
| `rds038_innodb_upd_row_count`                        | Row Updating Rate                   | This metric is used to count the average number of rows updated per second in the InnoDB table, in rows/second. |  ≥ 0 rows/s        | 1 minute                |
| `rds037_innodb_read_row_count`                        | Row Reading Rate                  | This metric is used to count the average number of rows read per second from the InnoDB table, in rows/second. |  ≥ 0 queries/s        | 1 minute                       |
| `rds039_disk_util`                        | Disk Utilization                              | This metric is used to count the disk utilization rate of the measured object, in percentage units. |  0-100%        | 1 minute                |
| `rds047_disk_total_size`                      | Total Disk Size                          | This metric is used to count the total size of the measured object's disk. |  40GB~4000GB        | 1 minute                |
| `rds048_disk_used_size`                        | Disk Usage                          | This metric is used to count the size of disk usage of the measured object. |  0GB~4000GB        | 1 minute                |
| `rds049_disk_read_throughput`                        | Hard Disk Read Throughput                   | This metric is used to count the number of bytes read per second from the hard drive. |  ≥ 0 bytes/s        | 1 minute                |
| `rds050_disk_write_throughput`                        | Hard Disk Write Throughput                  | This metric is used to count the number of bytes written per second to the hard drive. |  ≥ 0 bytes/s        | 1 minute                |
| `rds072_conn_usage`                        | Connection Usage Rate                             | This metric is used to count the average number of rows read per second from the InnoDB table, in rows/second. |  0-100%       | 1 minute                |
| `rds073_replication_delay`                        | Real-time Replication Delay                      | This metric represents the real-time delay between the standby or read-only database and the primary database, corresponding to seconds_behind_master. This value is a real-time value. |  ≥ 0 s        | 1 minute                |
| `rds074_slow_queries`                        | Slow Log Count Statistics                          | This metric is used to display the number of slow logs generated by MariaDB per minute. |  ≥ 0        | 1 minute                |
| `rds075_avg_disk_ms_per_read`                        | Hard Disk Read Time                      | This metric is used to count the average time taken for each disk read during a certain period. |  ≥ 0 ms       | 1 minute                |
| `rds076_avg_disk_ms_per_write`                        | Hard Disk Write Time                     | This metric is used to count the average time taken for each disk write during a certain period. |  ≥ 0 ms        | 1 minute                |
| `rds077_vma`                        | VMA Quantity                                         | This metric is used to monitor the size of virtual memory areas for the RDS process |  ≥ 0 counts        | 1 minute                |
| `rds078_threads`                        | Number of Threads in Process                                | Monitor the number of threads in the RDS process, in units. |  ≥ 0 counts        | 1 minute                |
| `rds079_vm_hwm`                        | Peak Physical Memory Usage of Process                          | Monitor the peak physical memory usage of the RDS process, in KB units. |  ≥ 0 KB        | 1 minute                |
| `rds080_vm_peak`                        | Peak Virtual Memory Usage of Process                          | Monitor the peak virtual memory usage of the RDS process, in KB units. |  ≥ 0 KB       | 1 minute                |
| `rds082_semi_sync_tx_avg_wait_time`                        | Average Transaction Wait Time            | Monitor the average wait time in semi-synchronous replication mode, in microseconds. | ≥ 0 μs        | 1 minute                |
| `rds173_replication_delay_avg`                        | Average Replication Delay                     | This metric represents the average delay between the standby or read-only database and the primary database, corresponding to seconds_behind_master |  ≥ 0 s        | 1 minute                |
| `rds_buffer_pool_wait_free`                        | Buffer Pool Idle Page Wait Count                 | This metric is used to count the number of waits for idle pages in the InnoDB buffer pool. |  ≥ 0 ms        | 1 minute                |
| `rds_bytes_recv_rate`                        | Database Bytes Received Per Second                         | This metric is used to count the number of bytes received by the database per second, in bytes/second. |  ≥ 0 bytes/s        | 1 minute                |
| `rds_bytes_sent_rate`                        | Database Bytes Sent Per Second                         | This metric is used to count the number of bytes sent by the database per second, in bytes/second. |  ≥ 0 bytes/s        | 1 minute                |
| `rds_conn_active_usage`                        | Active Connection Usage Rate                         | This metric counts the ratio of active connections to the maximum number of connections, in percentage units. |  0-100%        | 1 minute                |
| `rds_created_tmp_tables_rate`                        | Temporary Tables Created Per Second                         | This metric is used to count the number of temporary tables created per second, in counts/second. | ≥ 0 counts/s        | 1 minute                |
| `rds_innodb_buffer_pool_pages_flushed_rate`                        | innodb_buffer_pool Pages Flushed Per Second                         | This metric is used to count the number of pages flushed per second by the innodb_buffer_pool, in counts/second. |  ≥ 0 counts/s        | 1 minute                |
| `rds_innodb_buffer_pool_read_requests_rate`                        | innodb_buffer_pool Read Requests Per Second                         | This metric is used to count the number of read requests per second by the innodb_buffer_pool, in counts/second. |  ≥ 0 counts/s        | 1 minute                |
| `rds_innodb_buffer_pool_write_requests_rate`                        | innodb_buffer_pool Write Requests Per Second                         | This metric is used to count the number of write requests per second by the innodb_buffer_pool, in counts/second. |  ≥ 0 counts/s        | 1 minute                |
| `rds_innodb_lock_waits`                        | Waiting Row Lock Transactions                         | This metric is used to count the number of Innodb transactions currently waiting for row locks, in units. |  ≥ 0 counts        | 1 minute                |
| `rds_innodb_log_waits_count`                        | Log Wait Count                         | This metric is used to count the number of log waits, in units. | ≥ 0 counts       | 1 minute                |
| `rds_innodb_log_waits_rate`                        | Log Waits Due to Insufficient Log Buffer Causing Flush To Disk                         | This metric is used to count the number of times caused by insufficient log buffer leading to flushes to disk, in counts/second. | ≥ 0 counts       | 1 minute                |
| `rds_innodb_os_log_written_rate`                        | Average Size Written To Redo Log Per Second                         | This metric is used to count the average size written to redo log per second, in bytes/second. | ≥ 0 bytes/s       | 1 minute                |
| `rds_innodb_pages_read_rate`                        | innodb Average Data Read Per Second                         | This metric is used to count the average amount of data read per second by innodb, in pages/second. | ≥ 0 Pages/s      | 1 minute                |
| `rds_innodb_pages_written_rate`                        | innodb Average Data Written Per Second                        | This metric is used to count the average amount of data written per second by innodb, in pages/second. | ≥ 0 Pages/s       | 1 minute                |
| `rds_innodb_row_lock_current_waits`                        | Current Row Lock Waits                         | This metric is used to count the current number of Innodb row lock waits, in units. | ≥ 0 counts       | 1 minute                |
| `rds_innodb_row_lock_time_avg`                        | Average Row Lock Wait Time                         | This metric is used to count the average row lock wait time, in milliseconds. | ≥ 0 ms       | 1 minute                |
| `rds_wait_thread_count`                        | Waiting Thread Count                         | This metric is used to count the number of waiting threads, in units. | ≥ 0 counts       | 1 minute                |

## Objects {#object}

The collected Huawei Cloud RDS MariaDB object data structure can be seen in "Infrastructure - Resource Catalog"

```json
{
  "measurement": "huaweicloud_rds_mariadb",
  "tags": {
    "RegionId"               : "cn-south-1",
    "project_id"             : "c631f046252dxxxxxxxf253c62d48585",
    "enterprise_project_id"  : "o78hhbss-xxxx-xxxx-xxxx-cba3d38cf2f9",
    "instance_id"            : "1d0c91561f4644dxxxxxx68304b0520din01",
    "instance_name"          : "rds-xxxx",
    "status"                 : "ACTIVE",
    "type"                   : "Ha",
    "engine"                 : "MariaDB"
  },
  "fields": {
    "security_group_id"      : "9e5bd45e-0564-445f-xxxx-2c8954e2d99c", 
    "security_group_id"      : "9e5bd45e-0564-445f-xxxx-2c8954e2d99c", 
    "time_zone"              : "China Standard Time", 
    "enable_ssl"             : "True",
    "charge_info.charge_mode": "postPaid",
    "engine_version"         : "10.5",
    "created_time"           : "2024-11-12T06:31:07+0000",
    "updated_time"           : "2024-11-12T07:45:54+0000",
    "private_ips"            : "[\"192.x.x.35\"]",
    "public_ips"             : "[]",
    "datastore"              : "{Instance JSON data}",
    "cpu"                    : "4",
    "mem"                    : "8",
    "volume"                 : "{Volume information}",
    "nodes"                  : "[{Primary/Secondary instance information}]",
    "related_instance"       : "[]",
    "backup_strategy"        : "{Backup strategy}",
    "datastore"              : {}
  }
}
```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.instance_id` is the instance ID, serving as a unique identifier.
>
> Tip 2: The following fields are serialized JSON strings:
>
> - `fields.private_ips`
> - `fields.public_ips`
> - `fields.volume`
> - `fields.nodes`
> - `fields.related_instance`
> - `fields.backup_strategy`
>
> Tip 3: The value of `type` can be “Single”, “Ha”, “Replica”, or "Enterprise", corresponding respectively to single-instance, master-slave instance, read-only instance, and distributed instance (Enterprise Edition).