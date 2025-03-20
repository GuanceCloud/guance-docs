---
title     : 'Pinpoint'
summary   : 'Pinpoint Tracing data access'
tags      :
  - 'PINPOINT'
  - 'APM'
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

Datakit's built-in Pinpoint Agent is used to receive, compute, and analyze Pinpoint Tracing protocol data.

## Configuration {#config}

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "HOST Installation"

    Navigate to the `conf.d/pinpoint` directory under the DataKit installation directory, copy `pinpoint.conf.sample`, and rename it to `pinpoint.conf`. An example is as follows:

    ```toml
        
    [[inputs.pinpoint]]
      ## Pinpoint service endpoint for
      ## - Span Server
      ## - Agent Server(unimplemented, for service intactness and compatibility)
      ## - Metadata Server(unimplemented, for service intactness and compatibility)
      ## - Profiler Server(unimplemented, for service intactness and compatibility)
      address = "127.0.0.1:9991"
    
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
      # [inputs.pinpoint.close_resource]
        # service1 = ["resource1", "resource2", ...]
        # service2 = ["resource1", "resource2", ...]
        # "*" = ["close_resource_under_all_services"]
        # ...
    
      ## Sampler config uses to set global sampling strategy.
      ## sampling_rate used to set global sampling rate.
      # [inputs.pinpoint.sampler]
        # sampling_rate = 1.0
    
      # [inputs.pinpoint.tags]
        # key1 = "value1"
        # key2 = "value2"
        # ...
    
      ## Storage config a local storage space in hard dirver to cache trace data.
      ## path is the local file path used to cache data.
      ## capacity is total space size(MB) used to store data.
      # [inputs.pinpoint.storage]
        # path = "./pinpoint_storage"
        # capacity = 5120
    
    ```

    The listening address configuration item for the Datakit Pinpoint Agent is:

    ```toml
    # Pinpoint GRPC service endpoint for
    # - Span Server
    # - Agent Server(unimplemented, for service intactness and compatibility)
    # - Metadata Server(unimplemented, for service intactness and compatibility)
    # - Profiler Server(unimplemented, for service intactness and compatibility)
    address = "127.0.0.1:9991"
    ```

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can enable the collector by injecting the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting) or by [setting ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting).

    It also supports modifying configuration parameters via environment variables (you need to add it as the default collector in ENV_DEFAULT_ENABLED_INPUTS):

    - **ENV_INPUT_PINPOINT_ADDRESS**
    
        Proxy URL
    
        **Field Type**: String
    
        **Collector Configuration Field**: `address`
    
        **Example**: 127.0.0.1:9991
    
    - **ENV_INPUT_PINPOINT_KEEP_RARE_RESOURCE**
    
        Maintain a list of rare tracing resources
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `keep_rare_resource`
    
        **Default Value**: false
    
    - **ENV_INPUT_PINPOINT_DEL_MESSAGE**
    
        Delete trace messages
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `del_message`
    
        **Default Value**: false
    
    - **ENV_INPUT_PINPOINT_CLOSE_RESOURCE**
    
        Ignore specified server tracing (regex match)
    
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
    
        Custom tags. If the configuration file has tags with the same name, they will override them.
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `tags`
    
        **Example**: {"k1":"v1", "k2":"v2", "k3":"v3"}                             |

