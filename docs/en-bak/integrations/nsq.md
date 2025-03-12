---
title     : 'NSQ'
summary   : 'Collect NSQ metrics'
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

Collect NSQ operation data and report it to Guance Cloud in the form of indicators.

## Configuration {#config}

### Preconditions {#requirements}

- NSQ installed（[NSQ official website](https://nsq.io/){:target="_blank"}）

- Recommend NSQ version >= 1.0.0, already tested version:

- [x] 1.2.1
- [x] 1.1.0
- [x] 0.3.8

### Collector Configuration {#input-config}

=== "Host Installation"
<!-- markdownlint-disable MD046 -->
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
    - `nsqd`: Configure a fixed list of NSQ Daemon (`nsqd`) addresses for which the collector collects only NSQ Server data
    
    The above two configuration methods are mutually exclusive, and `lookupd` has higher priority, so it is recommended to use `lookupd` configuration method.
    
    Once configured, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->
## Metric {#metric}

For all of the following data collections, the global election tags will added automatically, we can add extra tags in `[inputs.nsq.tags]` if needed:

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

- Metrics


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

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`backend_depth`|Total number of unconsumed messages exceeding the max-queue-size.|int|count|
|`depth`|Total number of unconsumed messages in the current node.|int|count|
|`message_count`|Total number of messages processed by the current node.|int|count|






## Custom Object {#object}













### `mq`



- Tags


| Tag | Description |
|  ----  | --------|
|`col_co_status`|Current status of collector on Nsq(`OK/NotOK`)|
|`host`|The server host address|
|`ip`|Connection IP of the Nsq|
|`name`|Object uniq ID|
|`reason`|If status not ok, we'll get some reasons about the status|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`display_name`|Displayed name in UI|string|-|
|`uptime`|Current Nsq uptime|int|s|
|`version`|Current version of Nsq|string|-|



