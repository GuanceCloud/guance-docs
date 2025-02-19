---
title: '华为云 GaussDB-Influx'
tags: 
  - 华为云
summary: '华为云GaussDB-Influx的展示指标包括写入吞吐量、查询延迟、数据保留策略和可扩展性，这些指标反映了GaussDB-Influx在处理大规模时序数据存储和查询时的性能表现和可靠性。'
__int_icon: 'icon/huawei_gaussdb_influx'
dashboard:

  - desc: '华为云 GaussDB-Influx 内置视图'
    path: 'dashboard/zh/huawei_gaussdb_influx'

monitor:
  - desc: '华为云 GaussDB-Influx 监控器'
    path: 'monitor/zh/huawei_gaussdb_influx'

---


<!-- markdownlint-disable MD025 -->
# 华为云 GaussDB-Influx
<!-- markdownlint-enable -->

华为云GaussDB-Influx的展示指标包括写入吞吐量、查询延迟、数据保留策略和可扩展性，这些指标反映了GaussDB-Influx在处理大规模时序数据存储和查询时的性能表现和可靠性。


## 配置 {#config}

### 安装 Func

推荐开通 {{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步华为云 DIS 的监控数据，我们安装对应的采集脚本：「{{{ custom_key.brand_name }}}集成（华为云-GaussDB-Influx采集）」(ID：`guance_huaweicloud_gaussdb_influx`)

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

脚本安装完后，在Func中「开发」里找到脚本「{{{ custom_key.brand_name }}}集成（华为云-GaussDB-Influx采集）」，展开修改此脚本，找到`collector_configs`和`monitor_configs`分别编辑下面`region_projects`中的内容，将地域和Project ID,更改为实际的地域和 Project ID，再点击保存发布。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-huaweicloud-ces/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在{{{ custom_key.brand_name }}}平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在{{{ custom_key.brand_name }}}平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好华为云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [华为云云监控指标详情](https://support.huaweicloud.com/influxug-nosql/nosql_09_0036.html){:target="_blank"}

| 指标ID                                | 指标名称             | 指标含义                                                     | 取值范围      | 测量对象 | 监控周期（原始指标）|
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| `nosql001_cpu_usage`       | CPU利用率      | 该指标为从系统层面采集的CPU使用率。 单位：%                  | 0~100 %  | GaussDB(for Influx)实例的节点 | 1分钟                                             |
| `nosql002_mem_usage`       | 内存利用率     | 该指标为从系统层面采集的内存使用率。 单位：%                 | 0~100 %  | GaussDB(for Influx)实例的节点 | 1分钟                |
| `nosql003_bytes_out`       | 网络输出吞吐量 | 统计平均每秒从测量对象的所有网络适配器输出的流量。单位：kb/s | ≥ 0 kb/s | GaussDB(for Influx)实例的节点 | 1分钟                |
| `nosql004_bytes_in`        | 网络输入吞吐量 | 统计平均每秒从测量对象的所有网络适配器输入的流量。 单位：kb/s | ≥ 0 kb/s | GaussDB(for Influx)实例的节点 | 1分钟                |
| `nosql005_disk_usage`      | 磁盘利用率     | 该指标用于统计测量对象的磁盘利用率。 单位：%                 | 0~100 %  | GaussDB(for Influx)实例的节点 | 1分钟                |
| `nosql006_disk_total_size` | 磁盘总大小     | 该指标用于统计测量对象的磁盘总大小。 单位：GB                | ≥ 0 GB   | GaussDB(for Influx)实例的节点 | 1分钟                |
| `nosql007_disk_used_size`  | 磁盘使用量     | 该指标用于统计测量对象的磁盘已使用总大小。 单位：GB          | ≥ 0 GB   | GaussDB(for Influx)实例的节点 | 1分钟                |
| `influxdb001_series_num` | 时间线数量 | 描述总的时间线数量。 单位：Counts | ≥ 0 Counts | GaussDB(for Influx)实例的节点 | 1分钟 |
| `influxdb002_query_req_ps` | 每秒查询请求 | 描述每秒查询请求的数量。 单位：Counts/s | ≥ 0 Counts/s | GaussDB(for Influx)实例的节点 | 1分钟 |
| `influxdb003_write_req_ps` | 每秒写入请求 | 描述每秒写入请求的数量。 单位：Counts/s | ≥ 0 Counts/s | GaussDB(for Influx)实例的节点 | 1分钟 |
| `influxdb004_write_points_ps` | 写入数据点 | 描述每秒写入的数据点数量。 单位：Counts/s | ≥ 0 Counts/s | GaussDB(for Influx)实例的节点 | 1分钟 |
| `influxdb005_write_concurrency` | 写入并发量 | 描述并发写入的请求数量。 单位：Counts | ≥ 0 Counts | GaussDB(for Influx)实例的节点 | 1分钟 |
| `influxdb006_query_concurrency` | 查询并发量 | 描述并发查询的请求数量。 单位：Counts | ≥ 0 Counts | GaussDB(for Influx)实例的节点 | 1分钟 |

## 对象 {#object}

采集到的华为云 GaussDB-Influx 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

``` json
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
> 提示 2：以下字段均为 JSON 序列化后字符串
>
> - `fields.message`
> - `fields.backup_strategy`
> - `fields.datastore`
> - `fields.groups`
> - `fields.actions`



