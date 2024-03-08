---
title     : 'OpenTelemetry'
summary   : '接收 OpenTelemetry 指标、日志、APM 数据'
__int_icon      : 'icon/opentelemetry'
dashboard :
  - desc  : 'Opentelemetry JVM 监控视图'
    path  : 'dashboard/zh/opentelemetry'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# OpenTelemetry
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

OpenTelemetry （以下简称 OTEL）是 CNCF 的一个可观测性项目，旨在提供可观测性领域的标准化方案，解决观测数据的数据模型、采集、处理、导出等的标准化问题。

OTEL 是一组标准和工具的集合，旨在管理观测类数据，如 trace、metrics、logs 等（未来可能有新的观测类数据类型出现）。

OTEL 提供与 vendor 无关的实现，根据用户的需要将观测类数据导出到不同的后端，如开源的 Prometheus、Jaeger、Datakit 或云厂商的服务中。

本篇旨在介绍如何在 Datakit 上配置并开启 OTEL 的数据接入，以及 Java、Go 的最佳实践。

> 版本说明：Datakit 目前只接入 OTEL-v1 版本的 `otlp` 数据。

## 配置 {#config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/opentelemetry` 目录，复制 `opentelemetry.conf.sample` 并命名为 `opentelemetry.conf`。示例如下：

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

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    可通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting) 或 [配置 ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) 开启采集器。

    也支持以环境变量的方式修改配置参数（需要在 ENV_DEFAULT_ENABLED_INPUTS 中加为默认采集器）：

    - **ENV_INPUT_OTEL_CUSTOMER_TAGS**
    
        标签白名单
    
        **Type**: JSON
    
        **ConfField**: `customer_tags`
    
        **Example**: `["sink_project", "custom.tag"]`
    
    - **ENV_INPUT_OTEL_KEEP_RARE_RESOURCE**
    
        保持稀有跟踪资源列表
    
        **Type**: Boolean
    
        **ConfField**: `keep_rare_resource`
    
        **Default**: false
    
    - **ENV_INPUT_OTEL_DEL_MESSAGE**
    
        删除 trace 消息
    
        **Type**: Boolean
    
        **ConfField**: `del_message`
    
        **Default**: false
    
    - **ENV_INPUT_OTEL_OMIT_ERR_STATUS**
    
        错误状态白名单
    
        **Type**: JSON
    
        **ConfField**: `omit_err_status`
    
        **Example**: ["404", "403", "400"]
    
    - **ENV_INPUT_OTEL_CLOSE_RESOURCE**
    
        忽略指定服务器的 tracing（正则匹配）
    
        **Type**: JSON
    
        **ConfField**: `close_resource`
    
        **Example**: {"service1":["resource1","other"],"service2":["resource2","other"]}
    
    - **ENV_INPUT_OTEL_SAMPLER**
    
        全局采样率
    
        **Type**: Float
    
        **ConfField**: `sampler`
    
        **Example**: 0.3
    
    - **ENV_INPUT_OTEL_THREADS**
    
        线程和缓存的数量
    
        **Type**: JSON
    
        **ConfField**: `threads`
    
        **Example**: {"buffer":1000, "threads":100}
    
    - **ENV_INPUT_OTEL_STORAGE**
    
        本地缓存路径和大小（MB）
    
        **Type**: JSON
    
        **ConfField**: `storage`
    
        **Example**: `{"storage":"./otel_storage", "capacity": 5120}`
    
    - **ENV_INPUT_OTEL_HTTP**
    
        代理 HTTP 配置
    
        **Type**: JSON
    
        **ConfField**: `http`
    
        **Example**: `{"enable":true, "http_status_ok": 200, "trace_api": "/otel/v1/trace", "metric_api": "/otel/v1/metric"}`
    
    - **ENV_INPUT_OTEL_GRPC**
    
        代理 GRPC 配置
    
        **Type**: JSON
    
        **ConfField**: `grpc`
    
        **Example**: {"trace_enable": true, "metric_enable": true, "addr": "127.0.0.1:4317"}
    
    - **ENV_INPUT_OTEL_EXPECTED_HEADERS**
    
        配置使用客户端的 HTTP 头
    
        **Type**: JSON
    
        **ConfField**: `expected_headers`
    
        **Example**: {"ex_version": "1.2.3", "ex_name": "env_resource_name"}
    
    - **ENV_INPUT_OTEL_TAGS**
    
        自定义标签。如果配置文件有同名标签，将会覆盖它
    
        **Type**: JSON
    
        **ConfField**: `tags`
    
        **Example**: {"k1":"v1", "k2":"v2", "k3":"v3"}

