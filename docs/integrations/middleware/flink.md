---
icon: integrations/flink
---
# Flink

---

## 视图预览

Flink 性能指标展示，包括运行的 Job 数、 TaskManager 数、 JVM 信息、 Task Slot 数等。
![image.png](../imgs/flink-1.png)
![image.png](../imgs/flink-2.png)
![image.png](../imgs/flink-3.png)
![image.png](../imgs/flink-4.png)
![image.png](../imgs/flink-5.png)

## 版本支持

操作系统：Linux / Windows<br />
Flink 版本：ALL

## 前置条件

- 服务器 <[安装 DataKit](../../datakit/datakit-install.md)>

## 安装配置

说明：示例 Flink 版本为 Linux 环境 Flink/1.14.2 (CentOS)，各个不同版本指标可能存在差异。

### 部署实施

1、 修改 Flink 主配置文件 `flink-conf.yaml` ，添加 PrometheusReporter

```bash
metrics.reporter.prom.class: org.apache.flink.metrics.prometheus.PrometheusReporter
metrics.reporter.prom.port: 9250-9260
```

说明：`metrics.reporter.prom.port` 端口数根据集群 jobmanager 和 taskmanager 数量而定。可以使用如下测试命令：

```bash
curl http://ip:9250/metrics (~9260)
```

示例 Flink 启动方式为 standalone，jobmanager 指标 9520 端口，taskmanager 指标 9521 端口，把所有采集数据的端口填写至步骤 3 里的 urls 中

![image.png](../imgs/flink-6.png)

2、 开启 DataKit Prom 插件，复制 `sample` 文件

```bash
cd /usr/local/datakit/conf.d/prom/
cp prom.conf.sample prom.conf
```

3、 修改 `prom.conf` 配置文件，添加 urls，其他默认即可

```bash
[[inputs.prom]]
urls = ["http://127.0.0.1:9250/metrics","http://127.0.0.1:9251/metrics"]
```

4、 使用 DataKit Tool 测试数据

```bash
datakit tool --prom-conf prom.conf
```

![image.png](../imgs/flink-7.png)

5、 重启 DataKit

```bash
systemctl restart datakit
```

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - Flink 监控视图>

## 指标详解

### CPU

| Scope            | Infix          | Metrics | Description                      | Type  |
| ---------------- | -------------- | ------- | -------------------------------- | ----- |
| Job-/TaskManager | Status.JVM.CPU | Load    | The recent CPU usage of the JVM. | Gauge |
| Job-/TaskManager | Status.JVM.CPU | Time    | The CPU time used by the JVM.    | Gauge |

### Memory

