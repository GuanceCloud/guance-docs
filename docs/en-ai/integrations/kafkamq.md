---
title: 'KafkaMQ'
summary: 'Collect existing metrics and log data via Kafka'
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

DataKit supports subscribing to messages from Kafka to collect trace, metrics, and log information. Currently supported are `SkyWalking`, `Jaeger`, and custom topics.

## Configuration {#config}

Sample configuration file:

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/kafkamq` directory under the DataKit installation directory, copy `kafkamq.conf.sample` and rename it to `kafkamq.conf`. Example as follows:
    
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
        #trace_api="/otel/v1/trace"
        #metric_api="/otel/v1/metric"
        #trace_topics=["trace1","trace2"]
        #metric_topics=["otel-metric","otel-metric1"]
        #thread = 8 
    
      ## todo: add other input-mq
    
    ```

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can inject the collector configuration through [ConfigMap method](../datakit/datakit-daemonset-deploy.md#configmap-setting) to enable the collector.
<!-- markdownlint-enable -->

---

> Note: Since v1.6.0, all support for sampling and rate limiting has been added. Previous versions only supported custom messages.

Points to note in the configuration file:

1. `kafka_version`: Length should be 3, e.g., `1.0.0`, `1.2.1`, etc.
2. `offsets`: Pay attention to whether it is `Newest` or `Oldest`.
3. `SASL`: If security authentication is enabled, configure the username and password correctly. If the Kafka listener address is a domain name, add an IP mapping in `/etc/hosts`.
4. When using SSL, configure the certificate path in `ssl_cert`.
5. Multi-threaded mode is supported starting from v1.23.0.

### Consumer Group and Message Partitioning {#consumer_group}

Currently, the collector uses consumer group mode to consume messages from Kafka. Each partition of a message can only be consumed by one consumer, meaning that if there are 5 partitions, up to 5 collectors can consume simultaneously. If a consumer goes offline or cannot consume, Kafka will reassign the consumption partition. Therefore, when the message volume is large, increasing the number of partitions and consumers can achieve load balancing and improve throughput.

### SkyWalking {#kafkamq-skywalking}

The Kafka plugin defaults to sending `traces/JVM metrics/logging/Instance Properties/profiled snapshots` to the Kafka cluster.

This feature is disabled by default. Place *kafka-reporter-plugin-x.y.z.jar* from *agent/optional-reporter-plugins* to *agent/plugins* to enable it.

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

Uncomment the configuration to enable subscription. The subscribed topics are specified in the SkyWalking agent configuration file *config/agent.config*.

> Note: This collector forwards subscribed data to the DataKit SkyWalking collector. Enable the [SkyWalking](skywalking.md) collector and uncomment `dk_endpoint`.

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

> Note: This collector forwards subscribed data to the DataKit Jaeger collector. Enable the [Jaeger](jaeger.md) collector and uncomment `dk_endpoint`.

### Custom Topics {#kafka-custom}

Sometimes users use tools that are not commonly available, and some third-party libraries are not open-source, with data structures not publicly known. In such cases, manual processing based on collected data structures is required, showcasing the power of Pipeline. Users can customize configurations to subscribe and consume messages.

Often, existing systems have already sent data to Kafka, and modifying outputs becomes complex due to development and operations iterations. Using custom mode is a good solution.

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

> Note: Metric Pipeline scripts should be placed in the *pipeline/metric/* directory, and RUM Pipeline scripts in the *pipeline/rum/* directory.

In theory, each message body should be a single log or metric. If your message contains multiple logs, you can enable global JSON array splitting with `spilt_json_body`, or use `spilt_topic_map` for per-topic JSON array splitting. When data is a JSON array, combined with PL, it can split into individual logs or metrics.

### Consuming OpenTelemetry Data {#otel}

Configuration description:

```toml
## Receive and consume OTEL data from kafka.
[inputs.kafkamq.otel]
    dk_endpoint="http://localhost:9529"
    trace_api="/otel/v1/trace" 
    metric_api="/otel/v1/metric"
    trace_topics=["trace1","trace2"]
    metric_topics=["otel-metric","otel-metric1"]
```

The `dk_endpoint`, `trace_api`, and `metric_api` in the configuration file correspond to DataKit's address and the OpenTelemetry collector's API address.

> Note: Messages subscribed from Kafka are not directly parsed but sent directly to the `OpenTelemetry` collector. Ensure the [OpenTelemetry collector](opentelemetry.md) is enabled. Only `x-protobuf` data stream format is supported.

### Example {#example}

Using a simple metric as an example, this section explains how to use custom configurations to subscribe to messages.

When unsure about the format of data sent to Kafka, set DataKit's log level to Debug. Once the subscription is opened, check the DataKit logs. Assume the following data is obtained:

```shell
# Set the log level to Debug and view logs; DataKit will print message information.
tailf /var/log/datakit/log | grep "kafka_message"
```

Assume the received data is a JSON-formatted string of a metric:

```json
{"time": 1666492218, "dimensions": {"bk_biz_id": 225,"ip": "10.200.64.45" },  "metrics": { "cpu_usage_pct": 0.01}, "exemplar": null}
```

With the data structure, manually write a Pipeline script. Log in to `Guance -> Management -> Text Processing (Pipeline)` to write the script, for example:

```python
data = load_json(message)
drop_origin_data()

hostip = data["dimensions"]["ip"]
bkzid = data["bk_biz_id"]
cast(bkzid,"sttr")

set_tag(hostip,hostip)
set_tag(bk_biz_id,bkzid)

add_key(cpu_usage_pct,data["metrics"]["cpu_usage_pct"])

# Note: This is the default value for line protocol. After the Pipeline script runs, this message_len can be deleted.
drop_key(message_len)
```

Place the file in */usr/local/datakit/pipeline/metric/*.

> Note: Place metric data Pipeline scripts in *metric/* and logging data Pipeline scripts in *pipeline/*.

After configuring the Pipeline script, restart DataKit.

## Handling {#handle}

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

KafkaMQ provides a plugin mechanism to send data ([]byte) via HTTP to an external handle. After processing, the data can be returned in line protocol format for customized data handling.

Configuration details:

- `endpoint`: Handle address
- `send_message_count`: Number of messages sent in one batch.
- `topics`: Array of message topics
- `debug`: Boolean value. When enabled, `message_points` is invalid, and raw message data is sent without merging.
- `is_response_point`: Whether to send back line protocol data.
- `header_check`: Special header checks (customized for bfy, not general).

KafkaMQ receives messages, merges them into a package containing `send_message_count` messages, and sends them to the specified handle address. The data structure is as follows:

```txt
[
  {"topic": "bfySpan", "value": "dmFsdWUx"},
  {"topic": "bfySpan", "value": "dmFsdWUx"},
  {"topic": "bfySpan", "value": "dmFsdWUx"},
  {"topic": "bfySpan", "value": "dmFsdWUx"},
  ...
]
```

Returned data should follow the `v1/write/tracing` interface specification. Refer to the [API documentation](../datakit/apis.md#api-v1-write).

The response header should specify the data type: default is `tracing`.

```txt
X-category=tracing  
```

Refer to [supported data types by DataKit](../datakit/apis.md#category).

Receiving data indicates successful delivery regardless of parsing. A 200 status code should always be returned. For failed parsing, set `debug=true` to avoid JSON assembly and serialization, sending the raw message body.

---

External plugins have certain constraints:

- KafkaMQ receives but does not parse or serialize data, as this is customized and not universal.
- Processed data can be sent to [dk apis](../datakit/apis.md#api-v1-write) or returned to KafkaMQ for forwarding to Guance.
- Returned data to KafkaMQ must be in **line protocol format**. If JSON, include header: `Content-Type:application/json` and type: `X-category:tracing`.
- External plugins should always return 200.
- KafkaMQ retries on timeouts or unavailable ports and stops consuming Kafka messages.

## Benchmark {#benchmark}

Message consumption capability is limited by network and bandwidth. This benchmark tests DataKit's consumption rather than IO capability. The test machine configuration is 4 cores, 8 threads, 16GB RAM. During testing, CPU peaks at 60%~70%, memory increases by 10%.

| Message Count | Time     | Consumption Rate (messages/sec) |
| ------------- | -------- | ------------------------------- |
| 100k          | 5s~7s    | 16k                             |
| 1000k         | 1m30s    | 11k                             |

Reducing log output, disabling cgroup limits, increasing internal and external bandwidth can enhance consumption capability.

### Load Balancing Multiple Datakits {#datakit-assignor}

For high message volumes, increase DataKit instances for consumption. Points to note:

1. Ensure Topic partitions are more than one (at least 2). Use tools like [`kafka-map`](https://github.com/dushixiang/kafka-map/releases){:target="_blank"} to check.
2. Ensure KafkaMQ collector configuration is `assignor = "roundrobin"` and `group_id="datakit"` (consistent group ID prevents duplicate consumption).
3. Ensure producers send messages to multiple partitions.

## FAQ {#faq}

### :material-chat-question: Pipeline Script Testing {#test_Pipeline}

To verify if a Pipeline script splits correctly, use the test command:

```shell
datakit pipeline -P metric.p -T '{"time": 1666492218,"dimensions":{"bk_biz_id": 225,"ip": "172.253.64.45"},"metrics": {"cpu_usage_pct": 0.01}, "exemplar": null}'
```

After verifying, enable [recording functionality](../datakit/datakit-tools-how-to.md#enable-recorder) in *datakit.conf* to check data correctness.

Connection failures may be due to version issues. Ensure correct Kafka version in the configuration file. Supported versions: [0.8.2] - [3.3.1]

### :material-chat-question: Message Backlog {#message_backlog}

1. Enable multi-threaded mode to increase consumption capacity.
2. Expand physical memory and CPU if performance bottlenecks occur.
3. Increase backend write capacity.
4. Remove any network bandwidth restrictions.
5. Increase the number of collectors and expand message partitions.
6. If these solutions do not resolve the issue, use [bug-report](../datakit/why-no-data.md#bug-report){:target="_blank"} to collect runtime metrics for analysis.

Other issues can be checked using `datakit monitor` or `datakit monitor -V`.