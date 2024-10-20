---
title     : 'NSQ'
summary   : '采集 NSQ 的指标数据'
tags:
  - '消息队列'
  - '中间件'
__int_icon      : 'icon/nsq'
dashboard :
  - desc  : 'NSQ'
    path  : 'dashboard/zh/nsq'
monitor   :
  - desc  : 'NSQ'
    path  : 'monitor/zh/nsq'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

采集 NSQ 运行数据并以指标的方式上报到观测云。


## 配置 {#config}

### 前置条件 {#requirements}

推荐 NSQ 版本 >= 1.0.0，已测试的版本：

- [x] 1.2.1
- [x] 1.1.0
- [x] 0.3.8

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

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
    
    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

    ???+ tip "NSQ 采集器提供两种配置方式，分别为 `lookupd` 和 `nsqd`"
    
        - `lookupd`：配置 NSQ 集群的 `lookupd` 地址，采集器会自动发现 NSQ Server 并采集数据，扩展性更佳
        - `nsqd`：配置固定的 NSQ Daemon（`nsqd`）地址列表，采集器只会采集该列表的 NSQ Server 数据
        
        以上两种配置方式是互斥的，**`lookupd` 优先级更高，推荐使用 `lookupd` 配置方式**。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

## 指标 {#metric}

以下所有数据采集，默认会追加全局选举 tag，也可以在配置中通过 `[inputs.nsq.tags]` 指定其它标签：

``` toml
 [inputs.nsq.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `nsq_topics`

Metrics of all topics in the NSQ cluster

- 标签


| Tag | Description |
|  ----  | --------|
|`channel`|Channel name|
|`topic`|Topic name|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`backend_depth`|Total number of unconsumed messages exceeding the max-queue-size.|int|count|
|`deferred_count`|Number of messages that have been requeued and are not yet ready for re-sending.|int|count|
|`depth`|Total number of unconsumed messages in the current channel.|int|count|
|`in_flight_count`|Number of messages during the sending process or client processing that have not been sent FIN, REQ (requeued), or timed out.|int|count|
|`message_count`|Total number of messages processed in the current channel.|int|count|
|`requeue_count`|Number of messages that have timed out or have been sent REQ by the client.|int|count|
|`timeout_count`|Number of messages that have timed out and are still unprocessed.|int|count|



### `nsq_nodes`

Metrics of all nodes in the NSQ cluster.

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|Hostname|
|`server_host`|Service address, that is `host:ip`.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`backend_depth`|Total number of unconsumed messages exceeding the max-queue-size.|int|count|
|`depth`|Total number of unconsumed messages in the current node.|int|count|
|`message_count`|Total number of messages processed by the current node.|int|count|



## 自定义对象 {#object}









