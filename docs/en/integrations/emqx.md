---
title     : 'EMQX'
summary   : 'Collect EMQX collection, topics, subscriptions, message, and packet related Metrics information'
__int_icon: 'icon/emqx'
dashboard :
  - desc  : 'EMQX monitoring view'
    path  : 'dashboard/en/emqx'
monitor   :
  - desc  : 'EMQX'
    path  : 'monitor/en/emqx'
---

<!-- markdownlint-disable MD025 -->
# EMQX
<!-- markdownlint-enable -->

Collect EMQX collection, topics, `subscriptions`, message, and packet related Metrics information.

## Installation Configuration {#config}


### EMQX Metrics

EMQX exposes the default Metrics port as `18083`. You can view the Metrics information through a browser at `http://clientIP:18083/api/v5/prometheus/stats`.

### DataKit Collector Configuration

Since `EMQX` can directly expose a `metrics` URL, it can be collected using the [`prom`](./prom.md) collector.



The following adjustments are made:

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

Adjust the parameters above in the document.

### Restart DataKit

```shell
systemctl restart datakit
```

## Metrics {#metric}

### Metrics Set `emqx`

#### Statistics

| Metrics | Description |
| -- | -- |
| emqx_connections_count | Current number of connections |
| emqx_topics_count | Current number of topics |
| `emqx_suboptions_count` | i.e., `subscriptions_count` |
| emqx_subscribers_count | Current number of subscribers |
| emqx_cluster_nodes_running | Cluster nodes with `running` status |
| emqx_cluster_nodes_stopped | Cluster nodes with `stop` status |

#### Messages (PUBLISH Packets)

| Metrics | Description |
| -- | -- |
| emqx_messages_received | Number of messages received from clients, equal to the sum of messages.qos0.received, messages.qos1.received, and messages.qos2.received |
| emqx_messages_sent | Number of messages sent to clients, equal to the sum of messages.qos0.sent, messages.qos1.sent, and messages.qos2.sent |
| emqx_messages_dropped | Total number of messages dropped by EMQX before forwarding them to subscriber processes |

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
| emqx_packets_connack_error | Number of `CONNACK` packets sent with reason codes not equal to 0x00. This metric's value is greater than or equal to `packets_connack_auth_error` |
| emqx_packets_connack_auth_error | Number of `CONNACK` packets sent with reason codes 0x86 and 0x87 |
| emqx_packets_disconnect_sent | Number of DISCONNECT packets sent |
| emqx_packets_disconnect_received | Number of DISCONNECT packets received |
| emqx_packets_publish_received | Number of PUBLISH packets received |
| emqx_packets_publish_sent | Number of PUBLISH packets sent |
| emqx_packets_publish_error | Number of PUBLISH packets received but could not be published |
| emqx_packets_publish_dropped | Number of PUBLISH packets dropped due to exceeding reception limits |
| emqx_packets_subscribe_received | Number of SUBSCRIBE packets received |
| emqx_packets_subscribe_error | Number of failed SUBSCRIBE packets received |
| `emqx_packets_suback_sent` | Number of `SUBACK` packets sent |
| emqx_packets_unsubscribe_received | Number of UNSUBSCRIBE packets received |
| emqx_packets_unsubscribe_error | Number of failed UNSUBSCRIBE packets received |


Refer to the [official documentation](https://www.emqx.io/docs/en/v5.1/observability/metrics-and-stats.html#Metrics-Reference) for detailed Metrics information.

<<<% if custom_key.brand_key == "guance" %>>>
## Best Practices {#best-practices}
<div class="grid cards" data-href="https://learning.<<< custom_key.brand_main_domain >>>/uploads/banner_e4008e857e.png" data-title="Best Practices for EMQX Observability" data-desc="By integrating EMQX Metrics data into <<< custom_key.brand_name >>>, users can better understand and control the behavior of the EMQX cluster, thereby improving system reliability and efficiency."  markdown>
<[Best Practices for EMQX Observability](https://<<< custom_key.brand_main_domain >>>/learn/articles/EMQX){:target="_blank"}>
</div>
<<<% endif %>>>