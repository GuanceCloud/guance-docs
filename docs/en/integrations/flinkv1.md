---
title     : 'Flink'
summary   : 'Collect metrics data from Flink'
tags:
  - 'MIDDLEWARE'
__int_icon      : 'icon/flink'
dashboard :
  - desc  : 'Flink'
    path  : 'dashboard/en/flink'
monitor   :
  - desc  : 'Flink'
    path  : 'monitor/en/flink'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

The Flink collector can gather many metrics from Flink instances, such as the status of Flink servers and network states among various metrics, and collect them into <<< custom_key.brand_name >>> to help you monitor and analyze various abnormal situations in Flink.

## Configuration {#config}

### Prerequisites {#requirements}

> Note: The example Flink version is Flink 1.14.2 (CentOS). Metrics may vary across different versions.

Currently, Flink officially provides two metrics reporting methods: [Prometheus](https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/deployment/metric_reporters/#prometheus){:target="_blank"} and [Prometheus PushGateway](https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/deployment/metric_reporters/#prometheuspushgateway){:target="_blank"}. The main differences between them are:

- The Prometheus PushGateway method reports all cluster metrics uniformly to PushGateway, so additional installation of PushGateway is required.
- The Prometheus method requires each node in the cluster to expose a unique port, without needing any additional software installation, but requires N available ports, making configuration slightly more complex.

### PrometheusPushGateway Method (Recommended) {#push-gateway}

- Download and install: PushGateWay can be downloaded from the [Prometheus official page](https://prometheus.io/download/#pushgateway){:target="_blank"}.

Start Push Gateway: (This command is for reference only; the specific command may vary depending on your actual environment)

```shell
nohup ./pushgateway &
```

- Configure `flink-conf.yaml` to report metrics uniformly to PushGateway

Example configuration for Flink's configuration file `conf/flink-conf.yaml`:

```bash
metrics.reporter.promgateway.class: org.apache.flink.metrics.prometheus.PrometheusPushGatewayReporter # This value is fixed and cannot be changed
metrics.reporter.promgateway.host: localhost # IP address of promgateway
metrics.reporter.promgateway.port: 9091 # Listening port of promgateway
metrics.reporter.promgateway.interval: 15 SECONDS # Collection interval
metrics.reporter.promgateway.groupingKey: k1=v1;k2=v2

# Below are optional parameters
# metrics.reporter.promgateway.jobName: myJob
# metrics.reporter.promgateway.randomJobNameSuffix: true
# metrics.reporter.promgateway.deleteOnShutdown: false
```

Start Flink: `./bin/start-cluster.sh` (This command is for reference only; the specific command may vary depending on your actual environment)

### Prometheus Method {#prometheus}

- Configure `flink-conf.yaml` to expose metrics for each node. Example configuration for Flink's configuration file `conf/flink-conf.yaml`:

```bash
metrics.reporter.prom.class: org.apache.flink.metrics.prometheus.PrometheusReporter
metrics.reporter.prom.port: 9250-9260 # Port range for each node, which varies depending on the number of nodes, one port corresponds to one node
```

- Start Flink: `./bin/start-cluster.sh` (This command is for reference only; the specific command may vary depending on your actual environment)
- Host with external network access<[Install Datakit](https://www.yuque.com/dataflux/datakit/datakit-install){:target="_blank"}>
- Modify the Flink configuration by adding the following content to enable Prometheus collection

```bash
metrics.reporter.prom.class: org.apache.flink.metrics.prometheus.PrometheusReporter
metrics.reporter.prom.port: 9250-9260
```

> Note: Please set `metrics.reporter.prom.port` based on the number of `jobmanager` and `taskmanager` in the cluster

- Restart the Flink cluster to apply the configuration
- Run `curl http://{Flink iP}:9250-9260` and if it returns results normally, you can start collecting

## Metrics {#metric}

By default, Flink collects multiple metrics, which provide deep insights into the current state. These [metrics](https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/ops/metrics/#system-metrics){:target="_blank"} offer detailed information.



### `flink_jobmanager`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|Host name.|

- Metric List


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

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|Host name.|
|`tm_id`|Task manager ID.|

- Metric List


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