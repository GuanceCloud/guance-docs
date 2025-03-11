---
title     : 'Pinpoint'
summary   : 'Pinpoint Tracing Data Ingestion'
tags      :
  - 'PINPOINT'
  - 'Trace Analysis'
__int_icon: 'icon/pinpoint'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

[:octicons-tag-24: Version-1.6.0](../datakit/changelog.md#cl-1.6.0) · [:octicons-beaker-24: Experimental](../datakit/index.md#experimental)

---

The built-in Pinpoint Agent in DataKit is used to receive, process, and analyze data from the Pinpoint Tracing protocol.

## Configuration {#config}

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/pinpoint` directory under the DataKit installation directory, copy `pinpoint.conf.sample`, and rename it to `pinpoint.conf`. An example is as follows:

    ```toml
        
    [[inputs.pinpoint]]
      ## Pinpoint service endpoint for
      ## - Span Server
      ## - Agent Server (unimplemented, for service integrity and compatibility)
      ## - Metadata Server (unimplemented, for service integrity and compatibility)
      ## - Profiler Server (unimplemented, for service integrity and compatibility)
      address = "127.0.0.1:9991"
    
      ## Keep rare tracing resources list switch.
      ## If some resources are rare enough (not present in 1 hour), those resources will always be sent
      ## to the data center and not consider samplers and filters.
      # keep_rare_resource = false
    
      ## Delete trace message
      # del_message = true
    
      ## Ignore tracing resources map like service:[resources...].
      ## The service name is the full service name in the current application.
      ## The resource list is regular expressions used to block resource names.
      ## If you want to block some resources universally under all services, you can set the
      ## service name as "*". Note: double quotes "" cannot be omitted.
      # [inputs.pinpoint.close_resource]
        # service1 = ["resource1", "resource2", ...]
        # service2 = ["resource1", "resource2", ...]
        # "*" = ["close_resource_under_all_services"]
        # ...
    
      ## Sampler config used to set global sampling strategy.
      ## sampling_rate used to set global sampling rate.
      # [inputs.pinpoint.sampler]
        # sampling_rate = 1.0
    
      # [inputs.pinpoint.tags]
        # key1 = "value1"
        # key2 = "value2"
        # ...
    
      ## Storage config a local storage space on the hard drive to cache trace data.
      ## path is the local file path used to cache data.
      ## capacity is total space size (MB) used to store data.
      # [inputs.pinpoint.storage]
        # path = "./pinpoint_storage"
        # capacity = 5120
    
    ```

    The listening address configuration item for the DataKit Pinpoint Agent is:

    ```toml
    # Pinpoint GRPC service endpoint for
    # - Span Server
    # - Agent Server (unimplemented, for service integrity and compatibility)
    # - Metadata Server (unimplemented, for service integrity and compatibility)
    # - Profiler Server (unimplemented, for service integrity and compatibility)
    address = "127.0.0.1:9991"
    ```

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can inject the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting) or enable the collector by [setting ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting).

    It also supports modifying configuration parameters via environment variables (you need to add it to the default collectors in ENV_DEFAULT_ENABLED_INPUTS):

    - **ENV_INPUT_PINPOINT_ADDRESS**
    
        Proxy URL
    
        **Field Type**: String
    
        **Collector Configuration Field**: `address`
    
        **Example**: 127.0.0.1:9991
    
    - **ENV_INPUT_PINPOINT_KEEP_RARE_RESOURCE**
    
        Keep rare tracing resources list
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `keep_rare_resource`
    
        **Default Value**: false
    
    - **ENV_INPUT_PINPOINT_DEL_MESSAGE**
    
        Delete trace messages
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `del_message`
    
        **Default Value**: false
    
    - **ENV_INPUT_PINPOINT_CLOSE_RESOURCE**
    
        Ignore specified server's tracing (regex match)
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `close_resource`
    
        **Example**: {"service1":["resource1","other"],"service2":["resource2","other"]}
    
    - **ENV_INPUT_PINPOINT_SAMPLER**
    
        Global sampling rate
    
        **Field Type**: Float
    
        **Collector Configuration Field**: `sampler`
    
        **Example**: 0.3
    
    - **ENV_INPUT_PINPOINT_STORAGE**
    
        Local cache path and size (MB)
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `storage`
    
        **Example**: {"storage":"./pinpoint_storage", "capacity": 5120}
    
    - **ENV_INPUT_PINPOINT_TAGS**
    
        Custom tags. If there are same-name tags in the configuration file, they will overwrite them
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `tags`
    
        **Example**: {"k1":"v1", "k2":"v2", "k3":"v3"}

???+ warning "The Pinpoint Agent in DataKit has the following limitations"

    - Currently only supports gRPC protocol
    - Multiple services (Agent/Metadata/Stat/Span) use the same port
    - Differences exist between Pinpoint traces and DataKit traces, see [below](pinpoint.md#opentracing-vs-pinpoint)

<!-- markdownlint-enable -->

### Pinpoint Agent Configuration {#agent-config}

- Download the required Pinpoint APM Agent

Pinpoint supports multi-language APM Collectors; this document uses the JAVA Agent for configuration. [Download](https://github.com/pinpoint-apm/pinpoint/releases){:target="_blank"} the JAVA APM Collector.

- Configure the Pinpoint APM Collector, open */path_to_pinpoint_agent/pinpoint-root.config* and configure the corresponding multi-service ports

    - Set `profiler.transport.module = GRPC`
    - Set `profiler.transport.grpc.agent.collector.port = 9991` (the port configured in the DataKit Pinpoint Agent)
    - Set `profiler.transport.grpc.metadata.collector.port = 9991` (the port configured in the DataKit Pinpoint Agent)
    - Set `profiler.transport.grpc.stat.collector.port = 9991` (the port configured in the DataKit Pinpoint Agent)
    - Set `profiler.transport.grpc.span.collector.port = 9991` (the port configured in the DataKit Pinpoint Agent)

- Start the Pinpoint APM Agent with the following command

```shell
$ java -javaagent:/path_to_pinpoint/pinpoint-bootstrap.jar \
    -Dpinpoint.agentId=agent-id \
    -Dpinpoint.applicationName=app-name \
    -Dpinpoint.config=/path_to_pinpoint/pinpoint-root.config \
    -jar /path_to_your_app.jar
```

DataKit trace data follows the OpenTracing protocol, where a trace in DataKit is linked through a simple parent-child structure (child spans store the ID of their parent span) and each span corresponds to a function call.

<figure markdown>
  ![OpenTracing](https://static.guance.com/images/datakit/datakit-opentracing.png){ width="600" }
  <figcaption>OpenTracing</figcaption>
</figure>

Pinpoint APM trace data is more complex:

- Parent spans generate child span IDs
- Child spans also store the parent span ID
- Use span events instead of spans in OpenTracing
- A span represents one response process of a service

<figure markdown>
  ![Pinpoint](https://static.guance.com/images/datakit/datakit-pinpoint.png){ width="600" }
  <figcaption>Pinpoint</figcaption>
</figure>

### PinPointV2 {#pinpointv2}

In version `DataKit 1.19.0`, after optimization, the `source` was changed to `PinPointV2`. The new version reorganizes the relationships between `SpanChunk` and `Span`, `Event` and `Span`, and `Span` with `Span`, as well as aligns the `startElapsed` and `endElapsed` times in `Event`.

Key points:

- Cache the `serviceType` service table and write it to a file to prevent data loss upon DataKit restart.
- If `parentSpanId` in `Span` is not `-1`, cache it. If `parentSpanId` is `-1`, retrieve the `Span` from the cache using the `nextSpanId` in `spanEvent` and concatenate it into a single trace.
- Cache all `events` in `SpanChunk` until receiving the main `Span`, then retrieve all cached items and append them to the trace.
- Incrementally sum the `startElapsed` time of the current `Event` as the start time for the next `Event`.
- Determine the parent-child relationship of the current `Event` based on the `Depth` field.
- For database queries, replace the SQL statement with the current 'resource' name.

## Trace Fields {#tracing}





### `pinpoint`



- Tags


| Tag | Description |
|  ----  | --------|
|`container_host`|Container hostname. Available in OpenTelemetry. Optional.|
|`dk_fingerprint`|DataKit fingerprint is the DataKit hostname|
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

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`duration`|Duration of span|int|μs|
|`message`|Original content of span|string|-|
|`parent_id`|Parent span ID of current span|string|-|
|`resource`|Resource name producing current span|string|-|
|`span_id`|Span ID|string|-|
|`start`|Start time of span.|int|usec|
|`trace_id`|Trace ID|string|-|








## Metrics Fields {#metrics}









### `pinpoint-metric`



- Tags


| Tag | Description |
|  ----  | --------|
|`agentVersion`|Pinpoint agent version|
|`agent_id`|Agent ID|
|`container`|Whether it is a container|
|`hostname`|Host name|
|`ip`|Agent IP|
|`pid`|Process ID|
|`ports`|Open ports|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`GcNewCount`|JVM GC NewCount|int|count|
|`GcNewTime`|JVM GC NewTime|int|msec|
|`JvmCpuLoad`|JVM CPU load|int|percent|
|`JvmGcOldCount`|JVM GC Old Count|int|count|
|`JvmGcOldTime`|JVM GC Old Time|int|msec|
|`JvmMemoryHeapMax`|JVM Memory Heap Max|int|B|
|`JvmMemoryHeapUsed`|JVM Memory Heap Used|int|B|
|`JvmMemoryNonHeapMax`|JVM Memory NonHeap Max|int|B|
|`JvmMemoryNonHeapUsed`|JVM Memory NonHeap Used|int|B|
|`PoolCodeCacheUsed`|JVM Pool Code Cache Used|float|B|
|`PoolMetaspaceUsed`|JVM Pool meta space used|float|count|
|`PoolNewGenUsed`|JVM Pool New Gen Used|float|B|
|`PoolOldGenUsed`|Duration of JVM garbage collection actions|float|B|
|`PoolPermGenUsed`|The maximum file descriptor count|float|count|
|`PoolSurvivorSpaceUsed`|JVM Pool Survivor Space Used|float|B|
|`SystemCpuLoad`|System CPU load|int|percent|




## Pinpoint References {#references}

- [Pinpoint Official Documentation](https://pinpoint-apm.gitbook.io/pinpoint/){:target="_blank"}
- [Pinpoint Version Document Library](https://pinpoint-apm.github.io/pinpoint/index.html){:target="_blank"}
- [Pinpoint Official Repository](https://github.com/pinpoint-apm){:target="_blank"}
- [Pinpoint Online Instance](http://125.209.240.10:10123/main){:target="_blank"}
