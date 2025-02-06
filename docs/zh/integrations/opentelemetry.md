---
title     : 'OpenTelemetry'
summary   : '接收 OpenTelemetry 指标、日志、APM 数据'
__int_icon: 'icon/opentelemetry'
tags      :
  - 'OTEL'
  - '链路追踪'
dashboard :
  - desc  : 'Opentelemetry JVM 监控视图'
    path  : 'dashboard/zh/opentelemetry'
monitor   :
  - desc  : '暂无'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

OpenTelemetry （以下简称 OTEL）是 CNCF 的一个可观测性项目，旨在提供可观测性领域的标准化方案，解决观测数据的数据模型、采集、处理、导出等的标准化问题。

OTEL 是一组标准和工具的集合，旨在管理观测类数据，如 trace、metrics、logs 。

本篇旨在介绍如何在 Datakit 上配置并开启 OTEL 的数据接入，以及 Java、Go 的最佳实践。


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
      ## trace : /otel/v1/trace
      ## metric: /otel/v1/metric
      ## and the client side should be configured properly with Datakit listening port(default: 9529)
      ## or custom HTTP request path.
      ## for example http://127.0.0.1:9529/otel/v1/trace
      ## The acceptable http_status_ok values will be 200 or 202.
      [inputs.opentelemetry.http]
       http_status_ok = 200
       trace_api = "/otel/v1/trace"
       metric_api = "/otel/v1/metric"
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

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    可通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting) 或 [配置 ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) 开启采集器。

    也支持以环境变量的方式修改配置参数（需要在 ENV_DEFAULT_ENABLED_INPUTS 中加为默认采集器）：

    - **ENV_INPUT_OTEL_CUSTOMER_TAGS**
    
        标签白名单
    
        **字段类型**: JSON
    
        **采集器配置字段**: `customer_tags`
    
        **示例**: `["sink_project", "custom.tag"]`
    
    - **ENV_INPUT_OTEL_KEEP_RARE_RESOURCE**
    
        保持稀有跟踪资源列表
    
        **字段类型**: Boolean
    
        **采集器配置字段**: `keep_rare_resource`
    
        **默认值**: false
    
    - **ENV_INPUT_OTEL_COMPATIBLE_DD_TRACE**
    
        将 trace_id 转成 10 进制，兼容 DDTrace
    
        **字段类型**: Boolean
    
        **采集器配置字段**: `compatible_dd_trace`
    
        **默认值**: false
    
    - **ENV_INPUT_OTEL_SPILT_SERVICE_NAME**
    
        从 span.Attributes 中获取 xx.system 去替换服务名
    
        **字段类型**: Boolean
    
        **采集器配置字段**: `spilt_service_name`
    
        **默认值**: false
    
    - **ENV_INPUT_OTEL_DEL_MESSAGE**
    
        删除 trace 消息
    
        **字段类型**: Boolean
    
        **采集器配置字段**: `del_message`
    
        **默认值**: false
    
    - **ENV_INPUT_OTEL_OMIT_ERR_STATUS**
    
        错误状态白名单
    
        **字段类型**: JSON
    
        **采集器配置字段**: `omit_err_status`
    
        **示例**: ["404", "403", "400"]
    
    - **ENV_INPUT_OTEL_CLOSE_RESOURCE**
    
        忽略指定服务器的 tracing（正则匹配）
    
        **字段类型**: JSON
    
        **采集器配置字段**: `close_resource`
    
        **示例**: {"service1":["resource1","other"],"service2":["resource2","other"]}
    
    - **ENV_INPUT_OTEL_SAMPLER**
    
        全局采样率
    
        **字段类型**: Float
    
        **采集器配置字段**: `sampler`
    
        **示例**: 0.3
    
    - **ENV_INPUT_OTEL_THREADS**
    
        线程和缓存的数量
    
        **字段类型**: JSON
    
        **采集器配置字段**: `threads`
    
        **示例**: {"buffer":1000, "threads":100}
    
    - **ENV_INPUT_OTEL_STORAGE**
    
        本地缓存路径和大小（MB）
    
        **字段类型**: JSON
    
        **采集器配置字段**: `storage`
    
        **示例**: `{"storage":"./otel_storage", "capacity": 5120}`
    
    - **ENV_INPUT_OTEL_HTTP**
    
        代理 HTTP 配置
    
        **字段类型**: JSON
    
        **采集器配置字段**: `http`
    
        **示例**: `{"enable":true, "http_status_ok": 200, "trace_api": "/otel/v1/trace", "metric_api": "/otel/v1/metric"}`
    
    - **ENV_INPUT_OTEL_GRPC**
    
        代理 GRPC 配置
    
        **字段类型**: JSON
    
        **采集器配置字段**: `grpc`
    
        **示例**: {"trace_enable": true, "metric_enable": true, "addr": "127.0.0.1:4317"}
    
    - **ENV_INPUT_OTEL_EXPECTED_HEADERS**
    
        配置使用客户端的 HTTP 头
    
        **字段类型**: JSON
    
        **采集器配置字段**: `expected_headers`
    
        **示例**: {"ex_version": "1.2.3", "ex_name": "env_resource_name"}
    
    - **ENV_INPUT_OTEL_TAGS**
    
        自定义标签。如果配置文件有同名标签，将会覆盖它
    
        **字段类型**: JSON
    
        **采集器配置字段**: `tags`
    
        **示例**: {"k1":"v1", "k2":"v2", "k3":"v3"}

