
# DDTrace
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Datakit 内嵌的 DDTrace Agent 用于接收，运算，分析 DataDog Tracing 协议数据。

## DDTrace 文档和示例 {#doc-example}

<div class="grid cards" markdown>
-   :fontawesome-brands-python: __Python__

    ---

    [SDK :material-download:](https://github.com/DataDog/dd-trace-py){:target="_blank"} ·
    [:octicons-book-16: 文档](https://docs.datadoghq.com/tracing/setup_overview/setup/python?tab=containers){:target="_blank"} ·
    [:octicons-arrow-right-24: 示例](ddtrace-python.md)

-   :material-language-java: __Java__

    ---

    [SDK :material-download:](https://static.guance.com/ddtrace/dd-java-agent.jar){:target="_blank"} ·
    [:octicons-book-16: 文档](https://docs.datadoghq.com/tracing/setup_overview/setup/java?tab=containers){:target="_blank"} ·
    [:octicons-arrow-right-24: 示例](ddtrace-java.md)

-   :material-language-ruby: __Ruby__

    ---

    [SDK :material-download:](https://github.com/DataDog/dd-trace-rb){:target="_blank"} ·
    [:octicons-book-16: 文档](https://docs.datadoghq.com/tracing/setup_overview/setup/ruby){:target="_blank"} ·
    [:octicons-arrow-right-24: 示例](ddtrace-java.md)

-   :fontawesome-brands-golang: __Golang__

    ---

    [SDK :material-download:](https://github.com/DataDog/dd-trace-go){:target="_blank"} ·
    [:octicons-book-16: 文档](https://docs.datadoghq.com/tracing/setup_overview/setup/go?tab=containers){:target="_blank"} ·
    [:octicons-arrow-right-24: 示例](ddtrace-golang.md)

-   :material-language-php: __PHP__

    ---

    [SDK :material-download:](https://github.com/DataDog/dd-trace-php){:target="_blank"} ·
    [:octicons-book-16: 文档](https://docs.datadoghq.com/tracing/setup_overview/setup/php?tab=containers){:target="_blank"} ·
    [:octicons-arrow-right-24: 示例](ddtrace-php.md)

-   :fontawesome-brands-node-js: __NodeJS__

    ---

    [SDK :material-download:](https://github.com/DataDog/dd-trace-js){:target="_blank"} ·
    [:octicons-book-16: 文档](https://docs.datadoghq.com/tracing/setup_overview/setup/nodejs?tab=containers){:target="_blank"} ·
    [:octicons-arrow-right-24: 示例](ddtrace-nodejs.md)

-   :material-language-cpp:

    ---

    [SDK :material-download:](https://github.com/opentracing/opentracing-cpp){:target="_blank"} ·
    [:octicons-book-16: 文档](https://docs.datadoghq.com/tracing/setup_overview/setup/cpp?tab=containers){:target="_blank"} ·
    [:octicons-arrow-right-24: 示例](ddtrace-cpp.md)

-   :material-dot-net:

    ---

    [SDK :material-download:](https://github.com/DataDog/dd-trace-dotnet){:target="_blank"} ·
    [:octicons-book-16: 文档](https://docs.datadoghq.com/tracing/setup_overview/setup/dotnet-framework?tab=windows){:target="_blank"} ·
    [:octicons-book-16: .Net Core 文档](https://docs.datadoghq.com/tracing/setup_overview/setup/dotnet-framework?tab=windows){:target="_blank"}
</div>

???+ tip

    我们对 DDTrace 做了一些[功能扩展](ddtrace-ext-changelog.md)，便于支持更多的主流框架和更细粒度的数据追踪。

## 采集器配置 {#config}

=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/ddtrace` 目录，复制 `ddtrace.conf.sample` 并命名为 `ddtrace.conf`。示例如下：
    
    ```toml
        
    [[inputs.ddtrace]]
      ## DDTrace Agent endpoints register by version respectively.
      ## Endpoints can be skipped listen by remove them from the list.
      ## Default value set as below. DO NOT MODIFY THESE ENDPOINTS if not necessary.
      endpoints = ["/v0.3/traces", "/v0.4/traces", "/v0.5/traces"]
    
      ## customer_tags is a list of keys contains keys set by client code like span.SetTag(key, value)
      ## that want to send to data center. Those keys set by client code will take precedence over
      ## keys in [inputs.ddtrace.tags]. DOT(.) IN KEY WILL BE REPLACED BY DASH(_) WHEN SENDING.
      # customer_tags = ["key1", "key2", ...]
    
      ## Keep rare tracing resources list switch.
      ## If some resources are rare enough(not presend in 1 hour), those resource will always send
      ## to data center and do not consider samplers and filters.
      # keep_rare_resource = false
    
      ## By default every error presents in span will be send to data center and omit any filters or
      ## sampler. If you want to get rid of some error status, you can set the error status list here.
      # omit_err_status = ["404"]
    
      ## Ignore tracing resources map like service:[resources...].
      ## The service name is the full service name in current application.
      ## The resource list is regular expressions uses to block resource names.
      ## If you want to block some resources universally under all services, you can set the
      ## service name as "*". Note: double quotes "" cannot be omitted.
      # [inputs.ddtrace.close_resource]
        # service1 = ["resource1", "resource2", ...]
        # service2 = ["resource1", "resource2", ...]
        # "*" = ["close_resource_under_all_services"]
        # ...
    
      ## Sampler config uses to set global sampling strategy.
      ## sampling_rate used to set global sampling rate.
      # [inputs.ddtrace.sampler]
        # sampling_rate = 1.0
    
      # [inputs.ddtrace.tags]
        # key1 = "value1"
        # key2 = "value2"
        # ...
    
      ## Threads config controls how many goroutines an agent cloud start to handle HTTP request.
      ## buffer is the size of jobs' buffering of worker channel.
      ## threads is the total number fo goroutines at running time.
      # [inputs.ddtrace.threads]
        # buffer = 100
        # threads = 8
    
      ## Storage config a local storage space in hard dirver to cache trace data.
      ## path is the local file path used to cache data.
      ## capacity is total space size(MB) used to store data.
      # [inputs.ddtrace.storage]
        # path = "./ddtrace_storage"
        # capacity = 5120
    
    ```

    配置好后，[重启 DataKit](datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](datakit-daemonset-deploy.md#configmap-setting)来开启采集器。

---

???+ attention

    - 不要修改这里的 `endpoints` 列表。

    ```toml
    endpoints = ["/v0.3/traces", "/v0.4/traces", "/v0.5/traces"]
    ```

    - 如果要关闭采样（即采集所有数据），采样率字段需做如下设置：
    
    ``` toml
    # [inputs.ddtrace.sampler]
    # sampling_rate = 1.0
    ```

    不要只注释 `sampling_rate = 1.0` 这一行，必须连同 `[inputs.ddtrace.sampler]` 也一并注释掉，否则采集器会认为 `sampling_rate` 被置为 0.0，从而导致所有数据都被丢弃。

### HTTP 设置 {#http}

如果 Trace 数据是跨机器发送过来的，那么需要设置 [DataKit 的 HTTP 设置](datakit-conf.md#config-http-server)。

如果有 ddtrace 数据发送给 DataKit，那么在 [DataKit 的 monitor](datakit-monitor.md) 上能看到：

<figure markdown>
  ![](https://zhuyun-static-files-production.oss-cn-hangzhou.aliyuncs.com/images/datakit/input-ddtrace-monitor.png){ width="800" }
  <figcaption> DDtrace 将数据发送给了 /v0.4/traces 接口</figcaption>
</figure>

### 开启磁盘缓存 {#disk-cache}

如果 Trace 数据量很大，为避免给主机造成大量的资源开销，可以将 Trace 数据临时缓存到磁盘中，延迟处理：

``` toml
[inputs.ddtrace.storage]
  path = "/path/to/ddtrace-disk-storage"
  capacity = 5120
```

## DDtrace SDK 配置 {#sdk}

配置完采集器之后，还可以对 DDtrace SDK 端做一些配置。

### 环境变量设置 {#dd-envs}

- `DD_TRACE_ENABLED`: Enable global tracer (部分语言平台支持)
- `DD_AGENT_HOST`: DDtrace agent host address
- `DD_TRACE_AGENT_PORT`: DDtrace agent host port
- `DD_SERVICE`: Service name
- `DD_TRACE_SAMPLE_RATE`: Set sampling rate
- `DD_VERSION`: Application version (optional)
- `DD_TRACE_STARTUP_LOGS`: DDtrace logger
- `DD_TRACE_DEBUG`: DDtrace debug mode
- `DD_ENV`: Application env values
- `DD_TAGS`: Application

除了在应用初始化时设置项目名，环境名以及版本号外，还可通过如下两种方式设置：

- 通过命令行注入环境变量

```shell
DD_TAGS="project:your_project_name,env=test,version=v1" ddtrace-run python app.py
```

- 在 ddtrace.conf 中直接配置自定义标签。这种方式会影响**所有**发送给 DataKit tracing 服务的数据，需慎重考虑：

```toml
# tags is ddtrace configed key value pairs
[inputs.ddtrace.tags]
  some_tag = "some_value"
  more_tag = "some_other_value"
```

### 在代码中添加业务 tag {#add-tags}

在应用代码中，可通过诸如 `span.SetTag(some-tag-key, some-tag-value)`（不同语言方式不同） 这样的方式来设置业务自定义 tag。对于这些业务自定义 tag，可通过在 ddtrace.conf 中配置 `customer_tags` 来识别并提取：

```toml
customer_tags = [
  "order_id",
  "task_id",
  "some.key",  # 被重命名为 some_key
]
```

注意，这些 tag-key 中不能包含英文字符 '.'，带 `.` 的 tag-key 会替换为 `_`。

???+ attention "应用代码中添加业务 tag 注意事项"

    - 在应用代码中添加了对应的 tag 后，必须在 ddtrace.conf 的 `customer_tags` 中也同步添加对应的 tag-key 列表，否则 DataKit 不会对这些业务 tag 进行提取
    - 在开启了采样的情况下，部分添加了 tag 的 span 有可能被舍弃

## 指标集 {#measurements}





### `ddtrace`



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




## 延伸阅读 {#more-reading}

- [DataKit Tracing 字段定义](datakit-tracing-struct.md)
- [DataKit 通用 Tracing 数据采集说明](datakit-tracing.md)
- [正确使用正则表达式来配置](datakit-input-conf.md#debug-regex) 
