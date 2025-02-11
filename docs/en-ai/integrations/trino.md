---
title     : 'Trino'
summary   : 'Collect Trino Metrics information'
__int_icon: 'icon/trino'
dashboard :
  - desc  : 'Trino Monitoring View'
    path  : 'dashboard/en/trino'
monitor   :
  - desc  : 'None'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# `Trino`
<!-- markdownlint-enable -->

Collect `Trino` Metrics information.


## Installation and Configuration {#config}

`Trino` is a Java application that can expose Metrics information via JMX.

JMX Exporter is an open-source tool used to export JMX (Java Management Extensions) metrics from Java applications into Prometheus format.

By using JMX Exporter, you can obtain `Trino` Metrics information and collect JMX metrics by enabling DataKit's prometheus collector.

### Download JMX Exporter

Download link: [https://github.com/prometheus/jmx_exporter/releases](https://github.com/prometheus/jmx_exporter/releases)

### Coordinator Node

The `coordinator` is a type of server in `Trino`, responsible for parsing statements, query planning, and managing workers.

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

Here, `3900` is the exposed port. After starting, you can access the metrics information via `http://localhost:3900`.

### DataKit Collector Configuration

Since `Trino` can directly expose the `metrics` URL through JMX Exporter, it can be collected directly using the [`prom`](./prom.md) collector.

Perform the following operations:

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
Parameter adjustment explanation:

<!-- markdownlint-disable MD004 -->
- urls: The Prometheus metrics URL, fill in the metrics URL exposed by the corresponding component.
- source: Alias for the collector, it is recommended to differentiate.
- interval: Collection interval.

<!-- markdownlint-enable -->
### Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

### Metrics Set `Trino`

| Metric | Description |
| --- | --- |
| `memory_ClusterMemoryPool_Nodes` | Number of cluster nodes |
| `memory_ClusterMemoryPool_BlockedNodes` | Nodes blocked in the cluster memory pool |
| `memory_ClusterMemoryPool_FreeDistributedBytes` | Unallocated available memory in the cluster memory pool |
| `memory_ClusterMemoryPool_TotalDistributedBytes` | Total memory in the cluster |
| `memory_ClusterMemoryPool_ReservedDistributedBytes` | Reserved distributed bytes in the cluster memory pool |
| `memory_ClusterMemoryManager_ClusterMemoryBytes` | Cluster memory size |
| `memory_ClusterMemoryManager_QueriesKilledDueToOutOfMemory` | Total number of queries killed due to out-of-memory |
| `execution_QueryManager_RunningQueries` | Number of currently running queries |
| `execution_QueryManager_QueuedQueries` | Number of queued queries waiting to be executed |
| `execution_QueryManager_SubmittedQueries_OneMinute_Count` | Number of queries submitted per minute |
| `execution_QueryManager_CompletedQueries_OneMinute_Count` | Number of queries completed per minute |
| `execution_QueryManager_CompletedQueries_TotalCount` | Total number of completed queries |
| `execution_QueryManager_FailedQueries_OneMinute_Count` | Number of failed queries per minute |
| `execution_QueryManager_FailedQueries_FiveMinute_Count` | Number of failed queries in the last 5 minutes |
| `execution_QueryManager_UserErrorFailures_OneMinute_Count` | Number of user error failures per minute |
| `execution_QueryManager_UserErrorFailures_FiveMinute_Count` | Number of user error failures in the last 5 minutes |
| `execution_QueryManager_UserErrorFailures_TotalCount` | Total number of user error failures |
| `execution_QueryManager_InternalFailures_OneMinute_Count` | Number of internal failures per minute |
| `execution_QueryManager_InternalFailures_FiveMinute_Count` | Number of internal failures in the last 5 minutes |
| `execution_QueryManager_InternalFailures_TotalCount` | Total number of internal failures |
| `execution_SqlTaskManager_InputDataSize_OneMinute_Count` | Input data size per minute |
| `execution_SqlTaskManager_InputDataSize_FiveMinute_Count` | Input data size in the last 5 minutes |
| `execution_SqlTaskManager_InputDataSize_TotalCount` | Total input data size |
| `execution_SqlTaskManager_InputPositions_OneMinute_Count` | Number of input rows per minute |
| `execution_SqlTaskManager_InputPositions_FiveMinute_Count` | Number of input rows in the last 5 minutes |
| `execution_SqlTaskManager_InputPositions_TotalCount` | Total number of input rows |
| `execution_SqlTaskManager_OutputDataSize_OneMinute_Count` | Output data size per minute |
| `execution_SqlTaskManager_OutputDataSize_FiveMinute_Count` | Output data size in the last 5 minutes |
| `execution_SqlTaskManager_OutputDataSize_TotalCount` | Total output data size |
| `execution_SqlTaskManager_OutputPositions_OneMinute_Count` | Number of output rows per minute |
| `execution_SqlTaskManager_OutputPositions_FiveMinute_Count` | Number of output rows in the last 5 minutes |
| `execution_SqlTaskManager_OutputPositions_TotalCount` | Total number of output rows |
| `execution_SqlTaskManager_FailedTasks_OneMinute_Count` | Number of failed tasks per minute |
| `execution_SqlTaskManager_FailedTasks_FiveMinute_Count` | Number of failed tasks in the last 5 minutes |
| `execution_SqlTaskManager_FailedTasks_TotalCount` | Total number of failed tasks |
| `execution_executor_TaskExecutor_Tasks` | Number of all registered tasks in the task executor |
| `execution_executor_TaskExecutor_TotalSplits` | Total number of splits in the task executor |
| `execution_executor_TaskExecutor_RunningSplits` | Number of running splits in the task executor |
| `execution_executor_TaskExecutor_WaitingSplits` | Number of waiting splits in the task executor |
| `memory_ClusterMemoryManager_TotalAvailableProcessors` | Total number of processors in the cluster |

### Metrics Set Java

| Metric | Description |
| --- | --- |
| `lang_Runtime_Uptime` | Uptime |
| `lang_G1_Concurrent_GC_CollectionCount` | GC collection count |
| `lang_Memory_HeapMemoryUsage_used` | Used heap memory |
| `lang_Memory_HeapMemoryUsage_init` | Initial heap memory |
| `lang_Memory_HeapMemoryUsage_max` | Maximum heap memory |
| `lang_Memory_HeapMemoryUsage_committed` | Committed heap memory |
| `lang_Memory_NonHeapMemoryUsage_used` | Used non-heap memory |
| `lang_Memory_NonHeapMemoryUsage_init` | Initial non-heap memory |
| `lang_Memory_NonHeapMemoryUsage_max` | Maximum non-heap memory |
| `lang_Memory_NonHeapMemoryUsage_committed` | Committed non-heap memory |