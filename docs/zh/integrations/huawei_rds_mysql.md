---
title: '华为云 RDS MYSQL'
tags: 
  - 华为云
summary: '使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云'
__int_icon: 'icon/huawei_rds_mysql'
dashboard:

  - desc: '华为云 RDS MYSQL 内置视图'
    path: 'dashboard/zh/huawei_rds_mysql'

monitor:
  - desc: '华为云 RDS MYSQL 监控器'
    path: 'monitor/zh/huawei_rds_mysql'

---


<!-- markdownlint-disable MD025 -->
# 华为云 RDS MYSQL
<!-- markdownlint-enable -->

使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步华为云 RDS MYSQL 的监控数据，我们安装对应的采集脚本：「观测云集成（华为云-RDS采集）」(ID：`guance_huaweicloud_rds`)

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

脚本安装完后，在 Func 中「开发」里找到脚本「观测云集成（华为云-RDS采集）」，展开修改此脚本，找到 collector_configs 和monitor_configs 分别编辑下面region_projects中的内容，将地域和 Project ID,更改为实际的地域和 Project ID，再点击保存发布。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-huaweicloud-ces/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好华为云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [华为云云监控指标详情](https://support.huaweicloud.com/usermanual-rds/rds_06_0001.html){:target="_blank"}

### 实例监控指标

RDS for MySQL实例性能监控指标，如下表所示。

| 指标ID                                       | 指标名称                                | 指标含义                                                     | 取值范围           | 监控周期（原始指标） |
| -------------------------------------------- | --------------------------------------- | ------------------------------------------------------------ | ------------------ | -------------------- |
| `rds001_cpu_util`                            | CPU使用率                               | 该指标用于统计测量对象的CPU使用率，以比率为单位。            | 0-100%             | 1分钟5秒1秒          |
| `rds002_mem_util`                            | 内存使用率                              | 该指标用于统计测量对象的内存使用率，以比率为单位。           | 0-100%             | 1分钟5秒1秒          |
| `rds003_iops`                                | IOPS                                    | 该指标用于统计当前实例，单位时间内系统处理的I/O请求数量（平均值）。 | ≥ 0 counts/s       | 1分钟                |
| `rds004_bytes_in`                            | 网络输入吞吐量                          | 该指标用于统计平均每秒从测量对象的所有网络适配器输入的流量，以字节/秒为单位。 | ≥ 0 bytes/s        | 1分钟                |
| `rds005_bytes_out`                           | 网络输出吞吐量                          | 该指标用于统计平均每秒从测量对象的所有网络适配器输出的流量，以字节/秒为单位。 | ≥ 0 bytes/s        | 1分钟                |
| `rds006_conn_count`                          | 数据库总连接数                          | 该指标用于统计试图连接到MySQL服务器的总连接数，以个为单位。  | ≥ 0 counts         | 1分钟5秒1秒          |
| `rds007_conn_active_count`                   | 当前活跃连接数                          | 该指标用于统计当前打开的连接的数量，以个为单位。             | ≥ 0 counts         | 1分钟5秒1秒          |
| `rds008_qps`                                 | QPS                                     | 该指标用于统计SQL语句查询次数，含存储过程，以次/秒为单位。   | ≥ 0 queries/s      | 1分钟5秒1秒          |
| `rds009_tps`                                 | TPS                                     | 该指标用于统计事务执行次数，含提交的和回退的，以次/秒为单位。 | ≥ 0 transactions/s | 1分钟5秒1秒          |
| `rds010_innodb_buf_usage`                    | 缓冲池利用率                            | 该指标用于统计空闲的页与**InnoDB**缓存中缓冲池页面总数的比例，以比率为单位。 | 0-1                | 1分钟                |
| `rds011_innodb_buf_hit`                      | 缓冲池命中率                            | 该指标用于统计读命中与读请求数比例，以比率为单位。           | 0-1                | 1分钟                |
| `rds012_innodb_buf_dirty`                    | 缓冲池脏块率                            | 该指标用于统计**InnoDB**缓存中脏数据与**InnoDB**缓存中使用的页比例，以比率为单位。 | 0-1                | 1分钟                |
| `rds013_innodb_reads`                        | **InnoDB**读取吞吐量                    | 该指标用于统计**Innodb**平均每秒读字节数，以字节/秒为单位。  | ≥ 0 bytes/s        | 1分钟                |
| `rds014_innodb_writes`                       | **InnoDB**写入吞吐量                    | 该指标用于统计**Innodb**平均每秒写字节数，以字节/秒为单位。  | ≥ 0 bytes/s        | 1分钟                |
| `rds015_innodb_read_count`                   | **InnoDB**文件读取频率                  | 该指标用于统计**Innodb**平均每秒从文件中读的次数，以次/秒为单位。 | ≥ 0 counts/s       | 1分钟                |
| `rds016_innodb_write_count`                  | **InnoDB**文件写入频率                  | 该指标用于统计**Innodb**平均每秒向文件中写的次数，以次/秒为单位。 | ≥ 0 counts/s       | 1分钟                |
| `rds017_innodb_log_write_req_count`          | **InnoDB**日志写请求频率                | 该指标用于统计平均每秒的日志写请求数，以次/秒为单位。        | ≥ 0 counts/s       | 1分钟                |
| `rds018_innodb_log_write_count`              | **InnoDB**日志物理写频率                | 该指标用于统计平均每秒向日志文件的物理写次数，以次/秒为单位。 | ≥ 0 counts/s       | 1分钟                |
| `rds019_innodb_log_fsync_count`              | **InnoDB**日志fsync()写频率             | 该指标用于统计平均每秒向日志文件完成的fsync()写数量，以次/秒为单位。 | ≥ 0 counts/s       | 1分钟                |
| `rds020_temp_tbl_rate`                       | 临时表创建速率                          | 该指标用于统计每秒在硬盘上创建的临时表数量，以个/秒为单位。  | ≥ 0 counts/s       | 1分钟                |
| `rds021_myisam_buf_usage`                    | Key Buffer利用率                        | 该指标用于统计MyISAM Key buffer的利用率，以比率为单位。      | 0-1                | 1分钟                |
| `rds022_myisam_buf_write_hit`                | Key Buffer写命中率                      | 该指标用于统计MyISAM Key buffer写命中率，以比率为单位。      | 0-1                | 1分钟                |
| `rds023_myisam_buf_read_hit`                 | Key Buffer读命中率                      | 该指标用于统计MyISAM Key buffer读命中率，以比率为单位。      | 0-1                | 1分钟                |
| `rds024_myisam_disk_write_count`             | MyISAM硬盘写入频率                      | 该指标用于统计向磁盘写入索引的次数，以次/秒为单位。          | ≥ 0 counts/s       | 1分钟                |
| `rds025_myisam_disk_read_count`              | MyISAM硬盘读取频率                      | 该指标用于统计从磁盘读取索引的次数，以次/秒为单位。          | ≥ 0 counts/s       | 1分钟                |
| `rds026_myisam_buf_write_count`              | MyISAM缓冲池写入频率                    | 该指标用于统计向缓冲池写入索引的请求次数，以次/秒为单位。    | ≥ 0 counts/s       | 1分钟                |
| `rds027_myisam_buf_read_count`               | MyISAM缓冲池读取频率                    | 该指标用于统计从缓冲池读取索引的请求次数，以次/秒为单位。    | ≥ 0 counts/s       | 1分钟                |
| `rds028_comdml_del_count`                    | Delete语句执行频率                      | 该指标用于统计平均每秒Delete语句执行次数，以次/秒为单位。    | ≥ 0 queries/s      | 1分钟5秒1秒          |
| `rds029_comdml_ins_count`                    | Insert语句执行频率                      | 该指标用于统计平均每秒Insert语句执行次数，以次/秒为单位。    | ≥ 0 queries/s      | 1分钟5秒1秒          |
| `rds030_comdml_ins_sel_count`                | Insert_Select语句执行频率               | 该指标用于统计平均每秒Insert_Select语句执行次数，以次/秒为单位。 | ≥ 0 queries/s      | 1分钟                |
| `rds031_comdml_rep_count`                    | Replace语句执行频率                     | 该指标用于统计平均每秒Replace语句执行次数，以次/秒为单位。   | ≥ 0 queries/s      | 1分钟                |
| `rds032_comdml_rep_sel_count`                | Replace_Selection语句执行频率           | 该指标用于统计平均每秒Replace_Selection语句执行次数，以次/秒为单位。 | ≥ 0 queries/s      | 1分钟                |
| `rds033_comdml_sel_count`                    | Select语句执行频率                      | 该指标用于统计平均每秒Select语句执行次数。                   | ≥ 0 queries/s      | 1分钟5秒1秒          |
| `rds034_comdml_upd_count`                    | Update语句执行频率                      | 该指标用于统计平均每秒Update语句执行次数，以次/秒为单位。    | ≥ 0 queries/s      | 1分钟5秒1秒          |
| `rds035_innodb_del_row_count`                | 行删除速率                              | 该指标用于统计平均每秒从**InnoDB**表删除的行数，以行/秒为单位。 | ≥ 0 rows/s         | 1分钟                |
| `rds036_innodb_ins_row_count`                | 行插入速率                              | 该指标用于统计平均每秒向**InnoDB**表插入的行数，以行/秒为单位。 | ≥ 0 rows/s         | 1分钟                |
| `rds037_innodb_read_row_count`               | 行读取速率                              | 该指标用于统计平均每秒从**InnoDB**表读取的行数，以行/秒为单位。 | ≥ 0 rows/s         | 1分钟                |
| `rds038_innodb_upd_row_count`                | 行更新速率                              | 该指标用于统计平均每秒向**InnoDB**表更新的行数，以行/秒为单位。 | ≥ 0 rows/s         | 1分钟                |
| `rds039_disk_util`                           | 磁盘利用率                              | 该指标用于统计测量对象的磁盘利用率，以比率为单位。           | 0-100%             | 1分钟                |
| `rds047_disk_total_size`                     | 磁盘总大小                              | 该指标用于统计测量对象的磁盘总大小。                         | 40GB~4000GB        | 1分钟                |
| `rds048_disk_used_size`                      | 磁盘使用量                              | 该指标用于统计测量对象的磁盘使用大小。                       | 0GB~4000GB         | 1分钟                |
| `rds049_disk_read_throughput`                | 硬盘读吞吐量                            | 该指标用于统计每秒从硬盘读取的字节数。                       | ≥ 0 bytes/s        | 1分钟                |
| `rds050_disk_write_throughput`               | 硬盘写吞吐量                            | 该指标用于统计每秒写入硬盘的字节数。                         | ≥ 0 bytes/s        | 1分钟                |
| `rds072_conn_usage`                          | 连接数使用率                            | 该指标用于统计当前已用的MySQL连接数占总连接数的百分比。      | 0-100%             | 1分钟                |
| `rds173_replication_delay_avg`               | 平均复制时延                            | 该指标为备库或只读与主库的平均延迟，对应seconds_behind_master。取60秒时间段的平均值。 | ≥ 0s               | 10秒                 |
| `rds073_replication_delay`                   | 实时复制时延                            | 该指标为备库或只读与主库的实时延迟，对应seconds_behind_master。该值为实时值。 | ≥ 0s               | 1分钟5秒             |
| `rds074_slow_queries`                        | 慢日志个数统计                          | 该指标用于展示每分钟MySQL产生慢日志的数量。                  | ≥ 0                | 1分钟                |
| `rds075_avg_disk_ms_per_read`                | 硬盘读耗时                              | 该指标用于统计某段时间平均每次读取磁盘所耗时间。             | ≥ 0ms              | 1分钟                |
| `rds076_avg_disk_ms_per_write`               | 硬盘写耗时                              | 该指标用于统计某段时间平均写入磁盘所耗时间。                 | ≥ 0ms              | 1分钟                |
| `rds077_vma`                                 | VMA数量                                 | 监控RDS进程的虚拟内存区域大小，以个为单位。                  | ≥ 0counts          | 1分钟                |
| `rds078_threads`                             | 进程中线程数量                          | 监控RDS进程中的线程数量，以个为单位。                        | ≥ 0counts          | 1分钟                |
| `rds079_vm_hwm`                              | 进程的物理内存占用峰值                  | 监控RDS进程的物理内存占用峰值，以KB为单位。                  | ≥ 0 KB             | 1分钟                |
| `rds080_vm_peak`                             | 进程的虚拟内存占用峰值                  | 监控RDS进程的虚拟内存占用峰值，以KB为单位。                  | ≥ 0 KB             | 1分钟                |
| `rds081_vm_ioutils`                          | 磁盘I/O使用率                           | 磁盘I/O使用率，以比率为单位。                                | 0-1                | 1分钟                |
| `rds082_semi_sync_tx_avg_wait_time`          | 事务平均等待时间                        | 监控半同步复制模式下平均等待时间，以微秒为单位。             | ≥ 0微秒            | 1分钟                |
| `sys_swap_usage`                             | swap利用率                              | 该指标用于统计测量对象的swap利用率，以比率为单位。           | 0-100%             | 1分钟                |
| `rds_innodb_lock_waits`                      | 行锁等待个数                            | 该指标用于统计**Innodb**行锁等待个数，以个为单位。表示历史累积等待行锁的事务个数。重启会清空锁等待。 | ≥ 0 counts         | 1分钟                |
| `rds_bytes_recv_rate`                        | 数据库每秒接收字节                      | 该指标用于统计数据库每秒接收字节，以字节/秒为单位。          | ≥ 0 bytes/s        | 1分钟                |
| `rds_bytes_sent_rate`                        | 数据库每秒发送字节                      | 该指标用于统计数据库每条发送字节，以字节/秒为单位。          | ≥ 0 bytes/s        | 1分钟                |
| `rds_innodb_pages_read_rate`                 | **Innodb**平均每秒读取的数据量          | 该指标用于统计**Innodb**平均每秒读取的数据量，以页/秒为单位。 | ≥ 0 Pages/s        | 1分钟                |
| `rds_innodb_pages_written_rate`              | **Innodb**平均每秒写入的数据量          | 该指标用于统计**Innodb**平均每秒写入的数据量，以页/秒为单位。 | ≥ 0 Pages/s        | 1分钟                |
| `rds_innodb_os_log_written_rate`             | 平均每秒写入redo log的大小              | 该指标用于统计平均每秒写入redo log的大小，以字节/秒为单位。  | ≥ 0 bytes/s        | 1分钟                |
| `rds_innodb_buffer_pool_read_requests_rate`  | innodb_buffer_pool每秒读请求次数        | 该指标用于统计innodb_buffer_pool每秒读请求次数，以次/秒为单位。 | ≥ 0 counts/s       | 1分钟                |
| `rds_innodb_buffer_pool_write_requests_rate` | innodb_buffer_pool每秒写请求次数        | 该指标用于统计innodb_buffer_pool每秒写请求次数，以次/秒为单位。 | ≥ 0 counts/s       | 1分钟                |
| `rds_innodb_buffer_pool_pages_flushed_rate`  | innodb_buffer_pool每秒页面刷新数        | 该指标用于统计innodb_buffer_pool每秒页面刷新数，以次/秒为单位。 | ≥ 0 counts/s       | 1分钟                |
| `rds_innodb_log_waits_rate`                  | 因log buffer不足导致等待flush到磁盘次数 | 该指标用于统计因log buffer不足导致等待flush到磁盘次数，以次/秒为单位。 | ≥ 0 counts/s       | 1分钟                |
| `rds_created_tmp_tables_rate`                | 每秒创建临时表数                        | 该指标用于统计每秒创建临时表数，以个/秒为单位。              | ≥ 0 counts/s       | 1分钟                |
| `rds_wait_thread_count`                      | 等待线程数                              | 该指标用于统计等待线程数，以个为单位。                       | ≥ 0 counts         | 1分钟                |
| `rds_innodb_row_lock_time_avg`               | 历史行锁平均等待时间                    | 该指标用于统计**innodb**历史行锁平均等待时间。               | > 0ms              | 1分钟                |
| `rds_innodb_row_lock_current_waits`          | 当前行锁等待数                          | 该指标用于统计**innodb**当前行锁等待数，以个为单位。表示当前正在等待行锁的事务个数。 | ≥ 0 counts         | 1分钟                |
| `rds_mdl_lock_count`                         | MDL锁数量                               | 该指标用于统计MDL锁数量，以个为单位。                        | ≥ 0counts          | 1分钟                |
| `rds_buffer_pool_wait_free`                  | 等待落盘的脏页数量                      | 该指标统计等待落盘的脏页数量，以个为单位。                   | ≥ 0counts          | 1分钟                |
| `rds_conn_active_usage`                      | 活跃连接数使用率                        | 该指标统计活跃连接数占最大连接数的比率，以比率为单位。       | 0-100%             | 1分钟                |
| `rds_innodb_log_waits_count`                 | 日志等待次数                            | 该指标用于统计日志等待次数，以个为单位。                     | ≥ 0counts          | 1分钟                |
| `rds_long_transaction`                       | 长事务指标                              | 该指标统计长事务耗时数据，以秒为单位。相关操作命令前后分别有**BEGIN**以及**COMMIT**命令才算作一个完整的长事务。 | ≥ 0seconds         | 1分钟                |

RDS for MySQL数据库代理监控指标，如[表2](https://support.huaweicloud.com/usermanual-rds/rds_06_0001.html#rds_06_0001__table1377262611585){:target="_blank"}所示。

| 指标ID                                 | 指标名称               | 指标含义                                                     | 取值范围     | 监控周期（原始指标） |
| -------------------------------------- | ---------------------- | ------------------------------------------------------------ | ------------ | -------------------- |
| rds001_cpu_util                        | CPU使用率              | 该指标用于统计测量对象的CPU使用率，以比率为单位。            | 0-100%       | 1分钟5秒1秒          |
| rds002_mem_util                        | 内存使用率             | 该指标用于统计测量对象的内存使用率，以比率为单位。           | 0-100%       | 1分钟5秒1秒          |
| rds004_bytes_in                        | 网络输入吞吐量         | 该指标用于统计平均每秒从测量对象的所有网络适配器输入的流量，以字节/秒为单位。 | ≥ 0 bytes/s  | 1分钟                |
| rds005_bytes_out                       | 网络输出吞吐量         | 该指标用于统计平均每秒从测量对象的所有网络适配器输出的流量，以字节/秒为单位。 | ≥ 0 bytes/s  | 1分钟                |
| rds_proxy_frontend_connections         | 前端连接数             | 应用与Proxy之间的连接数。                                    | ≥ 0 counts   | 1分钟                |
| rds_proxy_backend_connections          | 后端连接数             | Proxy和RDS数据库之间的连接数。                               | ≥ 0 counts   | 1分钟                |
| rds_proxy_average_response_time        | 平均响应时间           | 平均响应时间。                                               | ≥ 0 ms       | 1分钟                |
| rds_proxy_query_per_seconds            | QPS                    | SQL语句查询次数。                                            | ≥ 0 counts   | 1分钟                |
| rds_proxy_read_query_proportions       | 读占比                 | 读请求占总请求的比例。                                       | 0-100%       | 1分钟                |
| rds_proxy_write_query_proportions      | 写占比                 | 写占比占总请求的比例。                                       | 0-100%       | 1分钟                |
| rds_proxy_frontend_connection_creation | 每秒平均创建前端连接数 | 统计平均每秒客户应用程序针对数据库代理服务创建的前端连接数。 | ≥ 0 counts/s | 1分钟                |
| rds_proxy_transaction_query            | 每秒平均事务中的查询数 | 统计平均每秒执行的事务中包含select的执行数                   | ≥ 0 counts/s | 1分钟                |
| rds_proxy_multi_statement_query        | 每秒平均多语句执行数   | 统计平均每秒Multi-Statements语句的执行数                     | ≥ 0 counts/s | 1分钟                |

### 维度

| Key                   | Value                     |
| --------------------- | ------------------------- |
| `rds_cluster_id`     | RDS for MySQL实例ID |
| `dbproxy_instance_id` | RDS for MySQL Proxy实例ID |
| `dbproxy_node_id`     | RDS for MySQL Proxy节点ID |

## 对象 {#object}

采集到的华为云 RDS MYSQL 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

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

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
>
> 提示 2：以下字段均为 JSON 序列化后字符串
>
> - `fields.message`
> - `fields.private_ips`
> - `fields.public_ips`
> - `fields.volume`
> - `fields.nodes`
> - `fields.related_instance`
> - `fields.backup_strategy`
>
> 提示 3：`type`取值为“Single”，“Ha”或“Replica”, "Enterprise"，分别对应于单机实例、主备实例、只读实例、分布式实例（企业版）。
