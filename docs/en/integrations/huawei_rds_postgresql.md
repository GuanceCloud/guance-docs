---
title: '华为云 RDS PostgreSQL'
summary: '使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云'
__int_icon: 'icon/huawei_rds_postgresql'
dashboard:

  - desc: '华为云 RDS PostgreSQL 内置视图'
    path: 'dashboard/zh/huawei_rds_postgresql'

monitor:
  - desc: '华为云 RDS PostgreSQL 监控器'
    path: 'monitor/zh/huawei_rds_postgresql'

---


<!-- markdownlint-disable MD025 -->
# Huawei RDS postgresql
<!-- markdownlint-enable -->

Use the「Guance Cloud Synchronization」series script package in the script market to monitor the cloud ,The data of the cloud asset is synchronized to the Guance cloud.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically,Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip: Please prepare Huawei AK that meets the requirements in advance（For simplicity's sake,You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of  Huawei RDS PostgreSQL cloud resources, we install the corresponding collection script:To access the [脚本市场] via the web service of Func,「观测云集成（华为云-RDS-PostgreSQL 采集）」(ID：`guance_huaweicloud_rds_postgresql`)

Click 【Install】 and enter the corresponding parameters: Huawei AK,SK,Huawei account name.

Tap【Deploy startup Script】，The system automatically creates Startup script sets，And automatically configure the corresponding startup script.

After the script is installed,Find the script in「Development」in Func「观测云集成（华为云-RDS采集）」,Expand to modify this script,find collector_configsandmonitor_configsEdit the content inregion_projects,Change the locale and Project ID to the actual locale and Project ID,Click Save Publish again.

