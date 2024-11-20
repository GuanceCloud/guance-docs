---
title: 'Huawei Cloud RDS MariaDB'
tags: 
  - Huawei Cloud
summary: 'Collect Huawei Cloud RDS MariaDB metric data'
__int_icon: 'icon/huawei_rds_mariadb'
dashboard:

  - desc: 'Huawei Cloud RDS MariaDB Monitoring View'
    path: 'dashboard/en/huawei_rds_mariadb'

monitor:
  - desc: 'Huawei Cloud RDS MariaDB Monitor'
    path: 'monitor/en/huawei_rds_mariadb'
---

Collect Huawei Cloud RDS MariaDB metric data

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically,Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

>Recommend deploying GSE version

### Installation script

> Tip:Please prepare a Huawei Cloud AK that meets the requirements in advance (For simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)


To synchronize the monitoring data of Huawei Cloud RDS MariaDB, we install the corresponding collection script: 「Guance Cloud Integration (Huawei Cloud RDS-MariaDB Collection)」 (ID: `guance_huaweicloud_rds_mariadb`)

Click 【Install】 and enter the corresponding parameters: HUAWEI CLOUD AK, HUAWEI CLOUD account name.

Tap【Deploy startup Script】, the system automatically creates `Startup` script sets, and automatically configure the corresponding startup script.

After installing the script, find the script 「Guance Cloud Integration (Huawei Cloud RDS-MariaDB data collection)」 in the 「Development」 section of Func. Expand and modify the script, find collector_configs and monitor_configs, and edit the content in region_projects below. Change the region and Project ID to the actual region and Project ID, and then click save and publish.

In addition, in「Management / Automatic Trigger Configuration」 you can see the corresponding automatic trigger configuration. Click 【Execute】 to run it immediately, without waiting for the scheduled time. After a short moment, you can check the execution task records and corresponding logs.

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the guance cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the guance cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

