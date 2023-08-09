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

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。

    在 Kubernetes 中支持的环境变量如下表：

    | 环境变量名                              | 类型        | 示例                                                                             |
    | --------------------------------------- | ----------- | -------------------------------------------------------------------------------- |
    | `ENV_INPUT_PINPOINT_ADDRESS`            | string      | "127.0.0.1:9991"                                                                 |
    | `ENV_INPUT_PINPOINT_KEEP_RARE_RESOURCE` | bool        | true                                                                             |
    | `ENV_INPUT_PINPOINT_CLOSE_RESOURCE`     | JSON string | `{"service1":["resource1"], "service2":["resource2"], "service3":["resource3"]}` |
    | `ENV_INPUT_PINPOINT_SAMPLER`            | float       | 0.3                                                                              |
    | `ENV_INPUT_PINPOINT_TAGS`               | JSON string | `{"k1":"v1", "k2":"v2", "k3":"v3"}`                                              |
    | `ENV_INPUT_PINPOINT_STORAGE`            | JSON string | `{"storage":"./pinpoint_storage", "capacity": 5120}`                             |

???+ warning "Datakit 中的 Pinpoint Agent 存在以下限制"

    - 目前只支持 gRPC 协议
    - 多服务（Agent/Metadata/Stat/Span）合一的服务使用同一个端口
    - Pinpoint 链路与 Datakit 链路存在差异，详见[下文](pinpoint.md#opentracing-vs-pinpoint)

<!-- markdownlint-enable -->

### Pinpoint Collector 配置 {#collector-config}

- 下载所需的 Pinpoint APM Collector

Pinpoint 支持实现了多语言的 APM Collector 本文档使用 JAVA Collector 进行配置。[下载](https://github.com/pinpoint-apm/pinpoint/releases){:target="_blank"} JAVA APM Collector。

- 配置 Pinpoint APM Collector，打开 */path_to_pinpoint_collector/pinpoint-root.config* 配置相应的多服务端口

    - 配置 `profiler.transport.module = GRPC`
    - 配置 `profiler.transport.grpc.agent.collector.port = 9991`   （即 Datakit Pinpoint Agent 中配置的端口）
    - 配置 `profiler.transport.grpc.metadata.collector.port = 9991`（即 Datakit Pinpoint Agent 中配置的端口）
    - 配置 `profiler.transport.grpc.stat.collector.port = 9991`    （即 Datakit Pinpoint Agent 中配置的端口）
    - 配置 `profiler.transport.grpc.span.collector.port = 9991`    （即 Datakit Pinpoint Agent 中配置的端口）

- 启动 Pinpoint APM Collector 启动命令

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

## 链路字段 {#tracing}





### `pinpoint`



- 标签


| Tag | Description |
|  ----  | --------|
|`container_host`|Container hostname. Available in OpenTelemetry. Optional.|
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
|`pid`|Application process id. Available in DDTrace, OpenTelemetry. Optional.|string|-|
|`priority`|Optional.|int|-|
|`resource`|Resource name produce current span|string|-|
|`span_id`|Span id|string|-|
|`start`|start time of span.|int|usec|
|`trace_id`|Trace id|string|-|




## Pinpoint 参考资料 {#references}

- [Pinpoint 官方文档](https://pinpoint-apm.gitbook.io/pinpoint/){:target="_blank"}
- [Pinpoint 版本文档库](https://pinpoint-apm.github.io/pinpoint/index.html){:target="_blank"}
- [Pinpoint 官方仓库](https://github.com/pinpoint-apm){:target="_blank"}
- [Pinpoint 线上实例](http://125.209.240.10:10123/main){:target="_blank"}
