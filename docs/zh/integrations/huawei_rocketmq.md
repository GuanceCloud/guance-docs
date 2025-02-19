---
title: '华为云 DMS RocketMQ'
tags: 
  - 华为云
summary: '使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云。'
__int_icon: 'icon/huawei_rocketmq'
dashboard:
  - desc: '华为云 RocketMQ 内置视图'
    path: 'dashboard/zh/huawei_rocketmq/'

monitor:
  - desc: '华为云 RocketMQ 监控器'
    path: 'monitor/zh/huawei_rocketmq/'
---


<!-- markdownlint-disable MD025 -->
# 华为云 DMS RocketMQ
<!-- markdownlint-enable -->

使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云。

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署Func](https://func.guance.com/doc/script-market-guance-integration/)

> 推荐部署GSE版

### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 RocketMQ 云资源的监控数据，我们安装对应的采集脚本：「观测云集成（华为云- RocketMQ）」(ID：`guance_huaweicloud_rocketmq`)

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

脚本安装完后，在 Func 中「开发」里找到脚本「观测云集成（华为云- RocketMQ）」，展开修改此脚本，找到 collector_configs 和monitor_configs 分别编辑下面region_projects中的内容，将地域和 Project ID,更改为实际的地域和 Project ID，再点击保存发布。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-huaweicloud-rocketmq/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好华为云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [华为云云监控指标详情](https://support.huaweicloud.com/usermanual-hrm/hrm-ug-018.html){:target="_blank"}

| **指标ID**            |          **指标名称**   | **指标含义** | **取值范围**      | **测量对象** | **监控周期（原始指标）** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| instance_produce_msg |        消息生产数        | 实例一分钟收到的消息数单位：Count | >0 | RocketMQ实例     | 1分钟    |
| instance_consume_msg | 消息消费数 | 实例一分钟被消费的消息数单位：Count | >0 | RocketMQ实例     | 1分钟 |
| current_topics | 主题数 | 实例的主题数量单位：Count![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >=0 | RocketMQ实例     | 1分钟 |
| current_queues | 队列数 | 实例的队列数量单位：Count![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >=0 | RocketMQ实例     | 1分钟 |
| instance_accumulation | 堆积消息数 | 实例所有消费组堆积消息数量之和单位：Count![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >=0 | RocketMQ实例     | 1分钟 |
| broker_produce_msg | 消息生产数 | 节点一分钟收到的消息数单位：Count | >0 | RocketMQ实例节点 | 1分钟 |
| broker_consume_msg | 消息消费数 | 节点一分钟被消费的消息数单位：Count | >0 | RocketMQ实例节点 | 1分钟 |
| broker_produce_rate | 消息生产速率 | 节点每秒收到的消息数单位：Count/s | >0 | RocketMQ实例节点 | 1分钟 |
| broker_consume_rate | 消息消费速率 | 节点每秒被消费的消息数单位：Count/s | >0 | RocketMQ实例节点 | 1分钟 |
| broker_total_bytes_in_rate | 网络入流量 | 节点每秒网络访问流入流量单位：Byte/s | >0 | RocketMQ实例节点 | 1分钟 |
| broker_total_bytes_out_rate | 网络出流量 | 节点每秒网络访问流出流量单位：Byte/s | >0 | RocketMQ实例节点 | 1分钟 |
| broker_cpu_core_load | CPU核均负载 | 该指标用于统计节点虚拟机CPU每个核的平均负载 | >0 | RocketMQ实例节点 | 1分钟 |
| broker_disk_usage | 磁盘容量使用率 | 该指标用于统计节点虚拟机的磁盘容量使用率单位：% | 0~100 | RocketMQ实例节点 | 1分钟 |
| broker_memory_usage | 内存使用率 | 该指标用于统计节点虚拟机的内存使用率单位：% | 0~100 | RocketMQ实例节点 | 1分钟 |
| broker_alive | 节点存活状态 | 节点存活状态![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**说明：**2022年5月16号及以后购买的实例，支持此监控项。 | 1：存活0：离线 | RocketMQ实例节点 | 1分钟 |
| broker_connections | 连接数 | 虚拟机使用的连接数单位：Count![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >=0 | RocketMQ实例节点 | 1分钟 |
| broker_cpu_usage | CPU使用率 | 虚拟机的CPU使用率单位：%![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >=0 | RocketMQ实例节点 | 1分钟 |
| broker_disk_read_rate | 磁盘读流量 | 磁盘读操作流量单位：Byte/s![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >=0 | RocketMQ实例节点 | 1分钟 |
| broker_disk_write_rate | 磁盘写流量 | 磁盘写操作流量单位：Byte/s![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >=0 | RocketMQ实例节点 | 1分钟 |
| topic_produce_msg | 消息生产数 | Topic一分钟收到的消息数单位：Count | >0 | RocketMQ实例队列 | 1分钟 |
| topic_consume_msg | 消息消费数 | Topic一分钟被消费的消息数单位：Count | >0 | RocketMQ实例队列 | 1分钟 |
| topic_produce_rate | 消息生产速率 | Topic每秒收到的消息数单位：Count/s | >0 | RocketMQ实例队列 | 1分钟 |
| topic_consume_rate | 消息消费速率 | Topic每秒被消费的消息数单位：Count/s | >0 | RocketMQ实例队列 | 1分钟 |
| topic_bytes_in_rate | 生产流量 | 当前主题的生产流量单位：Byte/s![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >=0 | RocketMQ实例队列 | 1分钟 |
| topic_bytes_out_rate | 消费流量 | 当前主题的消费流量单位：Byte/s![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**说明：**2022年5月16号及以后购买的实例，支持此监控项。 | >=0 | RocketMQ实例队列 | 1分钟 |

## 对象 {#object}

数据正常同步后，可以在观测云的「基础设施 / 自定义（对象）」中查看数据。

```json
{
  "measurement": "huaweicloud_rocketmq",
  "tags": {      
    "RegionId"      : "cn-north-4",
    "charging_mode" : "1",
    "engine"        : "reliability",
    "engine_version": "4.8.0",
    "instance_id"   : "c0b0ea90-xxxx-xxxx-xxxx-cba3d38cf2f9",
    "instance_name" : "rocketmq-xxxxx",
    "name"          : "c0b0ea90-xxxx-xxxx-xxxx-cba3d38cf2f9",
    "status"        : "RUNNING",
    "type"          : "cluster.small"
  },
  "fields": {
    "created_at"         : "1687158517888",
    "description"        : "",
    "enable_publicip"    : false,
    "maintain_begin"     : "02:00:00",
    "maintain_end"       : "06:00:00",
    "resource_spec_code" : "",
    "specification"      : "rocketmq.4u8g.cluster.small * 1 broker",
    "storage_space"      : 250,
    "total_storage_space": 300,
    "used_storage_space" : 0,
    "message"            : "{实例 JSON 数据}"
  }
}
```

部分字段说明如下：

| 字段                 | 类型   | 说明                                                         |
| :------------------- | :----- | :----------------------------------------------------------- |
| `specification`      | String | 实例规格。                                                   |
| `charging_mode`      | String | 付费模式，1表示按需计费，0表示包年/包月计费。                |
| `created_at`         | String | 完成创建时间。格式为时间戳，指从格林威治时间 1970年01月01日00时00分00秒起至指定时间的偏差总毫秒数。 |
| `resource_spec_code` | String | 资源规格                                                     |
| `maintain_begin`     | String | 维护时间窗开始时间，格式为HH:mm:ss                           |
| `maintain_end`       | String | 维护时间窗结束时间，格式为HH:mm:ss                           |

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
>
> 提示 2：
>
> - fields.message`、`fields.listeners`为 JSON 序列化后字符串。
> - `tags.operating_status`为负载均衡器的操作状态。取值范围：可以为 ONLINE 和 FROZEN。

