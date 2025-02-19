---
title: '华为云 GaussDB SYS.GAUSSDBV5'
tags: 
  - 华为云
summary: '华为云 GaussDB SYS.GAUSSDBV5，提供cpu、内存、磁盘、死锁、SQL 响应时间指标等数据。'
__int_icon: 'icon/huawei_gaussdb_sys.gaussdbv5'
dashboard:

  - desc: '华为云 GaussDB SYS.GAUSSDBV5'
    path: 'dashboard/zh/huawei_gaussdb_sys.gaussdbv5'

monitor:
  - desc: '华为云 GaussDB SYS.GAUSSDBV5'
    path: 'monitor/zh/huawei_gaussdb_sys.gaussdbv5'

---


<!-- markdownlint-disable MD025 -->
# 华为云 GaussDB `SYS.GAUSSDBV5`
<!-- markdownlint-enable -->

华为云 GaussDB `SYS.GAUSSDBV5`，提供cpu、内存、磁盘、死锁、`SQL`响应时间指标等数据。


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 GaussDB `SYS.GAUSSDBV5` 的监控数据，我们安装对应的采集脚本：「观测云集成（华为云- GaussDB 采集）」(ID：`guance_huaweicloud_gaussdb`)

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-huaweicloud-gaussdb/){:target="_blank"}



### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好 GaussDB `SYS.GAUSSDBV5` ,默认的指标集如下, 可以通过配置的方式采集更多的指标 [华为云云监控指标详情](https://support.huaweicloud.com/usermanual-opengauss/opengauss_01_0071.html){:target="_blank"}

| 指标ID                                             | 指标名称                          | 指标含义                                                     | 展示对象      | 指标单位               | 测量对象 |
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| rds005_instance_disk_used_size                     | 实例数据磁盘已使用大小            | 该指标用于统计测量对象的实例数据磁盘已使用大小，该值为实时值。 | 实例          | GB                     | 实例     |
| rds006_instance_disk_total_size                    | 实例数据磁盘总大小                | 该指标用于统计测量对象的实例数据磁盘总大小，该值为实时值。   | 实例          | GB                     | 实例     |
| rds007_instance_disk_usage                         | 实例数据磁盘已使用百分比          | 该指标用于统计测量对象的实例数据磁盘使用率，该值为实时值。   | 实例          | %                      | 实例     |
| rds035_buffer_hit_ratio                            | buffer命中率                      | 该指标用于统计数据库buffer命中率。                           | 实例          | %                      | 实例     |
| rds036_deadlocks                                   | 死锁次数                          | 该指标用于统计数据库发生事务死锁的次数，取该时间段的增量值。 | 实例          | Count                  | 实例     |
| rds048_P80                                         | 80% SQL的响应时间                 | 该指标用于统计数据库80% SQL的响应时间，该值为实时值。        | 实例          | us                     | 实例     |
| rds049_P95                                         | 95% SQL的响应时间                 | 该指标用于统计数据库95% SQL的响应时间，该值为实时值。        | 实例          | us                     | 实例     |
| rds001_cpu_util                                    | CPU使用率                         | 该指标用于统计测量对象的CPU使用率。                          | 当前节点      | %                      | 节点     |
| rds002_mem_util                                    | 内存使用率                        | 该指标用于统计测量对象的内存使用率。                         | 当前节点      | %                      | 节点     |
| rds003_bytes_in                                    | 数据写入量                        | 该指标用于统计测量对象对应VM的网络发送字节数，取时间段的平均值 | 当前节点      | Byte/s                 | 节点     |
| rds004_bytes_out                                   | 数据传出量                        | 该指标用于统计测量对象对应VM的网络接受字节数，取时间段的平均值 | 当前节点      | Byte/s                 | 节点     |
| rds014_iops                                        | 数据磁盘每秒读写次数              | 该指标用于统计测量对象的节点数据磁盘每秒读写次数，该值为实时值。 | 当前节点      | Count/s                | 节点     |
| rds016_disk_write_throughput                       | 数据磁盘写吞吐量                  | 该指标用于统计测量对象的节点数据磁盘每秒写吞吐量，该值为实时值。 | 当前节点      | Byte/s                 | 节点     |
| rds017_disk_read_throughput                        | 数据磁盘读吞吐量                  | 该指标用于统计测量对象的节点数据磁盘每秒读吞吐量，该值为实时值。 | 当前节点      | Byte/s                 | 节点     |
| rds020_avg_disk_ms_per_write                       | 数据磁盘单次写入花费的时间        | 该指标用于统计测量对象的节点数据磁盘单次写入花费的时间，取时间段的平均值。 | 当前节点      | ms                     | 节点     |
| rds021_avg_disk_ms_per_read                        | 数据磁盘单次读取花费的时间        | 该指标用于统计测量对象的节点数据磁盘单次读取花费的时间，取时间段的平均值。 | 当前节点      | ms                     | 节点     |
| io_bandwidth_usage                                 | 磁盘io带宽占用率                  | 当前磁盘io带宽与磁盘最大带宽比值                             | 当前节点      | %                      | 节点     |
| iops_usage                                         | IOPS使用率                        | 当前iops与磁盘最大iops比值                                   | 当前节点      | %                      | 节点     |
| rds069_swap_total_size                             | 交换内存总大小                    | 该指标用于描述操作系统交换内存总大小，该值为实时值。         | 当前节点      | MB                     | 节点     |
| rds068_swap_used_ratio                             | 交换内存使用率                    | 该指标用于描述操作系统交换内存使用率，该值为实时值。         | 当前节点      | %                      | 节点     |




## 对象 {#object}

采集到的 GaussDB `SYS.GAUSSDBV5` 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

``` json
{
  "measurement": "huaweicloud_gaussdb",
  "tags": {
    "RegionId"                : "cn-north-4",
    "db_user_name"            : "root",
    "name"                    : "2e10f990e139xxxxxx5fac6b59de7eein07",
    "port"                    : "3306",
    "project_id"              : "c631f046252d4xxxxxxx5f253c62d48585",
    "status"                  : "BUILD",
    "type"                    : "Cluster",
    "instance_id"             : "1236a915462940xxxxxx879882200in02",
    "instance_name"           : "xxxxx-efa7"
  },
  "fields": {
    "charge_info"          : "{计费类型信息，支持按需和包周期}",
    "flavor_info"          : "{规格信息}",
    "volume"               : "{volume信息}",
    "create_time"          : "2023-08-01T14:17:40+0800",
    "update_time"          : "2023-08-01T14:17:42+0800",
    "public_ips"           : "[\"192.168.0.223\"]",
    "nodes"                : "[]",
    "message"              : "{实例 JSON 数据}",
    "time_zone"            : "UTC+08:00"
  }
}

```


> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
>
> 提示 2：`fields.message`、`fields.charge_info`、`fields.flavor_info`、`fields.volume`、`fields.public_ips`、`fields.nodes`、均为 JSON 序列化后字符串

