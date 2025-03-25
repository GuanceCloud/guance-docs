---
title     : 'SkyWalking'
summary   : 'SkyWalking Tracing data ingestion'
tags:
  - 'APM'
  - 'SKYWALKING'
__int_icon: 'icon/skywalking'
dashboard :
  - desc  : 'Skywalking JVM monitoring view'
    path  : 'dashboard/en/skywalking'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The SkyWalking Agent embedded in Datakit is used to receive, compute, and analyze SkyWalking Tracing protocol data.

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
=== "HOST Installation"

    Navigate to the `conf.d/skywalking` directory under the DataKit installation directory, copy `skywalking.conf.sample` and rename it to `skywalking.conf`. Example as follows:

    ```toml
        
    [[inputs.skywalking]]
      ## Skywalking HTTP endpoints for tracing, metric, logging and profiling.
      ## NOTE: DO NOT EDIT.
      endpoints = ["/v3/trace", "/v3/metric", "/v3/logging", "/v3/profiling"]
    
      ## Skywalking GRPC server listening on address.
      address = "127.0.0.1:11800"
    
      ## plugins is a list contains all the widgets used in program that want to be regarded as service.
      ## every key words list in plugins represents a plugin defined as special tag by skywalking.
      ## the value of the key word will be used to set the service name.
      # plugins = ["db.type"]
    
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
      # [inputs.skywalking.close_resource]
        # service1 = ["resource1", "resource2", ...]
        # service2 = ["resource1", "resource2", ...]
        # "*" = ["close_resource_under_all_services"]
        # ...
    
      ## Sampler config uses to set global sampling strategy.
      ## sampling_rate used to set global sampling rate.
      # [inputs.skywalking.sampler]
        # sampling_rate = 1.0
    
      # [inputs.skywalking.tags]
        # key1 = "value1"
        # key2 = "value2"
        # ...
    
      ## Threads config controls how many goroutines an agent cloud start to handle HTTP request.
      ## buffer is the size of jobs' buffering of worker channel.
      ## threads is the total number fo goroutines at running time.
      # [inputs.skywalking.threads]
        # buffer = 100
        # threads = 8
    
      ## Storage config a local storage space in hard dirver to cache trace data.
      ## path is the local file path used to cache data.
      ## capacity is total space size(MB) used to store data.
      # [inputs.skywalking.storage]
        # path = "./skywalking_storage"
        # capacity = 5120
    
    ```

    The Datakit SkyWalking Agent currently supports two network transmission methods: HTTP protocol and GRPC protocol.

    The `/v3/profiling` interface is currently only used as a compatibility interface; profiling data is not reported to the data center.

    Transmission via HTTP protocol

    ```toml
    ## Skywalking HTTP endpoints for tracing, metric, logging and profiling.
    ## NOTE: DO NOT EDIT.
    endpoints = ["/v3/trace", "/v3/metric", "/v3/logging", "/v3/logs", "/v3/profiling"]
    ```

    Transmission via GRPC protocol

    ```toml
    ## Skywalking GRPC server listening on address.
    address = "localhost:11800"
    ```

