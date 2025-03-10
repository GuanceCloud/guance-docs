---
title: 'DDTrace'
summary: 'Receive APM data from DDTrace'
__int_icon: 'icon/ddtrace'
tags:
  - 'DDTRACE'
  - 'Trace Collection'
dashboard:
  - desc: 'None'
    path: '-'
monitor:
  - desc: 'None'
    path: '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

DDTrace is an open-source APM product by DataDog. The DDTrace Agent embedded in DataKit receives, processes, and analyzes data following the DataDog Tracing protocol.

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

    [SDK :material-download:](https://static.guance.com/dd-image/dd-java-agent.jar){:target="_blank"} ·
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
    [:octicons-book-16: Documentation](https://docs.datadoghq.com/tracing/trace_collection/automatic_instrumentation/dd_libraries/dotnet-framework?tab=windows){:target="_blank"} ·
    [:octicons-book-16: .Net Core Documentation](https://docs.datadoghq.com/tracing/trace_collection/automatic_instrumentation/dd_libraries/dotnet-core?tab=windows){:target="_blank"}
</div>

???+ tip

    We have made some [feature extensions](ddtrace-ext-changelog.md) to DDTrace to support more mainstream frameworks and finer-grained data tracing.

## Configuration {#config}

=== "Host Installation"

    Navigate to the `conf.d/ddtrace` directory under the DataKit installation directory, copy `ddtrace.conf.sample`, and rename it to `ddtrace.conf`. An example configuration is as follows:

    ```toml
        
    [[inputs.ddtrace]]
      ## DDTrace Agent endpoints register by version respectively.
      ## Endpoints can be skipped listen by remove them from the list.
      ## NOTE: DO NOT EDIT.
      endpoints = ["/v0.3/traces", "/v0.4/traces", "/v0.5/traces"]
    
      ## customer_tags will work as a whitelist to prevent tags send to data center.
      ## All . will replace to _, like this :
      ## "project.name" to send to Guance center is "project_name"
      # customer_tags = ["sink_project", "custom_dd_tag"]
    
      ## Keep rare tracing resources list switch.
      ## If some resources are rare enough (not present in 1 hour), those resource will always send
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

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can inject collector configurations via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [configure ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) to enable the collector.

    Environment variables can also be used to modify configuration parameters (you need to add it to the default collectors in ENV_DEFAULT_ENABLED_INPUTS):

    - **ENV_INPUT_DDTRACE_ENDPOINTS**
    
        Agent endpoints
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `endpoints`
    
        **Example**: ["/v0.3/traces", "/v0.4/traces", "/v0.5/traces"]
    
    - **ENV_INPUT_DDTRACE_CUSTOMER_TAGS**
    
        Tag whitelist
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `customer_tags`
    
        **Example**: `["sink_project", "custom_dd_tag"]`
    
    - **ENV_INPUT_DDTRACE_KEEP_RARE_RESOURCE**
    
        Keep rare trace resources list
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `keep_rare_resource`
    
        **Default Value**: false
    
    - **ENV_INPUT_DDTRACE_COMPATIBLE_OTEL**
    
        Compatible OTEL Trace with DDTrace Trace
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `compatible_otel`
    
        **Default Value**: false
    
    - **ENV_INPUT_DDTRACE_TRACE_ID_64_BIT_HEX**
    
        Compatible B3/B3Multi TraceID with DDTrace
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `trace_id_64_bit_hex`
    
        **Default Value**: false
    
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
    
        Ignore specified server's tracing (regex match)
    
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
    
        Custom tags. If there are same-named tags in the configuration file, they will override them.
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `tags`
    
        **Example**: {"k1":"v1", "k2":"v2", "k3":"v3"}
    
    - **ENV_INPUT_DDTRACE_ENV_INPUT_DDTRACE_MAX_SPANS**
    
        Maximum number of spans per trace. If exceeded, extra spans will be truncated; set to -1 to disable this limit.
    
        **Field Type**: Int
    
        **Collector Configuration Field**: `env_input_ddtrace_max_spans`
    
        **Example**: 1000
    
        **Default Value**: 100000
    
    - **ENV_INPUT_DDTRACE_ENV_INPUT_DDTRACE_MAX_BODY_MB**
    
        Maximum API request body size per trace (in MiB); set to -1 to disable this limit.
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `env_input_ddtrace_max_body_mb`
    
        **Example**: 32
    
        **Default Value**: 10

### Multi-line Propagation Tool Considerations {#trace_propagator}

DDTrace currently supports propagation protocols: `datadog/b3multi/tracecontext`. Two cases need attention:

- When using `tracecontext`, since the trace ID is 128 bits, you need to enable the `compatible_otel=true` switch in the configuration.
- When using `b3multi`, pay attention to the length of the `trace_id`. If it is 64-bit hex encoded, you need to enable `trace_id_64_bit_hex=true` in the configuration file.
- For more information on propagation protocols and tool usage, see: [Multi-link Propagation](tracing-propagator.md){:target="_blank"}

### Inject Pod and Node Information {#add-pod-node-info}

When deploying applications in Kubernetes or other container environments, we can append Pod/Node information to the final Span data by modifying the application's Yaml. Below is an example of a Kubernetes Deployment yaml:

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

Note that `POD_NAME` and `NODE_NAME` must be defined first, then embedded into the DDTrace-specific environment variables.

After starting the application, enter the corresponding Pod to verify if the ENV variables are effective:

```shell
$ env | grep DD_
...
```

Once injected successfully, the final Span data will include the Pod and Node names where the Span resides.

---

???+ attention

    - Do not modify the `endpoints` list unless you clearly understand the configuration logic and effects.

    ```toml
    endpoints = ["/v0.3/traces", "/v0.4/traces", "/v0.5/traces"]
    ```

    - To disable sampling (i.e., collect all data), the sampling rate field should be set as follows:

    ``` toml
    # [inputs.ddtrace.sampler]
    # sampling_rate = 1.0
    ```

    Do not just comment out `sampling_rate = 1.0`; you must also comment out `[inputs.ddtrace.sampler]`, otherwise the collector will interpret `sampling_rate` as 0.0, causing all data to be discarded.

<!-- markdownlint-enable -->

### HTTP Settings {#http}

If Trace data is sent across machines, you need to configure [DataKit's HTTP settings](../datakit/datakit-conf.md#config-http-server).

If DDTrace data is sent to DataKit, you can see it in [DataKit's monitor](../datakit/datakit-monitor.md):

<figure markdown>
  ![input-ddtrace-monitor](https://static.guance.com/images/datakit/input-ddtrace-monitor.png){ width="800" }
  <figcaption> DDtrace sends data to the /v0.4/traces endpoint</figcaption>
</figure>

### Enable Disk Cache {#disk-cache}

If the volume of Trace data is large, to avoid consuming too much host resources, you can temporarily cache Trace data to disk for delayed processing:

``` toml
[inputs.ddtrace.storage]
  path = "/path/to/ddtrace-disk-storage"
  capacity = 5120
```

### DDtrace SDK Configuration {#sdk}

After configuring the collector, additional configurations can be made on the DDtrace SDK side.

### Environment Variable Settings {#sdk-envs}

- `DD_TRACE_ENABLED`: Enable global tracer (supported by some language platforms)
- `DD_AGENT_HOST`: DDtrace agent host address
- `DD_TRACE_AGENT_PORT`: DDtrace agent host port
- `DD_SERVICE`: Service name
- `DD_TRACE_SAMPLE_RATE`: Set sampling rate
- `DD_VERSION`: Application version (optional)
- `DD_TRACE_STARTUP_LOGS`: DDtrace logger
- `DD_TRACE_DEBUG`: DDtrace debug mode
- `DD_ENV`: Application environment values
- `DD_TAGS`: Application tags

In addition to setting project name, environment name, and version during application initialization, you can also set these through the following methods:

- Inject environment variables via command line

```shell
DD_TAGS="project:your_project_name,env=test,version=v1" ddtrace-run python app.py
```

- Configure custom tags directly in `_ddtrace.conf`. This affects all data sent to the DataKit tracing service and should be carefully considered:

```toml
# tags is ddtrace configured key-value pairs
[inputs.ddtrace.tags]
  some_tag = "some_value"
  more_tag = "some_other_value"
```

## APMTelemetry {#apm_telemetry}

[:octicons-tag-24: Version-1.35.0](../datakit/changelog.md#cl-1.35.0) · [:octicons-beaker-24: Experimental](../datakit/index.md#experimental)

After the DDTrace probe starts, it continuously reports service-related information through additional interfaces, such as startup configuration, heartbeat, loaded probes list, etc. This data can be viewed in Guance's Infrastructure -> Resource Catalog. The displayed data helps troubleshoot startup commands and third-party library version issues. It also includes host information, service information, and the number of generated Spans.

Different languages and versions may result in significant differences in the data. Refer to the actual received data.

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
|`name`|Same as service name|
|`os`|Operating system|
|`os_version`|Operating system version|
|`runtime_id`|Runtime ID|
|`runtime_name`|Runtime name|
|`runtime_patches`|Runtime patches|
|`runtime_version`|Runtime version|
|`service`|Service|
|`service_version`|Service version|
|`tracer_version`|DDTrace version|

- Metric List (Non-string type or long string type)


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`app-client-configuration-change`|App client configuration change config|string|-|
|`app-closing`|App close|string|-|
|`app-dependencies-loaded`|App dependencies loaded|string|-|
|`app-integrations-change`|App integrations change|string|-|
|`app-product-change`|App product change|string|-|
|`app-started`|App started config|string|-|
|`spans_created`|Created span count|float|count|
|`spans_finished`|Finished span count|float|count|



### Fixed Extraction of Tags {#add-tags}

Starting from DataKit version [1.21.0](../datakit/changelog.md#cl-1.21.0), the blacklist feature has been deprecated, and not all Span.Mate fields are promoted to top-level tags anymore but selectively extracted.

The following is a list of potentially extracted tags:

| Original Meta Field | Extracted Field Name | Description |
| :------------------ | :------------------ | :---------------  |
| `http.url`          | `http_url`          | Full HTTP request URL |
| `http.hostname`     | `http_hostname`     | Hostname          |
| `http.route`        | `http_route`        | Route             |
| `http.status_code`  | `http_status_code`  | Status code       |
| `http.method`       | `http_method`       | Request method    |
| `http.client_ip`    | `http_client_ip`    | Client IP         |
| `sampling.priority` | `sampling_priority` | Sampling priority |
| `span.kind`         | `span_kind`         | Span type         |
| `error`             | `error`             | Error flag        |
| `dd.version`        | `dd_version`        | Agent version     |
| `error.message`     | `error_message`     | Error message     |
| `error.stack`       | `error_stack`       | Stack trace       |
| `error.type`        | `error_type`        | Error type        |
| `system.pid`        | `pid`               | PID               |
| `error.msg`         | `error_message`     | Error message     |
| `project`           | `project`           | Project           |
| `version`           | `version`           | Version           |
| `env`               | `env`               | Environment       |
| `host`              | `host`              | Hostname in tag   |
| `pod_name`          | `pod_name`          | Pod name in tag   |
| `_dd.base_service`  | `_dd_base_service`  | Parent service    |

In the Tracing interface of Guance, tags not listed here can still be filtered.

Starting from DataKit version [1.22.0](../datakit/changelog.md#cl-1.22.0), the whitelist feature has been restored. If certain tags must be extracted to the top-level list, they can be configured in `customer_tags`. If the configured whitelist tags are in the original `message.meta`, the `.` separator will be replaced with `_`.

## Trace Field Explanation {#tracing}





### `ddtrace`



- Tags (String type)


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

- Metrics (Non-string type or long string type)


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`duration`|Duration of span|int|μs|
|`message`|Origin content of span|string|-|
|`parent_id`|Parent span ID of current span|string|-|
|`resource`|Resource name producing current span|string|-|
|`span_id`|Span id|string|-|
|`start`|Start time of span|int|usec|
|`trace_id`|Trace id|string|-|


## Further Reading {#more-reading}

- [DataKit Tracing Field Definitions](datakit-tracing-struct.md)
- [General Tracing Data Collection Instructions for DataKit](datakit-tracing.md)
- [Correctly Using Regular Expressions for Configuration](../datakit/datakit-input-conf.md#debug-regex)
- [Multi-link Propagation](tracing-propagator.md)
- [Java Integration and Exception Handling](ddtrace-java.md)