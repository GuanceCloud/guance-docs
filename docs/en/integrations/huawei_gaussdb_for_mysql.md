---
title: 'Huawei Cloud GaussDB for MySQL'
tags: 
  - Huawei Cloud
summary: 'GaussDB for MySQL, including cpu, memory, network, buffer pool, storage, slow logs, `innoDB` and other related metrics.'
__int_icon: 'icon/huawei_gaussdb_for_mysql'
dashboard:

  - desc: 'GaussDB for MySQL built-in views'
    path: 'dashboard/en/huawei_gaussdb_for_mysql'

monitor:
  - desc: 'GaussDB for MySQL monitors'
    path: 'monitor/en/huawei_gaussdb_for_mysql'

---


<!-- markdownlint-disable MD025 -->
# Huawei Cloud GaussDB for MySQL
<!-- markdownlint-enable -->

GaussDB for MySQL, including cpu, memory, network, buffer pool, storage, slow logs, `innoDB` and other related metrics.


## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - hosted Func: all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize GaussDB for MySQL monitoring data, we install the corresponding collection script: 「<<< custom_key.brand_name >>> Integration (Huawei Cloud-Gaussdb-Mysql Collection)」(ID: `guance_huaweicloud_ddm_gaussdb_mysql`)

After clicking 【Install】, input the corresponding parameters: Huawei Cloud AK, Huawei Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to immediately execute it once without waiting for the regular time. After a while, you can view the execution task records and corresponding logs.

We default collect some configurations, for details, see the Metrics section.

[Configure custom cloud object metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-huaweicloud-gaussdb-mysql/){:target="_blank"}



### Verification