???+ warning "The following limitations exist for the Pinpoint Agent in Datakit"

    - Currently only supports gRPC protocol
    - Multiple services (Agent/Metadata/Stat/Span) use the same port
    - Differences exist between Pinpoint traces and Datakit traces, see [below](pinpoint.md#opentracing-vs-pinpoint)

<!-- markdownlint-enable -->

### Pinpoint Agent Configuration {#agent-config}

- Download the required Pinpoint APM Agent

Pinpoint supports multi-language APM Collectors. This document uses JAVA Agent for configuration. [Download](https://github.com/pinpoint-apm/pinpoint/releases){:target="_blank"} JAVA APM Collector.

- Configure the Pinpoint APM Collector, open */path_to_pinpoint_agent/pinpoint-root.config* and configure the corresponding multi-service ports.

    - Configure `profiler.transport.module = GRPC`
    - Configure `profiler.transport.grpc.agent.collector.port = 9991`   (i.e., the port configured in the Datakit Pinpoint Agent)
    - Configure `profiler.transport.grpc.metadata.collector.port = 9991` (i.e., the port configured in the Datakit Pinpoint Agent)
    - Configure `profiler.transport.grpc.stat.collector.port = 9991`    (i.e., the port configured in the Datakit Pinpoint Agent)
    - Configure `profiler.transport.grpc.span.collector.port = 9991`    (i.e., the port configured in the Datakit Pinpoint Agent)

- Start the Pinpoint APM Agent with the following command

```shell
$ java -javaagent:/path_to_pinpoint/pinpoint-bootstrap.jar \
    -Dpinpoint.agentId=agent-id \
    -Dpinpoint.applicationName=app-name \
    -Dpinpoint.config=/path_to_pinpoint/pinpoint-root.config \
    -jar /path_to_your_app.jar
```

Datakit trace data adheres to the OpenTracing protocol. In Datakit, a single trace is linked through a simple parent-child structure (the child span stores the id of the parent span), and each span corresponds to a function call.

<figure markdown>
  ![OpenTracing](https://static.guance.com/images/datakit/datakit-opentracing.png){ width="600" }
  <figcaption>OpenTracing</figcaption>
</figure>

Pinpoint APM trace data is more complex:

- The parent span is responsible for generating the ID of the child span.
- The child span also stores the ID of the parent span.
- Span events replace spans in OpenTracing.
- A span represents a single response process of a service.

<figure markdown>
  ![Pinpoint](https://static.guance.com/images/datakit/datakit-pinpoint.png){ width="600" }
  <figcaption>Pinpoint</figcaption>
</figure>

### PinPointV2 {#pinpointv2}

`DataKit 1.19.0` version reoptimized and changed `source` to `PinPointV2`. The new version reorganizes the relationship between `SpanChunk` and `Span`, the relationship between `Event` and `Span`, the relationship between `Span` and `Span`, 
and resolves the time alignment issue of `startElapsed` and `endElapsed` in `Event`.

Main logical points:

- Cache the `serviceType` service table and write it to a file to prevent data loss after DataKit restarts.
- If `parentSpanId` in `Span` is not -1, then cache it. If `parentSpanId:-1`, retrieve the `Span` from the cache based on the `nextSpanId` in `spanEvent` and append it to a trace.
- Cache all `event`s in `SpanChunk`, and retrieve them all from the cache when the main `Span` is received, appending them to the trace.
- Accumulate the current `Event`'s `startElapsed` sequentially as the start time of the next `Event`.
- Determine the parent-child relationship of the current `Event` according to the `Depth` field.
- Replace the `sql` statement with the current 'resource' name when encountering database queries.

## Trace Fields {#tracing}





### `pinpoint`



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
|`GcNewCount`|Jvm Gc NewCount|int|count|
|`GcNewTime`|Jvm Gc NewTime|int|msec|
|`JvmCpuLoad`|Jvm CPU load|int|percent|
|`JvmGcOldCount`|Jvm Gc Old Count|int|count|
|`JvmGcOldTime`|Jvm Gc Old Time|int|msec|
|`JvmMemoryHeapMax`|Jvm Memory Heap Max|int|B|
|`JvmMemoryHeapUsed`|Jvm Memory Heap Used|int|B|
|`JvmMemoryNonHeapMax`|Jvm Memory NonHeap Max|int|B|
|`JvmMemoryNonHeapUsed`|Jvm Memory NonHeap Used|int|B|
|`PoolCodeCacheUsed`|Jvm Pool Code Cache Used|float|B|
|`PoolMetaspaceUsed`|Jvm Pool meta space used|float|count|
|`PoolNewGenUsed`|Jvm Pool New GenUsed|float|B|
|`PoolOldGenUsed`|Duration of Jvm garbage collection actions|float|B|
|`PoolPermGenUsed`|The maximum file descriptor count|float|count|
|`PoolSurvivorSpaceUsed`|Jvm Pool Survivor SpaceUsed|float|B|
|`SystemCpuLoad`|system CPU load|int|percent|




## Pinpoint Reference Materials {#references}

- [Pinpoint Official Documentation](https://pinpoint-apm.gitbook.io/pinpoint/){:target="_blank"}
- [Pinpoint Version Document Library](https://pinpoint-apm.github.io/pinpoint/index.html){:target="_blank"}
- [Pinpoint Official Repository](https://github.com/pinpoint-apm){:target="_blank"}
- [Pinpoint Online Instance](http://125.209.240.10:10123/main){:target="_blank"}