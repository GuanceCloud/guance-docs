---
title     : 'OpenTelemetry'
summary   : 'Receive OpenTelemetry Metrics, logs, and APM data'
__int_icon: 'icon/opentelemetry'
tags      :
  - 'OTEL'
  - 'APM'
dashboard :
  - desc  : 'OpenTelemetry JVM monitoring view'
    path  : 'dashboard/zh/opentelemetry'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

OpenTelemetry (hereinafter referred to as OTEL) is an observability project of CNCF, aiming to provide a standardized solution in the observability field, solving the standardization problems of data model, collection, processing, and export of observability data.

OTEL is a set of standards and tools designed to manage observability data such as traces, metrics, and logs.

This article aims to introduce how to configure and enable OTEL data ingestion on Datakit, as well as best practices for Java and Go.


## Configuration {#config}

<!-- markdownlint-disable MD046 -->
=== "HOST installation"

    Enter the `conf.d/opentelemetry` directory under the DataKit installation directory, copy `opentelemetry.conf.sample` and rename it to `opentelemetry.conf`. Example as follows:

    ```toml
        
    [[inputs.opentelemetry]]
      ## customer_tags will work as a whitelist to prevent tags from being sent to the data center.
      ## All . will be replaced with _, like this:
      ## "project.name" sent to <<< custom_key.brand_name >>> center becomes "project_name"
      # customer_tags = ["sink_project", "custom.otel.tag"]
    
      ## Keep rare tracing resources list switch.
      ## If some resources are rare enough (not present in 1 hour), those resources will always be sent
      ## to the data center without considering samplers and filters.
      # keep_rare_resource = false
    
      ## By default, every error in span will be sent to the data center and ignore any filters or
      ## sampler. If you want to get rid of some error statuses, you can set the error status list here.
      # omit_err_status = ["404"]
    
      ## Compatible ddtrace: It is possible to make OTEL Trace compatible with DDTrace trace
      # compatible_ddtrace=false
    
      ## Split service.name form xx.system.
      ## see: https://github.com/open-telemetry/semantic-conventions/blob/main/docs/database/database-spans.md
      spilt_service_name = true
    
      ## Delete trace message
      # del_message = true
    
      ## Ignore tracing resources map like service:[resources...].
      ## The service name is the full service name in the current application.
      ## The resource list is regular expressions used to block resource names.
      ## If you want to block some resources universally under all services, you can set the
      ## service name as "*". Note: double quotes "" cannot be omitted.
      # [inputs.opentelemetry.close_resource]
        # service1 = ["resource1", "resource2", ...]
        # service2 = ["resource1", "resource2", ...]
        # "*" = ["close_resource_under_all_services"]
        # ...
    
      ## Sampler config used to set global sampling strategy.
      ## sampling_rate used to set global sampling rate.
      # [inputs.opentelemetry.sampler]
        # sampling_rate = 1.0
    
      # [inputs.opentelemetry.tags]
        # key1 = "value1"
        # key2 = "value2"
        # ...
    
      ## Threads config controls how many goroutines an agent can start to handle HTTP requests.
      ## buffer is the size of jobs' buffering of worker channel.
      ## threads is the total number of goroutines at running time.
      # [inputs.opentelemetry.threads]
        # buffer = 100
        # threads = 8
    
      ## Storage config a local storage space in hard dirver to cache trace data.
      ## path is the local file path used to cache data.
      ## capacity is total space size(MB) used to store data.
      # [inputs.opentelemetry.storage]
        # path = "./otel_storage"
        # capacity = 5120
    
      ## OTEL agent HTTP config for trace and metrics
      ## If enable set to be true, trace and metrics will be received on path respectively, by default is:
      ## trace : /otel/v1/traces
      ## metric: /otel/v1/metrics
      ## and the client side should be configured properly with Datakit listening port(default: 9529)
      ## or custom HTTP request path.
      ## for example http://127.0.0.1:9529/otel/v1/traces
      ## The acceptable http_status_ok values will be 200 or 202.
      [inputs.opentelemetry.http]
       http_status_ok = 200
       trace_api = "/otel/v1/traces"
       metric_api = "/otel/v1/metrics"
       logs_api = "/otel/v1/logs"
    
      ## OTEL agent GRPC config for trace and metrics.
      ## GRPC services for trace and metrics can be enabled respectively as setting either to be true.
      ## add is the listening on address for GRPC server.
      [inputs.opentelemetry.grpc]
       addr = "127.0.0.1:4317"
    
      ## If 'expected_headers' is well configured, then the obligation of sending certain wanted HTTP headers is on the client side,
      ## otherwise HTTP status code 400(bad request) will be provoked.
      ## Note: expected_headers will take effect on both trace and metrics if set up.
      # [inputs.opentelemetry.expected_headers]
      # ex_version = "1.2.3"
      # ex_name = "env_resource_name"
      # ...
    
    ```

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can enable the collector via [ConfigMap injection](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [configure ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting).

    Environment variables can also be used to modify configuration parameters (you need to add it as the default collector in ENV_DEFAULT_ENABLED_INPUTS):

    - **ENV_INPUT_OTEL_CUSTOMER_TAGS**
    
        Tag whitelist
    
        **Field type**: JSON
    
        **Collector configuration field**: `customer_tags`
    
        **Example**: [\"project_id\", \"custom.tag\"]
    
    - **ENV_INPUT_OTEL_KEEP_RARE_RESOURCE**
    
        Maintain a rare tracing resource list
    
        **Field type**: Boolean
    
        **Collector configuration field**: `keep_rare_resource`
    
        **Default value**: false
    
    - **ENV_INPUT_OTEL_COMPATIBLE_DD_TRACE**
    
        Convert trace_id to decimal, compatible with DDTrace
    
        **Field type**: Boolean
    
        **Collector configuration field**: `compatible_dd_trace`
    
        **Default value**: false
    
    - **ENV_INPUT_OTEL_SPILT_SERVICE_NAME**
    
        Get xx.system from span.Attributes to replace service name
    
        **Field type**: Boolean
    
        **Collector configuration field**: `spilt_service_name`
    
        **Default value**: false
    
    - **ENV_INPUT_OTEL_DEL_MESSAGE**
    
        Delete trace messages
    
        **Field type**: Boolean
    
        **Collector configuration field**: `del_message`
    
        **Default value**: false
    
    - **ENV_INPUT_OTEL_OMIT_ERR_STATUS**
    
        Error status whitelist
    
        **Field type**: JSON
    
        **Collector configuration field**: `omit_err_status`
    
        **Example**: ["404", "403", "400"]
    
    - **ENV_INPUT_OTEL_CLOSE_RESOURCE**
    
        Ignore specified servers' tracing (regex match)
    
        **Field type**: JSON
    
        **Collector configuration field**: `close_resource`
    
        **Example**: {"service1":["resource1","other"],"service2":["resource2","other"]}
    
    - **ENV_INPUT_OTEL_SAMPLER**
    
        Global sampling rate
    
        **Field type**: Float
    
        **Collector configuration field**: `sampler`
    
        **Example**: 0.3
    
    - **ENV_INPUT_OTEL_THREADS**
    
        Number of threads and cache
    
        **Field type**: JSON
    
        **Collector configuration field**: `threads`
    
        **Example**: {"buffer":1000, "threads":100}
    
    - **ENV_INPUT_OTEL_STORAGE**
    
        Local cache path and size (MB)
    
        **Field type**: JSON
    
        **Collector configuration field**: `storage`
    
        **Example**: `{"storage":"./otel_storage", "capacity": 5120}`
    
    - **ENV_INPUT_OTEL_HTTP**
    
        Proxy HTTP configuration
    
        **Field type**: JSON
    
        **Collector configuration field**: `http`
    
        **Example**: `{"enable":true, "http_status_ok": 200, "trace_api": "/otel/v1/traces", "metric_api": "/otel/v1/metrics"}`
    
    - **ENV_INPUT_OTEL_GRPC**
    
        Proxy GRPC configuration
    
        **Field type**: JSON
    
        **Collector configuration field**: `grpc`
    
        **Example**: {"trace_enable": true, "metric_enable": true, "addr": "127.0.0.1:4317"}
    
    - **ENV_INPUT_OTEL_EXPECTED_HEADERS**
    
        Configure using client's HTTP headers
    
        **Field type**: JSON
    
        **Collector configuration field**: `expected_headers`
    
        **Example**: {"ex_version": "1.2.3", "ex_name": "env_resource_name"}
    
    - **ENV_INPUT_OTEL_TAGS**
    
        Custom tags. If there are same-name tags in the configuration file, they will override them.
    
        **Field type**: JSON
    
        **Collector configuration field**: `tags`
    
        **Example**: {"k1":"v1", "k2":"v2", "k3":"v3"}

<!-- markdownlint-enable -->

### Notes {#attentions}

1. It is recommended to use gRPC protocol, which has advantages such as high compression ratio, fast serialization, and higher efficiency.
2. Since [Datakit 1.10.0](../datakit/changelog.md#cl-1.10.0), the HTTP protocol routes are configurable. Default request paths (Trace/Metric) are `/otel/v1/traces` `/otel/v1/logs`, and `/otel/v1/metrics`.
3. When dealing with `float/double` type data, only two decimal places will be retained.
4. Both HTTP and gRPC support gzip compression format. In exporter, environment variables can be configured to enable: `OTEL_EXPORTER_OTLP_COMPRESSION = gzip`. By default, gzip is not enabled.
5. HTTP protocol request format supports both JSON and Protobuf serialization formats. However, gRPC only supports Protobuf.

<!-- markdownlint-disable MD046 -->
???+ tips

    In DDTrace tracing data, the service name is based on the service name or referenced third-party libraries, whereas the service name in OTEL collectors is defined according to `otel.service.name`.
    To display the service name separately, a field configuration has been added: spilt_service_name = true
    The service name is extracted from the tags of the tracing data. For example, DB type tag `db.system=mysql` makes the service name Mysql; if it's MQ type: `messaging.system=kafka`, then the service name is Kafka.
    By default, these three tags are extracted: "db.system" "rpc.system" "messaging.system".
<!-- markdownlint-enable -->


When using OTEL HTTP exporter, pay attention to the environment variable configuration. Since Datakit's default configuration is `/otel/v1/traces` `/otel/v1/logs` and `/otel/v1/metrics`, if you want to use the HTTP protocol, you need to configure `trace` and `metric` separately,

## Agent V2 Version {#v2}

The V2 version uses `otlp exporter` by default, changing the previous `grpc` to `http/protobuf`. This can be set via the command `-Dotel.exporter.otlp.protocol=grpc`, or use the default `http/protobuf`.

If using HTTP, each exporter path needs explicit configuration, for example:

```shell
java -javaagent:/usr/local/ddtrace/opentelemetry-javaagent-2.5.0.jar \
  -Dotel.exporter=otlp \
  -Dotel.exporter.otlp.protocol=http/protobuf \
  -Dotel.exporter.otlp.logs.endpoint=http://localhost:9529/otel/v1/logs \
  -Dotel.exporter.otlp.traces.endpoint=http://localhost:9529/otel/v1/traces \
  -Dotel.exporter.otlp.metrics.endpoint=http://localhost:9529/otel/v1/metrics \
  -Dotel.service.name=app \
  -jar app.jar
```

If using gRPC protocol, it must be explicitly configured; otherwise, it defaults to HTTP protocol:

```shell
java -javaagent:/usr/local/ddtrace/opentelemetry-javaagent-2.5.0.jar \
  -Dotel.exporter=otlp \
  -Dotel.exporter.otlp.protocol=grpc \
  -Dotel.exporter.otlp.endpoint=http://localhost:4317
  -Dotel.service.name=app \
  -jar app.jar
```

Log collection is enabled by default. To disable log collection, set the exporter configuration to empty: `-Dotel.logs.exporter=none`

For more significant changes in V2, please refer to the official documentation or GitHub <<< custom_key.brand_name >>> version notes: [Github-GuanCe-v2.11.0](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/releases/tag/v2.11.0-guance){:target="_blank"}

## Common Commands {#sdk-configuration}

| ENV                           | Command                       | Description                                       | Default                    | Notes                                            |
|:------------------------------|:------------------------------|:-----------------------------------------|:------------------------|:----------------------------------------------|
| `OTEL_SDK_DISABLED`           | `otel.sdk.disabled`           | Disable SDK                                   | false                   | No link metric information will be generated after disabling                              |
| `OTEL_RESOURCE_ATTRIBUTES`    | `otel.resource.attributes`    | "service.name=App,username=liu"          |                         | Each span will have this tag information                         |
| `OTEL_SERVICE_NAME`           | `otel.service.name`           | Service name, equivalent to above "service.name=App"             |                                  | Higher priority than the one above                                       |
| `OTEL_LOG_LEVEL`              | `otel.log.level`              | Log level                                     | `info`                          |                                               |
| `OTEL_PROPAGATORS`            | `otel.propagators`            | Propagation protocol                                     | `tracecontext,baggage`          |                                               |
| `OTEL_TRACES_SAMPLER`         | `otel.traces.sampler`         | Sampling                                       | `parentbased_always_on`         |                                               |
| `OTEL_TRACES_SAMPLER_ARG`     | `otel.traces.sampler.arg`     | Sampling parameter                                | 1.0                             | 0 - 1.0                                       |
| `OTEL_EXPORTER_OTLP_PROTOCOL` | `otel.exporter.otlp.protocol` | Protocol includes: `grpc`,`http/protobuf`,`http/json` | gRPC                            |                                               |
| `OTEL_EXPORTER_OTLP_ENDPOINT` | `otel.exporter.otlp.endpoint` | OTLP address                                  | <http://localhost:4317>                  | <http://datakit-endpoint:9529/otel/v1/traces> |
| `OTEL_TRACES_EXPORTER`        | `otel.traces.exporter`        | Tracing exporter                                    | `otlp`                                   |                                               |
| `OTEL_LOGS_EXPORTER`          | `otel.logs.exporter`          | Logs exporter                                    | `otlp`                                   | OTEL V1 requires explicit configuration, otherwise it is not enabled by default                      |


> You can pass the parameter `otel.javaagent.debug=true` to the Agent to view debug logs. Please note that these logs are quite verbose and should be used cautiously in production environments.

## Tracing {#tracing}

Traces (links) consist of multiple spans forming a chain of information.
Whether it's a single service or a service cluster, link information provides a complete set of paths between all services traversed from the start to the end of a request.

Datakit only receives OTLP data. OTLP has three data types: `gRPC`, `http/protobuf`, and `http/json`. Specific configurations can be referenced as follows:

```shell
# OpenTelemetry sends data to Datakit using the gPRC protocol by default
-Dotel.exporter=otlp \
-Dotel.exporter.otlp.protocol=grpc \
-Dotel.exporter.otlp.endpoint=http://datakit-endpoint:4317

# Use http/protobuf method
-Dotel.exporter=otlp \
-Dotel.exporter.otlp.protocol=http/protobuf \
-Dotel.exporter.otlp.traces.endpoint=http://datakit-endpoint:9529/otel/v1/traces \
-Dotel.exporter.otlp.metrics.endpoint=http://datakit-endpoint:9529/otel/v1/metrics 

# Use http/json method
-Dotel.exporter=otlp \
-Dotel.exporter.otlp.protocol=http/json \
-Dotel.exporter.otlp.traces.endpoint=http://datakit-endpoint:9529/otel/v1/traces \
-Dotel.exporter.otlp.metrics.endpoint=http://datakit-endpoint:9529/otel/v1/metrics
```

### Trace Sampling {#sample}

You can use header-based or tail-based sampling. Refer to the following best practices:

- Tail-based sampling with collector: [OpenTelemetry Sampling Best Practices](../best-practices/cloud-native/opentelemetry-simpling.md)
- Header-based sampling on the Agent side: [OpenTelemetry Java Agent Sampling Strategy](../best-practices/cloud-native/otel-agent-sampling.md)

### Tags {#tags}

Starting from DataKit version [1.22.0](../datakit/changelog.md#cl-1.22.0), the blacklist feature has been deprecated. A fixed tag list has been added, and only items in this list will be extracted into first-level tags. Below is the fixed list:

| Attributes            | tag                   | Description                             |
|:----------------------|:----------------------|:-------------------------------|
| http.url              | http_url              | Full HTTP request path                    |
| http.hostname         | http_hostname         | hostname                       |
| http.route            | http_route            | Route                             |
| http.status_code      | http_status_code      | Status code                            |
| http.request.method   | http_request_method   | Request method                           |
| http.method           | http_method           | Same as above                             |
| http.client_ip        | http_client_ip        | Client IP                         |
| http.scheme           | http_scheme           | Request protocol                           |
| url.full              | url_full              | Full request path                          |
| url.scheme            | url_scheme            | Request protocol                           |
| url.path              | url_path              | Request path                           |
| url.query             | url_query             | Request parameters                           |
| span_kind             | span_kind             | Span type                        |
| db.system             | db_system             | Span type                        |
| db.operation          | db_operation          | DB action                          |
| db.name               | db_name               | Database name                          |
| db.statement          | db_statement          | Detailed information                           |
| server.address        | server_address        | Service address                           |
| net.host.name         | net_host_name         | Requested host                       |
| server.port           | server_port           | Server port number                          |
| net.host.port         | net_host_port         | Same as above                             |
| network.peer.address  | network_peer_address  | Network address                           |
| network.peer.port     | network_peer_port     | Network port                           |
| network.transport     | network_transport     | Protocol                             |
| messaging.system      | messaging_system      | Message queue name                         |
| messaging.operation   | messaging_operation   | Message action                           |
| messaging.message     | messaging_message     | Message                             |
| messaging.destination | messaging_destination | Message details                           |
| rpc.service           | rpc_service           | RPC service address                       |
| rpc.system            | rpc_system            | RPC service name                       |
| error                 | error                 | Whether an error occurred                           |
| error.message         | error_message         | Error information                           |
| error.stack           | error_stack           | Stack trace information                           |
| error.type            | error_type            | Error type                           |
| error.msg             | error_message         | Error information                           |
| project               | project               | Project                        |
| version               | version               | Version                             |
| env                   | env                   | Environment                             |
| host                  | host                  | Host tag in Attributes          |
| pod_name              | pod_name              | Pod_name tag in Attributes      |
| pod_namespace         | pod_namespace         | Pod_namespace tag in Attributes |

If you want to add custom tags, you can use environment variables:

```shell
# Add custom tags through startup parameters
-Dotel.resource.attributes=username=myName,env=1.1.0
```

And modify the whitelist in the configuration file so that custom tags can appear in the first-level tags of the detailed links in <<< custom_key.brand_name >>>.

```toml
customer_tags = ["sink_project", "username","env"]
```

### Kind {#kind}

All `Spans` have the `span_kind` tag, with six attributes:

- `unspecified`: Not set.
- `internal`: Internal span or sub-span type.
- `server`: WEB services, RPC services, etc.
- `client`: Client type.
- `producer`: Message producer.
- `consumer`: Message consumer.


## Metrics {#metric}

OpenTelemetry Java Agent collects MBean metrics from applications via the JMX protocol. The Java Agent reports selected JMX metrics through its internal SDK, meaning all metrics are configurable.

You can enable or disable JMX metric collection via the command `otel.jmx.enabled=true/false`. By default, it is enabled.

To control the time interval between MBean detection attempts, you can use the `otel.jmx.discovery.delay` command. This property defines the milliseconds between the first and next detection cycles.

Additionally, the Agent includes some built-in configurations for third-party software metrics. Refer to: [GitHub OTEL JMX Metric](https://github.com/open-telemetry/opentelemetry-java-instrumentation/blob/main/instrumentation/jmx-metrics/javaagent/README.md){:target="_blank"}

<!-- markdownlint-disable MD046 -->
???+ warning "metrics"

    Starting from version [DataKit 1.68.0](../datakit/changelog.md#cl-1.68.0), the name of the measurement sets has been changed:
    All metrics sent to <<< custom_key.brand_name >>> have a unified measurement set name: `otel_service`
    If you already have dashboards, export them and uniformly change `otel-serivce` to `otel_service` before re-importing.

<!-- markdownlint-enable -->

When transferring **Histogram** metrics to <<< custom_key.brand_name >>>, some special processing occurs:

- OpenTelemetry histograms are directly mapped to Prometheus histograms.
- Each bucket count is converted to Prometheus cumulative count format.
- For example, OpenTelemetry buckets `[0, 10)`、`[10, 50)`、`[50, 100)` are converted to Prometheus `_bucket` metrics with the `le` tag:

```text
  my_histogram_bucket{le="10"} 100
  my_histogram_bucket{le="50"} 200
  my_histogram_bucket{le="100"} 250
```

- The total number of observations in the OpenTelemetry histogram is converted to the Prometheus `_count` metric.
- The sum of the OpenTelemetry histogram is converted to the Prometheus `_sum` metric, with additional `_max` `_min`.

```text
  my_histogram_count 250
  my_histogram_max 100
  my_histogram_min 50
  my_histogram_sum 12345.67
```

Any metric ending with `_bucket` is histogram data and must have `_max` `_min` `_count` `sum` ending metrics.

In histogram data, you can classify using the `le(less or equal)` tag and filter based on the tag. You can check all metrics and tags in [OpenTelemetry Metrics](https://opentelemetry.io/docs/specs/semconv/){:target="_blank"}.

This conversion allows OpenTelemetry-collected histogram data to seamlessly integrate into Prometheus and leverage Prometheus's powerful query and visualization capabilities for analysis.



## Data Field Explanation {#fields}



### metrics



- Tags


| Tag | Description |
|  ----  | --------|
|`action`|GC Action|
|`area`|Heap or not|
|`cause`|GC Cause|
|`container_id`|Container ID|
|`exception`|Exception Information|
|`gc`|GC Type|
|`host`|Host Name|
|`host_arch`|Host arch|
|`host_name`|Host Name|
|`http.scheme`|HTTP/HTTPS|
|`http_method`|HTTP Method|
|`http_request_method`|HTTP Method|
|`http_response_status_code`|HTTP status code|
|`http_route`|HTTP Route|
|`id`|JVM Type|
|`instrumentation_name`|Metric Name|
|`jvm_gc_action`|Action:end of major,end of minor GC|
|`jvm_gc_name`|Name:PS MarkSweep,PS Scavenge|
|`jvm_memory_pool_name`|Pool_name:code cache,PS Eden Space,PS Old Gen,MetaSpace...|
|`jvm_memory_type`|Memory type:heap,non_heap|
|`jvm_thread_state`|Thread state:runnable,timed_waiting,waiting|
|`le`|*_bucket: histogram metric explicit bounds|
|`level`|Log Level|
|`main-application-class`|Main Entry Point|
|`method`|HTTP Type|
|`name`|Thread Pool Name|
|`net_protocol_name`|Net Protocol Name|
|`net_protocol_version`|Net Protocol Version|
|`os_type`|OS Type|
|`outcome`|HTTP Outcome|
|`path`|Disk Path|
|`pool`|JVM Pool Type|
|`scope_name`|Scope name|
|`service_name`|Service Name|
|`spanProcessorType`|Span Processor Type|
|`state`|Thread State:idle,used|
|`status`|HTTP Status Code|
|`unit`|Metrics unit|
|`uri`|HTTP Request URI|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`application.ready.time`|Time taken (ms) for the application to be ready to service requests|float|msec|
|`application.started.time`|Time taken (ms) to start the application|float|msec|
|`disk.free`|Usable space for path|float|B|
|`disk.total`|Total space for path|float|B|
|`executor.active`|The approximate number of threads that are actively executing tasks|float|count|
|`executor.completed`|The approximate total number of tasks that have completed execution|float|count|
|`executor.pool.core`|The core number of threads for the pool|float|B|
|`executor.pool.max`|The maximum allowed number of threads in the pool|float|count|
|`executor.pool.size`|The current number of threads in the pool|float|B|
|`executor.queue.remaining`|The number of additional elements that this queue can ideally accept without blocking|float|count|
|`executor.queued`|The approximate number of tasks that are queued for execution|float|count|
|`http.server.active_requests`|The number of concurrent HTTP requests that are currently in-flight|float|count|
|`http.server.duration`|The duration of the inbound HTTP request|float|ns|
|`http.server.request.duration`|The count of HTTP request duration time in each bucket|float|count|
|`http.server.requests`|The HTTP request count|float|count|
|`http.server.requests.max`|None|float|B|
|`http.server.response.size`|The size of HTTP response messages|float|B|
|`jvm.buffer.count`|An estimate of the number of buffers in the pool|float|count|
|`jvm.buffer.memory.used`|An estimate of the memory that the Java virtual machine is using for this buffer pool|float|B|
|`jvm.buffer.total.capacity`|An estimate of the total capacity of the buffers in this pool|float|B|
|`jvm.classes.loaded`|The number of classes that are currently loaded in the Java virtual machine|float|count|
|`jvm.classes.unloaded`|The total number of classes unloaded since the Java virtual machine has started execution|float|count|
|`jvm.gc.live.data.size`|Size of long-lived heap memory pool after reclamation|float|B|
|`jvm.gc.max.data.size`|Max size of long-lived heap memory pool|float|B|
|`jvm.gc.memory.allocated`|Incremented for an increase in the size of the (young) heap memory pool after one GC to before the next|float|B|
|`jvm.gc.memory.promoted`|Count of positive increases in the size of the old generation memory pool before GC to after GC|float|B|
|`jvm.gc.overhead`|An approximation of the percent of CPU time used by GC activities over the last look back period or since monitoring began, whichever is shorter, in the range [0..1]|int|count|
|`jvm.gc.pause`|Time spent in GC pause|float|nsec|
|`jvm.gc.pause.max`|Time spent in GC pause|float|msec|
|`jvm.memory.committed`|The amount of memory in bytes that is committed for the Java virtual machine to use|float|B|
|`jvm.memory.max`|The maximum amount of memory in bytes that can be used for memory management|float|B|
|`jvm.memory.usage.after.gc`|The percentage of long-lived heap pool used after the last GC event, in the range [0..1]|float|percent|
|`jvm.memory.used`|The amount of used memory|float|B|
|`jvm.threads.daemon`|The current number of live daemon threads|float|count|
|`jvm.threads.live`|The current number of live threads including both daemon and non-daemon threads|float|B|
|`jvm.threads.peak`|The peak live thread count since the Java virtual machine started or peak was reset|float|B|
|`jvm.threads.states`|The current number of threads having NEW state|float|B|
|`log4j2.events`|Number of fatal level log events|float|count|
|`otlp.exporter.exported`|OTLP exporter to remote|int|count|
|`otlp.exporter.seen`|OTLP exporter|int|count|
|`process.cpu.usage`|The "recent cpu usage" for the Java Virtual Machine process|float|percent|
|`process.files.max`|The maximum file descriptor count|float|count|
|`process.files.open`|The open file descriptor count|float|B|
|`process.runtime.jvm.buffer.count`|The number of buffers in the pool|float|count|
|`process.runtime.jvm.buffer.limit`|Total capacity of the buffers in this pool|float|B|
|`process.runtime.jvm.buffer.usage`|Memory that the Java virtual machine is using for this buffer pool|float|B|
|`process.runtime.jvm.classes.current_loaded`|Number of classes currently loaded|float|count|
|`process.runtime.jvm.classes.loaded`|Number of classes loaded since JVM start|int|count|
|`process.runtime.jvm.classes.unloaded`|Number of classes unloaded since JVM start|float|count|
|`process.runtime.jvm.cpu.utilization`|Recent cpu utilization for the process|float|B|
|`process.runtime.jvm.gc.duration`|Duration of JVM garbage collection actions|float|nsec|
|`process.runtime.jvm.memory.committed`|Measure of memory committed|float|B|
|`process.runtime.jvm.memory.init`|Measure of initial memory requested|float|B|
|`process.runtime.jvm.memory.limit`|Measure of max obtainable memory|float|B|
|`process.runtime.jvm.memory.usage`|Measure of memory used|float|B|
|`process.runtime.jvm.memory.usage_after_last_gc`|Measure of memory used after the most recent garbage collection event on this pool|float|B|
|`process.runtime.jvm.system.cpu.load_1m`|Average CPU load of the whole system for the last minute|float|percent|
|`process.runtime.jvm.system.cpu.utilization`|Recent cpu utilization for the whole system|float|percent|
|`process.runtime.jvm.threads.count`|Number of executing threads|float|count|
|`process.start.time`|Start time of the process since unix epoch|float|B|
|`process.uptime`|The uptime of the Java virtual machine|int|sec|
|`processedSpans`|The number of spans processed by the BatchSpanProcessor|int|count|
|`queueSize`|The number of spans queued|int|count|
|`system.cpu.count`|The number of processors available to the Java virtual machine|int|count|
|`system.cpu.usage`|The "recent cpu usage" for the whole system|float|percent|
|`system.load.average.1m`|The sum of the number of runnable entities queued to available processors and the number of runnable entities running on the available processors averaged over a period of time|float|count|



### tracing



- Tags


| Tag | Description |
|  ----  | --------|
|`container_host`|Container hostname. Available in OpenTelemetry. Optional.|
|`dk_fingerprint`|DataKit fingerprint is DataKit hostname|
|`endpoint`|Endpoint info. Available in SkyWalking, Zipkin. Optional.|
|`env`|Application environment info. Available in Jaeger. Optional.|
|`host`|Hostname.|
|`http_method`|HTTP request method name. Available in DDTrace, OpenTelemetry. Optional.|
|`http_route`|HTTP route. Optional.|
|`http_status_code`|HTTP response code. Available in DDTrace, OpenTelemetry. Optional.|
|`http_url`|HTTP URL. Optional.|
|`operation`|Span name|
|`project`|Project name. Available in Jaeger. Optional.|
|`service`|Service name. Optional.|
|`source_type`|Tracing source type|
|`span_type`|Span type|
|`status`|Span status|
|`version`|Application version info. Available in Jaeger. Optional.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`duration`|Duration of span|int|μs|
|`message`|Origin content of span|string|-|
|`parent_id`|Parent span ID of current span|string|-|
|`resource`|Resource name produce current span|string|-|
|`span_id`|Span id|string|-|
|`start`|start time of span.|int|usec|
|`trace_id`|Trace id|string|-|




## Deleted Tags in Metrics {#del-metric}

Many useless tags are reported in OTEL metrics. These are String types and due to excessive memory and bandwidth consumption, they have been removed and will not be uploaded to the <<< custom_key.brand_name >>> center.

These tags include:

```text
process.command_line
process.executable.path
process.runtime.description
process.runtime.name
process.runtime.version
telemetry.distro.name
telemetry.distro.version
telemetry.sdk.language
telemetry.sdk.name
telemetry.sdk.version
```

## Logging {#logging}

[:octicons-tag-24: Version-1.33.0](../datakit/changelog.md#cl-1.33.0)

Currently, JAVA Agent supports collecting `stdout` logs and sends them to DataKit using the [Standard output](https://opentelemetry.io/docs/specs/otel/logs/sdk_exporters/stdout/){:target="_blank"} method through the `otlp` protocol.

By default, `OTEL Agent` does not enable log collection and must be explicitly enabled via the command `otel.logs.exporter`:

```shell
# env
export OTEL_LOGS_EXPORTER=OTLP
export OTEL_EXPORTER_OTLP.ENDPOINT=http://<DataKit Addr>:4317
# other env
java -jar app.jar

# command
java -javaagent:/path/to/agnet.jar \
  -otel.logs.exporter=otlp \
  -Dotel.exporter.otlp.endpoint=http://<DataKit Addr>:4317 \
  -jar app.jar
```

The `source` of logs collected via OTEL is the service name but can be customized by adding tags: `log.source`, for example: `-Dotel.resource.attributes="log.source=source_name"`.

> Note: If the app runs in a container environment (such as k8s), Datakit would automatically collect logs (default behavior). Collecting logs again would cause duplicate collection issues. It is recommended to [manually disable Datakit's automatic log collection](container-log.md#logging-with-image-config){:target="_blank"} before enabling log collection.

More languages can be found in the [official documentation](https://opentelemetry.io/docs/specs/otel/logs/){:target="_blank"}

## Examples {#examples}

Datakit currently provides the following best practices fortwo languages:

- [Golang](opentelemetry-go.md)
- [Java](opentelemetry-java.md)


## More Documentation {#more-readings}

- [Golang SDK](https://github.com/open-telemetry/opentelemetry-go){:target="_blank"}
- [Official User Manual](https://opentelemetry.io/docs/){:target="_blank"}
- [Environment Variable Configuration](https://github.com/open-telemetry/opentelemetry-java/blob/main/sdk-extensions/autoconfigure/README.md#otlp-exporter-both-span-and-metric-exporters){:target="_blank"}
- [<<< custom_key.brand_name >>> Custom Development Version](https://github.com/GuanceCloud/opentelemetry-java-instrumentation){:target="_blank"}