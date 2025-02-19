---
title: '华为云 RDS MariaDB'
tags: 
  - 华为云
summary: '采集华为云 RDS MariaDB 指标数据'
__int_icon: 'icon/huawei_rds_mariadb'
dashboard:

  - desc: '华为云 RDS MariaDB 监控视图'
    path: 'dashboard/zh/huawei_rds_mariadb'

monitor:
  - desc: '华为云 RDS MariaDB 监控器'
    path: 'monitor/zh/huawei_rds_mariadb'

---

采集华为云 RDS MariaDB 指标数据

## 配置 {#config}

### 安装 Func

推荐开通 {{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> 推荐部署GSE版

### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步华为云 RDS MariaDB 的监控数据，我们安装对应的采集脚本：「{{{ custom_key.brand_name }}}集成（华为云-RDS-MariaDB 采集）」(ID：`guance_huaweicloud_rds_mariadb`)

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

脚本安装完后，在 Func 中「开发」里找到脚本「{{{ custom_key.brand_name }}}集成（华为云-RDS-MariaDB 采集）」，展开修改此脚本，找到 collector_configs 和 monitor_configs 分别编辑下面region_projects中的内容，将地域和 Project ID,更改为实际的地域和 Project ID，再点击保存发布。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在{{{ custom_key.brand_name }}}平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在{{{ custom_key.brand_name }}}平台，「指标」查看是否有对应监控数据

## 指标 {#metric}

配置华为云 RDS MariaDB 指标,可以通过配置的方式采集更多的指标 [华为云 RDS MariaDB 指标详情](https://support.huaweicloud.com/usermanual-rds/maria_03_0087.html){:target="_blank"}

RDS for MariaDB 实例性能监控指标，如下表所示。

| 指标ID                                       | 指标名称                                | 指标含义                                                     | 取值范围           | 监控周期（原始指标） |
| -------------------------------------------- | --------------------------------------- | ------------------------------------------------------------ | ------------------ | -------------------- |
| `rds001_cpu_util`                            | CPU使用率                               | 该指标用于统计测量对象的CPU使用率，以比率为单位。            | 0-100%             | 1分钟          |
| `rds002_mem_util`                            | 内存使用率                              | 该指标用于统计测量对象的内存利用率。           | 0～100%            | 1分钟          |
| `rds003_iops`                                | IOPS                                    | 该指标用于统计当前实例，单位时间内系统处理的I/O请求数量（平均值）。 | ≥ 0 counts/s   | 1分钟          |
| `rds004_bytes_in`                            | 网络输入吞吐量                          | 该指标用于统计平均每秒从测量对象的所有网络适配器输入的流量，以字节/秒为单位。 | ≥ 0 bytes/s        | 1分钟                |
| `rds005_bytes_out`                           | 网络输出吞吐量                          | 该指标用于统计平均每秒从测量对象的所有网络适配器输出的流量，以字节/秒为单位。 | ≥ 0 bytes/s        | 1分钟                |
| `rds006_conn_count`                           | 数据库总连接数                          | 该指标用于统计试图连接到MariaDB服务器的总连接数，以个为单位。 | ≥ 0 counts        | 1分钟                |
| `rds007_conn_active_count`                           | 当前活跃连接数                          | 该指标用于统计当前打开的连接的数量，以个为单位。       | ≥ 0 counts        | 1分钟                |
| `rds008_qps`                           | QPS                          | 该指标用于统计SQL语句查询次数，含存储过程，以次/秒为单位。                    | ≥ 0 queries/s        | 1分钟                |
| `rds009_tps`                           | TPS                          | 该指标用于统计事务执行次数，含提交的和回退的，以次/秒为单位。 | ≥ 0 transactions/s        | 1分钟                |
| `rds010_innodb_buf_usage`                     | 缓冲池利用率                          | 该指标用于统计空闲的页与InnoDB缓存中缓冲池页面总数的比例，以比率为单位。 | 0-1        | 1分钟                |
| `rds011_innodb_buf_hit`                        | 缓冲池命中率                          | 该指标用于统计读命中与读请求数比例，以比率为单位。 |  0-1        | 1分钟                |
| `rds012_innodb_buf_dirty`                        | 缓冲池脏块率                          | 该指标用于统计InnoDB缓存中脏数据与InnoDB缓存中使用的页比例，以比率为单位。 |  0-1        | 1分钟                |
| `rds013_innodb_reads`                        | InnoDB读取吞吐量                          | 该指标用于统计Innodb平均每秒读字节数，以字节/秒为单位。 |  ≥ 0 bytes/s        | 1分钟                |
| `rds014_innodb_writes`                        | InnoDB写入吞吐量                          | 该指标用于统计Innodb平均每秒写字节数，以字节/秒为单位。 |  ≥ 0 bytes/s        | 1分钟                |
| `rds015_innodb_read_count`                        | InnoDB文件读取频率                        | 该指标用于统计Innodb平均每秒从文件中读的次数，以次/秒为单位。 |  ≥ 0 counts/s       | 1分钟                |
| `rds016_innodb_write_count`                        | InnoDB文件写入频率                       | 该指标用于统计Innodb平均每秒向文件中写的次数，以次/秒为单位。 |  ≥ 0 counts/s       | 1分钟                |
| `rds017_innodb_log_write_req_count`               | InnoDB日志写请求频率                      | 该指标用于统计平均每秒的日志写请求数，以次/秒为单位。 |  ≥ 0 counts/s               | 1分钟                |
| `rds018_innodb_log_write_count`                        | InnoDB日志物理写频率                          | 该指标用于统计平均每秒向日志文件的物理写次数，以次/秒为单位。 |  ≥ 0 counts/s        | 1分钟                |
| `rds019_innodb_log_fsync_count`                        | InnoDB日志fsync()写频率                          | 日志fsync()写频率该指标用于统计平均每秒向日志文件完成的fsync()写数量，以次/秒为单位。 |  0-1        | 1分钟                |
| `rds020_temp_tbl_rate`                        | 临时表创建速率                         | 该指标用于统计每秒在硬盘上创建的临时表数量，以个/秒为单位。 |  ≥ 0 counts/s       | 1分钟                |
| `rds021_myisam_buf_usage`                        | Key Buffer利用率                          | 该指标用于统计MyISAM Key buffer的利用率，以比率为单位。 |  0-1        | 1分钟                |
| `rds022_myisam_buf_write_hit`                        | Key Buffer写命中率                          | 该指标用于统计MyISAM Key buffer写命中率，以比率为单位。 |  0-1        | 1分钟                |
| `rds023_myisam_buf_read_hit`                        | Key Buffer读命中率                          | 该指标用于统计MyISAM Key buffer读命中率，以比率为单位。 |  0-1        | 1分钟                |
| `rds024_myisam_disk_write_count`                        | MyISAM硬盘写入频率                          | 该指标用于统计向磁盘写入索引的次数，以次/秒为单位。 |  ≥ 0 counts/s       | 1分钟                |
| `rds025_myisam_disk_read_count`                        | MyISAM硬盘读取频率                         | 该指标用于统计从磁盘读取索引的次数，以次/秒为单位。 |  ≥ 0 counts/s        | 1分钟                |
| `rds026_myisam_buf_write_count`                        | MyISAM缓冲池写入频率                         | 该指标用于统计向缓冲池写入索引的请求次数，以次/秒为单位。 |  ≥ 0 counts/s        | 1分钟                |
| `rds027_myisam_buf_read_count`                        | MyISAM缓冲池读取频率                         | 该指标用于统计从缓冲池读取索引的请求次数，以次/秒为单位。 |  ≥ 0 counts/s        | 1分钟                |
| `rds028_comdml_del_count`                        | Delete语句执行频率                         | 该指标用于统计平均每秒Delete语句执行次数，以次/秒为单位。 |  ≥ 0 queries/s        | 1分钟                |
| `rds029_comdml_ins_count`                        | Insert语句执行频率                         | 该指标用于统计平均每秒Insert语句执行次数，以次/秒为单位。 |  ≥ 0 queries/s        | 1分钟                |
| `rds030_comdml_ins_sel_count`                        | Insert_Select语句执行频率          | 该指标用于统计平均每秒Insert_Select语句执行次数，以次/秒为单位。 |  ≥ 0 queries/s        | 1分钟                |
| `rds031_comdml_rep_count`                        | Replace语句执行频率                    | 该指标用于统计平均每秒Replace语句执行次数，以次/秒为单位。 | ≥ 0 queries/s        | 1分钟                |
| `rds032_comdml_rep_sel_count`                        | Replace_Selection语句执行频率      | 该指标用于统计平均每秒Replace_Selection语句执行次数，以次/秒为单位。 |  ≥ 0 queries/s        | 1分钟         |
| `rds033_comdml_sel_count`                        | Select语句执行频率             | 该指标用于统计平均每秒Select语句执行次数。 |  ≥ 0 queries/s        | 1分钟                |
| `rds034_comdml_upd_count`                        | Update语句执行频率              | 该指标用于统计平均每秒Update语句执行次数，以次/秒为单位。 |  ≥ 0 queries/s        | 1分钟                |
| `rds035_innodb_del_row_count`                        | 行删除速率                  | 该指标用于统计平均每秒从InnoDB表删除的行数，以行/秒为单位。 |  ≥ 0 rows/s      | 1分钟                |
| `rds036_innodb_ins_row_count`                        | 行插入速率                   | 该指标用于统计平均每秒向InnoDB表插入的行数，以行/秒为单位 | ≥ 0 rows/s        | 1分钟                |
| `rds037_innodb_read_row_count`                        | 行读取速率                   | 该指标用于统计平均每秒从InnoDB表读取的行数，以行/秒为单位。 |  ≥ 0 rows/s        | 1分钟                |
| `rds038_innodb_upd_row_count`                        | 行更新速率                   | 该指标用于统计平均每秒向InnoDB表更新的行数，以行/秒为单位。 |  ≥ 0 rows/s        | 1分钟                |
| `rds037_innodb_read_row_count`                        | 行读取速率                  | 该指标用于统计平均每秒从InnoDB表读取的行数，以行/秒为单位。 |  ≥ 0 queries/s        | 1分钟                       |
| `rds039_disk_util`                        | 磁盘利用率                              | 该指标用于统计测量对象的磁盘利用率，以比率为单位。 |  0-100%        | 1分钟                |
| `rds047_disk_total_size`                      | 磁盘总大小                          | 该指标用于统计测量对象的磁盘总大小。 |  40GB~4000GB        | 1分钟                |
| `rds048_disk_used_size`                        | 磁盘使用量                          | 该指标用于统计测量对象的磁盘使用大小。 |  0GB~4000GB        | 1分钟                |
| `rds049_disk_read_throughput`                        | 硬盘读吞吐量                   | 该指标用于统计每秒从硬盘读取的字节数。 |  ≥ 0 bytes/s        | 1分钟                |
| `rds050_disk_write_throughput`                        | 硬盘写吞吐量                  | 该指标用于统计每秒写入硬盘的字节数。 |  ≥ 0 bytes/s        | 1分钟                |
| `rds072_conn_usage`                        | 连接数使用率                             | 该指标用于统计平均每秒从InnoDB表读取的行数，以行/秒为单位。 |  0-100%       | 1分钟                |
| `rds073_replication_delay`                        | 实时复制时延                      | 该指标为备库或只读与主库的实时延迟，对应seconds_behind_master。该值为实时值。 |  ≥ 0 s        | 1分钟                |
| `rds074_slow_queries`                        | 慢日志个数统计                          | 该指标用于展示每分钟MariaDB产生慢日志的数量。 |  ≥ 0        | 1分钟                |
| `rds075_avg_disk_ms_per_read`                        | 硬盘读耗时                      | 该指标用于统计某段时间平均每次读取磁盘所耗时间。 |  ≥ 0 ms       | 1分钟                |
| `rds076_avg_disk_ms_per_write`                        | 硬盘写耗时                     | 该指标用于统计某段时间平均写入磁盘所耗时间。 |  ≥ 0 ms        | 1分钟                |
| `rds077_vma`                        | VMA数量                                         | 该指标用于监控RDS进程的虚拟内存区域大小 |  ≥ 0 counts        | 1分钟                |
| `rds078_threads`                        | 进程中线程数量                                | 监控RDS进程中的线程数量，以个为单位 |  ≥ 0 counts        | 1分钟                |
| `rds079_vm_hwm`                        | 进程的物理内存占用峰值                          | 监控RDS进程的物理内存占用峰值，以KB为单位。 |  ≥ 0 KB        | 1分钟                |
| `rds080_vm_peak`                        | 进程的虚拟内存占用峰值                          | 监控RDS进程的虚拟内存占用峰值，以KB为单位。 |  ≥ 0 KB       | 1分钟                |
| `rds082_semi_sync_tx_avg_wait_time`                        | 事务平均等待时间            | 监控半同步复制模式下平均等待时间，以微秒为单位。 | ≥ 0 μs        | 1分钟                |
| `rds173_replication_delay_avg`                        | 平均复制时延                     | 该指标为备库或只读与主库的平均延迟，对应seconds_behind_master |  ≥ 0 s        | 1分钟                |
| `rds_buffer_pool_wait_free`                        | 缓冲池空闲页等待次数                 | 该指标用于统计InnoDB缓冲池空闲页等待次数。 |  ≥ 0 ms        | 1分钟                |
| `rds_bytes_recv_rate`                        | 数据库每秒接受字节                         | 该指标用于统计数据库每秒接收字节，以字节/秒为单位。 |  ≥ 0 bytes/s        | 1分钟                |
| `rds_bytes_sent_rate`                        | 数据库每秒发送字节                         | 该指标用于统计数据库每条发送字节，以字节/秒为单位。 |  ≥ 0 bytes/s        | 1分钟                |
| `rds_conn_active_usage`                        | 活跃连接数使用率                         | 该指标统计活跃连接数占最大连接数的比率，以比率为单位。 |  0-100%        | 1分钟                |
| `rds_created_tmp_tables_rate`                        | 每秒创建临时表数                         | 该指标用于统计每秒创建临时表数，以个/秒为单位。 | ≥ 0 counts/s        | 1分钟                |
| `rds_innodb_buffer_pool_pages_flushed_rate`                        | innodb_buffer_pool每秒页面刷新数                         | 该指标用于统计innodb_buffer_pool每秒页面刷新数，以次/秒为单位。 |  ≥ 0 counts/s        | 1分钟                |
| `rds_innodb_buffer_pool_read_requests_rate`                        | innodb_buffer_pool每秒读请求次数                         | 该指标用于统计innodb_buffer_pool每秒读请求次数，以次/秒为单位。 |  ≥ 0 counts/s        | 1分钟                |
| `rds_innodb_buffer_pool_write_requests_rate`                        | innodb_buffer_pool每秒写请求次数                         | 该指标用于统计innodb_buffer_pool每秒写请求次数，以次/秒为单位。 |  ≥ 0 counts/s        | 1分钟                |
| `rds_innodb_lock_waits`                        | 等待行锁事务数                         | 该指标用于统计当前等待行锁的Innodb事务数，以个为单位。 |  ≥ 0 counts        | 1分钟                |
| `rds_innodb_log_waits_count`                        | 日志等待次数                         | 该指标用于统计日志等待次数，以个为单位。 | ≥ 0 counts       | 1分钟                |
| `rds_innodb_log_waits_rate`                        | 因log buffer不足导致等待flush到磁盘次数                         | 该指标用于统计因log buffer不足导致等待flush到磁盘次数，以次/秒为单位。 | ≥ 0 counts       | 1分钟                |
| `rds_innodb_os_log_written_rate`                        | 平均每秒写入redo log的大小                         | 该指标用于统计平均每秒写入redo log的大小，以字节/秒为单位。 | ≥ 0 bytes/s       | 1分钟                |
| `rds_innodb_pages_read_rate`                        | innodb平均每秒读取的数据量                         | 该指标用于统计innodb平均每秒读取的数据量，以页/秒为单位。 | ≥ 0 Pages/s      | 1分钟                |
| `rds_innodb_pages_written_rate`                        | innodb平均每秒写入的数据量                        | 该指标用于统计innodb平均每秒写入的数据量，以页/秒为单位。 | ≥ 0 Pages/s       | 1分钟                |
| `rds_innodb_row_lock_current_waits`                        | 当前行锁等待数                         | 该指标用于统计innodb当前行锁等待数，以个为单位。 | ≥ 0 counts       | 1分钟                |
| `rds_innodb_row_lock_time_avg`                        | 行锁平均等待时间                         | 该指标用于统计行锁平均等待时间，以毫秒为单位。| ≥ 0 ms       | 1分钟                |
| `rds_wait_thread_count`                        | 等待线程数                         | 该指标用于统计等待线程数量，以个为单位。 | ≥ 0 counts       | 1分钟                |

## 对象 {#object}

采集到的华为云 RDS MariaDB 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

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
    "created_time"      : "2024-11-12T06:31:07+0000",
    "updated_time"      : "2024-11-12T07:45:54+0000",
    "private_ips"       : "[\"192.x.x.35\"]",
    "public_ips"        : "[]",
    "datastore"         : "{实例 JSON 数据}",
    "cpu"               : "4",
    "mem"               : "8",
    "volume"            : "{volume 信息}",
    "nodes"             : "[{主备实例信息}]",
    "related_instance"  : "[]",
    "backup_strategy"   : "{备份策略}"
  }
}
```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
>
> 提示 2：以下字段均为 JSON 序列化后字符串
>
> - `fields.private_ips`
> - `fields.public_ips`
> - `fields.volume`
> - `fields.nodes`
> - `fields.related_instance`
> - `fields.backup_strategy`
>
> 提示 3：`type`取值为“Single”，“Ha”或“Replica”, "Enterprise"，分别对应于单机实例、主备实例、只读实例、分布式实例（企业版）。
