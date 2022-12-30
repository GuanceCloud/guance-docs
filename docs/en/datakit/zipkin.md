<!-- This file required to translate to EN. -->

# Zipkin
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Datakit 内嵌的 Zipkin Agent 用于接收，运算，分析 Zipkin Tracing 协议数据。

## Zipkin 文档 {#docs}

- [Quickstart](https://zipkin.io/pages/quickstart.html){:target="_blank"}
- [Docs](https://zipkin.io/pages/instrumenting.html){:target="_blank"}
- [Souce Code](https://github.com/openzipkin/zipkin){:target="_blank"}

## 配置 Zipkin Agent {#config-agent}

=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/zipkin` 目录，复制 `zipkin.conf.sample` 并命名为 `zipkin.conf`。示例如下：
    
    ```toml
        
    [[inputs.zipkin]]
      pathV1 = "/api/v1/spans"
      pathV2 = "/api/v2/spans"
    
      ## customer_tags is a list of keys contains keys set by client code like span.SetTag(key, value)
      ## that want to send to data center. Those keys set by client code will take precedence over
      ## keys in [inputs.zipkin.tags]. DOT(.) IN KEY WILL BE REPLACED BY DASH(_) WHEN SENDING.
      # customer_tags = ["key1", "key2", ...]
    
      ## Keep rare tracing resources list switch.
      ## If some resources are rare enough(not presend in 1 hour), those resource will always send
      ## to data center and do not consider samplers and filters.
      # keep_rare_resource = false
    
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

    目前可以通过 [ConfigMap 方式注入采集器配置](datakit-daemonset-deploy.md#configmap-setting)来开启采集器。

## 指标集 {#measurements}





### `zipkin`



- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`container_host`|container hostname|
|`endpoint`|endpoint info|
|`env`|application environment info|
|`http_method`|http request method name|
|`http_status_code`|http response code|
|`operation`|span name|
|`project`|project name|
|`service`|service name|
|`source_type`|tracing source type|
|`span_type`|span type|
|`status`|span status|
|`version`|application version info|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`duration`|duration of span|int|μs|
|`message`|origin content of span|string|-|
|`parent_id`|parent span ID of current span|string|-|
|`pid`|application process id.|string|-|
|`priority`||int|-|
|`resource`|resource name produce current span|string|-|
|`span_id`|span id|string|-|
|`start`|start time of span.|int|usec|
|`trace_id`|trace id|string|-|



