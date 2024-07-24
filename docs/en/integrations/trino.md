---
title     : 'Trino'
summary   : 'Collect Trino metrics information'
__int_icon: 'icon/trino'
dashboard :
  - desc  : 'Trino'
    path  : 'dashboard/zh/trino'
monitor   :
  - desc  : 'No'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# `Trino`
<!-- markdownlint-enable -->

Collect `Trino` metrics information.


## Configuration {#config}

`Trino` is an application written in Java language that can obtain metrics information through jmx.

JMX Exporter is an open-source tool used to export JMX (Java Management Extension) metrics for Java applications into Prometheus format metric data.

Obtain `Trino` metrics information through JMX Exporter, and collect jmx metrics information by opening DataKit's prom collector.

### Download JMX Exporter

Download url [https://github.com/prometheus/jmx_exporter/releases](https://github.com/prometheus/jmx_exporter/releases)

### Coordinator Node

`coordinator` is a type of server called `Trino`, responsible for parsing statements, querying plans, and managing workers.

- Add `jmx_config.yaml`

```yaml
rules:
- pattern: ".*"
```

- Adjust startup command

```shell
...
-javaagent:/opt/apache/trino/lib/jmx_prometheus_javaagent-0.19.0.jar=3900:/opt/apache/trino/etc/jmx_config.yaml \
-Dnode.environment=test \
-Dnode.id=trino-coordinator \
...
```

Among them, `3900` is an exposed port that can be accessed through the `http://localhost:3900`  Obtain metrics information.

### DataKit Collector

Due to the fact that `Trino` can directly expose the `metrics` URL through JMX Exporter, it can be collected directly through the [`prom`](./prom.md) collector.

Perform the following actions:

```shell
cd datakit/conf.d/prom
cp prom.conf.sample trino.conf
```

Adjust the content of `trino.conf` as follows:

```toml

  urls = ["http://localhost:3900"]

  source = "trino"

  [inputs.prom.tags]
    component="trino"
  interval = "10s"

```

<font color="red">*Note that the marker needs to be adjusted*</font>


Description of main parameters:

- urls: `trino` Metric address, where you fill in the metric URL exposed by the corresponding component
- source: Collector alias, recommended to distinguish
- interval: collection interval
- measurement_prefix: Metric set prefix for easy management of classification

<!-- markdownlint-enable -->
### Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metric {#metric}

### MetricSets Trino

| Metric | Description |
| -- | -- |
| `memory_ClusterMemoryPool_Nodes` | Number of cluster nodes |
| `memory_ClusterMemoryPool_BlockedNodes`  | Nodes blocked by memory cluster and memory pool |
| `memory_ClusterMemoryPool_FreeDistributedBytes`  | Free available memory in cluster memory pool |
| `memory_ClusterMemoryPool_TotalDistributedBytes`  | Total memory in cluster memory |
| `memory_ClusterMemoryPool_ReservedDistributedBytes`  |Unallocated available memory in cluster memory pool |
| `memory_ClusterMemoryManager_ClusterMemoryBytes`  | Cluster memory size |
| `memory_ClusterMemoryManager_QueriesKilledDueToOutOfMemory`  | The total number of queries for oom killed|
| `execution_QueryManager_RunningQueries`  | The current number of running queries |
| `execution_QueryManager_QueuedQueries`  | The number of queries waiting to be executed |
| `execution_QueryManager_SubmittedQueries_OneMinute_Count`  | Number of queries submitted per minute |
| `execution_QueryManager_CompletedQueries_OneMinute_Count`  | Number of completed queries per minute |
| `execution_QueryManager_CompletedQueries_TotalCount`  | Total number of completed queries |
| `execution_QueryManager_FailedQueries_OneMinute_Count`  | Number of failed queries per minute |
| `execution_QueryManager_FailedQueries_FiveMinute_Count`  | Number of queries that failed within 5 minutes |
| `execution_QueryManager_UserErrorFailures_OneMinute_Count`  | Number of failed queries caused by exceptions per minute |
| `execution_QueryManager_UserErrorFailures_FiveMinute_Count`  | Number of failed queries caused by 5-minute exceptions |
| `execution_QueryManager_UserErrorFailures_TotalCount`  | The total number of failed queries caused by exceptions |
| `execution_QueryManager_InternalFailures_OneMinute_Count`  | The number of failed queries caused by internal service exceptions per minute |
| `execution_QueryManager_InternalFailures_TotalCount`  | The total number of failed queries caused by internal service exceptions |
| `execution_SqlTaskManager_InputDataSize_OneMinute_Count`  | Task input data volume per minute |
| `execution_SqlTaskManager_InputDataSize_TotalCount`  | Task input data volume|
| `execution_SqlTaskManager_InputPositions_OneMinute_Count`  | Number of input data rows per minute for Task|
| `execution_SqlTaskManager_InputPositions_TotalCount`  | Total number of input data rows for Task|
| `execution_SqlTaskManager_OutputDataSize_OneMinute_Count`  | Task output data volume per minute |
| `execution_SqlTaskManager_OutputDataSize_TotalCount`  | Task output data volume|
| `execution_SqlTaskManager_OutputPositions_OneMinute_Count`  | Number of output data rows per minute for Task|
| `execution_SqlTaskManager_OutputPositions_FiveMinute_Count`  | 5-minute Task output data rows|
| `execution_SqlTaskManager_OutputPositions_TotalCount`  | Total number of output data rows for Task|
| `execution_SqlTaskManager_FailedTasks_OneMinute_Count`  | Number of failed tasks per minute|
| `execution_SqlTaskManager_FailedTasks_FiveMinute_Count`  | Number of Tasks Failed in 5 Minutes|
| `execution_SqlTaskManager_FailedTasks_TotalCount`  | Total number of output data rows for Task|
|`execution_executor_TaskExecutor_Tasks`|The number of all tasks registered with the task executor|
|`execution_executor_TaskExecutor_TotalSplits`|Total number of splits for task executors|
|`execution_executor_TaskExecutor_RunningSplits`|The number of splits run by the task executor|
|`execution_executor_TaskExecutor_WaitingSplits`|The number of splits waiting on the task executor|
|`memory_ClusterMemoryManager_TotalAvailableProcessors`| Cluster CPU count |

### MetricSets Java

| Metric | Description |
| --  | -- |
| `lang_Runtime_Uptime`  | Online duration |
| `lang_G1_Concurrent_GC_CollectionCount`  | gc count |
| `lang_Memory_HeapMemoryUsage_used`  | Heap used memory |
| `lang_Memory_HeapMemoryUsage_init`  | Heap initial memory |
| `lang_Memory_HeapMemoryUsage_max`  | Maximum heap memory |
| `lang_Memory_HeapMemoryUsage_committed`  | Heap has committed memory |
| `lang_Memory_NonHeapMemoryUsage_used`  | NonHeap used memory |
| `lang_Memory_NonHeapMemoryUsage_init`  | NonHeap initial memory |
| `lang_Memory_NonHeapMemoryUsage_max`  | Maximum NonHeap memory |
| `lang_Memory_NonHeapMemoryUsage_committed`  | NonHeap has committed memory |
