---
title     : 'Flink'
summary   : 'Collect Flink metrics'
__int_icon      : 'icon/flink'
dashboard :
  - desc  : 'Flink'
    path  : 'dashboard/en/flink'
monitor   :
  - desc  : 'Flink'
    path  : 'monitor/en/flink'
---

<!-- markdownlint-disable MD025 -->
# Flink
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

Flink collector can take many metrics from Flink instances, such as Flink server status and network status, and collect the metrics to DataFlux to help you monitor and analyze various abnormal situations of Flink.

## Configuration  {#config}

### Preconditions {#requirements}

> Explanation: Example Flink version is: Flink 1.14. 2 (CentOS), each version of the indicator may be different.

At present, Flink officially provides two methods for reporting metrics: [Prometheus](https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/deployment/metric_reporters/#prometheus){:target="_blank"} and [PrometheusPushGateway](https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/deployment/metric_reporters/#prometheuspushgateway){:target="_blank"}. Their main differences are:

- Prometheus PushGateway is to report all metrics of the cluster to PushGateway in a unified way, so you need to install PushGateway additionally.
- Prometheus mode requires each node of the cluster to expose a unique port, and does not need to install other software, but it requires N available ports, which is slightly complicated to configure.

### PrometheusPushGateway Way (recommended) {#push-gateway}

- Download and Install: PushGateway can be downloaded at [Prometheuse official page](https://prometheus.io/download/#pushgateway){:target="_blank"}.

Start PushGateway: (This command is for reference only, and the specific command may vary according to the actual environment)

```shell
nohup ./pushgateway &
```

- Configure `flink-conf.yaml` to report metrics uniformly to PushGateway

Configure the configuration file for Flink `conf/flink-conf.yaml` sample:

```bash
metrics.reporter.promgateway.class: org.apache.flink.metrics.prometheus.PrometheusPushGatewayReporter # Fixed this value and cannot be changed
metrics.reporter.promgateway.host: localhost # IP address of promgateway
metrics.reporter.promgateway.port: 9091 # promgateway listening port
metrics.reporter.promgateway.interval: 15 SECONDS # collection interval
metrics.reporter.promgateway.groupingKey: k1=v1;k2=v2

# The following are optional parameters
# metrics.reporter.promgateway.jobName: myJob
# metrics.reporter.promgateway.randomJobNameSuffix: true
# metrics.reporter.promgateway.deleteOnShutdown: false
```

Start Flink: `./bin/start-cluster.sh` (This command is for reference only, and the specific command may vary depending on the actual environment)

### Prometheus Mode {#prometheus}

- Configure `flink-conf.yaml` to expose metrics for each node. Configure the configuration file for Flink `conf/flink-conf.yaml` sample:

```bash
metrics.reporter.prom.class: org.apache.flink.metrics.prometheus.PrometheusReporter
metrics.reporter.prom.port: 9250-9260 # The port range of each node is different according to the number of nodes, and one port corresponds to one node
```

- Start Flink: `./bin/start-cluster.sh` (This command is for reference only, and the specific command may vary depending on the actual environment)

- Hosts with access to external networks [Install Datakit](https://www.yuque.com/dataflux/datakit/datakit-install){:target="_blank"}
- Change the Flink configuration and add the following to turn on Prometheus collection.

```bash
metrics.reporter.prom.class: org.apache.flink.metrics.prometheus.PrometheusReporter
metrics.reporter.prom.port: 9250-9260
```

> Note: The `metrics.reporter.prom.port` setting is based on the number of clustered `jobmanagers` and `taskmanager`

- Restart the Flink cluster application configuration
- curl http://{Flink iP}:9250-9260 to start collecting

## Metric {#metric}

Flink collects multiple metrics by default, and these [metrics](https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/ops/metrics/#system-metrics){:target="_blank"} provide insight into the current state.



### `flink_jobmanager`

- tag


| Tag | Description |
|  ----  | --------|
|`host`|Host name.|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`Status_JVM_CPU_Load`|The recent CPU usage of the JVM.|int|count|
|`Status_JVM_CPU_Time`|The CPU time used by the JVM.|int|count|
|`Status_JVM_ClassLoader_ClassesLoaded`|The total number of classes loaded since the start of the JVM.|int|count|
|`Status_JVM_ClassLoader_ClassesUnloaded`|The total number of classes unloaded since the start of the JVM.|int|count|
|`Status_JVM_GarbageCollector_Copy_Count`|The total number of collections that have occurred.|int|count|
|`Status_JVM_GarbageCollector_Copy_Time`|The total time spent performing garbage collection.|int|count|
|`Status_JVM_GarbageCollector_G1_Old_Generation_Count`|The total number of collections that have occurred.|int|count|
|`Status_JVM_GarbageCollector_G1_Old_Generation_Time`|The total time spent performing garbage collection.|int|count|
|`Status_JVM_GarbageCollector_G1_Young_Generation_Count`|The total number of collections that have occurred.|int|count|
|`Status_JVM_GarbageCollector_G1_Young_Generation_Time`|The total time spent performing garbage collection.|int|count|
|`Status_JVM_GarbageCollector_MarkSweepCompact_Count`|The total number of collections that have occurred.|int|count|
|`Status_JVM_GarbageCollector_MarkSweepCompact_Time`|The total time spent performing garbage collection.|int|count|
|`Status_JVM_Memory_Direct_Count`|The number of buffers in the direct buffer pool.|int|count|
|`Status_JVM_Memory_Direct_MemoryUsed`|The amount of memory used by the JVM for the direct buffer pool.|int|count|
|`Status_JVM_Memory_Direct_TotalCapacity`|The total capacity of all buffers in the direct buffer pool.|int|count|
|`Status_JVM_Memory_Heap_Committed`|The amount of heap memory guaranteed to be available to the JVM.|int|count|
|`Status_JVM_Memory_Heap_Max`|The maximum amount of heap memory that can be used for memory management.|int|count|
|`Status_JVM_Memory_Heap_Used`|The amount of heap memory currently used.|int|count|
|`Status_JVM_Memory_Mapped_Count`|The number of buffers in the mapped buffer pool.|int|count|
|`Status_JVM_Memory_Mapped_MemoryUsed`|The amount of memory used by the JVM for the mapped buffer pool.|int|count|
|`Status_JVM_Memory_Mapped_TotalCapacity`|The number of buffers in the mapped buffer pool.|int|count|
|`Status_JVM_Memory_Metaspace_Committed`|The amount of memory guaranteed to be available to the JVM in the meta-space memory pool (in bytes).|int|count|
|`Status_JVM_Memory_Metaspace_Max`|The maximum amount of memory that can be used in the meta-space memory pool (in bytes).|int|count|
|`Status_JVM_Memory_Metaspace_Used`|Used bytes of a given JVM memory area|int|count|
|`Status_JVM_Memory_NonHeap_Committed`|The amount of non-heap memory guaranteed to be available to the JVM.|int|count|
|`Status_JVM_Memory_NonHeap_Max`|The maximum amount of non-heap memory that can be used for memory management|int|count|
|`Status_JVM_Memory_NonHeap_Used`|The amount of non-heap memory currently used.|int|count|
|`Status_JVM_Threads_Count`|The total number of live threads.|int|count|
|`numRegisteredTaskManagers`|The number of registered task managers.|int|count|
|`numRunningJobs`|The number of running jobs.|int|count|
|`taskSlotsAvailable`|The number of available task slots.|int|count|
|`taskSlotsTotal`|The total number of task slots.|int|count|



### `flink_taskmanager`

- tag


| Tag | Description |
|  ----  | --------|
|`host`|Host name.|
|`tm_id`|Task manager ID.|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`Status_Flink_Memory_Managed_Total`|The total amount of managed memory.|int|count|
|`Status_Flink_Memory_Managed_Used`|The amount of managed memory currently used.|int|count|
|`Status_JVM_CPU_Load`|The recent CPU usage of the JVM.|int|count|
|`Status_JVM_CPU_Time`|The CPU time used by the JVM.|int|count|
|`Status_JVM_ClassLoader_ClassesLoaded`|The total number of classes loaded since the start of the JVM.|int|count|
|`Status_JVM_ClassLoader_ClassesUnloaded`|The total number of classes unloaded since the start of the JVM.|int|count|
|`Status_JVM_GarbageCollector_G1_Old_Generation_Count`|The total number of collections that have occurred.|int|count|
|`Status_JVM_GarbageCollector_G1_Old_Generation_Time`|The total time spent performing garbage collection.|int|count|
|`Status_JVM_GarbageCollector_G1_Young_Generation_Count`|The total number of collections that have occurred.|int|count|
|`Status_JVM_GarbageCollector_G1_Young_Generation_Time`|The total time spent performing garbage collection.|int|count|
|`Status_JVM_Memory_Direct_Count`|The number of buffers in the direct buffer pool.|int|count|
|`Status_JVM_Memory_Direct_MemoryUsed`|The amount of memory used by the JVM for the direct buffer pool.|int|count|
|`Status_JVM_Memory_Direct_TotalCapacity`|The total capacity of all buffers in the direct buffer pool.|int|count|
|`Status_JVM_Memory_Heap_Committed`|The amount of heap memory guaranteed to be available to the JVM.|int|count|
|`Status_JVM_Memory_Heap_Max`|The maximum amount of heap memory that can be used for memory management.|int|count|
|`Status_JVM_Memory_Heap_Used`|The amount of heap memory currently used.|int|count|
|`Status_JVM_Memory_Mapped_Count`|The number of buffers in the mapped buffer pool.|int|count|
|`Status_JVM_Memory_Mapped_MemoryUsed`|The amount of memory used by the JVM for the mapped buffer pool.|int|count|
|`Status_JVM_Memory_Mapped_TotalCapacity`|The number of buffers in the mapped buffer pool.|int|count|
|`Status_JVM_Memory_Metaspace_Committed`|The amount of memory guaranteed to be available to the JVM in the meta-space memory pool (in bytes).|int|count|
|`Status_JVM_Memory_Metaspace_Max`|The maximum amount of memory that can be used in the meta-space memory pool (in bytes).|int|count|
|`Status_JVM_Memory_Metaspace_Used`|Used bytes of a given JVM memory area|int|count|
|`Status_JVM_Memory_NonHeap_Committed`|The amount of non-heap memory guaranteed to be available to the JVM.|int|count|
|`Status_JVM_Memory_NonHeap_Max`|The maximum amount of non-heap memory that can be used for memory management|int|count|
|`Status_JVM_Memory_NonHeap_Used`|The amount of non-heap memory currently used.|int|count|
|`Status_JVM_Threads_Count`|The total number of live threads.|int|count|
|`Status_Network_AvailableMemorySegments`|The number of unused memory segments.|int|count|
|`Status_Network_TotalMemorySegments`|The number of allocated memory segments.|int|count|
|`Status_Shuffle_Netty_AvailableMemory`|The amount of unused memory in bytes.|int|count|
|`Status_Shuffle_Netty_AvailableMemorySegments`|The number of unused memory segments.|int|count|
|`Status_Shuffle_Netty_RequestedMemoryUsage`|Experimental: The usage of the network memory. Shows (as percentage) the total amount of requested memory from all of the subtasks. It can exceed 100% as not all requested memory is required for subtask to make progress. However if usage exceeds 100% throughput can suffer greatly and please consider increasing available network memory, or decreasing configured size of network buffer pools.|int|count|
|`Status_Shuffle_Netty_TotalMemory`|The amount of allocated memory in bytes.|int|count|
|`Status_Shuffle_Netty_TotalMemorySegments`|The number of allocated memory segments.|int|count|
|`Status_Shuffle_Netty_UsedMemory`|The amount of used memory in bytes.|int|count|
|`Status_Shuffle_Netty_UsedMemorySegments`|The number of used memory segments.|int|count|


