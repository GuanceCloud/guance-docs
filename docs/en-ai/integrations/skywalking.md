---
title: 'SkyWalking'
summary: 'SkyWalking Tracing Data Ingestion'
tags:
  - 'Tracing'
  - 'SKYWALKING'
__int_icon: 'icon/skywalking'
dashboard:
  - desc: 'Skywalking JVM Monitoring View'
    path: 'dashboard/en/skywalking'
monitor:
  - desc: 'Not available'
    path: '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The embedded SkyWalking Agent in Datakit is used to receive, compute, and analyze data from the SkyWalking Tracing protocol.

## Configuration {#config}

### SkyWalking Client Configuration {#client-config}

Open the file */path_to_skywalking_agent/config/agent.config* for configuration

```conf
# The service name in UI
agent.service_name=${SW_AGENT_NAME:your-service-name}
# Backend service addresses.
collector.backend_service=${SW_AGENT_COLLECTOR_BACKEND_SERVICES:<datakit-ip:skywalking-agent-port>}
```

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/skywalking` directory under the DataKit installation directory, copy `skywalking.conf.sample`, and rename it to `skywalking.conf`. Example configuration:

    ```toml
        
    [[inputs.skywalking]]
      ## Skywalking HTTP endpoints for tracing, metric, logging, and profiling.
      ## NOTE: DO NOT EDIT.
      endpoints = ["/v3/trace", "/v3/metric", "/v3/logging", "/v3/profiling"]
    
      ## Skywalking GRPC server listening on address.
      address = "127.0.0.1:11800"
    
      ## plugins is a list containing all the widgets used in the program that should be regarded as services.
      ## every key word list in plugins represents a plugin defined as a special tag by skywalking.
      ## the value of the key word will be used to set the service name.
      # plugins = ["db.type"]
    
      ## ignore_tags will work as a blacklist to prevent tags from being sent to the data center.
      ## Every value in this list is a valid string of regular expression.
      # ignore_tags = ["block1", "block2"]
    
      ## Keep rare tracing resources list switch.
      ## If some resources are rare enough (not present in 1 hour), those resources will always be sent
      ## to the data center and do not consider samplers and filters.
      # keep_rare_resource = false
    
      ## delete trace message
      # del_message = true
    
      ## Ignore tracing resources map like service:[resources...].
      ## The service name is the full service name in the current application.
      ## The resource list is regular expressions used to block resource names.
      ## If you want to block some resources universally under all services, you can set the
      ## service name as "*". Note: double quotes "" cannot be omitted.
      # [inputs.skywalking.close_resource]
        # service1 = ["resource1", "resource2", ...]
        # service2 = ["resource1", "resource2", ...]
        # "*" = ["close_resource_under_all_services"]
        # ...
    
      ## Sampler config sets the global sampling strategy.
      ## sampling_rate sets the global sampling rate.
      # [inputs.skywalking.sampler]
        # sampling_rate = 1.0
    
      # [inputs.skywalking.tags]
        # key1 = "value1"
        # key2 = "value2"
        # ...
    
      ## Threads config controls how many goroutines an agent can start to handle HTTP requests.
      ## buffer is the size of jobs' buffering of worker channel.
      ## threads is the total number of goroutines at runtime.
      # [inputs.skywalking.threads]
        # buffer = 100
        # threads = 8
    
      ## Storage config sets up a local storage space on the hard drive to cache trace data.
      ## path is the local file path used to cache data.
      ## capacity is the total space size (MB) used to store data.
      # [inputs.skywalking.storage]
        # path = "./skywalking_storage"
        # capacity = 5120
    
    ```

    The Datakit SkyWalking Agent currently supports HTTP and GRPC protocols for network transmission.

    The `/v3/profiling` interface is currently only used for compatibility purposes; profiling data is not reported to the data center.

    Transmission via HTTP Protocol

    ```toml
    ## Skywalking HTTP endpoints for tracing, metric, logging, and profiling.
    ## NOTE: DO NOT EDIT.
    endpoints = ["/v3/trace", "/v3/metric", "/v3/logging", "/v3/logs", "/v3/profiling"]
    ```

    Transmission via GRPC Protocol

    ```toml
    ## Skywalking GRPC server listening on address.
    address = "localhost:11800"
    ```

=== "Kubernetes Installation"

    You can inject collector configurations using [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting) or configure [ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) to enable the collector.

    Environment variables can also be used to modify configuration parameters (they need to be added as default collectors in ENV_DEFAULT_ENABLED_INPUTS):

    - **ENV_INPUT_SKYWALKING_HTTP_ENDPOINTS**

        HTTP endpoints

        **Field Type**: JSON

        **Collector Configuration Field**: `endpoints`

        **Example**: ["/v3/trace", "/v3/metric", "/v3/logging", "/v3/profiling"]

    - **ENV_INPUT_SKYWALKING_GRPC_ENDPOINT**

        GRPC server

        **Field Type**: String

        **Collector Configuration Field**: `address`

        **Example**: 127.0.0.1:11800

    - **ENV_INPUT_SKYWALKING_PLUGINS**

        Plugin list

        **Field Type**: JSON

        **Collector Configuration Field**: `plugins`

        **Example**: ["db.type", "os.call"]

    - **ENV_INPUT_SKYWALKING_IGNORE_TAGS**

        Tag blacklist

        **Field Type**: JSON

        **Collector Configuration Field**: `ignore_tags`

        **Example**: ["block1","block2"]

    - **ENV_INPUT_SKYWALKING_KEEP_RARE_RESOURCE**

        Keep rare tracing resources list

        **Field Type**: Boolean

        **Collector Configuration Field**: `keep_rare_resource`

        **Default Value**: false

    - **ENV_INPUT_SKYWALKING_DEL_MESSAGE**

        Delete trace messages

        **Field Type**: Boolean

        **Collector Configuration Field**: `del_message`

        **Default Value**: false

    - **ENV_INPUT_SKYWALKING_CLOSE_RESOURCE**

        Ignore specified server's tracing (regex match)

        **Field Type**: JSON

        **Collector Configuration Field**: `close_resource`

        **Example**: {"service1":["resource1","other"],"service2":["resource2","other"]}

    - **ENV_INPUT_SKYWALKING_SAMPLER**

        Global sampling rate

        **Field Type**: Float

        **Collector Configuration Field**: `sampler`

        **Example**: 0.3

    - **ENV_INPUT_SKYWALKING_THREADS**

        Number of threads and buffers

        **Field Type**: JSON

        **Collector Configuration Field**: `threads`

        **Example**: {"buffer":1000, "threads":100}

    - **ENV_INPUT_SKYWALKING_STORAGE**

        Local cache path and size (MB)

        **Field Type**: JSON

        **Collector Configuration Field**: `storage`

        **Example**: {"storage":"./skywalking_storage", "capacity": 5120}

    - **ENV_INPUT_SKYWALKING_TAGS**

        Custom tags. If the same-named tags exist in the configuration file, they will be overwritten.

        **Field Type**: JSON

        **Collector Configuration Field**: `tags`

        **Example**: {"k1":"v1", "k2":"v2", "k3":"v3"}

<!-- markdownlint-enable -->

### Starting the Java Client {#start-java}

```command
  java -javaagent:/path/to/skywalking/agent -jar /path/to/your/service.jar
