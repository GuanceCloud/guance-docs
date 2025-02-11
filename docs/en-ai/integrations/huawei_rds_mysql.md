---
title: 'Huawei Cloud RDS MySQL'
tags: 
  - Huawei Cloud
summary: 'Collecting Huawei Cloud RDS MySQL data'
__int_icon: 'icon/huawei_rds_mysql'
dashboard:

  - desc: 'Built-in views for Huawei Cloud RDS MySQL'
    path: 'dashboard/en/huawei_rds_mysql'

monitor:
  - desc: 'Monitors for Huawei Cloud RDS MySQL'
    path: 'monitor/en/huawei_rds_mysql'

---

Collecting Huawei Cloud RDS MySQL Data

## Configuration {#config}

### Installing Func

We recommend enabling the Guance integration - Extensions - DataFlux Func (Automata): All prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installing Scripts

> Tip: Prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data from Huawei Cloud RDS MySQL, we install the corresponding collection scripts:

- **guance_huaweicloud_rds**: Collects monitoring metrics data
- **guance_huaweicloud_rds_slowlog_detail**: Collects detailed slow query logs
- **guance_huaweicloud_rds_slowlog**: Collects summarized slow query logs

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy Startup Script】; the system will automatically create a `Startup` script set and configure the startup scripts accordingly.

Once the script is installed, find the script 「Guance Integration (Huawei Cloud-RDS Collection)」/「Guance Integration (Huawei Cloud-RDS Slow Query Detail Log Collection)」/「Guance Integration (Huawei Cloud-RDS Slow Query Summary Log Collection)」 under 「Development」 in Func, unfold and modify this script. Find `collector_configs` and `monitor_configs` and edit the contents of `region_projects`, changing the region and Project ID to the actual values, then click Save and Publish.

Additionally, view the corresponding automatic trigger configuration under 「Management / Automatic Trigger Configuration」. Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.

### Verification

1. Under 「Management / Automatic Trigger Configuration」, confirm whether the corresponding tasks have an automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. On the Guance platform, under 「Metrics」, check if corresponding monitoring data exists.
4. On the Guance platform, under 「Logs」, check if corresponding slow log data exists.

## Metrics {#metric}

