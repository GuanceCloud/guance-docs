---
title: 'Huawei Cloud GaussDB for MySQL'
tags: 
  - Huawei Cloud
summary: 'GaussDB for MySQL, including CPU, memory, network, buffer pool, storage, slow logs, `innoDB` and other related metrics.'
__int_icon: 'icon/huawei_gaussdb_for_mysql'
dashboard:

  - desc: 'Built-in views for GaussDB for MySQL'
    path: 'dashboard/en/huawei_gaussdb_for_mysql'

monitor:
  - desc: 'GaussDB for MySQL monitor'
    path: 'monitor/en/huawei_gaussdb_for_mysql'

---

<!-- markdownlint-disable MD025 -->
# Huawei Cloud GaussDB for MySQL
<!-- markdownlint-enable -->

GaussDB for MySQL, including CPU, memory, network, buffer pool, storage, slow logs, `innoDB` and other related metrics.


## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - Extension - Managed Func: all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> **Tip:** Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data for GaussDB for MySQL, we install the corresponding collection script:「Guance Integration (Huawei Cloud-Gaussdb-Mysql Collection)」(ID: `guance_huaweicloud_ddm_gaussdb_mysql`)

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK, Huawei Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Once enabled, you can see the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

We default to collecting some configurations, see the metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-gaussdb-mysql/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm that the corresponding task has an automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. On the Guance platform, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring GaussDB for MySQL, the default metric set is as follows. More metrics can be collected through configuration. [Huawei Cloud Monitoring Metric Details](https://support.huaweicloud.com/usermanual-gaussdb/gaussdb_03_0085.html){:target="_blank"}

| Metric ID                                | Metric Name             | Metric Description                                                     | Value Range      | Measurement Object (Dimension) | **Monitoring Period (Raw Metric)** |
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| `gaussdb_mysql001_cpu_util`                       | CPU Utilization            | This metric measures the CPU utilization of the measurement object.                       | 0～100%         | GaussDB(for MySQL) instance          | 1 minute 5 seconds 1 second                                           |
| `gaussdb_mysql002_mem_util`                            | Memory Utilization         | This metric measures the memory utilization of the measurement object.                                | 0~100%          | GaussDB(for MySQL) instance          | 1 minute 5 seconds 1 second                                             |
| `gaussdb_mysql004_bytes_in`                      | Network Input Throughput            | This metric measures the average traffic input per second from all network adapters of the measurement object.                       | ≥0 bytes/s           | GaussDB(for MySQL) instance          | 1 minute 5 seconds 1 second                                    |
| `gaussdb_mysql005_bytes_out`                            | Network Output Throughput                    | This metric measures the average traffic output per second from all network adapters of the measurement object. | ≥0 bytes/s    | GaussDB(for MySQL) instance | 1 minute 5 seconds 1 second              |
| `gaussdb_mysql006_conn_count`                       | Total Database Connections                    | This metric counts the total number of connections to the GaussDB(for MySQL) server.     | ≥0 counts     | GaussDB(for MySQL) instance | 1 minute 5 seconds 1 second              |
| `gaussdb_mysql007_conn_active_count`                            | Active Connection Count                    | This metric counts the current active connections.                             | ≥0 counts     | GaussDB(for MySQL) instance | 1 minute 5 seconds 1 second              |
| `gaussdb_mysql010_innodb_buf_usage`                       | Buffer Pool Usage                      | This metric measures the ratio of used pages to the total data pages in the InnoDB cache.         | 0-1           | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql011_innodb_buf_hit`                            | Buffer Pool Hit Rate                      | This metric measures the ratio of reads hit to read requests during this period.                 | 0-1           | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql012_innodb_buf_dirty`                       | Buffer Pool Dirty Block Rate                      | This metric measures the ratio of dirty data in the InnoDB cache.                 | 0～100%       | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql013_innodb_reads`                            | InnoDB Read Throughput                  | This metric measures the average bytes read per second by InnoDB.                       | ≥0 bytes/s    | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql014_innodb_writes`                       | InnoDB Write Throughput                  | This metric measures the average bytes written per second by InnoDB to temporary table pages. | ≥0 bytes/s    | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql017_innodb_log_write_req_count`                            | InnoDB Log Write Request Frequency              | This metric measures the average number of log write requests per second.                       | ≥0 counts     | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql020_temp_tbl_count`                       | Temporary Table Count                        | This metric counts the number of temporary tables created automatically on disk when executing statements in GaussDB(for MySQL). | ≥0 counts     | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql028_comdml_del_count`                            | Delete Statement Execution Frequency                | This metric measures the average number of Delete statements executed per second.                   | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute 5 seconds 1 second              |
| `gaussdb_mysql029_comdml_ins_count`                       | Insert Statement Execution Frequency                | This metric measures the average number of Insert statements executed per second.                   | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute 5 seconds 1 second              |
| `gaussdb_mysql030_comdml_ins_sel_count`                            | Insert_Select Statement Execution Frequency         | This metric measures the average number of Insert_Select statements executed per second.            | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql031_comdml_rep_count`                       | Replace Statement Execution Frequency               | This metric measures the average number of Replace statements executed per second.                  | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql032_comdml_rep_sel_count`                            | Replace_Selection Statement Execution Frequency     | This metric measures the average number of Replace_Selection statements executed per second.        | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql033_comdml_sel_count`                       | Select Statement Execution Frequency                | This metric measures the average number of Select statements executed per second.                   | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute 5 seconds 1 second              |
| `gaussdb_mysql034_comdml_upd_count`                            | Update Statement Execution Frequency                | This metric measures the average number of Update statements executed per second.                   | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute 5 seconds 1 second              |
| `gaussdb_mysql035_innodb_del_row_count`                       | Row Deletion Rate                        | This metric measures the average number of rows deleted per second from InnoDB tables.                 | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql036_innodb_ins_row_count`                            | Row Insertion Rate                        | This metric measures the average number of rows inserted per second into InnoDB tables.                 | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql037_innodb_read_row_count`                       | Row Read Rate                        | This metric measures the average number of rows read per second from InnoDB tables.                 | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql038_innodb_upd_row_count`                            | Row Update Rate                        | This metric measures the average number of rows updated per second in InnoDB tables.                 | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql048_disk_used_size`                       | Disk Usage Size                        | This metric measures the disk usage size of the measurement object.                       | 0GB～128TB    | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql072_conn_usage`                            | Connection Usage Rate                      | This metric measures the percentage of current used GaussDB(for MySQL) connections out of the maximum allowed. | 0~100%        | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql074_slow_queries`                       | Slow Query Count                    | This metric shows the number of slow queries generated by GaussDB(for MySQL) per minute.         | ≥0 counts/min | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql104_dfv_write_delay`                            | Storage Write Latency                        | This metric measures the average latency of writing data to the storage layer over a period of time.           | ≥0 ms         | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql105_dfv_read_delay`                       | Storage Read Latency                        | This metric measures the average latency of reading data from the storage layer over a period of time.           | ≥0 ms         | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql106_innodb_row_lock_current_waits`                            | InnoDB Row Lock Count                    | This metric collects the number of row locks currently waiting on InnoDB tables.![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**Note:** If there are DDL statements causing blocking, long transactions, or slow SQL, the number of waiting row locks may increase. | ≥0 Locks/s    | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql107_comdml_ins_and_ins_sel_count`                       | Insert and Insert_Select Statement Execution Frequency | This metric measures the average number of Insert and Insert_Select statements executed per second.  | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql108_com_commit_count`                            | Commit Statement Execution Frequency                | This metric measures the average number of Commit statements executed per second.                 | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql109_com_rollback_count`                       | Rollback Statement Execution Frequency              | This metric measures the average number of Rollback statements executed per second.               | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql110_innodb_bufpool_reads`                            | InnoDB Storage Layer Read Request Frequency            | This metric measures the average number of read requests from the storage layer by InnoDB per second.     | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql111_innodb_bufpool_read_requests`                       | InnoDB Read Request Frequency                  | This metric measures the average number of read requests by InnoDB per second.             | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql119_disk_used_ratio`                            | Disk Usage Rate                        | This metric measures the disk usage rate.                                 | 0~100%        | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql116_innodb_bufpool_read_ahead_rnd`                       | Innodb Random Pre-read Page Count                | This metric collects the number of random pre-read pages on InnoDB tables.                     | ≥0 counts     | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql117_innodb_pages_read`                            | Innodb Physical Page Reads Count          | This metric collects the number of physical pages read on InnoDB tables.               | ≥0 counts     | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql118_innodb_pages_written`                       | Innodb Physical Page Writes Count          | This metric collects the number of physical pages written on InnoDB tables.               | ≥0 counts     | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql342_iostat_iops_write`                            | IO Write IOPS                          | This metric collects the number of writes per second on the disk.                               | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql344_iostat_iops_read`                       | IO Read IOPS                          | This metric collects the number of reads per second on the disk.                               | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql346_iostat_throughput_write`                            | IO Write Bandwidth                          | This metric collects the write bandwidth per second on the disk.                               | ≥0 bytes/s    | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql348_iostat_throughput_read`                       | IO Read Bandwidth                          | This metric collects the read bandwidth per second on the disk.                               | ≥0 bytes/s    | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql123_sort_range`                            | Range Sort Count                        | This metric measures the number of sorts completed using range scans during this period.           | ≥0 counts/min | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql121_innodb_row_lock_time`                       | Row Lock Time Spent                      | This metric measures the time spent on row locks on InnoDB tables during this period.             | ≥0 ms         | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql122_innodb_row_lock_waits`                            | Row Lock Wait Count                        | This metric measures the number of row locks on InnoDB tables during this period.                 | ≥0 counts/min | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql126_table_open_cache_hits`                       | Open Table Cache Hits Count            | This metric measures the number of hits in the open table cache during this period.             | ≥0 counts/min | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql124_sort_rows`                            | Sorted Rows Count                          | This metric measures the number of sorted rows during this period.                       | ≥0 counts/min | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql125_sort_scan`                       | Scan Table Sort Count                      | This metric measures the number of sorts completed by scanning tables during this period.             | ≥0 counts/min | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql060_rx_errors`                            | Received Packet Error Rate                    | This metric measures the ratio of erroneous packets received to the total received packets during the monitoring period. | 0~100%        | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql127_table_open_cache_misses`                       | Open Table Cache Misses Count          | This metric measures the number of misses in the open table cache during this period.           | ≥0 counts/min | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql128_long_trx_count`                            | Number of Unclosed Long Transactions                | This metric measures the number of unclosed long transactions.                           | ≥0 counts     | GaussDB(for MySQL) instance | 150 seconds                    |
| `gaussdb_mysql063_tx_dropped`                       | Sent Packet Drop Rate                    | This metric measures the ratio of dropped packets sent to the total sent packets during the monitoring period. | 0~100%        | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql061_rx_dropped`                            | Received Packet Drop Rate                    | This metric measures the ratio of dropped packets received to the total received packets during the monitoring period. | 0~100%        | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql062_tx_errors`                       | Sent Packet Error Rate                    | This metric measures the ratio of erroneous packets sent to the total sent packets during the monitoring period. | 0~100%        | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql114_innodb_bufpool_read_ahead`                            | Innodb Sequential Pre-read Page Count                | This metric collects the number of sequential pre-read pages on InnoDB tables.                     | ≥0 counts     | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql378_create_temp_tbl_per_min`                       | Temporary Tables Created Per Minute                | This metric measures the number of temporary tables created automatically on disk per minute when executing statements in GaussDB(for MySQL). | ≥0counts/min  | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql371_taurus_binlog_total_file_counts`                            | Binlog File Count                    | This metric measures the number of Binlog files in GaussDB(for MySQL).             | ≥0            | GaussDB(for MySQL) instance | 5 minutes                    |
| `gaussdb_mysql115_innodb_bufpool_read_ahead_evicted`                       | Innodb Sequential Pre-read Unaccessed Pages Count  | This metric collects the number of sequential pre-read pages on InnoDB tables that were not accessed.       | ≥0 counts     | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql120_innodb_buffer_pool_bytes_data`                            | Buffer Pool Data Total Bytes                | This metric measures the total bytes of data contained in the InnoDB buffer pool.             | ≥0 bytes      | GaussDB(for MySQL) instance | 1 minute                    |



## Objects {#object}

The collected HUAWEI SYS.CBR object data structure can be viewed under 「Infrastructure - Custom」

``` json
{
  "measurement": "huaweicloud_gaussdb_mysql",
  "tags": {
    "RegionId"                : "cn-north-4",
    "db_user_name"            : "root",
    "name"                    : "2e10f990e139xxxxxx5fac6b59de7eein07",
    "port"                    : "3306",
    "project_id"              : "c631f046252d4xxxxxxx5f253c62d48585",
    "status"                  : "BUILD",
    "type"                    : "Cluster",
    "vpc_id"                  : "f6bc2c55-2a95-xxxx-xxxx-7b09e9a8de13",
    "instance_id"             : "2e10f990e139xxxxxx5fac6b59de7eein07",
    "instance_name"           : "nosql-efa7"
  },
  "fields": {
    "charge_info"          : "{Billing type information, supports prepaid and pay-as-you-go, default is pay-as-you-go}",
    "create_time"          : "2023-08-01T14:17:40+0800",
    "update_time"          : "2023-08-01T14:17:42+0800",
    "private_ips"          : "[\"192.168.0.223\"]",
    "proxy_ips"            : "[]",
    "readonly_private_ips" : "[Private IP address list of the read replica]",
    "message"              : "{Instance JSON data}"
  }
}


```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, used as a unique identifier.
>
> Tip 2: `fields.message`, `fields.charge_info`, `fields.private_ips`, `fields.proxy_ips`, and `fields.readonly_private_ips` are JSON serialized strings.
