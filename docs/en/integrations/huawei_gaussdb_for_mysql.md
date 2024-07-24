---
title: 'HUAWEI GaussDB for MySQL'
tags: 
  - Huawei Cloud
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.'
__int_icon: 'icon/gaussdb_for_mysql'
dashboard:

  - desc: 'HUAWEI CLOUD GaussDB for MySQL Monitoring View'
    path: 'dashboard/zh/gaussdb_for_mysql'

monitor:
  - desc: 'HUAWEI CLOUD GaussDB for MySQL Monitor'
    path: 'monitor/zh/gaussdb_for_mysql'

---


<!-- markdownlint-disable MD025 -->
# HUAWEI CLOUD GaussDB for MySQL
<!-- markdownlint-enable -->

HUAWEI CLOUD GaussDB for MySQL includes metrics related to CPU, memory, network, buffer pool, storage, slow logs, and `InnoDB` performance.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to  [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare HUAWEI CLOUD AK that meets the requirements in advance（For simplicity's sake,You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of  GaussDB for MySQL , we install the corresponding collection script：「Guance Integration（HUAWEI CLOUD-CBRCollect）」(ID：`guance_huaweicloud_ddm_gaussdb_mysql`)

Click 【Install】 and enter the corresponding parameters: HUAWEI CLOUD AK, HUAWEI CLOUD account name.

tap【Deploy startup Script】,The system automatically creates `Startup` script sets,And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」.Click【Run】,you can immediately execute once, without waiting for a regular time.After a while, you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-gaussdb-mysql/){:target="_blank"}

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure HUAWEI CLOUD SYS.CBR monitoring. The default metric set is as follows. You can collect more metrics by configuring them [HUAWEI CLOUD Monitor Metrics Details](https://support.huaweicloud.com/usermanual-gaussdb/gaussdb_03_0085.html){:target="_blank"}

| **Metric**                                         | **Name**                                       | **Description**                                              | **Value Range** | **Remarks**                                                  |
|------------------------------------|----------------------------------------------------------| ------------------------------------------------------------ | ---------- | ---------------- |
| gaussdb_mysql001_cpu_util                          | CPU Usage                                      | CPU usage of the monitored object                            | 0–100%          | Monitored object: ECSMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql002_mem_util                          | Memory Usage                                   | Memory usage of the monitored object                         | 0–100%          | Monitored object: ECSMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql004_bytes_in                          | Network Input Throughput                       | Incoming traffic in bytes per second                         | ≥0 Bytes/s      | Monitored object: ECSMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql005_bytes_out                            | Network Output Throughput                      | Outgoing traffic in bytes per second                         | ≥0 Bytes/s      | Monitored object: ECSMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql006_conn_count                       | Total Connections                              | Total number of connections that connect to the MySQL server | ≥0 Connections  | Monitored object: databaseMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql007_conn_active_count                            | Current Active Connections                     | Number of active connections                                 | ≥0 Connections  | Monitored object: databaseMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql010_innodb_buf_usage                       | Buffer Pool Usage                              | Ratio of used pages to total pages in the InnoDB buffer      | 0–100%          | Monitored object: ECSMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql011_innodb_buf_hit                            | Buffer Pool Hit Ratio                          | Ratio of read hits to read requests in the InnoDB buffer     | 0–100%          | Monitored object: ECSMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql012_innodb_buf_dirty                       | Buffer Pool Dirty Block Ratio                  | Ratio of dirty data to all data in the InnoDB buffer         | 0–100%          | Monitored object: databaseMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql013_innodb_reads                            | InnoDB Read Throughput                         | Number of read bytes per second in the InnoDB buffer         | ≥0 Bytes/s      | Monitored object: databaseMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql014_innodb_writes                       | InnoDB Write Throughput                        | Number of write bytes per second in the InnoDB buffer        | ≥0 Bytes/s      | Monitored object: ECSMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql017_innodb_log_write_req_count                            | InnoDB Log Write Requests per Second           | Number of InnoDB log write requests per second               | ≥0 Requests/s   | Monitored object: ECSMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql020_temp_tbl_count                       | Temporary Tables                               | Number of temporary tables automatically created on hard disks when MySQL statements are executed | ≥0 Tables       | Monitored object: ECSMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql028_comdml_del_count                            | DELETE Statements per Second                   | Number of DELETE statements executed per second              | ≥0 Statements/s | Monitored object: ECSMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql029_comdml_ins_count                       | INSERT Statements per Second                   | Number of INSERT statements executed per second              | ≥0 Statements/s | Monitored object: databaseMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql030_comdml_ins_sel_count                            | INSERT_SELECT Statements per Second            | Number of INSERT_SELECT statements executed per second       | ≥0 Statements/s | Monitored object: databaseMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql031_comdml_rep_count                       | REPLACE Statements per Second                  | Number of REPLACE statements executed per second             | ≥0 Statements/s | Monitored object: ECSMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql032_comdml_rep_sel_count                            | REPLACE_SELECTION Statements per Second        | Number of REPLACE_SELECTION statements executed per second   | ≥0 Statements/s | Monitored object: ECSMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql033_comdml_sel_count                       | SELECT Statements per Second                   | Number of SELECT statements executed per second              | ≥0 Statements/s | Monitored object: ECSMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql034_comdml_upd_count                            | UPDATE Statements per Second                   | Number of UPDATE statements executed per second              | ≥0 Statements/s | Monitored object: ECSMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql035_innodb_del_row_count                       | Row Delete Frequency                           | Number of rows deleted from the InnoDB table per second      | ≥0 Rows/s       | Monitored object: databaseMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql036_innodb_ins_row_count                            | Row Insert Frequency                           | Number of rows inserted into the InnoDB table per second     | ≥0 Rows/s       | Monitored object: databaseMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql037_innodb_read_row_count                       | Row Read Frequency                             | Number of rows read from the InnoDB table per second         | ≥0 Rows/s       | Monitored object: ECSMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql038_innodb_upd_row_count                            | Row Update Frequency                           | Number of rows updated into the InnoDB table per second      | ≥0 Rows/s       | Monitored object: ECSMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql048_disk_used_size                       | Used Storage Space                             | Used storage space of the monitored object                   | 0 GB-128 TB     | Monitored object: ECSMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql072_conn_usage                            | Connection Usage                               | Percent of used MySQL connections to the total number of connections | 0-100%          | Monitored object: ECSMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql074_slow_queries                       | Slow Query Logs                                | Number of MySQL slow query logs generated per minute         | ≥0 Queries/min  | Monitored object: databaseMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql104_dfv_write_delay                            | Storage Write Latency                          | Average latency of writing data to the storage layer in a specified period | ≥0 ms           | Monitored object: ECSMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql105_dfv_read_delay                       | Storage Read Latency                           | Average latency of reading data from the storage layer in a specified period | ≥0 ms           | Monitored object: ECSMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql106_innodb_row_lock_current_waits                            | InnoDB Row Locks                               | Number of row locks being waited by operations on the InnoDB table | ≥0 Locks        | Monitored object: ECSMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql107_comdml_ins_and_ins_sel_count                       | INSERT and INSERT_SELECT Statements per Second | Number of INSERT and INSERT_SELECT statements executed per second | ≥0 Statements/s | Monitored object: ECSMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql108_com_commit_count                            | COMMIT Statements per Second                   | Number of COMMIT statements executed per second              | ≥0 Statements/s | Monitored object: databaseMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql109_com_rollback_count                       | ROLLBACK Statements per Second                 | Number of ROLLBACK statements executed per second            | ≥0 Statements/s | Monitored object: databaseMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql110_innodb_bufpool_reads                            | InnoDB Storage Layer Read Requests per Second  | Number of times that InnoDB reads data from the storage layer per second | ≥0 Times/s      | Monitored object: databaseMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql111_innodb_bufpool_read_requests                       | InnoDB Read Requests per Second                | Number of InnoDB read requests per second                    | ≥0 Requests/s   | Monitored object: databaseMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql119_disk_used_ratio                            | Disk Usage                                     | Disk usage of the monitored object                           | 0-100%          | Monitored object: databaseMonitored instance type: GaussDB(for MySQL) instance1 minute |
| gaussdb_mysql116_innodb_bufpool_read_ahead_rnd                       | InnoDB **Bufpool** Read Ahead Rnd                  | Number of random **read-aheads** initiated by InnoDB             | ≥0 **Read-aheads**  | Monitored object: databaseMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql117_innodb_pages_read                            | InnoDB Pages Read                              | Number of pages read from the InnoDB buffer pool by operations on InnoDB tables | ≥0 Pages        | Monitored object: databaseMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql118_innodb_pages_written                       | InnoDB Pages Written                           | Number of pages written by operations on InnoDB tables       | ≥0 Pages        | Monitored object: databaseMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql342_iostat_iops_write                            | I/O Write IOPS                                 | Number of disk writes per second                             | ≥0 Operations/s | Monitored object: databaseMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql344_iostat_iops_read                       | I/O Read IOPS                                  | Number of disk reads per second                              | ≥0 Operations/s | Monitored object: databaseMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql346_iostat_throughput_write                            | I/O Write Bandwidth                            | Disk write bandwidth per second                              | ≥0 Bytes/s      | Monitored object: databaseMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql348_iostat_throughput_read                       | I/O Read Bandwidth                             | Disk read bandwidth per second                               | ≥0 Bytes/s      | Monitored object: databaseMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql114_innodb_bufpool_read_ahead                            | InnoDB **Bufpool** Read Ahead                      | Number of pages read into the InnoDB buffer pool by the read-ahead background thread | ≥0 Pages        | Monitored object: databaseMonitored instance type: GaussDB(for MySQL) instance |
| gaussdb_mysql378_create_temp_tbl_per_min                       | Temporary Tables Created per Minute            | Number of temporary tables automatically created on disks per minute when GaussDB(for MySQL) statements are executed | ≥0counts/min    | Monitored object: databaseMonitored instance type: GaussDB(for MySQL) instance1 minute |
| gaussdb_mysql371_taurus_binlog_total_file_counts                            | Binlog Files                                   | Number of GaussDB(for MySQL) **binlog** files                    | ≥0              | Monitored object: databaseMonitored instance type: GaussDB(for MySQL) instance5 minutes |
| gaussdb_mysql115_innodb_bufpool_read_ahead_evicted                       | InnoDB **Bufpool** Read Ahead Evicted              | Number of pages read into the InnoDB buffer pool by the read-ahead background thread that were subsequently evicted without having been accessed by queries | ≥0 Pages        | Monitored object: databaseMonitored instance type: GaussDB(for MySQL) instance |

## Object {#object}

The collected HUAWEI CLOUD OBS object data structure can see the object data from 「Infrastructure-Custom」

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
    "charge_info"          : "{The value can be yearly or monthly or on-demand. The default value is on-demand}",
    "create_time"          : "2023-08-01T14:17:40+0800",
    "update_time"          : "2023-08-01T14:17:42+0800",
    "private_ips"          : "[\"192.168.0.223\"]",
    "proxy_ips"            : "[]",
    "readonly_private_ips" : "[Instance Reads the Intranet IP address list]",
    "message"              : "{Instance JSON data}"
  }
}

```


> *notice：`tags`、`fields`The fields in this section may change with subsequent updates*
>
> Tips 1：`tags.name`The value serves as the instance ID for unique identification
>
> Tips 2：`fields.message`、`fields.charge_info`、`fields.private_ips`、`fields.proxy_ips`、`fields.readonly_private_ips`、are all JSON-serialized string representations.