=== "Kubernetes Installation"

    You can inject collector configurations via [ConfigMap method](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [configure ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) to enable the collector.

    It also supports modifying configuration parameters via environment variables (needs to be added as default collectors in ENV_DEFAULT_ENABLED_INPUTS):

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
    
        Number of threads and buffer
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `threads`
    
        **Example**: {"buffer":1000, "threads":100}
    
    - **ENV_INPUT_SKYWALKING_STORAGE**
    
        Local cache path and size (MB)
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `storage`
    
        **Example**: {"storage":"./skywalking_storage", "capacity": 5120}
    
    - **ENV_INPUT_SKYWALKING_TAGS**
    
        Custom tags. If there are tags with the same name in the configuration file, they will override them.
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `tags`
    
        **Example**: {"k1":"v1", "k2":"v2", "k3":"v3"}

<!-- markdownlint-enable -->

### Starting Java Client {#start-java}

```command
  java -javaagent:/path/to/skywalking/agent -jar /path/to/your/service.jar
```

### Log Collection Configuration {#logging-config}

log4j2 example. Add toolkit dependency package to maven or gradle:

```xml
<dependency>
    <groupId>org.apache.skywalking</groupId>
    <artifactId>apm-toolkit-log4j-2.x</artifactId>
    <version>{project.release.version}</version>
</dependency>
```

Send through gRPC protocol:

```xml
  <GRPCLogClientAppender name="grpc-log">
    <PatternLayout pattern="%d{HH:mm:ss.SSS} %-5level %logger{36} - %msg%n"/>
  </GRPCLogClientAppender>
```

Other log framework support:

- [Log4j-1.x](https://github.com/apache/skywalking-java/blob/main/docs/en/setup/service-agent/java-agent/Application-toolkit-log4j-1.x.md){:target="_blank"}
- [Logback-1.x](https://github.com/apache/skywalking-java/blob/main/docs/en/setup/service-agent/java-agent/Application-toolkit-logback-1.x.md){:target="_blank"}

## Metrics Fields {#metric}

SkyWalking reports some JVM metrics data.

- Tags

| Tag Name  | Description  |
| --------- | ------------ |
| `service` | service name |

- Metrics List

| Metrics                            | Description                                                                                                                               | Data Type |  Unit   |
| ---------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | :-------: | :-----: |
| `class_loaded_count`               | loaded class count.                                                                                                                       |    int    |  count  |
| `class_total_loaded_count`         | total loaded class count.                                                                                                                 |    int    |  count  |
| `class_total_unloaded_class_count` | total unloaded class count.                                                                                                               |    int    |  count  |
| `cpu_usage_percent`                | cpu usage percentile                                                                                                                      |   float   | percent |
| `gc_phrase_old/new_count`          | gc old or new count.                                                                                                                      |    int    |  count  |
| `heap/stack_committed`             | heap or stack committed amount of memory.                                                                                                 |    int    |  count  |
| `heap/stack_init`                  | heap or stack initialized amount of memory.                                                                                               |    int    |  count  |
| `heap/stack_max`                   | heap or stack max amount of memory.                                                                                                       |    int    |  count  |
| `heap/stack_used`                  | heap or stack used amount of memory.                                                                                                      |    int    |  count  |
| `pool_*_committed`                 | committed amount of memory in variety of pool(code_cache_usage,newgen_usage,oldgen_usage,survivor_usage,permgen_usage,metaspace_usage).   |    int    |  count  |
| `pool_*_init`                      | initialized amount of memory in variety of pool(code_cache_usage,newgen_usage,oldgen_usage,survivor_usage,permgen_usage,metaspace_usage). |    int    |  count  |
| `pool_*_max`                       | max amount of memory in variety of pool(code_cache_usage,newgen_usage,oldgen_usage,survivor_usage,permgen_usage,metaspace_usage).         |    int    |  count  |
| `pool_*_used`                      | used amount of memory in variety of pool(code_cache_usage,newgen_usage,oldgen_usage,survivor_usage,permgen_usage,metaspace_usage).        |    int    |  count  |
| `thread_blocked_state_count`       | blocked state thread count                                                                                                                |    int    |  count  |
| `thread_daemon_count`              | thread daemon count.                                                                                                                      |    int    |  count  |
| `thread_live_count`                | thread live count.                                                                                                                        |    int    |  count  |
| `thread_peak_count`                | thread peak count.                                                                                                                        |    int    |  count  |
| `thread_runnable_state_count`      | runnable state thread count.                                                                                                              |    int    |  count  |
| `thread_time_waiting_state_count`  | time waiting state thread count.                                                                                                          |    int    |  count  |
| `thread_waiting_state_count`       | waiting state thread count.                                                                                                               |    int    |  count  |

## Data Field Explanation {#fields}





### Metrics Types {#metric}

JVM metrics collected by SkyWalking language agent.

- Metric Tags


| Tag | Description |
|  ----  | --------|
|`service`|service name|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`class_loaded_count`|loaded class count.|int|count|
|`class_total_loaded_count`|total loaded class count.|int|count|
|`class_total_unloaded_class_count`|total unloaded class count.|int|count|
|`cpu_usage_percent`|cpu usage percentile|float|percent|
|`gc_phrase_old/new_count`|gc old or new count.|int|count|
|`heap/stack_committed`|heap or stack committed amount of memory.|int|count|
|`heap/stack_init`|heap or stack initialized amount of memory.|int|count|
|`heap/stack_max`|heap or stack max amount of memory.|int|count|
|`heap/stack_used`|heap or stack used amount of memory.|int|count|
|`pool_*_committed`|committed amount of memory in variety of pool(code_cache_usage,newgen_usage,oldgen_usage,survivor_usage,permgen_usage,metaspace_usage).|int|count|
|`pool_*_init`|initialized amount of memory in variety of pool(code_cache_usage,newgen_usage,oldgen_usage,survivor_usage,permgen_usage,metaspace_usage).|int|count|
|`pool_*_max`|max amount of memory in variety of pool(code_cache_usage,newgen_usage,oldgen_usage,survivor_usage,permgen_usage,metaspace_usage).|int|count|
|`pool_*_used`|used amount of memory in variety of pool(code_cache_usage,newgen_usage,oldgen_usage,survivor_usage,permgen_usage,metaspace_usage).|int|count|
|`thread_blocked_state_count`|blocked state thread count|int|count|
|`thread_daemon_count`|thread daemon count.|int|count|
|`thread_live_count`|thread live count.|int|count|
|`thread_peak_count`|thread peak count.|int|count|
|`thread_runnable_state_count`|runnable state thread count.|int|count|
|`thread_time_waiting_state_count`|time waiting state thread count.|int|count|
|`thread_waiting_state_count`|waiting state thread count.|int|count|






### Trace Field Explanation {#tracing}



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
|`start`|start time of span.|int|usec|
|`trace_id`|Trace id|string|-|






## SkyWalking Documentation {#doc}

> The latest Datakit SkyWalking implementation supports all 8.x.x versions of SkyWalking APM Agents

- [Quick Start](https://skywalking.apache.org/docs/skywalking-showcase/latest/readme/){:target="_blank"}
- [Docs](https://skywalking.apache.org/docs/){:target="_blank"}
- [Clients Download](https://skywalking.apache.org/downloads/){:target="_blank"}
- [Source Code](https://github.com/apache/skywalking){:target="_blank"}