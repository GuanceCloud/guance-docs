---
title: 'KafkaMQ'
summary: 'Collect existing Metrics and LOG data via Kafka'
tags:
  - MESSAGE QUEUES
  - LOG
__int_icon: 'icon/kafka'
dashboard:
  - desc: 'Not available'
    path: '-'
monitor:
  - desc: 'Not available'
    path: '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Datakit supports subscribing to messages from Kafka for collecting APM, Metrics, and LOG information. Currently, it supports `SkyWalking`, `Jaeger`, and custom Topics.

## Configuration {#config}

Example configuration file:

<!-- markdownlint-disable MD046 -->
=== "HOST Installation"

    Navigate to the `conf.d/kafkamq` directory under the DataKit installation directory, copy `kafkamq.conf.sample`, and rename it as `kafkamq.conf`. Example as follows:
    
    ```toml
        
    [[inputs.kafkamq]]
      addrs = ["localhost:9092"]
      # your kafka version:0.8.2 ~ 3.2.0
      kafka_version = "2.0.0"
      group_id = "datakit-group"
      # consumer group partition assignment strategy (range, roundrobin, sticky)
      assignor = "roundrobin"
    
      ## rate limit.
      #limit_sec = 100
      ## sample
      # sampling_rate = 1.0
    
      ## kafka tls config
      # tls_enable = true
      ## PLAINTEXT/SASL_SSL/SASL_PLAINTEXT
      # tls_security_protocol = "SASL_PLAINTEXT"
      ## PLAIN/SCRAM-SHA-256/SCRAM-SHA-512/OAUTHBEARER,default is PLAIN.
      # tls_sasl_mechanism = "PLAIN"
      # tls_sasl_plain_username = "user"
      # tls_sasl_plain_password = "pw"
      ## If tls_security_protocol is SASL_SSL, then ssl_cert must be configured.
      # ssl_cert = "/path/to/host.cert"
    
      ## -1:Offset Newest, -2:Offset Oldest
      offsets=-1
    
      ## skywalking custom
      #[inputs.kafkamq.skywalking]
      ## Required: send to datakit skywalking input.
      #  dk_endpoint="http://localhost:9529"
      #  thread = 8 
      #  topics = [
      #    "skywalking-metrics",
      #    "skywalking-profilings",
      #    "skywalking-segments",
      #    "skywalking-managements",
      #    "skywalking-meters",
      #    "skywalking-logging",
      #  ]
      #  namespace = ""
    
      ## Jaeger from kafka. Please make sure your Datakit Jaeger collector is open!
      #[inputs.kafkamq.jaeger]
      ## Required: ipv6 is "[::1]:9529"
      #  dk_endpoint="http://localhost:9529"
      #  thread = 8 
      #  source: agent,otel,others...
      #  source = "agent"
      #  # Required: topics
      #  topics=["jaeger-spans","jaeger-my-spans"]
    
      ## user custom message with PL script.
      #[inputs.kafkamq.custom]
        #spilt_json_body = true
        #thread = 8 
        ## spilt_topic_map determines whether to enable log splitting for specific topic based on the values in the spilt_topic_map[topic].
        #[inputs.kafkamq.custom.spilt_topic_map]
        #  "log_topic"=true
        #  "log01"=false
        #[inputs.kafkamq.custom.log_topic_map]
        #  "log_topic"="log.p"
        #  "log01"="log_01.p"
        #[inputs.kafkamq.custom.metric_topic_map]
        #  "metric_topic"="metric.p"
        #  "metric01"="rum_apm.p"
        #[inputs.kafkamq.custom.rum_topic_map]
        #  "rum_topic"="rum_01.p"
        #  "rum_02"="rum_02.p"
    
      #[inputs.kafkamq.remote_handle]
        ## Required
        #endpoint="http://localhost:8080"
        ## Required topics
        #topics=["spans","my-spans"]
        # send_message_count = 100
        # debug = false
        # is_response_point = true
        # header_check = false
      
      ## Receive and consume OTEL data from kafka.
      #[inputs.kafkamq.otel]
        #dk_endpoint="http://localhost:9529"
        #trace_api="/otel/v1/traces"
        #metric_api="/otel/v1/metrics"
        #trace_topics=["trace1","trace2"]
        #metric_topics=["otel-metric","otel-metric1"]
        #thread = 8 
    
      ## todo: add other input-mq
    
    ```

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector by injecting its configuration through a [ConfigMap method](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

---

> Note: Starting from v1.6.0, all support for sampling and rate limiting has been added; previous versions only supported custom messages.

Points to note in the configuration file:

1. `kafka_version`: Length is 3, e.g., `1.0.0`, `1.2.1`, etc.
2. `offsets`: Pay attention to whether it is `Newest` or `Oldest`.
3. `SASL`: If security authentication is enabled, configure the username and password correctly. If the Kafka listener address is in domain name format, add an IP mapping in `/etc/hosts`.
4. When using SSL, configure the certificate path in `ssl_cert`.
5. Starting from v1.23.0, multi-threaded mode is supported.

### Consumer Group and Message Partitioning {#consumer_group}

Currently, the collector uses consumer groups to consume messages from Kafka. Each partition of a message can only be consumed by one consumer, and each message can only be consumed by one consumer. This means that if a message has 5 partitions, up to 5 collectors can consume simultaneously. When a consumer goes offline or cannot consume, Kafka will reassign the consumption partition.

Thus, when the message volume is large, load balancing and throughput can be increased by opening more partitions and adding consumers.


### SkyWalking {#kafkamq-skywalking}

The Kafka plugin defaults to sending `traces/JVM Metrics/logging/Instance Properties/profiled snapshots` to the Kafka cluster.

This feature is disabled by default. To enable it, move *kafka-reporter-plugin-x.y.z.jar* from *agent/optional-reporter-plugins* to *agent/plugins*.

Configuration file and instructions:

```toml
# skywalking custom
[inputs.kafkamq.skywalking]

  # !!!Required: send to datakit skywalking input.
  dk_endpoint="http://localhost:9529"
  
  topics = [
    "skywalking-metrics",
    "skywalking-profilings",
    "skywalking-segments",
    "skywalking-managements",
    "skywalking-meters",
    "skywalking-logging",
  ]
  namespace = ""
```

Uncomment to activate the subscription. The subscribed topics are in the SkyWalking agent configuration file *config/agent.config*.

> Note: This collector only forwards the subscribed data to the Datakit SkyWalking collector. Please enable the [SkyWalking](skywalking.md) collector and uncomment `dk_endpoint`.

### Jaeger {#jaeger}

Configuration file:

```toml
# Jaeger from kafka. !!!Note: Make sure Datakit Jaeger collector is open.
[inputs.kafkamq.jaeger]
    ## !!!Required: ipv6 is "[::1]:9529"
    dk_endpoint="http://localhost:9529"
    
    ## !!!Required: topics 
    topics=["jaeger-spans","jaeger-my-spans"]
```

> Note: This collector only forwards the subscribed data to the Datakit Jaeger collector. Please enable the [jaeger](jaeger.md) collector and uncomment `dk_endpoint`.

### Custom Topic {#kafka-custom}

Sometimes users do not use common tools on the market, some third-party libraries are not open-source, and their data structures are not public. In such cases, manual processing according to the collected data structure is required, showcasing the power of Pipelines where users can subscribe and consume messages via custom configurations.

More often, the existing system already sends data to Kafka, but modifying the output becomes complex and difficult to implement due to iterations by developers and operations personnel. Using custom modes is an excellent way in this situation.

Configuration file:

```toml
# user custom message with PL script.
[inputs.kafkamq.custom]
# spilt_json_body = true
[inputs.kafkamq.custom.spilt_topic_map]
  "log_topic"=true
  "log01"=false
[inputs.kafkamq.custom.log_topic_map]
  "log_topic"="log.p"
  "log"="rum_apm.p"

[inputs.kafkamq.custom.metric_topic_map]
  "metric_topic"="rum_apm.p"
  
[inputs.kafkamq.custom.rum_topic_map]
  "rum"="rum.p"

```

> Note: The metric Pipeline script should be placed in the *pipeline/metric/* directory, and the RUM Pipeline script should be placed in the *pipeline/rum/* directory.

In theory, each message body should be a single log or metric. If your message contains multiple logs, you can enable global JSON array splitting functionality by turning on `spilt_json_body`. You can also enable JSON array splitting for individual Topics by using `spilt_topic_map`. When the data is a JSON array, combining it with PL can split the array into individual log or metric data.

### Consuming OpenTelemetry Data {#otel}

Configuration instructions:

```toml
  ## Receive and consume OTEL data from kafka.
  [inputs.kafkamq.otel]
      dk_endpoint="http://localhost:9529"
      trace_api="/otel/v1/traces" 
      metric_api="/otel/v1/metrics"
      trace_topics=["trace1","trace2"]
      metric_topics=["otel-metric","otel-metric1"]
```

The `dk_endpoint`, `trace_api`, and `metric_api` in the configuration file correspond to the DataKit address and OpenTelemetry collector API address.

> Note: Messages subscribed from Kafka will not be parsed directly but sent to the `OpenTelemetry` collector. Therefore, you must enable the [OpenTelemetry collector](opentelemetry.md). Currently, only the `x-protobuf` data stream format is supported.

### Example {#example}

Using a simple metric as an example, this section explains how to use custom configurations to subscribe to messages.

When unsure about the format of the data sent to Kafka, first change the DataKit log level to Debug. After enabling the subscription, check the DataKit logs for output. Assuming the following data is obtained:

```shell
  # After enabling the debug log level, view the logs. DataKit will print out the message information.
  tailf /var/log/datakit/log | grep "kafka_message"
```

Assuming the received data is a pure text string in JSON format for a metric:

```json
{"time": 1666492218, "dimensions": {"bk_biz_id": 225,"ip": "10.200.64.45" },  "metrics": { "cpu_usage_pct": 0.01}, "exemplar": null}
```

With the data format known, you can manually write a Pipeline script. Log in to 「<<< custom_key.brand_name >>> -> Manage -> Text Processing (Pipeline) Script Writing」. For example:

```python
  data = load_json(message)
  drop_origin_data()
  
  hostip = data["dimensions"]["ip"]
  bkzid = data["bk_biz_id"]
  cast(bkzid,"sttr")
  
  set_tag(hostip,hostip)
  set_tag(bk_biz_id,bkzid)
  
  add_key(cpu_usage_pct,data["metrics"]["cpu_usage_pct"])
  
  # Note: This is the default value for line protocol. After passing through the Pipeline script, this message_len can be deleted.
  drop_key(message_len)
```

Place the file in the */usr/local/datakit/pipeline/metric/* directory.

> Note: Place the metric data Pipeline script in the *metric/* directory and the logging data Pipeline script in the *pipeline/* directory.

After configuring the Pipeline script, restart DataKit.

## Handle {#handle}

Configuration file:

```toml
 [inputs.kafkamq.remote_handle]
    ## Required！
    endpoint="http://localhost:8080"
    ## Required！ topics
    topics=["spans","my-spans"]
    send_message_count = 100
    debug = false
    is_response_point = true
    # header_check = false
```

KafkaMQ provides a plugin mechanism: sending data ([]byte) via HTTP to an external handle, which can process the data and return it in line protocol format. This enables customized data handling.

Configuration instructions:

- `endpoint`: Handle address
- `send_message_count`: Number of messages sent at once.
- `topics`: Array of message topics
- `debug`: Boolean value. When debug is enabled, `message_points` is invalid. If debug mode is turned on, the original message body data is sent without merging messages.
- `is_response_point`: Whether to send back line protocol data
- `header_check`: Special header detection (customized for bfy and not universal)


After receiving messages, KafkaMQ merges them into a package containing `send_message_count` messages and sends it to the specified handle address. The data structure is as follows:

```txt
[
  {"topic": "bfySpan", "value": "dmFsdWUx"},
  {"topic": "bfySpan", "value": "dmFsdWUx"},
  {"topic": "bfySpan", "value": "dmFsdWUx"},
  {"topic": "bfySpan", "value": "dmFsdWUx"},
  ...
]
```

Returned data should follow the `v1/write/tracing` interface specification. [API Documentation](../datakit/apis.md#api-v1-write)

The returned header should indicate the type of data: default is `tracing`

```txt
X-category=tracing  
```

[DataKit Supported Data Types](../datakit/apis.md#category)

As long as the data is received, it indicates that KafkaMQ has successfully sent the data. Regardless of parsing, a 200 response should be returned, and the next request should be awaited.

If parsing fails, it is recommended to set `debug=true` in the KafkaMQ configuration. In this case, no JSON assembly or serialization will occur, and the request `body` will be the message itself.

---

External plugins have certain constraints:

- KafkaMQ receives data but does not handle deserialization, as this is a custom development task and cannot be used universally for all users.
- Data processed by external plugins can be sent to [dk apis](../datakit/apis.md#api-v1-write), or returned to KafkaMQ and then sent to <<< custom_key.brand_name >>>.
- Data returned via response to KafkaMQ must be in ***line protocol format***. If it's in `JSON` format, the header information must include: `Content-Type:application/json`. Additionally, the returned header should indicate the type: `X-category:tracing` representing this tracing information.
- External plugins should return 200 regardless of whether the data parsing succeeds or fails.
- If KafkaMQ encounters timeouts or port issues while sending data to external plugins, it will attempt to reconnect and stop consuming messages from Kafka.

## Benchmark {#benchmark}

Message consumption capacity is limited by network and bandwidth restrictions, so benchmark testing only measures Datakit's consumption capability, not IO capability. The machine configuration for this test is 4 cores, 8 threads, and 16GB of memory. During testing, CPU peaks at 60%~70%, and memory increases by 10%.

| Message Count | Time     | Consumption Capacity per Second (items) |
| -------------- | -------- | --------------------------------------- |
| 100k          | 5s~7s    | 16k                                    |
| 1000k         | 1m30s    | 11k                                    |

Additionally, reducing log output, disabling cgroup limits, increasing internal and external network bandwidth, etc., can increase consumption capacity.

### Load Balancing Multiple Datakits {#datakit-assignor}

When the message volume is large and a single Datakit cannot meet the consumption needs, multiple Datakits can be used for consumption. There are three points to note:

1. Ensure the Topic partition is not one (at least 2). This can be checked using the tool [`kafka-map`](https://github.com/dushixiang/kafka-map/releases){:target="_blank"}.
2. Ensure the KafkaMQ collector configuration is `assignor = "roundrobin"` (one kind of load balancing strategy), `group_id="datakit"` (the group name must be consistent, otherwise duplicate consumption will occur).
3. Ensure the producer sends messages to multiple partitions, methods vary by language, code examples are not provided here, please refer to relevant implementations.

## FAQ {#faq}

### :material-chat-question: Pipeline Script {#test_Pipeline}

When unsure whether the written Pipeline script splits correctly, you can use the test command:

```shell
datakit pipeline -P metric.p -T '{"time": 1666492218,"dimensions":{"bk_biz_id": 225,"ip": "172.253.64.45"},"metrics": {"cpu_usage_pct": 0.01}, "exemplar": null}'
```

After splitting correctly, you can verify the data by enabling [data recording function](../datakit/datakit-tools-how-to.md#enable-recorder) in *datakit.conf*.

Connection failure may be due to version issues. Please correctly fill in the Kafka version in the configuration file. Currently supported versions are: [0.8.2] - [3.3.1].

### :material-chat-question: Message Backlog {#message_backlog}

1. Enable multi-threaded mode to increase consumption capacity.
2. If performance reaches a bottleneck, expand physical memory and CPU.
3. Increase backend write capacity.
4. Remove any network bandwidth limitations.
5. Increase the number of collectors and expand the number of message partitions to allow more consumers to consume.
6. If the above solutions still fail to resolve the issue, you can use [bug-report](../datakit/why-no-data.md#bug-report){:target="_blank"} to collect runtime metrics for analysis.

Other questions: View through the `datakit monitor` command or `datakit monitor -V`.