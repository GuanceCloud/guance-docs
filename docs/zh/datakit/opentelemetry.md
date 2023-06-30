
# OpenTelemetry
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

OpenTelemetry （以下简称 OTEL）是 CNCF 的一个可观测性项目，旨在提供可观测性领域的标准化方案，解决观测数据的数据模型、采集、处理、导出等的标准化问题。

OTEL 是一组标准和工具的集合，旨在管理观测类数据，如 trace、metrics、logs 等（未来可能有新的观测类数据类型出现）。

OTEL 提供与 vendor 无关的实现，根据用户的需要将观测类数据导出到不同的后端，如开源的 Prometheus、Jaeger、Datakit 或云厂商的服务中。

本篇旨在介绍如何在 Datakit 上配置并开启 OTEL 的数据接入，以及 Java、Go 的最佳实践。

> 版本说明：Datakit 目前只接入 OTEL-v1 版本的 `otlp` 数据。

## 配置说明 {#config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/opentelemetry` 目录，复制 `opentelemetry.conf.sample` 并命名为 `opentelemetry.conf`。示例如下：

    ```toml
        
    [[inputs.opentelemetry]]
      ## During creating 'trace', 'span' and 'resource', many labels will be added, and these labels will eventually appear in all 'spans'
      ## When you don't want too many labels to cause unnecessary traffic loss on the network, you can choose to ignore these labels
      ## with setting up an regular expression list.
      ## Note: ignore_attribute_keys will be effected on both trace and metrics if setted up.
      # ignore_attribute_keys = ["os_*", "process_*"]
    
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

    配置好后，[重启 DataKit](datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

### 注意事项 {#attentions}

1. 建议使用 gRPC 协议，gRPC 具有压缩率高、序列化快、效率更高等优点
2. 自 datakit v1.10.0 版本开始，http 协议的路由是可配置的，默认请求路径（Trace/Metric）分别为 `/otel/v1/trace` 和 `/otel/v1/metric`
3. 在涉及到 `float/double` 类型数据时，会最多保留两位小数
4. HTTP 和 gRPC 都支持 gzip 压缩格式。在 exporter 中可配置环境变量来开启：`OTEL_EXPORTER_OTLP_COMPRESSION = gzip`, 默认是不会开启 gzip。
5. HTTP 协议请求格式同时支持 JSON 和 Protobuf 两种序列化格式。但 gRPC 仅支持 Protobuf 一种。
6. 配置字段 `ignore_attribute_keys` 是过滤掉一些不需要的 Key 。但是在 OTEL 中的 `attributes` 大多数的标签中用 `.` 分隔。例如在 resource 的源码中：

```golang
ServiceNameKey = attribute.Key("service.name")
ServiceNamespaceKey = attribute.Key("service.namespace")
TelemetrySDKNameKey = attribute.Key("telemetry.sdk.name")
TelemetrySDKLanguageKey = attribute.Key("telemetry.sdk.language")
OSTypeKey = attribute.Key("os.type")
OSDescriptionKey = attribute.Key("os.description")
...
```

因此，如果您想要过滤所有 `teletemetry.sdk` 和 `os`  下所有的子类型标签，那么应该这样配置：

``` toml
# 在创建 trace/span/resource 时，会加入很多标签，这些标签最终都会出现在 Span 中
# 当您不希望这些标签太多造成网络上不必要的流量损失时，可选择忽略掉这些标签
# 支持正则表达，
# 注意：将所有的 '.' 替换成 '_'
ignore_attribute_keys = ["os_*","teletemetry_sdk*"]
```

使用 OTEL HTTP exporter 时注意环境变量的配置，由于 datakit 的默认配置是 `/otel/v1/trace` 和 `/otel/v1/metric`，所以想要使用 HTTP 协议的话，需要单独配置 `trace` 和 `metric`，

otlp 的默认的请求路由是 `v1/traces` 和 `v1/metrics`, 需要为这两个单独进行配置。如果修改了配置文件中的路由，替换下面的路由地址即可。

比如：

```shell
java -javaagent:/usr/local/opentelemetry-javaagent-1.26.1-guance.jar \
 -Dotel.exporter=otlp \
 -Dotel.exporter.otlp.protocol=http/protobuf \ 
 -Dotel.exporter.otlp.traces.endpoint=http://localhost:9529/otel/v1/trace \ 
 -Dotel.exporter.otlp.metrics.endpoint=http://localhost:9529/otel/v1/metric \ 
 -jar tmall.jar
 
# 如果修改了配置文件中的默认路由为 `v1/traces` 和 `v1/metrics` 那么 上面的命令可以这么写：
java -javaagent:/usr/local/opentelemetry-javaagent-1.26.1-guance.jar \
 -Dotel.exporter=otlp \
 -Dotel.exporter.otlp.protocol=http/protobuf \ 
 -Dotel.exporter.otlp.endpoint=http://localhost:9529/ \ 
 -jar tmall.jar
```

### 最佳实践 {#bp}

Datakit 目前提供了 [Golang](opentelemetry-go.md)、[Java](opentelemetry-java.md) 两种语言的最佳实践，其他语言会在后续提供。

## 更多文档 {#more-readings}

- [Golang SDK](https://github.com/open-telemetry/opentelemetry-go){:target="_blank"}
- [官方使用手册](https://opentelemetry.io/docs/){:target="_blank"}
- [环境变量配置](https://github.com/open-telemetry/opentelemetry-java/blob/main/sdk-extensions/autoconfigure/README.md#otlp-exporter-both-span-and-metric-exporters){:target="_blank"}
- [观测云二次开发版本](https://github.com/GuanceCloud/opentelemetry-java-instrumentation){:target="_blank"}
