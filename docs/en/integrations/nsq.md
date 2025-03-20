---
title     : 'NSQ'
summary   : 'Collect NSQ Metrics data'
tags:
  - 'MESSAGE QUEUES'
  - 'MIDDLEWARE'
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

Collect NSQ runtime data and report it to Guance in the form of Metrics.


## Configuration {#config}

### Prerequisites {#requirements}

It is recommended that the version of NSQ >= 1.0.0, tested versions include:

- [x] 1.2.1
- [x] 1.1.0
- [x] 0.3.8

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "HOST Installation"

    Go to the `conf.d/nsq` directory under the DataKit installation directory, copy `nsq.conf.sample` and rename it to `nsq.conf`. An example is as follows:
    
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
    
    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

    ???+ tip "The NSQ collector provides two configuration methods, namely `lookupd` and `nsqd`"
    
        - `lookupd`: Configure the `lookupd` address of the NSQ cluster. The collector will automatically discover the NSQ Server and collect data, offering better scalability.
        - `nsqd`: Configure a fixed list of NSQ Daemon (`nsqd`) addresses. The collector will only collect data from the NSQ Servers in this list.
        
        These two configuration methods are mutually exclusive. **`lookupd` has higher priority and its use is recommended**.

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

## Metrics {#metric}

By default, all collected data below will append global election tags, or you can specify other tags through `[inputs.nsq.tags]` in the configuration:

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








## Custom Objects {#custom_object}




### `mq`



- Tags


| Tag | Description |
|  ----  | --------|
|`col_co_status`|Current status of collector on Nsq(`OK/NotOK`)|
|`host`|The server host address|
|`ip`|Connection IP of the Nsq|
|`name`|Object uniq ID|
|`reason`|If status not ok, we'll get some reasons about the status|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`display_name`|Displayed name in UI|string|-|
|`uptime`|Current Nsq uptime|int|s|
|`version`|Current version of Nsq|string|-|