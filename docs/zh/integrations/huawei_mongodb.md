---
title: '华为云 MongoDB'
tags: 
  - 华为云
summary: '采集华为云 MongoDB 指标数据'
__int_icon: 'icon/huawei_mongodb'
dashboard:
  - desc: '华为云 MongoDB 内置视图'
    path: 'dashboard/zh/huawei_mongodb/'

monitor:
  - desc: '华为云 MongoDB 监控器'
    path: 'monitor/zh/huawei_mongodb/'
---


采集 华为云 MongoDB 指标数据

## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/)

> 推荐部署GSE版

### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步华为云 MongoDB 监控数据，我们安装对应的采集脚本：「<<< custom_key.brand_name >>>集成（华为云-GaussDB-Mongo）」(ID：`guance_huaweicloud_gaussdb_mongo`)

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

脚本安装完后，在 Func 中「开发」里找到脚本「<<< custom_key.brand_name >>>集成（华为云-GaussDB-Mongo 采集）」，展开修改此脚本，找到 `collector_configs` 和 `monitor_configs` 分别编辑下面 `region_projects` 中的内容，将地域和 Project ID,更改为实际的地域和 Project ID，再点击保存发布。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 - 资源目录」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}

配置华为云 MongoDB 指标, 可以通过配置的方式采集更多的指标 [华为云 MongoDB 指标详情](https://support.huaweicloud.com/mongoug-nosql/nosql_08_0106.html){:target="_blank"}

| **指标ID**            |          **指标名称**   | **指标含义** | **取值范围**      | **测量对象** | **监控周期（原始指标）** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| `nosql001_cpu_usage`            |   CPU利用率    |该指标为从系统层面采集的CPU使用率。单位：%   | 0~100 %  | GeminiDB Mongo实例的节点 | 1分钟             |
| `nosql002_mem_usage`            |   内存利用率   | 该指标为从系统层面采集的内存使用率。单位：%  | 0~100 %  | GeminiDB Mongo实例的节点 | 1分钟             |
| `nosql003_bytes_out`            |  网络输出吞吐量 | 统计平均每秒从测量对象的所有网络适配器输出的流量。单位：bytes/s | ≥ 0 bytes/s    | GeminiDB Mongo实例的节点 | 1分钟       |
| `nosql004_bytes_in`             |  网络输入吞吐量 | 统计平均每秒从测量对象的所有网络适配器输入的流量。单位：bytes/s | ≥ 0 bytes/s  | GeminiDB Mongo实例的节点 | 1分钟            |
| `nosql005_disk_usage`           |  存储容量使用率 | 该指标为存储容量使用率。单位：%   |   0~100 %    | GeminiDB Mongo实例的节点       | 1分钟                |
| `nosql006_disk_total_size`      |  存储容量总容量 | 该指标为实例的存储容量总容量。单位：GB   | ≥ 0 GB | GeminiDB Mongo实例的节点       | 1分钟                |
| `nosql007_disk_used_size`       |  存储容量使用量 | 该指标为实例的存储容量使用量。单位：GB   | ≥ 0 GB | GeminiDB Mongo实例的节点       | 1分钟                |
| `mongodb001_command_ps`         |  command执行频率 | 该指标用于统计平均每秒command语句在节点上执行次数。 单位：Counts/s           | ≥ 0 Counts/s | GeminiDB Mongo实例的节点 | 1分钟         |
| `mongodb002_delete_ps`          |  delete语句执行频率  | 该指标用于统计平均每秒delete语句在节点上执行次数。 单位：Counts/s           | ≥ 0 Counts/s | GeminiDB Mongo实例的节点 | 1分钟        |
| `mongodb003_insert_ps`          |  insert语句执行频率  | 该指标用于统计平均每秒inster语句在节点上执行次数。 单位：Counts/s          | ≥ 0 Counts/s | GeminiDB Mongo实例的节点 | 1分钟          |
| `mongodb004_query_ps`           |  query语句执行频率   | 该指标用于统计平均每秒query语句在节点上执行次数。 单位：Counts/s          | ≥ 0 Counts/s   | GeminiDB Mongo实例的节点 | 1分钟        |
| `mongodb005_update_ps`          |  update语句执行频率  | 该指标用于统计平均每秒update语句在节点上执行次数。 单位：Counts/s          | ≥ 0 Counts/s | GeminiDB Mongo实例的节点 | 1分钟          |
| `mongodb006_getmore_ps`         | getmore语句执行频率  | 该指标用于统计平均每秒getmore语句在节点上执行次数。 单位：Counts/s          | ≥ 0 Counts/s | GeminiDB Mongo实例的节点 | 1分钟          |
| `mongodb007_connections_usage`  |  当前活动连接数百分比 | 该指标用于统计试图连接到实例节点的连接数占可用连接数百分比。 单位：%          | 0~100 %      | GeminiDB Mongo实例的节点 | 1分钟          |
| `mongodb008_mem_resident`       |  驻留内存           | 该指标用于统计当前驻留内存的大小。单位：MB            | ≥ 0 MB      | GeminiDB Mongo实例的节点 | 1分钟               |
| `mongodb009_mem_virtual`       |   虚拟内存           | 该指标用于统计当前虚拟内存的大小。单位：MB           | ≥ 0 MB       | GeminiDB Mongo实例的节点 | 1分钟              |
| `mongodb010_regular_asserts_ps` |  常规断言频率        | 该指标用于统计常规断言频率。单位：Counts/s          | ≥ 0 Counts/s       | GeminiDB Mongo实例的节点 | 1分钟         |
| `mongodb011_warning_asserts_ps` |   警告频率           | 该指标用于统计警告频率。单位：Counts/s             | ≥ 0 Counts/s | GeminiDB Mongo实例的节点      | 1分钟                 |
| `mongodb012_msg_asserts_ps` |       消息断言频率       | 该指标用于统计消息断言频率。单位：Counts/s          | ≥ 0 Counts/s | GeminiDB Mongo实例的节点 | 1分钟              |
| `mongodb013_user_asserts_ps`     |     用户断言频率    | 该指标用于统计用户断言频率。单位：Counts/s          | ≥ 0 Counts/s | GeminiDB Mongo实例的节点的节点 | 1分钟        |
| `mongodb014_queues_total`    |     等待锁的操作数     | 该指标用于统计当前等待锁的操作数。单位：Counts         |   ≥ 0 Counts |  GeminiDB Mongo实例的节点       | 1分钟                |
| `mongodb015_queues_readers`       |    等待读锁的操作数    | 该指标用于统计当前等待读锁的操作数。单位：Counts               | ≥ 0 Counts   | GeminiDB Mongo实例的节点  | 1分钟      |
| `mongodb016_queues_writers`     |   等待写锁的操作数        | 该指标用于统计当前等待写锁的操作数。单位：Counts                   | ≥ 0 Counts   | GeminiDB Mongo实例的节点 | 1分钟                    |
| `mongodb017_page_faults`     |   缺页错误数   | 该指标用于统计当前节点上的缺页错误数。单位：Counts             | ≥ 0 Counts   | GeminiDB Mongo实例的节点 | 1分钟                    |
| `mongodb018_porfling_num`        |      慢查询数      | 该指标用于统计当前节点上的慢查询数。单位：Counts          | ≥ 0 Counts   | GeminiDB Mongo实例的节点 | 1分钟                    |
| `mongodb019_cursors_open`       |       当前维护游标数       | 该指标用于统计当前节点上的维护游标数。单位：Counts             | ≥ 0 Counts   | GeminiDB Mongo实例的节点   | 1分钟                    |
| `mongodb020_cursors_timeout`       |    服务超时游标数    | 该指标用于统计当前节点上的服务超时游标数。单位：Counts           | ≥ 0 Counts       | GeminiDB Mongo实例的节点 | 1分钟                    |

## 对象 {#object}

数据正常同步后，可以在<<< custom_key.brand_name >>>的「基础设施 - 资源目录」中查看数据。

```json
{
  "measurement": "huaweicloud_gaussdb_mongo",
  "tags": {
    "RegionId"             : "cn-south-1",
    "project_id"           : "756ada1aa17e4049b2a16ea41912e52d",
    "instance_id"          : "16b35ebaba1c44c39d9c24bae742ca97in02",
    "enterprise_project_id": "0824ss-xxxx-xxxx-xxxx-12334fedffg",
    "instance_name"        : "dds-3ed3",
    "status"               : "normal",
    "engine"               : "rocksDB"
  },
  "fields": {
    "port"              : "8635", 
    "db_user_name"      : "rwuser",
    "vpc_id"            : "674e9b42-xxxx-xxxx-xxxx-5abcc565b961",
    "subnet_id"         : "f1df08c5-xxxx-xxxx-xxxx-de435a51007b",
    "security_group_id" : "7aa51dbf-xxxx-xxxx-xxxx-dad3c4828b58",
    "pay_mode"          : "0",
    "create_time"       : "2024-11-09T15:28:46",
    "update_time"       : "2024-11-08T13:21:35",
    "backup_strategy"   : "{实例 JSON 数据}",
    "datastore"         : "{实例 JSON 数据}",
    "groups"            : "[{实例 JSON 数据}]",
    "time_zone"         : "xxxx",
    "message"           : "{实例 JSON 数据}"
  }
}
```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.instance_id`值为实例 ID，作为唯一识别
>
> 提示 2：
>
> - `fields.message`
> - `fields.backup_strategy`
> - `fields.datastore`
> - `fields.groups`
> - `fields.actions`
