---
title     : 'AutoMQ'
summary   : 'Collect AutoMQ related Metrics information'
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

Collect AutoMQ related Metrics information.

## Installation and Configuration {#config}

### 1. Enable AutoMQ Metrics

Modify the AutoMQ startup command:

```shell
bin/kafka-server-start.sh ...\
--override  s3.telemetry.metrics.exporter.type=prometheus \
--override  s3.metrics.exporter.prom.port=8890  \
--override  s3.metrics.exporter.prom.host=0.0.0.0 \
......

```

AutoMQ exposes metrics on port `8890`. You can view the metrics information via a browser at `http://clientIP:8890/metrics`.

### 2. DataKit Collector Configuration

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Configure the Collector

Since `AutoMQ` can directly expose a `metrics` URL, you can use the [`prom`](./prom.md) collector for data collection.

Navigate to the [DataKit installation directory](./datakit_dir.md) under `conf.d/prom`, and copy `prom.conf.sample` to `automq.conf`.

> `cp prom.conf.sample automq.conf`

Modify the content of `automq.conf` as follows:

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
<font color="red">*Other configurations can be adjusted as needed*</font>
<!-- markdownlint-enable -->

Parameter adjustment instructions:

<!-- markdownlint-disable MD004 -->
- urls: The `AutoMQ` metrics address, fill in the exposed metrics URL of the corresponding component.
- source: Alias for the collector, it is recommended to differentiate them.
- interval: Collection interval.

<!-- markdownlint-enable -->
### 3. Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

### Kafka Metrics Set

| Metric | Description | Unit |
| -- | -- | -- |
| kafka_server_connection_count | Number of connections currently established by the node | Gauge |
| kafka_network_threads_idle_rate | Idle rate of Kafka SocketServer network threads, range: [0, 1.0]. | Gauge |
| kafka_controller_active_count | Indicates whether the current Controller node is active; a value of 1 indicates active, 0 indicates inactive. | Gauge |
| kafka_broker_active_count | Number of active Brokers in the current cluster. | Gauge |
| kafka_broker_fenced_count | Number of fenced Brokers in the current cluster. | Gauge |
| kafka_topic_count | Total number of Topics in the current cluster. | Gauge |
| kafka_partition_total_count | Total number of partitions in the current cluster. | Gauge |
| kafka_partition_offline_count | Total number of leaderless partitions in the current cluster. | Gauge |
| kafka_stream_s3_object_count | Total number of Objects uploaded to object storage, classified by Object status. | Gauge |
| kafka_stream_s3_object_size_bytes | Total size of Objects uploaded to object storage. | Byte |
| kafka_stream_stream_object_num | Number of StreamObjects uploaded to object storage. | Gauge |
| kafka_stream_stream_set_object_num | Number of StreamSetObjects uploaded to object storage by each Broker. | Gauge |
| kafka_message_count_total | Total number of messages received by the Broker node; deriving this over time gives message throughput. | Counter |
| kafka_network_io_bytes_total | Total size of messages received and sent by the Broker node; deriving this over time gives message size throughput. | Counter |
| kafka_request_size_bytes_total | Total size of requests received by the Broker node. | Byte |
| kafka_topic_request_count_total | Total number of requests received by each Topic on the Broker node, including only produce and fetch types. | Counter |
| kafka_topic_request_failed_total | Total number of failed requests received by each Topic on the Broker node, including only produce and fetch types. | Counter |
| kafka_request_count_total | Total number of requests received by the Broker node. | Counter |
| kafka_request_time_milliseconds_total | Total time spent processing requests by the Broker node. | ms |
| kafka_request_queue_size | Size of the request queue on the Broker node. | Byte |
| kafka_response_queue_size | Size of the response queue on the Broker node. | Byte |
| kafka_partition_count | Number of partitions currently assigned to the Broker node. | Counter |
| kafka_log_size | Size of messages in each partition on the Broker node. | Byte |

For more metric descriptions, refer to the [AutoMQ official documentation](https://docs.automq.com/en/docs/automq-opensource/ArHpwR9zsiLbqwkecNzcqOzXn4b).