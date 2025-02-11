---
title     : 'Resin'
summary   : 'Display Resin performance Metrics, including startup time, heap memory, non-heap memory, classes, threads, etc.'
__int_icon: 'icon/resin'
dashboard :
  - desc  : 'Resin monitoring view'
    path  : 'dashboard/en/resin'
monitor   :
  - desc  : 'None'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Resin
<!-- markdownlint-enable -->

## Installation and Configuration {#config}

Note: The example Resin version is for Windows environment Resin/4.0.66 (Windows).

Metrics collection is performed using the `jolokia-jvm-agent` to gather runtime Metrics of Resin.


### Enabling Metrics Collection for Resin

- Configure `config/resin.properties`

Add `jvm_args`, parameter description:

- `javaagent`: `jolokia-jvm-agent`
- port=9530 # Port exposed by `jolokia-jvm-agent` for Metrics

```shell
jvm_args  : -Xmx2048m -XX:MaxPermSize=256m -javaagent:C:/"Program Files"/datakit/data/jolokia-jvm-agent.jar=port=9530
```

- Restart Resin

Double-click `resin.exe`

### DataKit Collector Configuration

- Enable the DataKit JVM plugin and copy the `sample` file

```shell
cd datakit/conf.d/jvm
cp jvm.conf.sample jvm.conf
```

- Modify the `jvm.conf` configuration file

Key parameters explanation:

- urls: `jolokia` agent access address
- interval: collection frequency
- inputs.jvm.metric: JVM-related Metrics

```toml
# {"version": "1.2.12", "desc": "do NOT edit this line"}
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

## Monitoring Interval
interval   = "10s"

# Add agents URLs to query
urls = ["http://localhost:9530/jolokia/"]

## Add Metrics to read
[[inputs.jvm.metric]]
name  = "resin_runtime"
mbean = "java.lang:type=Runtime"
paths = ["Uptime","StartTime","VmVersion","SpecName"]

[[inputs.jvm.metric]]
name  = "resin_memory"
mbean = "java.lang:type=Memory"
paths = ["HeapMemoryUsage", "NonHeapMemoryUsage", "ObjectPendingFinalizationCount"]

[[inputs.jvm.metric]]
name     = "resin_garbage_collector"
mbean    = "java.lang:name=*,type=GarbageCollector"
paths    = ["CollectionTime", "CollectionCount"]
tag_keys = ["name"]

[[inputs.jvm.metric]]
name  = "resin_threading"
mbean = "java.lang:type=Threading"
paths = ["TotalStartedThreadCount", "ThreadCount", "DaemonThreadCount", "PeakThreadCount"]

[[inputs.jvm.metric]]
name  = "resin_class_loading"
mbean = "java.lang:type=ClassLoading"
paths = ["LoadedClassCount", "UnloadedClassCount", "TotalLoadedClassCount"]

[[inputs.jvm.metric]]
name     = "resin_memory_pool"
mbean    = "java.lang:name=*,type=MemoryPool"
paths    = ["Usage", "PeakUsage", "CollectionUsage"]
tag_keys = ["name"]

[inputs.jvm.tags]
# some_tag = "some_value"
# more_tag = "some_other_value"
  # ...
```

- Restart DataKit (if you need to enable logging, configure log collection before restarting)


## Metrics {#metric}

### Metric Set resin_runtime

| Metric | Description |
| --- | --- |
| `Uptime` | Uptime |
| `StartTime` | Startup time |
| `VmVersion` | JVM version |
| `SpecName` | Java Virtual Machine Specification Name |

### Metric Set resin_memory

| Metric | Description |
| --- | --- |
| `HeapMemoryUsage` | Heap memory usage |
| `NonHeapMemoryUsage` | Non-heap memory usage |

### Metric Set resin_threading

| Metric | Description |
| --- | --- |
| `TotalStartedThreadCount` | Total number of started threads |
| `ThreadCount` | Number of active threads |
| `DaemonThreadCount` | Number of daemon threads |
| `PeakThreadCount` | Peak thread count |

### Metric Set resin_class_loading

| Metric | Description |
| --- | --- |
| LoadedClassCount | Number of currently loaded classes |
| UnloadedClassCount | Total number of unloaded classes |
| TotalLoadedClassCount | Total number of loaded classes |

### Metric Set resin_memory_pool

| Metric | Description |
| --- | --- |
| Usage | Used memory pool |
| PeakUsage | Peak used memory pool |
| CollectionUsage | Collected memory pool |

### Metric Set resin_garbage_collector

| Metric | Description |
| --- | --- |
| CollectionTime | GC time |
| CollectionCount | GC count |