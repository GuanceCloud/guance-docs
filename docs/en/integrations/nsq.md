
# NSQ
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")index.md#legends "支持选举")

---

Collect NSQ operation data and report it to Guance Cloud in the form of indicators.

## Preconditions {#requirements}

- NSQ installed（[NSQ official website](https://nsq.io/){:target="_blank"}）

- Recommend NSQ version >= 1.0.0, already tested version:

- [x] 1.2.1
- [x] 1.1.0
- [x] 0.3.8

## Configuration {#config}

=== "Host Installation"

    Go to the `conf.d/nsq` directory under the DataKit installation directory, copy `nsq.conf.sample` and name it `nsq.conf`. Examples are as follows:
    
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
    
      ## Set true to enable election
      election = true
      
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
    
    The NSQ collector is available in two configurations, `lookupd` and `nsqd`, as follows:
    
    - `lookupd`: Configure the `lookupd` address of the NSQ cluster, and the collector will automatically discover the NSQ Server and collect data, which is more scalable.
    - `nsqd`: Configure a fixed list of NSQD addresses for which the collector collects only NSQ Server data
    
    The above two configuration methods are mutually exclusive, and `lookupd` has higher priority, so it is recommended to use `lookupd` configuration method.
    
    Once configured, [restart DataKit](datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](datakit-daemonset-deploy.md#configmap-setting).

## Measurements {#measurements}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.nsq.tags]`:

``` toml
 [inputs.nsq.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `nsq_topics`

NSQ 集群所有 topic 的指标

- tag


| Tag | Description |
|  ----  | --------|
|`channel`|channel 名称|
|`topic`|topic 名称|

- metric list


| Metric | Description | Type | Unit |
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

- tag


| Tag | Description |
|  ----  | --------|
|`host`|Hostname|
|`server_host`|服务地址，即 `host:ip`|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`backend_depth`|超出 men-queue-size 的未被消费的消息总数|int|count|
|`depth`|在当前 node 中未被消费的消息总数|int|count|
|`message_count`|当前 node 处理的消息总数量|int|count|


