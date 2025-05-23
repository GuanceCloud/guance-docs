---
title     : 'Jaeger'
summary   : '接收 Jaeger APM 数据'
__int_icon      : 'icon/jaeger'
tags      :
  - 'JAEGER'
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

Datakit 内嵌的 Jaeger Agent 用于接收，运算，分析 Jaeger Tracing 协议数据。

## 配置 {#config}

<!-- markdownlint-disable MD046 -->
???+ info

    当前 Jaeger 版本支持 HTTP 和 UDP 通信协议和 Apache Thrift 编码规范

=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/jaeger` 目录，复制 `jaeger.conf.sample` 并命名为 `jaeger.conf`。示例如下：

    ```toml
        
    [[inputs.jaeger]]
      # Jaeger endpoint for receiving tracing span over HTTP.
      # Default value set as below. DO NOT MODIFY THE ENDPOINT if not necessary.
      endpoint = "/apis/traces"
    
      # Jaeger agent host:port address for UDP transport.
      # address = "127.0.0.1:6831"
      # binary_address = "127.0.0.1:6832"
    
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
      # [inputs.jaeger.close_resource]
        # service1 = ["resource1", "resource2", ...]
        # service2 = ["resource1", "resource2", ...]
        # "*" = ["close_resource_under_all_services"]
        # ...
    
      ## Sampler config uses to set global sampling strategy.
      ## sampling_rate used to set global sampling rate.
      # [inputs.jaeger.sampler]
        # sampling_rate = 1.0
    
      # [inputs.jaeger.tags]
        # key1 = "value1"
        # key2 = "value2"
        # ...
    
      ## Threads config controls how many goroutines an agent cloud start to handle HTTP request.
      ## buffer is the size of jobs' buffering of worker channel.
      ## threads is the total number fo goroutines at running time.
      ## timeout is the duration(ms) before a job can return a result.
      # [inputs.jaeger.threads]
        # buffer = 100
        # threads = 8
    
      ## Storage config a local storage space in hard dirver to cache trace data.
      ## path is the local file path used to cache data.
      ## capacity is total space size(MB) used to store data.
      # [inputs.jaeger.storage]
        # path = "./jaeger_storage"
        # capacity = 5120
    
    ```

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    可通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting) 或 [配置 ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) 开启采集器。

    也支持以环境变量的方式修改配置参数（需要在 ENV_DEFAULT_ENABLED_INPUTS 中加为默认采集器）：

    - **ENV_INPUT_JAEGER_HTTP_ENDPOINT**
    
        通过 HTTP 接收 tracing span 的端点
    
        **字段类型**: String
    
        **采集器配置字段**: `endpoint`
    
        **示例**: /apis/traces
    
    - **ENV_INPUT_JAEGER_UDP_ENDPOINT**
    
        UDP 代理 URL
    
        **字段类型**: String
    
        **采集器配置字段**: `address`
    
        **示例**: 127.0.0.1:6831
    
    - **ENV_INPUT_JAEGER_IGNORE_TAGS**
    
        忽略的标签
    
        **字段类型**: JSON
    
        **采集器配置字段**: `ignore_tags`
    
        **示例**: ["block1","block2"]
    
    - **ENV_INPUT_JAEGER_KEEP_RARE_RESOURCE**
    
        保持稀有跟踪资源列表
    
        **字段类型**: Boolean
    
        **采集器配置字段**: `keep_rare_resource`
    
        **默认值**: false
    
    - **ENV_INPUT_JAEGER_DEL_MESSAGE**
    
        删除 trace 消息
    
        **字段类型**: Boolean
    
        **采集器配置字段**: `del_message`
    
        **默认值**: false
    
    - **ENV_INPUT_JAEGER_CLOSE_RESOURCE**
    
        忽略指定服务器的 tracing（正则匹配）
    
        **字段类型**: JSON
    
        **采集器配置字段**: `close_resource`
    
        **示例**: {"service1":["resource1","other"],"service2":["resource2","other"]}
    
    - **ENV_INPUT_JAEGER_SAMPLER**
    
        全局采样率
    
        **字段类型**: Float
    
        **采集器配置字段**: `sampler`
    
        **示例**: 0.3
    
    - **ENV_INPUT_JAEGER_THREADS**
    
        线程和缓存的数量
    
        **字段类型**: JSON
    
        **采集器配置字段**: `threads`
    
        **示例**: {"buffer":1000, "threads":100}
    
    - **ENV_INPUT_JAEGER_STORAGE**
    
        本地缓存路径和大小（MB）
    
        **字段类型**: JSON
    
        **采集器配置字段**: `storage`
    
        **示例**: {"storage":"./jaeger_storage", "capacity": 5120}
    
    - **ENV_INPUT_JAEGER_TAGS**
    
        自定义标签。如果配置文件有同名标签，将会覆盖它
    
        **字段类型**: JSON
    
        **采集器配置字段**: `tags`
    
        **示例**: {"k1":"v1", "k2":"v2", "k3":"v3"}

<!-- markdownlint-enable -->

在使用 UDP 协议的时候，注意协议中的数据格式，默认情况下使用 6831 端口使用的是 `thrift CompactProtocol` 格式，使用 6832 端口时的协议为 `thrift BinaryProtocol` 。
Jaeger 默认情况下使用的是 6831 端口中的协议，所以 当您不使用 6832 端口时，请不要打开注释。

### 配置 Jaeger HTTP Agent {#config-http-agent}

endpoint 代表 Jaeger HTTP Agent 路由

```toml
[[inputs.jaeger]]
  # Jaeger endpoint for receiving tracing span over HTTP.
  # Default value set as below. DO NOT MODIFY THE ENDPOINT if not necessary.
  endpoint = "/apis/traces"