1. In 「Manage / Automatic Trigger Configuration」confirm whether the corresponding task has an automatic trigger configuration, and at the same time, you can view the corresponding task records and log checks for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, in 「Infrastructure / Custom」check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, in 「Metrics」check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring GaussDB for MySQL, the default metric set is as follows. More metrics can be collected through configuration. [Huawei Cloud Cloud Monitoring Metric Details](https://support.huaweicloud.com/usermanual-gaussdb/gaussdb_03_0085.html){:target="_blank"}

| Metric ID                                | Metric Name             | Metric Meaning                                                     | Value Range      | Measurement Object (Dimension) | **Monitoring Cycle (Raw Metric)** |
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| `gaussdb_mysql001_cpu_util`                       | CPU Utilization            | This metric is used to count the CPU utilization of the measurement object.                       | 0～100%         | GaussDB(for MySQL) instance          | 1 minute 5 seconds 1 second                                           |
| `gaussdb_mysql002_mem_util`                            | Memory Utilization         | This metric is used to count the memory utilization of the measurement object.                                | 0~100%          | GaussDB(for MySQL) instance          | 1 minute 5 seconds 1 second                                             |
| `gaussdb_mysql004_bytes_in`                      | Network Input Throughput            | This metric is used to count the average traffic per second from all network adapters of the measurement object.                       | ≥0 bytes/s           | GaussDB(for MySQL) instance          | 1 minute 5 seconds 1 second                                    |
| `gaussdb_mysql005_bytes_out`                            | Network Output Throughput                    | This metric is used to count the average traffic per second from all network adapters of the measurement object. | ≥0 bytes/s    | GaussDB(for MySQL) instance | 1 minute 5 seconds 1 second              |
| `gaussdb_mysql006_conn_count`                       | Total Database Connections                    | This metric is used to count the total number of connections to the GaussDB(for MySQL) server.     | ≥0 counts     | GaussDB(for MySQL) instance | 1 minute 5 seconds 1 second              |
| `gaussdb_mysql007_conn_active_count`                            | Current Active Connections                    | This metric is used to count the current active connections.                             | ≥0 counts     | GaussDB(for MySQL) instance | 1 minute 5 seconds 1 second              |
| `gaussdb_mysql010_innodb_buf_usage`                       | Buffer Pool Utilization                      | This metric is used to count the ratio of used pages to the total data pages in the InnoDB cache.         | 0-1           | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql011_innodb_buf_hit`                            | Buffer Pool Hit Rate                      | This metric is used to count the ratio of read hits to read requests during this period.                 | 0-1           | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql012_innodb_buf_dirty`                       | Buffer Pool Dirty Block Rate                      | This metric is used to count the ratio of dirty data to data in the InnoDB cache.                 | 0～100%       | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql013_innodb_reads`                            | InnoDB Read Throughput                  | This metric is used to count the average number of bytes read per second by Innodb.                       | ≥0 bytes/s    | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql014_innodb_writes`                       | InnoDB Write Throughput                  | This metric is used to count the average number of bytes written per second by Innodb to temporary table pages. GaussDB(for MySQL) only writes temporary table pages. | ≥0 bytes/s    | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql017_innodb_log_write_req_count`                            | InnoDB Log Write Request Frequency              | This metric is used to count the average number of log write requests per second.                       | ≥0 counts     | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql020_temp_tbl_count`                       | Temporary Table Count                        | This metric is used to count the number of temporary tables automatically created on disk when executing GaussDB(for MySQL) statements. | ≥0 counts     | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql028_comdml_del_count`                            | Delete Statement Execution Frequency                | This metric is used to count the average number of Delete statement executions per second.                   | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute 5 seconds 1 second              |
| `gaussdb_mysql029_comdml_ins_count`                       | Insert Statement Execution Frequency                | This metric is used to count the average number of Insert statement executions per second.                   | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute 5 seconds 1 second              |
| `gaussdb_mysql030_comdml_ins_sel_count`                            | Insert_Select Statement Execution Frequency         | This metric is used to count the average number of Insert_Select statement executions per second.            | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql031_comdml_rep_count`                       | Replace Statement Execution Frequency               | This metric is used to count the average number of Replace statement executions per second.                  | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql032_comdml_rep_sel_count`                            | Replace_Selection Statement Execution Frequency     | This metric is used to count the average number of Replace_Selection statement executions per second.        | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql033_comdml_sel_count`                       | Select Statement Execution Frequency                | This metric is used to count the average number of Select statement executions per second.                   | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute 5 seconds 1 second              |
| `gaussdb_mysql034_comdml_upd_count`                            | Update Statement Execution Frequency                | This metric is used to count the average number of Update statement executions per second.                   | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute 5 seconds 1 second              |
| `gaussdb_mysql035_innodb_del_row_count`                       | Row Deletion Rate                        | This metric is used to count the average number of rows deleted per second from the InnoDB table.                 | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql036_innodb_ins_row_count`                            | Row Insertion Rate                        | This metric is used to count the average number of rows inserted per second into the InnoDB table.                 | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql037_innodb_read_row_count`                       | Row Reading Rate                        | This metric is used to count the average number of rows read per second from the InnoDB table.                 | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql038_innodb_upd_row_count`                            | Row Update Rate                        | This metric is used to count the average number of rows updated per second in the InnoDB table.                 | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql048_disk_used_size`                       | Disk Usage                        | This metric is used to count the disk usage size of the measurement object.                       | 0GB～128TB    | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql072_conn_usage`                            | Connection Usage Rate                      | This metric is used to count the percentage of current used GaussDB(for MySQL) connections out of the maximum connections. | 0~100%        | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql074_slow_queries`                       | Slow Log Count Statistics                    | This metric shows the number of slow logs generated by GaussDB(for MySQL) per minute.         | ≥0 counts/min | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql104_dfv_write_delay`                            | Storage Write Latency                        | This metric is used to count the average latency of writing data to the storage layer during a certain period.           | ≥0 ms         | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql105_dfv_read_delay`                       | Storage Read Latency                        | This metric is used to count the average latency of reading data from the storage layer during a certain period.           | ≥0 ms         | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql106_innodb_row_lock_current_waits`                            | InnoDB Row Lock Count                    | This metric collects the number of row locks currently being waited on for operations on InnoDB tables. ![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**Note:** If there are DDL statements causing blocking, long transactions, or slow SQLs, the number of waiting row locks may increase. | ≥0 Locks/s    | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql107_comdml_ins_and_ins_sel_count`                       | Insert and Insert_Select Statement Execution Frequency | This metric is used to count the average number of executions per second of Insert and Insert_Select statements.  | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql108_com_commit_count`                            | Commit Statement Execution Frequency                | This metric is used to count the average number of Commit statement executions per second.                 | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql109_com_rollback_count`                       | Rollback Statement Execution Frequency              | This metric is used to count the average number of Rollback statement executions per second.               | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql110_innodb_bufpool_reads`                            | InnoDB Storage Layer Read Request Frequency            | This metric is used to count the average number of requests per second InnoDB reads data from the storage layer.     | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql111_innodb_bufpool_read_requests`                       | InnoDB Read Request Frequency                  | This metric is used to count the average number of requests per second InnoDB reads data.             | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql119_disk_used_ratio`                            | Disk Usage Ratio                        | This metric is used to count the disk usage ratio.                                 | 0~100%        | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql116_innodb_bufpool_read_ahead_rnd`                       | Innodb Random Read-Ahead Page Count                | This metric collects the random read-ahead page count on InnoDB tables.                     | ≥0 counts     | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql117_innodb_pages_read`                            | Innodb Physical Page Reads Count          | This metric collects the physical page read count on InnoDB tables.               | ≥0 counts     | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql118_innodb_pages_written`                       | Innodb Physical Page Writes Count          | This metric collects the physical page write count on InnoDB tables.               | ≥0 counts     | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql342_iostat_iops_write`                            | IO Write IOPS                          | This metric collects the disk write count per second.                               | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql344_iostat_iops_read`                       | IO Read IOPS                          | This metric collects the disk read count per second.                               | ≥0 counts/s   | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql346_iostat_throughput_write`                            | IO Write Bandwidth                          | This metric collects the disk write bandwidth per second.                               | ≥0 bytes/s    | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql348_iostat_throughput_read`                       | IO Read Bandwidth                          | This metric collects the disk read bandwidth per second.                               | ≥0 bytes/s    | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql123_sort_range`                            | Range Sort Count                        | This metric counts the sort operations completed using range scans during this period.           | ≥0 counts/min | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql121_innodb_row_lock_time`                       | Row Lock Time Spent                      | This metric counts the row lock time spent on InnoDB tables during this period.             | ≥0 ms         | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql122_innodb_row_lock_waits`                            | Row Lock Wait Count                        | This metric counts the row lock count on InnoDB tables during this period.                 | ≥0 counts/min | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql126_table_open_cache_hits`                       | Open Table Cache Lookup Hit Count            | This metric counts the hit count of open table cache lookups during this period.             | ≥0 counts/min | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql124_sort_rows`                            | Row Sort Count                          | This metric counts the sorted row count during this period.                       | ≥0 counts/min | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql125_sort_scan`                       | Scan Table Sort Count                      | This metric counts the sort operations completed by scanning tables during this period.             | ≥0 counts/min | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql060_rx_errors`                            | Received Packet Error Rate                    | This metric counts the ratio of erroneous packets received to all received packets within the monitoring cycle. | 0~100%        | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql127_table_open_cache_misses`                       | Open Table Cache Lookup Miss Count          | This metric counts the miss count of open table cache lookups during this period.           | ≥0 counts/min | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql128_long_trx_count`                            | Number of Unclosed Long Transactions                | This metric counts the number of unclosed long transactions.                           | ≥0 counts     | GaussDB(for MySQL) instance | 150 seconds                    |
| `gaussdb_mysql063_tx_dropped`                       | Sent Packet Drop Rate                    | This metric counts the ratio of dropped packets sent to all sent packets within the monitoring cycle. | 0~100%        | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql061_rx_dropped`                            | Received Packet Drop Rate                    | This metric counts the ratio of dropped packets received to all received packets within the monitoring cycle. | 0~100%        | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql062_tx_errors`                       | Sent Packet Error Rate                    | This metric counts the ratio of erroneous packets sent to all sent packets within the monitoring cycle. | 0~100%        | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql114_innodb_bufpool_read_ahead`                            | Innodb Sequential Read-Ahead Page Count                | This metric collects the sequential read-ahead page count on InnoDB tables.                     | ≥0 counts     | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql378_create_temp_tbl_per_min`                       | Temporary Tables Created Per Minute                | This metric counts the number of temporary tables automatically created on disk per minute when executing GaussDB(for MySQL) statements. | ≥0counts/min  | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql371_taurus_binlog_total_file_counts`                            | Binlog File Count                    | This metric counts the number of Binlog files for GaussDB(for MySQL).             | ≥0            | GaussDB(for MySQL) instance | 5 minutes                    |
| `gaussdb_mysql115_innodb_bufpool_read_ahead_evicted`                       | Innodb Sequential Read-Ahead Pages Not Accessed  | This metric collects the sequential read-ahead pages not accessed on InnoDB tables.       | ≥0 counts     | GaussDB(for MySQL) instance | 1 minute                    |
| `gaussdb_mysql120_innodb_buffer_pool_bytes_data`                            | Buffer Pool Data Total Byte Count                | This metric counts the total byte count of data in the InnoDB buffer pool.             | ≥0 bytes      | GaussDB(for MySQL) instance | 1 minute                    |



## Objects {#object}

The HUAWEI SYS.CBR object data structure collected can be seen in the object data under 「Infrastructure-Custom」

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
    "charge_info"          : "{Billing type information, supports annual/monthly and pay-as-you-go, defaults to pay-as-you-go}",
    "create_time"          : "2023-08-01T14:17:40+0800",
    "update_time"          : "2023-08-01T14:17:42+0800",
    "private_ips"          : "[\"192.168.0.223\"]",
    "proxy_ips"            : "[]",
    "readonly_private_ips" : "[Instance read internal IP address list]",
    "message"              : "{Instance JSON data}"
  }
}


```

> *Note: The fields in `tags`, `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, used as unique identification.
>
> Tip 2: `fields.message`, `fields.charge_info`, `fields.private_ips`, `fields.proxy_ips`, `fields.readonly_private_ips`, are all JSON serialized strings.