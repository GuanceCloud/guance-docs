---
title     : 'SkyWalking'
summary   : 'SkyWalking Tracing Data Ingestion'
__int_icon      : 'icon/skywalking'
dashboard :
  - desc  : 'Skywalking JVM Monitoring View'
    path  : 'dashboard/en/skywalking'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# SkyWalking
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The SkyWalking Agent embedded in Datakit is used to receive, compute and analyze SkyWalking Tracing protocol data.

## SkyWalking Doc {#doc}

> APM v8.8. 3 is currently incompatible and cannot be used. V8.5. 0 v8.6. 0 v8.7. 0 is currently supported.

- [Quick Start](https://skywalking.apache.org/docs/skywalking-showcase/latest/readme/){:target="_blank"}
- [Docs](https://skywalking.apache.org/docs/){:target="_blank"}
- [Clients Download](https://skywalking.apache.org/downloads/){:target="_blank"}
- [Source Code](https://github.com/apache/skywalking){:target="_blank"}

## Configure SkyWalking Client {#client-config}

Open file /path_to_skywalking_agent/config/agent.config to configure.

```conf
# The service name in UI
agent.service_name=${SW_AGENT_NAME:your-service-name}
# Backend service addresses.
collector.backend_service=${SW_AGENT_COLLECTOR_BACKEND_SERVICES:<datakit-ip:skywalking-agent-port>}
```

## Configure SkyWalking Agent {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Install On Local Host"

    Go to the `conf.d/skywalking` directory under the DataKit installation directory, copy `skywalking.conf.sample` and name it `skywalking.conf`. Examples are as follows:

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

    Datakit supports two kinds of Transport Protocol, HTTP & GRPC.

    /v3/profiling API for now used as compatible facility and do not send profiling data to data center.

    HTTP Protocol Config
    ```toml
      ## Skywalking HTTP endpoints for tracing, metric, logging and profiling.
      ## NOTE: DO NOT EDIT.
      endpoints = ["/v3/trace", "/v3/metric", "/v3/logging", "/v3/logs", "/v3/profiling"]
    ```

    GRPC Protocol Config
    ```toml
      ## Skywalking GRPC server listening on address.
      address = "localhost:11800"
    ```

    For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.skywalking.tags]`:

    ```toml
      [inputs.skywalking.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
      # ...
    ```

=== "Install In Kubernetes Cluster"

    Can be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [Config ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) .

    Can also be turned on by environment variables, (needs to be added as the default collector in ENV_DEFAULT_ENABLED_INPUTS):
    
    - **ENV_INPUT_SKYWALKING_HTTP_ENDPOINTS**
    
        HTTP endpoints for tracing
    
        **Type**: JSON
    
        **ConfField**: `endpoints`
    
        **Example**: ["/v3/trace", "/v3/metric", "/v3/logging", "/v3/profiling"]
    
    - **ENV_INPUT_SKYWALKING_GRPC_ENDPOINT**
    
        GRPC server
    
        **Type**: String
    
        **ConfField**: `address`
    
        **Example**: 127.0.0.1:11800
    
    - **ENV_INPUT_SKYWALKING_PLUGINS**
    
        List contains all the widgets used in program that want to be regarded as service
    
        **Type**: JSON
    
        **ConfField**: `plugins`
    
        **Example**: ["db.type", "os.call"]
    
    - **ENV_INPUT_SKYWALKING_IGNORE_TAGS**
    
        Blacklist to prevent tags
    
        **Type**: JSON
    
        **ConfField**: `ignore_tags`
    
        **Example**: ["block1","block2"]
    
    - **ENV_INPUT_SKYWALKING_KEEP_RARE_RESOURCE**
    
        Keep rare tracing resources list switch
    
        **Type**: Boolean
    
        **ConfField**: `keep_rare_resource`
    
        **Default**: false
    
    - **ENV_INPUT_SKYWALKING_DEL_MESSAGE**
    
        Delete trace message
    
        **Type**: Boolean
    
        **ConfField**: `del_message`
    
        **Default**: false
    
    - **ENV_INPUT_SKYWALKING_CLOSE_RESOURCE**
    
        Ignore tracing resources that service (regular)
    
        **Type**: JSON
    
        **ConfField**: `close_resource`
    
        **Example**: {"service1":["resource1","other"],"service2":["resource2","other"]}
    
    - **ENV_INPUT_SKYWALKING_SAMPLER**
    
        Global sampling rate
    
        **Type**: Float
    
        **ConfField**: `sampler`
    
        **Example**: 0.3
    
    - **ENV_INPUT_SKYWALKING_THREADS**
    
        Total number of threads and buffer
    
        **Type**: JSON
    
        **ConfField**: `threads`
    
        **Example**: {"buffer":1000, "threads":100}
    
    - **ENV_INPUT_SKYWALKING_STORAGE**
    
        Local cache file path and size (MB) 
    
        **Type**: JSON
    
        **ConfField**: `storage`
    
        **Example**: {"storage":"./skywalking_storage", "capacity": 5120}
    
    - **ENV_INPUT_SKYWALKING_TAGS**
    
        Customize tags. If there is a tag with the same name in the configuration file, it will be overwritten
    
        **Type**: JSON
    
        **ConfField**: `tags`
    
        **Example**: {"k1":"v1", "k2":"v2", "k3":"v3"}

<!-- markdownlint-enable -->

## Restart Java Client {#start-java}

```command
java -javaagent:/path/to/skywalking/agent -jar /path/to/your/service.jar
```

## Send Log to Datakit {#logging}

- log4j2

The toolkit dependency package is added to the maven or gradle.

```xml
  <dependency>
    <groupId>org.apache.skywalking</groupId>
    <artifactId>apm-toolkit-log4j-2.x</artifactId>
    <version>{project.release.version}</version>
  </dependency>
```

Sent through grpc protocol:

```xml
  <GRPCLogClientAppender name="grpc-log">
    <PatternLayout pattern="%d{HH:mm:ss.SSS} %-5level %logger{36} - %msg%n"/>
  </GRPCLogClientAppender>
```

Others:

- [Log4j-1.x](https://github.com/apache/skywalking-java/blob/main/docs/en/setup/service-agent/java-agent/Application-toolkit-log4j-1.x.md){:target="_blank"}
- [Logback-1.x](https://github.com/apache/skywalking-java/blob/main/docs/en/setup/service-agent/java-agent/Application-toolkit-logback-1.x.md){:target="_blank"}

## SkyWalking JVM Measurement {#jvm-measurements}

jvm metrics collected by SkyWalking language agent.

- Tag

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

## Measurements {#measurements}









### ``



- tag


| Tag | Description |
|  ----  | --------|
|`container_host`|Container hostname. Available in OpenTelemetry. Optional.|
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



