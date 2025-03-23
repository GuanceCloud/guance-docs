---
title     : 'Trino'
summary   : 'Collect Trino Metrics information'
__int_icon: 'icon/trino'
dashboard :
  - desc  : 'Trino Monitoring View'
    path  : 'dashboard/en/trino'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# `Trino`
<!-- markdownlint-enable -->

Collect `Trino` Metrics information.


## Installation Configuration {#config}

`Trino` is an application written in the Java LANGUAGE, and its Metrics information can be obtained through the jmx method.

JMX Exporter is an open-source tool used to export JMX (Java Management Extensions) metrics from Java applications into Prometheus-formatted measurement data.

By using the JMX Exporter to obtain `Trino` Metrics information, and enabling DataKit’s prom collector to collect jmx Metrics information.

### Download JMX Exporter

Download address [https://github.com/prometheus/jmx_exporter/releases](https://github.com/prometheus/jmx_exporter/releases)

### Coordinator Node

`coordinator` is a type of Server in `Trino`, responsible for parsing statements, query planning, and managing workers.

- Write `jmx_config.yaml`

```yaml
rules:
- pattern: ".*"
```

- Adjust the startup command

```shell
...
-javaagent:/opt/apache/trino/lib/jmx_prometheus_javaagent-0.19.0.jar=3900:/opt/apache/trino/etc/jmx_config.yaml \
-Dnode.environment=test \
-Dnode.id=trino-coordinator \
...
```

Here, `3900` is the port exposed externally. After starting, you can access Metrics information via `http://localhost:3900`.


### DataKit Collector Configuration

Since `Trino` can directly expose `metrics` url through JMX Exporter, it can be collected directly via the [`prom`](./prom.md) collector.

Perform the following steps:

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

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations should be adjusted as needed*</font>
<!-- markdownlint-enable -->
, Parameter adjustment description:

<!-- markdownlint-disable MD004 -->
- urls: The `prometheus` Metrics address; fill in the Metrics url exposed by the corresponding component here.
- source: Alias for the collector; differentiation is recommended.
- interval: Collection interval

<!-- markdownlint-enable -->
### Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

### Metrics Set `Trino`

| Metric | Description |
| -- | -- |
| `memory_ClusterMemoryPool_Nodes` | Number of cluster nodes |
| `memory_ClusterMemoryPool_BlockedNodes`  | Nodes blocked in the memory cluster memory pool |
| `memory_ClusterMemoryPool_FreeDistributedBytes`  | Unallocated available memory in the cluster memory pool |
| `memory_ClusterMemoryPool_TotalDistributedBytes`  | Total memory in the cluster memory |
| `memory_ClusterMemoryPool_ReservedDistributedBytes`  | Unallocated available memory in the cluster memory pool |
| `memory_ClusterMemoryManager_ClusterMemoryBytes`  | Cluster memory size |
| `memory_ClusterMemoryManager_QueriesKilledDueToOutOfMemory`  | Total number of queries killed due to out-of-memory |
| `execution_QueryManager_RunningQueries`  | Number of currently running queries |
| `execution_QueryManager_QueuedQueries`  | Number of queries waiting to be executed |
| `execution_QueryManager_SubmittedQueries_OneMinute_Count`  | Number of queries submitted per minute |
| `execution_QueryManager_CompletedQueries_OneMinute_Count`  | Number of queries completed per minute |
| `execution_QueryManager_CompletedQueries_TotalCount`  | Total number of queries completed |
| `execution_QueryManager_FailedQueries_OneMinute_Count`  | Number of failed queries per minute |
| `execution_QueryManager_FailedQueries_FiveMinute_Count`  | Number of failed queries in 5 minutes |
| `execution_QueryManager_UserErrorFailures_OneMinute_Count`  | Number of failed queries due to exceptions per minute |
| `execution_QueryManager_UserErrorFailures_FiveMinute_Count`  | Number of failed queries due to exceptions in 5 minutes |
| `execution_QueryManager_UserErrorFailures_TotalCount`  | Total number of failed queries due to exceptions |
| `execution_QueryManager_InternalFailures_OneMinute_Count`  | Number of failed queries due to internal service exceptions per minute |
| `execution_QueryManager_InternalFailures_FiveMinute_Count`  | Number of failed queries due to internal service exceptions in 5 minutes |
| `execution_QueryManager_InternalFailures_TotalCount`  | Total number of failed queries due to internal service exceptions |
| `execution_SqlTaskManager_InputDataSize_OneMinute_Count`  | Task input data volume per minute |
| `execution_SqlTaskManager_InputDataSize_FiveMinute_Count`  | Task input data volume in 5 minutes |
| `execution_SqlTaskManager_InputDataSize_TotalCount`  | Task input data volume |
| `execution_SqlTaskManager_InputPositions_OneMinute_Count`  | Task input data row count per minute |
| `execution_SqlTaskManager_InputPositions_FiveMinute_Count`  | Task input data row count in 5 minutes |
| `execution_SqlTaskManager_InputPositions_TotalCount`  | Total task input data row count |
| `execution_SqlTaskManager_OutputDataSize_OneMinute_Count`  | Task output data volume per minute |
| `execution_SqlTaskManager_OutputDataSize_FiveMinute_Count`  | Task output data volume in 5 minutes |
| `execution_SqlTaskManager_OutputDataSize_TotalCount`  | Task output data volume |
| `execution_SqlTaskManager_OutputPositions_OneMinute_Count`  | Task output data row count per minute |
| `execution_SqlTaskManager_OutputPositions_FiveMinute_Count`  | Task output data row count in 5 minutes |
| `execution_SqlTaskManager_OutputPositions_TotalCount`  | Total task output data row count |
| `execution_SqlTaskManager_FailedTasks_OneMinute_Count`  | Number of failed tasks per minute |
| `execution_SqlTaskManager_FailedTasks_FiveMinute_Count`  | Number of failed tasks in 5 minutes |
| `execution_SqlTaskManager_FailedTasks_TotalCount`  | Total task output data row count |
| `execution_executor_TaskExecutor_Tasks` | Total number of tasks registered with the task executor |
| `execution_executor_TaskExecutor_TotalSplits` | Total splits in the task executor |
| `execution_executor_TaskExecutor_RunningSplits` | Running splits in the task executor |
| `execution_executor_TaskExecutor_WaitingSplits` | Waiting splits in the task executor |
| `memory_ClusterMemoryManager_TotalAvailableProcessors` | Total cluster CPU count |

### Metrics Set Java

| Metric | Description |
| --  | -- |
| `lang_Runtime_Uptime`  | Uptime |
| `lang_G1_Concurrent_GC_CollectionCount`  | GC count |
| `lang_Memory_HeapMemoryUsage_used`  | Used heap memory |
| `lang_Memory_HeapMemoryUsage_init`  | Initial heap memory |
| `lang_Memory_HeapMemoryUsage_max`  | Maximum heap memory |
| `lang_Memory_HeapMemoryUsage_committed`  | Committed heap memory |
| `lang_Memory_NonHeapMemoryUsage_used`  | Used non-heap memory |
| `lang_Memory_NonHeapMemoryUsage_init`  | Initial non-heap memory |
| `lang_Memory_NonHeapMemoryUsage_max`  | Maximum non-heap memory |
| `lang_Memory_NonHeapMemoryUsage_committed`  | Committed non-heap memory |