| Scope            | Infix               | Metrics              | Description                                                                                                                                                                                                                                                                                                                                                              | Type  |
| ---------------- | ------------------- | -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----- |
| Job-/TaskManager | Status.JVM.Memory   | Heap.Used            | The amount of heap memory currently used (in bytes).                                                                                                                                                                                                                                                                                                                     | Gauge |
| Job-/TaskManager | Status.JVM.Memory   | Heap.Committed       | The amount of heap memory guaranteed to be available to the JVM (in bytes).                                                                                                                                                                                                                                                                                              | Gauge |
| Job-/TaskManager | Status.JVM.Memory   | Heap.Max             | The maximum amount of heap memory that can be used for memory management (in bytes). This value might not be necessarily equal to the maximum value specified through -Xmx or the equivalent Flink configuration parameter. Some GC algorithms allocate heap memory that won't be available to the user code and, therefore, not being exposed through the heap metrics. | Gauge |
| Job-/TaskManager | Status.JVM.Memory   | NonHeap.Used         | The amount of non-heap memory currently used (in bytes).                                                                                                                                                                                                                                                                                                                 | Gauge |
| Job-/TaskManager | Status.JVM.Memory   | NonHeap.Committed    | The amount of non-heap memory guaranteed to be available to the JVM (in bytes).                                                                                                                                                                                                                                                                                          | Gauge |
| Job-/TaskManager | Status.JVM.Memory   | NonHeap.Max          | The maximum amount of non-heap memory that can be used for memory management (in bytes).                                                                                                                                                                                                                                                                                 | Gauge |
| Job-/TaskManager | Status.JVM.Memory   | Metaspace.Used       | The amount of memory currently used in the Metaspace memory pool (in bytes).                                                                                                                                                                                                                                                                                             | Gauge |
| Job-/TaskManager | Status.JVM.Memory   | Metaspace.Committed  | The amount of memory guaranteed to be available to the JVM in the Metaspace memory pool (in bytes).                                                                                                                                                                                                                                                                      | Gauge |
| Job-/TaskManager | Status.JVM.Memory   | Metaspace.Max        | The maximum amount of memory that can be used in the Metaspace memory pool (in bytes).                                                                                                                                                                                                                                                                                   | Gauge |
| Job-/TaskManager | Status.JVM.Memory   | Direct.Count         | The number of buffers in the direct buffer pool.                                                                                                                                                                                                                                                                                                                         | Gauge |
| Job-/TaskManager | Status.JVM.Memory   | Direct.MemoryUsed    | The amount of memory used by the JVM for the direct buffer pool (in bytes).                                                                                                                                                                                                                                                                                              | Gauge |
| Job-/TaskManager | Status.JVM.Memory   | Direct.TotalCapacity | The total capacity of all buffers in the direct buffer pool (in bytes).                                                                                                                                                                                                                                                                                                  | Gauge |
| Job-/TaskManager | Status.JVM.Memory   | Mapped.Count         | The number of buffers in the mapped buffer pool.                                                                                                                                                                                                                                                                                                                         | Gauge |
| Job-/TaskManager | Status.JVM.Memory   | Mapped.MemoryUsed    | The amount of memory used by the JVM for the mapped buffer pool (in bytes).                                                                                                                                                                                                                                                                                              | Gauge |
| Job-/TaskManager | Status.JVM.Memory   | Mapped.TotalCapacity | The number of buffers in the mapped buffer pool (in bytes).                                                                                                                                                                                                                                                                                                              | Gauge |
| Job-/TaskManager | Status.Flink.Memory | Managed.Used         | The amount of managed memory currently used.                                                                                                                                                                                                                                                                                                                             | Gauge |
| Job-/TaskManager | Status.Flink.Memory | Managed.Total        | The total amount of managed memory.                                                                                                                                                                                                                                                                                                                                      | Gauge |

### Threads

| Scope            | Infix              | Metrics | Description                       | Type  |
| ---------------- | ------------------ | ------- | --------------------------------- | ----- |
| Job-/TaskManager | Status.JVM.Threads | Count   | The total number of live threads. | Gauge |

### GarbageCollection

| Scope            | Infix                       | Metrics                  | Description                                         | Type  |
| ---------------- | --------------------------- | ------------------------ | --------------------------------------------------- | ----- |
| Job-/TaskManager | Status.JVM.GarbageCollector | <GarbageCollector>.Count | The total number of collections that have occurred. | Gauge |
| Job-/TaskManager | Status.JVM.GarbageCollector | <GarbageCollector>.Time  | The total time spent performing garbage collection. | Gauge |

### ClassLoader

| Scope            | Infix                  | Metrics         | Description                                                      | Type  |
| ---------------- | ---------------------- | --------------- | ---------------------------------------------------------------- | ----- |
| Job-/TaskManager | Status.JVM.ClassLoader | ClassesLoaded   | The total number of classes loaded since the start of the JVM.   | Gauge |
| Job-/TaskManager | Status.JVM.ClassLoader | ClassesUnloaded | The total number of classes unloaded since the start of the JVM. | Gauge |

### Default shuffle service