```

- 修改 Jaeger Client 的 Agent Host Port 为 Datakit Port（默认为 9529）
- 修改 Jaeger Client 的 Agent endpoint 为上面配置中指定的 endpoint

### 配置 Jaeger UDP Agent {#config-udp-agent}

修改 Jaeger Client 的 Agent UDP Host:Port 为下面配置中指定的 address：

```toml
[[inputs.jaeger]]
  # Jaeger agent host:port address for UDP transport.
  address = "127.0.0.1:6831"
```

有关数据采样，数据过滤，关闭资源等配置请参考[Datakit Tracing](datakit-tracing.md)

## 示例 {#demo}

### Golang 示例 {#go-http}

以下是一个 HTTP Agent 示例：

```golang
package main

import (
  "fmt"
  "io"
  "log"
  "net/http"
  "net/http/httptest"
  "time"

  "github.com/opentracing/opentracing-go"
  "github.com/opentracing/opentracing-go/ext"
  "github.com/uber/jaeger-client-go"
  jaegercfg "github.com/uber/jaeger-client-go/config"
  jaegerlog "github.com/uber/jaeger-client-go/log"
)

var tracer opentracing.Tracer

func main() {
  jgcfg := jaegercfg.Configuration{
    ServiceName: "jaeger_sample_http",
    Sampler: &jaegercfg.SamplerConfig{
      Type:  jaeger.SamplerTypeConst,
      Param: 1,
    },
    Reporter: &jaegercfg.ReporterConfig{
      CollectorEndpoint:   "http://localhost:9529/apis/traces",
      HTTPHeaders:         map[string]string{"Content-Type": "application/x-thrift"},
      BufferFlushInterval: time.Second,
      LogSpans:            true,
    },
  }

  var (
    closer io.Closer
    err    error
  )
  tracer, closer, err = jgcfg.NewTracer(jaegercfg.Logger(jaegerlog.StdLogger))
  defer func() {
    if err := closer.Close(); err != nil {
      log.Println(err.Error())
    }
  }()
  if err != nil {
    log.Panicln(err.Error())
  }

  srv := httptest.NewServer(http.HandlerFunc(func(resp http.ResponseWriter, req *http.Request) {
    spctx, err := tracer.Extract(opentracing.HTTPHeaders, opentracing.HTTPHeadersCarrier(req.Header))
    var span opentracing.Span
    if err != nil {
      log.Println(err.Error())
      span = tracer.StartSpan(req.RequestURI)
    } else {
      span = tracer.StartSpan(req.RequestURI, ext.RPCServerOption(spctx))
    }
    defer span.Finish()

    span.SetTag("finish_ts", time.Now())

    resp.Write([]byte("hello, world"))
  }))

  for i := 0; i < 100; i++ {
    send(srv.URL, i)

    time.Sleep(time.Second)
  }
}

func send(urlstr string, i int) {
  span := tracer.StartSpan(fmt.Sprintf("main_loop->send(%d)", i))
  defer span.Finish()

  req, err := http.NewRequest(http.MethodGet, urlstr, nil)
  if err != nil {
    log.Println(err.Error())

    return
  }

  if err = tracer.Inject(span.Context(), opentracing.HTTPHeaders, opentracing.HTTPHeadersCarrier(req.Header)); err != nil {
    log.Panicln(err.Error())

    return
  }

  span.SetTag(fmt.Sprintf("send_%d_finish", i), time.Now())
}
```

### Golang UDP 示例 {#go-udp}

以下是一个 UDP Agent 示例：

```golang
package main

import (
  "io"
  "log"
  "time"

  "github.com/opentracing/opentracing-go"
  "github.com/uber/jaeger-client-go"
  jaegercfg "github.com/uber/jaeger-client-go/config"
  jaegerlog "github.com/uber/jaeger-client-go/log"
)

var tracer opentracing.Tracer

func main() {
  jgcfg := jaegercfg.Configuration{
    ServiceName: "jaeger_sample_app",
    Sampler: &jaegercfg.SamplerConfig{
      Type:  jaeger.SamplerTypeConst,
      Param: 1,
    },
    Reporter: &jaegercfg.ReporterConfig{
      LocalAgentHostPort:  "127.0.0.1:6831",
      BufferFlushInterval: time.Second,
      LogSpans:            true,
    },
  }

  var (
    closer io.Closer
    err    error
  )
  tracer, closer, err = jgcfg.NewTracer(jaegercfg.Logger(jaegerlog.StdLogger))
  defer func() {
    if err := closer.Close(); err != nil {
      log.Println(err.Error())
    }
  }()
  if err != nil {
    log.Panicln(err.Error())
  }

  for i := 0; i < 10; i++ {
    foo()

    time.Sleep(time.Second)
  }
}

func foo() {
  span := tracer.StartSpan("foo")
  defer span.Finish()

  span.SetTag("finish_ts", time.Now())
}
```

## 指标 {#metric}





### `jaeger`



- 标签


| Tag | Description |
|  ----  | --------|
|`base_service`|Span Base service name|
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




## Jaeger 官方文档 {#doc}

- [Quick Start](https://www.jaegertracing.io/docs/1.27/getting-started/){:target="_blank"}
- [Docs](https://www.jaegertracing.io/docs/){:target="_blank"}
- [Clients Download](https://www.jaegertracing.io/download/){:target="_blank"}
- [Source Code](https://github.com/jaegertracing/jaeger){:target="_blank"}