<!-- markdownlint-enable -->

### 注意事项 {#attentions}

1. 建议使用 gRPC 协议，gRPC 具有压缩率高、序列化快、效率更高等优点
2. 自 [Datakit 1.10.0](../datakit/changelog.md#cl-1.10.0) 版本开始，http 协议的路由是可配置的，默认请求路径（Trace/Metric）分别为 `/otel/v1/trace` 和 `/otel/v1/metric`
3. 在涉及到 `float/double` 类型数据时，会最多保留两位小数
4. HTTP 和 gRPC 都支持 gzip 压缩格式。在 exporter 中可配置环境变量来开启：`OTEL_EXPORTER_OTLP_COMPRESSION = gzip`, 默认是不会开启 gzip。
5. HTTP 协议请求格式同时支持 JSON 和 Protobuf 两种序列化格式。但 gRPC 仅支持 Protobuf 一种。

使用 OTEL HTTP exporter 时注意环境变量的配置，由于 Datakit 的默认配置是 `/otel/v1/trace` 和 `/otel/v1/metric`，所以想要使用 HTTP 协议的话，需要单独配置 `trace` 和 `metric`，

## SDK 常规配置 {#sdk-configuration}

| 命令                           | 说明                                         | 默认                    | 注意                                          |
|:------------------------------|:--------------------------------------------|:------------------------|:---------------------------------------------|
| `OTEL_SDK_DISABLED`           | 关闭 SDK                                     | false                   | 关闭后将不会产生任何链路指标信息                   |
| `OTEL_RESOURCE_ATTRIBUTES`    | "service.name=App,username=liu"             |                         | 每一个 span 中都会有该 tag 信息                  |
| `OTEL_SERVICE_NAME`           | 服务名，等效于上面 "service.name=App"           |                         | 优先级高于上面                                 |
| `OTEL_LOG_LEVEL`              | 日志级别                                      | `info`                  |                                              |
| `OTEL_PROPAGATORS`            | 透传协议                                      | `tracecontext,baggage`  |                                              |
| `OTEL_TRACES_SAMPLER`         | 采样                                         | `parentbased_always_on` |                                              |
| `OTEL_TRACES_SAMPLER_ARG`     | 配合上面采样 参数                              | 1.0                     | 0 - 1.0                                      |
| `OTEL_EXPORTER_OTLP_PROTOCOL` | 协议包括： `grpc`,`http/protobuf`,`http/json` | gRPC                    |                                              |
| `OTEL_EXPORTER_OTLP_ENDPOINT` | OTLP 地址                                    | <http://localhost:4317> | <http://datakit-endpoint:9529/otel/v1/trace> |
| `OTEL_TRACES_EXPORTER`        | 链路导出器                                    | `otlp`                  |                                              |


> 您可以将 `otel.javaagent.debug=true` 参数传递给 Agent 以查看调试日志。请注意，这些日志内容相当冗长，生产环境下谨慎使用。

## 链路 {#tracing}

Trace（链路）是由多个 span 组成的一条链路信息。
无论是单个服务还是一个服务集群，链路信息提供了一个请求发生到结束所经过的所有服务之间完整路径的集合。

Datakit 只接收 OTLP 的数据，OTLP 有三种数据类型： `gRPC` ， `http/protobuf` 和 `http/json` ，具体配置可以参考：

```shell
# OpenTelemetry 默认采用 gPRC 协议发送到 Datakit
-Dotel.exporter=otlp \
-Dotel.exporter.otlp.protocol=grpc \
-Dotel.exporter.otlp.endpoint=http://datakit-endpoint:4317

# 使用 http/protobuf 方式
-Dotel.exporter=otlp \
-Dotel.exporter.otlp.protocol=http/protobuf \
-Dotel.exporter.otlp.traces.endpoint=http://datakit-endpoint:9529/otel/v1/trace \
-Dotel.exporter.otlp.metrics.endpoint=http://datakit-endpoint:9529/otel/v1/metric 

# 使用 http/json 方式
-Dotel.exporter=otlp \
-Dotel.exporter.otlp.protocol=http/json \
-Dotel.exporter.otlp.traces.endpoint=http://datakit-endpoint:9529/otel/v1/trace \
-Dotel.exporter.otlp.metrics.endpoint=http://datakit-endpoint:9529/otel/v1/metric
```

### 链路采样 {#sample}

可以采用头部采样或者尾部采样，具体可以查看两篇最佳实践：

- 需要配合 collector 的尾部采样： [OpenTelemetry 采样最佳实践](../best-practices/cloud-native/opentelemetry-simpling.md)
- Agent 端的头部采样： [OpenTelemetry Java Agent 端采样策略](../best-practices/cloud-native/otel-agent-sampling.md)

### Tag {#tags}

从 DataKit 版本 [1.22.0](../datakit/changelog.md#cl-1.22.0) 开始，黑名单功能废弃。增加固定标签列表，只有在此列表中的才会提取到一级标签中，以下是固定列表：

| Attributes                 | tag                   | 说明                        |
|:---------------------------|:----------------------|:--------------------------|
| http.url                   | http_url              | HTTP 请求完整路径               |
| http.hostname              | http_hostname         | hostname                  |
| http.route                 | http_route            | 路由                        |
| http.status_code           | http_status_code      | 状态码                       |
| http.request.method        | http_request_method   | 请求方法                      |
| http.method                | http_method           | 同上                        |
| http.client_ip             | http_client_ip        | 客户端 IP                    |
| http.scheme                | http_scheme           | 请求协议                      |
| url.full                   | url_full              | 请求全路径                     |
| url.scheme                 | url_scheme            | 请求协议                      |
| url.path                   | url_path              | 请求路径                      |
| url.query                  | url_query             | 请求参数                      |
| span_kind                  | span_kind             | span 类型                   |
| db.system                  | db_system             | span 类型                   |
| db.operation               | db_operation          | DB 动作                     |
| db.name                    | db_name               | 数据库名称                     |
| db.statement               | db_statement          | 详细信息                      |
| server.address             | server_address        | 服务地址                      |
| net.host.name              | net_host_name         | 请求的 host                  |
| server.port                | server_port           | 服务端口号                     |
| net.host.port              | net_host_port         | 同上                        |
| network.peer.address       | network_peer_address  | 网络地址                      |
| network.peer.port          | network_peer_port     | 网络端口                      |
| network.transport          | network_transport     | 协议                        |
| messaging.system           | messaging_system      | 消息队列名称                    |
| messaging.operation        | messaging_operation   | 消息动作                      |
| messaging.message          | messaging_message     | 消息                        |
| messaging.destination      | messaging_destination | 消息详情                      |
| rpc.service                | rpc_service           | RPC 服务地址                  |
| rpc.system                 | rpc_system            | RPC 服务名称                  |
| error                      | error                 | 是否错误                      |
| error.message              | error_message         | 错误信息                      |
| error.stack                | error_stack           | 堆栈信息                      |
| error.type                 | error_type            | 错误类型                      |
| error.msg                  | error_message         | 错误信息                      |
| project                    | project               | project                   |
| version                    | version               | 版本                        |
| env                        | env                   | 环境                        |
| host                       | host                  | Attributes 中的 host 标签     |
| pod_name                   | pod_name              | Attributes 中的 pod_name 标签 |

如果想要增加自定义标签，可使用环境变量：

```shell
# 通过启动参数添加自定义标签
-Dotel.resource.attributes=username=myName,env=1.1.0
```

并修改配置文件中的白名单，这样就可以在观测云的链路详情的一级标签出现自定义的标签。

```toml
customer_tags = ["sink_project", "username","env"]
```

### Kind {#kind}

所有的 `Span` 都有 `span_kind` 标签，共有 6 中属性：

- `unspecified`:  未设置。
- `internal`:  内部 span 或子 span 类型。
- `server`:  WEB 服务、RPC 服务 等等。
- `client`:  客户端类型。
- `producer`:  消息的生产者。
- `consumer`:  消息的消费者。

### 示例 {#examples}

Datakit 目前提供了如下两种语言的最佳实践：

- [Golang](opentelemetry-go.md)
- [Java](opentelemetry-java.md)

## 指标 {#metric}

OpenTelemetry Java Agent 从应用程序中通过 JMX 协议获取 MBean 的指标信息，Java Agent 通过内部 SDK 报告选定的 JMX 指标，这意味着所有的指标都是可以配置的。

可以通过命令 `otel.jmx.enabled=true/false` 开启和关闭 JMX 指标采集，默认是开启的。

为了控制 MBean 检测尝试之间的时间间隔，可以使用 `otel.jmx.discovery.delay` 命令，该属性定义了在第一个和下一个检测周期之间通过的毫秒数。

另外 Agent 内置的一些三方软件的采集配置。具体可以参考： [GitHub OTEL JMX Metric](https://github.com/open-telemetry/opentelemetry-java-instrumentation/blob/main/instrumentation/jmx-metrics/javaagent/README.md){:target="_blank"}



### `opentelemetry`



- 标签


| Tag | Description |
|  ----  | --------|
|`action`|GC Action|
|`area`|Heap or not|
|`cause`|GC Cause|
|`container.id`|Container ID|
|`description`|Metric Description|
|`exception`|Exception Information|
|`gc`|GC Type|
|`host`|Host Name|
|`http.flavor`|HTTP Version|
|`http.method`|HTTP Method|
|`http.route`|HTTP Request Route|
|`http.scheme`|HTTP/HTTPS|
|`http.target`|HTTP Target|
|`id`|JVM Type|
|`instrumentation_name`|Metric Name|
|`level`|Log Level|
|`main-application-class`|Main Entry Point|
|`method`|HTTP Type|
|`name`|Thread Pool Name|
|`net.protocol.name`|Net Protocol Name|
|`net.protocol.version`|Net Protocol Version|
|`os.description`|OS Version|
|`os.type`|OS Type|
|`outcome`|HTTP Outcome|
|`path`|Disk Path|
|`pool`|JVM Pool Type|
|`process.command_line`|Process Command Line|
|`process.executable.path`|Executable File Path|
|`process.runtime.description`|Process Runtime Description|
|`process.runtime.name`|JVM Pool Runtime Name|
|`process.runtime.version`|JVM Pool Runtime Version|
|`service.name`|Service Name|
|`spanProcessorType`|Span Processor Type|
|`state`|Thread State|
|`status`|HTTP Status Code|
|`telemetry.auto.version`|Version|
|`telemetry.sdk.language`|Language|
|`telemetry.sdk.name`|SDK Name|
|`telemetry.sdk.version`|SDK Version|
|`uri`|HTTP Request URI|

- 指标列表


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



## 更多文档 {#more-readings}

- [Golang SDK](https://github.com/open-telemetry/opentelemetry-go){:target="_blank"}
- [官方使用手册](https://opentelemetry.io/docs/){:target="_blank"}
- [环境变量配置](https://github.com/open-telemetry/opentelemetry-java/blob/main/sdk-extensions/autoconfigure/README.md#otlp-exporter-both-span-and-metric-exporters){:target="_blank"}
- [观测云二次开发版本](https://github.com/GuanceCloud/opentelemetry-java-instrumentation){:target="_blank"}
