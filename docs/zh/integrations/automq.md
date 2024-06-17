---
title     : 'AutoMQ'
summary   : '采集 AutoMQ 相关指标信息'
__int_icon: 'icon/automq'
dashboard :
  - desc  : 'AutoMQ Cluster'
    path  : 'dashboard/zh/automq_cluster'
  - desc  : 'AutoMQ Group'
    path  : 'dashboard/zh/automq_group'
  - desc  : 'AutoMQ Broker'
    path  : 'dashboard/zh/automq_broker'
  - desc  : 'AutoMQ Detailed'
    path  : 'dashboard/zh/automq_detailed'
  - desc  : 'AutoMQ Topics'
    path  : 'dashboard/zh/automq_topics'
monitor   :
  - desc  : 'AutoMQ'
    path  : 'monitor/zh/automq'
---

<!-- markdownlint-disable MD025 -->
# AutoMQ
<!-- markdownlint-enable -->

采集 AutoMQ 相关指标信息。

## 安装配置 {#config}

### AutoMQ 开启指标

调整 AutoMQ 启动命令

```shell
bin/kafka-server-start.sh ...\
--override  s3.telemetry.metrics.exporter.type=prometheus \
--override  s3.metrics.exporter.prom.port=8890  \
--override  s3.metrics.exporter.prom.host=0.0.0.0 \
......

```

AutoMQ 暴露指标端口为：`8890`，可通过浏览器查看指标相关信息：`http://clientIP:8890/metrics`。

### DataKit 采集器配置

由于`AutoMQ`能够直接暴露`metrics` url，所以可以直接通过[`prom`](./prom.md)采集器进行采集。



调整内容如下：

```toml

  urls = ["http://clientIP:8890/metrics"]
  source = "AutoMQ"

  ## Keep Exist Metric Name
  ## If the keep_exist_metric_name is true, keep the raw value for field names.
  keep_exist_metric_name = true

  [inputs.prom.tags_rename]
    overwrite_exist_tags = true

  [inputs.prom.tags_rename.mapping]
    service_name = "job"
    service_instance_id = "instance"

  [inputs.prom.tags]
    component="AutoMQ"
  interval = "10s"

```

<!-- markdownlint-disable MD033 -->
<font color="red">*其他配置按需调整*</font>
<!-- markdownlint-enable -->
，调整参数说明 ：

<!-- markdownlint-disable MD004 -->
- urls：`AutoMQ`指标地址，这里填写对应组件暴露出来的指标 url
- source：采集器别名，建议做区分
- interval：采集间隔

<!-- markdownlint-enable -->
### 重启 DataKit

[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service)

## 指标 {#metric}

### kafka 指标集

| 指标 | 描述 | 单位 |
| -- | -- | -- |
| kafka_server_connection_count | 节点当前建立的连接数 | Gauge |
| kafka_network_threads_idle_rate | Kafka SocketServer 网络线程的空闲率，范围：[0， 1.0]。 | Gauge |
| kafka_controller_active_count | 用于表示当前 Controller 节点是否为 active Controller，指标值等于 1 表示为 active，0 表示非 active。 | Gauge |
| kafka_broker_active_count | 当前集群的活跃 Broker 数量。| Gauge |
| kafka_broker_fenced_count | 当前集群被 fence 的 Broker 数量。| Gauge |
| kafka_topic_count | 当前集群 Topic 总数。| Gauge |
| kafka_partition_total_count | 当前集群分区总数。| Gauge |
| kafka_partition_offline_count | 当前集群无主分区总数。| Gauge |
| kafka_stream_s3_object_count | 当前集群上传至对象存储的 Object 总数，按 Object 状态分类。| Gauge |
| kafka_stream_s3_object_size_bytes | 当前集群上传至对象存储的 Object 总大小。| byte |
| kafka_stream_stream_object_num | 当前集群上传至对象存储的 StreamObject 数量。| Gauge |
| kafka_stream_stream_set_object_num | 当前集群各 Broker 上传至对象存储的 StreamSetObject 数量。| Gauge |
| kafka_message_count_total |Broker 节点收到的消息总数，对时间求导可得消息数量吞吐。| Counter |
| kafka_network_io_bytes_total |Broker 节点收到和发出的消息大小总量，对时间求导可得消息大小吞吐。| Counter |
| kafka_request_size_bytes_total |Broker 节点收到的请求大小总和。| Byte |
| kafka_topic_request_count_total |Broker 节点上各 Topic 收到的请求总数，仅包含 produce 和 fetch 两种类型请求。| Counter |
| kafka_topic_request_failed_total |Broker 节点上各 Topic 的请求失败总数，仅包含 produce 和 fetch 两种类型请求。| Counter |
| kafka_request_count_total |Broker 节点收到的请求总数。| Counter |
| kafka_request_time_milliseconds_total |Broker 节点处理请求的耗时总和。| ms |
| kafka_request_queue_size |Broker 节点的请求队列大小。| Byte |
| kafka_response_queue_size |Broker 节点的响应队列大小。| Byte |
| kafka_partition_count |Broker 节点当前分配的分区数量。| Counter |
| kafka_log_size |Broker 节点上各个分区的消息大小。| Byte |

更多指标说明，参考 [AutoMQ 官方文档](https://docs.automq.com/zh/docs/automq-opensource/ArHpwR9zsiLbqwkecNzcqOzXn4b)。

