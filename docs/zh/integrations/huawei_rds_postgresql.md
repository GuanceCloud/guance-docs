---
title: '华为云 RDS PostgreSQL'
tags: 
  - 华为云
summary: '华为云 RDS PostgreSQL 的展示指标包括查询性能、事务吞吐量、并发连接数和数据可靠性，这些指标反映了RDS PostgreSQL 在处理大规模关系型数据存储和事务处理时的性能表现和可靠性。'
__int_icon: 'icon/huawei_rds_postgresql'
dashboard:

  - desc: '华为云 RDS PostgreSQL 内置视图'
    path: 'dashboard/zh/huawei_rds_postgresql'

monitor:
  - desc: '华为云 RDS PostgreSQL 监控器'
    path: 'monitor/zh/huawei_rds_postgresql'

---


<!-- markdownlint-disable MD025 -->
# 华为云 RDS PostgreSQL
<!-- markdownlint-enable -->

华为云 RDS PostgreSQL 的展示指标包括查询性能、事务吞吐量、并发连接数和数据可靠性，这些指标反映了RDS PostgreSQL 在处理大规模关系型数据存储和事务处理时的性能表现和可靠性。


## 配置 {#config}

### 安装 Func

推荐开通 {{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步华为云 RDS PostgreSQL 的监控数据，我们安装对应的采集脚本：通过访问func的web服务进入【脚本市场】，「{{{ custom_key.brand_name }}}集成（华为云-RDS-PostgreSQL 采集）」(ID：`guance_huaweicloud_rds_postgresql`)

点击【安装】后，输入相应的参数：华为云 AK、SK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

脚本安装完后，在 Func 中「开发」里找到脚本「{{{ custom_key.brand_name }}}集成（华为云-RDS-PostgreSQL 采集）」，展开修改此脚本，找到 collector_configs 和monitor_configs 分别编辑下面region_projects中的内容，将地域和 Project ID,更改为实际的地域和 Project ID，再点击保存发布。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-huaweicloud-rds-postgresql/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在{{{ custom_key.brand_name }}}平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在{{{ custom_key.brand_name }}}平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好华为云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [华为云云监控指标详情](https://support.huaweicloud.com/usermanual-rds/rds_pg_06_0001.html){:target="_blank"}

### 实例监控指标

RDS for PostgreSQL实例性能监控指标，如下表所示。更多指标请参考[表1](https://support.huaweicloud.com/usermanual-rds/rds_pg_06_0001.html){:target="_blank"}

| 指标ID                                       | 指标名称                                | 指标含义                                                     | 取值范围           | 监控周期（原始指标） |
| -------------------------------------------- | --------------------------------------- | ------------------------------------------------------------ | ------------------ | -------------------- |
| `swap_total_size`| 交换区总容量大小| 该指标为统计交换区总量。| ≥ 0 MB| 1分钟|
| `swap_usage`| 交换区容量使用率| 该指标为统计交换区使用率。| 0-100%| 1分钟|
| `rds005_bytes_out`| 网络输出吞吐量| 该指标用于统计平均每秒从测量对象的所有网络适配器输出的流量，以字节/秒为单位。| ≥ 0 bytes/s| 1分钟|
| `rds004_bytes_in`| 网络输入吞吐量| 该指标用于统计平均每秒从测量对象的所有网络适配器输入的流量，以字节/秒为单位。| ≥ 0 bytes/s| 1分钟|
| `rds003_iops`| IOPS| 该指标用于统计当前实例，单位时间内系统处理的I/O请求数量（平均值）。| ≥ 0 counts/s| 1分钟|
| `read_count_per_second`| 读IOPS| 该指标用于统计当前实例，单位时间内系统处理的读I/O请求数量（平均值）。| ≥ 0 counts/s| 1分钟|
| `write_count_per_second`| 写IOPS| 该指标用于统计当前实例，单位时间内系统处理的写I/O请求数量（平均值）。| ≥ 0 counts/s| 1分钟|
| `rds042_database_connections`| 数据库连接数| 当前连接到数据库的后端量。| ≥ 0 counts| 1分钟|
| `rds083_conn_usage`| 连接数使用率| 该指标用于统计当前已用的PgSQL连接数占总连接数的百分比。| 0-100%| 1分钟|
| `active_connections`| 活跃连接数| 该指标为统计数据库当前活跃连接数。| ≥ 0| 1分钟|
| `rds082_tps`| TPS| 该指标用于统计每秒事务执行次数，含提交的和回退的。| ≥ 0 次/秒| 1分钟|
| `rds046_replication_lag`| 复制时延| 副本滞后时延。| ≥ 0 ms| 1分钟|
| `synchronous_replication_blocking_time`| 同步复制阻塞时间| 该指标为获取同步复制主备机间复制阻塞的时长。| ≥ 0 s| 1分钟|
| `inactive_logical_replication_slot`| 非活跃逻辑复制槽数量| 该指标用于统计当前数据库中存在的非活跃逻辑复制槽数量。| ≥ 0| 1分钟|
| `rds041_replication_slot_usage`| 复制插槽使用量| 复制插槽文件所占磁盘容量。| ≥ 0 MB| 1分钟|
| `rds043_maximum_used_transaction_ids`| 事务最大已使用ID数| 事务最大已使用ID。| ≥ 0 counts| 1分钟|
| `idle_transaction_connections`| 事务空闲连接数| 该指标为统计数据库当前空闲连接数。| ≥ 0| 1分钟|
| `oldest_transaction_duration`| 最长事务存活时长| 该指标为统计当前数据库中存在的最长事务存活时长。| ≥ 0 ms| 1分钟|
| `oldest_transaction_duration_2pc`| 最长未决事务存活时长| 该指标为统计当前数据库存在的最长未决事务存活时长。| ≥ 0 ms| 1分钟|
| `rds040_transaction_logs_usage`| 事务日志使用量| 事务日志所占用的磁盘容量。| ≥ 0 MB| 1分钟|
| `lock_waiting_sessions`| 等待锁的会话数| 该指标为统计当前处于阻塞状态的会话个数。| ≥ 0| 1分钟|
| `slow_sql_log_min_duration_statement`| 已执行log_min_duration_statement时长的SQL数| 该指标为统计数据库执行时长比参数log_min_duration_statement大的慢SQL个数，该参数大小可根据业务需要进行更改。| ≥ 0| 1分钟|
| `slow_sql_one_second`| 已执行1s的SQL数| 该指标为统计数据库执行时长1秒以上的慢SQL个数。| ≥ 0| 1分钟|
| `slow_sql_three_second`| 已执行3s的SQL数| 该指标为统计数据库执行时长3秒以上的慢SQL个数。| ≥ 0| 1分钟|
| `slow_sql_five_second`| 已执行5s的SQL数| 该指标为统计数据库执行时长5秒以上的慢SQL个数。| ≥ 0| 1分钟|

## 对象 {#object}

采集到的华为云 RDS PostgreSQL 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "huaweicloud_rds_postgresql",
  "tags": {
    "name"                   : "1d0c91561f4644daxxxxx68304b0520din01",
    "id"                     : "1d0c91561f4644dxxxxxxd68304b0520din01",
    "instance_name"          : "rds-df54-xxxx",
    "status"                 : "ACTIVE",
    "port"                   : "5432",
    "type"                   : "Single",
    "RegionId"               : "cn-north-4",
    "security_group_id"      : "d13ebb59-d4fe-xxxx-xxxx-c22bcea6f987",
    "switch_strategy"        : "xxx",
    "project_id"             : "c631f046252dxxxxxxxf253c62d48585",
    "time_zone"              : "UTC+08:00",
    "enable_ssl"             : "False",
    "charge_info.charge_mode": "postPaid",
    "engine"                 : "PostgreSQL",
    "engine_version"         : "14"
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
