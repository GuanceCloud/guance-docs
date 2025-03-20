---
title     : 'Zipkin'
summary   : 'Zipkin Tracing 数据接入'
__int_icon      : 'icon/zipkin'
tags      :
  - 'ZIPKIN'
  - '链路追踪'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Datakit 内嵌的 Zipkin Agent 用于接收，运算，分析 Zipkin Tracing 协议数据。

## 配置 {#config}

### 采集器配置 {#input-config}
<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/zipkin` 目录，复制 `zipkin.conf.sample` 并命名为 `zipkin.conf`。示例如下：

    ```toml
        
    [[inputs.zipkin]]
      pathV1 = "/api/v1/spans"
      pathV2 = "/api/v2/spans"
    
      ## ignore_tags will work as a blacklist to prevent tags send to data center.
      ## Every value in this list is a valid string of regular expression.
      # ignore_tags = ["block1", "block2"]
    
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
      # [inputs.zipkin.close_resource]
        # service1 = ["resource1", "resource2", ...]
        # service2 = ["resource1", "resource2", ...]
        # "*" = ["close_resource_under_all_services"]
        # ...
    
      ## Sampler config uses to set global sampling strategy.
      ## sampling_rate used to set global sampling rate.
      # [inputs.zipkin.sampler]
        # sampling_rate = 1.0
    
      # [inputs.zipkin.tags]
        # key1 = "value1"
        # key2 = "value2"
        # ...
    
      ## Threads config controls how many goroutines an agent cloud start to handle HTTP request.
      ## buffer is the size of jobs' buffering of worker channel.
      ## threads is the total number fo goroutines at running time.
      # [inputs.zipkin.threads]
        # buffer = 100
        # threads = 8
    
      ## Storage config a local storage space in hard dirver to cache trace data.
      ## path is the local file path used to cache data.
      ## capacity is total space size(MB) used to store data.
      # [inputs.zipkin.storage]
        # path = "./zipkin_storage"
        # capacity = 5120
    
    ```

    配置好后，重启 DataKit 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。

    在 Kubernetes 中支持的环境变量如下表：

    | 环境变量名                            | 类型        | 示例                                                                             |
    | ------------------------------------- | ----------- | -------------------------------------------------------------------------------- |
    | `ENV_INPUT_ZIPKIN_PATH_V1`            | string      | "/api/v1/spans"                                                                  |
    | `ENV_INPUT_ZIPKIN_PATH_V2`            | string      | "/api/v2/spans"                                                                  |
    | `ENV_INPUT_ZIPKIN_IGNORE_TAGS`        | JSON string | `["block1", "block2"]`                                                           |
    | `ENV_INPUT_ZIPKIN_KEEP_RARE_RESOURCE` | bool        | true                                                                             |
    | `ENV_INPUT_ZIPKIN_DEL_MESSAGE`        | bool        | true                                                                             |
    | `ENV_INPUT_ZIPKIN_CLOSE_RESOURCE`     | JSON string | `{"service1":["resource1"], "service2":["resource2"], "service3":["resource3"]}` |
    | `ENV_INPUT_ZIPKIN_SAMPLER`            | float       | 0.3                                                                              |
    | `ENV_INPUT_ZIPKIN_TAGS`               | JSON string | `{"k1":"v1", "k2":"v2", "k3":"v3"}`                                              |
    | `ENV_INPUT_ZIPKIN_THREADS`            | JSON string | `{"buffer":1000, "threads":100}`                                                 |
    | `ENV_INPUT_ZIPKIN_STORAGE`            | JSON string | `{"storage":"./zipkin_storage", "capacity": 5120}`                               |

<!-- markdownlint-enable -->

## 链路字段 {#tracing}





### `zipkin`



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




## Zipkin 文档 {#docs}

- [Quick Start](https://zipkin.io/pages/quickstart.html){:target="_blank"}
- [Docs](https://zipkin.io/pages/instrumenting.html){:target="_blank"}
- [Source Code](https://github.com/openzipkin/zipkin){:target="_blank"}
