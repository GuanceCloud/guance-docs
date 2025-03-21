---
title     : 'Jaeger'
summary   : 'Receive Jaeger APM data'
__int_icon      : 'icon/jaeger'
tags      :
  - 'JAEGER'
  - 'APM'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The Jaeger Agent embedded in Datakit is used to receive, process, and analyze data from the Jaeger Tracing protocol.

## Configuration {#config}

<!-- markdownlint-disable MD046 -->
???+ info

    The current Jaeger version supports HTTP and UDP communication protocols and Apache Thrift encoding specifications.

=== "HOST Installation"

    Navigate to the `conf.d/jaeger` directory under the DataKit installation directory, copy `jaeger.conf.sample` and rename it to `jaeger.conf`. Example as follows:

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

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can inject the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [configure ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) to enable the collector.

    It also supports modifying configuration parameters using environment variables (you need to add it as the default collector in ENV_DEFAULT_ENABLED_INPUTS):

    - **ENV_INPUT_JAEGER_HTTP_ENDPOINT**
    
        Endpoint that receives tracing spans through HTTP
    
        **Field Type**: String
    
        **Collector Configuration Field**: `endpoint`
    
        **Example**: /apis/traces
    
    - **ENV_INPUT_JAEGER_UDP_ENDPOINT**
    
        UDP proxy URL
    
        **Field Type**: String
    
        **Collector Configuration Field**: `address`
    
        **Example**: 127.0.0.1:6831
    
    - **ENV_INPUT_JAEGER_IGNORE_TAGS**
    
        Ignored tags
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `ignore_tags`
    
        **Example**: ["block1","block2"]
    
    - **ENV_INPUT_JAEGER_KEEP_RARE_RESOURCE**
    
        Keeps the list of rare tracing resources
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `keep_rare_resource`
    
        **Default Value**: false
    
    - **ENV_INPUT_JAEGER_DEL_MESSAGE**
    
        Deletes trace messages
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `del_message`
    
        **Default Value**: false
    
    - **ENV_INPUT_JAEGER_CLOSE_RESOURCE**
    
        Ignores specified server tracings (regex matching)
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `close_resource`
    
        **Example**: {"service1":["resource1","other"],"service2":["resource2","other"]}
    
    - **ENV_INPUT_JAEGER_SAMPLER**
    
        Global sampling rate
    
        **Field Type**: Float
    
        **Collector Configuration Field**: `sampler`
    
        **Example**: 0.3
    
    - **ENV_INPUT_JAEGER_THREADS**
    
        Number of threads and buffers
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `threads`
    
        **Example**: {"buffer":1000, "threads":100}
    
    - **ENV_INPUT_JAEGER_STORAGE**
    
        Local cache path and size (MB)
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `storage`
    
        **Example**: {"storage":"./jaeger_storage", "capacity": 5120}
    
    - **ENV_INPUT_JAEGER_TAGS**
    
        Custom tags. If there are same-name tags in the configuration file, they will override them.
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `tags`
    
        **Example**: {"k1":"v1", "k2":"v2", "k3":"v3"}

<!-- markdownlint-enable -->

When using the UDP protocol, note the data format in the protocol. By default, port 6831 uses the `thrift CompactProtocol` format, and port 6832 uses the `thrift BinaryProtocol` format.
Jaeger defaults to the protocol on port 6831, so if you are not using port 6832, do not uncomment it.

### Configure Jaeger HTTP Agent {#config-http-agent}

The endpoint represents the Jaeger HTTP Agent route.

```toml
[[inputs.jaeger]]
  # Jaeger endpoint for receiving tracing span over HTTP.
  # Default value set as below. DO NOT MODIFY THE ENDPOINT if not necessary.
  endpoint = "/apis/traces"
```

- Modify the Agent Host Port of the Jaeger Client to the Datakit Port (default is 9529).
- Modify the Agent endpoint of the Jaeger Client to the endpoint specified in the above configuration.

### Configure Jaeger UDP Agent {#config-udp-agent}

Modify the Agent UDP Host:Port of the Jaeger Client to the address specified in the following configuration:

```toml
[[inputs.jaeger]]
  # Jaeger agent host:port address for UDP transport.
  address = "127.0.0.1:6831"
```

For configurations related to data sampling, data filtering, and closing resources, please refer to [Datakit Tracing](datakit-tracing.md).

## Example {#demo}

### Golang Example (HTTP) {#go-http}

Below is an HTTP Agent example:

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

### Golang Example (UDP) {#go-udp}

Below is a UDP Agent example:

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

## Metrics {#metric}





### `jaeger`



- Tags


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

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`duration`|Duration of span|int|μs|
|`message`|Origin content of span|string|-|
|`parent_id`|Parent span ID of current span|string|-|
|`resource`|Resource name produce current span|string|-|
|`span_id`|Span id|string|-|
|`start`|start time of span.|int|usec|
|`trace_id`|Trace id|string|-|




## Official Jaeger Documentation {#doc}

- [Quick Start](https://www.jaegertracing.io/docs/1.27/getting-started/){:target="_blank"}
- [Docs](https://www.jaegertracing.io/docs/){:target="_blank"}
- [Clients Download](https://www.jaegertracing.io/download/){:target="_blank"}
- [Source Code](https://github.com/jaegertracing/jaeger){:target="_blank"}