<!-- markdownlint-enable -->

### 注意事项 {#attentions}

1. 建议使用 gRPC 协议，gRPC 具有压缩率高、序列化快、效率更高等优点
2. 自 [Datakit 1.10.0](../datakit/changelog.md#cl-1.10.0) 版本开始，http 协议的路由是可配置的，默认请求路径（Trace/Metric）分别为 `/otel/v1/trace` `/otel/v1/logs` 以及 `/otel/v1/metric`
3. 在涉及到 `float/double` 类型数据时，会最多保留两位小数
4. HTTP 和 gRPC 都支持 gzip 压缩格式。在 exporter 中可配置环境变量来开启：`OTEL_EXPORTER_OTLP_COMPRESSION = gzip`, 默认是不会开启 gzip。
5. HTTP 协议请求格式同时支持 JSON 和 Protobuf 两种序列化格式。但 gRPC 仅支持 Protobuf 一种。

<!-- markdownlint-disable MD046 -->
???+ tips

    DDTrace 链路数据中的服务名是根据服务名或者引用的三方库命名的，而 OTEL 采集器的服务名是按照 `otel.service.name` 定义的。
    为了分开显示服务名，增加了一个字段配置：spilt_service_name = true
    服务名从链路数据的标签中取出，比如 DB 类型的标签 `db.system=mysql` 那么 服务名就是 Mysql 如果是 MQ 类型：`messaging.system=kafka` ，那么服务名就是 Kafka 。
    默认从这三个标签中取出："db.system" "rpc.system" "messaging.system".
<!-- markdownlint-enable -->


使用 OTEL HTTP exporter 时注意环境变量的配置，由于 Datakit 的默认配置是 `/otel/v1/trace` `/otel/v1/logs` 和 `/otel/v1/metric`，所以想要使用 HTTP 协议的话，需要单独配置 `trace` 和 `metric`，

## Agent V2 版本 {#v2}

V2 版本默认使用 `otlp exporter` 将之前的 `grpc` 改为 `http/protobuf` ， 可以通过命令 `-Dotel.exporter.otlp.protocol=grpc` 设置，或者使用默认的 `http/protobuf`

使用 http 的话，每个 exporter 路径需要显性配置 如：

```shell
java -javaagent:/usr/local/ddtrace/opentelemetry-javaagent-2.5.0.jar \
  -Dotel.exporter=otlp \
  -Dotel.exporter.otlp.protocol=http/protobuf \
  -Dotel.exporter.otlp.logs.endpoint=http://localhost:9529/otel/v1/logs \
  -Dotel.exporter.otlp.traces.endpoint=http://localhost:9529/otel/v1/trace \
  -Dotel.exporter.otlp.metrics.endpoint=http://localhost:9529/otel/v1/metric \
  -Dotel.service.name=app \
  -jar app.jar
```

使用 gRPC 协议的话，必须是显式配置，否则就是默认的 http 协议：

```shell
java -javaagent:/usr/local/ddtrace/opentelemetry-javaagent-2.5.0.jar \
  -Dotel.exporter=otlp \
  -Dotel.exporter.otlp.protocol=grpc \
  -Dotel.exporter.otlp.endpoint=http://localhost:4317
  -Dotel.service.name=app \
  -jar app.jar
```

默认日志是开启的，要关闭日志采集的话，exporter 配置为空即可：`-Dotel.logs.exporter=none`

更多关于 V2 版本的重大修改请查看官方文档或者 GitHub 观测云版本说明： [Github-GuanCe-v2.11.0](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/releases/tag/v2.11.0-guance){:target="_blank"}

## 常规命令 {#sdk-configuration}

| ENV                           | Command                       | 说明                                       | 默认                    | 注意                                           |
|:------------------------------|:------------------------------|:-----------------------------------------|:------------------------|:---------------------------------------------|
| `OTEL_SDK_DISABLED`           | `otel.sdk.disabled`           | 关闭 SDK                                   | false                   | 关闭后将不会产生任何链路指标信息                             |
| `OTEL_RESOURCE_ATTRIBUTES`    | `otel.resource.attributes`    | "service.name=App,username=liu"          |                         | 每一个 span 中都会有该 tag 信息                        |
| `OTEL_SERVICE_NAME`           | `otel.service.name`           | 服务名，等效于上面 "service.name=App"             |                                  | 优先级高于上面                                      |
| `OTEL_LOG_LEVEL`              | `otel.log.level`              | 日志级别                                     | `info`                          |                                              |
| `OTEL_PROPAGATORS`            | `otel.propagators`            | 透传协议                                     | `tracecontext,baggage`          |                                              |
| `OTEL_TRACES_SAMPLER`         | `otel.traces.sampler`         | 采样                                       | `parentbased_always_on`         |                                              |
| `OTEL_TRACES_SAMPLER_ARG`     | `otel.traces.sampler.arg`     | 配合上面采样 参数                                | 1.0                             | 0 - 1.0                                      |
| `OTEL_EXPORTER_OTLP_PROTOCOL` | `otel.exporter.otlp.protocol` | 协议包括： `grpc`,`http/protobuf`,`http/json` | gRPC                            |                                              |
| `OTEL_EXPORTER_OTLP_ENDPOINT` | `otel.exporter.otlp.endpoint` | OTLP 地址                                  | <http://localhost:4317>                  | <http://datakit-endpoint:9529/otel/v1/trace> |
| `OTEL_TRACES_EXPORTER`        | `otel.traces.exporter`        | 链路导出器                                    | `otlp`                                   |                                              |
| `OTEL_LOGS_EXPORTER`          | `otel.logs.exporter`          | 日志导出器                                    | `otlp`                                   | OTEL V1 版本需要显式配置，否则默认不开启                     |


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

| Attributes            | tag                   | 说明                             |
|:----------------------|:----------------------|:-------------------------------|
| http.url              | http_url              | HTTP 请求完整路径                    |
| http.hostname         | http_hostname         | hostname                       |
| http.route            | http_route            | 路由                             |
| http.status_code      | http_status_code      | 状态码                            |
| http.request.method   | http_request_method   | 请求方法                           |
| http.method           | http_method           | 同上                             |
| http.client_ip        | http_client_ip        | 客户端 IP                         |
| http.scheme           | http_scheme           | 请求协议                           |
| url.full              | url_full              | 请求全路径                          |
| url.scheme            | url_scheme            | 请求协议                           |
| url.path              | url_path              | 请求路径                           |
| url.query             | url_query             | 请求参数                           |
| span_kind             | span_kind             | span 类型                        |
| db.system             | db_system             | span 类型                        |
| db.operation          | db_operation          | DB 动作                          |
| db.name               | db_name               | 数据库名称                          |
| db.statement          | db_statement          | 详细信息                           |
| server.address        | server_address        | 服务地址                           |
| net.host.name         | net_host_name         | 请求的 host                       |
| server.port           | server_port           | 服务端口号                          |
| net.host.port         | net_host_port         | 同上                             |
| network.peer.address  | network_peer_address  | 网络地址                           |
| network.peer.port     | network_peer_port     | 网络端口                           |
| network.transport     | network_transport     | 协议                             |
| messaging.system      | messaging_system      | 消息队列名称                         |
| messaging.operation   | messaging_operation   | 消息动作                           |
| messaging.message     | messaging_message     | 消息                             |
| messaging.destination | messaging_destination | 消息详情                           |
| rpc.service           | rpc_service           | RPC 服务地址                       |
| rpc.system            | rpc_system            | RPC 服务名称                       |
| error                 | error                 | 是否错误                           |
| error.message         | error_message         | 错误信息                           |
| error.stack           | error_stack           | 堆栈信息                           |
| error.type            | error_type            | 错误类型                           |
| error.msg             | error_message         | 错误信息                           |
| project               | project               | project                        |
| version               | version               | 版本                             |
| env                   | env                   | 环境                             |
| host                  | host                  | Attributes 中的 host 标签          |
| pod_name              | pod_name              | Attributes 中的 pod_name 标签      |
| pod_namespace         | pod_namespace         | Attributes 中的 pod_namespace 标签 |

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


## 指标 {#metric}

OpenTelemetry Java Agent 从应用程序中通过 JMX 协议获取 MBean 的指标信息，Java Agent 通过内部 SDK 报告选定的 JMX 指标，这意味着所有的指标都是可以配置的。

可以通过命令 `otel.jmx.enabled=true/false` 开启和关闭 JMX 指标采集，默认是开启的。

为了控制 MBean 检测尝试之间的时间间隔，可以使用 `otel.jmx.discovery.delay` 命令，该属性定义了在第一个和下一个检测周期之间通过的毫秒数。

另外 Agent 内置的一些三方软件的采集配置。具体可以参考： [GitHub OTEL JMX Metric](https://github.com/open-telemetry/opentelemetry-java-instrumentation/blob/main/instrumentation/jmx-metrics/javaagent/README.md){:target="_blank"}

所有发送到观测云的指标有一个统一的指标集的名字： `otel-service` 。

## 数据字段说明 {#fields}







### 指标类型 {#metric}



- 指标的标签


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






### 链路字段说明 {#tracing}



- 标签（String 类型）


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

- 指标列表（非 String 类型，或者长 String 类型）


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`duration`|Duration of span|int|μs|
|`message`|Origin content of span|string|-|
|`parent_id`|Parent span ID of current span|string|-|
|`resource`|Resource name produce current span|string|-|
|`span_id`|Span id|string|-|
|`start`|start time of span.|int|usec|
|`trace_id`|Trace id|string|-|






## 日志 {#logging}

[:octicons-tag-24: Version-1.33.0](../datakit/changelog.md#cl-1.33.0)

目前 JAVA Agent 支持采集 `stdout` 日志。并使用 [Standard output](https://opentelemetry.io/docs/specs/otel/logs/sdk_exporters/stdout/){:target="_blank"} 方式通过 `otlp` 协议发送到 DataKit 中。

`OTEL Agent` 默认情况下不开启 log 采集，必须需要通过显式命令： `otel.logs.exporter` 开启方式为：

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

通过 OTEL 采集的日志的 `source` 为服务名，也可以通过添加标签的方式自定义：`log.source` ，比如：`-Dotel.resource.attributes="log.source=source_name"`。

> 注意：如果 app 是运行在容器环境（比如 k8s），Datakit 本来就会[自动采集日志](container-log.md#logging-stdout){:target="_blank"}（默认行为），如果再采集一次，会有重复采集的问题。建议在开启采集日志之前，[手动关闭 Datakit 自主的日志采集行为](container-log.md#logging-with-image-config){:target="_blank"}

更多语言可以[查看官方文档](https://opentelemetry.io/docs/specs/otel/logs/){:target="_blank"}

## 示例 {#examples}

Datakit 目前提供了如下两种语言的最佳实践：

- [Golang](opentelemetry-go.md)
- [Java](opentelemetry-java.md)


## 更多文档 {#more-readings}

- [Golang SDK](https://github.com/open-telemetry/opentelemetry-go){:target="_blank"}
- [官方使用手册](https://opentelemetry.io/docs/){:target="_blank"}
- [环境变量配置](https://github.com/open-telemetry/opentelemetry-java/blob/main/sdk-extensions/autoconfigure/README.md#otlp-exporter-both-span-and-metric-exporters){:target="_blank"}
- [观测云二次开发版本](https://github.com/GuanceCloud/opentelemetry-java-instrumentation){:target="_blank"}
