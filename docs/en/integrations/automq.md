---
title     : 'AutoMQ'
summary   : 'Collect metrics related to AutoMQ'
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

Collect metrics related to AutoMQ.

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

AutoMQ exposes the metrics endpoint at port `8890`. You can view the metrics information via a browser: `http://clientIP:8890/metrics`.

### 2. Configure DataKit Collector

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Configure the Collector

Since `AutoMQ` can directly expose a `metrics` URL, you can use the [`prom`](./prom.md) collector for collection.

Navigate to the [DataKit installation directory](./datakit_dir.md) under `conf.d/prom`, copy `prom.conf.sample` to `automq.conf`.

> `cp prom.conf.sample automq.conf`

Edit the content of `automq.conf` as follows:

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
- urls: The metric address of `AutoMQ`, fill in the corresponding component's exposed metrics URL.
- source: Alias for the collector, it is recommended to differentiate.
- interval: Collection interval

<!-- markdownlint-enable -->
### 3. Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

### Kafka Metrics Set

| Metric | Description | Unit |
| --- | --- | --- |
| kafka_server_connection_count | Number of connections currently established on the node | Gauge |
| kafka_network_threads_idle_rate | Idle rate of Kafka SocketServer network threads, range: [0, 1.0]. | Gauge |
| kafka_controller_active_count | Indicates whether the current Controller node is an active Controller, a value of 1 indicates active, 0 indicates non-active. | Gauge |
| kafka_broker_active_count | Number of active Brokers in the current cluster. | Gauge |
| kafka_broker_fenced_count | Number of fenced Brokers in the current cluster. | Gauge |
| kafka_topic_count | Total number of Topics in the current cluster. | Gauge |
| kafka_partition_total_count | Total number of partitions in the current cluster. | Gauge |
| kafka_partition_offline_count | Total number of leaderless partitions in the current cluster. | Gauge |
| kafka_stream_s3_object_count | Total number of Objects uploaded to object storage by the current cluster, categorized by Object status. | Gauge |
| kafka_stream_s3_object_size_bytes | Total size of Objects uploaded to object storage by the current cluster. | byte |
| kafka_stream_stream_object_num | Number of StreamObjects uploaded to object storage by the current cluster. | Gauge |
| kafka_stream_stream_set_object_num | Number of StreamSetObjects uploaded to object storage by each Broker in the current cluster. | Gauge |
| kafka_message_count_total | Total number of messages received by the Broker node, deriving the message throughput over time. | Counter |
| kafka_network_io_bytes_total | Total size of messages received and sent by the Broker node, deriving the message size throughput over time. | Counter |
| kafka_request_size_bytes_total | Total size of requests received by the Broker node. | Byte |
| kafka_topic_request_count_total | Total number of requests received by the Broker node for each Topic, including only produce and fetch types. | Counter |
| kafka_topic_request_failed_total | Total number of failed requests for each Topic on the Broker node, including only produce and fetch types. | Counter |
| kafka_request_count_total | Total number of requests received by the Broker node. | Counter |
| kafka_request_time_milliseconds_total | Total processing time for requests on the Broker node. | ms |
| kafka_request_queue_size | Size of the request queue on the Broker node. | Byte |
| kafka_response_queue_size | Size of the response queue on the Broker node. | Byte |
| kafka_partition_count | Number of partitions currently assigned to the Broker node. | Counter |
| kafka_log_size | Size of messages in each partition on the Broker node. | Byte |

For more metric descriptions, refer to the [official AutoMQ documentation](https://docs.automq.com/en/docs/automq-opensource/ArHpwR9zsiLbqwkecNzcqOzXn4b).
