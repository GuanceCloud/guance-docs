---
title     : 'DDTrace'
summary   : 'Receive APM data from DDTrace'
__int_icon: 'icon/ddtrace'
dashboard :
  - desc  : 'N/A'
    path  : '-'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# DDTrace
<!-- markdownlint-enable -->
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

DDTrace Agent embedded in Datakit is used to receive, calculate and analyze DataDog Tracing protocol data.

## DDTrace Documentation and Examples {#doc-example}

<!-- markdownlint-disable MD046 MD032 MD030 -->
<div class="grid cards" markdown>
-   :fontawesome-brands-python: __Python__

    ---

    [:octicons-code-16: SDK](https://github.com/DataDog/dd-trace-py){:target="_blank"} ·
    [:octicons-book-16: doc](https://docs.datadoghq.com/tracing/setup_overview/setup/python?tab=containers){:target="_blank"} ·
    [:octicons-arrow-right-24: example](ddtrace-python.md)

-   :material-language-java: __Java__

    ---

    [:octicons-code-16: SDK](https://static.guance.com/dd-image/dd-java-agent.jar){:target="_blank"} ·
    [:octicons-book-16: doc](https://docs.datadoghq.com/tracing/setup_overview/setup/java?tab=containers){:target="_blank"} ·
    [:octicons-arrow-right-24: example](ddtrace-java.md)

-   :material-language-ruby: __Ruby__

    ---

    [:octicons-code-16: SDK](https://github.com/DataDog/dd-trace-rb){:target="_blank"} ·
    [:octicons-book-16: doc](https://docs.datadoghq.com/tracing/setup_overview/setup/ruby){:target="_blank"} ·
    [:octicons-arrow-right-24: example](ddtrace-java.md)

-   :fontawesome-brands-golang: __Golang__

    ---

    [:octicons-code-16: SDK](https://github.com/DataDog/dd-trace-go){:target="_blank"} ·
    [:octicons-book-16: doc](https://docs.datadoghq.com/tracing/setup_overview/setup/go?tab=containers){:target="_blank"} ·
    [:octicons-arrow-right-24: example](ddtrace-golang.md)

-   :material-language-php: __PHP__

    ---

    [:octicons-code-16: SDK](https://github.com/DataDog/dd-trace-php){:target="_blank"} ·
    [:octicons-book-16: doc](https://docs.datadoghq.com/tracing/setup_overview/setup/php?tab=containers){:target="_blank"} ·
    [:octicons-arrow-right-24: example](ddtrace-php.md)

-   :fontawesome-brands-node-js: __NodeJS__

    ---

    [:octicons-code-16: SDK](https://github.com/DataDog/dd-trace-js){:target="_blank"} ·
    [:octicons-book-16: doc](https://docs.datadoghq.com/tracing/setup_overview/setup/nodejs?tab=containers){:target="_blank"} ·
    [:octicons-arrow-right-24: example](ddtrace-nodejs.md)

-   :material-language-cpp:

    ---

    [:octicons-code-16: SDK](https://github.com/opentracing/opentracing-cpp){:target="_blank"} ·
    [:octicons-book-16: doc](https://docs.datadoghq.com/tracing/setup_overview/setup/cpp?tab=containers){:target="_blank"} ·
    [:octicons-arrow-right-24: example](ddtrace-cpp.md)

-   :material-dot-net:

    ---

    [:octicons-code-16: SDK](https://github.com/DataDog/dd-trace-dotnet){:target="_blank"} ·
    [:octicons-book-16: doc](https://docs.datadoghq.com/tracing/setup_overview/setup/dotnet-framework?tab=windows){:target="_blank"} ·
    [:octicons-book-16: .Net Core doc](https://docs.datadoghq.com/tracing/setup_overview/setup/dotnet-framework?tab=windows){:target="_blank"}
</div>

???+ tip

    The DataKit installation directory, under the `data` directory, has a pre-prepared `dd-java-agent.jar`(recommended). You can also download it directly from [Maven download](https://mvnrepository.com/artifact/com.datadoghq/dd-java-agent){:target="_blank"}

    Guance Cloud also Fork its own branch on the basis of Ddtrace-Java, adding more functions and probes. For more version details, please see [Ddtrace Secondary Development Version Description](../developers/ddtrace-guance.md)

## Configuration {#config}

### Collector Configuration {#input-config}

=== "Host Installation"

    Go to the `conf.d/ddtrace` directory under the DataKit installation directory, copy `ddtrace.conf.sample` and name it `ddtrace.conf`. Examples are as follows:

    ```toml
        
    [[inputs.ddtrace]]
      ## DDTrace Agent endpoints register by version respectively.
      ## Endpoints can be skipped listen by remove them from the list.
      ## NOTE: DO NOT EDIT.
      endpoints = ["/v0.3/traces", "/v0.4/traces", "/v0.5/traces"]
    
      ## customer_tags will work as a whitelist to prevent tags send to data center.
      ## All . will replace to _ ,like this :
      ## "project.name" to send to GuanCe center is "project_name"
      # customer_tags = ["sink_project", "custom_dd_tag"]
    
      ## Keep rare tracing resources list switch.
      ## If some resources are rare enough(not presend in 1 hour), those resource will always send
      ## to data center and do not consider samplers and filters.
      # keep_rare_resource = false
    
      ## By default every error presents in span will be send to data center and omit any filters or
      ## sampler. If you want to get rid of some error status, you can set the error status list here.
      # omit_err_status = ["404"]
    
      ## compatible otel: It is possible to compatible OTEL Trace with DDTrace trace.
      ## make span_id and parent_id to hex encoding.
      # compatible_otel=true
    
      ##  It is possible to compatible B3/B3Multi TraceID with DDTrace.
      # trace_id_64_bit_hex=true
    
      ## delete trace message
      # del_message = true
    
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

    Once configured, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Can be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [Config ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) .

    Can also be turned on by environment variables, (needs to be added as the default collector in ENV_DEFAULT_ENABLED_INPUTS):
    
    - **ENV_INPUT_DDTRACE_ENDPOINTS**
    
        Agent endpoints
    
        **Type**: JSON
    
        **input.conf**: `endpoints`
    
        **Example**: ["/v0.3/traces", "/v0.4/traces", "/v0.5/traces"]
    
    - **ENV_INPUT_DDTRACE_CUSTOMER_TAGS**
    
        Whitelist to tags
    
        **Type**: JSON
    
        **input.conf**: `customer_tags`
    
        **Example**: `["sink_project", "custom_dd_tag"]`
    
    - **ENV_INPUT_DDTRACE_KEEP_RARE_RESOURCE**
    
        Keep rare tracing resources list switch
    
        **Type**: Boolean
    
        **input.conf**: `keep_rare_resource`
    
        **Default**: false
    
    - **ENV_INPUT_DDTRACE_COMPATIBLE_OTEL**
    
        Compatible `OTEL Trace` with `DDTrace trace`
    
        **Type**: Boolean
    
        **input.conf**: `compatible_otel`
    
        **Default**: false
    
    - **ENV_INPUT_DDTRACE_TRACE_ID_64_BIT_HEX**
    
        Compatible `B3/B3Multi TraceID` with `DDTrace`
    
        **Type**: Boolean
    
        **input.conf**: `trace_id_64_bit_hex`
    
        **Default**: false
    
    - **ENV_INPUT_DDTRACE_DEL_MESSAGE**
    
        Delete trace message
    
        **Type**: Boolean
    
        **input.conf**: `del_message`
    
        **Default**: false
    
    - **ENV_INPUT_DDTRACE_OMIT_ERR_STATUS**
    
        Whitelist to error status
    
        **Type**: JSON
    
        **input.conf**: `omit_err_status`
    
        **Example**: ["404", "403", "400"]
    
    - **ENV_INPUT_DDTRACE_CLOSE_RESOURCE**
    
        Ignore tracing resources that service (regular)
    
        **Type**: JSON
    
        **input.conf**: `close_resource`
    
        **Example**: {"service1":["resource1","other"],"service2":["resource2","other"]}
    
    - **ENV_INPUT_DDTRACE_SAMPLER**
    
        Global sampling rate
    
        **Type**: Float
    
        **input.conf**: `sampler`
    
        **Example**: 0.3
    
    - **ENV_INPUT_DDTRACE_THREADS**
    
        Total number of threads and buffer
    
        **Type**: JSON
    
        **input.conf**: `threads`
    
        **Example**: {"buffer":1000, "threads":100}
    
    - **ENV_INPUT_DDTRACE_STORAGE**
    
        Local cache file path and size (MB) 
    
        **Type**: JSON
    
        **input.conf**: `storage`
    
        **Example**: {"storage":"./ddtrace_storage", "capacity": 5120}
    
    - **ENV_INPUT_DDTRACE_TAGS**
    
        Customize tags. If there is a tag with the same name in the configuration file, it will be overwritten
    
        **Type**: JSON
    
        **input.conf**: `tags`
    
        **Example**: {"k1":"v1", "k2":"v2", "k3":"v3"}

### Notes on Linking Multiple Line Tools {#trace_propagator}
DDTrace currently supports the following propagation protocols: `datadog/b3multi/tracecontext`. There are two things to note:

- When using `tracecontext`, the `compatible_otel=true` switch needs to be turned on in the configuration because the link ID is 128 bits.
- When using `b3multi`, pay attention to the length of `trace_id`. If it is 64-bit hex encoding, the `trace_id_64_bit_hex=true` needs to be turned on in the configuration file.
- For more propagation protocol and tool usage, please refer to: [Multi-Link Concatenation](tracing-propagator.md){:target="_blank"}

### Add Pod and Node tags {#add-pod-node-info}

When your service deployed on Kubernetes, we can add Pod/Node tags to Span, edit your Pod yaml, here is a Deployment yaml example:

```yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  selector:
    matchLabels:
      app: my-app
  replicas: 3
  template:
    metadata:
      labels:
        app: my-app
        service: my-service
    spec:
      containers:
        - name: my-app
          image: my-app:v0.0.1
          env:
            - name: POD_NAME    # <------
              valueFrom:
                fieldRef:
                  fieldPath: metadata.name
            - name: NODE_NAME
              valueFrom:
                fieldRef:
                  fieldPath: spec.nodeName
            - name: DD_SERVICE
              valueFrom:
                fieldRef:
                  fieldPath: metadata.labels['service']
            - name: DD_TAGS
              value: pod_name:$(POD_NAME),host:$(NODE_NAME)
```

Here we must define `POD_NAME` and `NODE_NAME` before reference them in dedicated environment keys of DDTrace:

After your Pod started, enter the Pod, we can check if environment applied:

```shell
$ env | grep DD_
...
```

Once environment set, the Pod/Node name will attached to related Span tags.

---

???+ attention

    - Don't modify the `endpoints` list here.

    ```toml
    endpoints = ["/v0.3/traces", "/v0.4/traces", "/v0.5/traces"]
    ```

    - If you want to turn off sampling (that is, collect all data), the sampling rate field needs to be set as follows:

    ``` toml
    # [inputs.ddtrace.sampler]
    # sampling_rate = 1.0
    ```

    Don't just comment on the line `sampling_rate = 1.0` , it must be commented out along with `[inputs.ddtrace.sampler]` , or the collector will assume that `sampling_rate` is set to 0.0, causing all data to be discarded.

<!-- markdownlint-enable -->

### HTTP Settings {#http}

If Trace data is sent across machines, you need to set [HTTP settings for DataKit](datakit-conf.md#config-http-server).

If you have ddtrace data sent to the DataKit, you can see it on [DataKit's monitor](datakit-monitor.md):

<figure markdown>
  ![input-ddtrace-monitor](https://static.guance.com/images/datakit/input-ddtrace-monitor.png){ width="800" }
  <figcaption> DDtrace sends data to the /v0.4/traces interface</figcaption>
</figure>

### Turn on Disk Cache {#disk-cache}

If the amount of Trace data is large, in order to avoid causing a lot of resource overhead to the host, you can temporarily cache the Trace data to disk and delay processing:

``` toml
[inputs.ddtrace.storage]
  path = "/path/to/ddtrace-disk-storage"
  capacity = 5120
```

### DDtrace SDK Configuration {#sdk}

After configuring the collector, you can also do some configuration on the DDtrace SDK side.

### Environment Variables Setting {#sdk-envs}

- `DD_TRACE_ENABLED`: Enable global tracer (Partial language platform support)
- `DD_AGENT_HOST`: DDtrace agent host address
- `DD_TRACE_AGENT_PORT`: DDtrace agent host port
- `DD_SERVICE`: Service name
- `DD_TRACE_SAMPLE_RATE`: Set sampling rate
- `DD_VERSION`: Application version (optional)
- `DD_TRACE_STARTUP_LOGS`: DDtrace logger
- `DD_TRACE_DEBUG`: DDtrace debug mode
- `DD_ENV`: Application env values
- `DD_TAGS`: Application

In addition to setting the project name, environment name, and version number when initialization is applied, you can also set them in the following two ways:

- Inject environment variables from the command line

```shell
DD_TAGS="project:your_project_name,env=test,version=v1" ddtrace-run python app.py
```

- Configure custom tags directly in ddtrace. conf. This approach affects __all__ data sends to the DataKit tracing service and should be considered carefully:

```toml
# tags is ddtrace configed key value pairs
[inputs.ddtrace.tags]
  some_tag = "some_value"
  more_tag = "some_other_value"
```

### Add a Business Tag to your Code {#add-tags}

Starting from DataKit version [1.21.0](../datakit/changelog.md#cl-1.21.0), do not include All in Span.Mate are advanced to the first level label and only select following list labels:

| Mete              | GuanCe tag        | doc                   |
|:------------------|:------------------|:----------------------|
| http.url          | http_url          | HTTP url              |
| http.hostname     | http_hostname     | hostname              |
| http.route        | http_route        | route                 |
| http.status_code  | http_status_code  | status code           |
| http.method       | http_method       | method                |
| http.client_ip    | http_client_ip    | client IP             |
| sampling.priority | sampling_priority | sample                |
| span.kind         | span_kind         | span kind             |
| error             | error             | is error              |
| dd.version        | dd_version        | agent version         |
| error.message     | error_message     | error message         |
| error.stack       | error_stack       | error stack           |
| error.type        | error_type        | error type            |
| system.pid        | pid               | pid                   |
| error.msg         | error_message     | error message         |
| project           | project           | project               |
| version           | version           | version               |
| env               | env               | env                   |
| host              | host              | host from dd.tags     |
| pod_name          | pod_name          | pod_name from dd.tags |
| _dd.base_service  | _dd_base_service  | base service          |

In the link interface of the observation cloud, tags that are not in the list can also be filtered.

Restore whitelist functionality from DataKit version [1.22.0](../datakit/changelog.md#cl-1.22.0). If there are labels that must be extracted from the first level label list, they can be found in the `customer_tags`.

If the configured whitelist label is in the native `message.meta`, Will convert to replace `.` with `_`.

## Tracing {#tracing}





### `ddtrace`



- tag


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

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`duration`|Duration of span|int|μs|
|`message`|Origin content of span|string|-|
|`parent_id`|Parent span ID of current span|string|-|
|`resource`|Resource name produce current span|string|-|
|`span_id`|Span id|string|-|
|`start`|start time of span.|int|usec|
|`trace_id`|Trace id|string|-|




## More Readings {#more-reading}

- [DataKit Tracing Field definition](datakit-tracing-struct.md)
- [DataKit general Tracing data collection instructions](datakit-tracing.md)
- [Proper use of regular expressions to configure](datakit-input-conf.md#debug-regex)
