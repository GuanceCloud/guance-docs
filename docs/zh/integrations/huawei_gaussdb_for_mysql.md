---
title: '华为云 GaussDB for MySQL'
tags: 
  - 华为云
summary: 'GaussDB for MySQL，包括cpu、内存、网络、缓冲池、存储、慢日志、`innoDB`等相关指标。'
__int_icon: 'icon/huawei_gaussdb_for_mysql'
dashboard:

  - desc: 'GaussDB for MySQL 内置视图'
    path: 'dashboard/zh/huawei_gaussdb_for_mysql'

monitor:
  - desc: 'GaussDB for MySQL 监控器'
    path: 'monitor/zh/huawei_gaussdb_for_mysql'

---


<!-- markdownlint-disable MD025 -->
# 华为云 GaussDB for MySQL
<!-- markdownlint-enable -->

GaussDB for MySQL，包括cpu、内存、网络、缓冲池、存储、慢日志、`innoDB`等相关指标。


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 GaussDB for MySQL 的监控数据，我们安装对应的采集脚本：「观测云集成（华为云-Gaussdb-Mysql 采集）」(ID：`guance_huaweicloud_ddm_gaussdb_mysql`)

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-huaweicloud-gaussdb-mysql/){:target="_blank"}



### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好 GaussDB for MySQL ,默认的指标集如下, 可以通过配置的方式采集更多的指标 [华为云云监控指标详情](https://support.huaweicloud.com/usermanual-gaussdb/gaussdb_03_0085.html){:target="_blank"}

