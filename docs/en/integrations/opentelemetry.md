
# OpenTelemetry
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

OpenTelemetry (hereinafter referred to as OTEL) is an observability project of CNCF, which aims to provide a standardization scheme in the field of observability and solve the standardization problems of data model, collection, processing and export of observation data.

OTEL is a collection of standards and tools for managing observational data, such as trace, metrics, logs, etc. (new observational data types may appear in the future).

OTEL provides vendor-independent implementations that export observation class data to different backends, such as open source Prometheus, Jaeger, Datakit, or cloud vendor services, depending on the user's needs.

The purpose of this article is to introduce how to configure and enable OTEL data access on Datakit, and the best practices of Java and Go.

***Version Notes***: Datakit currently only accesses OTEL v1 version of otlp data.

<!-- markdownlint-disable MD046 -->
## Configuration {#config}

=== "Host Installation"

    Go to the `conf.d/opentelemetry` directory under the DataKit installation directory, copy `opentelemetry.conf.sample` and name it `opentelemetry.conf`. Examples are as follows:

    ```toml
        
    [[inputs.opentelemetry]]
      ## ignore_tags will work as a blacklist to prevent tags send to data center.
      ## Every value in this list is a valid string of regular expression.
      # ignore_tags = ["block1", "block2"]
    
      ## Keep rare tracing resources list switch.
      ## If some resources are rare enough(not presend in 1 hour), those resource will always send
      ## to data center and do not consider samplers and filters.
      # keep_rare_resource = false
    
      ## By default every error presents in span will be send to data center and omit any filters or
      ## sampler. If you want to get rid of some error status, you can set the error status list here.
      # omit_err_status = ["404"]
    
      ## compatible ddtrace: It is possible to compatible OTEL Trace with DDTrace trace
      # compatible_ddtrace=false
    
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
      ## trace : /otel/v1/trace
      ## metric: /otel/v1/metric
      ## and the client side should be configured properly with Datakit listening port(default: 9529)
      ## or custom HTTP request path.
      ## for example http://127.0.0.1:9529/otel/v1/trace
      ## The acceptable http_status_ok values will be 200 or 202.
      [inputs.opentelemetry.http]
       enable = true
       http_status_ok = 200
       trace_api = "/otel/v1/trace"
       metric_api = "/otel/v1/metric"
    
      ## OTEL agent GRPC config for trace and metrics.
      ## GRPC services for trace and metrics can be enabled respectively as setting either to be true.
      ## add is the listening on address for GRPC server.
      [inputs.opentelemetry.grpc]
       trace_enable = true
       metric_enable = true
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

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting).

    Multiple environment variables supported that can be used in Kubernetes showing below:

    | Envrionment Variable Name           | Type        | Example                                                                                                  |
    | ----------------------------------- | ----------- | -------------------------------------------------------------------------------------------------------- |
    | `ENV_INPUT_OTEL_IGNORE_TAGS`        | JSON string | `["block1", "block2"]`                                                                                   |
    | `ENV_INPUT_OTEL_KEEP_RARE_RESOURCE` | bool        | true                                                                                                     |
    | `ENV_INPUT_OTEL_OMIT_ERR_STATUS`    | JSON string | `["404", "403", "400"]`                                                                                  |
    | `ENV_INPUT_OTEL_CLOSE_RESOURCE`     | JSON string | `{"service1":["resource1"], "service2":["resource2"], "service3":["resource3"]}`                         |
    | `ENV_INPUT_OTEL_SAMPLER`            | float       | 0.3                                                                                                      |
    | `ENV_INPUT_OTEL_TAGS`               | JSON string | `{"k1":"v1", "k2":"v2", "k3":"v3"}`                                                                      |
    | `ENV_INPUT_OTEL_THREADS`            | JSON string | `{"buffer":1000, "threads":100}`                                                                         |
    | `ENV_INPUT_OTEL_STORAGE`            | JSON string | `{"storage":"./otel_storage", "capacity": 5120}`                                                         |
    | `ENV_INPUT_OTEL_HTTP`               | JSON string | `{"enable":true, "http_status_ok": 200, "trace_api": "/otel/v1/trace", "metric_api": "/otel/v1/metric"}` |
    | `ENV_INPUT_OTEL_GRPC`               | JSON string | `{"trace_enable": true, "metric_enable": true, "addr": "127.0.0.1:4317"}`                                |
    | `ENV_INPUT_OTEL_EXPECTED_HEADERS`   | JSON string | `{"ex_version": "1.2.3", "ex_name": "env_resource_name"}`                                                |

<!-- markdownlint-enable -->

### Notes {#attentions}

1. It is recommended to use grpc protocol, which has the advantages of high compression ratio, fast serialization and higher efficiency.
2. The route of the http protocol is configurable and the default request path is trace: `/otel/v1/trace`, metric:`/otel/v1/metric`
3. When data of type `float` `double` is involved, a maximum of two decimal places are reserved.
4. Both http and grpc support the gzip compression format. You can configure the environment variable in exporter to turn it on: `OTEL_EXPORTER_OTLP_COMPRESSION = gzip`; gzip is not turned on by default.
5. The http protocol request format supports both json and protobuf serialization formats. But grpc only supports protobuf.

Pay attention to the configuration of environment variables when using OTEL HTTP exporter. Since the default configuration of datakit is `/otel/v1/trace` and `/otel/v1/metric`,
if you want to use the HTTP protocol, you need to configure `trace` and `trace` separately `metric`,

The default request routes of otlp are `v1/traces` and `v1/metrics`, which need to be configured separately for these two. If you modify the routing in the configuration file, just replace the routing address below.

## General SDK Configuration {#sdk-configuration}

| Command                       | doc                                                     | default                 | note                                                                                                         |
|:------------------------------|:--------------------------------------------------------|:------------------------|:-------------------------------------------------------------------------------------------------------------|
| `OTEL_SDK_DISABLED`           | Disable the SDK for all signals                         | false                   | Boolean value. If “true”, a no-op SDK implementation will be used for all telemetry signals                  |
| `OTEL_RESOURCE_ATTRIBUTES`    | Key-value pairs to be used as resource attributes       |                         |                                                                                                              |
| `OTEL_SERVICE_NAME`           | Sets the value of the `service.name` resource attribute |                         | If `service.name` is also provided in `OTEL_RESOURCE_ATTRIBUTES`, then `OTEL_SERVICE_NAME` takes precedence. |
| `OTEL_LOG_LEVEL`              | Log level used by the SDK logger                        | `info`                  |                                                                                                              |
| `OTEL_PROPAGATORS`            | Propagators to be used as a comma-separated list        | `tracecontext,baggage`  | Values MUST be deduplicated in order to register a `Propagator` only once.                                   |
| `OTEL_TRACES_SAMPLER`         | Sampler to be used for traces                           | `parentbased_always_on` |                                                                                                              |
| `OTEL_TRACES_SAMPLER_ARG`     | String value to be used as the sampler argument         | 1.0                     | 0 - 1.0                                                                                                      |
| `OTEL_EXPORTER_OTLP_PROTOCOL` | `grpc`,`http/protobuf`,`http/json`                      | gRPC                    |                                                                                                              |
| `OTEL_EXPORTER_OTLP_ENDPOINT` | OTLP Addr                                               | <http://localhost:4317> | <http://datakit-endpoint:9529/otel/v1/trace>                                                                 |
| `OTEL_TRACES_EXPORTER`        | Trace Exporter                                          | `otlp`                  |                                                                                                              |

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
-Dotel.exporter.otlp.traces.endpoint=http://datakit-endpoint:9529/otel/v1/trace \
-Dotel.exporter.otlp.metrics.endpoint=http://datakit-endpoint:9529/otel/v1/metric 

# use http/json
-Dotel.exporter=otlp \
-Dotel.exporter.otlp.protocol=http/json \
-Dotel.exporter.otlp.traces.endpoint=http://datakit-endpoint:9529/otel/v1/trace \
-Dotel.exporter.otlp.metrics.endpoint=http://datakit-endpoint:9529/otel/v1/metric
```