Configure Huawei Cloud RDS MariaDB metrics to collect more metrics through configuration [Huawei Cloud RDS MariaDB Metric Details](https://support.huaweicloud.com/usermanual-rds/maria_03_0087.html){:target="_blank"}

The performance monitoring metrics for RDS for MariaDB instances are shown in the following table.

| **MetricID**                                       | **Metric Name**                                | **Metric Meaning**                                                     | **Value Range**           | **Monitoring Period (Raw Metric)** |
| -------------------------------------------- | --------------------------------------- | ------------------------------------------------------------ | ------------------ | -------------------- |
| `rds001_cpu_util`                            | CPU usage rate                               | This indicator is used to calculate the CPU usage rate of the measured object, measured in units of ratios.            | 0-100%             | 1 minute          |
| `rds002_mem_util`                            | Memory usage rate                              | This indicator is used to measure the memory utilization of the measured object.           | 0～100%            | 1 minute          |
| `rds003_iops`                                | IOPS                                    | This indicator is used to calculate the average number of I/O requests processed by the system per unit time for the current instance. | ≥ 0 counts/s   | 1 minute          |
| `rds004_bytes_in`                            | Network input throughput                          | This indicator is used to calculate the average traffic input from all network adapters of the measurement object per second, measured in bytes per second. | ≥ 0 bytes/s        | 1 minute                |
| `rds005_bytes_out`                           | Network output throughput                          | This metric is used to calculate the average traffic output per second from all network adapters of the measurement object, measured in bytes per second. | ≥ 0 bytes/s        | 1 minute                |
| `rds006_conn_count`                           | Total number of database connections                          | This indicator is used to count the total number of connections attempting to connect to MariaDB servers, measured in units of. | ≥ 0 counts        | 1 minute                |
| `rds007_conn_active_count`                           | Current number of active connections                          | This indicator is used to count the current number of open connections, measured in units of.      | ≥ 0 counts        | 1 minute                |
| `rds008_qps`                           | QPS                          | This indicator is used to count the number of SQL statement queries, including stored procedures, in units of times per second.                    | ≥ 0 queries/s        | 1 minute                |
| `rds009_tps`                           | TPS                          | This indicator is used to count the number of transaction executions, including commit and rollback, in units of times per second. | ≥ 0 transactions/s        | 1 minute                |
| `rds010_innodb_buf_usage`                     | Buffer pool utilization rate                          | This indicator is used to calculate the ratio of idle pages to the total number of buffer pool pages in InnoDB cache, measured in units of ratio. | 0-1        | 1 minute                |
| `rds011_innodb_buf_hit`                        |  Buffer Pool Hit Rate                          | This indicator is used to calculate the ratio of read hits to read requests, measured in units of ratio. |  0-1        | 1 minute                |
| `rds012_innodb_buf_dirty`                        | Buffer pool dirty block rate                          | This indicator is used to calculate the ratio of dirty data in InnoDB cache to pages used in InnoDB cache, measured in units of ratio. |  0-1        | 1 minute                |
| `rds013_innodb_reads`                        | InnoDB read throughput                         | This indicator is used to calculate the average number of bytes read per second by InnoDB, measured in bytes per second. |  ≥ 0 bytes/s        | 1 minute                |
| `rds014_innodb_writes`                        | InnoDB write throughput                          | This indicator is used to calculate the average number of words written per second in InnoDB, measured in bytes per second. |  ≥ 0 bytes/s        | 1 minute                |
| `rds015_innodb_read_count`                        | InnoDB file read frequency                          | This indicator is used to calculate the average number of times InnoDB reads files per second, measured in times per second. |  ≥ 0 counts/s        | 1 minute                |
| `rds016_innodb_write_count`                        | InnoDB file write frequency                          | This indicator is used to calculate the average number of times InnoDB writes to files per second, measured in times per second. |  ≥ 0 counts/s       | 1 minute                |
| `rds017_innodb_log_write_req_count`                        | InnoDB log write request frequency                          | This indicator is used to calculate the average number of log write requests per second, measured in times per second. |  ≥ 0 counts/s        | 1 minute                |
| `rds018_innodb_log_write_count`                        | InnoDB log physical write frequency                          | This indicator is used to calculate the average number of physical writes to log files per second, measured in times per second. |  ≥ 0 counts/s        | 1 minute                |
| `rds019_innodb_log_fsync_count`                        | InnoDB log fsync() write frequency                          | The fsync() write frequency indicator is used to calculate the average number of fsync() writes completed to log files per second, measured in times per second. |  0-1        | 1 minute                |
| `rds020_temp_tbl_rate`                        | Temporary table creation rate                        | This indicator is used to count the number of temporary tables created on the hard drive per second, measured in units of per second. |  ≥ 0 counts/s       | 1 minute                |
| `rds021_myisam_buf_usage`                        | Key Buffer Utilization                          | This indicator is used to calculate the utilization rate of MyISAM Key buffer, measured in ratios. |  0-1        | 1 minute                |
| `rds022_myisam_buf_write_hit`                        | Key Buffer write hit rate                          | This indicator is used to calculate the write hit rate of MyISAM Key buffer, measured in ratios. |  0-1        | 1 minute                |
| `rds023_myisam_buf_read_hit`                        | Key Buffer read hit rate                          | This indicator is used to calculate the MyISAM Key buffer read hit rate, measured in ratios. |  0-1        | 1 minute                |
| `rds024_myisam_disk_write_count`                        | MyISAM hard drive write frequency                          | This indicator is used to count the number of times an index is written to the disk, measured in times per second。 |  ≥ 0 counts/s       | 1 minute                |
| `rds025_myisam_disk_read_count`                        | MyISAM hard drive read frequency                         | This indicator is used to count the number of times indexes are read from the disk, measured in times per second. |  ≥ 0 counts/s        | 1 minute                |
| `rds026_myisam_buf_write_count`                        | MyISAM buffer pool write frequency                         | This indicator is used to count the number of requests to write indexes to the buffer pool, measured in times per second. |  ≥ 0 counts/s        | 1 minute                |
| `rds027_myisam_buf_read_count`                        | MyISAM buffer pool read frequency                         | This indicator is used to count the number of requests to read indexes from the buffer pool, measured in times per second. |  ≥ 0 counts/s        | 1 minute                |
| `rds028_comdml_del_count`                        | Delete statement execution frequency                         | This indicator is used to calculate the average number of Delete statement executions per second, measured in times per second. |  ≥ 0 queries/s        | 1 minute                |
| `rds029_comdml_ins_count`                        | Insert statement execution frequency                         | This indicator is used to calculate the average number of Insert statement executions per second, measured in times per second. |  ≥ 0 queries/s        | 1 minute                |
| `rds030_comdml_ins_sel_count`                        | Insert_Select statement execution frequency                         | This indicator is used to calculate the average number of insert_Select statement executions per second, measured in times per second. |  ≥ 0 queries/s        | 1 minute                |
| `rds031_comdml_rep_count`                        | Replace statement execution frequency                         | This indicator is used to calculate the average number of Replace statement executions per second, measured in times per second. | ≥ 0 queries/s        | 1 minute                |
| `rds032_comdml_rep_sel_count`                        | Replacing Selection statement execution frequency                         | This indicator is used to calculate the average number of times the replace_Selection statement is executed per second, measured in times per second. |  ≥ 0 queries/s        | 1 minute                |
| `rds033_comdml_sel_count`                        | Select statement execution frequency                         | This indicator is used to calculate the average number of Select statement executions per second. |  ≥ 0 queries/s        | 1 minute                |
| `rds034_comdml_upd_count`                        | Update statement execution frequency                         | This indicator is used to calculate the average number of times Update statements are executed per second, measured in times per second. |  ≥ 0 queries/s        | 1 minute                |
| `rds035_innodb_del_row_count`                        | Row deletion rate                         | This indicator is used to calculate the average number of rows deleted from InnoDB tables per second, measured in rows per second. |  ≥ 0 rows/s      | 1 minute                |
| `rds036_innodb_ins_row_count`                        | Row insertion rate                        | This metric is used to calculate the average number of rows inserted into InnoDB tables per second, measured in rows per second | ≥ 0 rows/s        | 1 minute                |
| `rds037_innodb_read_row_count`                        | Row read rate                         | This metric is used to calculate the average number of rows read from InnoDB tables per second, measured in rows per second. |  ≥ 0 rows/s        | 1 minute                |
| `rds038_innodb_upd_row_count`                        | Line update rate                         | This indicator is used to calculate the average number of rows updated to InnoDB tables per second, measured in rows per second. |  ≥ 0 rows/s        | 1 minute                |
| `rds037_innodb_read_row_count`                        | Row read rate                         | This metric is used to calculate the average number of rows read from InnoDB tables per second, measured in rows per second. |  ≥ 0 queries/s        | 1 minute                |
| `rds039_disk_util`                        | Disk utilization rate                         | This indicator is used to calculate the disk utilization rate of the measured object, measured in ratios. |  0-100%        | 1 minute                |
| `rds047_disk_total_size`                      | Total disk size                         |   This indicator is used to calculate the total disk size of the measured object. |  40GB~4000GB        | 1 minute                |
| `rds048_disk_used_size`                        | Disk usage                         | This indicator is used to calculate the disk usage size of the measured object. |  0GB~4000GB        | 1 minute                |
| `rds049_disk_read_throughput`                        | Hard disk read throughput                         | This indicator is used to count the number of bytes read from the hard drive per second. |  ≥ 0 bytes/s        | 1 minute                |
| `rds050_disk_write_throughput`                        | Hard disk write throughput                        | This indicator is used to count the number of bytes written to the hard drive per second. |  ≥ 0 bytes/s        | 1 minute                |
| `rds072_conn_usage`                        | Connection usage rate                         | This metric is used to calculate the average number of rows read from InnoDB tables per second, measured in rows per second. |  0-100%       | 1 minute                |
| `rds073_replication_delay`                        | Real time replication latency                         | This indicator is the real-time delay between the backup or read-only and primary databases, corresponding to seconds_beding_master. This value is a real-time value. |  ≥ 0 s        | 1 minute                |
| `rds074_slow_queries`                        | Statistics on the number of slow logs                         | This metric is used to display the number of slow logs generated by MariaDB per minute. |  ≥ 0        | 1 minute                |
| `rds075_avg_disk_ms_per_read`                        | Hard disk read time                         | 该The indicator is used to calculate the average time taken to read a disk during a certain period of time. |  ≥ 0 ms       | 1 minute                |
| `rds076_avg_disk_ms_per_write`                        | Hard disk write time                        | This indicator is used to calculate the average time spent writing to the disk during a certain period of time. |  ≥ 0 ms        | 1 minute                |
| `rds077_vma`                        | VMA quantity                        | This indicator is used to monitor the virtual memory area size of RDS processes |  ≥ 0 counts        | 1 minute                |
| `rds078_threads`                        | Number of threads in the process                         | Monitor the number of threads in the RDS process, in units of|  ≥ 0 counts        | 1 minute                |
| `rds079_vm_hwm`                        | Peak physical memory usage of processes                         | Monitor the peak physical memory usage of RDS processes in kilobytes.|  ≥ 0 KB        | 1 minute                |
| `rds080_vm_peak`                        | Peak virtual memory usage of processes                         | Monitor the peak virtual memory usage of RDS processes in kilobytes. |  ≥ 0 KB       | 1 minute                |
| `rds082_semi_sync_tx_avg_wait_time`                        | Average waiting time for transactions                         |Monitor the average waiting time in microseconds under semi synchronous replication mode. | ≥ 0 μs        | 1 minute                |
| `rds173_replication_delay_avg`                        | Average replication latency                         | This indicator is the average latency between the backup or read-only database and the main database, corresponding to seconds_beding_master |  ≥ 0 s        | 1 minute                |
| `rds_buffer_pool_wait_free`                        | Waiting times for idle pages in the buffer pool                         | This indicator is used to count the number of idle page waiting times in the InnoDB buffer pool. |  ≥ 0 ms        | 1 minute                |
| `rds_bytes_recv_rate`                        | The database receives bytes per second                         | This indicator is used to count the number of bytes received by the database per second, measured in bytes per second. |  ≥ 0 bytes/s        | 1 minute                |
| `rds_bytes_sent_rate`                        | The database sends bytes per second                        | This indicator is used to count each byte sent in the database, measured in bytes per second. |  ≥ 0 bytes/s        | 1 minute                |
| `rds_conn_active_usage`                        | Active connection usage rate                        | This indicator calculates the ratio of active connections to the maximum number of connections, measured in units of ratio. |  0-100%        | 1 minute                |
| `rds_created_tmp_tables_rate`                        | Number of temporary tables created per second                         |This indicator is used to count the number of temporary tables created per second, measured in units of per second. | ≥ 0 counts/s        | 1 minute                |
| `rds_innodb_buffer_pool_pages_flushed_rate`                        | Innobd_fuffer_pool page refresh rate per second                         | This indicator is used to calculate the number of page refreshes per second for innobd_fuffer_pool, measured in times per second. |  ≥ 0 counts/s        | 1 minute                |
| `rds_innodb_buffer_pool_read_requests_rate`                        | Innobd_fuffer_pool reads requests per second                        | This indicator is used to count the number of read requests per second for innobd_fuffer_pool, measured in times per second. |  ≥ 0 counts/s        | 1 minute                |
| `rds_innodb_buffer_pool_write_requests_rate`                        | Innobd_fuffer_pool writes requests per second                         | This indicator is used to count the number of write requests per second for innobd_fuffer_pool, measured in times per second. |  ≥ 0 counts/s        | 1 minute                |
| `rds_innodb_lock_waits`                        | Waiting for row lock transactions                        | This indicator is used to count the number of InnoDB transactions currently waiting for row locks, measured in units of. |  ≥ 0 counts        | 1 minute                |
| `rds_innodb_log_waits_count`                        | Number of log waiting times                         | This indicator is used to count the number of log waiting times, measured in units of. | ≥ 0 counts       | 1 minute                |
| `rds_innodb_log_waits_rate`                        | Waiting for flush to disk times due to insufficient log buffer                         | This indicator is used to count the number of times a disk waits to flush due to insufficient log buffer, measured in times per second. | ≥ 0 counts       | 1 minute                |
| `rds_innodb_os_log_written_rate`                        | The average size of Redo logs written per second                         | This indicator is used to calculate the average size of redo logs written per second, measured in bytes per second. | ≥ 0 bytes/s       | 1 minute                |
| `rds_innodb_pages_read_rate`                        | The average amount of data read per second by InnoDB                         | This indicator is used to calculate the average amount of data read per second by InnoDB, measured in pages per second. | ≥ 0 Pages/s      | 1 minute                |
| `rds_innodb_pages_written_rate`                        | The average amount of data written per second by InnoDB                       | This indicator is used to calculate the average amount of data written to InnoDB per second, measured in pages per second. | ≥ 0 Pages/s       | 1 minute                |
| `rds_innodb_row_lock_current_waits`                        | Current line lock waiting count                        | This indicator is used to count the current number of row lock waits in InnoDB, measured in units of. | ≥ 0 counts       | 1 minute                |
| `rds_innodb_row_lock_time_avg`                        | Average waiting time for line locks                        | This indicator is used to calculate the average waiting time for row locks, measured in milliseconds.| ≥ 0 ms       | 1 minute                |
| `rds_wait_thread_count`                        | Waiting for thread count                         | This indicator is used to count the number of waiting threads, measured in units of. | ≥ 0 counts       | 1 minute                |

## Object {#object}

The collected Huawei Cloud RDS MariaDB object data structure can be viewed in the 「Infrastructure Customization」 section for object data.

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
    "created_time"    : "2024-11-12T06:31:07+0000",
    "updated_time"    : "2024-11-12T07:45:54+0000",
    "private_ips"     : "[\"192.x.x.35\"]",
    "public_ips"      : "[]",
    "datastore"       : "{Instance JSON data}",
    "cpu"             : "4",
    "mem"             : "8",
    "volume"          : "{volume message}",
    "nodes"           : "[{Primary instance information}]",
    "related_instance": "[]",
    "backup_strategy" : "{Backup strategy}"
  }
}
```

> *notice：`tags`、`fields`The fields in this section may change with subsequent updates*
>
> Tips 1：The value of `tags.name` is the instance ID, which serves as a unique identifier
>
> Tips 2：The following fields are JSON serialized strings
>
> - `fields.private_ips`
> - `fields.public_ips`
> - `fields.volume`
> - `fields.nodes`
> - `fields.related_instance`
> - `fields.backup_strategy`
>
> Tips 3：The value of `type` is "Single","Ha" or "Replica","Enterprise",corresponding to single machine instance, primary/backup instance, read-only instance, and distributed instance (Enterprise Edition), respectively.
