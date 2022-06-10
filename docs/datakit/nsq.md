
# NSQ

- DataKit 版本：1.4.0
- 文档发布日期：2022-06-10 10:51:49
- 操作系统支持：`windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

采集 NSQ 运行数据并以指标的方式上报到观测云。

## 前置条件

- 已安装 NSQ（[NSQ 官方网址](https://nsq.io/)）

- NSQ 版本 >= 1.0.0

## 配置

进入 DataKit 安装目录下的 `conf.d/nsq` 目录，复制 `nsq.conf.sample` 并命名为 `nsq.conf`。示例如下：

```toml

[[inputs.nsq]]
  ## NSQ Lookupd HTTP API endpoint
  lookupd = "http://localhost:4161"

  ## NSQD HTTP API endpoint
  ## example:
  ##   ["http://localhost:4151"]
  nsqd = []
  
  ## time units are "ms", "s", "m", "h"
  interval = "10s"
  
  ## Optional TLS Config
  # tls_ca = "/etc/telegraf/ca.pem"
  # tls_cert = "/etc/telegraf/cert.pem"
  # tls_key = "/etc/telegraf/key.pem"
  ## Use TLS but skip chain & host verification
  # insecure_skip_verify = false
  
  [inputs.nsq.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
 
```

NSQ 采集器提供两种配置方式，分别为 `lookupd` 和 `nsqd`，具体说明如下：

- `lookupd`：配置 NSQ 集群的 `lookupd` 地址，采集器会自动发现 NSQ Server 并采集数据，扩展性更佳
- `nsqd`：配置固定的 NSQD 地址列表，采集器只会采集该列表的 NSQ Server 数据

以上两种配置方式是互斥的，`lookupd` 优先级更高，推荐使用 `lookupd` 配置方式。

配置好后，重启 DataKit 即可。

此 input 支持选举功能，[关于选举](election)。

## 指标集

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.nsq.tags]` 指定其它标签：

``` toml
 [inputs.nsq.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `nsq_topics`

NSQ 集群所有 topic 的指标

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`channel`|channel 名称|
|`topic`|topic 名称|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`backend_depth`|超出 men-queue-size 的未被消费的消息总数|int|count|
|`deferred_count`|重新入队并且还没有准备好重新发送的消息数量|int|count|
|`depth`|在当前 channel 中未被消费的消息总数|int|count|
|`in_flight_count`|发送过程中或者客户端处理过程中的数量，客户端没有发送 FIN、REQ(重新入队列) 和超时的消息数量|int|count|
|`message_count`|当前 channel 处理的消息总数量|int|count|
|`requeue_count`|超时或者客户端发送 REQ 的消息数量|int|count|
|`timeout_count`|超时未处理的消息数量|int|count|



### `nsq_nodes`

NSQ 集群所有 node 的指标

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`server_host`|服务地址，即 `host:ip`|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`backend_depth`|超出 men-queue-size 的未被消费的消息总数|int|count|
|`depth`|在当前 node 中未被消费的消息总数|int|count|
|`message_count`|当前 node 处理的消息总数量|int|count|

 
