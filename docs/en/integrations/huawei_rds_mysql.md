---
title: 'HUAWEI RDS MYSQL'
tags: 
  - Huawei Cloud
summary: 'Use the「Guanc Synchronization」series script package in the script market to monitor the cloud ,The data of the cloud asset is synchronized to the Guance.'
__int_icon: 'icon/huawei_rds_mysql'
dashboard:

  - desc: 'HUAWEI CLOUD RDS MYSQL Built-in Dashboard'
    path: 'dashboard/zh/huawei_rds_mysql'

monitor:
  - desc: 'HUAWEI CLOUD RDS MYSQL Monitor'
    path: 'monitor/zh/huawei_rds_mysql'

---


<!-- markdownlint-disable MD025 -->
# HUAWEI CLOUD RDS MYSQL
<!-- markdownlint-enable -->

Use the「Guance Synchronization」series script package in the script market to monitor the cloud ,The data of the cloud asset is synchronized to the Guance.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically,Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip: Please prepare HUAWEI CLOUD AK that meets the requirements in advance（For simplicity's sake,You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of  HUAWEI CLOUD RDS cloud resources, we install the corresponding collection script: 「Guance Integration（HUAWEI CLOUD-RDSCollect）」(ID：`guance_huaweicloud_rds`)

Click  [Install] and enter the corresponding parameters: HUAWEI CLOUD AK, HUAWEI CLOUD account name.

Tap [Deploy startup Script],The system automatically creates Startup script sets,And automatically configure the corresponding startup script.

After the script is installed,Find the script in「Development」in Func「Guance Integration（HUAWEI CLOUD-RDSCollect）」,Expand to modify this script,find collector_configsandmonitor_configsEdit the content inregion_projects,Change the locale and Project ID to the actual locale and Project ID,Click Save Publish again.

In addition, the corresponding automatic trigger configuration is displayed in「Management / Crontab Config」. Tap [Run],It can be executed immediately once,without waiting for a periodic time.After a while,you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-ces/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist.
2. On Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists.
3. On Guance platform, press 「Metrics」 to check whether monitoring data exists.

