
# RabbitMQ
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "支持选举")

---

RabbitMQ collector monitors RabbitMQ by collecting data through the plug-in `rabbitmq-management` and can:

- RabbitMQ overview, such as connections, queues, total messages, and so on.
- Track RabbitMQ queue information, such as queue size, consumer count and so on.
- Rack RabbitMQ node information, such as `socket` `mem`.
- Tracking RabbitMQ exchange information such as `message_publish_count`.

## Preconditions {#reqirement}

- RabbitMQ version >= 3.8.14

- Install `rabbitmq`, take `Ubuntu` as an example

    ```shell
    sudo apt-get update
    sudo apt-get install rabbitmq-server
    sudo service rabbitmq-server start
    ```

- Start `REST API plug-ins`

    ```shell
    sudo rabbitmq-plugins enable rabbitmq-management
    ```

- Creat user, for example:

    ```shell
    sudo rabbitmqctl add_user guance <SECRET>
    sudo rabbitmqctl set_permissions  -p / guance "^aliveness-test$" "^amq\.default$" ".*"
    sudo rabbitmqctl set_user_tags guance monitoring
    ```

## Cnfiguration {#config}

=== "Host Installation"

    Go to the `conf.d/rabbitmq` directory under the DataKit installation directory, copy `rabbitmq.conf.sample` and name it `rabbitmq.conf`. Examples are as follows:


​    
    ```toml
        
    [[inputs.rabbitmq]]
      # rabbitmq url ,required
      url = "http://localhost:15672"
    
      # rabbitmq user, required
      username = "guest"
    
      # rabbitmq password, required
      password = "guest"
    
      # ##(optional) collection interval, default is 30s
      # interval = "30s"
    
      ## Optional TLS Config
      # tls_ca = "/xxx/ca.pem"
      # tls_cert = "/xxx/cert.cer"
      # tls_key = "/xxx/key.key"
      ## Use TLS but skip chain & host verification
      insecure_skip_verify = false
    
      ## Set true to enable election
      election = true
    
      # [inputs.rabbitmq.log]
      # files = []
      # #grok pipeline script path
      # pipeline = "rabbitmq.p"
    
      [inputs.rabbitmq.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
      # ...
    
    
    ```
    
    After configuration, [restart DataKit](datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap injection collector configuration](datakit-daemonset-deploy.md#configmap-setting).

## Measurements {#measurements}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.rabbitmq.tags]`:

``` toml
 [inputs.rabbitmq.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `rabbitmq_overview`

- tag


| Tag | Descrition |
|  ----  | --------|
|`cluster_name`|rabbitmq cluster name|
|`rabbitmq_version`|rabbitmq version|
|`url`|rabbitmq url|

- metric list


| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`message_ack_count`|Number of messages delivered to clients and acknowledged|int|count|
|`message_ack_rate`|Rate of messages delivered to clients and acknowledged per second|float|percent|
|`message_confirm_count`|Count of messages confirmed|int|count|
|`message_confirm_rate`|Rate of messages confirmed per second|float|percent|
|`message_deliver_get_count`|Sum of messages delivered in acknowledgement mode to consumers, in no-acknowledgement mode to consumers, in acknowledgement mode in response to basic.get, and in no-acknowledgement mode in response to basic.get|int|count|
|`message_deliver_get_rate`|Rate per second of the sum of messages delivered in acknowledgement mode to consumers, in no-acknowledgement mode to consumers, in acknowledgement mode in response to basic.get, and in no-acknowledgement mode in response to basic.get |float|percent|
|`message_publish_count`|Count of messages published|int|count|
|`message_publish_in_count`|Count of messages published from channels into this overview|int|count|
|`message_publish_in_rate`|Rate of messages published from channels into this overview per sec |float|percent|
|`message_publish_out_count`|Count of messages published from this overview into queues|int|count|
|`message_publish_out_rate`|Rate of messages published from this overview into queues per second|float|percent|
|`message_publish_rate`|Rate of messages published per second|float|percent|
|`message_redeliver_count`|Count of subset of messages in deliver_get which had the redelivered flag set|int|count|
|`message_redeliver_rate`|Rate of subset of messages in deliver_get which had the redelivered flag set per second|float|percent|
|`message_return_unroutable_count`|Count of messages returned to publisher as unroutable |int|count|
|`message_return_unroutable_count_rate`|Rate of messages returned to publisher as unroutable per second|float|percent|
|`object_totals_channels`|Total number of channels|int|count|
|`object_totals_connections`|Total number of connections|int|count|
|`object_totals_consumers`|Total number of consumers|int|count|
|`object_totals_queues`|Total number of queues|int|count|
|`queue_totals_messages_count`|Total number of messages (ready plus unacknowledged)|int|count|
|`queue_totals_messages_rate`|Total rate of messages (ready plus unacknowledged)|float|percent|
|`queue_totals_messages_ready_count`|Number of messages ready for delivery |int|count|
|`queue_totals_messages_ready_rate`|Rate of number of messages ready for delivery|float|percent|
|`queue_totals_messages_unacknowledged_count`|Number of unacknowledged messages|int|count|
|`queue_totals_messages_unacknowledged_rate`|Rate of number of unacknowledged messages|float|percent|



### `rabbitmq_queue`

- tag


| Tag | Descrition |
|  ----  | --------|
|`node_name`|rabbitmq node name|
|`queue_name`|rabbitmq queue name|
|`url`|rabbitmq url|

- metric list


| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`bindings_count`|Number of bindings for a specific queue|int|count|
|`consumer_utilization`|Number of consumers|float|percent|
|`consumers`|The ratio of time that a queue's consumers can take new messages|int|count|
|`head_message_timestamp`|Timestamp of the head message of the queue. Shown as millisecond|int|msec|
|`memory`|Bytes of memory consumed by the Erlang process associated with the queue, including stack, heap and internal structures|int|B|
|`message`|Count of the total messages in the queue|int|count|
|`message_ack_count`|Number of messages in queues delivered to clients and acknowledged|int|count|
|`message_ack_rate`|Number per second of messages delivered to clients and acknowledged|float|percent|
|`message_deliver_count`|Count of messages delivered in acknowledgement mode to consumers|int|count|
|`message_deliver_get_count`|Sum of messages in queues delivered in acknowledgement mode to consumers, in no-acknowledgement mode to consumers, in acknowledgement mode in response to basic.get, and in no-acknowledgement mode in response to basic.get.|int|count|
|`message_deliver_get_rate`|Rate per second of the sum of messages in queues delivered in acknowledgement mode to consumers, in no-acknowledgement mode to consumers, in acknowledgement mode in response to basic.get, and in no-acknowledgement mode in response to basic.get.|float|percent|
|`message_deliver_rate`|Rate of messages delivered in acknowledgement mode to consumers|float|percent|
|`message_publish_count`|Count of messages in queues published|int|count|
|`message_publish_rate`|Rate per second of messages published|float|percent|
|`message_redeliver_count`|Count of subset of messages in queues in deliver_get which had the redelivered flag set|int|count|
|`message_redeliver_rate`|Rate per second of subset of messages in deliver_get which had the redelivered flag set|float|percent|
|`messages_rate`|Count per second of the total messages in the queue|float|percent|
|`messages_ready`|Number of messages ready to be delivered to clients|int|count|
|`messages_ready_rate`|Number per second of messages ready to be delivered to clients|float|percent|
|`messages_unacknowledged`|Number of messages delivered to clients but not yet acknowledged|int|count|
|`messages_unacknowledged_rate`|Number per second of messages delivered to clients but not yet acknowledged|float|percent|



### `rabbitmq_exchange`

- tag


| Tag | Descrition |
|  ----  | --------|
|`auto_delete`|If set, the exchange is deleted when all queues have finished using it|
|`durable`|If set when creating a new exchange, the exchange will be marked as durable. Durable exchanges remain active when a server restarts. Non-durable exchanges (transient exchanges) are purged if/when a server restarts.|
|`exchange_name`|rabbitmq exchange name|
|`internal`|If set, the exchange may not be used directly by publishers, but only when bound to other exchanges. Internal exchanges are used to construct wiring that is not visible to applications|
|`type`|rabbitmq exchange type|
|`url`|rabbitmq url|
|`vhost`|rabbitmq exchange virtual hosts|

- metric list


| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`message_ack_count`|Number of messages in exchanges delivered to clients and acknowledged|int|count|
|`message_ack_rate`|Rate of messages in exchanges delivered to clients and acknowledged per second|float|percent|
|`message_confirm_count`|Count of messages in exchanges confirmed|int|count|
|`message_confirm_rate`|Rate of messages in exchanges confirmed per second|float|percent|
|`message_deliver_get_count`|Sum of messages in exchanges delivered in acknowledgement mode to consumers, in no-acknowledgement mode to consumers, in acknowledgement mode in response to basic.get, and in no-acknowledgement mode in response to basic.get|int|count|
|`message_deliver_get_rate`|Rate per second of the sum of exchange messages delivered in acknowledgement mode to consumers, in no-acknowledgement mode to consumers, in acknowledgement mode in response to basic.get, and in no-acknowledgement mode in response to basic.get|float|percent|
|`message_publish_count`|Count of messages in exchanges published|int|count|
|`message_publish_in_count`|Count of messages published from channels into this exchange|int|count|
|`message_publish_in_rate`|Rate of messages published from channels into this exchange per sec|float|percent|
|`message_publish_out_count`|Count of messages published from this exchange into queues|int|count|
|`message_publish_out_rate`|Rate of messages published from this exchange into queues per second|float|percent|
|`message_publish_rate`|Rate of messages in exchanges published per second|float|percent|
|`message_redeliver_count`|Count of subset of messages in exchanges in deliver_get which had the redelivered flag set|int|count|
|`message_redeliver_rate`|Rate of subset of messages in exchanges in deliver_get which had the redelivered flag set per second|float|percent|
|`message_return_unroutable_count`|Count of messages in exchanges returned to publisher as unroutable|int|count|
|`message_return_unroutable_count_rate`|Rate of messages in exchanges returned to publisher as unroutable per second|float|percent|



### `rabbitmq_node`

- tag


| Tag | Descrition |
|  ----  | --------|
|`node_name`|rabbitmq node name|
|`url`|rabbitmq url|

- metric list


| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`disk_free`|Current free disk space|int|B|
|`disk_free_alarm`|Does the node have disk alarm|bool|-|
|`fd_used`|Used file descriptors|int|-|
|`io_read_avg_time`|avg wall time (milliseconds) for each disk read operation in the last statistics interval|float|ms|
|`io_seek_avg_time`|average wall time (milliseconds) for each seek operation in the last statistics interval|float|ms|
|`io_sync_avg_time`|average wall time (milliseconds) for each fsync() operation in the last statistics interval|float|ms|
|`io_write_avg_time`|avg wall time (milliseconds) for each disk write operation in the last statistics interval|float|ms|
|`mem_alarm`|Does the node have mem alarm|bool|-|
|`mem_limit`|Memory usage high watermark in bytes|int|B|
|`mem_used`|Memory used in bytes|int|B|
|`run_queue`|Average number of Erlang processes waiting to run|int|count|
|`running`|Is the node running or not|bool|-|
|`sockets_used`|Number of file descriptors used as sockets|int|count|




## Log Collection {#logging}

???+ attention

    DataKit must be installed on the host where RabbitMQ is located to collect RabbitMQ logs.

To collect the RabbitMQ log, open `files` in RabbitMQ.conf and write to the absolute path of the RabbitMQ log file. For example:

```toml
    [[inputs.rabbitmq]]
      ...
      [inputs.rabbitmq.log]
        files = ["/var/log/rabbitmq/rabbit@your-hostname.log"]
```


When log collection is turned on, a log with a log `source` of `rabbitmq` is generated by default.

## Log Pipeline Function Cut Field Description {#pipeline}

- RabbitMQ universal log cutting

Example of common log text:

```
2021-05-26 14:20:06.105 [warning] <0.12897.46> rabbitmqctl node_health_check and its HTTP API counterpart are DEPRECATED. See https://www.rabbitmq.com/monitoring.html#health-checks for replacement options.
```

The list of cut fields is as follows:

| Field Name | Field Value                             | Description                         |
| ---    | ---                                | ---                          |
| status | warning                            | Log level                     |
| msg    | <0.12897.46>...replacement options | Log level                     |
| time   | 1622010006000000000                | Nanosecond timestamp (as row protocol time) |
