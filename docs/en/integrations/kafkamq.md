---
title: 'KafkaMQ'
summary: 'Collect existing Metrics and log data via Kafka'
tags:
  - 'Message Queue'
  - 'Logs'
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

Datakit supports subscribing to messages from Kafka for collecting trace, Metrics, and log information. Currently, it supports `SkyWalking`, `Jaeger`, and custom topics.

## Configuration {#config}

### Configuration File Example

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/kafkamq` directory under the DataKit installation directory, copy `kafkamq.conf.sample` and rename it to `kafkamq.conf`. An example is as follows:
    
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

    Currently, you can enable the collector by injecting the collector configuration via [ConfigMap method](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

---

> Note: Since v1.6.0, all support for sampling and rate limiting has been added. Previous versions only supported custom messages.

Points to note in the configuration file:

1. `kafka_version`: Length should be 3, e.g., `1.0.0`, `1.2.1`, etc.
2. `offsets`: Pay attention to whether it's `Newest` or `Oldest`.
3. `SASL`: If security authentication is enabled, configure the user and password correctly. If the Kafka listener address is a domain name, add an IP mapping in `/etc/hosts`.
4. When using SSL, configure the certificate path in `ssl_cert`.
5. Multi-threaded mode is supported starting from v1.23.0.

### Consumer Group and Message Partition {#consumer_group}

Currently, the collector uses the consumer group mode to consume messages from Kafka. Each partition of a message can only be consumed by one consumer, meaning that if there are 5 partitions, up to 5 collectors can consume simultaneously. If a consumer goes offline or cannot consume messages, Kafka will reassign the partitions. Therefore, when the message volume is large, increasing the number of partitions and consumers can achieve load balancing and improve throughput.

### SkyWalking {#kafkamq-skywalking}

The Kafka plugin defaults to sending `traces/JVM metrics/logging/Instance Properties/profiled snapshots` to the Kafka cluster.

This feature is disabled by default. Place *kafka-reporter-plugin-x.y.z.jar* from *agent/optional-reporter-plugins* to *agent/plugins* for it to take effect.

Configuration file and explanation:

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

Uncomment the above settings to enable subscription. The subscription topics are defined in the SkyWalking agent configuration file *config/agent.config*.

> Note: This collector forwards subscribed data to the DataKit SkyWalking collector. Ensure the [SkyWalking](skywalking.md) collector is enabled and uncomment `dk_endpoint`.

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

> Note: This collector forwards subscribed data to the DataKit Jaeger collector. Ensure the [Jaeger](jaeger.md) collector is enabled and uncomment `dk_endpoint`.

### Custom Topic {#kafka-custom}

Sometimes users use tools not commonly available on the market, some third-party libraries are not open-source, and their data structures are not public. In such cases, manual processing of collected data is required. This highlights the power of Pipeline, where users can subscribe and consume messages via custom configurations.

Often, existing systems already send data to Kafka, and modifying outputs becomes complex and difficult to implement with iterations. Using custom mode is a good solution in such scenarios.

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

> Note: Metric Pipeline scripts should be placed in the *pipeline/metric/* directory, and RUM Pipeline scripts should be placed in the *pipeline/rum/* directory.

In theory, each message body should be a single log or metric. If your message contains multiple logs, you can enable global JSON array slicing with `spilt_json_body` or use `spilt_topic_map` for per-topic JSON array slicing when the data is a JSON array. Combined with PL, this can split the array into individual log or metric entries.

### Consume OpenTelemetry Data {#otel}

Configuration details:

```toml
  ## Receive and consume OTEL data from kafka.
  [inputs.kafkamq.otel]
      dk_endpoint="http://localhost:9529"
      trace_api="/otel/v1/traces" 
      metric_api="/otel/v1/metrics"
      trace_topics=["trace1","trace2"]
      metric_topics=["otel-metric","otel-metric1"]
```

The `dk_endpoint`, `trace_api`, and `metric_api` in the configuration file correspond to DataKit's address and the OpenTelemetry collector's API address.

> Note: Messages subscribed from Kafka are not directly parsed but sent directly to the `OpenTelemetry` collector. Therefore, the [OpenTelemetry collector](opentelemetry.md) must be enabled. Currently, only `x-protobuf` data stream format is supported.

### Example {#example}

Using a simple metric as an example, this section explains how to use custom configurations to subscribe to messages.

When you don't know the structure of the data being sent to Kafka, you can first change DataKit's log level to Debug. Enable the subscription, and DataKit will print the message information in the logs. Suppose you get the following data:

```shell
  # After enabling debug log level, check the logs. DataKit will print out the message information.
  tailf /var/log/datakit/log | grep "kafka_message"