| 指标ID                                | 指标名称             | 指标含义                                                     | 取值范围      | 测量对象（维度） | **监控周期（原始指标）** |
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| `gaussdb_mysql001_cpu_util`                       | CPU使用率            | 该指标用于统计测量对象的CPU利用率。                       | 0～100%         | GaussDB(for MySQL)实例          | 1分钟5秒1秒                                           |
| `gaussdb_mysql002_mem_util`                            | 内存使用率         | 该指标用于统计测量对象的内存利用率。                                | 0~100%          | GaussDB(for MySQL)实例          | 1分钟5秒1秒                                             |
| `gaussdb_mysql004_bytes_in`                      | 网络输入吞吐量            | 该指标用于统计平均每秒从测量对象的所有网络适配器输入的流量。                       | ≥0 bytes/s           | GaussDB(for MySQL)实例          | 1分钟5秒1秒                                    |
| `gaussdb_mysql005_bytes_out`                            | 网络输出吞吐量                    | 该指标用于统计平均每秒从测量对象的所有网络适配器输出的流量。 | ≥0 bytes/s    | GaussDB(for MySQL)实例 | 1分钟5秒1秒              |
| `gaussdb_mysql006_conn_count`                       | 数据库总连接数                    | 该指标用于统计连接到GaussDB(for MySQL)服务器的总连接数。     | ≥0 counts     | GaussDB(for MySQL)实例 | 1分钟5秒1秒              |
| `gaussdb_mysql007_conn_active_count`                            | 当前活跃连接数                    | 该指标用于统计当前活跃的连接数。                             | ≥0 counts     | GaussDB(for MySQL)实例 | 1分钟5秒1秒              |
| `gaussdb_mysql010_innodb_buf_usage`                       | 缓冲池利用率                      | 该指标用于统计使用的页与InnoDB缓存中数据页总数比例。         | 0-1           | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql011_innodb_buf_hit`                            | 缓冲池命中率                      | 该指标用于统计该段时间读命中与读请求数比例。                 | 0-1           | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql012_innodb_buf_dirty`                       | 缓冲池脏块率                      | 该指标用于统计InnoDB缓存中脏数据与数据比例。                 | 0～100%       | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql013_innodb_reads`                            | InnoDB读取吞吐量                  | 该指标用于统计Innodb平均每秒读字节数。                       | ≥0 bytes/s    | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql014_innodb_writes`                       | InnoDB写入吞吐量                  | 该指标用于统计Innodb平均每秒写页面数据字节数。GaussDB(for MySQL)只写入临时表页面。 | ≥0 bytes/s    | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql017_innodb_log_write_req_count`                            | InnoDB日志写请求频率              | 该指标用于统计平均每秒的日志写请求数。                       | ≥0 counts     | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql020_temp_tbl_count`                       | 临时表数量                        | 该指标用于统计GaussDB(for MySQL)执行语句时在硬盘上自动创建的临时表的数量。 | ≥0 counts     | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql028_comdml_del_count`                            | Delete语句执行频率                | 该指标用于统计平均每秒Delete语句执行次数。                   | ≥0 counts/s   | GaussDB(for MySQL)实例 | 1分钟5秒1秒              |
| `gaussdb_mysql029_comdml_ins_count`                       | Insert语句执行频率                | 该指标用于统计平均每秒Insert语句执行次数。                   | ≥0 counts/s   | GaussDB(for MySQL)实例 | 1分钟5秒1秒              |
| `gaussdb_mysql030_comdml_ins_sel_count`                            | Insert_Select语句执行频率         | 该指标用于统计平均每秒Insert_Select语句执行次数。            | ≥0 counts/s   | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql031_comdml_rep_count`                       | Replace语句执行频率               | 该指标用于统计平均每秒Replace语句执行次数。                  | ≥0 counts/s   | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql032_comdml_rep_sel_count`                            | Replace_Selection语句执行频率     | 该指标用于统计平均每秒Replace_Selection语句执行次数。        | ≥0 counts/s   | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql033_comdml_sel_count`                       | Select语句执行频率                | 该指标用于统计平均每秒Select语句执行次数。                   | ≥0 counts/s   | GaussDB(for MySQL)实例 | 1分钟5秒1秒              |
| `gaussdb_mysql034_comdml_upd_count`                            | Update语句执行频率                | 该指标用于统计平均每秒Update语句执行次数。                   | ≥0 counts/s   | GaussDB(for MySQL)实例 | 1分钟5秒1秒              |
| `gaussdb_mysql035_innodb_del_row_count`                       | 行删除速率                        | 该指标用于统计平均每秒从InnoDB表删除的行数。                 | ≥0 counts/s   | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql036_innodb_ins_row_count`                            | 行插入速率                        | 该指标用于统计平均每秒向InnoDB表插入的行数。                 | ≥0 counts/s   | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql037_innodb_read_row_count`                       | 行读取速率                        | 该指标用于统计平均每秒从InnoDB表读取的行数。                 | ≥0 counts/s   | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql038_innodb_upd_row_count`                            | 行更新速率                        | 该指标用于统计平均每秒向InnoDB表更新的行数。                 | ≥0 counts/s   | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql048_disk_used_size`                       | 磁盘使用量                        | 该指标用于统计测量对象的磁盘使用大小。                       | 0GB～128TB    | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql072_conn_usage`                            | 连接数使用率                      | 该指标用于统计当前已用的GaussDB(for MySQL)连接数占最大连接数的百分比。 | 0~100%        | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql074_slow_queries`                       | 慢日志个数统计                    | 该指标展示每分钟GaussDB(for MySQL)产生慢日志的数量。         | ≥0 counts/min | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql104_dfv_write_delay`                            | 存储写时延                        | 该指标用于统计某段时间写入数据到存储层的平均时延。           | ≥0 ms         | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql105_dfv_read_delay`                       | 存储读时延                        | 该指标用于统计某段时间从存储层读取数据的平均时延。           | ≥0 ms         | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql106_innodb_row_lock_current_waits`                            | InnoDB行锁数量                    | 该指标用于采集InnoDB表上的操作当前正在等待的行锁数量。![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**说明：**如果存在导致阻塞的DDL语句、长事务或慢SQL，等待的行锁数可能会增加。 | ≥0 Locks/s    | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql107_comdml_ins_and_ins_sel_count`                       | Insert和Insert_Select语句执行频率 | 该指标用于统计平均每秒Insert和Insert_Select语句的执行次数。  | ≥0 counts/s   | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql108_com_commit_count`                            | Commit语句执行频率                | 该指标用于统计平均每秒Commit语句的执行次数。                 | ≥0 counts/s   | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql109_com_rollback_count`                       | Rollback语句执行频率              | 该指标用于统计平均每秒Rollback语句的执行次数。               | ≥0 counts/s   | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql110_innodb_bufpool_reads`                            | InnoDB存储层读请求频率            | 该指标用于统计平均每秒InnoDB从存储层读取数据的请求次数。     | ≥0 counts/s   | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql111_innodb_bufpool_read_requests`                       | InnoDB读请求频率                  | 该指标用于统计平均每秒InnoDB读取数据的请求次数。             | ≥0 counts/s   | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql119_disk_used_ratio`                            | 磁盘使用率                        | 该指标用于统计磁盘的使用率。                                 | 0~100%        | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql116_innodb_bufpool_read_ahead_rnd`                       | Innodb随机预读页数                | 该指标用于采集InnoDB表上的随机预读页数。                     | ≥0 counts     | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql117_innodb_pages_read`                            | Innodb读取物理page的数量          | 该指标用于采集InnoDB表上的读取物理page的数量。               | ≥0 counts     | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql118_innodb_pages_written`                       | Innodb写入物理page的数量          | 该指标用于采集InnoDB表上的写入物理page的数量。               | ≥0 counts     | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql342_iostat_iops_write`                            | IO写IOPS                          | 该指标用于采集磁盘每秒写次数。                               | ≥0 counts/s   | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql344_iostat_iops_read`                       | IO读IOPS                          | 该指标用于采集磁盘每秒读次数。                               | ≥0 counts/s   | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql346_iostat_throughput_write`                            | IO写带宽                          | 该指标用于采集磁盘每秒写带宽。                               | ≥0 bytes/s    | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql348_iostat_throughput_read`                       | IO读带宽                          | 该指标用于采集磁盘每秒读带宽。                               | ≥0 bytes/s    | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql123_sort_range`                            | 范围排序数                        | 该指标用于统计该段时间内使用范围扫描完成的排序数。           | ≥0 counts/min | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql121_innodb_row_lock_time`                       | 行锁花费时间                      | 该指标用于统计该段时间内InnoDB表上行锁花费时间。             | ≥0 ms         | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql122_innodb_row_lock_waits`                            | 行锁等待数                        | 该指标用于统计该段时间内InnoDB表上行锁数量。                 | ≥0 counts/min | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql126_table_open_cache_hits`                       | 打开表缓存查找的命中数            | 该指标用于统计该段时间内打开表缓存查找的命中数。             | ≥0 counts/min | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql124_sort_rows`                            | 行排序数                          | 该指标用于统计该段时间内已排序的行数。                       | ≥0 counts/min | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql125_sort_scan`                       | 扫描表排序数                      | 该指标用于统计该段时间内通过扫描表完成的排序数。             | ≥0 counts/min | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql060_rx_errors`                            | 接收报文错误率                    | 该指标用于统计监控周期内接收报文中错误报文数量与全部接收报文比值。 | 0~100%        | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql127_table_open_cache_misses`                       | 打开表缓存查找的未命中数          | 该指标用于统计该段时间内打开表缓存查找的未命中数。           | ≥0 counts/min | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql128_long_trx_count`                            | 未关闭的长事务个数                | 该指标用于统计未关闭的长事务个数。                           | ≥0 counts     | GaussDB(for MySQL)实例 | 150秒                    |
| `gaussdb_mysql063_tx_dropped`                       | 发送报文丢包率                    | 该指标用于监控周期内统计发送报文中丢失报文数量与全部发送报文比值。 | 0~100%        | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql061_rx_dropped`                            | 接收报文丢包率                    | 该指标用于监控周期内统计接收报文中丢失报文数量与全部接收报文比值。 | 0~100%        | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql062_tx_errors`                       | 发送报文错误率                    | 该指标用于监控周期内统计发送报文中错误报文数量与全部发送报文比值。 | 0~100%        | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql114_innodb_bufpool_read_ahead`                            | Innodb顺序预读页数                | 该指标用于采集InnoDB表上的顺序预读页数。                     | ≥0 counts     | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql378_create_temp_tbl_per_min`                       | 临时表每分钟创建数                | 该指标用于统计GaussDB(for MySQL)执行语句时在硬盘上每分钟自动创建的临时表的数量。 | ≥0counts/min  | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql371_taurus_binlog_total_file_counts`                            | Binlog文件个数                    | 该指标用于统计GaussDB(for MySQL)Binlog文件数量。             | ≥0            | GaussDB(for MySQL)实例 | 5分钟                    |
| `gaussdb_mysql115_innodb_bufpool_read_ahead_evicted`                       | Innodb顺序预读，但未访问过的页数  | 该指标用于采集InnoDB表上的顺序预读，但未访问过的页数。       | ≥0 counts     | GaussDB(for MySQL)实例 | 1分钟                    |
| `gaussdb_mysql120_innodb_buffer_pool_bytes_data`                            | 缓冲池数据总字节数                | 该指标用于统计InnoDB缓冲池中包含数据的总字节数。             | ≥0 bytes      | GaussDB(for MySQL)实例 | 1分钟                    |



## 对象 {#object}

采集到的 HUAWEI SYS.CBR 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

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
    "charge_info"          : "{计费类型信息，支持包年包月和按需，默认为按需}",
    "create_time"          : "2023-08-01T14:17:40+0800",
    "update_time"          : "2023-08-01T14:17:42+0800",
    "private_ips"          : "[\"192.168.0.223\"]",
    "proxy_ips"            : "[]",
    "readonly_private_ips" : "[实例读内网IP地址列表]",
    "message"              : "{实例 JSON 数据}"
  }
}


```


> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
>
> 提示 2：`fields.message`、`fields.charge_info`、`fields.private_ips`、`fields.proxy_ips`、`fields.readonly_private_ips`、均为 JSON 序列化后字符串

