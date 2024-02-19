---
title     : 'Resin'
summary   : 'Resin Performance metrics display, including startup time, heap memory, non heap memory, classes, threads, etc.'
__int_icon: 'icon/resin'
dashboard :
  - desc  : 'Resin'
    path  : 'dashboard/en/resin'
monitor   :
  - desc  : 'No'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Resin
<!-- markdownlint-enable -->

## Installation Configuration{#config}

Explanation: The example Resin version is Windows environment Resin/4.0.66 (Windows).

Metric collection is achieved through the use of `jolokia-jvm-agent` to collect Resin runtime metrics.

### Resin enables metric collection

- Configure `config/resin.properties`

ADD `jvm_args` ，parameter description：

- `javaagent`：`jolokia-jvm-agent`
- port=9530 # `jolokia-jvm-agent` export port

```shell
jvm_args  : -Xmx2048m -XX:MaxPermSize=256m -javaagent:C:/"Program Files"/datakit/data/jolokia-jvm-agent.jar=port=9530
```

- Restart Resin

Double-click `resin.exe`

### DataKit Collector Configuration

- Enables the DataKit JVM plugin and copy the 'sample' file

```shell
cd datakit/conf.d/jvm
cp jvm.conf.sample jvm.conf
```

- Modify `jvm.conf` configuration file

Main parameter description

- urls：`jolokia` agent access url
- interval：acquisition frequency
- inputs.jvm.metric：jvm metrics

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

## Monitor Intreval
interval   = "10s"

# Add agents URLs to query
urls = ["http://localhost:9530/jolokia/"]

## Add metrics to read
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

- Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metric {#metric}

### Metric Set resin_runtime

|Metrics| Describe |
| --- | --- |
| `Uptime` | Online duration |
| `StartTime` | resin start time |
| `VmVersion` | jvm version |
| `SpecName` | Java virtual machine specification name |

### Metric Set resin_memory

|Metrics| Describe |
| --- | --- |
| `HeapMemoryUsage` | heap memory used |
| `NonHeapMemoryUsage` | nonHeap memory used |

### Metric Set resin_threading

|Metrics| Describe |
| --- | --- |
| `TotalStartedThreadCount` | Total number of startup threads |
| `ThreadCount` | Number of active threads |
| `DaemonThreadCount` | Number of daemon threads |
| `PeakThreadCount` | Thread Peak |

### Metric Set resin_class_loading

|Metrics| Describe |
| --- | --- |
| LoadedClassCount | The current class has been loaded |
| UnloadedClassCount | Total number of `unloadun` classes |
| TotalLoadedClassCount | Total number of loaded classes |

### Metric Set resin_memory_pool

|Metrics| Describe |
| --- | --- |
| Usage | Memory pool used |
| PeakUsage | Used Memory Pool Peak |
| CollectionUsage | Used memory pool recycling |

### Metric Set resin_garbage_collector

|Metrics| Describe |
| --- | --- |
| CollectionTime | GC time |
| CollectionCount | GC count |
