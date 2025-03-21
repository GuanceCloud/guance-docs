---
title     : 'Zipkin'
summary   : 'Zipkin Tracing data ingestion'
__int_icon      : 'icon/zipkin'
tags      :
  - 'ZIPKIN'
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

The Zipkin Agent embedded in Datakit is used to receive, process, and analyze data following the Zipkin Tracing protocol.

## Configuration {#config}

### Collector Configuration {#input-config}
<!-- markdownlint-disable MD046 -->
=== "HOST installation"

    Navigate to the `conf.d/zipkin` directory under the DataKit installation directory, copy `zipkin.conf.sample`, and rename it as `zipkin.conf`. An example is shown below:

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

    After configuring, simply restart DataKit.

=== "Kubernetes"

    Currently, the collector configuration can be injected via the [ConfigMap method](../datakit/datakit-daemonset-deploy.md#configmap-setting) to enable the collector.

    Supported environment variables in Kubernetes are listed in the table below:

    | Environment Variable Name                            | Type        | Example                                                                             |
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

## Trace Fields {#tracing}





### `zipkin`



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
|`resource`|Resource name produce current span|string|-|
|`span_id`|Span id|string|-|
|`start`|start time of span.|int|usec|
|`trace_id`|Trace id|string|-|




## Zipkin Documentation {#docs}

- [Quick Start](https://zipkin.io/pages/quickstart.html){:target="_blank"}
- [Docs](https://zipkin.io/pages/instrumenting.html){:target="_blank"}
- [Source Code](https://github.com/openzipkin/zipkin){:target="_blank"}