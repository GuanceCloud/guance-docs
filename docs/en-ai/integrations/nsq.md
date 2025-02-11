---
title     : 'NSQ'
summary   : 'Collect metrics data from NSQ'
tags:
  - 'Message Queue'
  - 'Middleware'
__int_icon      : 'icon/nsq'
dashboard :
  - desc  : 'NSQ'
    path  : 'dashboard/en/nsq'
monitor   :
  - desc  : 'NSQ'
    path  : 'monitor/en/nsq'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

Collect runtime data from NSQ and report it to Guance in the form of metrics.


## Configuration {#config}

### Prerequisites {#requirements}

It is recommended to use NSQ version >= 1.0.0. Tested versions include:

- [x] 1.2.1
- [x] 1.1.0
- [x] 0.3.8

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Go to the `conf.d/nsq` directory under the DataKit installation directory, copy `nsq.conf.sample` and rename it to `nsq.conf`. An example configuration is as follows:
    
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
    
    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

    ???+ tip "The NSQ collector supports two configuration methods: `lookupd` and `nsqd`"
    
        - `lookupd`: Configure the `lookupd` address of the NSQ cluster. The collector will automatically discover NSQ servers and collect data, providing better scalability.
        - `nsqd`: Configure a fixed list of NSQ Daemon (`nsqd`) addresses. The collector will only collect data from the listed NSQ servers.
        
        These two configuration methods are mutually exclusive, with **`lookupd` having higher priority and being recommended**.

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

## Metrics {#metric}

By default, all collected data will append global election tags, or you can specify other tags through `[inputs.nsq.tags]` in the configuration:

``` toml
 [inputs.nsq.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `nsq_topics`

Metrics of all topics in the NSQ cluster

- Tags


| Tag | Description |
|  ----  | --------|
|`channel`|Channel name|
|`topic`|Topic name|

- Metrics List


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

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|Hostname|
|`server_host`|Service address, that is `host:ip`.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`backend_depth`|Total number of unconsumed messages exceeding the max-queue-size.|int|count|
|`depth`|Total number of unconsumed messages in the current node.|int|count|
|`message_count`|Total number of messages processed by the current node.|int|count|



## Custom Objects {#object}









</input_content>
<target_language>英语</target_language>
</input>

