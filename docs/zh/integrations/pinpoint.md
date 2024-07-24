---
title     : 'Pinpoint'
summary   : 'Pinpoint Tracing 数据接入'
__int_icon      : 'icon/pinpoint'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Pinpoint
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

[:octicons-tag-24: Version-1.6.0](../datakit/changelog.md#cl-1.6.0) · [:octicons-beaker-24: Experimental](../datakit/index.md#experimental)

---

Datakit 内置的 Pinpoint Agent 用于接收，运算，分析 Pinpoint Tracing 协议数据。

## 配置 {#config}

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/pinpoint` 目录，复制 `pinpoint.conf.sample` 并命名为 `pinpoint.conf`。示例如下：

    ```toml
        
    [[inputs.pinpoint]]
      ## Pinpoint service endpoint for
      ## - Span Server
      ## - Agent Server(unimplemented, for service intactness and compatibility)
      ## - Metadata Server(unimplemented, for service intactness and compatibility)
      ## - Profiler Server(unimplemented, for service intactness and compatibility)
      address = "127.0.0.1:9991"
    
      ## Keep rare tracing resources list switch.
      ## If some resources are rare enough(not presend in 1 hour), those resource will always send
      ## to data center and do not consider samplers and filters.
      # keep_rare_resource = false
    
      ## delete trace message
      # del_message = true
    
      ## Ignore tracing resources map like service:[resources...].
      ## The service name is the full service name in current application.
      ## The resource list is regular expressions uses to block resource names.
      ## If you want to block some resources universally under all services, you can set the
      ## service name as "*". Note: double quotes "" cannot be omitted.
      # [inputs.pinpoint.close_resource]
        # service1 = ["resource1", "resource2", ...]
        # service2 = ["resource1", "resource2", ...]
        # "*" = ["close_resource_under_all_services"]
        # ...
    
      ## Sampler config uses to set global sampling strategy.
      ## sampling_rate used to set global sampling rate.
      # [inputs.pinpoint.sampler]
        # sampling_rate = 1.0
    
      # [inputs.pinpoint.tags]
        # key1 = "value1"
        # key2 = "value2"
        # ...
    
      ## Storage config a local storage space in hard dirver to cache trace data.
      ## path is the local file path used to cache data.
      ## capacity is total space size(MB) used to store data.
      # [inputs.pinpoint.storage]
        # path = "./pinpoint_storage"
        # capacity = 5120
    
    ```

    Datakit Pinpoint Agent 监听地址配置项为：

    ```toml
    # Pinpoint GRPC service endpoint for
    # - Span Server
    # - Agent Server(unimplemented, for service intactness and compatibility)
    # - Metadata Server(unimplemented, for service intactness and compatibility)
    # - Profiler Server(unimplemented, for service intactness and compatibility)
    address = "127.0.0.1:9991"
    ```

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    可通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting) 或 [配置 ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) 开启采集器。

    也支持以环境变量的方式修改配置参数（需要在 ENV_DEFAULT_ENABLED_INPUTS 中加为默认采集器）：

    - **ENV_INPUT_PINPOINT_ADDRESS**
    
        代理 URL
    
        **字段类型**: String
    
        **采集器配置字段**: `address`
    
        **示例**: 127.0.0.1:9991
    
    - **ENV_INPUT_PINPOINT_KEEP_RARE_RESOURCE**
    
        保持稀有跟踪资源列表
    
        **字段类型**: Boolean
    
        **采集器配置字段**: `keep_rare_resource`
    
        **默认值**: false
    
    - **ENV_INPUT_PINPOINT_DEL_MESSAGE**
    
        删除 trace 消息
    
        **字段类型**: Boolean
    
        **采集器配置字段**: `del_message`
    
        **默认值**: false
    
    - **ENV_INPUT_PINPOINT_CLOSE_RESOURCE**
    
        忽略指定服务器的 tracing（正则匹配）
    
        **字段类型**: JSON
    
        **采集器配置字段**: `close_resource`
    
        **示例**: {"service1":["resource1","other"],"service2":["resource2","other"]}
    
    - **ENV_INPUT_PINPOINT_SAMPLER**
    
        全局采样率
    
        **字段类型**: Float
    
        **采集器配置字段**: `sampler`
    
        **示例**: 0.3
    
    - **ENV_INPUT_PINPOINT_STORAGE**
    
        本地缓存路径和大小（MB）
    
        **字段类型**: JSON
    
        **采集器配置字段**: `storage`
    
        **示例**: {"storage":"./pinpoint_storage", "capacity": 5120}
    
    - **ENV_INPUT_PINPOINT_TAGS**
    
        自定义标签。如果配置文件有同名标签，将会覆盖它
    
        **字段类型**: JSON
    
        **采集器配置字段**: `tags`
    
        **示例**: {"k1":"v1", "k2":"v2", "k3":"v3"}                             |

???+ warning "Datakit 中的 Pinpoint Agent 存在以下限制"

    - 目前只支持 gRPC 协议
    - 多服务（Agent/Metadata/Stat/Span）合一的服务使用同一个端口
    - Pinpoint 链路与 Datakit 链路存在差异，详见[下文](pinpoint.md#opentracing-vs-pinpoint)

<!-- markdownlint-enable -->

### Pinpoint Agent 配置 {#agent-config}

- 下载所需的 Pinpoint APM Agent

Pinpoint 支持实现了多语言的 APM Collector 本文档使用 JAVA Agent 进行配置。[下载](https://github.com/pinpoint-apm/pinpoint/releases){:target="_blank"} JAVA APM Collector。

- 配置 Pinpoint APM Collector，打开 */path_to_pinpoint_agent/pinpoint-root.config* 配置相应的多服务端口

    - 配置 `profiler.transport.module = GRPC`
    - 配置 `profiler.transport.grpc.agent.collector.port = 9991`   （即 Datakit Pinpoint Agent 中配置的端口）
    - 配置 `profiler.transport.grpc.metadata.collector.port = 9991`（即 Datakit Pinpoint Agent 中配置的端口）
    - 配置 `profiler.transport.grpc.stat.collector.port = 9991`    （即 Datakit Pinpoint Agent 中配置的端口）
    - 配置 `profiler.transport.grpc.span.collector.port = 9991`    （即 Datakit Pinpoint Agent 中配置的端口）

- 启动 Pinpoint APM Agent 启动命令

```shell
$ java -javaagent:/path_to_pinpoint/pinpoint-bootstrap.jar \
    -Dpinpoint.agentId=agent-id \
    -Dpinpoint.applicationName=app-name \
    -Dpinpoint.config=/path_to_pinpoint/pinpoint-root.config \
    -jar /path_to_your_app.jar
```

Datakit 链路数据遵循 OpenTracing 协议，Datakit 中一条链路是通过简单的父子（子 span 中存放父 span 的 id）结构串联起来且每个 span 对应一次函数调用

<figure markdown>
  ![OpenTracing](https://static.guance.com/images/datakit/datakit-opentracing.png){ width="600" }
  <figcaption>OpenTracing</figcaption>
</figure>

Pinpoint APM 链路数据较为复杂：

- 父 span 负责产生子 span 的 ID
- 子 span 中也要存放父 span 的 ID
- 使用 span event 替代 OpenTracing 中的 span
- 一个 span 为一个服务的一次应答过程

<figure markdown>
  ![Pinpoint](https://static.guance.com/images/datakit/datakit-pinpoint.png){ width="600" }
  <figcaption>Pinpoint</figcaption>
</figure>

### PinPointV2 {#pinpointv2}

`DataKit 1.19.0` 版本重新优化后更改 `source` 为 `PinPointV2`。 新版本的链路数据重新梳理 `SpanChunk` 和 `Span` 的关系、`Event` 和 `Span` 的关系、`Span` 与 `Span` 的关系。
以及 `Event` 中 `startElapsed` 和 `endElapsed` 时间对齐问题。

主要的逻辑点：

- 缓存 `serviceType` 服务表，并写到文件中，防止 DataKit 重启而丢失数据。
- `Span` 中的 `parentSpanId` 不为 -1，则缓存。如 `parentSpanId:-1`，则根据 `spanEvent` 中的 `nextSpanId` 从缓存中取出 `Span` 拼接到一个链路中。
- 缓存所有 `SpanChunk` 中的 `event`，直到接收到主 `Span` 才从缓存中全部取出，追加到链路中。
- 按顺序累加当前 `Event` 中 `startElapsed` 作为下一个 `Event` 的起始时间。
- 按照 `Depth` 字段判断当前 `Event` 的父子级关系。
- 遇到数据库查询会将 `sql` 语句替换当前的 '资源' 名称。

## 链路字段 {#tracing}





### `pinpoint`



- 标签


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

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`duration`|Duration of span|int|μs|
|`message`|Origin content of span|string|-|
|`parent_id`|Parent span ID of current span|string|-|
|`resource`|Resource name produce current span|string|-|
|`span_id`|Span id|string|-|
|`start`|start time of span.|int|usec|
|`trace_id`|Trace id|string|-|








## 指标字段 {#metrics}









### `pinpoint-metric`



- 标签


| Tag | Description |
|  ----  | --------|
|`agentVersion`|Pinpoint agent version|
|`agent_id`|Agent ID|
|`container`|Whether it is a container|
|`hostname`|Host name|
|`ip`|Agent IP|
|`pid`|Process ID|
|`ports`|Open ports|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`GcNewCount`|Jvm Gc NewCount|int|count|
|`GcNewTime`|Jvm Gc NewTime|int|msec|
|`JvmCpuLoad`|Jvm CPU load|int|percent|
|`JvmGcOldCount`|Jvm Gc Old Count|int|count|
|`JvmGcOldTime`|Jvm Gc Old Time|int|msec|
|`JvmMemoryHeapMax`|Jvm Memory Heap Max|int|B|
|`JvmMemoryHeapUsed`|Jvm Memory Heap Used|int|B|
|`JvmMemoryNonHeapMax`|Jvm Memory NonHeap Max|int|B|
|`JvmMemoryNonHeapUsed`|Jvm Memory NonHeap Used|int|B|
|`PoolCodeCacheUsed`|Jvm Pool Code Cache Used|float|B|
|`PoolMetaspaceUsed`|Jvm Pool meta space used|float|count|
|`PoolNewGenUsed`|Jvm Pool New GenUsed|float|B|
|`PoolOldGenUsed`|Duration of Jvm garbage collection actions|float|B|
|`PoolPermGenUsed`|The maximum file descriptor count|float|count|
|`PoolSurvivorSpaceUsed`|Jvm Pool Survivor SpaceUsed|float|B|
|`SystemCpuLoad`|system CPU load|int|percent|




## Pinpoint 参考资料 {#references}

- [Pinpoint 官方文档](https://pinpoint-apm.gitbook.io/pinpoint/){:target="_blank"}
- [Pinpoint 版本文档库](https://pinpoint-apm.github.io/pinpoint/index.html){:target="_blank"}
- [Pinpoint 官方仓库](https://github.com/pinpoint-apm){:target="_blank"}
- [Pinpoint 线上实例](http://125.209.240.10:10123/main){:target="_blank"}
