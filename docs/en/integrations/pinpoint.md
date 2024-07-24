---
title     : 'Pinpoint'
summary   : 'Receive Pinpoint Tracing data'
__int_icon      : 'icon/pinpoint'
dashboard :
  - desc  : 'N/A'
    path  : '-'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Pinpoint
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

[:octicons-tag-24: Version-1.6.0](../datakit/changelog.md#cl-1.6.0) · [:octicons-beaker-24: Experimental](../datakit/index.md#experimental)

---

The built-in Pinpoint Agent in Datakit is used to receive, calculate, and analyze Pinpoint Tracing protocol data.

## Configuration {#config}

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host installation"

    Enter the `conf.d/pinpoint` directory under the DataKit installation directory, copy `pinpoint.conf.sample` and name it `pinpoint.conf`. Examples are as follows:

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

    Datakit Pinpoint Agent listening address configuration items are:

    ```toml
    # Pinpoint GRPC service endpoint for
    # - Span Server
    # - Agent Server(unimplemented, for service intactness and compatibility)
    # - Metadata Server(unimplemented, for service intactness and compatibility)
    # - Profiler Server(unimplemented, for service intactness and compatibility)
    address = "127.0.0.1:9991"
    ```

    After configuration, [Restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Can be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [Config ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) .

    Can also be turned on by environment variables, (needs to be added as the default collector in ENV_DEFAULT_ENABLED_INPUTS):
    
    - **ENV_INPUT_PINPOINT_ADDRESS**
    
        Agent span server
    
        **Type**: String
    
        **input.conf**: `address`
    
        **Example**: 127.0.0.1:9991
    
    - **ENV_INPUT_PINPOINT_KEEP_RARE_RESOURCE**
    
        Keep rare tracing resources list switch
    
        **Type**: Boolean
    
        **input.conf**: `keep_rare_resource`
    
        **Default**: false
    
    - **ENV_INPUT_PINPOINT_DEL_MESSAGE**
    
        Delete trace message
    
        **Type**: Boolean
    
        **input.conf**: `del_message`
    
        **Default**: false
    
    - **ENV_INPUT_PINPOINT_CLOSE_RESOURCE**
    
        Ignore tracing resources that service (regular)
    
        **Type**: JSON
    
        **input.conf**: `close_resource`
    
        **Example**: {"service1":["resource1","other"],"service2":["resource2","other"]}
    
    - **ENV_INPUT_PINPOINT_SAMPLER**
    
        Global sampling rate
    
        **Type**: Float
    
        **input.conf**: `sampler`
    
        **Example**: 0.3
    
    - **ENV_INPUT_PINPOINT_STORAGE**
    
        Local cache file path and size (MB) 
    
        **Type**: JSON
    
        **input.conf**: `storage`
    
        **Example**: {"storage":"./pinpoint_storage", "capacity": 5120}
    
    - **ENV_INPUT_PINPOINT_TAGS**
    
        Customize tags. If there is a tag with the same name in the configuration file, it will be overwritten
    
        **Type**: JSON
    
        **input.conf**: `tags`
    
        **Example**: {"k1":"v1", "k2":"v2", "k3":"v3"}

???+ warning "The Pinpoint Agent in Datakit has the following limitations"

    - Currently only supports gRPC protocol
    - Multiple services (Agent/Metadata/Stat/Span) combined into one service use the same port
    - There are differences between Pinpoint links and Datakit links, see [below](pinpoint.md#opentracing-vs-pinpoint) for details

<!-- markdownlint-enable -->

### Pinpoint Agent configuration {#agent-config}

- Download the required Pinpoint APM Agent

Pinpoint supports the multi-language APM Collector. This document uses JAVA Agent for configuration. [Download](https://github.com/pinpoint-apm/pinpoint/releases){:target="_blank"} JAVA APM Collector.

- Configure Pinpoint APM Collector, open */path_to_pinpoint_agent/pinpoint-root.config* and configure the corresponding multi-service ports

    - Configure `profiler.transport.module = GRPC`
    - Configure `profiler.transport.grpc.agent.collector.port = 9991`   (i.e. the port configured in Datakit Pinpoint Agent)
    - Configure `profiler.transport.grpc.metadata.collector.port = 9991`(i.e. the port configured in Datakit Pinpoint Agent)
    - Configure `profiler.transport.grpc.stat.collector.port = 9991`    (i.e. the port configured in Datakit Pinpoint Agent)
    - Configure `profiler.transport.grpc.span.collector.port = 9991`    (i.e. the port configured in Datakit Pinpoint Agent)

- Start Pinpoint APM Agent startup command

```shell
$ java -javaagent:/path_to_pinpoint/pinpoint-bootstrap.jar \
    -Dpinpoint.agentId=agent-id \
    -Dpinpoint.applicationName=app-name \
    -Dpinpoint.config=/path_to_pinpoint/pinpoint-root.config \
    -jar /path_to_your_app.jar
```

Datakit link data follows the OpenTracing protocol. A link in Datakit is concatenated through a simple parent-child (the child span stores the id of the parent span) structure and each span corresponds to a function call.

<figure markdown>
  ![OpenTracing](https://static.guance.com/images/datakit/datakit-opentracing.png){ width="600" }
  <figcaption>OpenTracing</figcaption>
</figure>

Pinpoint APM link data is more complex:

- The parent span is responsible for generating the ID of the child span
- The ID of the parent span must also be stored in the child span.
- Use span event instead of span in OpenTracing
- A span is a response process for a service

<figure markdown>
  ![Pinpoint](https://static.guance.com/images/datakit/datakit-pinpoint.png){ width="600" }
  <figcaption>Pinpoint</figcaption>
</figure>

### PinPointV2 {#pinpointv2}

`DataKit 1.19.0` version has been re-optimized and changed `source` to `PinPointV2`. The new version of link data reorganizes the relationship between `SpanChunk` and `Span`, the relationship between `Event` and `Span`, and the relationship between `Span` and `Span`.
And the time alignment problem between `startElapsed` and `endElapsed` in `Event`.

Main logical points:

- Cache the `serviceType` service table and write it to a file to prevent data loss when DataKit restarts.
- Cache if `parentSpanId` in `Span` is not -1. For example, if `parentSpanId:-1` is used, the `Span` will be fetched from the cache and spliced into a link based on the `nextSpanId` in `spanEvent`.
- Cache all `event` in `SpanChunk`, until the main `Span` is received, all are taken out from the cache and appended to the link.
- Accumulate `startElapsed` in the current `Event` in order as the start time of the next `Event`.
- Determine the parent-child relationship of the current `Event` according to the `Depth` field.
- Database queries will replace the current 'resource' name with `sql` statements.

## Tracing {#tracing}





### `pinpoint`



- tags


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

- fields


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`duration`|Duration of span|int|μs|
|`message`|Origin content of span|string|-|
|`parent_id`|Parent span ID of current span|string|-|
|`resource`|Resource name produce current span|string|-|
|`span_id`|Span id|string|-|
|`start`|start time of span.|int|usec|
|`trace_id`|Trace id|string|-|








## Metric {#metrics}









### `pinpoint-metric`



- tags


| Tag | Description |
|  ----  | --------|
|`agentVersion`|Pinpoint agent version|
|`agent_id`|Agent ID|
|`container`|Whether it is a container|
|`hostname`|Host name|
|`ip`|Agent IP|
|`pid`|Process ID|
|`ports`|Open ports|

- fields


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




## Pinpoint References {#references}

- [Pinpoint official documentation](https://pinpoint-apm.gitbook.io/pinpoint/){:target="_blank"}
- [Pinpoint version documentation library](https://pinpoint-apm.github.io/pinpoint/index.html){:target="_blank"}
- [Pinpoint official repository](https://github.com/pinpoint-apm){:target="_blank"}
- [Pinpoint online example](http://125.209.240.10:10123/main){:target="_blank"}
