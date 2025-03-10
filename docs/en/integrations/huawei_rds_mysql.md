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

Collect Huawei Cloud RDS MYSQL Data

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - Extensions - Managed Func: all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a qualified Huawei Cloud AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of Huawei Cloud RDS MYSQL, we install the corresponding collection scripts:

- **guance_huaweicloud_rds**: Collects monitoring metrics data
- **guance_huaweicloud_rds_slowlog_detail**: Collects detailed slow query logs
- **guance_huaweicloud_rds_slowlog**: Collects statistical slow query logs

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy startup script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script automatically.

Once the script is installed, find the script 「Guance Integration (Huawei Cloud-RDS Collection)」/「Guance Integration (Huawei Cloud-RDS Slow Query Detail Log Collection)」/「Guance Integration (Huawei Cloud-RDS Slow Query Statistical Log Collection)」 under Func's 「Development」 section, expand and modify this script. Find and edit the contents of `collector_configs` and `monitor_configs` under `region_projects`, changing the region and Project ID to the actual values, then click Save and Publish.

Additionally, view the corresponding automatic trigger configuration under 「Management / Automatic Trigger Configuration」. Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.

### Verification

1. In 「Management / Automatic Trigger Configuration」 confirm that the corresponding tasks have corresponding automatic trigger configurations, and you can check the corresponding task records and logs to see if there are any abnormalities.
2. On the Guance platform, go to 「Infrastructure / Custom」 to check if asset information exists.
3. On the Guance platform, go to 「Metrics」 to check if there are corresponding monitoring data.
4. On the Guance platform, go to 「Logs」 to check if there are corresponding slow log data.

## Metrics {#metric}