| Scope       | Infix                                                                                                                         | Metrics                     | Description                                                                    | Type    |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------- | --------------------------- | ------------------------------------------------------------------------------ | ------- |
| TaskManager | Status.Shuffle.Netty                                                                                                          | AvailableMemorySegments     | The number of unused memory segments.                                          | Gauge   |
| TaskManager | Status.Shuffle.Netty                                                                                                          | UsedMemorySegments          | The number of used memory segments.                                            | Gauge   |
| TaskManager | Status.Shuffle.Netty                                                                                                          | TotalMemorySegments         | The number of allocated memory segments.                                       | Gauge   |
| TaskManager | Status.Shuffle.Netty                                                                                                          | AvailableMemory             | The amount of unused memory in bytes.                                          | Gauge   |
| TaskManager | Status.Shuffle.Netty                                                                                                          | UsedMemory                  | The amount of used memory in bytes.                                            | Gauge   |
| TaskManager | Status.Shuffle.Netty                                                                                                          | TotalMemory                 | The amount of allocated memory in bytes.                                       | Gauge   |
| Task        | Shuffle.Netty.Input.Buffers                                                                                                   | inputQueueLength            | The number of queued input buffers.                                            | Gauge   |
| Task        | Shuffle.Netty.Input.Buffers                                                                                                   | inPoolUsage                 | An estimate of the input buffers usage. (ignores LocalInputChannels)           | Gauge   |
| Task        | Shuffle.Netty.Input.Buffers                                                                                                   | inputFloatingBuffersUsage   | An estimate of the floating input buffers usage. (ignores LocalInputChannels)  | Gauge   |
| Task        | Shuffle.Netty.Input.Buffers                                                                                                   | inputExclusiveBuffersUsage  | An estimate of the exclusive input buffers usage. (ignores LocalInputChannels) | Gauge   |
| Task        | Shuffle.Netty.Output.Buffers                                                                                                  | outputQueueLength           | The number of queued output buffers.                                           | Gauge   |
| Task        | Shuffle.Netty.Output.Buffers                                                                                                  | outPoolUsage                | An estimate of the output buffers usage.                                       | Gauge   |
| Task        | Shuffle.Netty.<Input\|Output>.<gate\|partition> **(only available if taskmanager.net.detailed-metrics config option is set)** | totalQueueLen               | Total number of queued buffers in all input/output channels.                   | Gauge   |
| Task        | (only available if taskmanager.net.detailed-metrics config option is set)                                                     | minQueueLen                 | Minimum number of queued buffers in all input/output channels.                 | Gauge   |
| Task        | (only available if taskmanager.net.detailed-metrics config option is set)                                                     | maxQueueLen                 | Maximum number of queued buffers in all input/output channels.                 | Gauge   |
| Task        | (only available if taskmanager.net.detailed-metrics config option is set)                                                     | avgQueueLen                 | Average number of queued buffers in all input/output channels.                 | Gauge   |
| Task        | Shuffle.Netty.Input                                                                                                           | numBytesInLocal             | The total number of bytes this task has read from a local source.              | Counter |
| Task        | Shuffle.Netty.Input                                                                                                           | numBytesInLocalPerSecond    | The number of bytes this task reads from a local source per second.            | Meter   |
| Task        | Shuffle.Netty.Input                                                                                                           | numBytesInRemote            | The total number of bytes this task has read from a remote source.             | Counter |
| Task        | Shuffle.Netty.Input                                                                                                           | numBytesInRemotePerSecond   | The number of bytes this task reads from a remote source per second.           | Meter   |
| Task        | Shuffle.Netty.Input                                                                                                           | numBuffersInLocal           | The total number of network buffers this task has read from a local source.    | Counter |
| Task        | Shuffle.Netty.Input                                                                                                           | numBuffersInLocalPerSecond  | The number of network buffers this task reads from a local source per second.  | Meter   |
| Task        | Shuffle.Netty.Input                                                                                                           | numBuffersInRemote          | The total number of network buffers this task has read from a remote source.   | Counter |
| Task        | Shuffle.Netty.Input                                                                                                           | numBuffersInRemotePerSecond | The number of network buffers this task reads from a remote source per second. | Meter   |

### Cluster

| Scope      | Metrics                   | Description                            | Type  |
| ---------- | ------------------------- | -------------------------------------- | ----- |
| JobManager | numRegisteredTaskManagers | The number of registered taskmanagers. | Gauge |
| JobManager | numRunningJobs            | The number of running jobs.            | Gauge |
| JobManager | taskSlotsAvailable        | The number of available task slots.    | Gauge |
| JobManager | taskSlotsTotal            | The total number of task slots.        | Gauge |

### Availability

| Scope                              | Metrics        | Description                                                                                                                                                       | Type  |
| ---------------------------------- | -------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----- |
| Job (only available on JobManager) | restartingTime | The time it took to restart the job, or how long the current restart has been in progress (in milliseconds).                                                      | Gauge |
| Job (only available on JobManager) | uptime         | The time that the job has been running without interruption.Returns -1 for completed jobs (in milliseconds).                                                      | Gauge |
| Job (only available on JobManager) | downtime       | For jobs currently in a failing/recovering situation, the time elapsed during this outage.Returns 0 for running jobs and -1 for completed jobs (in milliseconds). | Gauge |
| Job (only available on JobManager) | fullRestarts   | **Attention:** deprecated, use **numRestarts**.                                                                                                                   | Gauge |
| Job (only available on JobManager) | numRestarts    | The total number of restarts since this job was submitted, including full restarts and fine-grained restarts.                                                     | Gauge |

