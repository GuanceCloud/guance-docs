---
title     : 'EMQX'
summary   : 'Collect EMQX collection, topics, subsriptions, message, package related indicator information'
__int_icon: 'icon/emqx'
dashboard :
  - desc  : 'EMQX Monitoring View'
    path  : 'dashboard/zh/emqx'
monitor   :
  - desc  : 'No'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# EMQX
<!-- markdownlint-enable -->

EMQX collection, topics, `subsriptions`, message, package related index information were collected.

## Installation Configuration {#config}


### EMQX Indicators

EMQX default exposure indicator port is: `18083`, you can view indicator information through the browser: `http://clientIP:18083/api/v5/prometheus/stats`.

### DataKit Collector Configuration

Because `EMQX` can expose `metrics` URL directly, it can be collected directly through [ `prom`](./prom.md) collector.



The adjustments are as follows:

```toml

urls = ["http://clientIP:18083/api/v5/prometheus/stats"]

source = "emqx"

measurement_prefix = "emqx_"

interval = "10s"

```

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations are adjusted as needed*</font>
<!-- markdownlint-enable -->
, adjust parameter description:

- Urls: `prometheus` Indicator address, where you fill in the indicator URL exposed by the corresponding component
- Source: Collector alias, recommended to distinguish
- Interval: collection interval
- Measurement_ Prefix: index prefix

### Restart DataKit

```shell
systemctl restart datakit
```

## Metric {#metric}

### Tags

|Tags| Description |
| -- | -- |
|instance| instance |


### Indicator Set `emqx_emqx`

#### Statistics

|Metrics| Description |
| -- | -- |
|connections_count| current connections count  |
|topics_count| current topics count |
|`suboptions_count`|That is `subscriptions_count`|
|subscribers_count| current subscribers count|
|cluster_nodes_running |Cluster `running` status node|
|cluster_nodes_stopped| Cluster `stop` status  node |

#### Message (PUBLISH message)

|Metrics| Description |
| -- | -- |
|messages_ Received | The number of messages received from the client, equal to the sum of messages.qos0.received, messages.qos1.received and messages.qos2.received
|messages_ Send | The number of messages sent to the client, equal to the sum of messages.qos0.send, messages.qos1.sent and messages.qos2.sent
|messages_ Total number of dropped messages | EMQX forwards internally to the subscription process

#### Bytes

|Metrics| Description |
| -- | -- |
|bytes_received| current received bytes |
|bytes_sent| current send bytes |


#### Packets

|Metrics| Description |
| -- | -- |
| packets_connect |Number of CONNECT messages received|
|packets_connack_sent| Send `CONNACK` message count |
| packets_connack_error |The reason code sent is not `CONNACK` number of messages with 0x00, and the value of this indicator is greater than or equal to `packets_connack_auth_error`|
|packets_ Connack_ Auth_ Error | The `CONNACK` number of messages sent with reason codes 0x86 and 0x87
|packets_disconnect_sent| Send DISCONNECT message count|
|packets_disconnect_received| Receive DISCONNECT message count|
|packets_ Publish_ Received | Number of PUBLISH messages received
|packets_ Publish_ Sent | Number of PuBLISH messages sent
|packets_ Publish_ Error | Number of unpublished PUBLISH messages received
|packets_ Publish_ Dropped | Number of PUBLISH messages discarded beyond receive limit
|packets_ Subscribe_ Received | Number of SUBSCRIBE messages received
|packets_ Subscribe_ Error | Number of unsuccessful SUBSCRIBE messages received
| `packets.suback.sent` |Number of `SUBACK` Messages Sent
|packets_ Unsubscribe_ Received | Number of UNSUBSCRIBE messages received
|packets_ Unsubscribe_ Error | Number of Unsubscribe Failed UNSUBSCRIBE Messages Received


Detailed Indicator Information Reference [DOCS](https://www.emqx.io/docs/zh/v5.1/observability/metrics-and-stats.html#%E6%8C%87%E6%A0%87%E5%AF%B9%E7%85%A7%E6%89%8B%E5%86%8C)



## Frequently Asked Questions {#faq}

[No data to report for investigation] (.. /datakit/why-no-data.md)

