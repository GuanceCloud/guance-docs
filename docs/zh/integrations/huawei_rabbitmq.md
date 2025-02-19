---
title: '华为云 DMS RabbitMQ'
tags: 
  - 华为云
summary: '使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云。'
__int_icon: 'icon/huawei_rabbitmq'
dashboard:
  - desc: '华为云 RocketMQ 内置视图'
    path: 'dashboard/zh/huawei_rabbitmq/'

monitor:
  - desc: '华为云 RocketMQ 监控器'
    path: 'monitor/zh/huawei_rabbitmq/'
---


<!-- markdownlint-disable MD025 -->
# 华为云 DMS RabbitMQ
<!-- markdownlint-enable -->

使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云。

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署Func](https://func.guance.com/doc/script-market-guance-integration/)

> 推荐部署GSE版

### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 RabbitMQ 云资源的监控数据，我们安装对应的采集脚本：「观测云集成（华为云- RabbitMQ）」(ID：`guance_huaweicloud_rabbitmq`)

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

脚本安装完后，在Func中「开发」里找到脚本「观测云集成（华为云- RabbitMQ）」，展开修改此脚本，找到`collector_configs`将`regions`后的地域换成自己实际的地域，再找到`monitor_configs`下面的`region_projects`,更改为实际的地域和Project ID。再点击保存发布

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-huaweicloud-rabbitmq/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好华为云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [华为云云监控指标详情](https://support.huaweicloud.com/usermanual-rabbitmq/rabbitmq-ug-180413002.html){:target="_blank"}


| **指标ID**            |          **指标名称**   | **指标含义** | **取值范围**      | **测量对象** | **监控周期（原始指标）** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| `connections` |        连接数        | 该指标用于统计**RabbitMQ**实例中的总连接数。单位：Count      | >= 0               | **RabbitMQ**实例 | 1分钟                    |
| `channels`                      |        通道数        | 该指标用于统计**RabbitMQ**实例中的总通道数。单位：Count      | 0~2047             | **RabbitMQ**实例 | 1分钟                    |
| `queues`                        |        队列数        | 该指标用于统计**RabbitMQ**实例中的总队列数。单位：Count      | 0~1200             | **RabbitMQ**实例 | 1分钟                    |
| `consumers`                     |       消费者数       | 该指标用于统计**RabbitMQ**实例中的总消费者数。单位：Count    | 0~1200             | **RabbitMQ实例** | 1分钟                    |
| `messages_ready`                |     可消费消息数     | 该指标用于统计**RabbitMQ**实例中总可消费消息数量。单位：Count | 0~10000000         | **RabbitMQ**实例 | 1分钟                    |
| `messages_unacknowledged`       |     未确认消息数     | 该指标用于统计**RabbitMQ**实例中总已经消费但还未确认的消息数量。单位：Count | 0~10000000         | **RabbitMQ**实例 | 1分钟                    |
| `publish`                       |       生产速率       | 统计**RabbitMQ**实例中实时消息生产速率。单位：Count/s        | 0~25000            | **RabbitMQ**实例 | 1分钟                    |
| `deliver`                       | 消费速率（手工确认） | 统计**RabbitMQ**实例中实时消息消费速率（手工确认）。单位：Count/s | 0~25000            | **RabbitMQ**实例 | 1分钟                    |
| `deliver_no_ack`                | 消费速率（自动确认） | 统计**RabbitMQ**实例中实时消息消费速率（自动确认）。单位：Count/s | 0~50000            | **RabbitMQ**实例 | 1分钟                    |
| `connections_states_running`    |  运行状态的连接个数  | 该指标用于统计整个实例中的connection，状态是starting/tuning/opening/running状态的总数。单位：Count**说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >= 0               | **RabbitMQ**实例 | 1分钟                    |
| `connections_states_flow`       |   flow状态的连接数   | 该指标用于统计整个实例中的connection，状态是flow状态的总数。单位：Count **说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >= 0               | **RabbitMQ**实例 | 1分钟                    |
| `connections_states_block`      |  block状态的连接数   | 该指标用于统计整个实例中的connection，状态是blocking/blocked状态的总数。单位：Count **说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >= 0               | **RabbitMQ**实例 | 1分钟                    |
| `connections_states_close`      |  close状态的连接数   | 该指标用于统计整个实例中的connection，状态是closing/closed状态的总数。单位：Count **说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >= 0               | **RabbitMQ**实例 | 1分钟                    |
| `channels_states_running`       |   运行状态的通道数   | 该指标用于统计整个实例中的channel，状态是starting/tuning/opening/running状态的总数。单位：Count **说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >= 0               | **RabbitMQ**实例 | 1分钟                    |
| `channels_states_flow`          |   flow状态的通道数   | 该指标用于统计整个实例中的channel，状态是flow状态的总数。单位：Count **说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >= 0               | **RabbitMQ**实例 | 1分钟                    |
| `channels_states_block`         |  block状态的通道数   | 该指标用于统计整个实例中的channel，状态是blocking/blocked状态的总数。单位：Count **说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >= 0               | **RabbitMQ**实例 | 1分钟                    |
| `channels_states_close`         |  close状态的通道数   | 该指标用于统计整个实例中的channel，状态是closing/closed状态的总数。单位：Count **说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >= 0               | **RabbitMQ**实例 | 1分钟                    |
| `queues_states_running`         |   运行状态的队列数   | 该指标用于统计整个实例中的queue，状态是running状态的总数。单位：Count **说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >= 0               | **RabbitMQ**实例 | 1分钟                    |
| `queues_states_flow`            |   flow状态的队列数   | 该指标用于统计整个实例中的queue，状态是flow状态的总数。单位：Count **说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >= 0               | **RabbitMQ**实例 | 1分钟                    |
| `fd_used`                       |      文件句柄数      | 该指标用于统计当前节点RabbitMQ所占用的文件句柄数。单位：Count | 0~65535            | **RabbitMQ**实例节点 | 1分钟                    |
| `socket_used`                   |     Socket连接数     | 该指标用于统计当前节点**RabbitMQ**所使用的Socket连接数。单位：Count | 0~50000            | **RabbitMQ**实例节点 | 1分钟                    |
| `proc_used`                     |     Erlang进程数     | 该指标用于统计当前节点**RabbitMQ**所使用的Erlang进程数。单位：Count | 0~1048576          | **RabbitMQ**实例节点 | 1分钟                    |
| `mem_used`                      |       内存占用       | 该指标用于统计当前节点RabbitMQ内存占用。单位：Byte           | 0~32000000000      | **RabbitMQ**实例节点 | 1分钟                    |
| `disk_free`                     |     可用存储空间     | 该指标用于统计当前节点可使用的存储空间。单位：Byte           | 0~500000000000     | **RabbitMQ**实例节点 | 1分钟                    |
| `rabbitmq_alive`                |     节点存活状态     | 表示RabbitMQ节点是否存活。**说明：**2020年4月及以后购买的实例，支持此监控项。 | 1：存活0：离线     | **RabbitMQ**实例节点 | 1分钟                    |
| `rabbitmq_disk_usage`           |    磁盘容量使用率    | 统计RabbitMQ节点虚拟机的磁盘容量使用率。单位：% **说明：**2020年4月及以后购买的实例，支持此监控项。 | 0~100%             | RabbitMQ实例节点 | 1分钟                    |
| `rabbitmq_cpu_usage`            |      CPU使用率       | 统计RabbitMQ节点虚拟机的CPU使用率。单位：% **说明：**2020年4月及以后购买的实例，支持此监控项。 | 0~100%             | RabbitMQ实例节点 | 1分钟                    |
| `rabbitmq_cpu_core_load`        |     CPU核均负载      | 统计RabbitMQ节点虚拟机CPU每个核的平均负载。 **说明：**2020年4月及以后购买的实例，支持此监控项。 | >0                 | RabbitMQ实例节点 | 1分钟                    |
| `rabbitmq_memory_usage`         |      内存使用率      | 统计RabbitMQ节点虚拟机的内存使用率。单位：% **说明：**2020年4月及以后购买的实例，支持此监控项。 | 0~100%             | RabbitMQ实例节点 | 1分钟                    |
| `rabbitmq_disk_read_await`      |  磁盘平均读操作耗时  | 该指标用于统计磁盘在测量周期内平均每个读IO的操作时长。单位：ms **说明：**2020年6月及以后购买的实例，支持此监控项。 | >0                 | RabbitMQ实例节点 | 1分钟                    |
| `rabbitmq_disk_write_await`     |  磁盘平均写操作耗时  | 该指标用于统计磁盘在测量周期内平均每个写IO的操作时长。单位：ms **说明：**2020年6月及以后购买的实例，支持此监控项。 | >0                 | RabbitMQ实例节点 | 1分钟                    |
| `rabbitmq_node_bytes_in_rate`   |      网络入流量      | 统计RabbitMQ节点每秒网络访问流入流量。单位：Byte/s **说明：**2020年6月及以后购买的实例，支持此监控项。 | >0                 | RabbitMQ实例节点 | 1分钟                    |
| `rabbitmq_node_bytes_out_rate`  |      网络出流量      | 统计RabbitMQ节点每秒网络访问流出流量。单位：Byte/s **说明：**2020年6月及以后购买的实例，支持此监控项。 | >0                 | RabbitMQ实例节点 | 1分钟                    |
| `rabbitmq_node_queues`          |      节点队列数      | 该指标用于统计RabbitMQ节点队列个数。单位：个  **说明：**2020年6月及以后购买的实例，支持此监控项。 | >0                 | RabbitMQ实例节点 | 1分钟                    |
| `rabbitmq_memory_high_watermark` |    内存高水位状态    | 表示RabbitMQ节点是否触发内存高水位，如果触发，会阻塞集群的所有生产者。**说明：**2020年6月及以后购买的实例，支持此监控项。 | 1：触发0：没有触发 | RabbitMQ实例节点 | 1分钟                    |
| `rabbitmq_disk_insufficient`    |    磁盘高水位状态    | 表示RabbitMQ节点是否触发磁盘高水位，如果触发，会阻塞集群的所有生产者。**说明：**2020年6月及以后购买的实例，支持此监控项。 | 1：触发0：没有触发 | RabbitMQ实例节点 | 1分钟                    |
| `rabbitmq_disk_read_rate`       |      磁盘读流量      | 统计节点磁盘每秒的读字节大小。单位：KB/s **说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >= 0               | RabbitMQ实例节点 | 1分钟                    |
| `rabbitmq_disk_write_rate`      |      磁盘写流量      | 统计节点磁盘每秒的写字节大小。单位：KB/s **说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >= 0               | RabbitMQ实例节点 | 1分钟                    |
| `queue_messages_unacknowledged` |   队列未确认消息数   | 该指标用于统计队列中已消费未确认消息数。单位：Count          | 0~10000000         | RabbitMQ实例队列 | 1分钟                    |
| `queue_messages_ready`          |   队列可消费消息数   | 该指标用于统计队列中可消费的消息数。单位：Count              | 0~10000000         | RabbitMQ实例队列 | 1分钟                    |
| `queue_consumers`               |      消费者数量      | 该指标用于统计订阅该队列的消费者个数。单位：Count **说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >= 0               | RabbitMQ实例队列 | 1分钟                    |
| `queue_messages_publish_rate`   |       生产速率       | 该指标用于统计每秒该队列的消息流入数。单位：Count/s **说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >= 0               | RabbitMQ实例队列 | 1分钟                    |
| `queue_messages_ack_rate`       | 消费速率（手工确认） | 该指标用于统计该队列每秒传递给客户端并确认的消息数。单位：Count/s **说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >= 0               | RabbitMQ实例队列 | 1分钟                    |
| `queue_messages_deliver_get_rate` |       消费速率       | 该指标用于统计该队列每秒的消息流出数。单位：Count/s **说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >= 0               | RabbitMQ实例队列 | 1分钟                    |
| `queue_messages_redeliver_rate` |       重传速率       | 该指标用于统计该队列每秒的重传消息数。单位：Count/s **说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >= 0               | RabbitMQ实例队列 | 1分钟                    |
| `queue_messages_persistent`     |  消息总数（持久化）  | 该指标用来统计该队列中持久消息的总数（对于瞬时队列始终为0）。单位：Count **说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >= 0               | RabbitMQ实例队列 | 1分钟                    |
| `queue_messages_ram`            |   消息总数（内存）   | 该指标用于统计该队列中驻留在内存中的消息总数。单位：Count **说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >= 0               | RabbitMQ实例队列 | 1分钟                    |
| `queue_memory`                  | Erlang进程消耗字节数 | 该指标用于统计与队列关联的Erlang进程消耗的内存字节数，包括堆栈、堆和内部结构。单位：Byte **说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >= 0               | RabbitMQ实例队列 | 1分钟                    |
| `queue_message_bytes`           |     消息大小总和     | 该指标用于统计该队列中所有消息的大小总和（字节）。单位：Byte **说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >= 0               | RabbitMQ实例队列 | 1分钟                    |

## 对象 {#object}

数据正常同步后，可以在观测云的「基础设施 / 自定义（对象）」中查看数据。

```json
{
  "measurement": "huaweicloud_rabbitmq",
  "tags": {      
    "RegionId"       : "cn-north-4",
    "charging_mode"  : "1",
    "connect_address": "192.xxx.0.xxx",
    "engine"         : "rabbitmq",
    "engine_version" : "3.8.35",
    "instance_id"    : "f127cbb0-xxxx-xxxx-xxxx-aed5a36da5d9",
    "instance_name"  : "rabbitmq-xxxx",
    "name"           : "f127cbb0-xxxx-xxxx-xxxx-aed5a36da5d9",
    "status"         : "RUNNING",
    "port"           : "xxxx"
  },
  "fields": {
    "access_user"               : "rabbit_mh",
    "available_zones"           : "[实例 JSON 数据]",
    "connect_address"           : "192.xxx.0.xxx",
    "created_at"                : "1687143955266",
    "description"               : "",
    "enable_publicip"           : false,
    "maintain_begin"            : "02:00:00",
    "maintain_end"              : "06:00:00",
    "management_connect_address": "http://192.xxx.0.xxx:15672",
    "resource_spec_code"        : "",
    "specification"             : "rabbitmq.2u4g.single * 1 broker",
    "storage_space"             : 83,
    "total_storage_space"       : 100,
    "used_storage_space"        : 0,
    "message"                   : "{实例 JSON 数据}"
  }
}

```

部分字段说明如下：

| 字段                 | 类型   | 说明                                                         |
| :------------------- | :----- | :----------------------------------------------------------- |
| `specification`      | String | 实例规格。 RabbitMQ实例单机返回vm规格。 RabbitMQ实例集群返回vm规格和节点数。 |
| `charging_mode`      | String | 付费模式，1表示按需计费，0表示包年/包月计费。                |
| `available_zones`    | String | 实例节点所在的可用区，返回“可用区ID”。                       |
| `maintain_begin`     | String | 维护时间窗开始时间，格式为HH:mm:ss                           |
| `maintain_end`       | String | 维护时间窗结束时间，格式为HH:mm:ss                           |
| `created_at`         | String | 完成创建时间。格式为时间戳，指从格林威治时间 1970年01月01日00时00分00秒起至指定时间的偏差总毫秒数。 |
| `resource_spec_code` | String | 资源规格标识 `dms.instance.rabbitmq.single.c3.2u4g：`RabbitMQ单机，vm规格2u4g `dms.instance.rabbitmq.single.c3.4u8g`：RabbitMQ单机，vm规格4u8g `dms.instance.rabbitmq.single.c3.8u16g`：RabbitMQ单机，vm规格8u16g `dms.instance.rabbitmq.single.c3.16u32g`：RabbitMQ单机，vm规格16u32g `dms.instance.rabbitmq.cluster.c3.4u8g.3`：RabbitMQ集群，vm规格4u8g，3个节点 `dms.instance.rabbitmq.cluster.c3.4u8g.5`：RabbitMQ集群，vm规格4u8g，5个节点 `dms.instance.rabbitmq.cluster.c3.4u8g.7`：RabbitMQ集群，vm规格4u8g，7个节点 `dms.instance.rabbitmq.cluster.c3.8u16g.3`：RabbitMQ集群，vm规格8u16g，3个节点 `dms.instance.rabbitmq.cluster.c3.8u16g.5`：RabbitMQ集群，vm规格8u16g，5个节点 `dms.instance.rabbitmq.cluster.c3.8u16g.7`：RabbitMQ集群，vm规格8u16g，7个节点 `dms.instance.rabbitmq.cluster.c3.16u32g.3`：RabbitMQ集群，vm规格16u32g，3个节点 `dms.instance.rabbitmq.cluster.c3.16u32g.5`：RabbitMQ集群，vm规格16u32g，5个节点 `dms.instance.rabbitmq.cluster.c3.16u32g.7`：RabbitMQ集群，vm规格16u32g，7个节点 |



> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
>
> 提示 2：
>
> - fields.message`、`fields.listeners`为 JSON 序列化后字符串。
> - `tags.operating_status`为负载均衡器的操作状态。取值范围：可以为 ONLINE 和 FROZEN。

