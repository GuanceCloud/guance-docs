---
title     : 'EMQX'
summary   : '采集 EMQX collection、topics、subsriptions、message、packet 相关指标信息'
__int_icon: 'icon/emqx'
dashboard :
  - desc  : 'EMQX 监控视图'
    path  : 'dashboard/zh/emqx'
monitor   :
  - desc  : 'EMQX'
    path  : 'monitor/zh/emqx'
---

<!-- markdownlint-disable MD025 -->
# EMQX
<!-- markdownlint-enable -->

采集 EMQX collection、topics、`subsriptions`、message、packet 相关指标信息。

## 安装配置 {#config}


### EMQX 指标

EMQX 默认暴露指标端口为：`18083`，可通过浏览器查看指标相关信息：`http://clientIP:18083/api/v5/prometheus/stats`。

### DataKit 采集器配置

由于`EMQX`能够直接暴露`metrics` url，所以可以直接通过[`prom`](./prom.md)采集器进行采集。



调整内容如下：

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

调整文档以上参数。

### 重启 DataKit

```shell
systemctl restart datakit
```

## 指标 {#metric}

### 指标集 `emqx`

#### Statistics

| Metrics | 描述 |
| -- | -- |
| emqx_connections_count | 当前连接数量 |
|emqx_topics_count | 当前主题数量 |
|`emqx_suboptions_count`| 即 `subscriptions_count`|
|emqx_subscribers_count | 当前订阅者数量|
|emqx_cluster_nodes_running | 集群 `running` 状态的 node |
|emqx_cluster_nodes_stopped | 集群 `stop` 状态的 node |

#### 消息 (PUBLISH 报文)

| Metrics | 描述 |
| -- | -- |
|emqx_messages_received |接收来自客户端的消息数量，等于 messages.qos0.received，messages.qos1.received 与 messages.qos2.received 之和
|emqx_messages_sent |发送给客户端的消息数量，等于 messages.qos0.sent，messages.qos1.sent 与 messages.qos2.sent 之和
|emqx_messages_dropped |EMQX 内部转发到订阅进程前丢弃的消息总数

#### 字节 (Bytes)

| Metrics | 描述 |
| -- | -- |
| emqx_bytes_received | 已接收字节数 |
| emqx_bytes_sent | 已发送字节数 |


#### 报文 (Packets)

| Metrics | 描述 |
| -- | -- |
| emqx_packets_connect | 接收的 CONNECT 报文数量 |
| emqx_packets_connack_sent | 发送的 `CONNACK` 报文数量 |
| emqx_packets_connack_error | 发送的原因码不为 0x00 的 `CONNACK` 报文数量，此指标的值大于等于 `packets_connack_auth_error` 的值 |
|emqx_packets_connack_auth_error | 发送的原因码为 0x86 和 0x87 的 `CONNACK` 报文数量
|emqx_packets_disconnect_sent|发送的 DISCONNECT 报文数量|
|emqx_packets_disconnect_received|接收的 DISCONNECT 报文数量|
|emqx_packets_publish_received |接收的 PUBLISH 报文数量
|emqx_packets_publish_sent |发送的 PUBLISH 报文数量
|emqx_packets_publish_error |接收的无法被发布的 PUBLISH 报文数量
|emqx_packets_publish_dropped |超出接收限制而被丢弃的 PUBLISH 报文数量
|emqx_packets_subscribe_received |接收的 SUBSCRIBE 报文数量
|emqx_packets_subscribe_error |接收的订阅失败的 SUBSCRIBE 报文数量
|`emqx_packets_suback_sent`|发送的 `SUBACK` 报文数量
|emqx_packets_unsubscribe_received |接收的 UNSUBSCRIBE 报文数量
|emqx_packets_unsubscribe_error |接收的取消订阅失败的 UNSUBSCRIBE 报文数量


详细指标信息参考[官方文档](https://www.emqx.io/docs/zh/v5.1/observability/metrics-and-stats.html#%E6%8C%87%E6%A0%87%E5%AF%B9%E7%85%A7%E6%89%8B%E5%86%8C)


## 最佳实践 {#best-practices}
<div class="grid cards" data-href="https://learning.guance.com/uploads/banner_e4008e857e.png" data-title="EMQX 可观测性最佳实践" data-desc="通过将 EMQX 指标数据接入到观测云，让用户更好地理解和控制 EMQX 集群的行为，从而提高系统的可靠性和效率。"  markdown>
<[EMQX 可观测性最佳实践](https://www.guance.com/learn/articles/EMQX)>
</div>