## Metric {#metric}
Configure HUAWEI CLOUD - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [HUAWEI CLOUD Monitor Metrics Details](https://support.huaweicloud.com/usermanual-rds/rds_06_0001.html){:target="_blank"}

### Instance monitoring metric

RDS for MySQL instance performance monitoring metric,as shown in the table below.

| Metric ID                                     | Metric name                                | Metric meaning                                                     | Value range           | Monitoring cycle(original metric) |
| ------------------------------------------ | --------------------------------------- | ------------------------------------------------------------ | ------------------ | -------------------- |
| rds001_cpu_util                            | CPU Usage                       | This metric is used to count the CPU usage of the measurement object, and the unit is ratio. | 0-100%             | 1 minute 5 seconds 1 second |
| rds002_mem_util                            | Memory Usage               | This metric is used to count the memory usage of the measurement object, in the unit of ratio. | 0-100%             | 1 minute 5 seconds 1 second |
| rds003_iops                                | IOPS                                    | This metric is used to count the number of I/O requests processed by the system per unit time (average value) of the current instance. | ≥ 0 counts/s       | 1 minute        |
| rds004_bytes_in                            | Network input throughput | This metric is used to count the average traffic input from all network adapters of the measurement object per second, in bytes/second. | ≥ 0 bytes/s        | 1 minute        |
| rds005_bytes_out                           | Network output throughput | This metric is used to count the average output traffic from all network adapters of the measurement object per second, in bytes/second. | ≥ 0 bytes/s        | 1 minute        |
| rds006_conn_count                          | Total number of database connections | This metric is used to count the total number of connections trying to connect to the MySQL server, in units. | ≥ 0 counts         | 1 minute 5 seconds 1 second |
| rds007_conn_active_count                   | Current active connections | This metric is used to count the number of currently open connections, in unit. | ≥ 0 counts         | 1 minute 5 seconds 1 second |
| rds008_qps                                 | QPS                                     | This metric is used to count the number of SQL statement queries, including stored procedures, in the unit of times/second. | ≥ 0 queries/s      | 1 minute 5 seconds 1 second |
| rds009_tps                                 | TPS                                     | This metric is used to count the number of transaction executions, including committed and rolled back, in the unit of times/second. | ≥ 0 transactions/s | 1 minute 5 seconds 1 second |
| rds010_innodb_buf_usage                    | buffer pool utilization     | This metric is used to count the ratio of free pages to the total number of buffer pool pages in the InnoDB cache, in units of ratio. | 0-1                | 1 minute        |
| rds011_innodb_buf_hit                      | buffer pool hit ratio       | This metric is used to count the ratio of read hits to read requests, in units of ratio. | 0-1                | 1 minute        |
| rds012_innodb_buf_dirty                    | Buffer pool dirty block rate | This metric is used to count the ratio of dirty data in the InnoDB cache to pages used in the InnoDB cache, in units of ratio. | 0-1                | 1 minute        |
| rds013_innodb_reads                        | InnoDB read throughput         | This metric is used to count the average number of bytes read by Innodb per second, in bytes/second. | ≥ 0 bytes/s        | 1 minute        |
| rds014_innodb_writes                       | InnoDB write throughput        | This metric is used to count the average number of bytes written by Innodb per second, in bytes/second. | ≥ 0 bytes/s        | 1 minute        |
| rds015_innodb_read_count                   | InnoDB file read frequency   | This metric is used to count the average number of times Innodb reads from the file per second, in units of times/second. | ≥ 0 counts/s       | 1 minute        |
| rds016_innodb_write_count                  | InnoDB file write frequency  | This metric is used to count the average number of times Innodb writes to the file per second, in units of times/second. | ≥ 0 counts/s       | 1 minute        |
| rds017_innodb_log_write_req_count          | InnoDB log write request frequency | This metric is used to count the average number of log write requests per second, in units of times/second. | ≥ 0 counts/s       | 1 minute        |
| rds018_innodb_log_write_count              | InnoDB Log physical write frequency | This metric is used to count the average number of physical writes to the log file per second, in the unit of times/second. | ≥ 0 counts/s       | 1 minute        |
| rds019_innodb_log_fsync_count              | InnoDB log fsync() write frequency | This metric is used to count the average number of fsync() writes to the log file per second, in units of times/second. | ≥ 0 counts/s       | 1 minute        |
| rds020_temp_tbl_rate                       | Temporary table creation rate | This metric is used to count the number of temporary tables created on the hard disk per second, and the unit is one/second. | ≥ 0 counts/s       | 1 minute        |
| rds021_myisam_buf_usage                    | Key Buffer utilization          | This metric is used to count the utilization rate of MyISAM Key buffer, and the unit is ratio. | 0-1                | 1 minute        |
| rds022_myisam_buf_write_hit                | Key Buffer write hit rate     | This metric is used to count the MyISAM Key buffer write hit rate, in units of ratio. | 0-1                | 1 minute        |
| rds023_myisam_buf_read_hit                 | Key Buffer read hit rate       | This metric is used to count the MyISAM Key buffer read hit rate, and the unit is ratio. | 0-1                | 1 minute        |
| rds024_myisam_disk_write_count             | MyISAM HDD write frequency | This metric is used to count the number of times the index is written to the disk, in times/second. | ≥ 0 counts/s       | 1 minute        |
| rds025_myisam_disk_read_count              | MyISAM HDD read frequency    | This metric is used to count the number of index reads from the disk, in the unit of times/second. | ≥ 0 counts/s       | 1 minute        |
| rds026_myisam_buf_write_count              | MyISAM buffer pool write frequency | This metric is used to count the number of requests to write indexes to the buffer pool, in the unit of times/second. | ≥ 0 counts/s       | 1 minute        |
| rds027_myisam_buf_read_count               | MyISAM buffer pool read frequency | This metric is used to count the number of requests to read indexes from the buffer pool, in the unit of times/second. | ≥ 0 counts/s       | 1 minute        |
| rds028_comdml_del_count                    | Delete statement execution frequency | This metric is used to count the average number of executions of Delete statements per second, in units of times/second. | ≥ 0 queries/s      | 1 minute 5 seconds 1 second |
| rds029_comdml_ins_count                    | Insert statement execution frequency | This metric is used to count the average number of Insert statement executions per second, in units of times/second. | ≥ 0 queries/s      | 1 minute 5 seconds 1 second |
| rds030_comdml_ins_sel_count                | Insert_Select statement execution frequency | This metric is used to count the average number of executions of the Insert_Select statement per second, in the unit of times/second. | ≥ 0 queries/s      | 1 minute        |
| rds031_comdml_rep_count                    | Replace statement execution frequency | This metric is used to count the average number of Replace statement executions per second, in units of times/second. | ≥ 0 queries/s      | 1 minute        |
| rds032_comdml_rep_sel_count                | Replace_Selection statement execution frequency | This metric is used to count the average number of executions of the Replace_Selection statement per second, in the unit of times/second. | ≥ 0 queries/s      | 1 minute        |
| rds033_comdml_sel_count                    | Select statement execution frequency | This metric is used to count the average number of Select statement executions per second. | ≥ 0 queries/s      | 1 minute 5 seconds 1 second |
| rds034_comdml_upd_count                    | Update statement execution frequency | This metric is used to count the average number of Update statement executions per second, in the unit of times/second. | ≥ 0 queries/s      | 1 minute 5 seconds 1 second |
| rds035_innodb_del_row_count                | row deletion rate             | This metric is used to count the average number of rows deleted from InnoDB tables per second, in units of rows/second. | ≥ 0 rows/s         | 1 minute        |
| rds036_innodb_ins_row_count                | row insertion rate            | This metric is used to count the average number of rows inserted into the InnoDB table per second, in units of rows/second. | ≥ 0 rows/s         | 1 minute        |
| rds037_innodb_read_row_count               | row read rate                 | This metric is used to count the average number of rows read from the InnoDB table per second, in units of rows/second. | ≥ 0 rows/s         | 1 minute        |
| rds038_innodb_upd_row_count                | row update rate               | This metric is used to count the average number of rows updated to the InnoDB table per second, in units of rows/second. | ≥ 0 rows/s         | 1 minute        |
| rds039_disk_util                           | disk utilization              | This metric is used to count the disk utilization of the measurement object, in the unit of ratio. | 0-100%             | 1 minute        |
| rds047_disk_total_size                     | total disk size               | This metric is used to count the total disk size of the measurement object. | 40GB~4000GB        | 1 minute        |
| rds048_disk_used_size                      | Disk usage                   | This metric is used to count the disk usage size of the measurement object. | 0GB~4000GB         | 1 minute        |
| rds049_disk_read_throughput                | Disk read throughput      | This metric is used to count the number of bytes read from the hard disk per second. | ≥ 0 bytes/s        | 1 minute        |
| rds050_disk_write_throughput               | Disk write throughput    | This metric is used to count the number of bytes written to the hard disk per second. | ≥ 0 bytes/s        | 1 minute        |
| rds072_conn_usage                          | Connection usage           | This metric is used to count the percentage of currently used MySQL connections to the total number of connections. | 0-100%             | 1 minute                             |
| rds173_replication_delay_avg               | Average Replication Latency | This metric is the average delay between the standby database or the read-only database and the main database, corresponding to seconds_behind_master. Take the average over a 60 second time period. | ≥ 0s               | 10 seconds          |
| rds073_replication_delay                   | Real-time replication latency | This metric is the real-time delay between the standby database or the read-only database and the main database, corresponding to seconds_behind_master. This value is a real-time value. | ≥ 0s               | 1 minute 5 seconds |
| rds074_slow_queries                        | Statistics on the number of slow logs | This metric is used to display the number of slow logs generated by MySQL every minute. | ≥ 0                | 1 minute        |
| rds075_avg_disk_ms_per_read                | Disk read time       | This metric is used to count the average time spent reading each disk in a certain period of time. | ≥ 0ms              | 1 minute        |
| rds076_avg_disk_ms_per_write               | Disk write time     | This metric is used to count the average time spent writing to disk during a certain period of time. | ≥ 0ms              | 1 minute        |
| rds077_vma                                 | VMA   quantity                   | Monitor the size of the virtual memory area of the RDS process, in units. | ≥ 0counts          | 1 minute        |
| rds078_threads                             | Number of threads in the process | Monitor the number of threads in the RDS process, in unit. | ≥ 0counts          | 1 minute        |
| rds079_vm_hwm                              | Peak Memory Usage | Monitor the peak physical memory usage of the RDS process, in KB. | ≥ 0 KB             | 1 minute        |
| rds080_vm_peak                             | Process peak virtual memory usage | Monitors the peak virtual memory usage of the RDS process, in KB. | ≥ 0 KB             | 1 minute        |
| **rds081_vm_ioutils**                          | Disk I/O utilization            | Disk I/O usage, in ratios.      | 0-1                | 1 minute        |
| rds082_semi_sync_tx_avg_wait_time          | transaction average wait-time | Monitors the average wait time in semi-synchronous replication mode, in microseconds. | ≥ 0 microsecond | 1 minute        |
| sys_swap_usage                             | swap utilization                   | This metric is used to count the swap utilization of the measurement object, and the unit is ratio. | 0-100%             | 1 minute        |
| rds_innodb_lock_waits                      | Number of row locks waiting | This metric is used to count the number of Innodb row locks waiting, in unit. Indicates the cumulative number of transactions waiting for row locks in history. A restart clears the lock wait. | ≥ 0 counts         | 1 minute        |
| rds_bytes_recv_rate                        | Database bytes receives  per second | This metric is used to count the bytes received by the database per second, in bytes/second. | ≥ 0 bytes/s        | 1 minute        |
| rds_bytes_sent_rate                        | Database bytes sent per second | This metric is used to count the bytes sent by the database, in bytes/second. | ≥ 0 bytes/s        | 1 minute        |
| **rds_innodb_pages_read_rate**                 | Innodb average data read per second | This metric is used to count the average amount of data read by **innodb** per second, in pages/second. | ≥ 0 Pages/s        | 1 minute        |
| **rds_innodb_pages_written_rate**              | **innodb** average data write rate per second | This metric is used to count the average amount of data written by InnoDB per second, in pages/second. | ≥ 0 Pages/s        | 1 minute        |
| **rds_innodb_os_log_written_rate**             | Average size of redo log written per second | This metric is used to count the average size of the redo log written per second, in bytes/second. | ≥ 0 bytes/s        | 1 minute        |
| rds_innodb_buffer_pool_read_requests_rate  | innodb_buffer_pool read requests per second | This metric is used to count the number of read requests per second for innodb_buffer_pool, in units of times/second. | ≥ 0 counts/s       | 1 minute        |
| rds_innodb_buffer_pool_write_requests_rate | innodb_buffer_pool write requests per second | This metric is used to count the number of write requests per second for innodb_buffer_pool, in units of times/second. | ≥ 0 counts/s       | 1 minute        |
| rds_innodb_buffer_pool_pages_flushed_rate  | innodb_buffer_pool page refreshes per second | This metric is used to count the number of page refreshes per second for innodb_buffer_pool, in units of times/second. | ≥ 0 counts/s       | 1 minute        |
| rds_innodb_log_waits_rate                  | Number of times waiting for flush to disk due to insufficient log buffer | This metric is used to count the times of waiting for flushing to disk due to insufficient log buffer, and the unit is times/second. | ≥ 0 counts/s       | 1 minute        |
| rds_created_tmp_tables_rate                | Temporary tables created per second | This metric is used to count the number of temporary tables created per second, in units of one/second. | ≥ 0 counts/s       | 1 minute        |
| rds_wait_thread_count                      | Number of waiting threads    | This metric is used to count the number of waiting threads, in unit. | ≥ 0 counts         | 1 minute        |
| rds_innodb_row_lock_time_avg               | Average waiting time of historical row locks | This metric is used to count the average waiting time of **innodb** historical row locks. | > 0ms              | 1 minute        |
| rds_innodb_row_lock_current_waits          | Current row lock wait count | This metric is used to count the current row lock waiting number of InnoDB, in unit. Indicates the number of transactions currently waiting for row locks. | ≥ 0 counts         | 1 minute        |
| rds_mdl_lock_count                         | Number of MDL locks            | This metric is used to count the number of MDL locks, in units. | ≥ 0counts          | 1 minute        |
| rds_buffer_pool_wait_free                  | Number of dirty pages waiting to be flushed | This metric counts the number of dirty pages waiting to be flushed, in units. | ≥ 0counts          | 1 minute        |
| rds_conn_active_usage                      | Active Connections Utilization Rate | This metric counts the ratio of the number of active connections to the maximum number of connections, in units of ratio. | 0-100%             | 1 minute        |
| rds_innodb_log_waits_count                 | Log waiting times           | This metric is used to count the number of log waits, in unit. | ≥ 0counts          | 1 minute        |
| rds_long_transaction                       | Long transaction metric   | This metric counts the time-consuming data of long transactions, in seconds. Only when there are **BEGIN** and **COMMIT** commands before and after the relevant operation commands are counted as a complete long transaction. | ≥ 0seconds         | 1 minute        |

RDS for MySQL database agent monitoring metrics,As shown in [table 2](https://support.huaweicloud.com/usermanual-rds/rds_06_0001.html#rds_06_0001__table1377262611585){:target="_blank"}.

| Metric ID                           | Metric name                                               | Metric meaning                                            | Value range  | Monitoring cycle(original metric) |
| -------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------ | ------------------------------------ |
| rds001_cpu_util                        | CPU usage                                                    | This metric is used to count the CPU usage of the measurement object, and the unit is ratio. | 0-100%       | 1 minute 5 seconds 1 second          |
| rds002_mem_util                        | Memory usage                                                 | This metric is used to count the memory usage of the measurement object, in the unit of ratio. | 0-100%       | 1 minute 5 seconds 1 second          |
| rds004_bytes_in                        | Network input throughput                                     | This metric is used to count the average traffic input from all network adapters of the measurement object per second, in bytes/second. | ≥ 0 bytes/s  | 1 minute                             |
| rds005_bytes_out                       | Network output throughput                                    | This metric is used to count the average output traffic from all network adapters of the measurement object per second, in bytes/second. | ≥ 0 bytes/s  | 1 minute                             |
| rds_proxy_frontend_connections         | Front-end connections                                        | The number of connections between the application and the proxy. | ≥ 0 counts   | 1 minute                             |
| rds_proxy_backend_connections          | Backend connections                                          | The number of connections between the proxy and the RDS database. | ≥ 0 counts   | 1 minute                             |
| rds_proxy_average_response_time        | Average response time                                        | Average response time.                                       | ≥ 0 ms       | 1 minute                             |
| rds_proxy_query_per_seconds            | QPS                                                          | The number of SQL statement queries.                         | ≥ 0 counts   | 1 minute                             |
| rds_proxy_read_query_proportions       | Read ratio                                                   | The ratio of read requests to total requests.                | 0-100%       | 1 minute                             |
| rds_proxy_write_query_proportions      | Write ratio                                                  | Write ratio as a percentage of total requests.               | 0-100%       | 1 minute                             |
| rds_proxy_frontend_connection_creation | The average number of front-end connections created per second | Counts the average number of front-end connections created by client applications to the database proxy service per second. | ≥ 0 counts/s | 1 minute                             |
| rds_proxy_transaction_query            | The number of queries in an average transaction per second   | Count the number of executions that include select in the average transactions executed per second. | ≥ 0 counts/s | 1 minute                             |
| rds_proxy_multi_statement_query        | Average number of multi-statement executions per second      | Count the average number of executions of Multi-Statements statements per second. | ≥ 0 counts/s | 1 minute                             |

### Dimension

| Key                 | Value                           |
| ------------------- | ------------------------------- |
| `rds_cluster_id`      | RDS for MySQL Instance ID       |
| `dbproxy_instance_id` | RDS for MySQL Proxy Instance ID |
| `dbproxy_node_id`     | RDS for MySQL Proxy Node ID     |

## Object {#object}

The collected HUAWEI CLOUD RDS MYSQL object data structure can see the object data from「Infrastructure-Custom」

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
    "datastore"       : "{Database information}",
    "cpu"             : "2",
    "mem"             : "4",
    "volume"          : "{volume information}",
    "nodes"           : "[{Information about the active and standby Instance}]",
    "related_instance": "[]",
    "backup_strategy" : "{Backup strategy}",
    "message"         : "{Instance JSON data}"
  }
}
```

> *notice：`tags`,`fields`The fields in this section may change with subsequent updates*
>
> Tips  1：`tags.name`The value is the instance ID for unique identification
>
> Tips  2：The following fields are JSON serialized strings
>
> - `fields.message`
> - `fields.private_ips`
> - `fields.public_ips`
> - `fields.volume`
> - `fields.nodes`
> - `fields.related_instance`
> - `fields.backup_strategy`
>
> Tips 3：`type`The value is “Single”,“Ha” or “Replica”, "Enterprise",corresponding to stand-alone instance, active/standby instance, read-only instance, and distributed instance (enterprise edition) respectively.
