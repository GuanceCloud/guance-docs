---
title     : 'AutoMQ'
summary   : 'Collect AutoMQ related metrics information'
__int_icon: 'icon/automq'
dashboard :
  - desc  : 'AutoMQ Cluster'
    path  : 'dashboard/en/automq_cluster'
  - desc  : 'AutoMQ Group'
    path  : 'dashboard/en/automq_group'
  - desc  : 'AutoMQ Broker'
    path  : 'dashboard/en/automq_broker'
  - desc  : 'AutoMQ Detailed'
    path  : 'dashboard/en/automq_detailed'
  - desc  : 'AutoMQ Topics'
    path  : 'dashboard/en/automq_topics'
monitor   :
  - desc  : 'AutoMQ'
    path  : 'monitor/en/automq'
---

<!-- markdownlint-disable MD025 -->
# AutoMQ
<!-- markdownlint-enable -->

Collect AutoMQ related metrics information

## Installation Configuration{#config}

### Enabled AutoMQ metrics

Adjusting the AutoMQ startup command

```shell
bin/kafka-server-start.sh ...\
--override  s3.telemetry.metrics.exporter.type=prometheus \
--override  s3.metrics.exporter.prom.port=8890  \
--override  s3.metrics.exporter.prom.host=0.0.0.0 \
......

```

The default Exposure Metric port for AutoMQ is: `8890`. Metric-related information can be viewed through a browser: `http://clientIP:8890/metrics`.


### DataKit Collector Configuration

Because `AutoMQ` can expose `metrics` URL directly, it can be collected directly through [`prom`](./prom.md) collector.

The adjustments are as follows:

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
<font color="red">*Other configurations are adjusted as needed*</font>
<!-- markdownlint-enable -->
, adjust parameter description:

<!-- markdownlint-disable MD004 -->
- Urls: `prometheus` Metric address, where you fill in the metric URL exposed by the corresponding component
- Source: Collector alias, recommended to distinguish
- Interval: collection interval

<!-- markdownlint-enable -->
### Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metric {#metric}

### kafka Metrics

| Metric | Description | Unit |
| -- | -- | -- |
| kafka_server_connection_count | Current number of active connections on the node. | Gauge |
| kafka_network_threads_idle_rate | Idle rate of Kafka SocketServer network threads, range: [0, 1.0].| Gauge |
| kafka_controller_active_count | Indicates whether the current Controller node is the active Controller, with a metric value of 1 denoting active and 0 indicating non-active. | Gauge |
| kafka_broker_active_count | Current number of active Brokers in the cluster.| Gauge |
| kafka_broker_fenced_count | Current number of Brokers fenced in the cluster.| Gauge |
| kafka_topic_count | Total number of Topics in the cluster.| Gauge |
| kafka_partition_total_count | Total number of partitions in the cluster.| Gauge |
| kafka_partition_offline_count | Total number of leaderless partitions in the cluster.| Gauge |
| kafka_stream_s3_object_count | Total number of Objects uploaded to object storage in the current cluster, categorized by Object status.| Gauge |
| kafka_stream_s3_object_size_bytes | Total size of Objects uploaded to object storage by the current cluster.| byte |
| kafka_stream_stream_object_num |Number of StreamObjects uploaded to object storage by the current cluster.| Gauge |
| kafka_stream_stream_set_object_num |Number of StreamSetObjects uploaded to object storage by each Broker in the current cluster.| Gauge |
| kafka_message_count_total |The total number of messages received by the Broker node, when tracked over time, provides the message count throughput.| Counter |
| kafka_network_io_bytes_total |The total volume of messages received and sent by the Broker node, when analyzed over time, indicates the message size throughput.| Counter |
| kafka_request_size_bytes_total | Total size of requests received by Broker nodes.| Byte |
| kafka_topic_request_count_total |The total number of requests received by each Topic on the Broker node, limited to produce and fetch request types.| Counter |
| kafka_topic_request_failed_total |The total number of request failures for each Topic on the Broker node, including only produce and fetch request types.| Counter |
| kafka_request_count_total |Total number of requests received by Broker nodes.| Counter |
| kafka_request_time_milliseconds_total |Total time taken by Broker nodes to process requests.| ms |
| kafka_request_queue_size |Broker node's request queue size.| Byte |
| kafka_response_queue_size |Size of the response queue for each Broker node.| Byte |
| kafka_partition_count |Current allocation of partitions to the Broker node.| Counter |
| kafka_log_size |Message size allocated to each partition on the Broker node.| Byte |

For more metrics, refer to [the official AutoMQ document](https://docs.automq.com/zh/docs/automq-opensource/ArHpwR9zsiLbqwkecNzcqOzXn4b)