In addition, the corresponding automatic trigger configuration is displayed in「Management / Crontab Config」. Tap【Run】,It can be executed immediately once,without waiting for a periodic time.After a while,you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-rds-postgresql/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure Huawei Cloud - cloud monitoring. The default indicator set is as follows. You can collect more indicators by configuring them [Huawei CloudMonitor Metrics Details](https://support.huaweicloud.com/usermanual-rds/rds_pg_06_0001.html){:target="_blank"}

### Instance monitoring metric

RDS for postgresql instance performance monitoring metric,as shown in the table below.

| Indicator ID                                     | Indicator name                                | Indicator meaning                                                     | Value range           | Monitoring cycle(original indicator) |
| ------------------------------------------ | --------------------------------------- | ------------------------------------------------------------ | ------------------ | -------------------- |
| `rds001_cpu_util`| CPU usage rate| This metric is used to track the CPU usage rate of the measured object, in ratio units.| 0-100%|  1 minute| 
| `rds002_mem_util`| Memory usage rate| This metric is used to track the memory usage rate of the measured object, in ratio units.| 0-100%|  1 minute| 
| `rds047_disk_total_size`| Total disk size| This metric is used to track the total disk size of the measured object.| 40GB~15000GB|  1 minute| 
| `rds048_disk_used_size`| Disk usage| This metric is used to track the disk usage size of the measured object.| 0GB~15000GB|  1 minute| 
| `rds039_disk_util`| Disk utilization rate| This metric is used to track the disk utilization rate of the measured object, in ratio units.| 0-100%|  1 minute| 
| `disk_io_usage`| Disk IO usage rate| This metric is used to track the disk IO usage rate.| 0-100%|  1 minute| 
| `rds049_disk_read_throughput`| Disk read throughput| This metric is used to track the number of bytes read from the disk per second.| ≥ 0 bytes/s|  1 minute| 
| `rds050_disk_write_throughput`| Disk write throughput| This metric is used to track the number of bytes written to the disk per second.| ≥ 0 bytes/s|  1 minute| 
| `swap_total_size`| Total capacity of swap area| This metric is used to track the total amount of swap space.| ≥ 0 MB|  1 minute| 
| `swap_usage`| Swap area usage rate| This metric is used to track the swap space usage rate.| 0-100%|  1 minute| 
| `rds005_bytes_out`| Network output throughput| This metric is used to track the average amount of traffic output from all network adapters of the measured object per second, in bytes/second.| ≥ 0 bytes/s|  1 minute| 
| `rds004_bytes_in`| Network input throughput| This metric is used to track the average amount of traffic input from all network adapters of the measured object per second, in bytes/second.| ≥ 0 bytes/s|  1 minute| 
| `rds003_iops`| IOPS| This metric is used to track the average number of I/O requests processed by the system per unit time (average).| ≥ 0 counts/s|  1 minute| 
| `read_count_per_second`| Read IOPS| This metric is used to track the average number of read I/O requests processed by the system per unit time (average).| ≥ 0 counts/s|  1 minute| 
| `write_count_per_second`| Write IOPS| This metric is used to track the average number of write I/O requests processed by the system per unit time (average).| ≥ 0 counts/s|  1 minute| 
| `rds042_database_connections`| Database connection count| The number of backends currently connected to the database.| ≥ 0 counts|  1 minute| 
| `rds083_conn_usage`| Connection usage rate| This metric is used to track the percentage of used PgSQL connections to total connections.| 0-100%|  1 minute| 
| `active_connections`| Active connection count| This metric is used to track the current active connections to the database.| ≥ 0|  1 minute| 
| `rds082_tps`| TPS| This metric is used to track the number of transaction executions per second, including commits and rollbacks.| ≥ 0 次/秒|  1 minute| 
| `rds046_replication_lag`| Replication delay| Replication lag delay.| ≥ 0 ms|  1 minute| 
| `synchronous_replication_blocking_time`| Synchronous replication blocking time| This metric is used to track the duration of replication blocking between the synchronous replication master and standby machine.| ≥ 0 s|  1 minute| 
| `inactive_logical_replication_slot`| Number of inactive logical replication slots| This metric is used to track the number of inactive logical replication slots in the current database.| ≥ 0|  1 minute| 
| `rds041_replication_slot_usage`| Replication slot usage| Disk space used by replication slot files.| ≥ 0 MB|  1 minute| 
| `rds043_maximum_used_transaction_ids`| Maximum number of used transaction IDs| Maximum transaction ID used.| ≥ 0 counts|  1 minute| 
| `idle_transaction_connections`| Number of idle connections for transactions| Number of current idle connections to the database.| ≥ 0|  1 minute| 
| `oldest_transaction_duration`| Longest transaction lifetime| Longest transaction lifetime in the current database.| ≥ 0 ms|  1 minute| 
| `oldest_transaction_duration_2pc`| Longest pending transaction lifetime| Longest pending transaction lifetime in the current database.| ≥ 0 ms|  1 minute| 
| `rds040_transaction_logs_usage`| Transaction log usage| Disk space occupied by transaction logs.| ≥ 0 MB|  1 minute| 
| `lock_waiting_sessions`| Number of sessions waiting for locks| Number of sessions currently blocked.| ≥ 0|  1 minute| 
| `slow_sql_log_min_duration_statement`| Number of SQL statements executed with log_min_duration_statement| Number of slow SQL queries that take longer than the log_min_duration_statement parameter. The parameter size can be adjusted based on business needs.| ≥ 0|  1 minute| 
| `slow_sql_one_second`| Number of SQL statements executed in 1 second| Number of slow SQL queries that take longer than 1 second.| ≥ 0|  1 minute| 
| `slow_sql_three_second`| Number of SQL statements executed in 3 seconds| Number of slow SQL queries that take longer than 3 seconds.| ≥ 0|  1 minute| 
| `slow_sql_five_second`| Number of SQL statements executed in 5 seconds| Number of slow SQL queries that take longer than 5 seconds.| ≥ 0|  1 minute| 

## Object {#object}

The collected Huawei Cloud RDS PostgreSQL object data structure can see the object data from「基础设施-自定义」

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
    "engine"                 : "postgresql",
    "engine_version"         : "5.7"
  },
  "fields": {
    "created_time"    : "2022-06-21T06:17:27+0000",
    "updated_time"    : "2022-06-21T06:20:03+0000",
    "alias"           : "xxx",
    "private_ips"     : "[\"192.xxx.x.144\"]",
    "public_ips"      : "[]",
    "datastore"       : "{数据库信息}",
    "cpu"             : "2",
    "mem"             : "4",
    "volume"          : "{volume 信息}",
    "nodes"           : "[{主备实例信息}]",
    "related_instance": "[]",
    "backup_strategy" : "{备份策略}",
    "message"         : "{实例 JSON 数据}"
  }
}
```

> *notice：`tags`、`fields`The fields in this section may change with subsequent updates*
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
> Tips 3：`type`The value is “Single”，“Ha” or “Replica”, "Enterprise"，corresponding to stand-alone instance, active/standby instance, read-only instance, and distributed instance (enterprise edition) respectively.