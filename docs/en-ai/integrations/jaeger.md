---
title: 'Jaeger'
summary: 'Receive Jaeger APM Data'
__int_icon: 'icon/jaeger'
tags:
  - 'JAEGER'
  - 'Trace Analysis'
dashboard:
  - desc: 'None available'
    path: '-'
monitor:
  - desc: 'None available'
    path: '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The built-in Jaeger Agent in Datakit is used to receive, process, and analyze data from the Jaeger Tracing protocol.

## Configuration {#config}

<!-- markdownlint-disable MD046 -->
???+ info

    The current Jaeger version supports HTTP and UDP communication protocols with Apache Thrift encoding standards.

=== "Host Installation"

    Navigate to the `conf.d/jaeger` directory under the DataKit installation directory, copy `jaeger.conf.sample` and rename it to `jaeger.conf`. An example configuration is as follows:

    ```toml
        
    [[inputs.jaeger]]
      # Jaeger endpoint for receiving tracing spans over HTTP.
      # Default value set as below. DO NOT MODIFY THE ENDPOINT if not necessary.
      endpoint = "/apis/traces"
    
      # Jaeger agent host:port address for UDP transport.
      # address = "127.0.0.1:6831"
      # binary_address = "127.0.0.1:6832"
    
      ## ignore_tags will work as a blacklist to prevent tags from being sent to the data center.
      ## Every value in this list is a valid regular expression string.
      # ignore_tags = ["block1", "block2"]
    
      ## Keep rare tracing resources list switch.
      ## If some resources are rare enough (not present in 1 hour), those resources will always be sent
      ## to the data center and do not consider samplers and filters.
      # keep_rare_resource = false
    
      ## Delete trace message
      # del_message = true
    
      ## Ignore tracing resources map like service:[resources...].
      ## The service name is the full service name in the current application.
      ## The resource list is regular expressions used to block resource names.
      ## If you want to block some resources universally under all services, you can set the
      ## service name as "*". Note: double quotes "" cannot be omitted.
      # [inputs.jaeger.close_resource]
        # service1 = ["resource1", "resource2", ...]
        # service2 = ["resource1", "resource2", ...]
        # "*" = ["close_resource_under_all_services"]
        # ...
    
      ## Sampler config used to set global sampling strategy.
      ## sampling_rate used to set global sampling rate.
      # [inputs.jaeger.sampler]
        # sampling_rate = 1.0
    
      # [inputs.jaeger.tags]
        # key1 = "value1"
        # key2 = "value2"
        # ...
    
      ## Threads config controls how many goroutines an agent can start to handle HTTP requests.
      ## buffer is the size of jobs' buffering of worker channel.
      ## threads is the total number of goroutines at running time.
      ## timeout is the duration(ms) before a job can return a result.
      # [inputs.jaeger.threads]
        # buffer = 100
        # threads = 8
    
      ## Storage config sets up a local storage space on the hard drive to cache trace data.
      ## path is the local file path used to cache data.
      ## capacity is the total space size(MB) used to store data.
      # [inputs.jaeger.storage]
        # path = "./jaeger_storage"
        # capacity = 5120
    
    ```

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can inject collector configurations via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [configure ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) to enable collectors.

    Environment variables can also be used to modify configuration parameters (you need to add them as default collectors in ENV_DEFAULT_ENABLED_INPUTS):

    - **ENV_INPUT_JAEGER_HTTP_ENDPOINT**
    
        Endpoint for receiving tracing spans via HTTP
    
        **Field Type**: String
    
        **Collector Configuration Field**: `endpoint`
    
        **Example**: /apis/traces
    
    - **ENV_INPUT_JAEGER_UDP_ENDPOINT**
    
        UDP agent URL
    
        **Field Type**: String
    
        **Collector Configuration Field**: `address`
    
        **Example**: 127.0.0.1:6831
    
    - **ENV_INPUT_JAEGER_IGNORE_TAGS**
    
        Ignored tags
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `ignore_tags`
    
        **Example**: ["block1","block2"]
    
    - **ENV_INPUT_JAEGER_KEEP_RARE_RESOURCE**
    
        Keep rare tracing resources list
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `keep_rare_resource`
    
        **Default Value**: false
    
    - **ENV_INPUT_JAEGER_DEL_MESSAGE**
    
        Delete trace messages
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `del_message`
    
        **Default Value**: false
    
    - **ENV_INPUT_JAEGER_CLOSE_RESOURCE**
    
        Ignore specified services' tracing (regex match)
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `close_resource`
    
        **Example**: {"service1":["resource1","other"],"service2":["resource2","other"]}
    
    - **ENV_INPUT_JAEGER_SAMPLER**
    
        Global sampling rate
    
        **Field Type**: Float
    
        **Collector Configuration Field**: `sampler`
    
        **Example**: 0.3
    
    - **ENV_INPUT_JAEGER_THREADS**
    
        Number of threads and buffer
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `threads`
    
        **Example**: {"buffer":1000, "threads":100}
    
    - **ENV_INPUT_JAEGER_STORAGE**
    
        Local cache path and size (MB)
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `storage`
    
        **Example**: {"storage":"./jaeger_storage", "capacity": 5120}
    
    - **ENV_INPUT_JAEGER_TAGS**
    
        Custom tags. If the configuration file has the same named tags, they will override them.
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `tags`
    
        **Example**: {"k1":"v1", "k2":"v2", "k3":"v3"}

