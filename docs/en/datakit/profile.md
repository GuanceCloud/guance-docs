
# Profile Collection Configuration
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Profile supports collecting dynamic performance data of applications running in different language environments such as Java/Python, and helps users to view performance problems of CPU, memory and IO.

## Configuration Notes {#config}

At present, DataKit collects profiling data in two ways: 

- Push mode: the DataKit Profile service needs to be opened, and the client actively pushes data to the DataKit 

- Pull method: currently only [Go](profile-go.md) support, need to manually configure relevant information

### DataKit Configuration {#datakit-config}

=== "Host Installation"

    Go to the `conf.d/profile` directory under the DataKit installation directory, copy `profile.conf.sample` and name it `profile.conf`. The configuration file is described as follows:
    
    ```shell
        
    [[inputs.profile]]
      ## profile Agent endpoints register by version respectively.
      ## Endpoints can be skipped listen by remove them from the list.
      ## Default value set as below. DO NOT MODIFY THESE ENDPOINTS if not necessary.
      endpoints = ["/profiling/v1/input"]
    
      ## set true to enable election, pull mode only
      election = true
    
    ## go pprof config
    ## collect profiling data in pull mode
    #[[inputs.profile.go]]
      ## pprof url
      #url = "http://localhost:6060"
    
      ## pull interval, should be greater or equal than 10s
      #interval = "10s"
    
      ## service name
      #service = "go-demo"
    
      ## app env
      #env = "dev"
    
      ## app version
      #version = "0.0.0"
    
      ## types to pull
      ## values: cpu, goroutine, heap, mutex, block
      #enabled_types = ["cpu","goroutine","heap","mutex","block"]
    
    #[inputs.profile.go.tags]
      # tag1 = "val1"
    
    ## pyroscope config
    #[[inputs.profile.pyroscope]]
      ## listen url
      #url = "0.0.0.0:4040"
    
      ## service name
      #service = "pyroscope-demo"
    
      ## app env
      #env = "dev"
    
      ## app version
      #version = "0.0.0"
    
    #[inputs.profile.pyroscope.tags]
      #tag1 = "val1"
    
    ```
    
    Once configured, [restart DataKit](datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](datakit-daemonset-deploy.md#configmap-setting).

## Measurements {#measurements}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.profile.tags]`:

``` toml
 [inputs.profile.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `profile`



- tag


| Tag | Description |
|  ----  | --------|
|`container_host`|Container hostname. Available in OpenTelemetry. Optional.|
|`endpoint`|Endpoint info. Available in SkyWalking, Zipkin. Optional.|
|`env`|Application environment info. Available in Jaeger. Optional.|
|`http_method`|HTTP request method name. Available in ddtrace, OpenTelemetry. Optional.|
|`http_route`|HTTP route. Optional.|
|`http_status_code`|HTTP response code. Available in ddtrace, OpenTelemetry. Optional.|
|`http_url`|HTTP URL. Optional.|
|`operation`|Span name|
|`project`|Project name. Available in Jaeger. Optional.|
|`service`|Service name. Optional.|
|`source_type`|Tracing source type|
|`span_type`|Span type|
|`status`|Span status|
|`version`|Application version info. Available in Jaeger. Optional.|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`duration`|Duration of span|int|μs|
|`message`|Origin content of span|string|-|
|`parent_id`|Parent span ID of current span|string|-|
|`pid`|Application process id. Available in ddtrace, OpenTelemetry. Optional.|string|-|
|`priority`|Optional.|int|-|
|`resource`|Resource name produce current span|string|-|
|`span_id`|Span id|string|-|
|`start`|start time of span.|int|usec|
|`trace_id`|Trace id|string|-|