### Checkpointing

| Scope                              | Metrics                        | Description                                                                                                                                                                                                                                                                                                                                                                                                                        | Type  |
| ---------------------------------- | ------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----- |
| Job (only available on JobManager) | lastCheckpointDuration         | The time it took to complete the last checkpoint (in milliseconds).                                                                                                                                                                                                                                                                                                                                                                | Gauge |
| Job (only available on JobManager) | lastCheckpointSize             | The total size of the last checkpoint (in bytes).                                                                                                                                                                                                                                                                                                                                                                                  | Gauge |
| Job (only available on JobManager) | lastCheckpointExternalPath     | The path where the last external checkpoint was stored.                                                                                                                                                                                                                                                                                                                                                                            | Gauge |
| Job (only available on JobManager) | lastCheckpointRestoreTimestamp | Timestamp when the last checkpoint was restored at the coordinator (in milliseconds).                                                                                                                                                                                                                                                                                                                                              | Gauge |
| Job (only available on JobManager) | numberOfInProgressCheckpoints  | The number of in progress checkpoints.                                                                                                                                                                                                                                                                                                                                                                                             | Gauge |
| Job (only available on JobManager) | numberOfCompletedCheckpoints   | The number of successfully completed checkpoints.                                                                                                                                                                                                                                                                                                                                                                                  | Gauge |
| Job (only available on JobManager) | numberOfFailedCheckpoints      | The number of failed checkpoints.                                                                                                                                                                                                                                                                                                                                                                                                  | Gauge |
| Job (only available on JobManager) | totalNumberOfCheckpoints       | The number of total checkpoints (in progress, completed, failed).                                                                                                                                                                                                                                                                                                                                                                  | Gauge |
| Task                               | checkpointAlignmentTime        | The time in nanoseconds that the last barrier alignment took to complete, or how long the current alignment has taken so far (in nanoseconds). This is the time between receiving first and the last checkpoint barrier. You can find more information in the [Monitoring State and Checkpoints section](//nightlies.apache.org/flink/flink-docs-release-1.14/docs/ops/state/large_state_tuning/#monitoring-state-and-checkpoints) | Gauge |
| Task                               | checkpointStartDelayNanos      | The time in nanoseconds that elapsed between the creation of the last checkpoint and the time when the checkpointing process has started by this Task. This delay shows how long it takes for the first checkpoint barrier to reach the task. A high value indicates back-pressure. If only a specific task has a long start delay, the most likely reason is data skew.                                                           | Gauge |

### RocksDB

### IO

| Scope                                                                   | Metrics                                                                               | Description                                                                                                                                                                                                                                               | Type      |
| ----------------------------------------------------------------------- | ------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| **Job (only available on TaskManager)**                                 | [<source_id>.[<source_subtask_index>.]]<operator_id>.<operator_subtask_index>.latency | The latency distributions from a given source (subtask) to an operator subtask (in milliseconds), depending on the [latency granularity](https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/deployment/config/#metrics-latency-granularity). | Histogram |
| Task                                                                    | numBytesInLocal                                                                       | **Attention:** deprecated, use [Default shuffle service metrics](https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/ops/metrics/#default-shuffle-service).                                                                                   | Counter   |
| Task                                                                    | numBytesInLocalPerSecond                                                              | **Attention:** deprecated, use [Default shuffle service metrics](https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/ops/metrics/#default-shuffle-service).                                                                                   | Meter     |
| Task                                                                    | numBytesInRemote                                                                      | **Attention:** deprecated, use [Default shuffle service metrics](https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/ops/metrics/#default-shuffle-service).                                                                                   | Counter   |
| Task                                                                    | numBytesInRemotePerSecond                                                             | **Attention:** deprecated, use [Default shuffle service metrics](https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/ops/metrics/#default-shuffle-service).                                                                                   | Meter     |
| Task                                                                    | numBuffersInLocal                                                                     | **Attention:** deprecated, use [Default shuffle service metrics](https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/ops/metrics/#default-shuffle-service).                                                                                   | Counter   |
| Task                                                                    | numBuffersInLocalPerSecond                                                            | **Attention:** deprecated, use [Default shuffle service metrics](https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/ops/metrics/#default-shuffle-service).                                                                                   | Meter     |
| Task                                                                    | numBuffersInRemote                                                                    | **Attention:** deprecated, use [Default shuffle service metrics](https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/ops/metrics/#default-shuffle-service).                                                                                   | Counter   |
| Task                                                                    | numBuffersInRemotePerSecond                                                           | **Attention:** deprecated, use [Default shuffle service metrics](https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/ops/metrics/#default-shuffle-service).                                                                                   | Meter     |
| Task                                                                    | numBytesOut                                                                           | The total number of bytes this task has emitted.                                                                                                                                                                                                          | Counter   |
| Task                                                                    | numBytesOutPerSecond                                                                  | The number of bytes this task emits per second.                                                                                                                                                                                                           | Meter     |
| Task                                                                    | numBuffersOut                                                                         | The total number of network buffers this task has emitted.                                                                                                                                                                                                | Counter   |
| Task                                                                    | numBuffersOutPerSecond                                                                | The number of network buffers this task emits per second.                                                                                                                                                                                                 | Meter     |
| Task                                                                    | isBackPressured                                                                       | Whether the task is back-pressured.                                                                                                                                                                                                                       | Gauge     |
| Task                                                                    | idleTimeMsPerSecond                                                                   | The time (in milliseconds) this task is idle (has no data to process) per second. Idle time excludes back pressured time, so if the task is back pressured it is not idle.                                                                                | Meter     |
| Task                                                                    | backPressuredTimeMsPerSecond                                                          | The time (in milliseconds) this task is back pressured per second.                                                                                                                                                                                        | Gauge     |
| Task                                                                    | busyTimeMsPerSecond                                                                   | The time (in milliseconds) this task is busy (neither idle nor back pressured) per second. Can be NaN, if the value could not be calculated.                                                                                                              | Gauge     |
| **Task (only if buffer debloating is enabled and in non-source tasks)** | estimatedTimeToConsumeBuffersMs                                                       | The estimated time (in milliseconds) by the buffer debloater to consume all of the buffered data in the network exchange preceding this task. This value is calculated by approximated amount of the in-flight data and calculated throughput.            | Gauge     |
| Task                                                                    | debloatedBufferSize                                                                   | The desired buffer size (in bytes) calculated by the buffer debloater. Buffer debloater is trying to reduce buffer size when the amount of in-flight data (after taking into account current throughput) exceeds the configured target value.             | Gauge     |
| Task/Operator                                                           | numRecordsIn                                                                          | The total number of records this operator/task has received.                                                                                                                                                                                              | Counter   |
| Task/Operator                                                           | numRecordsInPerSecond                                                                 | The number of records this operator/task receives per second.                                                                                                                                                                                             | Meter     |
| Task/Operator                                                           | numRecordsOut                                                                         | The total number of records this operator/task has emitted.                                                                                                                                                                                               | Counter   |
| Task/Operator                                                           | numRecordsOutPerSecond                                                                | The number of records this operator/task sends per second.                                                                                                                                                                                                | Meter     |
| Task/Operator                                                           | numLateRecordsDropped                                                                 | The number of records this operator/task has dropped due to arriving late.                                                                                                                                                                                | Counter   |
| Task/Operator                                                           | currentInputWatermark                                                                 | The last watermark this operator/tasks has received (in milliseconds).**Note:** For operators/tasks with 2 inputs this is the minimum of the last received watermarks.                                                                                    | Gauge     |
| Operator                                                                | currentInput**N**Watermark                                                            | The last watermark this operator has received in its **N'th** input (in milliseconds), with index **N** starting from 1. For example currentInput**1**Watermark, currentInput**2**Watermark, ...**Note:** Only for operators with 2 or more inputs.       | Gauge     |
| Operator                                                                | currentOutputWatermark                                                                | The last watermark this operator has emitted (in milliseconds).                                                                                                                                                                                           | Gauge     |
| Operator                                                                | numSplitsProcessed                                                                    | The total number of InputSplits this data source has processed (if the operator is a data source).                                                                                                                                                        | Gauge     |


参考文档：[Flink 官方 Metrics 文档](https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/ops/metrics/#cpu)

## 常见问题排查

<[无数据上报排查](../../datakit/why-no-data.md)>

## 进一步阅读
