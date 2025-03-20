---
title: '华为云 RDS SQLServer'
tags: 
  - 华为云
summary: '采集华为云 RDS SQLServer 指标数据'
__int_icon: 'icon/huawei_rds_sqlserver'
dashboard:

  - desc: '华为云 RDS SQLServer 监控视图'
    path: 'dashboard/zh/huawei_rds_sqlserver'

monitor:
  - desc: '华为云 RDS SQLServer 监控器'
    path: 'monitor/zh/huawei_rds_sqlserver'

---

采集华为云 RDS SQLServer 指标数据

## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步华为云 RDS SQLServer 的监控数据，我们安装对应的采集脚本：「<<< custom_key.brand_name >>>集成（华为云-RDS-SQLServer 采集）」(ID：`guance_huaweicloud_rds_sqlserver`)

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

脚本安装完后，在 Func 中「开发」里找到脚本「<<< custom_key.brand_name >>>集成（华为云-RDS-SQLServer 采集）」，展开修改此脚本，找到 `collector_configs` 和 `monitor_configs` 分别编辑下面`region_projects`中的内容，将地域和 Project ID,更改为实际的地域和 Project ID，再点击保存发布。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 - 资源目录」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}

配置华为云 RDS SQLServer 指标,可以通过配置的方式采集更多的指标 [华为云 RDS SQLServer 指标详情](https://support.huaweicloud.com/usermanual-rds/rds_sqlserver_06_0001.html){:target="_blank"}

RDS for SQLServer 实例性能监控指标，如下表所示。

| 指标ID                                       | 指标名称                                | 指标含义                                                     | 取值范围           | 监控周期（原始指标） |
| -------------------------------------------- | --------------------------------------- | ------------------------------------------------------------ | ------------------ | -------------------- |
| `rds001_cpu_util`                            | CPU使用率                               | 该指标用于统计测量对象的CPU使用率，以比率为单位。            | 0-100%             | 1分钟5秒1秒          |
| `rds002_mem_util`                            | 内存使用率率                              | 该指标用于统计测量对象的内存利用率。           | 0～100%            | 1分钟          |
| `rds003_iops`                                | IOPS                                    | 该指标用于统计当前实例，单位时间内系统处理的I/O请求数量（平均值）。 | ≥ 0 counts/s       | 1分钟                |
| `rds004_bytes_in`                            | 网络输入吞吐量                          | 该指标用于统计平均每秒从测量对象的所有网络适配器输入的流量，以字节/秒为单位。 | ≥ 0 bytes/s        | 1分钟                |
| `rds005_bytes_out`                           | 网络输出吞吐量                          | 该指标用于统计平均每秒从测量对象的所有网络适配器输出的流量，以字节/秒为单位。 | ≥ 0 bytes/s        | 1分钟                |
| `rds039_disk_util`                           | 磁盘利用率                          | 该指标用于统计测量对象的磁盘利用率。                                       | 0～100%         | 1分钟          |
| `rds047_disk_total_size`                     | 磁盘总大小                           | 该指标用于统计测量对象的磁盘总大小。             |    40GB～4000GB         | 1分钟          |
| `rds048_disk_used_size`                                 | 磁盘使用量量                                     | 该指标用于统计测量对象的磁盘使用大小。   | 0GB～4000GB      | 1分钟          |
| `rds049_disk_read_throughput`                                 | 硬盘读吞吐量                                     | 该指标用于统计每秒从磁盘读取的字节数。 | ≥0bytes/s | 1分钟          |
| `rds050_disk_write_throughput`                    | 硬盘写吞吐量                            | 该指标用于统计每秒写入磁盘的字节数。 | ≥0bytes/s                | 1分钟                |
| `rds053_avg_disk_queue_length`                      | 磁盘平均队列长度                            | 该指标用于统计等待写入测量对象的进程个数。           | ≥0                | 1分钟                |
| `rds054_db_connections_in_use`                    | 使用中的数据库连接数                            | 用户连接到数据库的连接数量。 | ≥0 counts                | 1分钟                |
| `rds055_transactions_per_sec`                        | 平均每秒事务数                    | 该指标用于统计数据库每秒启动的事务数。  | ≥0counts/s        | 1分钟                |
| `rds056_batch_per_sec`                       | 平均每秒batch数                    | 该指标用于统计每秒收到的Transact-SQL命令批数。  | ≥0counts/s        | 1分钟                |
| `rds057_logins_per_sec`                   | 每秒登录次数                  | 该指标用于统计每秒启动的登录总数。 | ≥ 0 counts/s       | 1分钟                |
| `rds058_logouts_per_sec`                  | 每秒登出次数                  | 该指标用于统计每秒启动的注销操作总数。 | ≥ 0 counts/s       | 1分钟                |
| `rds059_cache_hit_ratio`          | 缓存命中率                                         | 该指标用于统计在缓冲区高速缓存中找到而不需要从磁盘中读取的页的百分比。        | 0~100%       | 1分钟                |
| `rds060_sql_compilations_per_sec`              | 平均每秒SQL编译数                | 该指标用于统计每秒SQL的编译数。 | ≥ 0 counts/s       | 1分钟                |
| `rds061_sql_recompilations_per_sec`              | 平均每秒SQL重编译数             | 该指标用于统计每秒语句重新编译的次数                      | ≥ 0 counts/s       | 1分钟                |
| `rds062_full_scans_per_sec`                       | 每秒全表扫描数                          | 该指标用于统计每秒不受限制的完全扫描数。          | ≥ 0 counts/s       | 1分钟                |
| `rds063_errors_per_sec`                    | 每秒用户错误数                          | 该指标用于统计每秒用户错误数。                   | ≥0counts/s           | 1分钟                |
| `rds064_latch_waits_per_sec`                | 每秒闩锁等待数                     | 该指标用于统计每秒未能立即授予的闩锁请求数。             | ≥0counts/s              | 1分钟                |
| `rds065_lock_waits_per_sec`                 | 每秒锁等待次数                      | 该指标用于统计每秒要求调用者等待的锁请求数。            | ≥0counts/s                | 1分钟                |
| `rds066_lock_requests_per_sec`             | 每秒锁请求次数                      | 该指标用于统计锁管理器每秒请求的新锁和锁转换数。          | ≥ 0 counts/s       | 1分钟                |
| `rds067_timeouts_per_sec`              | 每秒锁超时次数                      | 该指标用于统计每秒超时的锁请求数。          | ≥ 0 counts/s       | 1分钟                |
| `rds068_avg_lock_wait_time`              | 平均锁等待延迟                    | 该指标用于统计每个导致等待的锁请求的平均等待时间（毫秒）。    | ≥0ms       | 1分钟                |
| `rds069_deadlocks_per_sec`               | 每秒死锁次数                    | 该指标用于统计刷新所有脏页的检查点或其他操作每秒刷新到磁盘的页数。    | ≥ 0 counts/s       | 1分钟                |
| `rds070_checkpoint_pages_per_sec`          | 每秒检查点写入Page数                     | 该指标用于统计刷新所有脏页的检查点或其他操作每秒刷新到磁盘的页数。    | ≥0counts/s      | 1分钟                |
| `rds077_replication_delay`                    | 数据同步延迟                      | 该指标用于统计主备实例复制延迟，由于SQL Server实例复制延迟都是库级别，每个库各自都在做同步，所以实例级别复制延迟为复制延迟最大的库的值（单机不涉及都为0s）。    | ≥ 0s      |  1分钟                |
| `mssql_mem_grant_pending`                | 待内存授权进程数               | 该指标用于统计等待接受内存授权进行使用的进程总数，指示内存压力情况。 | ≥0counts      | 1分钟                |
| `mssql_lazy_write_per_sec`                    | 每秒惰性写入缓存数                     | 该指标用于统计每秒钟被惰性编辑器（Lazy writer）写入的缓冲数。   | ≥0counts/s      | 1分钟                |
| `mssql_page_life_expectancy`                | 无引用页缓冲池停留时间           | 该指标用于统计页面不被引用后，在缓冲池中停留的秒数。 | ≥0s      | 1分钟                |
| `mssql_page_reads_per_sec`                    | 每秒页读取次数                      | 该指标用于统计每秒读取页的个数。                   | ≥0counts/s      | 1分钟          |
| `mssql_tempdb_disk_size`                    | 临时表空间大小                     | 当前临时表空间占用磁盘大小。    | ≥ 0MB       | 1分钟          |
| `mssql_worker_threads_usage_rate`                | 工作线程使用率                              | 当前实际工作线程总数与max worker threads值的比值。 |     0~100%        | 1分钟                |

## 对象 {#object}

采集到的华为云 RDS SQLServer 对象数据结构, 可以从「基础设施 - 资源目录」里看到对象数据

```json
{
  "measurement": "huaweicloud_rds_sqlserver",
  "tags": {
    "RegionId"               : "cn-south-1",
    "project_id"             : "c631f046252dxxxxxxxf253c62d48585",
    "enterprise_project_id"  : "o78hhbss-xxxx-xxxx-xxxx-cba3d38cf2f9",
    "instance_id"            : "1d0c91561f4644dxxxxxx68304b0520din01",
    "instance_name"          : "rds-xxxx",
    "engine"                 : "SQLServer",
    "type"                   : "Ha",
    "status"                 : "ACTIVE",
  },
  "fields": {
    "port"                   : "3306",
    "security_group_id"      : "9e5bd45e-0564-445f-xxxx-2c8954e2d99c",
    "switch_strategy"        : "xxx",
    "time_zone"              : "China Standard Time",
    "enable_ssl"             : "True",
    "charge_info.charge_mode": "postPaid",
    "engine_version"         : "2022_SE",
    "created_time"           : "2024-11-03T15:26:45+0000",
    "updated_time"           : "2024-11-05T09:58:26+0000",
    "alias"                  : "xxx",
    "private_ips"            : "[\"192.x.x.35\"]",
    "public_ips"             : "[]",
    "datastore"              : "{Instance JSON 数据}",
    "cpu"                    : "4",
    "mem"                    : "8",
    "volume"                 : "{volume 信息}",
    "nodes"                  : "[{主备实例信息}]",
    "related_instance"       : "[]",
    "backup_strategy"        : "{备份策略}",
    "message"                : "{Instance JSON 数据}"
  }
}
```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.instance_id`值为实例 ID，作为唯一识别
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