```

Assume the received data is a JSON formatted string representing a metric:

```json
{"time": 1666492218, "dimensions": {"bk_biz_id": 225,"ip": "10.200.64.45" },  "metrics": { "cpu_usage_pct": 0.01}, "exemplar": null}
```

With the data structure known, you can manually write a Pipeline script. Log in to 「Guance -> Manage -> Text Processing (Pipeline)」to write the script, for example:

```python
  data = load_json(message)
  drop_origin_data()
  
  hostip = data["dimensions"]["ip"]
  bkzid = data["bk_biz_id"]
  cast(bkzid,"sttr")
  
  set_tag(hostip,hostip)
  set_tag(bk_biz_id,bkzid)
  
  add_key(cpu_usage_pct,data["metrics"]["cpu_usage_pct"])
  
  # Note: This is the default value for line protocol. After the Pipeline script runs, this `message_len` can be deleted.
  drop_key(message_len)
```

Place the file in the */usr/local/datakit/pipeline/metric/* directory.

> Note: Place metric data Pipeline scripts in the *metric/* directory and logging data Pipeline scripts in the *pipeline/* directory.

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

KafkaMQ provides a plugin mechanism: sending data ([]byte) via HTTP to an external handle. After processing, the data can be returned in line protocol format for customized data handling.

Configuration details:

- `endpoint`: Handle address
- `send_message_count`: Number of messages sent at once.
- `topics`: Array of message topics
- `debug`: Boolean value. When debug is enabled, `message_points` is invalid. If debug mode is on, the original message body is sent without message merging.
- `is_response_point`: Whether to return line protocol data.
- `header_check`: Special header checks (customized for bfy, not general).

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

Returned data should follow the `v1/write/tracing` interface specification, [API documentation](../datakit/apis.md#api-v1-write).

The returned header should specify the data type: default is `tracing`

```txt
X-category=tracing  
```

[Supported data types by DataKit](../datakit/apis.md#category)

As long as data is received, KafkaMQ considers the data transmission successful regardless of parsing results. It should return 200 and wait for the next request.

If parsing fails, it is recommended to set `debug=true` in the KafkaMQ configuration. This prevents JSON assembly and serialization, and the `body` of the request will be the raw message.

---

External plugins have some constraints:

- KafkaMQ receives data but does not parse or serialize it, as this is customized development and cannot serve all users.
- Processed data from external plugins can be sent to [dk apis](../datakit/apis.md#api-v1-write) or returned to KafkaMQ and then sent to Guance.
- Data returned to KafkaMQ via response must be in ***line protocol format***. If in `JSON` format, include the header: `Content-Type:application/json` and specify the type: `X-category:tracing`.
- External plugins should return 200 upon receiving data, regardless of parsing success.
- If KafkaMQ encounters timeouts or port issues when sending data to external plugins, it will attempt to reconnect and stop consuming messages from Kafka.

## Benchmark {#benchmark}

Message consumption capacity is limited by network and bandwidth. Therefore, benchmarking tests Datakit's consumption capability rather than IO performance. The test machine configuration is 4 cores, 8 threads, 16GB RAM. During testing, CPU peaks at 60%~70%, memory usage increases by 10%.

| Message Count | Time   | Consumption Rate (messages/sec) |
| ------------- | ------ | ------------------------------- |
| 100k         | 5s~7s  | 16k                             |
| 1000k        | 1m30s  | 11k                             |

Reducing log output, disabling cgroup limits, increasing internal and external bandwidth can enhance consumption capability.

### Load Balancing Multiple Datakits {#datakit-assignor}

When message volume is high and a single Datakit's consumption capacity is insufficient, additional Datakits can be used. Points to note:

1. Ensure the topic has more than one partition (at least 2). Use tools like [`kafka-map`](https://github.com/dushixiang/kafka-map/releases){:target="_blank"} to check.
2. Ensure KafkaMQ collector configuration is `assignor = "roundrobin"` (one load-balancing strategy), `group_id="datakit"` (group name must be consistent to avoid duplicate consumption).
3. Ensure message producers send messages to multiple partitions. Methods vary by language; refer to relevant implementations.

## FAQ {#faq}

### :material-chat-question: Pipeline Script {#test_Pipeline}

To verify if a Pipeline script splits data correctly, use the test command:

```shell
datakit pipeline -P metric.p -T '{"time": 1666492218,"dimensions":{"bk_biz_id": 225,"ip": "172.253.64.45"},"metrics": {"cpu_usage_pct": 0.01}, "exemplar": null}'
```

After confirming correct splitting, enable [data recording](../datakit/datakit-tools-how-to.md#enable-recorder) in *datakit.conf* to verify data correctness.

Connection failures may be due to version mismatches. Ensure the correct Kafka version is specified in the configuration file. Supported versions: [0.8.2] - [3.3.1]

### :material-chat-question: Message Backlog {#message_backlog}

1. Enable multi-threaded mode to increase consumption capacity.
2. Expand physical memory and CPU if performance reaches a bottleneck.
3. Increase backend write capacity.
4. Remove any network bandwidth restrictions.
5. Add more collectors and expand message partitions to allow more consumers.
6. If these solutions do not resolve the issue, use [bug-report](../datakit/why-no-data.md#bug-report){:target="_blank"} to collect runtime metrics for analysis.

Other issues: Check with `datakit monitor` or `datakit monitor -V`.