<!-- markdownlint-enable -->

When using the UDP protocol, note the data format in the protocol. By default, port 6831 uses the `thrift CompactProtocol` format, while port 6832 uses the `thrift BinaryProtocol` format.
Jaeger defaults to using the protocol on port 6831, so when you are not using port 6832, do not uncomment it.

### Configuring Jaeger HTTP Agent {#config-http-agent}

The `endpoint` represents the route for the Jaeger HTTP Agent.

```toml
[[inputs.jaeger]]
  # Jaeger endpoint for receiving tracing spans over HTTP.
  # Default value set as below. DO NOT MODIFY THE ENDPOINT if not necessary.
  endpoint = "/apis/traces"
```

- Modify the Jaeger Client's Agent Host Port to the DataKit Port (default is 9529).
- Modify the Jaeger Client's Agent endpoint to the endpoint specified in the configuration.

### Configuring Jaeger UDP Agent {#config-udp-agent}

Modify the Jaeger Client's Agent UDP Host:Port to the address specified in the configuration:

```toml
[[inputs.jaeger]]
  # Jaeger agent host:port address for UDP transport.
  address = "127.0.0.1:6831"
```

For more details on data sampling, filtering, and resource blocking configurations, refer to [DataKit Tracing](datakit-tracing.md).

## Example {#demo}

### Golang HTTP Example {#go-http}

Below is an example of an HTTP Agent:

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

### Golang UDP Example {#go-udp}

Below is an example of a UDP Agent:

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
| ---- | --------|
|`container_host`|Container hostname. Available in OpenTelemetry. Optional.|
|`dk_fingerprint`|DataKit fingerprint is DataKit hostname|
|`endpoint`|Endpoint information. Available in SkyWalking, Zipkin. Optional.|
|`env`|Application environment information. Available in Jaeger. Optional.|
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
|`version`|Application version information. Available in Jaeger. Optional.|

- Metric List

| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`duration`|Duration of span|int|μs|
|`message`|Origin content of span|string|-|
|`parent_id`|Parent span ID of current span|string|-|
|`resource`|Resource name that produces the current span|string|-|
|`span_id`|Span ID|string|-|
|`start`|Start time of span.|int|usec|
|`trace_id`|Trace ID|string|-|

## Official Jaeger Documentation {#doc}

- [Quick Start](https://www.jaegertracing.io/docs/1.27/getting-started/){:target="_blank"}
- [Docs](https://www.jaegertracing.io/docs/){:target="_blank"}
- [Clients Download](https://www.jaegertracing.io/download/){:target="_blank"}
- [Source Code](https://github.com/jaegertracing/jaeger){:target="_blank"}