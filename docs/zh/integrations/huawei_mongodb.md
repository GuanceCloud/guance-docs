---
title: '华为云 MongoDB'
summary: '华为云MongoDB的展示指标包括读写吞吐量、延迟、并发连接数和数据可靠性，这些指标反映了MongoDB在处理大规模文档存储和查询时的性能表现和可扩展性。'
__int_icon: 'icon/huawei_mongodb'
dashboard:
  - desc: '华为云 MongoDB 内置视图'
    path: 'dashboard/zh/huawei_mongodb/'

monitor:
  - desc: '华为云 MongoDB 监控器'
    path: 'monitor/zh/huawei_mongodb/'
---


<!-- markdownlint-disable MD025 -->
# 华为云 MongoDB
<!-- markdownlint-enable -->

华为云MongoDB的展示指标包括读写吞吐量、延迟、并发连接数和数据可靠性，这些指标反映了MongoDB在处理大规模文档存储和查询时的性能表现和可扩展性。

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署Func](https://func.guance.com/doc/script-market-guance-integration/)

> 推荐部署GSE版

### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 MongoDB 云资源的监控数据，我们安装对应的采集脚本：「观测云集成（华为云-MongoDB）」(ID：guance_huaweicloud_gaussdb_mongo)

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-huaweicloud-gaussdb-nosql/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好华为云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [华为云云监控指标详情](https://support.huaweicloud.com/mongoug-nosql/nosql_08_0106.html){:target="_blank"}

| **指标ID**            |          **指标名称**   | **指标含义** | **取值范围**      | **测量对象** | **监控周期（原始指标）** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| `nosql001_cpu_usage`            |      CPU利用率       | 该指标为从系统层面采集的CPU使用率。单位：%                   | 0~100 %      | GaussDB(for Mongo)实例的节点 | 1分钟                    |
| `nosql002_mem_usage`              |      内存利用率      | 该指标为从系统层面采集的内存使用率。单位：%                  | 0~100 %      | GaussDB(for Mongo)实例的节点 | 1分钟                    |
| `nosql003_bytes_out`            |    网络输出吞吐量    | 统计平均每秒从测量对象的所有网络适配器输出的流量。单位：bytes/s | ≥ 0 bytes/s  | GaussDB(for Mongo)实例的节点 | 1分钟                    |
| `nosql004_bytes_in`             |    网络输入吞吐量    | 统计平均每秒从测量对象的所有网络适配器输入的流量。单位：bytes/s | ≥ 0 bytes/s  | GaussDB(for Mongo)实例的节点 | 1分钟                    |
| `nosql005_disk_usage`           |      磁盘利用率      | 该指标用于统计测量对象的磁盘利用率。单位：%                  | 0~100 %      | GaussDB(for Mongo)实例       | 1分钟                    |
| `nosql006_disk_total_size`      |      磁盘总大小      | 该指标用于统计测量对象的磁盘总大小。单位：GB                 | ≥ 0 GB       | GaussDB(for Mongo)实例       | 1分钟                    |
| `nosql007_disk_used_size`       |      磁盘使用量      | 该指标用于统计测量对象的磁盘已使用总大小。单位：GB           | ≥ 0 GB       | GaussDB(for Mongo)实例       | 1分钟                    |
| `mongodb001_command_ps`         |   command执行频率    | 该指标用于统计平均每秒command语句在节点上执行次数。单位：Counts/s | ≥ 0 Counts/s | GaussDB(for Mongo)实例的节点 | 1分钟                    |
| `mongodb002_delete_ps`          |  delete语句执行频率  | 该指标用于统计平均每秒delete语句在节点上执行次数。单位：Counts/s | ≥ 0 Counts/s | GaussDB(for Mongo)实例的节点 | 1分钟                    |
| `mongodb003_insert_ps`          |  insert语句执行频率  | 该指标用于统计平均每秒insert语句在节点上执行次数。单位：Counts/s | ≥ 0 Counts/s | GaussDB(for Mongo)实例的节点 | 1分钟                    |
| `mongodb004_query_ps`           |  query语句执行频率   | 该指标用于统计平均每秒query语句在节点上执行次数。单位：Counts/s | ≥ 0 Counts/s | GaussDB(for Mongo)实例的节点 | 1分钟                    |
| `mongodb005_update_ps`          |  update语句执行频率  | 该指标用于统计平均每秒update语句执行次数。单位：Counts/s     | ≥ 0 Counts/s | GaussDB(for Mongo)实例的节点 | 1分钟                    |
| `mongodb006_getmore_ps`         | **getmore**语句执行频率  | 该指标用于统计平均每秒**getmore**语句在节点上执行次数。单位：Counts/s | ≥ 0 Counts/s | GaussDB(for Mongo)实例的节点 | 1分钟                    |
| `mongodb007_connections`        |    当前活动连接数    | 该指标用于统计试图连接到实例节点的连接数。单位：Counts       | ≥ 0 Counts   | GaussDB(for Mongo)实例的节点 | 1分钟                    |
| `mongodb007_connections_usage`  | 当前活动连接数百分比 | 该指标用于统计试图连接到实例节点的连接数占可用连接数百分比。单位：% | 0~100 %      | GaussDB(for Mongo)实例的节点 | 1分钟                    |
| `mongodb008_mem_resident`       |       驻留内存       | 该指标用于统计当前驻留内存的大小。单位：MB                   | ≥ 0 MB       | GaussDB(for Mongo)实例的节点 | 1分钟                    |
| `mongodb009_mem_virtual`        |       虚拟内存       | 该指标用于统计当前虚拟内存的大小。单位：MB                   | ≥ 0 MB       | GaussDB(for Mongo)实例的节点 | 1分钟                    |
| `mongodb010_regular_asserts_ps` |     常规断言频率     | 该指标用于统计常规断言频率。单位：Counts/s                   | ≥ 0 Counts/s | GaussDB(for Mongo)实例的节点 | 1分钟                    |
| `mongodb011_warning_asserts_ps` |       警告频率       | 该指标用于统计警告频率。单位：Counts/s                       | ≥ 0 Counts/s | GaussDB(for Mongo)实例的节点 | 1分钟                    |
| `mongodb012_msg_asserts_ps`     |     消息断言频率     | 该指标用于统计消息断言频率。单位：Counts/s                   | ≥ 0 Counts/s | GaussDB(for Mongo)实例的节点 | 1分钟                    |
| `mongodb013_user_asserts_ps`    |     用户断言频率     | 该指标用于统计用户断言频率。单位：Counts/s                   | ≥ 0 Counts/s | GaussDB(for Mongo)实例的节点 | 1分钟                    |
| `mongodb014_queues_total`       |    等待锁的操作数    | 该指标用于统计当前等待锁的操作数。单位：Counts               | ≥ 0 Counts   | GaussDB(for Mongo)实例的节点 | 1分钟                    |
| `mongodb015_queues_readers`     |   等待读锁的操作数   | 该指标用于统计当前等待读锁的操作数。单位：Counts             | ≥ 0 Counts   | GaussDB(for Mongo)实例的节点 | 1分钟                    |
| `mongodb016_queues_writers`     |   等待写锁的操作数   | 该指标用于统计当前等待写锁的操作数。单位：Counts             | ≥ 0 Counts   | GaussDB(for Mongo)实例的节点 | 1分钟                    |
| `mongodb017_page_faults`        |      缺页错误数      | 该指标用于统计当前节点上的缺页错误数。单位：Counts           | ≥ 0 Counts   | GaussDB(for Mongo)实例的节点 | 1分钟                    |
| `mongodb018_porfling_num`       |       慢查询数       | 该指标用于统计当前节点上的慢查询数。单位：Counts             | ≥ 0 Counts   | GaussDB(for Mongo)实例的节点 | 1分钟                    |
| `mongodb019_cursors_open`       |    当前维护游标数    | 该指标用于统计当前节点上的维护游标数。单位：Counts           | ≥ 0 Counts   | GaussDB(for Mongo)实例的节点 | 1分钟                    |
| `mongodb020_cursors_timeout`    |    服务超时游标数    | 该指标用于统计当前节点上的服务超时游标数。单位：Counts       | ≥ 0 Counts   | GaussDB(for Mongo)实例的节点 | 1分钟                    |

## 对象 {#object}

数据正常同步后，可以在观测云的「基础设施 / 自定义（对象）」中查看数据。

```json
{
  "measurement": "huaweicloud_gaussdb_nosql",
  "tags": {
    "RegionId"          : "cn-north-4",
    "db_user_name"      : "rwuser",
    "engine"            : "rocksDB",
    "instance_id"       : "1236a915462940xxxxxx879882200in02",
    "instance_name"     : "nosql-efa7",
    "name"              : "1236a915462940xxxxxx879882200in02",
    "pay_mode"          : "0",
    "port"              : "8635",
    "project_id"        : "15c6ce1c12dxxxx0xxxx2076643ac2b9",
    "security_group_id" : "7aa51dbf-xxxx-xxxx-xxxx-dad3c4828b58",
    "status"            : "normal",
    "subnet_id"         : "f1df08c5-xxxx-xxxx-xxxx-de435a51007b",
    "vpc_id"            : "674e9b42-xxxx-xxxx-xxxx-5abcc565b961"
  },
  "fields": {
    "actions"         : "[]",
    "create_time"     : "2023-08-01T14:17:40+0800",
    "update_time"     : "2023-08-01T14:17:42+0800",
    "backup_strategy" : "{实例 JSON 数据}",
    "datastore"       : "{实例 JSON 数据}",
    "groups"          : "[{实例 JSON 数据}]",
    "time_zone"       : "",
    "message"         : "{实例 JSON 数据}"
  }
}
```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
>
> 提示 2：
>
> - `fields.message`
> - `fields.backup_strategy`
> - `fields.datastore`
> - `fields.groups`
> - `fields.actions`

