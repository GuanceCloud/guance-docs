---
title     : 'Profiling'
summary   : 'Collect runtime performance data of applications'
__int_icon: 'icon/profiling'
tags:
  - 'PROFILE'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Profile supports collecting dynamic performance data of applications running in different language environments such as Java, Python, and Go, helping users identify CPU, memory, and IO performance issues.

## Configuration {#config}

Currently, DataKit collects profiling data in two ways:

- Push method: Requires enabling the DataKit Profile service, where the client actively pushes data to DataKit
- Pull method: Currently only supported for [Go](profile-go.md), requiring manual configuration of relevant information

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/profile` directory under the DataKit installation directory, copy `profile.conf.sample`, and rename it to `profile.conf`. The configuration file is explained as follows:
    
    ```shell
        
    [[inputs.profile]]
      ## profile Agent endpoints registered by version respectively.
      ## Endpoints can be skipped by removing them from the list.
      ## Default value set as below. DO NOT MODIFY THESE ENDPOINTS if not necessary.
      endpoints = ["/profiling/v1/input"]
    
      ## set true to enable election, pull mode only
      election = true
    
      ## the max allowed size of http request body (in MB), 32MB by default.
      body_size_limit_mb = 32 # MB
    
      ## set false to stop generating APM metrics from ddtrace output.
      generate_metrics = true
    
      ## io_config is used to control profiling uploading behavior.
      ## cache_path sets the disk directory where temporarily caching profiling data.
      ## cache_capacity_mb specifies the maximum storage space (in MiB) that profiling cache can use.
      ## clear_cache_on_start sets whether all previous profiling cache should be cleared on restarting Datakit.
      ## upload_workers sets the count of profiling uploading workers.
      ## send_timeout specifies the HTTP timeout when uploading profiling data to DataWay.
      ## send_retry_count sets the maximum retry count when sending each profiling request.
      # [inputs.profile.io_config]
      #   cache_path = "/usr/local/datakit/cache/profile_inputs"  # C:\Program Files\datakit\cache\profile_inputs by default on Windows
      #   cache_capacity_mb = 10240  # 10240MB
      #   clear_cache_on_start = false
      #   upload_workers = 8
      #   send_timeout = "75s"
      #   send_retry_count = 4
    
      ## set custom tags for profiling data
      # [inputs.profile.tags]
      #   some_tag = "some_value"
      #   more_tag = "some_other_value"
    
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
    
    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service) to enable the Profile service.

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

### Client Application Configuration {#app-config}

Client applications need to be configured separately based on the programming language. Supported languages include:

- [Java](profile-java.md)
- [Go](profile-go.md)
- [Python](profile-python.md)
- [C/C++](profile-cpp.md)
- [NodeJS](profile-nodejs.md)
- [.NET](profile-dotnet.md)

## Profiling Fields {#profiling}

All collected data will append a global tag named `host` (tag value is the hostname of the DataKit host) by default. Additional tags can also be specified using `[inputs.profile.tags]` in the configuration:

``` toml
 [inputs.profile.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `profile`

- Tags


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

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`duration`|Duration of span|int|μs|
|`message`|Origin content of span|string|-|
|`parent_id`|Parent span ID of current span|string|-|
|`resource`|Resource name producing current span|string|-|
|`span_id`|Span id|string|-|
|`start`|Start time of span.|int|usec|
|`trace_id`|Trace id|string|-|


</input_content>