```

### Log Collection Configuration {#logging-config}

log4j2 example. Add the toolkit dependency to your maven or gradle:

```xml
<dependency>
    <groupId>org.apache.skywalking</groupId>
    <artifactId>apm-toolkit-log4j-2.x</artifactId>
    <version>{project.release.version}</version>
</dependency>
```

Send logs via gRPC protocol:

```xml
  <GRPCLogClientAppender name="grpc-log">
    <PatternLayout pattern="%d{HH:mm:ss.SSS} %-5level %logger{36} - %msg%n"/>
  </GRPCLogClientAppender>
```

Other supported logging frameworks:

- [Log4j-1.x](https://github.com/apache/skywalking-java/blob/main/docs/en/setup/service-agent/java-agent/Application-toolkit-log4j-1.x.md){:target="_blank"}
- [Logback-1.x](https://github.com/apache/skywalking-java/blob/main/docs/en/setup/service-agent/java-agent/Application-toolkit-logback-1.x.md){:target="_blank"}

## Metrics Fields {#metric}

SkyWalking reports some JVM metrics data.

- Tags

| Tag Name  | Description  |
| --------- | ------------ |
| `service` | service name |

- Metrics List

| Metrics                            | Description                                                                                                                               | Data Type | Unit   |
| ---------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | :-------: | :-----: |
| `class_loaded_count`               | Loaded class count.                                                                                                                      | int       | count  |
| `class_total_loaded_count`         | Total loaded class count.                                                                                                                | int       | count  |
| `class_total_unloaded_class_count` | Total unloaded class count.                                                                                                              | int       | count  |
| `cpu_usage_percent`                | CPU usage percentile                                                                                                                     | float     | percent|
| `gc_phrase_old/new_count`          | GC old or new count.                                                                                                                     | int       | count  |
| `heap/stack_committed`             | Heap or stack committed amount of memory.                                                                                                | int       | count  |
| `heap/stack_init`                  | Heap or stack initialized amount of memory.                                                                                              | int       | count  |
| `heap/stack_max`                   | Heap or stack max amount of memory.                                                                                                      | int       | count  |
| `heap/stack_used`                  | Heap or stack used amount of memory.                                                                                                     | int       | count  |
| `pool_*_committed`                 | Committed amount of memory in various pools (code_cache_usage, newgen_usage, oldgen_usage, survivor_usage, permgen_usage, metaspace_usage). | int       | count  |
| `pool_*_init`                      | Initialized amount of memory in various pools (code_cache_usage, newgen_usage, oldgen_usage, survivor_usage, permgen_usage, metaspace_usage). | int       | count  |
| `pool_*_max`                       | Max amount of memory in various pools (code_cache_usage, newgen_usage, oldgen_usage, survivor_usage, permgen_usage, metaspace_usage).     | int       | count  |
| `pool_*_used`                      | Used amount of memory in various pools (code_cache_usage, newgen_usage, oldgen_usage, survivor_usage, permgen_usage, metaspace_usage).    | int       | count  |
| `thread_blocked_state_count`       | Blocked state thread count                                                                                                               | int       | count  |
| `thread_daemon_count`              | Daemon thread count.                                                                                                                     | int       | count  |
| `thread_live_count`                | Live thread count.                                                                                                                       | int       | count  |
| `thread_peak_count`                | Peak thread count.                                                                                                                       | int       | count  |
| `thread_runnable_state_count`      | Runnable state thread count.                                                                                                             | int       | count  |
| `thread_time_waiting_state_count`  | Time waiting state thread count.                                                                                                         | int       | count  |
| `thread_waiting_state_count`       | Waiting state thread count.                                                                                                              | int       | count  |

## Data Fields Explanation {#fields}

### Metrics Types {metric}

JVM metrics collected by the SkyWalking language agent.

- Metric Tags

| Tag | Description |
| ----  | --------|
|`service`|Service name|

- Metrics List

| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`class_loaded_count`|Loaded class count.|int|count|
|`class_total_loaded_count`|Total loaded class count.|int|count|
|`class_total_unloaded_class_count`|Total unloaded class count.|int|count|
|`cpu_usage_percent`|CPU usage percentile|float|percent|
|`gc_phrase_old/new_count`|GC old or new count.|int|count|
|`heap/stack_committed`|Heap or stack committed amount of memory.|int|count|
|`heap/stack_init`|Heap or stack initialized amount of memory.|int|count|
|`heap/stack_max`|Heap or stack max amount of memory.|int|count|
|`heap/stack_used`|Heap or stack used amount of memory.|int|count|
|`pool_*_committed`|Committed amount of memory in various pools (code_cache_usage, newgen_usage, oldgen_usage, survivor_usage, permgen_usage, metaspace_usage).|int|count|
|`pool_*_init`|Initialized amount of memory in various pools (code_cache_usage, newgen_usage, oldgen_usage, survivor_usage, permgen_usage, metaspace_usage).|int|count|
|`pool_*_max`|Max amount of memory in various pools (code_cache_usage, newgen_usage, oldgen_usage, survivor_usage, permgen_usage, metaspace_usage).|int|count|
|`pool_*_used`|Used amount of memory in various pools (code_cache_usage, newgen_usage, oldgen_usage, survivor_usage, permgen_usage, metaspace_usage).|int|count|
|`thread_blocked_state_count`|Blocked state thread count|int|count|
|`thread_daemon_count`|Daemon thread count.|int|count|
|`thread_live_count`|Live thread count.|int|count|
|`thread_peak_count`|Peak thread count.|int|count|
|`thread_runnable_state_count`|Runnable state thread count.|int|count|
|`thread_time_waiting_state_count`|Time waiting state thread count.|int|count|
|`thread_waiting_state_count`|Waiting state thread count.|int|count|

### Tracing Fields Explanation {tracing}

- Tags (String type)

| Tag | Description |
| ----  | --------|
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

- Metrics List (Non-string types or long strings)

| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`duration`|Duration of span|int|μs|
|`message`|Origin content of span|string|-|
|`parent_id`|Parent span ID of current span|string|-|
|`resource`|Resource name producing current span|string|-|
|`span_id`|Span id|string|-|
|`start`|Start time of span|int|usec|
|`trace_id`|Trace id|string|-|

## SkyWalking Documentation {#doc}

> The latest Datakit SkyWalking implementation supports all 8.x.x versions of the SkyWalking APM Agent

- [Quick Start](https://skywalking.apache.org/docs/skywalking-showcase/latest/readme/){:target="_blank"}
- [Documentation](https://skywalking.apache.org/docs/){:target="_blank"}
- [Clients Download](https://skywalking.apache.org/downloads/){:target="_blank"}
- [Source Code](https://github.com/apache/skywalking){:target="_blank"}