Configure Huawei Cloud RDS MYSQL monitoring metrics; more metrics can be collected through configuration [Huawei Cloud RDS MYSQL Metrics Details](https://support.huaweicloud.com/usermanual-rds/rds_06_0001.html){:target="_blank"}

### Instance Monitoring Metrics

RDS for MySQL instance performance monitoring metrics are shown in the following table.

| Metric ID                                       | Metric Name                                | Metric Meaning                                                     | Value Range           | Monitoring Period (Original Metric) |
| -------------------------------------------- | --------------------------------------- | ------------------------------------------------------------ | ------------------ | -------------------- |
| `rds001_cpu_util`                            | CPU Utilization                               | This metric measures the CPU utilization rate of the measurement object, in percentage units.            | 0-100%             | 1 minute 5 seconds 1 second          |
| `rds002_mem_util`                            | Memory Utilization                              | This metric measures the memory utilization rate of the measurement object, in percentage units.           | 0-100%             | 1 minute 5 seconds 1 second          |
| `rds003_iops`                                | IOPS                                    | This metric measures the number of I/O requests processed by the current instance per unit time (average). | ≥ 0 counts/s       | 1 minute                |
| `rds004_bytes_in`                                | Network Input Throughput                          | This metric measures the average flow of bytes input from all network adapters of the measurement object per second, in bytes/second. | ≥ 0 bytes/s        | 1 minute                |
| `rds005_bytes_out`                           | Network Output Throughput                          | This metric measures the average flow of bytes output from all network adapters of the measurement object per second, in bytes/second. | ≥ 0 bytes/s        | 1 minute                |
| `rds006_conn_count`                          | Total Database Connections                          | This metric measures the total number of connections attempting to connect to the MySQL server, in count units.  | ≥ 0 counts         | 1 minute 5 seconds 1 second          |
| `rds007_conn_active_count`                   | Current Active Connections                          | This metric measures the number of currently open connections, in count units.             | ≥ 0 counts         | 1 minute 5 seconds 1 second          |
| `rds008_qps`                                 | QPS                                     | This metric measures the number of SQL statement queries executed per second, including stored procedures, in queries/second.   | ≥ 0 queries/s      | 1 minute 5 seconds 1 second          |
| `rds009_tps`                                 | TPS                                     | This metric measures the number of transaction executions per second, including committed and rolled back transactions, in transactions/second. | ≥ 0 transactions/s | 1 minute 5 seconds 1 second          |
| `rds010_innodb_buf_usage`                    | Buffer Pool Usage Rate                            | This metric measures the ratio of idle pages to the total number of buffer pool pages in the **InnoDB** cache, in percentage units. | 0-1                | 1 minute                |
| `rds011_innodb_buf_hit`                      | Buffer Pool Hit Rate                            | This metric measures the ratio of read hits to read requests, in percentage units.           | 0-1                | 1 minute                |
| `rds012_innodb_buf_dirty`                    | Buffer Pool Dirty Block Rate                            | This metric measures the ratio of dirty data in the **InnoDB** cache to the used pages in the **InnoDB** cache, in percentage units. | 0-1                | 1 minute                |
| `rds013_innodb_reads`                        | **InnoDB** Read Throughput                    | This metric measures the average number of bytes read per second by **Innodb**, in bytes/second.  | ≥ 0 bytes/s        | 1 minute                |
| `rds014_innodb_writes`                       | **InnoDB** Write Throughput                    | This metric measures the average number of bytes written per second by **Innodb**, in bytes/second.  | ≥ 0 bytes/s        | 1 minute                |
| `rds015_innodb_read_count`                   | **InnoDB** File Read Frequency                  | This metric measures the average number of reads per second from files by **Innodb**, in counts/second. | ≥ 0 counts/s       | 1 minute                |
| `rds016_innodb_write_count`                  | **InnoDB** File Write Frequency                  | This metric measures the average number of writes per second to files by **Innodb**, in counts/second. | ≥ 0 counts/s       | 1 minute                |
| `rds017_innodb_log_write_req_count`          | **InnoDB** Log Write Request Frequency                | This metric measures the average number of log write requests per second, in counts/second.        | ≥ 0 counts/s       | 1 minute                |
| `rds018_innodb_log_write_count`              | **InnoDB** Log Physical Write Frequency                | This metric measures the average number of physical writes per second to log files, in counts/second. | ≥ 0 counts/s       | 1 minute                |
| `rds019_innodb_log_fsync_count`              | **InnoDB** Log fsync() Write Frequency             | This metric measures the average number of completed fsync() writes per second to log files, in counts/second. | ≥ 0 counts/s       | 1 minute                |
| `rds020_temp_tbl_rate`                       | Temporary Table Creation Rate                          | This metric measures the number of temporary tables created on disk per second, in counts/second.  | ≥ 0 counts/s       | 1 minute                |
| `rds021_myisam_buf_usage`                    | Key Buffer Utilization Rate                        | This metric measures the utilization rate of MyISAM Key buffer, in percentage units.      | 0-1                | 1 minute                |
| `rds022_myisam_buf_write_hit`                | Key Buffer Write Hit Rate                      | This metric measures the write hit rate of MyISAM Key buffer, in percentage units.      | 0-1                | 1 minute                |
| `rds023_myisam_buf_read_hit`                 | Key Buffer Read Hit Rate                      | This metric measures the read hit rate of MyISAM Key buffer, in percentage units.      | 0-1                | 1 minute                |
| `rds024_myisam_disk_write_count`             | MyISAM Disk Write Frequency                      | This metric measures the number of index writes to disk per second, in counts/second.          | ≥ 0 counts/s       | 1 minute                |
| `rds025_myisam_disk_read_count`              | MyISAM Disk Read Frequency                      | This metric measures the number of index reads from disk per second, in counts/second.          | ≥ 0 counts/s       | 1 minute                |
| `rds026_myisam_buf_write_count`              | MyISAM Buffer Pool Write Frequency                    | This metric measures the number of index write requests to the buffer pool per second, in counts/second.    | ≥ 0 counts/s       | 1 minute                |
| `rds027_myisam_buf_read_count`               | MyISAM Buffer Pool Read Frequency                    | This metric measures the number of index read requests from the buffer pool per second, in counts/second.    | ≥ 0 counts/s       | 1 minute                |
| `rds028_comdml_del_count`                    | Delete Statement Execution Frequency                      | This metric measures the average number of Delete statements executed per second, in queries/second.    | ≥ 0 queries/s      | 1 minute 5 seconds 1 second          |
| `rds029_comdml_ins_count`                    | Insert Statement Execution Frequency                      | This metric measures the average number of Insert statements executed per second, in queries/second.    | ≥ 0 queries/s      | 1 minute 5 seconds 1 second          |
| `rds030_comdml_ins_sel_count`                | Insert_Select Statement Execution Frequency               | This metric measures the average number of Insert_Select statements executed per second, in queries/second. | ≥ 0 queries/s      | 1 minute                |
| `rds031_comdml_rep_count`                    | Replace Statement Execution Frequency                     | This metric measures the average number of Replace statements executed per second, in queries/second.   | ≥ 0 queries/s      | 1 minute                |
| `rds032_comdml_rep_sel_count`                | Replace_Selection Statement Execution Frequency           | This metric measures the average number of Replace_Selection statements executed per second, in queries/second. | ≥ 0 queries/s      | 1 minute                |
| `rds033_comdml_sel_count`                    | Select Statement Execution Frequency                      | This metric measures the average number of Select statements executed per second.                   | ≥ 0 queries/s      | 1 minute 5 seconds 1 second          |
| `rds034_comdml_upd_count`                    | Update Statement Execution Frequency                      | This metric measures the average number of Update statements executed per second, in queries/second.    | ≥ 0 queries/s      | 1 minute 5 seconds 1 second          |
| `rds035_innodb_del_row_count`                | Row Deletion Rate                              | This metric measures the average number of rows deleted from **InnoDB** tables per second, in rows/second. | ≥ 0 rows/s         | 1 minute                |
| `rds036_innodb_ins_row_count`                | Row Insertion Rate                              | This metric measures the average number of rows inserted into **InnoDB** tables per second, in rows/second. | ≥ 0 rows/s         | 1 minute                |
| `rds037_innodb_read_row_count`               | Row Read Rate                              | This metric measures the average number of rows read from **InnoDB** tables per second, in rows/second. | ≥ 0 rows/s         | 1 minute                |
| `rds038_innodb_upd_row_count`                | Row Update Rate                              | This metric measures the average number of rows updated in **InnoDB** tables per second, in rows/second. | ≥ 0 rows/s         | 1 minute                |
| `rds039_disk_util`                           | Disk Utilization Rate                              | This metric measures the disk utilization rate of the measurement object, in percentage units.           | 0-100%             | 1 minute                |
| `rds047_disk_total_size`                     | Total Disk Size                              | This metric measures the total size of the disk of the measurement object.                         | 40GB~4000GB        | 1 minute                |
| `rds048_disk_used_size`                      | Disk Used Size                              | This metric measures the size of the disk used by the measurement object.                       | 0GB~4000GB         | 1 minute                |
| `rds049_disk_read_throughput`                | Disk Read Throughput                            | This metric measures the number of bytes read from the disk per second.                       | ≥ 0 bytes/s        | 1 minute                |
| `rds050_disk_write_throughput`               | Disk Write Throughput                            | This metric measures the number of bytes written to the disk per second.                         | ≥ 0 bytes/s        | 1 minute                |
| `rds072_conn_usage`                          | Connection Usage Rate                            | This metric measures the percentage of used MySQL connections out of the total connections.      | 0-100%             | 1 minute                |
| `rds173_replication_delay_avg`               | Average Replication Delay                            | This metric measures the average delay between the standby or read-only replica and the primary, corresponding to `seconds_behind_master`. It takes the average value over a 60-second period. | ≥ 0s               | 10 seconds                 |
| `rds073_replication_delay`                   | Real-time Replication Delay                            | This metric measures the real-time delay between the standby or read-only replica and the primary, corresponding to `seconds_behind_master`. This value is the real-time value. | ≥ 0s               | 1 minute 5 seconds             |
| `rds074_slow_queries`                        | Number of Slow Logs                             | This metric shows the number of slow logs generated by MySQL per minute.                  | ≥ 0                | 1 minute                |
| `rds075_avg_disk_ms_per_read`                | Disk Read Time                              | This metric measures the average time taken for each disk read over a certain period.             | ≥ 0ms              | 1 minute                |
| `rds076_avg_disk_ms_per_write`               | Disk Write Time                              | This metric measures the average time taken for each disk write over a certain period.                 | ≥ 0ms              | 1 minute                |
| `rds077_vma`                                 | VMA Count                                 | Monitors the size of virtual memory regions of the RDS process, in counts.                  | ≥ 0counts          | 1 minute                |
| `rds078_threads`                             | Number of Threads in Process                          | Monitors the number of threads in the RDS process, in counts.                        | ≥ 0counts          | 1 minute                |
| `rds079_vm_hwm`                              | Peak Physical Memory Usage of Process                  | Monitors the peak physical memory usage of the RDS process, in KB.                  | ≥ 0 KB             | 1 minute                |
| `rds080_vm_peak`                             | Peak Virtual Memory Usage of Process                  | Monitors the peak virtual memory usage of the RDS process, in KB.                  | ≥ 0 KB             | 1 minute                |
| `rds081_vm_ioutils`                          | Disk I/O Utilization Rate                           | Disk I/O utilization rate, in percentage units.                                | 0-1                | 1 minute                |
| `rds082_semi_sync_tx_avg_wait_time`          | Average Transaction Wait Time                        | Monitors the average wait time in semi-synchronous replication mode, in microseconds.             | ≥ 0 microseconds            | 1 minute                |
| `sys_swap_usage`                             | Swap Utilization Rate                              | This metric measures the swap utilization rate of the measurement object, in percentage units.           | 0-100%             | 1 minute                |
| `rds_innodb_lock_waits`                      | Number of Row Lock Waits                            | This metric measures the number of row lock waits in **Innodb**, in counts. Indicates the cumulative number of transactions waiting for row locks. Restarting clears the lock waits. | ≥ 0 counts         | 1 minute                |
| `rds_bytes_recv_rate`                        | Bytes Received per Second by Database                      | This metric measures the number of bytes received by the database per second, in bytes/second.          | ≥ 0 bytes/s        | 1 minute                |
| `rds_bytes_sent_rate`                        | Bytes Sent per Second by Database                      | This metric measures the number of bytes sent by the database per second, in bytes/second.          | ≥ 0 bytes/s        | 1 minute                |
| `rds_innodb_pages_read_rate`                 | Average Pages Read per Second by **Innodb**          | This metric measures the average number of pages read per second by **Innodb**, in pages/second. | ≥ 0 Pages/s        | 1 minute                |
| `rds_innodb_pages_written_rate`              | Average Pages Written per Second by **Innodb**          | This metric measures the average number of pages written per second by **Innodb**, in pages/second. | ≥ 0 Pages/s        | 1 minute                |
| `rds_innodb_os_log_written_rate`             | Average Redo Log Write Size per Second              | This metric measures the average redo log write size per second, in bytes/second.  | ≥ 0 bytes/s        | 1 minute                |
| `rds_innodb_buffer_pool_read_requests_rate`  | innodb_buffer_pool Read Requests per Second        | This metric measures the number of read requests per second by `innodb_buffer_pool`, in counts/second. | ≥ 0 counts/s       | 1 minute                |
| `rds_innodb_buffer_pool_write_requests_rate` | innodb_buffer_pool Write Requests per Second        | This metric measures the number of write requests per second by `innodb_buffer_pool`, in counts/second. | ≥ 0 counts/s       | 1 minute                |
| `rds_innodb_buffer_pool_pages_flushed_rate`  | innodb_buffer_pool Pages Flushed per Second        | This metric measures the number of pages flushed per second by `innodb_buffer_pool`, in counts/second. | ≥ 0 counts/s       | 1 minute                |
| `rds_innodb_log_waits_rate`                  | Number of Waits Due to Insufficient Log Buffer | This metric measures the number of waits due to insufficient log buffer, in counts/second. | ≥ 0 counts/s       | 1 minute                |
| `rds_created_tmp_tables_rate`                | Number of Temporary Tables Created per Second                        | This metric measures the number of temporary tables created per second, in counts/second.              | ≥ 0 counts/s       | 1 minute                |
| `rds_wait_thread_count`                      | Number of Waiting Threads                              | This metric measures the number of waiting threads, in counts.                       | ≥ 0 counts         | 1 minute                |
| `rds_innodb_row_lock_time_avg`               | Historical Average Row Lock Wait Time                    | This metric measures the historical average row lock wait time in **innodb**.               | > 0ms              | 1 minute                |
| `rds_innodb_row_lock_current_waits`          | Current Number of Row Lock Waits                          | This metric measures the current number of row lock waits in **innodb**, in counts. Represents the number of transactions currently waiting for row locks. | ≥ 0 counts         | 1 minute                |
| `rds_mdl_lock_count`                         | MDL Lock Count                               | This metric measures the number of MDL locks, in counts.                        | ≥ 0counts          | 1 minute                |
| `rds_buffer_pool_wait_free`                  | Number of Dirty Pages Waiting to Flush                      | This metric measures the number of dirty pages waiting to flush, in counts.                   | ≥ 0counts          | 1 minute                |
| `rds_conn_active_usage`                      | Active Connection Usage Rate                        | This metric measures the ratio of active connections to the maximum connection limit, in percentage units.       | 0-100%             | 1 minute                |
| `rds_innodb_log_waits_count`                 | Number of Log Waits                            | This metric measures the number of log waits, in counts.                     | ≥ 0counts          | 1 minute                |
| `rds_long_transaction`                       | Long Transaction Metric                              | This metric measures long transaction duration data, in seconds. Related operations commands must include both **BEGIN** and **COMMIT** commands to be considered a complete long transaction. | ≥ 0seconds         | 1 minute                |

RDS for MySQL database proxy monitoring metrics, as shown in [Table 2](https://support.huaweicloud.com/usermanual-rds/rds_06_0001.html#rds_06_0001__table1377262611585){:target="_blank"}.

| Metric ID                                 | Metric Name               | Metric Meaning                                                     | Value Range     | Monitoring Period (Original Metric) |
| -------------------------------------- | ---------------------- | ------------------------------------------------------------ | ------------ | -------------------- |
| rds001_cpu_util                        | CPU Utilization              | This metric measures the CPU utilization rate of the measurement object, in percentage units.            | 0-100%       | 1 minute 5 seconds 1 second          |
| rds002_mem_util                        | Memory Utilization             | This metric measures the memory utilization rate of the measurement object, in percentage units.           | 0-100%       | 1 minute 5 seconds 1 second          |
| rds004_bytes_in                        | Network Input Throughput         | This metric measures the average flow of bytes input from all network adapters of the measurement object per second, in bytes/second. | ≥ 0 bytes/s  | 1 minute                |
| rds005_bytes_out                       | Network Output Throughput         | This metric measures the average flow of bytes output from all network adapters of the measurement object per second, in bytes/second. | ≥ 0 bytes/s  | 1 minute                |
| rds_proxy_frontend_connections         | Frontend Connections             | Number of connections between applications and Proxy.                                    | ≥ 0 counts   | 1 minute                |
| rds_proxy_backend_connections          | Backend Connections             | Number of connections between Proxy and RDS database.                               | ≥ 0 counts   | 1 minute                |
| rds_proxy_average_response_time        | Average Response Time           | Average response time.                                               | ≥ 0 ms       | 1 minute                |
| rds_proxy_query_per_seconds            | QPS                    | Number of SQL statement queries executed per second.                                            | ≥ 0 counts   | 1 minute                |
| rds_proxy_read_query_proportions       | Read Proportion                 | Proportion of read requests among total requests.                                       | 0-100%       | 1 minute                |
| rds_proxy_write_query_proportions      | Write Proportion                 | Proportion of write requests among total requests.                                       | 0-100%       | 1 minute                |
| rds_proxy_frontend_connection_creation | Average Frontend Connections Created per Second | Measures the average number of frontend connections created per second by client applications targeting the database proxy service. | ≥ 0 counts/s | 1 minute                |
| rds_proxy_transaction_query            | Average Queries per Second in Transactions | Measures the average number of select executions per second within transactions                   | ≥ 0 counts/s | 1 minute                |
| rds_proxy_multi_statement_query        | Average Multi-Statements Executions per Second   | Measures the average number of multi-statements executions per second                     | ≥ 0 counts/s | 1 minute                |

## Object {#object}

The structure of the collected Huawei Cloud RDS MYSQL object data can be viewed in 「Infrastructure-Custom」.

```json
{
  "measurement": "huaweicloud_rds",
  "tags": {
    "name"                   : "1d0c91561f4644daxxxxx68304b0520din01",
    "id"                     : "1d0c91561f4644dxxxxxxd68304b0520din01",
    "instance_name"          : "rds-df54-xxxx",
    "status"                 : "ACTIVE",
    "port"                   : "3306",
    "type"                   : "Single",
    "RegionId"               : "cn-north-4",
    "security_group_id"      : "d13ebb59-d4fe-xxxx-xxxx-c22bcea6f987",
    "switch_strategy"        : "xxx",
    "project_id"             : "c631f046252dxxxxxxxf253c62d48585",
    "time_zone"              : "UTC+08:00",
    "enable_ssl"             : "False",
    "charge_info.charge_mode": "postPaid",
    "engine"                 : "MySQL",
    "engine_version"         : "5.7"
  },
  "fields": {
    "created_time"    : "2022-06-21T06:17:27+0000",
    "updated_time"    : "2022-06-21T06:20:03+0000",
    "alias"           : "xxx",
    "private_ips"     : "[\"192.xxx.x.144\"]",
    "public_ips"      : "[]",
    "datastore"       : "{Database Information}",
    "cpu"             : "2",
    "mem"             : "4",
    "volume"          : "{Volume Information}",
    "nodes"           : "[{Master-Slave Instance Information}]",
    "related_instance": "[]",
    "backup_strategy" : "{Backup Strategy}",
    "message"         : "{Instance JSON Data}"
  }
}
```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Note 1: The value of `tags.name` is the instance ID, serving as a unique identifier.
>
> Note 2: The following fields are serialized JSON strings:
>
> - `fields.message`
> - `fields.private_ips`
> - `fields.public_ips`
> - `fields.volume`
> - `fields.nodes`
> - `fields.related_instance`
> - `fields.backup_strategy`
>
> Note 3: The value of `type` can be "Single", "Ha", "Replica", or "Enterprise", corresponding to single-instance, master-slave instance, read-only instance, and distributed instance (enterprise edition), respectively.