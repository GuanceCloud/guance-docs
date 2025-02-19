---
title: '华为云 GaussDB-Redis'
tags: 
  - 华为云
summary: '华为云GaussDB-Redis的展示指标包括读写吞吐量、响应时间、并发连接数和数据持久性，这些指标反映了GaussDB-Redis在处理高并发数据存储和缓存时的性能表现和可靠性。'
__int_icon: 'icon/huawei_gaussdb_redis'
dashboard:

  - desc: '华为云 GaussDB for Redis 内置视图'
    path: 'dashboard/zh/huawei_gaussdb_redis'

monitor:
  - desc: '华为云 GaussDB for Redis 监控器'
    path: 'monitor/zh/huawei_gaussdb_redis'

---


<!-- markdownlint-disable MD025 -->
# 华为云 GaussDB-Redis
<!-- markdownlint-enable -->

华为云GaussDB-Redis的展示指标包括读写吞吐量、响应时间、并发连接数和数据持久性，这些指标反映了GaussDB-Redis在处理高并发数据存储和缓存时的性能表现和可靠性。


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步华为云 GaussDB-Redis 的监控数据，我们安装对应的采集脚本：「观测云集成（华为云-GaussDB-Redis 采集）」(ID：`guance_huaweicloud_gaussdb_redis`)

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

脚本安装完后，在Func中「开发」里找到脚本「观测云集成（华为云-GaussDB-Redis 采集）」，展开修改此脚本，找到`collector_configs`和`monitor_configs`分别编辑下面`region_projects`中的内容，将地域和Project ID,更改为实际的地域和 Project ID，再点击保存发布。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-huaweicloud-ces/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好华为云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [华为云云监控指标详情](https://support.huaweicloud.com/redisug-nosql/nosql_10_0036.html){:target="_blank"}

| 指标名称 | 描述 | 单位 | 维度 |
| :---: | :---: | :---: | :---: |
| `nosql001_cpu_usage` | CPU利用率 | % | redis_node_id |
| `nosql002_mem_usage` | 内存利用率 | % | redis_node_id |
| `nosql005_disk_usage` | 磁盘利用率 | % | redis_node_id |
| `nosql006_disk_total_size` | 磁盘总容量 | GB | redis_node_id |
| `nosql007_disk_used_size` | 磁盘使用量 | GB | redis_node_id |
| `redis017_proxy_accept` | proxy接收的客户端总数 | count | redis_node_id |
| `redis018_proxy_request_ps` | proxy的接收请求速率 | counts/s | redis_node_id |
| `redis019_proxy_response_ps` | proxy的返回请求速率 | count/s | redis_node_id |
| `redis020_proxy_recv_client_bps` | proxy接收客户端字节流的速率 | bytes/s | redis_node_id |
| `redis021_proxy_send_client_bps` | proxy发送给客户端字节流的速率 | bytes/s | redis_node_id |
| `redis032_shard_qps` | shard的qps | count | redis_node_id |
| `Invocationredis064_get_avg_usecs` | proxy执行命令“get”的平均时延 | μs | redis_node_id |
| `redis065_get_max_usec` | proxy执行命令“get”的最大时延 | μs | redis_node_id |
| `redis066_get_p99` | proxy执行命令“get”的p99时延 | μs | redis_node_id |
| `redis067_get_qps` | proxy执行命令“get”的速率 | count/s | redis_node_id |
| `redis316_all_avg_usec` | proxy执行所有命令的平均时延 | μs | redis_node_id |
| `redis317_all_max_usec` | proxy执行所有命令的最大时延 | μs | redis_node_id |
| `redis318_all_p99` | proxy执行所有命令的p99时延 | μs | redis_node_id |
| `redis319_all_qps` | proxy执行所有命令的速率 | count/s | redis_node_id |
| `redis669_connection_usage` | 连接数使用率 | % | redis_node_id |
| `redis670_hit_rate` | 命中率 | % | redis_node_id |


## 对象 {#object}

采集到的华为云 GaussDB-Redis 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

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
> 提示 2：以下字段均为 JSON 序列化后字符串
>
> - `fields.message`
> - `fields.backup_strategy`
> - `fields.datastore`
> - `fields.groups`
> - `fields.actions`



