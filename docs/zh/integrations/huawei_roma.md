---
title: '华为云 ROMA'
tags: 
  - 华为云
summary: '使用脚本市场中「{{{ custom_key.brand_name }}}云同步」系列脚本包把云监控 云资产的数据同步到{{{ custom_key.brand_name }}}'
__int_icon: 'icon/huawei_roma'
dashboard:
  - desc: '华为云 ROMA for Kafka'
    path: 'dashboard/zh/huawei_roma_kafka'


---


<!-- markdownlint-disable MD025 -->
# 华为云 ROMA
<!-- markdownlint-enable -->

使用脚本市场中「{{{ custom_key.brand_name }}}云同步」系列脚本包把云监控 云资产的数据同步到{{{ custom_key.brand_name }}}。


## 配置 {#config}

### 安装 Func

推荐开通 {{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步华为云 ROMA 的监控数据，我们安装对应的采集脚本：通过访问 func 的 web 服务进入【脚本市场】，「{{{ custom_key.brand_name }}}集成（华为云-ROMA 采集）」(ID：`guance_huaweicloud_roma`)

点击【安装】后，输入相应的参数：华为云 AK、SK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

脚本安装完后，在 Func 中「开发」里找到脚本「{{{ custom_key.brand_name }}}集成（华为云-Kafka 采集）」，展开修改此脚本，找到 collector_configs 和 monitor_configs 分别编辑下面region_projects 中的内容，将地域和 Project ID,更改为实际的地域和 Project ID，再点击保存发布。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。



### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在{{{ custom_key.brand_name }}}平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在{{{ custom_key.brand_name }}}平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置华为云-`ROMA` 采集,默认的指标集如下, 可以通过配置的方式采集更多的指标 [华为云ROMA指标详情](https://support.huaweicloud.com/usermanual-roma/roma_03_0023.html#section4){:target="_blank"}

### 实例监控指标

| 指标名称  | 指标含义  | 单位  |  维度  |
| -------- | -------- | -------- | -------- |
| current_partitions | 该指标用于统计Kafka实例中已经使用的分区数量 | Count | instance_id |
| current_topics | 该指标用于统计Kafka实例中已经创建的主题数量 | Count | instance_id |
| group_msgs | 该指标用于统计Kafka实例中所有消费组中总堆积消息数 | Count | instance_id |

### 节点监控指标
| 指标名称  | 指标含义  | 单位  |  维度  |
| -------- | -------- | -------- | -------- |
| broker_data_size | 该指标用于统计节点当前的消息数据大小 | Byte | instance_id |
| broker_messages_in_rate | 该指标用于统计每秒生产的消息数量 | Count/s | instance_id |
| broker_bytes_in_rate | 该指标用于统计每秒生产的字节数 | Byte/s | instance_id |
| broker_bytes_out_rate | 该指标用于统计每秒消费的字节数 | Byte/s | instance_id |
| broker_public_bytes_in_rate | 统计Broker节点每秒公网访问流入流量 | Byte/s | instance_id |
| broker_public_bytes_out_rate | 统计Broker节点每秒公网访问流出流量 | Byte/s | instance_id |
| broker_fetch_mean | 统计Broker节点处理消费请求平均时长 | ms | instance_id |
| broker_produce_mean | 生产请求平均处理时长 | ms | instance_id |
| broker_cpu_core_load | Kafka节点虚拟机层面采集的CPU每个核的平均负载 | % | instance_id |
| broker_disk_usage | Kafka节点虚拟机层面采集的磁盘容量使用率 | % | instance_id |
| broker_memory_usage | Kafka节点虚拟机层面采集的内存使用率 | % | instance_id |
| broker_heap_usage | Kafka节点Kafka进程JVM中采集的堆内存使用率 | % | instance_id |
| broker_alive | 表示Kafka节点是否存活 | 1：存活 0：离线 | instance_id |
| broker_connections | Kafka节点当前所有TCP连接数量 | Count | instance_id |
| broker_cpu_usage | Kafka节点虚拟机的CPU使用率 | % | instance_id |
| broker_total_bytes_in_rate | Broker节点每秒网络访问流入流量 | Byte/s | instance_id |
| broker_total_bytes_out_rate | Broker节点每秒网络访问流出流量 | Byte/s | instance_id |
| broker_disk_read_rate | 磁盘读操作流量 | Byte/s | instance_id |
| broker_disk_write_rate | 磁盘写操作流量 | Byte/s | instance_id |
| network_bandwidth_usage | 网络带宽利用率 | % | instance_id |

### 消费组监控指标
| 指标名称  | 指标含义  | 单位  |  维度  |
| -------- | -------- | -------- | -------- |
| messages_consumed | 该指标用于统计当前消费组已经消费的消息个数 | Count | instance_id |
| messages_remained | 该指标用于统计消费组可消费的消息个数 | Count | instance_id |
| topic_messages_remained | 该指标用于统计消费组指定队列可以消费的消息个数 | Count | instance_id |
| topic_messages_consumed | 该指标用于统计消费组指定队列当前已经消费的消息数 | Count | instance_id |
| consumer_messages_remained | 该指标用于统计消费组剩余可以消费的消息个数 | Count | instance_id |
| consumer_messages_consumed | 该指标用于统计消费组当前已经消费的消息数 | Count | instance_id |


## 对象 {#object}

采集到的华为云 ROMA 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "huaweicloud_SYS.ROMA",
  "tags": {      
    "RegionId"           : "cn-north-4",
    "charging_mode"      : "1",
    "connect_address"    : "192.168.0.161,192.168.0.126,192.168.0.31",
    "description"        : "",
    "engine"             : "kafka",
    "engine_version"     : "2.7",
    "instance_id"        : "beb33e02-xxxx-xxxx-xxxx-628a3994fd1f",
    "kafka_manager_user" : "",
    "name"               : "beb33e02-xxxx-xxxx-xxxx-628a3994fd1f",
    "port"               : "9092",
    "project_id"         : "f5f4c067d68xxxx86e173b18367bf",
    "resource_spec_code" : "",
    "service_type"       : "advanced",
    "specification"      : "kafka.2u4g.cluster.small * 3 broker",
    "status"             : "RUNNING",
    "storage_type"       : "hec",
    "user_id"            : "e4b27d49128e4bd0893b28d032a2e7c0",
    "user_name"          : "xxxx"
  },
  "fields": {
    "created_at"          : "1693203968959",
    "maintain_begin"      : "02:00:00",
    "maintain_end"        : "06:00:00",
    "storage_space"       : 186,
    "total_storage_space" : 300,
    "message"             : "{实例 JSON 数据}"
  }
}

```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
>
> 提示 2：以下字段均为 JSON 序列化后字符串

