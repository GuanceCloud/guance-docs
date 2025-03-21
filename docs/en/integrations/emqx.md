---
title     : 'EMQX'
summary   : 'Collect EMQX collection, topics, subscriptions, message, packet related Metrics information'
__int_icon: 'icon/emqx'
dashboard :
  - desc  : 'EMQX Monitoring View'
    path  : 'dashboard/en/emqx'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# EMQX
<!-- markdownlint-enable -->

Collect EMQX collection, topics, `subscriptions`, message, packet related Metrics information.

## Installation and Configuration {#config}


### EMQX Metrics

EMQX exposes default metrics port as: `18083`. You can view the metrics-related information through a browser: `http://clientIP:18083/api/v5/prometheus/stats`.

### DataKit Collector Configuration

Since `EMQX` can directly expose `metrics` URL, it can be collected via the [`prom`](./prom.md) collector.



The following content needs to be adjusted:

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

Adjust the parameters above in the documentation.

### Restart DataKit

```shell
systemctl restart datakit
```

## Metrics {#metric}

### Measurement Set `emqx`

#### Statistics

| Metrics | Description |
| -- | -- |
| emqx_connections_count | Current number of connections |
|emqx_topics_count | Current number of topics |
|`emqx_suboptions_count`| i.e., `subscriptions_count`|
|emqx_subscribers_count | Current number of subscribers|
|emqx_cluster_nodes_running | Cluster nodes with `running` status |
|emqx_cluster_nodes_stopped | Cluster nodes with `stopped` status |

#### Messages (PUBLISH Packets)

| Metrics | Description |
| -- | -- |
|emqx_messages_received | Number of messages received from clients, equal to the sum of messages.qos0.received, messages.qos1.received, and messages.qos2.received
|emqx_messages_sent | Number of messages sent to clients, equal to the sum of messages.qos0.sent, messages.qos1.sent, and messages.qos2.sent
|emqx_messages_dropped | Total number of messages discarded by EMQX before being forwarded to the subscription process

#### Bytes

| Metrics | Description |
| -- | -- |
| emqx_bytes_received | Number of bytes received |
| emqx_bytes_sent | Number of bytes sent |


#### Packets

| Metrics | Description |
| -- | -- |
| emqx_packets_connect | Number of CONNECT packets received |
| emqx_packets_connack_sent | Number of `CONNACK` packets sent |
| emqx_packets_connack_error | Number of `CONNACK` packets sent with cause code not 0x00, this metric's value is greater than or equal to `packets_connack_auth_error`
|emqx_packets_connack_auth_error | Number of `CONNACK` packets sent with cause code 0x86 and 0x87
|emqx_packets_disconnect_sent|Number of DISCONNECT packets sent|
|emqx_packets_disconnect_received|Number of DISCONNECT packets received|
|emqx_packets_publish_received |Number of PUBLISH packets received
|emqx_packets_publish_sent |Number of PUBLISH packets sent
|emqx_packets_publish_error |Number of PUBLISH packets received that cannot be published
|emqx_packets_publish_dropped |Number of PUBLISH packets dropped due to exceeding reception limits
|emqx_packets_subscribe_received |Number of SUBSCRIBE packets received
|emqx_packets_subscribe_error |Number of failed SUBSCRIBE packets received
|`emqx_packets_suback_sent`|Number of `SUBACK` packets sent
|emqx_packets_unsubscribe_received |Number of UNSUBSCRIBE packets received
|emqx_packets_unsubscribe_error |Number of failed UNSUBSCRIBE packets received


For detailed Metrics information, refer to the [official documentation](https://www.emqx.io/docs/en/v5.1/observability/metrics-and-stats.html#metrics-reference)



## Common Troubleshooting {#faq}

[No Data Reporting Troubleshooting](../datakit/why-no-data.md)

</translated_content>