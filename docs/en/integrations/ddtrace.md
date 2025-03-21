---
title     : 'DDTrace'
summary   : 'Receive APM data from DDTrace'
__int_icon: 'icon/ddtrace'
tags      :
  - 'DDTRACE'
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

DDTrace is an open-source APM product from DataDog. The DDTrace Agent embedded in Datakit is used to receive, compute, and analyze DataDog Tracing protocol data.

## DDTrace Documentation and Examples {#doc-example}

<!-- markdownlint-disable MD046 MD032 MD030 -->
<div class="grid cards" markdown>
-   :fontawesome-brands-python: __Python__

    ---

    [SDK :material-download:](https://github.com/DataDog/dd-trace-py){:target="_blank"} ·
    [:octicons-book-16: Documentation](https://docs.datadoghq.com/tracing/setup_overview/setup/python?tab=containers){:target="_blank"} ·
    [:octicons-arrow-right-24: Example](ddtrace-python.md)

-   :material-language-java: __Java__

    ---

    [SDK :material-download:](https://static.<<< custom_key.brand_main_domain >>>/dd-image/dd-java-agent.jar){:target="_blank"} ·
    [:octicons-book-16: Documentation](https://docs.datadoghq.com/tracing/setup_overview/setup/java?tab=containers){:target="_blank"} ·
    [:octicons-arrow-right-24: Example](ddtrace-java.md)

-   :material-language-ruby: __Ruby__

    ---

    [SDK :material-download:](https://github.com/DataDog/dd-trace-rb){:target="_blank"} ·
    [:octicons-book-16: Documentation](https://docs.datadoghq.com/tracing/setup_overview/setup/ruby){:target="_blank"} ·
    [:octicons-arrow-right-24: Example](ddtrace-ruby.md)

-   :fontawesome-brands-golang: __Golang__

    ---

    [SDK :material-download:](https://github.com/DataDog/dd-trace-go){:target="_blank"} ·
    [:octicons-book-16: Documentation](https://docs.datadoghq.com/tracing/setup_overview/setup/go?tab=containers){:target="_blank"} ·
    [:octicons-arrow-right-24: Example](ddtrace-golang.md)

-   :material-language-php: __PHP__

    ---

    [SDK :material-download:](https://github.com/DataDog/dd-trace-php){:target="_blank"} ·
    [:octicons-book-16: Documentation](https://docs.datadoghq.com/tracing/setup_overview/setup/php?tab=containers){:target="_blank"} ·
    [:octicons-arrow-right-24: Example](ddtrace-php.md)

-   :fontawesome-brands-node-js: __NodeJS__

    ---

    [SDK :material-download:](https://github.com/DataDog/dd-trace-js){:target="_blank"} ·
    [:octicons-book-16: Documentation](https://docs.datadoghq.com/tracing/setup_overview/setup/nodejs?tab=containers){:target="_blank"} ·
    [:octicons-arrow-right-24: Example](ddtrace-nodejs.md)

-   :material-language-cpp:

    ---

    [SDK :material-download:](https://github.com/opentracing/opentracing-cpp){:target="_blank"} ·
    [:octicons-book-16: Documentation](https://docs.datadoghq.com/tracing/setup_overview/setup/cpp?tab=containers){:target="_blank"} ·
    [:octicons-arrow-right-24: Example](ddtrace-cpp.md)

-   :material-dot-net:

    ---

    [SDK :material-download:](https://github.com/DataDog/dd-trace-dotnet){:target="_blank"} ·
    [:octicons-book-16: .Net Framework Documentation](https://docs.datadoghq.com/tracing/trace_collection/automatic_instrumentation/dd_libraries/dotnet-framework?tab=windows){:target="_blank"} ·
    [:octicons-book-16: .Net Core Documentation](https://docs.datadoghq.com/tracing/trace_collection/automatic_instrumentation/dd_libraries/dotnet-core?tab=windows){:target="_blank"}
</div>

???+ tip

    We have made some [feature extensions](ddtrace-ext-changelog.md) to DDTrace to support more mainstream frameworks and finer-grained data tracing.

## Configuration {#config}

=== "HOST Installation"

    Go to the `conf.d/ddtrace` directory under the DataKit installation directory, copy `ddtrace.conf.sample` and rename it as `ddtrace.conf`. Example as follows:

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
    
      ## When true, the tracer generates 128 bit Trace IDs, 
      ## and encodes Trace IDs as 32 lowercase hexadecimal characters with zero padding.
      ## default is true.
      # trace_128_bit_id = true
    
      ## delete trace message
      # del_message = true
    
      ## max spans limit on each trace. default 100000 or set to -1 to remove this limit.
      # trace_max_spans = 100000
    
      ## max trace body(Content-Length) limit. default 32MiB or set to -1 to remove this limit.
      # max_trace_body_mb = 32
    
      ## Ignore tracing resources map like service:[resources...].
      ## The service name is the full service name in current application.
      ## The resource list is regular expressions uses to block resource names.
      ## If you want to block some resources universally under all services, you can set the
      ## service name as "*". Note: double quotes "" cannot be omitted.
      # [inputs.ddtrace.close_resource]
      #   service1 = ["resource1", "resource2", ...]
      #   service2 = ["resource1", "resource2", ...]
      #   "*" = ["close_resource_under_all_services"]
      #   ...
    
      ## Sampler config uses to set global sampling strategy.
      ## sampling_rate used to set global sampling rate.
      # [inputs.ddtrace.sampler]
      #   sampling_rate = 1.0
    
      # [inputs.ddtrace.tags]
      #   key1 = "value1"
      #   key2 = "value2"
      #   ...
    
      ## Threads config controls how many goroutines an agent cloud start to handle HTTP request.
      ## buffer is the size of jobs' buffering of worker channel.
      ## threads is the total number fo goroutines at running time.
      # [inputs.ddtrace.threads]
      #   buffer = 100
      #   threads = 8
    
      ## Storage config a local storage space in hard dirver to cache trace data.
      ## path is the local file path used to cache data.
      ## capacity is total space size(MB) used to store data.
      # [inputs.ddtrace.storage]
      #   path = "./ddtrace_storage"
      #   capacity = 5120
    
    ```

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can enable the collector via [ConfigMap injection](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [ENV_DATAKIT_INPUTS configuration](../datakit/datakit-daemonset-deploy.md#env-setting).

    It also supports modifying configuration parameters via environment variables (requires adding it to ENV_DEFAULT_ENABLED_INPUTS as the default collector):

    - **ENV_INPUT_DDTRACE_ENDPOINTS**
    
        Proxy endpoints
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `endpoints`
    
        **Example**: ["/v0.3/traces", "/v0.4/traces", "/v0.5/traces"]
    
    - **ENV_INPUT_DDTRACE_CUSTOMER_TAGS**
    
        Tag whitelist
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `customer_tags`
    
        **Example**: `["sink_project", "custom_dd_tag"]`
    
    - **ENV_INPUT_DDTRACE_KEEP_RARE_RESOURCE**
    
        Keep rare tracing resource list
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `keep_rare_resource`
    
        **Default Value**: false
    
    - **ENV_INPUT_DDTRACE_COMPATIBLE_OTEL**
    
        Compatible `otel Trace` with `DDTrace Trace`
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `compatible_otel`
    
        **Default Value**: false
    
    - **ENV_INPUT_DDTRACE_TRACE_ID_64_BIT_HEX**
    
        Compatible `B3/B3Multi-TraceID` with `DDTrace`
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `trace_id_64_bit_hex`
    
        **Default Value**: false
    
    - **ENV_INPUT_DDTRACE_TRACE_128_BIT_ID**
    
        Trace IDs as 32 lowercase hexadecimal
    
        **Type**: Boolean
    
        **input.conf**: `trace_128_bit_id`
    
        **Default**: true
    
    - **ENV_INPUT_DDTRACE_DEL_MESSAGE**
    
        Delete trace message
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `del_message`
    
        **Default Value**: false
    
    - **ENV_INPUT_DDTRACE_OMIT_ERR_STATUS**
    
        Error status whitelist
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `omit_err_status`
    
        **Example**: ["404", "403", "400"]
    
    - **ENV_INPUT_DDTRACE_CLOSE_RESOURCE**
    
        Ignore specified server tracing (regex match)
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `close_resource`
    
        **Example**: {"service1":["resource1","other"],"service2":["resource2","other"]}
    
    - **ENV_INPUT_DDTRACE_SAMPLER**
    
        Global sampling rate
    
        **Field Type**: Float
    
        **Collector Configuration Field**: `sampler`
    
        **Example**: 0.3
    
    - **ENV_INPUT_DDTRACE_THREADS**
    
        Number of threads and buffers
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `threads`
    
        **Example**: {"buffer":1000, "threads":100}
    
    - **ENV_INPUT_DDTRACE_STORAGE**
    
        Local cache path and size (MB)
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `storage`
    
        **Example**: {"storage":"./ddtrace_storage", "capacity": 5120}
    
    - **ENV_INPUT_DDTRACE_TAGS**
    
        Custom tags. If the same-named tag is configured in the configuration file, it will override it.
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `tags`
    
        **Example**: {"k1":"v1", "k2":"v2", "k3":"v3"}
    
    - **ENV_INPUT_DDTRACE_ENV_INPUT_DDTRACE_MAX_SPANS**
    
        Maximum number of spans per trace. If this limit is exceeded, extra spans will be truncated; setting it to -1 disables the limit.
    
        **Field Type**: Int
    
        **Collector Configuration Field**: `env_input_ddtrace_max_spans`
    
        **Example**: 1000
    
        **Default Value**: 100000
    
    - **ENV_INPUT_DDTRACE_ENV_INPUT_DDTRACE_MAX_BODY_MB**
    
        Maximum body byte count for a single trace API request (in MiB); setting it to -1 disables the limit.
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `env_input_ddtrace_max_body_mb`
    
        **Example**: 32
    
        **Default Value**: 10

### Multi-line Tool Chaining Considerations {#trace_propagator}

In the DDTrace data structure, the TraceID is of type uint64. When using the propagation protocol `tracecontext`, an additional tag `_dd.p.tid:67c573cf00000000` is added internally in the DDTrace trace details.
This is because the `trace_id` in the `tracecontext` protocol is a 128-bit hexadecimal encoded string. To ensure compatibility, a high-order tag is added.

- When using `tracecontext`, the `compatible_otel=true` and `trace_128_bit_id` switch needs to be turned on in the configuration because the link ID is 128 bits.
- When using `b3multi`, pay attention to the length of `trace_id`. If it is 64-bit hex encoding, the `trace_id_64_bit_hex=true` needs to be turned on in the configuration file.
- For more propagation protocol and tool usage, please refer to: [Multi-Link Concatenation](tracing-propagator.md){:target="_blank"}


???+ tip

    compatible_otel function: Converts span_id and parent_id into hexadecimal strings.
    trace_128_bit_id function: Combines the "_dd.p.tid" from meta with trace_id to form a 32-character hexadecimal encoded string.
    trace_id_64_bit_hex function: Converts a 64-bit trace_id into a hexadecimal encoded string.


### Add Pod and Node tags {#add-pod-node-info}

### Inject Pod and Node Information {#add-pod-node-info}

When deploying applications in container environments such as Kubernetes, we can append Pod/Node information to the final Span data by modifying the application's Yaml. Below is an example of a Kubernetes Deployment yaml:

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

Note that `POD_NAME` and `NODE_NAME` must be defined first, and then embedded into the DDTrace-specific environment variables.

After the application starts, enter the corresponding Pod to verify whether the ENV has taken effect:

```shell
$ env | grep DD_
...
```

Once injected successfully, in the final Span data, we can see the Pod and Node names where the Span resides.

---

???+ attention

    - Do not modify the `endpoints` list here (unless you clearly understand the configuration logic and effects).

    ```toml
    endpoints = ["/v0.3/traces", "/v0.4/traces", "/v0.5/traces"]
    ```

    - If you want to disable sampling (i.e., collect all data), the sampling rate field needs to be set as follows:

    ``` toml
    # [inputs.ddtrace.sampler]
    # sampling_rate = 1.0
    ```

    Do not just comment out `sampling_rate = 1.0`; you must also comment out `[inputs.ddtrace.sampler]` together. Otherwise, the collector will think `sampling_rate` is set to 0.0, which would result in all data being discarded.

<!-- markdownlint-enable -->

### HTTP Settings {#http}

If Trace data is sent across machines, you need to configure [DataKit's HTTP settings](../datakit/datakit-conf.md#config-http-server).

If there is DDTrace data sent to Datakit, you will see it on [DataKit's monitor](../datakit/datakit-monitor.md):

<figure markdown>
  ![input-ddtrace-monitor](https://static.<<< custom_key.brand_main_domain >>>/images/datakit/input-ddtrace-monitor.png){ width="800" }
  <figcaption> DDtrace sends data to the /v0.4/traces interface</figcaption>
</figure>

### Enable Disk Cache {#disk-cache}

If the volume of Trace data is large, to avoid excessive resource consumption on the host, you can temporarily cache the Trace data to disk for delayed processing:

``` toml
[inputs.ddtrace.storage]
  path = "/path/to/ddtrace-disk-storage"
  capacity = 5120
```

### DDtrace SDK Configuration {#sdk}

After configuring the collector, you can also make some configurations on the DDtrace SDK side.

### Environment Variable Settings {#sdk-envs}

- `DD_TRACE_ENABLED`: Enable global tracer (supported by some language platforms)
- `DD_AGENT_HOST`: DDtrace agent host address
- `DD_TRACE_AGENT_PORT`: DDtrace agent host port
- `DD_SERVICE`: Service name
- `DD_TRACE_SAMPLE_RATE`: Set sampling rate
- `DD_VERSION`: Application version (optional)
- `DD_TRACE_STARTUP_LOGS`: DDtrace logger
- `DD_TRACE_DEBUG`: DDtrace debug mode
- `DD_ENV`: Application env values
- `DD_TAGS`: Application

In addition to setting the project name, environment name, and version number during application initialization, you can also set them in the following two ways:

- Inject environment variables via the command line

```shell
DD_TAGS="project:your_project_name,env=test,version=v1" ddtrace-run python app.py
```

- Directly configure custom tags in `_ddtrace.conf`. This method affects all data sent to the Datakit tracing service, so it should be carefully considered:

```toml
# tags is ddtrace configured key-value pairs
[inputs.ddtrace.tags]
  some_tag = "some_value"
  more_tag = "some_other_value"
```

## APMTelemetry {#apm_telemetry}

[:octicons-tag-24: Version-1.35.0](../datakit/changelog.md#cl-1.35.0) · [:octicons-beaker-24: Experimental](../datakit/index.md#experimental)

After the DDTrace probe starts, it continuously reports relevant service information through additional interfaces, such as startup configuration, heartbeat, loaded probes list, etc. This can be viewed in the Resource Catalog under Infrastructure in <<< custom_key.brand_name >>>. The displayed data helps diagnose issues with startup commands and referenced third-party library versions. It also includes host information, service information, and the number of Spans generated.

The data may vary significantly depending on the language and version, so take the actual received data as the standard.




### `DdTrace APM Telemetry`

Collect service, host, process APM telemetry messages.

- Tags (String type)


| Tag | Description |
|  ----  | --------|
|`architecture`|Architecture|
|`env`|Service ENV|
|`hostname`|Host name|
|`kernel_name`|Kernel name|
|`kernel_release`|Kernel release|
|`kernel_version`|Kernel version|
|`language_name`|Language name|
|`language_version`|Language version|
|`name`|same as service name|
|`os`|os|
|`os_version`|os version|
|`runtime_id`|RuntimeID|
|`runtime_name`|Runtime name|
|`runtime_patches`|Runtime patches|
|`runtime_version`|Runtime_version|
|`service`|Service|
|`service_version`|Service version|
|`tracer_version`|DdTrace version|

- Metrics List (Non-String types, or long String types)


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`app-client-configuration-change`|App client configuration change config|string|-|
|`app-closing`|App close|string|-|
|`app-dependencies-loaded`|App dependencies loaded|string|-|
|`app-integrations-change`|App Integrations change|string|-|
|`app-product-change`|App product change|string|-|
|`app-started`|App Started config|string|-|
|`spans_created`|Create span count|float|count|
|`spans_finished`|Finish span count|float|count|




### Fixed Extracted Tags {#add-tags}

Starting from DataKit version [1.21.0](../datakit/changelog.md#cl-1.21.0), the blacklist feature is deprecated, and not all fields from Span.Mate are promoted to top-level tags anymore; instead, selective extraction is performed.

Below is a list of potentially extracted tags:

| Original Meta Field      | Extracted Field Name    | Description              |
| :------------------ | :------------------ | :---------------  |
| `http.url`          | `http_url`          | Full HTTP request path |
| `http.hostname`     | `http_hostname`     | Hostname          |
| `http.route`        | `http_route`        | Route             |
| `http.status_code`  | `http_status_code`  | Status code       |
| `http.method`       | `http_method`       | Request method    |
| `http.client_ip`    | `http_client_ip`    | Client IP         |
| `sampling.priority` | `sampling_priority` | Sampling          |
| `span.kind`         | `span_kind`         | Span type         |
| `error`             | `error`             | Is error          |
| `dd.version`        | `dd_version`        | Agent version     |
| `error.message`     | `error_message`     | Error message     |
| `error.stack`       | `error_stack`       | Stack information |
| `error.type`        | `error_type`        | Error type        |
| `system.pid`        | `pid`               | PID               |
| `error.msg`         | `error_message`     | Error message     |
| `project`           | `project`           | Project           |
| `version`           | `version`           | Version           |
| `env`               | `env`               | Environment       |
| `host`              | `host`              | Hostname in tag   |
| `pod_name`          | `pod_name`          | Pod name in tag   |
| `_dd.base_service`  | `_dd_base_service`  | Parent service    |

In the link interface of <<< custom_key.brand_name >>>, tags not listed here can still be filtered.

Starting from DataKit version [1.22.0](../datakit/changelog.md#cl-1.22.0), the whitelist feature is restored. If there are tags that must be promoted to top-level tags, they can be configured in `customer_tags`.
If the whitelisted tags are from the native `message.meta`, `.` will be used as a separator, and the collector will convert `.` to `_`.

## Link Field Explanation {#tracing}





### `ddtrace`



- Tags (String type)


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

- Metrics List (Non-String types, or long String types)


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`duration`|Duration of span|int|μs|
|`message`|Origin content of span|string|-|
|`parent_id`|Parent span ID of current span|string|-|
|`resource`|Resource name produce current span|string|-|
|`span_id`|Span id|string|-|
|`start`|Start time of span.|int|usec|
|`trace_id`|Trace id|string|-|








## Further Reading {#more-reading}

- [DataKit Tracing Fields Definition](datakit-tracing-struct.md)
- [DataKit General Tracing Data Collection Instructions](datakit-tracing.md)
- [Correct Use of Regular Expressions for Configuration](../datakit/datakit-input-conf.md#debug-regex)
- [Multi-link Chaining](tracing-propagator.md)
- [Java Access and Exception Notes](ddtrace-java.md)