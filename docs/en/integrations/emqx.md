---
title: 'EMQX'
summary: 'Collect metrics related to EMQX collection, topics, subscriptions, message, and packet'
__int_icon: 'icon/emqx'
dashboard:
  - desc: 'EMQX monitoring view'
    path: 'dashboard/en/emqx'
monitor:
  - desc: 'Not available'
    path: '-'
---

<!-- markdownlint-disable MD025 -->
# EMQX
<!-- markdownlint-enable -->

Collect metrics related to EMQX collection, topics, `subscriptions`, message, and packet.

## Installation and Configuration {#config}

### EMQX Metrics

EMQX exposes metrics on port `18083` by default. You can view the metrics information via a browser at: `http://clientIP:18083/api/v5/prometheus/stats`.

### DataKit Collector Configuration

Since `EMQX` can directly expose a `metrics` URL, you can collect data using the [`prom`](./prom.md) collector.

Adjust the content as follows:

```toml
[[inputs.prom]]
  ## Exporter URLs.
  urls = ["http://clientIP:18083/api/v5/prometheus/stats"]

  source = "emqx"

  keep_exist_metric_name = true

  ## Customize tags.
  [inputs.prom.tags]
    job = "emqx"  
...
```

Adjust the above parameters in the document.

### Restart DataKit

```shell
systemctl restart datakit
```

## Metrics {#metric}

### Metric Set `emqx`

#### Statistics

| Metrics | Description |
| --- | --- |
| emqx_connections_count | Current number of connections |
| emqx_topics_count | Current number of topics |
| `emqx_suboptions_count` | Same as `subscriptions_count` |
| emqx_subscribers_count | Current number of subscribers |
| emqx_cluster_nodes_running | Nodes in the cluster with `running` status |
| emqx_cluster_nodes_stopped | Nodes in the cluster with `stopped` status |

#### Messages (PUBLISH Packet)

| Metrics | Description |
| --- | --- |
| emqx_messages_received | Number of messages received from clients, equal to the sum of messages.qos0.received, messages.qos1.received, and messages.qos2.received |
| emqx_messages_sent | Number of messages sent to clients, equal to the sum of messages.qos0.sent, messages.qos1.sent, and messages.qos2.sent |
| emqx_messages_dropped | Total number of messages dropped before being forwarded to subscription processes within EMQX |

#### Bytes

| Metrics | Description |
| --- | --- |
| emqx_bytes_received | Number of bytes received |
| emqx_bytes_sent | Number of bytes sent |

#### Packets

| Metrics | Description |
| --- | --- |
| emqx_packets_connect | Number of CONNECT packets received |
| emqx_packets_connack_sent | Number of `CONNACK` packets sent |
| emqx_packets_connack_error | Number of `CONNACK` packets sent with a reason code not equal to 0x00, this metric's value is greater than or equal to `packets_connack_auth_error` |
| emqx_packets_connack_auth_error | Number of `CONNACK` packets sent with reason codes 0x86 and 0x87 |
| emqx_packets_disconnect_sent | Number of DISCONNECT packets sent |
| emqx_packets_disconnect_received | Number of DISCONNECT packets received |
| emqx_packets_publish_received | Number of PUBLISH packets received |
| emqx_packets_publish_sent | Number of PUBLISH packets sent |
| emqx_packets_publish_error | Number of PUBLISH packets received that could not be published |
| emqx_packets_publish_dropped | Number of PUBLISH packets dropped due to exceeding reception limits |
| emqx_packets_subscribe_received | Number of SUBSCRIBE packets received |
| emqx_packets_subscribe_error | Number of SUBSCRIBE packets received with subscription failures |
| `emqx_packets_suback_sent` | Number of `SUBACK` packets sent |
| emqx_packets_unsubscribe_received | Number of UNSUBSCRIBE packets received |
| emqx_packets_unsubscribe_error | Number of UNSUBSCRIBE packets received with unsubscription failures |

For detailed metric information, refer to the [official documentation](https://www.emqx.io/docs/en/v5.1/observability/metrics-and-stats.html#metrics-reference).

## Common Troubleshooting {#faq}

[No Data Reporting Troubleshooting](../datakit/why-no-data.md)