### Best Practices {#bp}

Datakit currently provides [Go language](opentelemetry-go.md)、[Java](opentelemetry-java.md) languages, with other languages available later.

## Metric {#metric}

The OpenTelemetry Java Agent obtains the MBean's indicator information from the application through the JMX protocol, and the Java Agent reports the selected JMX indicator through the internal SDK, which means that all indicators are configurable.

You can enable and disable JMX metrics collection by command `otel.jmx.enabled=true/false`, which is enabled by default.

To control the time interval between MBean detection attempts, one can use the otel.jmx.discovery.delay property, which defines the number of milliseconds to elapse between the first and the next detection cycle.

In addition, the acquisition configuration of some third-party software built in the Agent. For details, please refer to: [JMX Metric Insight](https://github.com/open-telemetry/opentelemetry-java-instrumentation/blob/main/instrumentation/jmx-metrics/javaagent/README.md){:target="_blank"}



### `opentelemetry`



- tag


| Tag | Description |
|  ----  | --------|
|`action`|gc 动作|
|`area`|堆/非堆|
|`cause`|gc 原因|
|`container.id`|容器 ID|
|`description`|指标说明|
|`exception`|异常信息|
|`gc`|gc 类型|
|`host`|主机名|
|`http.flavor`|HTTP 版本|
|`http.method`|HTTP 请求类型|
|`http.route`|HTTP 请求路由|
|`http.scheme`|http/https|
|`http.target`|HTTP 请求目标|
|`id`|jvm 类型|
|`instrumentation_name`|指标名|
|`level`|日志级别|
|`main-application-class`|main 方法入口|
|`method`|HTTP 请求类型|
|`name`|线程池名称|
|`net.protocol.name`|网络协议名称|
|`net.protocol.version`|网络协议版本|
|`os.description`|操作系统版本信息|
|`os.type`|操作系统类型|
|`outcome`|http 结果|
|`path`|磁盘路径|
|`pool`|jvm 池类型|
|`process.command_line`|进程启动命令|
|`process.executable.path`|可执行文件路径|
|`process.runtime.description`|进程运行时说明|
|`process.runtime.name`|jvm 池类型|
|`process.runtime.version`|jvm 池类型|
|`service.name`|服务名称|
|`spanProcessorType`|span 处理器类型|
|`state`|线程状态|
|`status`|HTTP 状态码|
|`telemetry.auto.version`|代码版本|
|`telemetry.sdk.language`|语言|
|`telemetry.sdk.name`|SDK 名称|
|`telemetry.sdk.version`|SDK 版本|
|`uri`|http 请求路径|

- metric list


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



## More Docs {#more-readings}
- Go open source address [opentelemetry-go](https://github.com/open-telemetry/opentelemetry-go){:target="_blank"}
- Official user manual: [opentelemetry-io-docs](https://opentelemetry.io/docs/){:target="_blank"}
- Environment variable configuration: [sdk-extensions](https://github.com/open-telemetry/opentelemetry-java/blob/main/sdk-extensions/autoconfigure/README.md#otlp-exporter-both-span-and-metric-exporters){:target="_blank"}
- GitHub GuanceCloud version [opentelemetry-java-instrumentation](https://github.com/GuanceCloud/opentelemetry-java-instrumentation){:target="_blank"}
