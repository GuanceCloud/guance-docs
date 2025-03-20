---
title: 'Huawei Cloud RDS MYSQL'
tags: 
  - Huawei Cloud
summary: 'Collect Huawei Cloud RDS MYSQL data'
__int_icon: 'icon/huawei_rds_mysql'
dashboard:

  - desc: 'Huawei Cloud RDS MYSQL built-in views'
    path: 'dashboard/en/huawei_rds_mysql'

monitor:
  - desc: 'Huawei Cloud RDS MYSQL monitors'
    path: 'monitor/en/huawei_rds_mysql'

---

Collect Huawei Cloud RDS MYSQL data

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - managed Func: all prerequisites will be automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize the monitoring data of Huawei Cloud RDS MYSQL, we install the corresponding collection scripts:

- **guance_huaweicloud_rds**: Collects monitoring Metrics data
- **guance_huaweicloud_rds_slowlog_detail**: Collects detailed slow query log data
- **guance_huaweicloud_rds_slowlog**: Collects statistical slow query log data

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy Start Script】, and the system will automatically create a `Startup` script set, and automatically configure the corresponding start script.

After the script is installed, find the script "Guance Integration (Huawei Cloud-RDS Collection)" / "Guance Integration (Huawei Cloud-RDS Slow Query Detail Log Collection)" / "Guance Integration (Huawei Cloud-RDS Slow Query Statistical Log Collection)" under "Development" in Func, expand and modify this script. Find `collector_configs` and `monitor_configs`, and edit the content under `region_projects`. Change the region and Project ID to the actual region and Project ID, then click Save and Publish.

In addition, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click 【Execute】to immediately execute once without waiting for the regular time. After a while, you can view the execution task records and corresponding logs.

### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and at the same time, you can view the corresponding task records and logs to check for any abnormalities.
2. On the Guance platform, under "Infrastructure - Resource Catalog", check if there is asset information.
3. On the Guance platform, under "Metrics", check if there are corresponding monitoring data.
4. On the Guance platform, under "Logs", check if there are corresponding slow log data.

## Metrics {#metric}

