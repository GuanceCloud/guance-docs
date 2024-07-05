---
title     : 'Trino'
summary   : '采集 Trino 指标信息'
__int_icon: 'icon/trino'
dashboard :
  - desc  : 'Trino 监控视图'
    path  : 'dashboard/zh/trino'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# `Trino`
<!-- markdownlint-enable -->

采集 `Trino` 指标信息。


## 安装配置 {#config}

`Trino` 是 Java 语言编写的应用，可以通过 jmx 方式获取到指标信息。

JMX Exporter 是一个用于将 Java 应用程序的 JMX（Java Management Extensions）指标导出为 Prometheus 格式的度量数据的开源工具。

通过 JMX Exporter 获取 `Trino` 指标信息，并通过开启 DataKit 的 prom 采集器采集 jmx 指标信息。

### 下载 JMX Exporter

下载地址 [https://github.com/prometheus/jmx_exporter/releases](https://github.com/prometheus/jmx_exporter/releases)

### Coordinator 节点

`coordinator` 是 `Trino` 一种 Server 类型，负责解析语句，查询计划和管理 worker。

- 编写 `jmx_config.yaml`

```yaml
rules:
- pattern: ".*"
```

- 调整启动命令

```shell
...
-javaagent:/opt/apache/trino/lib/jmx_prometheus_javaagent-0.19.0.jar=3900:/opt/apache/trino/etc/jmx_config.yaml \
-Dnode.environment=test \
-Dnode.id=trino-coordinator \
...
```

其中 `3900` 是对外暴露的端口，启动后，可以通过`http://localhost:3900` 获取指标信息。


### DataKit 采集器配置

由于`Trino`通过 JMX Exporter 能够直接暴露`metrics` url，所以可以直接通过[`prom`](./prom.md)采集器进行采集。

执行以下操作：

```shell
cd datakit/conf.d/prom
cp prom.conf.sample trino.conf
```

调整`trino.conf`内容如下：

```toml

  urls = ["http://localhost:3900"]

  source = "trino"

  [inputs.prom.tags]
    component="trino"
  interval = "10s"

```

<!-- markdownlint-disable MD033 -->
<font color="red">*其他配置按需调整*</font>
<!-- markdownlint-enable -->
，调整参数说明 ：

<!-- markdownlint-disable MD004 -->
- urls：`prometheus`指标地址，这里填写对应组件暴露出来的指标 url
- source：采集器别名，建议做区分
- interval：采集间隔

<!-- markdownlint-enable -->
### 重启 DataKit

[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service)

## 指标 {#metric}

### 指标集 `Trino`

| 指标 | 描述 |
| -- | -- |
| `memory_ClusterMemoryPool_Nodes` | 集群节点数 |
| `memory_ClusterMemoryPool_BlockedNodes`  | 内存群集内存池阻止的节点 |
| `memory_ClusterMemoryPool_FreeDistributedBytes`  | 集群内存池中未分配的可用内存 |
| `memory_ClusterMemoryPool_TotalDistributedBytes`  | 集群内存中总内存 |
| `memory_ClusterMemoryPool_ReservedDistributedBytes`  | 集群内存池中未分配的可用内存 |
| `memory_ClusterMemoryManager_ClusterMemoryBytes`  | 集群内存大小 |
| `memory_ClusterMemoryManager_QueriesKilledDueToOutOfMemory`  | oom killed的查询总数|
| `execution_QueryManager_RunningQueries`  | 当前正在运行的查询数量 |
| `execution_QueryManager_QueuedQueries`  | 等待执行的查询数量 |
| `execution_QueryManager_SubmittedQueries_OneMinute_Count`  | 每分钟内提交的查询数量 |
| `execution_QueryManager_CompletedQueries_OneMinute_Count`  | 每分钟查询完成数 |
| `execution_QueryManager_CompletedQueries_TotalCount`  | 查询完成总数 |
| `execution_QueryManager_FailedQueries_OneMinute_Count`  | 每分钟内失败的查询数量 |
| `execution_QueryManager_FailedQueries_FiveMinute_Count`  | 5 分钟内失败的查询数量 |
| `execution_QueryManager_UserErrorFailures_OneMinute_Count`  | 每分钟异常导致的失败查询数 |
| `execution_QueryManager_UserErrorFailures_FiveMinute_Count`  | 5 分钟异常导致的失败查询数 |
| `execution_QueryManager_UserErrorFailures_TotalCount`  | 异常导致的失败查询总数 |
| `execution_QueryManager_InternalFailures_OneMinute_Count`  | 每分钟服务内部异常导致的失败查询数 |
| `execution_QueryManager_InternalFailures_FiveMinute_Count`  | 5 分钟服务内部异常导致的失败查询数 |
| `execution_QueryManager_InternalFailures_TotalCount`  | 服务内部异常导致的失败查询总数 |
| `execution_SqlTaskManager_InputDataSize_OneMinute_Count`  | 每分钟 Task 输入数据量 |
| `execution_SqlTaskManager_InputDataSize_FiveMinute_Count`  | 5 分钟Task输入数据量|
| `execution_SqlTaskManager_InputDataSize_TotalCount`  | Task输入数据量|
| `execution_SqlTaskManager_InputPositions_OneMinute_Count`  | 每分钟Task输入数据行数|
| `execution_SqlTaskManager_InputPositions_FiveMinute_Count`  | 5 分钟Task输入数据行数|
| `execution_SqlTaskManager_InputPositions_TotalCount`  | Task输入数据行总数|
| `execution_SqlTaskManager_OutputDataSize_OneMinute_Count`  | 每分钟 Task 输出数据量 |
| `execution_SqlTaskManager_OutputDataSize_FiveMinute_Count`  | 5 分钟 Task 输出数据量|
| `execution_SqlTaskManager_OutputDataSize_TotalCount`  | Task 输出数据量|
| `execution_SqlTaskManager_OutputPositions_OneMinute_Count`  | 每分钟 Task 输出数据行数|
| `execution_SqlTaskManager_OutputPositions_FiveMinute_Count`  | 5 分钟 Task 输出数据行数|
| `execution_SqlTaskManager_OutputPositions_TotalCount`  | Task输出数据行总数|
| `execution_SqlTaskManager_FailedTasks_OneMinute_Count`  | 每分钟失败的 Task 数目|
| `execution_SqlTaskManager_FailedTasks_FiveMinute_Count`  | 5 分钟失败的 Task 数目|
| `execution_SqlTaskManager_FailedTasks_TotalCount`  | Task 输出数据行总数|
|`execution_executor_TaskExecutor_Tasks`|向任务执行器注册的所有任务数|
|`execution_executor_TaskExecutor_TotalSplits`|任务执行器总 splits 数|
|`execution_executor_TaskExecutor_RunningSplits`|任务执行器运行的 splits 数|
|`execution_executor_TaskExecutor_WaitingSplits`|任务执行器上等待的 splits 数|
|`memory_ClusterMemoryManager_TotalAvailableProcessors`| 集群 CPU 数 |

### 指标集 Java

| 指标 | 描述 |
| --  | -- |
| `lang_Runtime_Uptime`  | 在线时长 |
| `lang_G1_Concurrent_GC_CollectionCount`  | gc 次数 |
| `lang_Memory_HeapMemoryUsage_used`  | 堆已使用内存 |
| `lang_Memory_HeapMemoryUsage_init`  | 堆初始内存 |
| `lang_Memory_HeapMemoryUsage_max`  | 堆最大内存 |
| `lang_Memory_HeapMemoryUsage_committed`  | 堆已提交内存 |
| `lang_Memory_NonHeapMemoryUsage_used`  | 非堆已使用内存 |
| `lang_Memory_NonHeapMemoryUsage_init`  | 非堆初始内存 |
| `lang_Memory_NonHeapMemoryUsage_max`  | 非堆最大内存 |
| `lang_Memory_NonHeapMemoryUsage_committed`  | 非堆已提交内存 |