Configure Huawei Cloud RDS MySQL monitoring metrics. More metrics can be collected through configuration [Huawei Cloud RDS MySQL Metric Details](https://support.huaweicloud.com/usermanual-rds/rds_06_0001.html){:target="_blank"}

### Instance Monitoring Metrics

RDS for MySQL instance performance monitoring metrics are as follows:

| Metric ID                                       | Metric Name                                | Metric Meaning                                                     | Value Range           | Monitoring Period (Original Metric) |
| -------------------------------------------- | --------------------------------------- | ------------------------------------------------------------ | ------------------ | -------------------- |
| `rds001_cpu_util`                            | CPU Utilization                               | This metric measures the CPU utilization of the measurement object, in percentage.            | 0-100%             | 1 minute 5 seconds 1 second          |
| `rds002_mem_util`                            | Memory Utilization                              | This metric measures the memory utilization of the measurement object, in percentage.           | 0-100%             | 1 minute 5 seconds 1 second          |
| `rds003_iops`                                | IOPS                                    | This metric measures the number of I/O operations processed by the system per unit time (average). | ≥ 0 counts/s       | 1 minute                |
| `rds004_bytes_in`                            | Network Input Throughput                          | This metric measures the average traffic input per second from all network adapters of the measurement object, in bytes/second. | ≥ 0 bytes/s        | 1 minute                |
| `rds005_bytes_out`                           | Network Output Throughput                          | This metric measures the average traffic output per second from all network adapters of the measurement object, in bytes/second. | ≥ 0 bytes/s        | 1 minute                |
| `rds006_conn_count`                          | Total Database Connections                          | This metric measures the total number of attempts to connect to the MySQL server, in units.  | ≥ 0 counts         | 1 minute 5 seconds 1 second          |
| `rds007_conn_active_count`                   | Current Active Connections                          | This metric measures the number of currently open connections, in units.             | ≥ 0 counts         | 1 minute 5 seconds 1 second          |
| `rds008_qps`                                 | QPS                                     | This metric measures the number of SQL query executions per second, including stored procedures, in queries/second.   | ≥ 0 queries/s      | 1 minute 5 seconds 1 second          |
| `rds009_tps`                                 | TPS                                     | This metric measures the number of transaction executions per second, including committed and rolled back transactions, in transactions/second. | ≥ 0 transactions/s | 1 minute 5 seconds 1 second          |
| `rds010_innodb_buf_usage`                    | Buffer Pool Utilization                            | This metric measures the ratio of idle pages to the total number of buffer pool pages in **InnoDB** cache, in percentage. | 0-1                | 1 minute                |
| `rds011_innodb_buf_hit`                      | Buffer Pool Hit Rate                            | This metric measures the ratio of read hits to read requests, in percentage.           | 0-1                | 1 minute                |
| `rds012_innodb_buf_dirty`                    | Buffer Pool Dirty Pages Rate                            | This metric measures the ratio of dirty data in **InnoDB** cache to used pages in **InnoDB** cache, in percentage. | 0-1                | 1 minute                |
| `rds013_innodb_reads`                        | **InnoDB** Read Throughput                    | This metric measures the average number of bytes read per second by **Innodb**, in bytes/second.  | ≥ 0 bytes/s        | 1 minute                |
| `rds014_innodb_writes`                       | **InnoDB** Write Throughput                    | This metric measures the average number of bytes written per second by **Innodb**, in bytes/second.  | ≥ 0 bytes/s        | 1 minute                |
| `rds015_innodb_read_count`                   | **InnoDB** File Read Frequency                  | This metric measures the average number of reads per second from files by **Innodb**, in counts/second. | ≥ 0 counts/s       | 1 minute                |
| `rds016_innodb_write_count`                  | **InnoDB** File Write Frequency                  | This metric measures the average number of writes per second to files by **Innodb**, in counts/second. | ≥ 0 counts/s       | 1 minute                |
| `rds017_innodb_log_write_req_count`          | **InnoDB** Log Write Request Frequency                | This metric measures the average number of log write requests per second, in counts/second.        | ≥ 0 counts/s       | 1 minute                |
| `rds018_innodb_log_write_count`              | **InnoDB** Log Physical Write Frequency                | This metric measures the average number of physical writes to log files per second, in counts/second. | ≥ 0 counts/s       | 1 minute                |
| `rds019_innodb_log_fsync_count`              | **InnoDB** Log fsync() Write Frequency             | This metric measures the average number of fsync() writes completed to log files per second, in counts/second. | ≥ 0 counts/s       | 1 minute                |
| `rds020_temp_tbl_rate`                       | Temporary Table Creation Rate                          | This metric measures the number of temporary tables created on disk per second, in counts/second.  | ≥ 0 counts/s       | 1 minute                |
| `rds021_myisam_buf_usage`                    | Key Buffer Utilization                        | This metric measures the utilization rate of MyISAM Key buffer, in percentage.      | 0-1                | 1 minute                |
| `rds022_myisam_buf_write_hit`                | Key Buffer Write Hit Rate                      | This metric measures the write hit rate of MyISAM Key buffer, in percentage.      | 0-1                | 1 minute                |
| `rds023_myisam_buf_read_hit`                 | Key Buffer Read Hit Rate                      | This metric measures the read hit rate of MyISAM Key buffer, in percentage.      | 0-1                | 1 minute                |
| `rds024_myisam_disk_write_count`             | MyISAM Disk Write Frequency                      | This metric measures the number of index writes to disk per second, in counts/second.          | ≥ 0 counts/s       | 1 minute                |
| `rds025_myisam_disk_read_count`              | MyISAM Disk Read Frequency                      | This metric measures the number of index reads from disk per second, in counts/second.          | ≥ 0 counts/s       | 1 minute                |
| `rds026_myisam_buf_write_count`              | MyISAM Buffer Pool Write Frequency                    | This metric measures the number of index write requests to buffer pool per second, in counts/second.    | ≥ 0 counts/s       | 1 minute                |
| `rds027_myisam_buf_read_count`               | MyISAM Buffer Pool Read Frequency                    | This metric measures the number of index read requests from buffer pool per second, in counts/second.    | ≥ 0 counts/s       | 1 minute                |
| `rds028_comdml_del_count`                    | Delete Statement Execution Frequency                      | This metric measures the average number of Delete statements executed per second, in queries/second.    | ≥ 0 queries/s      | 1 minute 5 seconds 1 second          |
| `rds029_comdml_ins_count`                    | Insert Statement Execution Frequency                      | This metric measures the average number of Insert statements executed per second, in queries/second.    | ≥ 0 queries/s      | 1 minute 5 seconds 1 second          |
| `rds030_comdml_ins_sel_count`                | Insert_Select Statement Execution Frequency               | This metric measures the average number of Insert_Select statements executed per second, in queries/second. | ≥ 0 queries/s      | 1 minute                |
| `rds031_comdml_rep_count`                    | Replace Statement Execution Frequency                     | This metric measures the average number of Replace statements executed per second, in queries/second.   | ≥ 0 queries/s      | 1 minute                |
| `rds032_comdml_rep_sel_count`                | Replace_Selection Statement Execution Frequency           | This metric measures the average number of Replace_Selection statements executed per second, in queries/second. | ≥ 0 queries/s      | 1 minute                |
| `rds033_comdml_sel_count`                    | Select Statement Execution Frequency                      | This metric measures the average number of Select statements executed per second.                   | ≥ 0 queries/s      | 1 minute 5 seconds 1 second          |
| `rds034_comdml_upd_count`                    | Update Statement Execution Frequency                      | This metric measures the average number of Update statements executed per second, in queries/second.    | ≥ 0 queries/s      | 1 minute 5 seconds 1 second          |
| `rds035_innodb_del_row_count`                | Row Deletion Rate                              | This metric measures the average number of rows deleted per second from **InnoDB** tables, in rows/second. | ≥ 0 rows/s         | 1 minute                |
| `rds036_innodb_ins_row_count`                | Row Insertion Rate                              | This metric measures the average number of rows inserted per second into **InnoDB** tables, in rows/second. | ≥ 0 rows/s         | 1 minute                |
| `rds037_innodb_read_row_count`               | Row Read Rate                              | This metric measures the average number of rows read per second from **InnoDB** tables, in rows/second. | ≥ 0 rows/s         | 1 minute                |
| `rds038_innodb_upd_row_count`                | Row Update Rate                              | This metric measures the average number of rows updated per second in **InnoDB** tables, in rows/second. | ≥ 0 rows/s         | 1 minute                |
| `rds039_disk_util`                           | Disk Utilization                              | This metric measures the disk utilization of the measurement object, in percentage.           | 0-100%             | 1 minute                |
| `rds047_disk_total_size`                     | Total Disk Size                              | This metric measures the total size of the disk.                         | 40GB~4000GB        | 1 minute                |
| `rds048_disk_used_size`                      | Disk Usage                              | This metric measures the disk usage size.                       | 0GB~4000GB         | 1 minute                |
| `rds049_disk_read_throughput`                | Disk Read Throughput                            | This metric measures the number of bytes read from disk per second.                       | ≥ 0 bytes/s        | 1 minute                |
| `rds050_disk_write_throughput`               | Disk Write Throughput                            | This metric measures the number of bytes written to disk per second.                         | ≥ 0 bytes/s        | 1 minute                |
| `rds072_conn_usage`                          | Connection Usage Rate                            | This metric measures the percentage of current used MySQL connections out of total connections.      | 0-100%             | 1 minute                |
| `rds173_replication_delay_avg`               | Average Replication Delay                            | This metric measures the average delay between replica or read-only and master, corresponding to seconds_behind_master. It takes the average value over a 60-second period. | ≥ 0s               | 10 seconds                 |
| `rds073_replication_delay`                   | Real-time Replication Delay                            | This metric measures the real-time delay between replica or read-only and master, corresponding to seconds_behind_master. This value is the real-time value. | ≥ 0s               | 1 minute 5 seconds             |
| `rds074_slow_queries`                        | Slow Log Count                            | This metric displays the number of slow logs generated by MySQL per minute.                  | ≥ 0                | 1 minute                |
| `rds075_avg_disk_ms_per_read`                | Disk Read Latency                              | This metric measures the average time taken for each disk read during a certain period.             | ≥ 0ms              | 1 minute                |
| `rds076_avg_disk_ms_per_write`               | Disk Write Latency                              | This metric measures the average time taken for each disk write during a certain period.                 | ≥ 0ms              | 1 minute                |
| `rds077_vma`                                 | VMA Count                                 | Monitors the size of virtual memory regions of the RDS process, in units.                  | ≥ 0counts          | 1 minute                |
| `rds078_threads`                             | Thread Count in Process                          | Monitors the number of threads in the RDS process, in units.                        | ≥ 0counts          | 1 minute                |
| `rds079_vm_hwm`                              | Peak Physical Memory Usage of Process                  | Monitors the peak physical memory usage of the RDS process, in KB.                  | ≥ 0 KB             | 1 minute                |
| `rds080_vm_peak`                             | Peak Virtual Memory Usage of Process                  | Monitors the peak virtual memory usage of the RDS process, in KB.                  | ≥ 0 KB             | 1 minute                |
| `rds081_vm_ioutils`                          | Disk I/O Utilization                           | Disk I/O utilization, in percentage.                                | 0-1                | 1 minute                |
| `rds082_semi_sync_tx_avg_wait_time`          | Average Transaction Wait Time                        | Monitors the average wait time in semi-synchronous replication mode, in microseconds.             | ≥ 0 microseconds            | 1 minute                |
| `sys_swap_usage`                             | Swap Utilization                              | This metric measures the swap utilization of the measurement object, in percentage.           | 0-100%             | 1 minute                |
| `rds_innodb_lock_waits`                      | Number of Row Lock Waits                            | This metric measures the number of row lock waits in **Innodb**, in units. Represents the cumulative number of transactions waiting for row locks. Restart clears lock waits. | ≥ 0 counts         | 1 minute                |
| `rds_bytes_recv_rate`                        | Bytes Received per Second                      | This metric measures the number of bytes received per second by the database, in bytes/second.          | ≥ 0 bytes/s        | 1 minute                |
| `rds_bytes_sent_rate`                        | Bytes Sent per Second                      | This metric measures the number of bytes sent per second by the database, in bytes/second.          | ≥ 0 bytes/s        | 1 minute                |
| `rds_innodb_pages_read_rate`                 | **Innodb** Pages Read per Second          | This metric measures the average number of pages read per second by **Innodb**, in pages/second. | ≥ 0 Pages/s        | 1 minute                |
| `rds_innodb_pages_written_rate`              | **Innodb** Pages Written per Second          | This metric measures the average number of pages written per second by **Innodb**, in pages/second. | ≥ 0 Pages/s        | 1 minute                |
| `rds_innodb_os_log_written_rate`             | Redo Log Write Rate              | This metric measures the average size of redo log written per second, in bytes/second.  | ≥ 0 bytes/s        | 1 minute                |
| `rds_innodb_buffer_pool_read_requests_rate`  | innodb_buffer_pool Read Requests per Second        | This metric measures the number of read requests per second by innodb_buffer_pool, in counts/second. | ≥ 0 counts/s       | 1 minute                |
| `rds_innodb_buffer_pool_write_requests_rate` | innodb_buffer_pool Write Requests per Second        | This metric measures the number of write requests per second by innodb_buffer_pool, in counts/second. | ≥ 0 counts/s       | 1 minute                |
| `rds_innodb_buffer_pool_pages_flushed_rate`  | innodb_buffer_pool Pages Flushed per Second        | This metric measures the number of pages flushed per second by innodb_buffer_pool, in counts/second. | ≥ 0 counts/s       | 1 minute                |
| `rds_innodb_log_waits_rate`                  | Flush to Disk Due to Insufficient Log Buffer Times | This metric measures the number of times flushing to disk due to insufficient log buffer, in counts/second. | ≥ 0 counts/s       | 1 minute                |
| `rds_created_tmp_tables_rate`                | Temporary Tables Created per Second                        | This metric measures the number of temporary tables created per second, in counts/second.              | ≥ 0 counts/s       | 1 minute                |
| `rds_wait_thread_count`                      | Waiting Threads                              | This metric measures the number of waiting threads, in units.                       | ≥ 0 counts         | 1 minute                |
| `rds_innodb_row_lock_time_avg`               | Average Historical Row Lock Wait Time                    | This metric measures the average historical row lock wait time in **innodb**.               | > 0ms              | 1 minute                |
| `rds_innodb_row_lock_current_waits`          | Current Row Lock Waits                          | This metric measures the number of current row lock waits in **innodb**, in units. Represents the number of transactions currently waiting for row locks. | ≥ 0 counts         | 1 minute                |
| `rds_mdl_lock_count`                         | MDL Lock Count                               | This metric measures the number of MDL locks, in units.                        | ≥ 0counts          | 1 minute                |
| `rds_buffer_pool_wait_free`                  | Dirty Pages Waiting to Be Flushed                      | This metric measures the number of dirty pages waiting to be flushed, in units.                   | ≥ 0counts          | 1 minute                |
| `rds_conn_active_usage`                      | Active Connection Usage Rate                        | This metric measures the ratio of active connections to the maximum number of connections, in percentage.       | 0-100%             | 1 minute                |
| `rds_innodb_log_waits_count`                 | Log Wait Count                            | This metric measures the number of log waits, in units.                     | ≥ 0counts          | 1 minute                |
| `rds_long_transaction`                       | Long Transaction Metric                              | This metric measures long transaction duration data, in seconds. Related operations must have both **BEGIN** and **COMMIT** commands to be considered a complete long transaction. | ≥ 0seconds         | 1 minute                |

RDS for MySQL proxy monitoring metrics, as shown in [Table 2](https://support.huaweicloud.com/usermanual-rds/rds_06_0001.html#rds_06_0001__table1377262611585){:target="_blank"}.

| Metric ID                                 | Metric Name               | Metric Meaning                                                     | Value Range     | Monitoring Period (Original Metric) |
| -------------------------------------- | ---------------------- | ------------------------------------------------------------ | ------------ | -------------------- |
| rds001_cpu_util                        | CPU Utilization              | This metric measures the CPU utilization of the measurement object, in percentage.            | 0-100%       | 1 minute 5 seconds 1 second          |
| rds002_mem_util                        | Memory Utilization             | This metric measures the memory utilization of the measurement object, in percentage.           | 0-100%       | 1 minute 5 seconds 1 second          |
| rds004_bytes_in                        | Network Input Throughput         | This metric measures the average traffic input per second from all network adapters of the measurement object, in bytes/second. | ≥ 0 bytes/s  | 1 minute                |
| rds005_bytes_out                       | Network Output Throughput         | This metric measures the average traffic output per second from all network adapters of the measurement object, in bytes/second. | ≥ 0 bytes/s  | 1 minute                |
| rds_proxy_frontend_connections         | Frontend Connections             | The number of connections between applications and Proxy.                                    | ≥ 0 counts   | 1 minute                |
| rds_proxy_backend_connections          | Backend Connections             | The number of connections between Proxy and RDS databases.                               | ≥ 0 counts   | 1 minute                |
| rds_proxy_average_response_time        | Average Response Time           | Average response time.                                               | ≥ 0 ms       | 1 minute                |
| rds_proxy_query_per_seconds            | QPS                    | SQL statement query count.                                            | ≥ 0 counts   | 1 minute                |
| rds_proxy_read_query_proportions       | Read Proportion                 | The proportion of read requests among total requests.                                       | 0-100%       | 1 minute                |
| rds_proxy_write_query_proportions      | Write Proportion                 | The proportion of write requests among total requests.                                       | 0-100%       | 1 minute                |
| rds_proxy_frontend_connection_creation | Average Frontend Connections Created per Second | Measures the average number of frontend connections created per second by client applications targeting the database proxy service. | ≥ 0 counts/s | 1 minute                |
| rds_proxy_transaction_query            | Average Queries per Transaction per Second | Measures the average number of select queries executed per second within transactions.                   | ≥ 0 counts/s | 1 minute                |
| rds_proxy_multi_statement_query        | Average Multi-Statements Executed per Second   | Measures the average number of Multi-Statements executed per second.                     | ≥ 0 counts/s | 1 minute                |

## Objects {#object}

The structure of collected Huawei Cloud RDS MySQL object data can be viewed under 「Infrastructure - Custom」.

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

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, which serves as a unique identifier.
>
> Tip 2: The following fields are serialized JSON strings:
>
> - `fields.message`
> - `fields.private_ips`
> - `fields.public_ips`
> - `fields.volume`
> - `fields.nodes`
> - `fields.related_instance`
> - `fields.backup_strategy`
>
> Tip 3: The `type` field can take values "Single", "Ha", "Replica", "Enterprise", corresponding to single-instance, master-slave instance, read-only instance, and distributed instance (enterprise edition), respectively.