Configure Huawei Cloud RDS MYSQL monitoring Metrics, which can collect more Metrics through configuration [Huawei Cloud RDS MYSQL Metrics Details](https://support.huaweicloud.com/usermanual-rds/rds_06_0001.html){:target="_blank"}

### Instance Monitoring Metrics

RDS for MySQL instance performance monitoring Metrics are shown in the following table.

| Metric ID                                       | Metric Name                                | Metric Meaning                                                     | Value Range           | Monitoring Period (Original Metric) |
| -------------------------------------------- | --------------------------------------- | ------------------------------------------------------------ | ------------------ | -------------------- |
| `rds001_cpu_util`                            | CPU Utilization                               | This metric is used to measure the CPU utilization of the object, as a ratio unit.            | 0-100%             | 1 minute 5 seconds 1 second          |
| `rds002_mem_util`                            | Memory Utilization                              | This metric is used to measure the memory utilization of the object, as a ratio unit.           | 0-100%             | 1 minute 5 seconds 1 second          |
| `rds003_iops`                                | IOPS                                    | This metric is used to measure the number of I/O requests processed by the system per unit time for the current instance (average value). | ≥ 0 counts/s       | 1 minute                |
| `rds004_bytes_in`                            | Network Input Throughput                          | This metric is used to measure the average traffic input from all network adapters of the measurement object per second, in bytes/second. | ≥ 0 bytes/s        | 1 minute                |
| `rds005_bytes_out`                           | Network Output Throughput                          | This metric is used to measure the average traffic output from all network adapters of the measurement object per second, in bytes/second. | ≥ 0 bytes/s        | 1 minute                |
| `rds006_conn_count`                          | Total Database Connections                          | This metric is used to measure the total number of connections attempting to connect to the MySQL server, in units.  | ≥ 0 counts         | 1 minute 5 seconds 1 second          |
| `rds007_conn_active_count`                   | Current Active Connections                          | This metric is used to measure the number of currently open connections, in units.             | ≥ 0 counts         | 1 minute 5 seconds 1 second          |
| `rds008_qps`                                 | QPS                                     | This metric is used to measure the number of SQL statement queries, including stored procedures, in units of times/second.   | ≥ 0 queries/s      | 1 minute 5 seconds 1 second          |
| `rds009_tps`                                 | TPS                                     | This metric is used to measure the number of transaction executions, including committed and rolled back, in units of times/second. | ≥ 0 transactions/s | 1 minute 5 seconds 1 second          |
| `rds010_innodb_buf_usage`                    | Buffer Pool Utilization                            | This metric is used to measure the ratio of idle pages to the total number of pages in the **InnoDB** cache buffer pool, as a ratio unit. | 0-1                | 1 minute                |
| `rds011_innodb_buf_hit`                      | Buffer Pool Hit Rate                            | This metric is used to measure the ratio of read hits to read requests, as a ratio unit.           | 0-1                | 1 minute                |
| `rds012_innodb_buf_dirty`                    | Buffer Pool Dirty Block Rate                            | This metric is used to measure the ratio of dirty data in the **InnoDB** cache to the pages used in the **InnoDB** cache, as a ratio unit. | 0-1                | 1 minute                |
| `rds013_innodb_reads`                        | **InnoDB** Read Throughput                    | This metric is used to measure the average number of bytes read per second by **Innodb**, in bytes/second.  | ≥ 0 bytes/s        | 1 minute                |
| `rds014_innodb_writes`                       | **InnoDB** Write Throughput                    | This metric is used to measure the average number of bytes written per second by **Innodb**, in bytes/second.  | ≥ 0 bytes/s        | 1 minute                |
| `rds015_innodb_read_count`                   | **InnoDB** File Read Frequency                  | This metric is used to measure the average number of reads from files per second by **Innodb**, in times/second. | ≥ 0 counts/s       | 1 minute                |
| `rds016_innodb_write_count`                  | **InnoDB** File Write Frequency                  | This metric is used to measure the average number of writes to files per second by **Innodb**, in times/second. | ≥ 0 counts/s       | 1 minute                |
| `rds017_innodb_log_write_req_count`          | **InnoDB** Log Write Request Frequency                | This metric is used to measure the average number of log write requests per second, in times/second.        | ≥ 0 counts/s       | 1 minute                |
| `rds018_innodb_log_write_count`              | **InnoDB** Log Physical Write Frequency                | This metric is used to measure the average number of physical writes to log files per second, in times/second. | ≥ 0 counts/s       | 1 minute                |
| `rds019_innodb_log_fsync_count`              | **InnoDB** Log fsync() Write Frequency             | This metric is used to measure the average number of completed fsync() writes to log files per second, in times/second. | ≥ 0 counts/s       | 1 minute                |
| `rds020_temp_tbl_rate`                       | Temporary Table Creation Rate                          | This metric is used to measure the number of temporary tables created on the hard disk per second, in units/second.  | ≥ 0 counts/s       | 1 minute                |
| `rds021_myisam_buf_usage`                    | Key Buffer Utilization                        | This metric is used to measure the utilization of MyISAM Key buffer, as a ratio unit.      | 0-1                | 1 minute                |
| `rds022_myisam_buf_write_hit`                | Key Buffer Write Hit Rate                      | This metric is used to measure the write hit rate of MyISAM Key buffer, as a ratio unit.      | 0-1                | 1 minute                |
| `rds023_myisam_buf_read_hit`                 | Key Buffer Read Hit Rate                      | This metric is used to measure the read hit rate of MyISAM Key buffer, as a ratio unit.      | 0-1                | 1 minute                |
| `rds024_myisam_disk_write_count`             | MyISAM Disk Write Frequency                      | This metric is used to measure the number of index writes to disk, in times/second.          | ≥ 0 counts/s       | 1 minute                |
| `rds025_myisam_disk_read_count`              | MyISAM Disk Read Frequency                      | This metric is used to measure the number of index reads from disk, in times/second.          | ≥ 0 counts/s       | 1 minute                |
| `rds026_myisam_buf_write_count`              | MyISAM Buffer Pool Write Frequency                    | This metric is used to measure the number of index write requests to the buffer pool, in times/second.    | ≥ 0 counts/s       | 1 minute                |
| `rds027_myisam_buf_read_count`               | MyISAM Buffer Pool Read Frequency                    | This metric is used to measure the number of index read requests from the buffer pool, in times/second.    | ≥ 0 counts/s       | 1 minute                |
| `rds028_comdml_del_count`                    | Delete Statement Execution Frequency                      | This metric is used to measure the average number of Delete statements executed per second, in times/second.    | ≥ 0 queries/s      | 1 minute 5 seconds 1 second          |
| `rds029_comdml_ins_count`                    | Insert Statement Execution Frequency                      | This metric is used to measure the average number of Insert statements executed per second, in times/second.    | ≥ 0 queries/s      | 1 minute 5 seconds 1 second          |
| `rds030_comdml_ins_sel_count`                | Insert_Select Statement Execution Frequency               | This metric is used to measure the average number of Insert_Select statements executed per second, in times/second. | ≥ 0 queries/s      | 1 minute                |
| `rds031_comdml_rep_count`                    | Replace Statement Execution Frequency                     | This metric is used to measure the average number of Replace statements executed per second, in times/second.   | ≥ 0 queries/s      | 1 minute                |
| `rds032_comdml_rep_sel_count`                | Replace_Selection Statement Execution Frequency           | This metric is used to measure the average number of Replace_Selection statements executed per second, in times/second. | ≥ 0 queries/s      | 1 minute                |
| `rds033_comdml_sel_count`                    | Select Statement Execution Frequency                      | This metric is used to measure the average number of Select statements executed per second.                   | ≥ 0 queries/s      | 1 minute 5 seconds 1 second          |
| `rds034_comdml_upd_count`                    | Update Statement Execution Frequency                      | This metric is used to measure the average number of Update statements executed per second, in times/second.    | ≥ 0 queries/s      | 1 minute 5 seconds 1 second          |
| `rds035_innodb_del_row_count`                | Row Deletion Rate                              | This metric is used to measure the average number of rows deleted from the **InnoDB** table per second, in rows/second. | ≥ 0 rows/s         | 1 minute                |
| `rds036_innodb_ins_row_count`                | Row Insertion Rate                              | This metric is used to measure the average number of rows inserted into the **InnoDB** table per second, in rows/second. | ≥ 0 rows/s         | 1 minute                |
| `rds037_innodb_read_row_count`               | Row Read Rate                              | This metric is used to measure the average number of rows read from the **InnoDB** table per second, in rows/second. | ≥ 0 rows/s         | 1 minute                |
| `rds038_innodb_upd_row_count`                | Row Update Rate                              | This metric is used to measure the average number of rows updated in the **InnoDB** table per second, in rows/second. | ≥ 0 rows/s         | 1 minute                |
| `rds039_disk_util`                           | Disk Utilization                              | This metric is used to measure the disk utilization of the measurement object, as a ratio unit.           | 0-100%             | 1 minute                |
| `rds047_disk_total_size`                     | Total Disk Size                              | This metric is used to measure the total disk size of the measurement object.                         | 40GB~4000GB        | 1 minute                |
| `rds048_disk_used_size`                      | Disk Usage                              | This metric is used to measure the disk usage size of the measurement object.                       | 0GB~4000GB         | 1 minute                |
| `rds049_disk_read_throughput`                | Hard Disk Read Throughput                            | This metric is used to measure the number of bytes read from the hard disk per second.                       | ≥ 0 bytes/s        | 1 minute                |
| `rds050_disk_write_throughput`               | Hard Disk Write Throughput                            | This metric is used to measure the number of bytes written to the hard disk per second.                         | ≥ 0 bytes/s        | 1 minute                |
| `rds072_conn_usage`                          | Connection Usage Rate                            | This metric is used to measure the percentage of currently used MySQL connections out of the total connections.      | 0-100%             | 1 minute                |
| `rds173_replication_delay_avg`               | Average Replication Delay                            | This metric represents the average delay between the standby or read-only replica and the primary, corresponding to seconds_behind_master. It takes the average over a 60-second period. | ≥ 0s               | 10 seconds                 |
| `rds073_replication_delay`                   | Real-time Replication Delay                            | This metric represents the real-time delay between the standby or read-only replica and the primary, corresponding to seconds_behind_master. This value is the real-time value. | ≥ 0s               | 1 minute 5 seconds             |
| `rds074_slow_queries`                        | Slow Log Count Statistics                          | This metric is used to display the number of slow logs generated by MySQL per minute.                  | ≥ 0                | 1 minute                |
| `rds075_avg_disk_ms_per_read`                | Hard Disk Read Time                              | This metric is used to measure the average time taken to read from the disk during a certain period.             | ≥ 0ms              | 1 minute                |
| `rds076_avg_disk_ms_per_write`               | Hard Disk Write Time                              | This metric is used to measure the average time taken to write to the disk during a certain period.                 | ≥ 0ms              | 1 minute                |
| `rds077_vma`                                 | VMA Count                                 | Monitors the size of virtual memory regions for the RDS process, in units.                  | ≥ 0counts          | 1 minute                |
| `rds078_threads`                             | Number of Threads in Process                          | Monitors the number of threads in the RDS process, in units.                        | ≥ 0counts          | 1 minute                |
| `rds079_vm_hwm`                              | Peak Physical Memory Usage of Process                  | Monitors the peak physical memory usage of the RDS process, in KB.                  | ≥ 0 KB             | 1 minute                |
| `rds080_vm_peak`                             | Peak Virtual Memory Usage of Process                  | Monitors the peak virtual memory usage of the RDS process, in KB.                  | ≥ 0 KB             | 1 minute                |
| `rds081_vm_ioutils`                          | Disk I/O Utilization                           | Disk I/O utilization, as a ratio unit.                                | 0-1                | 1 minute                |
| `rds082_semi_sync_tx_avg_wait_time`          | Average Transaction Wait Time                        | Monitors the average wait time in semi-synchronous replication mode, in microseconds.             | ≥ 0 microseconds            | 1 minute                |
| `sys_swap_usage`                             | Swap Utilization                              | This metric is used to measure the swap utilization of the measurement object, as a ratio unit.           | 0-100%             | 1 minute                |
| `rds_innodb_lock_waits`                      | Row Lock Waits Count                            | This metric is used to measure the count of **Innodb** row lock waits, in units. Represents the cumulative number of transactions waiting for row locks historically. Restart clears the lock waits. | ≥ 0 counts         | 1 minute                |
| `rds_bytes_recv_rate`                        | Database Bytes Received Per Second                      | This metric is used to measure the database bytes received per second, in bytes/second.          | ≥ 0 bytes/s        | 1 minute                |
| `rds_bytes_sent_rate`                        | Database Bytes Sent Per Second                      | This metric is used to measure the database bytes sent per second, in bytes/second.          | ≥ 0 bytes/s        | 1 minute                |
| `rds_innodb_pages_read_rate`                 | **Innodb** Average Data Read Per Second          | This metric is used to measure the average data read by **Innodb** per second, in pages/second. | ≥ 0 Pages/s        | 1 minute                |
| `rds_innodb_pages_written_rate`              | **Innodb** Average Data Written Per Second          | This metric is used to measure the average data written by **Innodb** per second, in pages/second. | ≥ 0 Pages/s        | 1 minute                |
| `rds_innodb_os_log_written_rate`             | Average Size of redo log Written Per Second              | This metric is used to measure the average size of redo log written per second, in bytes/second.  | ≥ 0 bytes/s        | 1 minute                |
| `rds_innodb_buffer_pool_read_requests_rate`  | innodb_buffer_pool Read Requests Per Second        | This metric is used to measure the number of read requests per second by innodb_buffer_pool, in counts/second. | ≥ 0 counts/s       | 1 minute                |
| `rds_innodb_buffer_pool_write_requests_rate` | innodb_buffer_pool Write Requests Per Second        | This metric is used to measure the number of write requests per second by innodb_buffer_pool, in counts/second. | ≥ 0 counts/s       | 1 minute                |
| `rds_innodb_buffer_pool_pages_flushed_rate`  | innodb_buffer_pool Page Flushes Per Second        | This metric is used to measure the number of page flushes per second by innodb_buffer_pool, in counts/second. | ≥ 0 counts/s       | 1 minute                |
| `rds_innodb_log_waits_rate`                  | Flush to Disk Waits Due to Insufficient Log Buffer | This metric is used to measure the number of flushes to disk per second due to insufficient log buffer, in counts/second. | ≥ 0 counts/s       | 1 minute                |
| `rds_created_tmp_tables_rate`                | Temporary Tables Created Per Second                        | This metric is used to measure the number of temporary tables created per second, in units/second.              | ≥ 0 counts/s       | 1 minute                |
| `rds_wait_thread_count`                      | Waiting Thread Count                              | This metric is used to measure the waiting thread count, in units.                       | ≥ 0 counts         | 1 minute                |
| `rds_innodb_row_lock_time_avg`               | Historical Average Row Lock Wait Time                    | This metric is used to measure the historical average row lock wait time for **innodb**.               | > 0ms              | 1 minute                |
| `rds_innodb_row_lock_current_waits`          | Current Row Lock Waits Count                          | This metric is used to measure the current row lock waits count for **innodb**, in units. Represents the number of transactions currently waiting for row locks. | ≥ 0 counts         | 1 minute                |
| `rds_mdl_lock_count`                         | MDL Lock Count                               | This metric is used to measure the MDL lock count, in units.                        | ≥ 0counts          | 1 minute                |
| `rds_buffer_pool_wait_free`                  | Dirty Pages Waiting to Be Flushed Count                      | This metric measures the count of dirty pages waiting to be flushed, in units.                   | ≥ 0counts          | 1 minute                |
| `rds_conn_active_usage`                      | Active Connection Usage Rate                        | This metric measures the ratio of active connections to maximum connections, as a ratio unit.       | 0-100%             | 1 minute                |
| `rds_innodb_log_waits_count`                 | Log Wait Count                            | This metric is used to measure the log wait count, in units.                     | ≥ 0counts          | 1 minute                |
| `rds_long_transaction`                       | Long Transaction Metric                              | This metric measures the duration of long transactions, in seconds. Related operations commands must include both **BEGIN** and **COMMIT** commands to count as a complete long transaction. | ≥ 0seconds         | 1 minute                |

RDS for MySQL database proxy monitoring Metrics, as shown in [Table 2](https://support.huaweicloud.com/usermanual-rds/rds_06_0001.html#rds_06_0001__table1377262611585){:target="_blank"}.

| Metric ID                                 | Metric Name               | Metric Meaning                                                     | Value Range     | Monitoring Period (Original Metric) |
| -------------------------------------- | ---------------------- | ------------------------------------------------------------ | ------------ | -------------------- |
| rds001_cpu_util                        | CPU Utilization              | This metric is used to measure the CPU utilization of the object, as a ratio unit.            | 0-100%       | 1 minute 5 seconds 1 second          |
| rds002_mem_util                        | Memory Utilization             | This metric is used to measure the memory utilization of the object, as a ratio unit.           | 0-100%       | 1 minute 5 seconds 1 second          |
| rds004_bytes_in                        | Network Input Throughput         | This metric is used to measure the average traffic input from all network adapters of the measurement object per second, in bytes/second. | ≥ 0 bytes/s  | 1 minute                |
| rds005_bytes_out                       | Network Output Throughput         | This metric is used to measure the average traffic output from all network adapters of the measurement object per second, in bytes/second. | ≥ 0 bytes/s  | 1 minute                |
| rds_proxy_frontend_connections         | Frontend Connections             | The number of connections between the application and Proxy.                                    | ≥ 0 counts   | 1 minute                |
| rds_proxy_backend_connections          | Backend Connections             | The number of connections between Proxy and RDS database.                               | ≥ 0 counts   | 1 minute                |
| rds_proxy_average_response_time        | Average Response Time           | Average response time.                                               | ≥ 0 ms       | 1 minute                |
| rds_proxy_query_per_seconds            | QPS                    | Number of SQL statement queries.                                            | ≥ 0 counts   | 1 minute                |
| rds_proxy_read_query_proportions       | Read Proportion                 | The proportion of read requests to total requests.                                       | 0-100%       | 1 minute                |
| rds_proxy_write_query_proportions      | Write Proportion                 | The proportion of write requests to total requests.                                       | 0-100%       | 1 minute                |
| rds_proxy_frontend_connection_creation | Average Frontend Connections Created Per Second | Measures the average number of frontend connections created per second by client applications targeting the database proxy service. | ≥ 0 counts/s | 1 minute                |
| rds_proxy_transaction_query            | Average Queries in Transactions Per Second | Measures the average number of queries included in transactions executed per second. | ≥ 0 counts/s | 1 minute                |
| rds_proxy_multi_statement_query        | Average Multi-Statement Queries Per Second   | Measures the average number of Multi-Statements queries executed per second. | ≥ 0 counts/s | 1 minute                |

## Objects {#object}

The collected Huawei Cloud RDS MYSQL object data structure can be seen under "Infrastructure - Resource Catalog".

```json
{
  "measurement": "huaweicloud_rds",
  "tags": {
    "RegionId"               : "cn-north-4",
    "project_id"             : "c631f046252dxxxxxxxf253c62d48585",
    "enterprise_project_id"  : "d13ebb59-d4fe-xxxx-xxxx-zc22bcea6f987",
    "instance_id"            : "1d0c91561f4644dxxxxxxd68304b0520din01",
    "instance_name"          : "rds-df54-xxxx",
    "status"                 : "ACTIVE",
    "type"                   : "Single",
    "engine"                 : "MySQL"
  },
  "fields": {
    "engine_version"         : "5.7",
    "port"                   : "3306",
    "security_group_id"      : "d13ebb59-d4fe-xxxx-xxxx-c22bcea6f987",
    "switch_strategy"        : "xxx",
    "enable_ssl"             : "False",
    "time_zone"              : "UTC+08:00",
    "created_time"           : "2022-06-21T06:17:27+0000",
    "updated_time"           : "2022-06-21T06:20:03+0000",
    "expiration_time"        : "2022-06-23T06:20:03+0000",
    "alias"                  : "xxx",
    "private_ips"            : "[\"192.xxx.x.144\"]",
    "public_ips"             : "[]",
    "cpu"                    : "2",
    "mem"                    : "4",
    "volume"                 : "{volume info}",
    "nodes"                  : "[{primary-secondary instance info}]",
    "related_instance"       : "[]",
    "backup_strategy"        : "{database info}"
  }
}
```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.instance_id` is the instance ID, used for unique identification.
>
> Tip 2: The following fields are JSON serialized strings:
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