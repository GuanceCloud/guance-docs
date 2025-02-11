---
title     : 'JVM'
summary   : 'Collecting JVM Metrics Data'
tags:
  - 'JAVA'
__int_icon      : 'icon/jvm'
dashboard :
  - desc  : 'JVM'
    path  : 'dashboard/en/jvm'
monitor   :
  - desc  : 'Not Available'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Here, we provide two methods for collecting JVM metrics data. One method is DDTrace, and the other is Jolokia (deprecated). The following recommendations are provided for choosing a collection method:

- It is recommended to use DDTrace for collecting JVM metrics; Jolokia can also be used but is more complicated, so it is not recommended.
- If you are collecting metrics from a self-developed Java application, the DDTrace solution is recommended. In addition to collecting JVM metrics, it can also collect APM data.

## Configuration {#config}

### Collecting JVM Metrics Using DDTrace {#jvm-ddtrace}

DataKit includes a built-in [StatsD collector](statsd.md) for receiving StatsD protocol data sent over the network. Here, we use DDTrace to collect JVM metrics data and send it to DataKit via the StatsD protocol.

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    We recommend using the following StatsD configuration to collect DDTrace JVM metrics. Copy this configuration into the `conf.d/statsd` directory and name it `ddtrace-jvm-statsd.conf`:

    ```toml
    [[inputs.statsd]]
      protocol = "udp"
    
      ## Address and port to host UDP listener on
      service_address = ":8125"
    
      ## separator to use between elements of a statsd metric
      metric_separator = "_"
    
      drop_tags = ["runtime-id"]
      metric_mapping = [
        "jvm_:jvm",
        "datadog_tracer_:ddtrace",
      ]
    
      # The following configurations do not require attention
    
      delete_gauges = true
      delete_counters = true
      delete_sets = true
      delete_timings = true
    
      ## Percentiles to calculate for timing & histogram stats
      percentiles = [50.0, 90.0, 99.0, 99.9, 99.95, 100.0]
    
      ## Parses tags in the datadog statsd format
      ## http://docs.datadoghq.com/guides/dogstatsd/
      parse_data_dog_tags = true
    
      ## Parses datadog extensions to the statsd format
      datadog_extensions = true
    
      ## Parses distributions metric as specified in the datadog statsd format
      ## https://docs.datadoghq.com/developers/metrics/types/?tab=distribution#definition
      datadog_distributions = true
    
      ## Number of UDP messages allowed to queue up, once filled,
      ## the statsd server will start dropping packets
      allowed_pending_messages = 10000
    
      ## Number of timing/histogram values to track per-measurement in the
      ## calculation of percentiles. Raising this limit increases the accuracy
      ## of percentiles but also increases the memory usage and CPU time.
      percentile_limit = 1000
    
      ## Max duration (TTL) for each metric to stay cached/reported without being updated.
      #max_ttl = "1000h"
    
      [inputs.statsd.tags]
      # some_tag = "your-tag-value"
      # some_other_tag = "your-other-tag-value"
    ```

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration through [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

---

Configuration explanations:

- `service_address`: Set to `:8125`, which means DDTrace will send JVM metrics to this target address.
- `drop_tags`: We discard `runtime-id` here because it may cause Time Series explosion. If you need this field, remove it from `drop_tags`.
- `metric_mapping`: In the raw data sent by DDTrace, there are two types of metrics whose names start with `jvm_` and `datadog_tracer_`. Therefore, we normalize them into two Mearsurement sets: one is `jvm`, and the other is DDTrace's own operational metrics.

### Starting the Java Application {#start-app}

A feasible way to deploy a JVM is as follows:

```shell
java -javaagent:dd-java-agent.jar \
    -Ddd.profiling.enabled=true \
    -Ddd.logs.injection=true \
    -Ddd.trace.sample.rate=1 \
    -Ddd.service.name=my-app \
    -Ddd.env=staging \
    -Ddd.agent.host=localhost \
    -Ddd.agent.port=9529 \
    -Ddd.jmxfetch.enabled=true \
    -Ddd.jmxfetch.check-period=1000 \
    -Ddd.jmxfetch.statsd.host=127.0.0.1  \
    -Ddd.jmxfetch.statsd.port=8125 \
    -Ddd.version=1.0 \
    -jar your-app.jar
```

Note:

- For downloading the `dd-java-agent.jar` package, refer to [here](ddtrace.md)
- It is recommended to name the following fields:
    - `service.name` to indicate which application the JVM data comes from
    - `env` to indicate which environment the JVM data comes from (e.g., `prod/testing/preprod`)

- The meanings of these options:
    - `-Ddd.jmxfetch.check-period` indicates the collection frequency in milliseconds
    - `-Ddd.jmxfetch.statsd.host=127.0.0.1` indicates the connection address for the StatsD collector on DataKit
    - `-Ddd.jmxfetch.statsd.port=8125` indicates the UDP connection port for the StatsD collector on DataKit, defaulting to 8125
    - `-Ddd.trace.health.xxx` settings for DDTrace's own metrics collection and sending
    - To enable APM, add the following parameters (DataKit HTTP address):
        - `-Ddd.agent.host=localhost`
        - `-Ddd.agent.port=9529`

After enabling, DDTrace-exposed JVM metrics can be collected.

<!-- markdownlint-disable MD046 -->
???+ attention

    Actual collected metrics should follow [DataDog’s documentation](https://docs.datadoghq.com/tracing/metrics/runtime_metrics/java/#data-collected){:target="_blank"}.
<!-- markdownlint-enable -->

## Metrics {#metric}

- Tags

Each metric has the following tags (actual tags depend on Java startup parameters and StatsD configuration):

| Tag Name        | Description          |
| ----          | --------      |
| `env`         | Corresponds to `DD_ENV` |
| `host`        | Hostname        |
| `instance`    | Instance          |
| `jmx_domain`  |               |
| `metric_type` |               |
| `name`        |               |
| `service`     |               |
| `type`        |               |
| `version`     |               |

- Metric List

| Metric                        | Description                                                                                                                          | Data Type | Unit   |
| ----                        | ----                                                                                                                          | :---:    | :----: |
| `heap_memory`               | The total Java heap memory used                                                                                               | int      | B      |
| `heap_memory_committed`     | The total Java heap memory committed to be used                                                                               | int      | B      |
| `heap_memory_init`          | The initial Java heap memory allocated                                                                                        | int      | B      |
| `heap_memory_max`           | The maximum Java heap memory available                                                                                        | int      | B      |
| `non_heap_memory`           | The total Java non-heap memory used. Non-heap memory is calculated as follows: `Metaspace + CompressedClassSpace + CodeCache` | int      | B      |
| `non_heap_memory_committed` | The total Java non-heap memory committed to be used                                                                           | int      | B      |
| `non_heap_memory_init`      | The initial Java non-heap memory allocated                                                                                    | int      | B      |
| `non_heap_memory_max`       | The maximum Java non-heap memory available                                                                                    | int      | B      |
| `thread_count`              | The number of live threads                                                                                                    | int      | count  |
| `gc_cms_count`              | The total number of garbage collections that have occurred                                                                    | int      | count  |
| `gc_major_collection_count` | The number of major garbage collections that have occurred. Set `new_gc_metrics: true` to receive this metric                 | int      | count  |
| `gc_minor_collection_count` | The number of minor garbage collections that have occurred. Set `new_gc_metrics: true` to receive this metric                 | int      | count  |
| `gc_parnew_time`            | The approximate accumulated garbage collection time elapsed                                                                   | int      | ms     |
| `gc_major_collection_time`  | The approximate major garbage collection time elapsed. Set `new_gc_metrics: true` to receive this metric                      | int      | ms     |
| `gc_minor_collection_time`  | The approximate minor garbage collection time elapsed. Set `new_gc_metrics: true` to receive this metric                      | int      | ms     |

Key explanations for several metrics: `gc_major_collection_count` `gc_minor_collection_count` `gc_major_collection_time` `gc_minor_collection_time`:

These metric types are `counter`, meaning they are counters. During collection, each time a metric is collected, it is subtracted from the previous result and divided by time, indicating the rate of change per second, not the actual value in the `JVM`'s `MBean`.

### Collecting JVM Metrics Using Jolokia {#jvm-jolokia}

The JVM collector can gather many metrics through JMX and send them to Guance for analysis of Java runtime conditions.

### Configuration {#jolokia-config}

### Prerequisites {#jolokia-requirements}

Install or download [Jolokia](https://search.maven.org/remotecontent?filepath=org/jolokia/jolokia-jvm/1.6.2/jolokia-jvm-1.6.2-agent.jar){:target="_blank"}. The Jolokia jar file is already downloaded in the `data` directory under the DataKit installation directory. Start the Java application as follows:

```shell
java -javaagent:/path/to/jolokia-jvm-agent.jar=port=8080,host=localhost -jar your_app.jar
```

Tested versions:

- [x] JDK 20
- [x] JDK 17
- [x] JDK 11
- [x] JDK 8

Go to the `conf.d/jvm` directory under the DataKit installation directory, copy `jvm.conf.sample` and rename it to `jvm.conf`. An example configuration is as follows:

```toml
[[inputs.jvm]]
  # default_tag_prefix      = ""
  # default_field_prefix    = ""
  # default_field_separator = "."

  # username = ""
  # password = ""
  # response_timeout = "5s"

  ## Optional TLS config
  # tls_ca   = "/var/private/ca.pem"
  # tls_cert = "/var/private/client.pem"
  # tls_key  = "/var/private/client-key.pem"
  # insecure_skip_verify = false

  ## Monitor Interval
  # interval   = "60s"

  # Add agents URLs to query
  urls = ["http://localhost:8080/jolokia"]

  ## Add metrics to read
  [[inputs.jvm.metric]]
    name  = "java_runtime"
    mbean = "java.lang:type=Runtime"
    paths = ["Uptime"]

  [[inputs.jvm.metric]]
    name  = "java_memory"
    mbean = "java.lang:type=Memory"
    paths = ["HeapMemoryUsage", "NonHeapMemoryUsage", "ObjectPendingFinalizationCount"]

  [[inputs.jvm.metric]]
    name     = "java_garbage_collector"
    mbean    = "java.lang:name=*,type=GarbageCollector"
    paths    = ["CollectionTime", "CollectionCount"]
    tag_keys = ["name"]

  [[inputs.jvm.metric]]
    name  = "java_threading"
    mbean = "java.lang:type=Threading"
    paths = ["TotalStartedThreadCount", "ThreadCount", "DaemonThreadCount", "PeakThreadCount"]

  [[inputs.jvm.metric]]
    name  = "java_class_loading"
    mbean = "java.lang:type=ClassLoading"
    paths = ["LoadedClassCount", "UnloadedClassCount", "TotalLoadedClassCount"]

  [[inputs.jvm.metric]]
    name     = "java_memory_pool"
    mbean    = "java.lang:name=*,type=MemoryPool"
    paths    = ["Usage", "PeakUsage", "CollectionUsage"]
    tag_keys = ["name"]

  [inputs.jvm.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

After configuring, restart DataKit.

### Jolokia Metrics {#jolokia-metric}

All collected data defaults to appending a global tag named `host` (tag value is the hostname where DataKit is located), and additional tags can be specified in the configuration using `[inputs.jvm.tags]`:

``` toml
 [inputs.jvm.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



#### `java_runtime`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|The hostname of the Jolokia agent/proxy running on.|
|`jolokia_agent_url`|Jolokia agent url path.|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`CollectionUsagecommitted`|The amount of memory in bytes that is committed for the Java virtual machine to use.|float|B|
|`CollectionUsageinit`|The amount of memory in bytes that the Java virtual machine initially requests from the operating system for memory management.|float|B|
|`CollectionUsagemax`|The maximum amount of memory in bytes that can be used for memory management.|float|B|
|`CollectionUsageused`|The amount of used memory in bytes.|float|B|
|`Uptime`|The total runtime.|int|ms|



#### `java_memory`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|The hostname of the Jolokia agent/proxy running on.|
|`jolokia_agent_url`|Jolokia agent url path.|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`CollectionUsagecommitted`|The amount of memory in bytes that is committed for the Java virtual machine to use.|float|B|
|`CollectionUsageinit`|The amount of memory in bytes that the Java virtual machine initially requests from the operating system for memory management.|float|B|
|`CollectionUsagemax`|The maximum amount of memory in bytes that can be used for memory management.|float|B|
|`CollectionUsageused`|The amount of used memory in bytes.|float|B|
|`HeapMemoryUsagecommitted`|The total Java heap memory committed to be used.|int|B|
|`HeapMemoryUsageinit`|The initial Java heap memory allocated.|int|B|
|`HeapMemoryUsagemax`|The maximum Java heap memory available.|int|B|
|`HeapMemoryUsageused`|The total Java heap memory used.|int|B|
|`NonHeapMemoryUsagecommitted`|The total Java non-heap memory committed to be used.|int|B|
|`NonHeapMemoryUsageinit`|The initial Java non-heap memory allocated.|int|B|
|`NonHeapMemoryUsagemax`|The maximum Java non-heap memory available.|int|B|
|`NonHeapMemoryUsageused`|The total Java non-heap memory used.|int|B|
|`ObjectPendingFinalizationCount`|The count of object pending finalization.|int|count|



#### `java_garbage_collector`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|The hostname of the Jolokia agent/proxy running on.|
|`jolokia_agent_url`|Jolokia agent url path.|
|`name`|The name of GC generation.|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`CollectionCount`|The number of GC that have occurred.|int|count|
|`CollectionTime`|The approximate GC collection time elapsed.|int|ms|
|`CollectionUsagecommitted`|The amount of memory in bytes that is committed for the Java virtual machine to use.|float|B|
|`CollectionUsageinit`|The amount of memory in bytes that the Java virtual machine initially requests from the operating system for memory management.|float|B|
|`CollectionUsagemax`|The maximum amount of memory in bytes that can be used for memory management.|float|B|
|`CollectionUsageused`|The amount of used memory in bytes.|float|B|



#### `java_threading`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|The hostname of the Jolokia agent/proxy running on.|
|`jolokia_agent_url`|Jolokia agent url path.|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`CollectionUsagecommitted`|The amount of memory in bytes that is committed for the Java virtual machine to use.|float|B|
|`CollectionUsageinit`|The amount of memory in bytes that the Java virtual machine initially requests from the operating system for memory management.|float|B|
|`CollectionUsagemax`|The maximum amount of memory in bytes that can be used for memory management.|float|B|
|`CollectionUsageused`|The amount of used memory in bytes.|float|B|
|`DaemonThreadCount`|The count of daemon thread.|int|count|
|`PeakThreadCount`|The peak count of thread.|int|count|
|`ThreadCount`|The count of thread.|int|count|
|`TotalStartedThreadCount`|The total count of started thread.|int|count|



#### `java_class_loading`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|The hostname of the Jolokia agent/proxy running on.|
|`jolokia_agent_url`|Jolokia agent url path.|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`CollectionUsagecommitted`|The amount of memory in bytes that is committed for the Java virtual machine to use.|float|B|
|`CollectionUsageinit`|The amount of memory in bytes that the Java virtual machine initially requests from the operating system for memory management.|float|B|
|`CollectionUsagemax`|The maximum amount of memory in bytes that can be used for memory management.|float|B|
|`CollectionUsageused`|The amount of used memory in bytes.|float|B|
|`LoadedClassCount`|The count of loaded class.|int|count|
|`TotalLoadedClassCount`|The total count of loaded class.|int|count|
|`UnloadedClassCount`|The count of unloaded class.|int|count|



#### `java_memory_pool`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|The hostname of the Jolokia agent/proxy running on.|
|`jolokia_agent_url`|Jolokia agent url path.|
|`name`|The name of space.|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`CollectionUsagecommitted`|The amount of memory in bytes that is committed for the Java virtual machine to use.|float|B|
|`CollectionUsageinit`|The amount of memory in bytes that the Java virtual machine initially requests from the operating system for memory management.|float|B|
|`CollectionUsagemax`|The maximum amount of memory in bytes that can be used for memory management.|float|B|
|`CollectionUsageused`|The amount of used memory in bytes.|float|B|
|`PeakUsagecommitted`|The total peak Java memory pool committed to be used.|int|B|
|`PeakUsageinit`|The initial peak Java memory pool allocated.|int|B|
|`PeakUsagemax`|The maximum peak Java memory pool available.|int|B|
|`PeakUsageused`|The total peak Java memory pool used.|int|B|
|`Usagecommitted`|The total Java memory pool committed to be used.|int|B|
|`Usageinit`|The initial Java memory pool allocated.|int|B|
|`Usagemax`|The maximum Java memory pool available.|int|B|
|`Usageused`|The total Java memory pool used.|int|B|



## Further Reading {#more-readings}

- [DDTrace Java Example](ddtrace-java.md)
- [SkyWalking](skywalking.md)
- [OpenTelemetry Java Example](opentelemetry-java.md)