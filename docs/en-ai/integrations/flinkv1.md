---
title: 'Flink'
summary: 'Collect metrics data from Flink'
tags:
  - 'Middleware'
__int_icon: 'icon/flink'
dashboard:
  - desc: 'Flink'
    path: 'dashboard/en/flink'
monitor:
  - desc: 'Flink'
    path: 'monitor/en/flink'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

The Flink collector can gather many metrics from Flink instances, such as the status of Flink servers and network conditions, among others, and send these metrics to Guance to help you monitor and analyze various anomalies in Flink.

## Configuration {#config}

### Prerequisites {#requirements}

> Note: The example Flink version is Flink 1.14.2 (CentOS), and different versions may have varying metrics.

Currently, Flink officially provides two ways to report metrics: [Prometheus](https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/deployment/metric_reporters/#prometheus){:target="_blank"} and [Prometheus PushGateway](https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/deployment/metric_reporters/#prometheuspushgateway){:target="_blank"}. The main differences are:

- The Prometheus PushGateway method reports all cluster metrics to a single PushGateway, so additional installation of PushGateway is required.
- The Prometheus method requires each node in the cluster to expose a unique port, with no need for extra software installation but needing N available ports, making configuration slightly more complex.

### PrometheusPushGateway Method (Recommended) {#push-gateway}

- Download and install: You can download PushGateway from the [Prometheus official page](https://prometheus.io/download/#pushgateway){:target="_blank"}.

Start PushGateway: (This command is for reference only; actual commands may vary based on your environment)

```shell
nohup ./pushgateway &
```

- Configure `flink-conf.yaml` to report metrics to PushGateway

Example configuration for Flink's configuration file `conf/flink-conf.yaml`:

```bash
metrics.reporter.promgateway.class: org.apache.flink.metrics.prometheus.PrometheusPushGatewayReporter # This value is fixed and cannot be changed
metrics.reporter.promgateway.host: localhost # IP address of promgateway
metrics.reporter.promgateway.port: 9091 # Listening port of promgateway
metrics.reporter.promgateway.interval: 15 SECONDS # Collection interval
metrics.reporter.promgateway.groupingKey: k1=v1;k2=v2

# Optional parameters
# metrics.reporter.promgateway.jobName: myJob
# metrics.reporter.promgateway.randomJobNameSuffix: true
# metrics.reporter.promgateway.deleteOnShutdown: false
```

Start Flink: `./bin/start-cluster.sh` (This command is for reference only; actual commands may vary based on your environment)

### Prometheus Method {#prometheus}

- Configure `flink-conf.yaml` to expose metrics on each node. Example configuration for Flink's configuration file `conf/flink-conf.yaml`:

```bash
metrics.reporter.prom.class: org.apache.flink.metrics.prometheus.PrometheusReporter
metrics.reporter.prom.port: 9250-9260 # Port range for each node, which varies depending on the number of nodes, one port per node
```

- Start Flink: `./bin/start-cluster.sh` (This command is for reference only; actual commands may vary based on your environment)
- For hosts that can access the Internet, [install Datakit](https://www.yuque.com/dataflux/datakit/datakit-install){:target="_blank"}
- Modify the Flink configuration by adding the following content to enable Prometheus collection

```bash
metrics.reporter.prom.class: org.apache.flink.metrics.prometheus.PrometheusReporter
metrics.reporter.prom.port: 9250-9260
```

> Note: Set `metrics.reporter.prom.port` based on the number of `jobmanager` and `taskmanager` in your cluster

- Restart the Flink cluster to apply the configuration
- Run `curl http://{Flink IP}:9250-9260` to check if it returns results normally before starting the collection

## Metrics {#metric}

By default, Flink collects multiple metrics, which provide deep insights into the current state. These [metrics](https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/ops/metrics/#system-metrics){:target="_blank"} offer detailed information.



### `flink_jobmanager`

- Tags


| Tag | Description |
| ---- | --------|
|`host`|Host name.|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`Status_JVM_CPU_Load`|Recent CPU usage of the JVM.|int|count|
|`Status_JVM_CPU_Time`|CPU time used by the JVM.|int|count|
|`Status_JVM_ClassLoader_ClassesLoaded`|Total number of classes loaded since the start of the JVM.|int|count|
|`Status_JVM_ClassLoader_ClassesUnloaded`|Total number of classes unloaded since the start of the JVM.|int|count|
|`Status_JVM_GarbageCollector_Copy_Count`|Total number of garbage collections performed.|int|count|
|`Status_JVM_GarbageCollector_Copy_Time`|Total time spent performing garbage collection.|int|count|
|`Status_JVM_GarbageCollector_G1_Old_Generation_Count`|Total number of garbage collections performed.|int|count|
|`Status_JVM_GarbageCollector_G1_Old_Generation_Time`|Total time spent performing garbage collection.|int|count|
|`Status_JVM_GarbageCollector_G1_Young_Generation_Count`|Total number of garbage collections performed.|int|count|
|`Status_JVM_GarbageCollector_G1_Young_Generation_Time`|Total time spent performing garbage collection.|int|count|
|`Status_JVM_GarbageCollector_MarkSweepCompact_Count`|Total number of garbage collections performed.|int|count|
|`Status_JVM_GarbageCollector_MarkSweepCompact_Time`|Total time spent performing garbage collection.|int|count|
|`Status_JVM_Memory_Direct_Count`|Number of buffers in the direct buffer pool.|int|count|
|`Status_JVM_Memory_Direct_MemoryUsed`|Amount of memory used by the JVM for the direct buffer pool.|int|count|
|`Status_JVM_Memory_Direct_TotalCapacity`|Total capacity of all buffers in the direct buffer pool.|int|count|
|`Status_JVM_Memory_Heap_Committed`|Amount of heap memory guaranteed to be available to the JVM.|int|count|
|`Status_JVM_Memory_Heap_Max`|Maximum amount of heap memory that can be used for memory management.|int|count|
|`Status_JVM_Memory_Heap_Used`|Amount of heap memory currently used.|int|count|
|`Status_JVM_Memory_Mapped_Count`|Number of buffers in the mapped buffer pool.|int|count|
|`Status_JVM_Memory_Mapped_MemoryUsed`|Amount of memory used by the JVM for the mapped buffer pool.|int|count|
|`Status_JVM_Memory_Mapped_TotalCapacity`|Number of buffers in the mapped buffer pool.|int|count|
|`Status_JVM_Memory_Metaspace_Committed`|Amount of memory guaranteed to be available to the JVM in the meta-space memory pool (in bytes).|int|count|
|`Status_JVM_Memory_Metaspace_Max`|Maximum amount of memory that can be used in the meta-space memory pool (in bytes).|int|count|
|`Status_JVM_Memory_Metaspace_Used`|Used bytes of a given JVM memory area|int|count|
|`Status_JVM_Memory_NonHeap_Committed`|Amount of non-heap memory guaranteed to be available to the JVM.|int|count|
|`Status_JVM_Memory_NonHeap_Max`|Maximum amount of non-heap memory that can be used for memory management|int|count|
|`Status_JVM_Memory_NonHeap_Used`|Amount of non-heap memory currently used.|int|count|
|`Status_JVM_Threads_Count`|Total number of live threads.|int|count|
|`numRegisteredTaskManagers`|Number of registered task managers.|int|count|
|`numRunningJobs`|Number of running jobs.|int|count|
|`taskSlotsAvailable`|Number of available task slots.|int|count|
|`taskSlotsTotal`|Total number of task slots.|int|count|



### `flink_taskmanager`

- Tags


| Tag | Description |
| ---- | --------|
|`host`|Host name.|
|`tm_id`|Task manager ID.|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`Status_Flink_Memory_Managed_Total`|Total amount of managed memory.|int|count|
|`Status_Flink_Memory_Managed_Used`|Amount of managed memory currently used.|int|count|
|`Status_JVM_CPU_Load`|Recent CPU usage of the JVM.|int|count|
|`Status_JVM_CPU_Time`|CPU time used by the JVM.|int|count|
|`Status_JVM_ClassLoader_ClassesLoaded`|Total number of classes loaded since the start of the JVM.|int|count|
|`Status_JVM_ClassLoader_ClassesUnloaded`|Total number of classes unloaded since the start of the JVM.|int|count|
|`Status_JVM_GarbageCollector_G1_Old_Generation_Count`|Total number of garbage collections performed.|int|count|
|`Status_JVM_GarbageCollector_G1_Old_Generation_Time`|Total time spent performing garbage collection.|int|count|
|`Status_JVM_GarbageCollector_G1_Young_Generation_Count`|Total number of garbage collections performed.|int|count|
|`Status_JVM_GarbageCollector_G1_Young_Generation_Time`|Total time spent performing garbage collection.|int|count|
|`Status_JVM_Memory_Direct_Count`|Number of buffers in the direct buffer pool.|int|count|
|`Status_JVM_Memory_Direct_MemoryUsed`|Amount of memory used by the JVM for the direct buffer pool.|int|count|
|`Status_JVM_Memory_Direct_TotalCapacity`|Total capacity of all buffers in the direct buffer pool.|int|count|
|`Status_JVM_Memory_Heap_Committed`|Amount of heap memory guaranteed to be available to the JVM.|int|count|
|`Status_JVM_Memory_Heap_Max`|Maximum amount of heap memory that can be used for memory management.|int|count|
|`Status_JVM_Memory_Heap_Used`|Amount of heap memory currently used.|int|count|
|`Status_JVM_Memory_Mapped_Count`|Number of buffers in the mapped buffer pool.|int|count|
|`Status_JVM_Memory_Mapped_MemoryUsed`|Amount of memory used by the JVM for the mapped buffer pool.|int|count|
|`Status_JVM_Memory_Mapped_TotalCapacity`|Number of buffers in the mapped buffer pool.|int|count|
|`Status_JVM_Memory_Metaspace_Committed`|Amount of memory guaranteed to be available to the JVM in the meta-space memory pool (in bytes).|int|count|
|`Status_JVM_Memory_Metaspace_Max`|Maximum amount of memory that can be used in the meta-space memory pool (in bytes).|int|count|
|`Status_JVM_Memory_Metaspace_Used`|Used bytes of a given JVM memory area|int|count|
|`Status_JVM_Memory_NonHeap_Committed`|Amount of non-heap memory guaranteed to be available to the JVM.|int|count|
|`Status_JVM_Memory_NonHeap_Max`|Maximum amount of non-heap memory that can be used for memory management|int|count|
|`Status_JVM_Memory_NonHeap_Used`|Amount of non-heap memory currently used.|int|count|
|`Status_JVM_Threads_Count`|Total number of live threads.|int|count|
|`Status_Network_AvailableMemorySegments`|Number of unused memory segments.|int|count|
|`Status_Network_TotalMemorySegments`|Number of allocated memory segments.|int|count|
|`Status_Shuffle_Netty_AvailableMemory`|Amount of unused memory in bytes.|int|count|
|`Status_Shuffle_Netty_AvailableMemorySegments`|Number of unused memory segments.|int|count|
|`Status_Shuffle_Netty_RequestedMemoryUsage`|Experimental: Usage of the network memory. Shows (as percentage) the total amount of requested memory from all of the subtasks. It can exceed 100% as not all requested memory is required for subtask to make progress. However, if usage exceeds 100%, throughput can suffer greatly, and please consider increasing available network memory or decreasing configured size of network buffer pools.|int|count|
|`Status_Shuffle_Netty_TotalMemory`|Amount of allocated memory in bytes.|int|count|
|`Status_Shuffle_Netty_TotalMemorySegments`|Number of allocated memory segments.|int|count|
|`Status_Shuffle_Netty_UsedMemory`|Amount of used memory in bytes.|int|count|
|`Status_Shuffle_Netty_UsedMemorySegments`|Number of used memory segments.|int|count|
|`Status_Shuffle_Netty_UsedMemorySegments`|Number of used memory segments.|int|count|
|`Status_Shuffle_Netty_UsedMemorySegments`|Number of used memory segments.|int|count|
|`Status_Shuffle_Netty_UsedMemorySegments`|Number of used memory segments.|int|count|
|`Status_Shuffle_Netty_UsedMemorySegments`|Number of used memory segments.|int|count|
|`Status_Shuffle_Netty_UsedMemorySegments`|Number of used memory segments.|int|count|
|`Status_Shuffle_Netty_UsedMemorySegments`|Number of used memory segments.|int|count|
|`Status_Shuffle_Netty_UsedMemorySegments`|Number of used memory segments.|int|count|
|`Status_Shuffle_Netty_UsedMemorySegments`|Number of used memory segments.|int|count|
|`Status_Shuffle_Netty_UsedMemorySegments`|Number of used memory segments.|int|count|
|`Status_Shuffle_Netty_UsedMemorySegments`|Number of used memory segments.|int|count|

(Note: The last section appears to have duplicate entries for `Status_Shuffle_Netty_UsedMemorySegments`. This might be an error in the original document.)