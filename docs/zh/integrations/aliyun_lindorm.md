---
title: '阿里云 Lindorm'
tags: 
  - 阿里云
summary: '使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>。'
__int_icon: 'icon/aliyun_lindorm'
dashboard:
  - desc: '阿里云 Lindorm 内置视图'
    path: 'dashboard/zh/aliyun_lindorm/'

monitor:
  - desc: '阿里云 Lindorm 监控器'
    path: 'monitor/zh/aliyun_lindorm/'
---

<!-- markdownlint-disable MD025 -->
# 阿里云 `Lindorm`
<!-- markdownlint-enable -->


使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>。


## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 **Lindorm** 云资源的监控数据，我们安装对应的采集脚本：「<<< custom_key.brand_name >>>集成（阿里云-**Lindorm**采集）」(ID：`guance_aliyun_lindorm`)

点击【安装】后，输入相应的参数：阿里云 AK、阿里云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

> 如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。


我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好阿里云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [阿里云云监控指标详情](https://cms.console.aliyun.com/metric-meta/acs_lindorm/lindorm){:target="_blank"}

> 注意：需要在 Aliyun `Lindorm` 控制台安装监控插件

| MetricName | MetricDescribe           | Dimensions | Statistics | Unit | MinPeriods |
| ---- | :---:    | :----: | ------ | ------ | :----: |
| `load_one`                   | 每5分钟平均负载      | userId,instanceId,host | Average,Maximum,Minimum | load    |    60 s    |
| `load_five`                  | 每5分钟平均负载      | userId,instanceId,host | Average,Maximum,Minimum | load    |    60 s    |
| `cpu_system`                 | CPU利用率System      | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `cpu_user`                   | CPU利用率User        | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `cpu_idle`                   | CPU空闲率            | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `cpu_wio`                    | CPU利用率IOWait      | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `mem_total`                  | 内存总量(total)      | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `mem_used_percent`           | 内存使用比例         | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `mem_free`                   | 空闲内存大小(free)   | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `mem_buff_cache`             | 缓存大小(buff/cache) | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `mem_shared`                 | 共享内存大小(shared) | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `bytes_in`                   | 每秒网络流入量       | userId,instanceId,host | Average,Maximum,Minimum | bytes/s |    60 s    |
| `bytes_out`                  | 每秒网络流出量       | userId,instanceId,host | Average,Maximum,Minimum | bytes/s |    60 s    |
| `storage_used_percent`       | 存储空间使用比例     | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `storage_used_bytes`         | 存储空间使用量       | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `storage_total_bytes`        | 存储空间总量         | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `hot_storage_used_percent`   | 热存储使用比例       | userId,instanceId,host | Average,Maximum         | %       |    60 s    |
| `hot_storage_used_bytes`     | 热存储使用量         | userId,instanceId,host | Average,Maximum         | bytes   |    60 s    |
| `hot_storage_total_bytes`    | 热存储总容量         | userId,instanceId,host | Average,Maximum         | bytes   |    60 s    |
| `cold_storage_used_percent`  | 冷存储使用百分比     | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `cold_storage_used_bytes`    | 冷存储使用量         | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `cold_storage_total_bytes`   | 冷存储总容量         | userId,instanceId,host | Average,Maximum,Minimum | bytes   |    60 s    |
| `cold_storage_token_percent` | 冷存读令牌使用比例   | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `store_locality`             | 存储本地化率         | userId,instanceId,host | Average,Maximum,Minimum | %       |    60 s    |
| `disk_readbytes`             | 磁盘读流量           | userId,instanceId,host | Average,Maximum,Minimum | bytes/s |    60 s    |
| `disk_writebytes` | 磁盘写流量 | userId,instanceId,host | Average,Maximum,Minimum | bytes/s | 60 s |
| `table_cold_storage_used_bytes` | 宽表冷存储使用量 | userId,instanceId,host | Average,Maximum,Minimum | bytes | 60 s |
| `table_hot_storage_used_bytes` | 宽表热存储使用量 | userId,instanceId,host | Average,Maximum,Minimum | Byte | 60 s |
| `read_ops` | 读请求量 | userId,instanceId,host | Average,Maximum,Minimum | countS | 60 s |
| `read_rt` | 读平均RT | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `read_data_kb` | 读流量 | userId,instanceId,host | Average,Maximum,Minimum | KB/s | 60 s |
| `get_num_ops` | Get请求量 | userId,instanceId,host | Average,Maximum,Minimum | countS | 60 s |
| `get_rt_avg` | Get平均RT | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `get_rt_p99` | Get操作P99延迟 | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `scan_num_ops` | Scan请求量 | userId,instanceId,host | Average,Maximum,Minimum | countS | 60 s |
| `scan_rt_avg` | Scan平均延迟 | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `scan_rt_p99` | Scan P99延迟 | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `thrift_call_num_ops` | Thrift请求量 | userId,instanceId | Average | count | 60 s |
| `thrift_call_mean` | thrift请求平均耗时 | userId,instanceId | Average | milliseconds | 60 s |
| `thrift_call_time_in_queue_ops` | Thrift请求队列等待数量 | userId,instanceId | Average | count | 60 s |
| `thrift_call_time_in_queue` | thrift请求队列等待耗时 | userId,instanceId | Average | ms | 60 s |
| `write_ops` | 写请求量 | userId,instanceId,host | Average,Maximum,Minimum | countS | 60 s |
| `write_rt` | 写平均RT | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `write_data_kb` | 写流量 | userId,instanceId,host | Average,Maximum,Minimum | KB/s | 60 s |
| `put_num_ops` | Put请求量 | userId,instanceId,host | Average,Maximum,Minimum | countS | 60 s |
| `put_rt_avg` | Put平均RT | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `put_rt_p99` | Put P99延迟 | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `above_memstore_count` | 超过`memstore`上限次数 | userId,instanceId,host | Average,Maximum,Minimum | frequency | 60 s |
| `lql_connection` | `sql`连接数 | userId,instanceId,host | Average,Maximum | count | 60 s |
| `lql_select_ops` | select请求数 | userId,instanceId,host | Average,Maximum | countSecond | 60 s |
| `lql_upsert_avg_rt` | `upsert`请求平均耗时 | userId,instanceId,host | Average,Maximum | milliseconds | 60 s |
| `lql_upsert_ops` | `upsert`请求数 | userId,instanceId,host | Average,Maximum | countSecond | 60 s |
| `lql_select_p99_rt` | select p99 耗时 | userId,instanceId,host | Average,Maximum | milliseconds | 60 s |
| `lql_select_avg_rt` | select请求平均耗时 | userId,instanceId,host | Average,Maximum | milliseconds | 60 s |
| `lql_upsert_p99_rt` | `upsert` p99耗时 | userId,instanceId,host | Average,Maximum | milliseconds | 60 s |
| `lql_delete_ops` | delete请求数 | userId,instanceId,host | Average,Maximum | countSecond | 60 s |
| `lql_delete_avg_rt` | delete请求平均耗时 | userId,instanceId,host | Average,Maximum | milliseconds | 60 s |
| `lql_delete_p99_rt` | delete p99耗时 | userId,instanceId,host | Average,Maximum | milliseconds | 60 s |
| `regions_per_ldserver` | RegionServer管理Region个数 | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `handler_queue_size` | HandlerQueue长度 | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `compaction_queue_size` | Compaction队列长度 | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `tsdb_jvm_used_percent` | JVM内存使用率 | userId,instanceId,host | Average,Maximum,Minimum | % | 60 s |
| `tsdb_disk_used` | 磁盘使用量 | userId,instanceId,host | Average,Maximum,Minimum | `Gbyte` | 60 s |
| `tsdb_hot_storage_used_bytes` | 时序热存储使用量 | userId,instanceId,host | Average,Maximum,Minimum | bytes | 60 s |
| `tsdb_cold_storage_used_bytes` | 时序冷存储使用量 | userId,instanceId,host | Average,Maximum,Minimum | bytes | 60 s |
| `tsdb_datapoints_added` | 数据点数量 | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `search_cold_storage_used_bytes` | 搜索冷存储使用量 | userId,instanceId,host | Average,Maximum,Minimum | bytes | 60 s |
| `search_hot_storage_used_bytes` | 搜索热存储使用量 | userId,instanceId,host | Average,Maximum,Minimum | bytes | 60 s |
| `search_select_count` | select次数总计 | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `search_select_meanRate` | select平均ops | userId,instanceId,host | Average,Maximum,Minimum | countS | 60 s |
| `search_select_mean_rt` | select平均RT | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_select_p95_rt` | select p95 RT | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_select_p999_rt` | select p999 RT | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_select_p99_rt` | select p99 RT | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_update_count` | update次数总计 | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `search_update_meanRate` | update平均ops | userId,instanceId,host | Average,Maximum,Minimum | countS | 60 s |
| `search_update_mean_rt` | update平均RT | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_update_p95_rt` | update p95 RT | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_update_p99_rt` | update p99 RT | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `search_update_p999_rt` | update p999 RT | userId,instanceId,host | Average,Maximum,Minimum | milliseconds | 60 s |
| `worker_count` | 工作节点数量 | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `failed_job_count` | 失败任务数 | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `warn_job_count` | 异常任务数 | userId,instanceId,host | Average,Maximum,Minimum | count | 60 s |
| `task_delay_max` | 最大任务延迟 | userId,instanceId,host | Average,Maximum,Minimum | ms | 60 s |
## 对象 {#object}
采集到的阿里云 `Lindorm` 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

``` json
{
  "measurement": "aliyun_lindorm",
  "tags": {
    "name"           : "r-bp12xxxxxxx",
    "InstanceId"     : "r-bp12xxxxxxx",
    "InstanceStatus" : "CREATING",
    "NetworkType"    : "vpc",
    "PayType"        : "POSTPAY",
    "RegionId"       : "cn-hangzhou",
    "ServiceType"    : "lindorm_standalone",
    "VpcId"          : "vpc-bp1pxxxxxx4t75e73v",
    "ZoneId"         : "cn-hangzhou-f",
    "account_name"   : "xxx 账号",
    "cloud_provider" : "aliyun"
  },
  "fields": {
    "CreateTime"      : "2023-07-14 10:54:05",
    "EnableStream"    : "False",
    "InstanceStorage" : "20",
    "message"         : "{实例 JSON 数据}"
  }
}
```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
>
> 提示 2：`fields.message` 为 JSON 序列化后字符串
>
