
# DDTrace
---

- DataKit 版本：1.4.5
- 操作系统支持：`windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

Datakit 内嵌的 DDTrace Agent 用于接收，运算，分析 DataDog Tracing 协议数据。

## DDTrace 文档

### Referenc

- [Java](https://docs.datadoghq.com/tracing/setup_overview/setup/java?tab=containers){:target="_blank"} 
- [Python](https://docs.datadoghq.com/tracing/setup_overview/setup/python?tab=containers){:target="_blank"}
- [Ruby](https://docs.datadoghq.com/tracing/setup_overview/setup/ruby){:target="_blank"}
- [Golang](https://docs.datadoghq.com/tracing/setup_overview/setup/go?tab=containers){:target="_blank"}
- [NodeJS](https://docs.datadoghq.com/tracing/setup_overview/setup/nodejs?tab=containers){:target="_blank"}
- [PHP](https://docs.datadoghq.com/tracing/setup_overview/setup/php?tab=containers){:target="_blank"}
- [C++](https://docs.datadoghq.com/tracing/setup_overview/setup/cpp?tab=containers){:target="_blank"}
- [.Net Core](https://docs.datadoghq.com/tracing/setup_overview/setup/dotnet-core?tab=windows){:target="_blank"}
- [.Net Framework](https://docs.datadoghq.com/tracing/setup_overview/setup/dotnet-framework?tab=windows){:target="_blank"}

### Source Code

- [Java](https://github.com/DataDog/dd-trace-java){:target="_blank"}
- [Python](https://github.com/DataDog/dd-trace-py){:target="_blank"}
- [Ruby](https://github.com/DataDog/dd-trace-rb){:target="_blank"}
- [Golang](https://github.com/DataDog/dd-trace-go){:target="_blank"}
- [NodeJS](https://github.com/DataDog/dd-trace-js){:target="_blank"}
- [PHP](https://github.com/DataDog/dd-trace-php){:target="_blank"}
- [C++](https://github.com/opentracing/opentracing-cpp){:target="_blank"}
- [.Net](https://github.com/DataDog/dd-trace-dotnet){:target="_blank"}

> Java： DataKit 安装目录 `data` 目录下，有预先准备好的 `dd-java-agent.jar`（推荐使用）。也可以直接去 [Maven 下载](https://mvnrepository.com/artifact/com.datadoghq/dd-java-agent){:target="_blank"}

## 配置 DDTrace Agent

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

```

> 注意：不要修改这里的 `endpoints` 列表。

```toml
endpoints = ["/v0.3/traces", "/v0.4/traces", "/v0.5/traces"]
```

编辑 `conf.d/datakit.conf`，将 `listen` 改为 `0.0.0.0:9529`（此处目的是开放外网访问，端口可选）。此时 ddtrace 的访问地址就是 `http://<datakit-ip>:9529`。如果 trace 数据来源就是 DataKit 本机，可不用修改 `listen` 配置，直接使用 `http://localhost:9529` 即可。

如果有 trace 数据发送给 DataKit，那么在 DataKit 的 `gin.log` 上能看到：

```shell
tail -f /var/log/datakit/gin.log
[GIN] 2021/08/02 - 17:16:31 | 200 |     386.256µs |       127.0.0.1 | POST     "/v0.4/traces"
[GIN] 2021/08/02 - 17:17:30 | 200 |     116.109µs |       127.0.0.1 | POST     "/v0.4/traces"
[GIN] 2021/08/02 - 17:17:30 | 200 |     489.428µs |       127.0.0.1 | POST     "/v0.4/traces"

...
```

> 注意：如果没有 trace 发送过来，在 [monitor 页面](datakit-tools-how-to.md#monitor)是看不到 ddtrace 的采集信息的。

## ddtrace 环境变量设置

### 基本环境变量

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
## tags is ddtrace configed key value pairs
[inputs.ddtrace.tags]
	 some_tag = "some_value"
	 more_tag = "some_other_value"
```

## 关于 Tags

### 在代码中添加业务 tag

在应用代码中，可通过诸如 `span.SetTag(some-tag-key, some-tag-value)`（不同语言方式不同） 这样的方式来设置业务自定义 tag。对于这些业务自定义 tag，可通过配置 `customer_tags` 来识别并提取：

```toml
customer_tags = []
```

注意，这些 tag-key 中不能包含英文字符 '.'，带 `.` 的 tag-key 会替换为 `_`，示例：

```toml
customer_tags = [
	"order_id",
	"task_id",
	"some.invalid.key",  #替换为 some_ivalid_key
]
```

### 应用代码中添加业务 tag 注意事项

- 务必在 `customer_tags` 中添加 tag-key 列表，否则 DataKit 不会进行业务 tag 的提取
- 在开启了采样的情况下，部分添加了 tag 的 span 有可能被舍弃

## Tracing 数据





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




## 延伸阅读

- [DataKit Tracing 字段定义](datakit-tracing-struct.md)
- [DataKit 通用 Tracing 数据采集说明](datakit-tracing.md)
- [正确使用正则表达式来配置](datakit-input-conf.md#debug-regex) 
