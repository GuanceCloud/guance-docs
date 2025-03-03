---
title     : 'OpenTelemetry'
summary   : 'Collect OpenTelemetry metric, log and APM data'
tags      :
  - 'OTEL'
  - 'APM'
  - 'TRACING'
__int_icon      : 'icon/opentelemetry'
dashboard :
  - desc  : 'Opentelemetry JVM Monitoring View'
    path  : 'dashboard/en/opentelemetry'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

OpenTelemetry (hereinafter referred to as OTEL) is an observability project of CNCF, which aims to provide a standardization scheme in the field of observability and solve the standardization problems of data model, collection, processing and export of observation data.

OTEL is a collection of standards and tools for managing observational data, such as trace, metrics, logs, etc. (new observational data types may appear in the future).

OTEL provides vendor-independent implementations that export observation class data to different backends, such as open source Prometheus, Jaeger, Datakit, or cloud vendor services, depending on the user's needs.

The purpose of this article is to introduce how to configure and enable OTEL data access on Datakit, and the best practices of Java and Go.

<!-- markdownlint-disable MD046 -->
## Configuration {#config}

### Collector Configuration {#input-config}

=== "Host Installation"

    Go to the `conf.d/opentelemetry` directory under the DataKit installation directory, copy `opentelemetry.conf.sample` and name it `opentelemetry.conf`. Examples are as follows:

    ```toml
        
    [[inputs.opentelemetry]]
      ## customer_tags will work as a whitelist to prevent tags send to data center.
      ## All . will replace to _ ,like this :
      ## "project.name" to send to GuanCe center is "project_name"
      # customer_tags = ["sink_project", "custom.otel.tag"]
    
      ## Keep rare tracing resources list switch.
      ## If some resources are rare enough(not presend in 1 hour), those resource will always send
      ## to data center and do not consider samplers and filters.
      # keep_rare_resource = false
    
      ## By default every error presents in span will be send to data center and omit any filters or
      ## sampler. If you want to get rid of some error status, you can set the error status list here.
      # omit_err_status = ["404"]
    
      ## compatible ddtrace: It is possible to compatible OTEL Trace with DDTrace trace
      # compatible_ddtrace=false
    
      ## spilt service.name form xx.system.
      ## see: https://github.com/open-telemetry/semantic-conventions/blob/main/docs/database/database-spans.md
      spilt_service_name = true
    
      ## delete trace message
      # del_message = true
    
      ## Ignore tracing resources map like service:[resources...].
      ## The service name is the full service name in current application.
      ## The resource list is regular expressions uses to block resource names.
      ## If you want to block some resources universally under all services, you can set the
      ## service name as "*". Note: double quotes "" cannot be omitted.
      # [inputs.opentelemetry.close_resource]
        # service1 = ["resource1", "resource2", ...]
        # service2 = ["resource1", "resource2", ...]
        # "*" = ["close_resource_under_all_services"]
        # ...
    
      ## Sampler config uses to set global sampling strategy.
      ## sampling_rate used to set global sampling rate.
      # [inputs.opentelemetry.sampler]
        # sampling_rate = 1.0
    
      # [inputs.opentelemetry.tags]
        # key1 = "value1"
        # key2 = "value2"
        # ...
    
      ## Threads config controls how many goroutines an agent cloud start to handle HTTP request.
      ## buffer is the size of jobs' buffering of worker channel.
      ## threads is the total number fo goroutines at running time.
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
    
      ## If 'expected_headers' is well configed, then the obligation of sending certain wanted HTTP headers is on the client side,
      ## otherwise HTTP status code 400(bad request) will be provoked.
      ## Note: expected_headers will be effected on both trace and metrics if setted up.
      # [inputs.opentelemetry.expected_headers]
      # ex_version = "1.2.3"
      # ex_name = "env_resource_name"
      # ...
    
    ```

    Once configured, [Restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Can be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [Config ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) .

    Can also be turned on by environment variables, (needs to be added as the default collector in ENV_DEFAULT_ENABLED_INPUTS):
    
    - **ENV_INPUT_OTEL_CUSTOMER_TAGS**
    
        Whitelist to tags
    
        **Type**: JSON
    
        **input.conf**: `customer_tags`
    
        **Example**: [\"project_id\", \"custom.tag\"]
    
    - **ENV_INPUT_OTEL_KEEP_RARE_RESOURCE**
    
        Keep rare tracing resources list switch
    
        **Type**: Boolean
    
        **input.conf**: `keep_rare_resource`
    
        **Default**: false
    
    - **ENV_INPUT_OTEL_COMPATIBLE_DD_TRACE**
    
        Convert trace_id to decimal, compatible with DDTrace
    
        **Type**: Boolean
    
        **input.conf**: `compatible_dd_trace`
    
        **Default**: false
    
    - **ENV_INPUT_OTEL_SPILT_SERVICE_NAME**
    
        Get xx.system from span.Attributes to replace service name
    
        **Type**: Boolean
    
        **input.conf**: `spilt_service_name`
    
        **Default**: false
    
    - **ENV_INPUT_OTEL_DEL_MESSAGE**
    
        Delete trace message
    
        **Type**: Boolean
    
        **input.conf**: `del_message`
    
        **Default**: false
    
    - **ENV_INPUT_OTEL_OMIT_ERR_STATUS**
    
        Whitelist to error status
    
        **Type**: JSON
    
        **input.conf**: `omit_err_status`
    
        **Example**: ["404", "403", "400"]
    
    - **ENV_INPUT_OTEL_CLOSE_RESOURCE**
    
        Ignore tracing resources that service (regular)
    
        **Type**: JSON
    
        **input.conf**: `close_resource`
    
        **Example**: {"service1":["resource1","other"],"service2":["resource2","other"]}
    
    - **ENV_INPUT_OTEL_SAMPLER**
    
        Global sampling rate
    
        **Type**: Float
    
        **input.conf**: `sampler`
    
        **Example**: 0.3
    
    - **ENV_INPUT_OTEL_THREADS**
    
        Total number of threads and buffer
    
        **Type**: JSON
    
        **input.conf**: `threads`
    
        **Example**: {"buffer":1000, "threads":100}
    
    - **ENV_INPUT_OTEL_STORAGE**
    
        Local cache file path and size (MB) 
    
        **Type**: JSON
    
        **input.conf**: `storage`
    
        **Example**: `{"storage":"./otel_storage", "capacity": 5120}`
    
    - **ENV_INPUT_OTEL_HTTP**
    
        HTTP agent config
    
        **Type**: JSON
    
        **input.conf**: `http`
    
        **Example**: `{"enable":true, "http_status_ok": 200, "trace_api": "/otel/v1/traces", "metric_api": "/otel/v1/metrics"}`
    
    - **ENV_INPUT_OTEL_GRPC**
    
        GRPC agent config
    
        **Type**: JSON
    
        **input.conf**: `grpc`
    
        **Example**: {"trace_enable": true, "metric_enable": true, "addr": "127.0.0.1:4317"}
    
    - **ENV_INPUT_OTEL_EXPECTED_HEADERS**
    
        If 'expected_headers' is well config, then the obligation of sending certain wanted HTTP headers is on the client side
    
        **Type**: JSON
    
        **input.conf**: `expected_headers`
    
        **Example**: {"ex_version": "1.2.3", "ex_name": "env_resource_name"}
    
    - **ENV_INPUT_OTEL_TAGS**
    
        Customize tags. If there is a tag with the same name in the configuration file, it will be overwritten
    
        **Type**: JSON
    
        **input.conf**: `tags`
    
        **Example**: {"k1":"v1", "k2":"v2", "k3":"v3"}

<!-- markdownlint-enable -->

### Notes {#attentions}

1. It is recommended to use grpc protocol, which has the advantages of high compression ratio, fast serialization and higher efficiency.
2. The route of the http protocol is configurable and the default request path is trace: `/otel/v1/traces`, metric:`/otel/v1/metrics`,logs:`/otel/v1/logs`
3. When data of type `float` `double` is involved, a maximum of two decimal places are reserved.
4. Both http and grpc support the gzip compression format. You can configure the environment variable in exporter to turn it on: `OTEL_EXPORTER_OTLP_COMPRESSION = gzip`; gzip is not turned on by default.
5. The http protocol request format supports both JSON and Protobuf serialization formats. But grpc only supports Protobuf.

<!-- markdownlint-disable MD046 -->
???+ tips

    The service name in the DDTrace is named based on the service name or the referenced third-party library, while the service name of the OTEL collector is defined according to `otel.service.name`.
    To display service names separately, a field configuration has been added: spilt_service_name = true.
    The service name is extracted from the label of the link data. For example, if the label of the DB type is `db.system=mysql`, then the service name is Mysql. If it is the MQ type: `messaging.system=kafka`, then the service name is Kafka.
    By default, the following three tags are extracted: "db.system", "rpc.system", and "messaging.system".
<!-- markdownlint-enable -->

Pay attention to the configuration of environment variables when using OTEL HTTP exporter. Since the default configuration of Datakit is `/otel/v1/traces` and `/otel/v1/metrics`,
if you want to use the HTTP protocol, you need to configure `trace` and `trace` separately `metric`,

The default request routes of OTLP are `/otel/v1/logs` `v1/traces` and `v1/metrics`, which need to be configured separately for these two. If you modify the routing in the configuration file, just replace the routing address below.

## Agent V2 version {#v2}

The default OTLP protocol has been changed from `grpc` to `http/protobuf` in order to align with the specification.
You can switch to the `grpc` protocol using `OTEL_EXPORTER_OTLP_PROTOCOL=grpc` or `-Dotel.exporter.otlp.protocol=grpc`.

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

Use gPRC:

```shell
java -javaagent:/usr/local/ddtrace/opentelemetry-javaagent-2.5.0.jar \
  -Dotel.exporter=otlp \
  -Dotel.exporter.otlp.protocol=grpc \
  -Dotel.exporter.otlp.endpoint=http://localhost:4317
  -Dotel.service.name=app \
  -jar app.jar
```

The default log is enabled. If you want to turn off log collection, the exporter configuration can be empty: `-Dotel.logs.exporter=none`

For more major changes in the V2 version, please check the official documentation or [GitHub GuanCe Cloud](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/releases/tag/v2.11.0-guance){:target="_blank"} version notes


## General SDK Configuration {#sdk-configuration}

| ENV                           | Command                       | doc                                                     | default                 | note                                                                                                         |
|:------------------------------|:------------------------------|:--------------------------------------------------------|:------------------------|:-------------------------------------------------------------------------------------------------------------|
| `OTEL_SDK_DISABLED`           | `otel.sdk.disabled`           | Disable the SDK for all signals                         | false                   | Boolean value. If “true”, a no-op SDK implementation will be used for all telemetry signals                  |
| `OTEL_RESOURCE_ATTRIBUTES`    | `otel.resource.attributes`    | Key-value pairs to be used as resource attributes       |                         |                                                                                                              |
| `OTEL_SERVICE_NAME`           | `otel.service.name`           | Sets the value of the `service.name` resource attribute |                         | If `service.name` is also provided in `OTEL_RESOURCE_ATTRIBUTES`, then `OTEL_SERVICE_NAME` takes precedence. |
| `OTEL_LOG_LEVEL`              | `otel.log.level`              | Log level used by the SDK logger                        | `info`                  |                                                                                                              |
| `OTEL_PROPAGATORS`            | `otel.propagators`            | Propagators to be used as a comma-separated list        | `tracecontext,baggage`  | Values MUST be deduplicated in order to register a `Propagator` only once.                                   |
| `OTEL_TRACES_SAMPLER`         | `otel.traces.sampler`         | Sampler to be used for traces                           | `parentbased_always_on` |                                                                                                              |
| `OTEL_TRACES_SAMPLER_ARG`     | `otel.traces.sampler.arg`     | String value to be used as the sampler argument         | 1.0                     | 0 - 1.0                                                                                                      |
| `OTEL_EXPORTER_OTLP_PROTOCOL` | `otel.exporter.otlp.protocol` | `grpc`,`http/protobuf`,`http/json`                      | gRPC                    |                                                                                                              |
| `OTEL_EXPORTER_OTLP_ENDPOINT` | `otel.exporter.otlp.endpoint` | OTLP Addr                                               | <http://localhost:4317> | <http://datakit-endpoint:9529/otel/v1/traces>                                                                |
| `OTEL_TRACES_EXPORTER`        | `otel.traces.exporter`        | Trace Exporter                                          | `otlp`                  |                                                                                                              |
| `OTEL_LOGS_EXPORTER`          | `otel.logs.exporter`          | Logging Exporter                                        | `otlp`                  | default disable                                                                                              |

> You can pass the 'otel.javaagent.debug=true' parameter to the agent to view debugging logs. Please note that these logs are quite lengthy and should be used with caution in production environments.

## Tracing {#tracing}

Datakit only accepts OTLP data. OTLP has clear data types: `gRPC`, `http/protobuf` and `http/json`. For specific configuration, please refer to:

```shell
# OpenTelemetry Agent default is gRPC
-Dotel.exporter=otlp \
-Dotel.exporter.otlp.protocol=grpc \
-Dotel.exporter.otlp.endpoint=http://datakit-endpoint:4317

# use http/protobuf
-Dotel.exporter=otlp \
-Dotel.exporter.otlp.protocol=http/protobuf \
-Dotel.exporter.otlp.traces.endpoint=http://datakit-endpoint:9529/otel/v1/traces \
-Dotel.exporter.otlp.metrics.endpoint=http://datakit-endpoint:9529/otel/v1/metrics 

# use http/json
-Dotel.exporter=otlp \
-Dotel.exporter.otlp.protocol=http/json \
-Dotel.exporter.otlp.traces.endpoint=http://datakit-endpoint:9529/otel/v1/traces \
-Dotel.exporter.otlp.metrics.endpoint=http://datakit-endpoint:9529/otel/v1/metrics
```

### Tag {#tag}

Starting from DataKit version [1.22.0](../datakit/changelog.md#cl-1.22.0) ,`ignore_tags` is deprecated.
Add a fixed tags, only those in this list will be extracted into the tag. The following is the fixed list:

| Attributes            | tag                   |
|:----------------------|:----------------------|
| http.url              | http_url              |
| http.hostname         | http_hostname         |
| http.route            | http_route            |
| http.status_code      | http_status_code      |
| http.request.method   | http_request_method   |
| http.method           | http_method           |
| http.client_ip        | http_client_ip        |
| http.scheme           | http_scheme           |
| url.full              | url_full              |
| url.scheme            | url_scheme            |
| url.path              | url_path              |
| url.query             | url_query             |
| span_kind             | span_kind             |
| db.system             | db_system             |
| db.operation          | db_operation          |
| db.name               | db_name               |
| db.statement          | db_statement          |
| server.address        | server_address        |
| net.host.name         | net_host_name         |
| server.port           | server_port           |
| net.host.port         | net_host_port         |
| network.peer.address  | network_peer_address  |
| network.peer.port     | network_peer_port     |
| network.transport     | network_transport     |
| messaging.system      | messaging_system      |
| messaging.operation   | messaging_operation   |
| messaging.message     | messaging_message     |
| messaging.destination | messaging_destination |
| rpc.service           | rpc_service           |
| rpc.system            | rpc_system            |
| error                 | error                 |
| error.message         | error_message         |
| error.stack           | error_stack           |
| error.type            | error_type            |
| error.msg             | error_message         |
| project               | project               |
| version               | version               |
| env                   | env                   |
| host                  | host                  |
| pod_name              | pod_name              |
| pod_namespace         | pod_namespace         |

If you want to add custom labels, you can use environment variables:

```shell
-Dotel.resource.attributes=username=myName,env=1.1.0
```

And modify the whitelist in the configuration file so that a custom label can appear in the first level label of the Guance Cloud link details.

```toml
customer_tags = ["sink_project", "username","env"]
```

### Kind {#kind}

All `Span` has `span_kind` tag,

- `unspecified`: unspecified.
- `internal`: internal span.
- `server`:  WEB server or RPC server.
- `client`:  HTTP client or RPC client.
- `producer`:  message producer.
- `consumer`:  message consumer.


### Best Practices {#bp}

Datakit currently provides [Go language](opentelemetry-go.md)、[Java](opentelemetry-java.md) languages, with other languages available later.

## Metric {#metric}

The OpenTelemetry Java Agent obtains the MBean's indicator information from the application through the JMX protocol, and the Java Agent reports the selected JMX indicator through the internal SDK, which means that all indicators are configurable.

You can enable and disable JMX metrics collection by command `otel.jmx.enabled=true/false`, which is enabled by default.

To control the time interval between MBean detection attempts, one can use the OTEL.jmx.discovery.delay property, which defines the number of milliseconds to elapse between the first and the next detection cycle.

In addition, the acquisition configuration of some third-party software built in the Agent. For details, please refer to: [JMX Metric Insight](https://github.com/open-telemetry/opentelemetry-java-instrumentation/blob/main/instrumentation/jmx-metrics/javaagent/README.md){:target="_blank"}

All indicators sent to the observation cloud have a unified indicator set name: `otel-service`.



### `opentelemetry`



- Tags


| Tag | Description |
|  ----  | --------|
|`action`|GC Action|
|`area`|Heap or not|
|`cause`|GC Cause|
|`container_id`|Container ID|
|`description`|Metric Description|
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
|`jvm_gc_action`|action:end of major,end of minor GC|
|`jvm_gc_name`|name:PS MarkSweep,PS Scavenge|
|`jvm_memory_pool_name`|pool_name:code cache,PS Eden Space,PS Old Gen,MetaSpace...|
|`jvm_memory_type`|memory type:heap,non_heap|
|`jvm_thread_state`|Thread state:runnable,timed_waiting,waiting|
|`le`|*_bucket: histogram metric explicit bounds|
|`level`|Log Level|
|`main-application-class`|Main Entry Point|
|`method`|HTTP Type|
|`name`|Thread Pool Name|
|`net_protocol_name`|Net Protocol Name|
|`net_protocol_version`|Net Protocol Version|
|`os_description`|OS Version|
|`os_type`|OS Type|
|`outcome`|HTTP Outcome|
|`path`|Disk Path|
|`pool`|JVM Pool Type|
|`process_command_line`|Process Command Line|
|`process_executable_path`|Executable File Path|
|`process_runtime_description`|Process Runtime Description|
|`process_runtime_name`|JVM Pool Runtime Name|
|`process_runtime_version`|JVM Pool Runtime Version|
|`scope_name`|Scope name|
|`service_name`|Service Name|
|`spanProcessorType`|Span Processor Type|
|`state`|Thread State:idle,used|
|`status`|HTTP Status Code|
|`telemetry_auto_version`|Version|
|`telemetry_sdk_language`|Language|
|`telemetry_sdk_name`|SDK Name|
|`telemetry_sdk_version`|SDK Version|
|`unit`|metrics unit|
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
|`http.server.requests`|The http request count|float|count|
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



### ``



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



## Logging {#logging}

[:octicons-tag-24: Version-1.33.0](../datakit/changelog.md#cl-1.33.0)

“Standard output” LogRecord Exporter is a LogRecord Exporter which outputs the logs to stdout/console.

If a language provides a mechanism to automatically configure a LogRecordProcessor to pair with the associated exporter (e.g., using the `OTEL_LOGS_EXPORTER` environment variable),
by default the standard output exporter SHOULD be paired with a simple processor.

The `source` of the logs collected through OTEL is the `service.name`, and it can also be customized by adding tags such as `log.source`,
for example: `-Dotel.resource.attributes="log.source=sourcename"`.

You can [View logging documents](https://opentelemetry.io/docs/specs/otel/logs/sdk_exporters/stdout/){:target="_blank"}

> Note: If the app is running in a container environment (such as k8s), [Datakit will automatically collect logs](container-log.md#logging-stdout){:target="_blank"}. If `otel` collects logs again, there will be a problem of duplicate collection.
> It is recommended to manually [turn off Datakit's autonomous log](container-log.md#logging-with-image-config){:target="_blank"} collection behavior before enabling `otel` to collect logs.

## More Docs {#more-readings}

- Go open source address [OpenTelemetry-go](https://github.com/open-telemetry/opentelemetry-go){:target="_blank"}
- Official user manual: [opentelemetry-io-docs](https://opentelemetry.io/docs/){:target="_blank"}
- Environment variable configuration: [sdk-extensions](https://github.com/open-telemetry/opentelemetry-java/blob/main/sdk-extensions/autoconfigure/README.md#otlp-exporter-both-span-and-metric-exporters){:target="_blank"}
- GitHub GuanceCloud version [OpenTelemetry-Java-instrumentation](https://github.com/GuanceCloud/opentelemetry-java-instrumentation){:target="_blank"}
