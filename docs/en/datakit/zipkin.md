
# Zipkin
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The Zipkin Agent embedded in Datakit is used to receive, calculate and analyze the data of Zipkin Tracing protocol.

## Zipkin Docs {#docs}

- [Quickstart](https://zipkin.io/pages/quickstart.html){:target="_blank"}
- [Docs](https://zipkin.io/pages/instrumenting.html){:target="_blank"}
- [Souce Code](https://github.com/openzipkin/zipkin){:target="_blank"}

## Configure Zipkin Agent {#config-agent}

=== "Host Installation"

    Go to the `conf.d/zipkin` directory under the DataKit installation directory, copy `zipkin.conf.sample` and name it `zipkin.conf`. Examples are as follows:
    
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

    After configuration, restart DataKit.

=== "Kubernetes"

    At present, the collector can be turned on by [injecting the collector configuration in ConfigMap mode](datakit-daemonset-deploy.md#configmap-setting).

## Measurements {#measurements}





### `zipkin`



- tag


| Tag | Description |
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

- metric list


| Metric | Description | Type | Unit |
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


