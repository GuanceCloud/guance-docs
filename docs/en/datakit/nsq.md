
# NSQ
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "支持选举")

---

Collect NSQ operation data and report it to Guance Cloud in the form of indicators.

## Preconditions {#requirements}

- NSQ installed（[NSQ official website](https://nsq.io/){:target="_blank"}）

- NSQ version >= 1.0.0

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

Metrics for all topics of the NSQ cluster.

-  Tag


| Tag Name | Description    |
|  ----  | --------|
|`channel`|channel name|
|`topic`|topic name|

- Metrics List


| Metrics | Description| Data Type | Unit   |
| ---- |---- | :---:    | :----: |
|`backend_depth`|Total number of unconsumed messages exceeding men-queue-size|int|count|
|`deferred_count`|Number of messages that are re-queued and not ready to be re-sent|int|count|
|`depth`|The total number of messages not consumed in the current channel|int|count|
|`in_flight_count`|The number of messages in the process of sending or client processing, the number of messages that the client did not send FIN, REQ (re-queuing) and timed out|int|count|
|`message_count`|The total number of messages currently processed by the channel|int|count|
|`requeue_count`|Timeout or number of REQ messages sent by client|int|count|
|`timeout_count`|Number of timeout unprocessed messages|int|count|



### `nsq_nodes`

Metrics for all nodes of the NSQ cluster.

-  Tag


| Tag Name  | Description    |
|  ----  | --------|
|`server_host`|service address, namely `host:ip`|

- Metrics List


| Metrics | Description| Data Type | Unit   |
| ---- |---- | :---:    | :----: |
|`backend_depth`|Total number of unconsumed messages exceeding men-queue-size|int|count|
|`depth`|The total number of messages not consumed in the current node|int|count|
|`message_count`|The total number of messages processed by the current node|int|count|

 
