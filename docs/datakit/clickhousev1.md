
# ClickHouse
---

- DataKit 版本：1.4.3
- 操作系统支持：`windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

ClickHouse 采集器可以采集 ClickHouse 服务器实例主动暴露的多种指标，比如语句执行数量和内存存储量，IO交互等多种指标，并将指标采集到观测云，帮助你监控分析 ClickHouse 各种异常情况。

## 前置条件 {#requirements}

- ClickHouse 版本 >=v20.1.2.4

在 clickhouse-server 的 config.xml 配置文件中找到如下的代码段，取消注释，并设置 metrics 暴露的端口号（具体哪个自己造择，唯一即可）。修改完成后重启（若为集群，则每台机器均需操作）。

```shell
vim /etc/clickhouse-server/config.xml
```

```xml
<prometheus>
    <endpoint>/metrics</endpoint>
    <port>9363</port>
    <metrics>true</metrics>
    <events>true</events>
    <asynchronous_metrics>true</asynchronous_metrics>
</prometheus>
```

- `endpoint` Prometheus 服务器抓取指标的 HTTP 路由
- `port` 端点的端口号
- `metrics` 从 ClickHouse 的 `system.metrics` 表中抓取暴露的指标标志
- `events` 从 ClickHouse 的 `system.events` 表中抓取暴露的事件标志
- `asynchronous_metrics` 从 ClickHouse 中 `system.asynchronous_metrics` 表中抓取暴露的异步指标标志

详见[ClickHouse 官方文档](https://ClickHouse.com/docs/en/operations/server-configuration-parameters/settings/#server_configuration_parameters-prometheus){:target="_blank"}

## 配置 {#input-config}

进入 DataKit 安装目录下的 `conf.d/db` 目录，复制 `clickhousev1.conf.sample` 并命名为 `clickhousev1.conf`。示例如下：

> 当前 ClickHouse 采集器版本为 v1 版本，更早的版本被废弃了，但因为兼容性考虑，此处将改进后的采集器版本重新命名一下。

```toml

[[inputs.prom]]
  ## Exporter 地址
  url = "http://127.0.0.1:9363/metrics"

  ## 采集器别名
  source = "clickhouse"

  ## 采集数据输出源
  # 配置此项，可以将采集到的数据写到本地文件而不将数据打到中心
  # 之后可以直接用 datakit --prom-conf /path/to/this/conf 命令对本地保存的指标集进行调试
  # 如果已经将url配置为本地文件路径，则--prom-conf优先调试output路径的数据
  # output = "/abs/path/to/file"

  ## 采集数据大小上限，单位为字节
  # 将数据输出到本地文件时，可以设置采集数据大小上限
  # 如果采集数据的大小超过了此上限，则采集的数据将被丢弃
  # 采集数据大小上限默认设置为32MB
  # max_file_size = 0

  ## 指标类型过滤, 可选值为 counter, gauge, histogram, summary
  # 默认只采集 counter 和 gauge 类型的指标
  # 如果为空，则不进行过滤
  metric_types = ["counter", "gauge"]

  ## 指标名称过滤
  # 支持正则，可以配置多个，即满足其中之一即可
  # 如果为空，则不进行过滤
  # metric_name_filter = ["cpu"]

  ## 指标集名称前缀
  # 配置此项，可以给指标集名称添加前缀
  measurement_prefix = ""

  ## 指标集名称
  # 默认会将指标名称以下划线"_"进行切割，切割后的第一个字段作为指标集名称，剩下字段作为当前指标名称
  # 如果配置measurement_name, 则不进行指标名称的切割
  # 最终的指标集名称会添加上measurement_prefix前缀
  # measurement_name = "prom"

  ## 采集间隔 "ns", "us" (or "µs"), "ms", "s", "m", "h"
  interval = "10s"

  ## 过滤tags, 可配置多个tag
  # 匹配的tag将被忽略
  # tags_ignore = ["xxxx"]

  ## TLS 配置
  tls_open = false
  # tls_ca = "/tmp/ca.crt"
  # tls_cert = "/tmp/peer.crt"
  # tls_key = "/tmp/peer.key"

  ## 自定义指标集名称
  # 可以将包含前缀prefix的指标归为一类指标集
  # 自定义指标集名称配置优先measurement_name配置项
  [[inputs.prom.measurements]]
  prefix = "ClickHouseProfileEvents_"
  name = "ClickHouseProfileEvents"

  [[inputs.prom.measurements]]
  prefix = "ClickHouseMetrics_"
  name = "ClickHouseMetrics"

  [[inputs.prom.measurements]]
  prefix = "ClickHouseAsyncMetrics_"
  name = "ClickHouseAsyncMetrics"

  [[inputs.prom.measurements]]
  prefix = "ClickHouseStatusInfo_"
  name = "ClickHouseStatusInfo"

  ## 自定义Tags(集群可添加主机名)
  [inputs.prom.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"

```

配置好后，重启 DataKit 即可。

## 指标集 {#measurements}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.prom.tags]`自定义指定其它Tags：(集群可添加主机名)

``` toml
    [inputs.prom.tags]
    # some_tag = "some_value"
    # more_tag = "some_other_value"
```

## 指标 {#metrics}





### `ClickHouseAsyncMetrics`



-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`host`|host name|

- 字段列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`AsynchronousMetricsCalculationTimeSpent`|-|int|count|
|`BlockActiveTimePerOp_dm_1`|-|int|count|
|`BlockActiveTime_dm_0`|-|int|count|
|`BlockActiveTime_dm_1`|-|int|count|
|`BlockActiveTime_sda`|-|int|count|
|`BlockActiveTime_sr0`|-|int|count|
|`BlockDiscardBytes_dm_0`|-|int|count|
|`BlockDiscardBytes_dm_1`|-|int|count|
|`BlockDiscardBytes_sda`|-|int|count|
|`BlockDiscardBytes_sr0`|-|int|count|
|`BlockDiscardMerges_dm_0`|-|int|count|
|`BlockDiscardMerges_dm_1`|-|int|count|
|`BlockDiscardMerges_sda`|-|int|count|
|`BlockDiscardMerges_sr0`|-|int|count|
|`BlockDiscardOps_dm_0`|-|int|count|
|`BlockDiscardOps_dm_1`|-|int|count|
|`BlockDiscardOps_sda`|-|int|count|
|`BlockDiscardOps_sr0`|-|int|count|
|`BlockDiscardTime_dm_0`|-|int|count|
|`BlockDiscardTime_dm_1`|-|int|count|
|`BlockDiscardTime_sda`|-|int|count|
|`BlockDiscardTime_sr0`|-|int|count|
|`BlockInFlightOps_dm_0`|-|int|count|
|`BlockInFlightOps_dm_1`|-|int|count|
|`BlockInFlightOps_sda`|-|int|count|
|`BlockInFlightOps_sr0`|-|int|count|
|`BlockQueueTimePerOp_dm_1`|-|int|count|
|`BlockQueueTime_dm_0`|-|int|count|
|`BlockQueueTime_dm_1`|-|int|count|
|`BlockQueueTime_sda`|-|int|count|
|`BlockQueueTime_sr0`|-|int|count|
|`BlockReadBytes_dm_0`|-|int|count|
|`BlockReadBytes_dm_1`|-|int|count|
|`BlockReadBytes_sda`|-|int|count|
|`BlockReadBytes_sr0`|-|int|count|
|`BlockReadMerges_dm_0`|-|int|count|
|`BlockReadMerges_dm_1`|-|int|count|
|`BlockReadMerges_sda`|-|int|count|
|`BlockReadMerges_sr0`|-|int|count|
|`BlockReadOps_dm_0`|-|int|count|
|`BlockReadOps_dm_1`|-|int|count|
|`BlockReadOps_sda`|-|int|count|
|`BlockReadOps_sr0`|-|int|count|
|`BlockReadTime_dm_0`|-|int|count|
|`BlockReadTime_dm_1`|-|int|count|
|`BlockReadTime_sda`|-|int|count|
|`BlockReadTime_sr0`|-|int|count|
|`BlockWriteBytes_dm_0`|-|int|count|
|`BlockWriteBytes_dm_1`|-|int|count|
|`BlockWriteBytes_sda`|-|int|count|
|`BlockWriteBytes_sr0`|-|int|count|
|`BlockWriteMerges_dm_0`|-|int|count|
|`BlockWriteMerges_dm_1`|-|int|count|
|`BlockWriteMerges_sda`|-|int|count|
|`BlockWriteMerges_sr0`|-|int|count|
|`BlockWriteOps_dm_0`|-|int|count|
|`BlockWriteOps_dm_1`|-|int|count|
|`BlockWriteOps_sda`|-|int|count|
|`BlockWriteOps_sr0`|-|int|count|
|`BlockWriteTime_dm_0`|-|int|count|
|`BlockWriteTime_dm_1`|-|int|count|
|`BlockWriteTime_sda`|-|int|count|
|`BlockWriteTime_sr0`|-|int|count|
|`CPUFrequencyMHz_0`|-|int|count|
|`CompiledExpressionCacheBytes`|-|int|count|
|`CompiledExpressionCacheCount`|-|int|count|
|`DiskAvailable_default`|-|int|count|
|`DiskTotal_default`|-|int|count|
|`DiskUnreserved_default`|-|int|count|
|`DiskUsed_default`|-|int|count|
|`FilesystemLogsPathAvailableByte`|-|int|count|
|`FilesystemLogsPathAvailableINodes`|-|int|count|
|`FilesystemLogsPathTotalBytes`|-|int|count|
|`FilesystemLogsPathTotalINodes`|-|int|count|
|`FilesystemLogsPathUsedBytes`|-|int|count|
|`FilesystemLogsPathUsedINodes`|-|int|count|
|`FilesystemMainPathAvailableBytes`|-|int|count|
|`FilesystemMainPathAvailableINodes`|-|int|count|
|`FilesystemMainPathTotalBytes`|-|int|count|
|`FilesystemMainPathTotalINodes`|-|int|count|
|`FilesystemMainPathUsedBytes`|-|int|count|
|`FilesystemMainPathUsedINodes`|-|int|count|
|`HTTPThreads`|-|int|count|
|`InterserverThreads`|-|int|count|
|`Jitter`|-|int|count|
|`LoadAverage1`|-|int|count|
|`LoadAverage15`|-|int|count|
|`LoadAverage5`|-|int|count|
|`MMapCacheCells`|-|int|count|
|`MarkCacheBytes`|-|int|count|
|`MarkCacheFiles`|-|int|count|
|`MaxPartCountForPartition`|-|int|count|
|`MemoryCode`|-|int|count|
|`MemoryDataAndStack`|-|int|count|
|`MemoryResident`|-|int|count|
|`MemoryShared`|-|int|count|
|`MemoryVirtual`|-|int|count|
|`MySQLThreads`|-|int|count|
|`NetworkReceiveBytes_ens33`|-|int|count|
|`NetworkReceiveBytes_virbr0`|-|int|count|
|`NetworkReceiveBytes_virbr0_nic`|-|int|count|
|`NetworkReceiveDrop_ens33`|-|int|count|
|`NetworkReceiveDrop_virbr0`|-|int|count|
|`NetworkReceiveDrop_virbr0_nic`|-|int|count|
|`NetworkReceiveErrors_ens33`|-|int|count|
|`NetworkReceiveErrors_virbr0`|-|int|count|
|`NetworkReceiveErrors_virbr0_nic`|-|int|count|
|`NetworkReceivePackets_ens33`|-|int|count|
|`NetworkReceivePackets_virbr0`|-|int|count|
|`NetworkReceivePackets_virbr0_nic`|-|int|count|
|`NetworkSendBytes_ens33`|-|int|count|
|`NetworkSendBytes_virbr0`|-|int|count|
|`NetworkSendBytes_virbr0_nic`|-|int|count|
|`NetworkSendDrop_ens33`|-|int|count|
|`NetworkSendDrop_virbr0`|-|int|count|
|`NetworkSendDrop_virbr0_nic`|-|int|count|
|`NetworkSendErrors_ens33`|-|int|count|
|`NetworkSendErrors_virbr0`|-|int|count|
|`NetworkSendErrors_virbr0_nic`|-|int|count|
|`NetworkSendPackets_ens33`|-|int|count|
|`NetworkSendPackets_virbr0`|-|int|count|
|`NetworkSendPackets_virbr0_nic`|-|int|count|
|`NumberOfDatabases`|-|int|count|
|`NumberOfTables`|-|int|count|
|`OSContextSwitches`|-|int|count|
|`OSGuestNiceTime`|-|int|count|
|`OSGuestNiceTimeCPU0`|-|int|count|
|`OSGuestNiceTimeNormalized`|-|int|count|
|`OSGuestTime`|-|int|count|
|`OSGuestTimeCPU0`|-|int|count|
|`OSGuestTimeNormalized`|-|int|count|
|`OSIOWaitTime`|-|int|count|
|`OSIOWaitTimeCPU0`|-|int|count|
|`OSIOWaitTimeNormalized`|-|int|count|
|`OSIdleTime`|-|int|count|
|`OSIdleTimeCPU0`|-|int|count|
|`OSIdleTimeNormalized`|-|int|count|
|`OSInterrupts`|-|int|count|
|`OSIrqTime`|-|int|count|
|`OSIrqTimeCPU0`|-|int|count|
|`OSIrqTimeNormalized`|-|int|count|
|`OSMemoryAvailable`|-|int|count|
|`OSMemoryCached`|-|int|count|
|`OSMemoryFreePlusCached`|-|int|count|
|`OSMemoryFreeWithoutCached`|-|int|count|
|`OSMemorySwapCached`|-|int|count|
|`OSMemoryTotal`|-|int|count|
|`OSNiceTime`|-|int|count|
|`OSNiceTimeCPU0`|-|int|count|
|`OSNiceTimeNormalized`|-|int|count|
|`OSOpenFiles`|-|int|count|
|`OSProcessesBlocked`|-|int|count|
|`OSProcessesCreated`|-|int|count|
|`OSProcessesRunning`|-|int|count|
|`OSSoftIrqTime`|-|int|count|
|`OSSoftIrqTimeCPU0`|-|int|count|
|`OSSoftIrqTimeNormalized`|-|int|count|
|`OSStealTime`|-|int|count|
|`OSStealTimeCPU0`|-|int|count|
|`OSStealTimeNormalized`|-|int|count|
|`OSSystemTime`|-|int|count|
|`OSSystemTimeCPU0`|-|int|count|
|`OSSystemTimeNormalized`|-|int|count|
|`OSThreadsRunnable`|-|int|count|
|`OSThreadsTotal`|-|int|count|
|`OSUptime`|-|int|count|
|`OSUserTime`|-|int|count|
|`OSUserTimeCPU0`|-|int|count|
|`OSUserTimeNormalized`|-|int|count|
|`PostgreSQLThreads`|-|int|count|
|`PrometheusThreads`|-|int|count|
|`ReplicasMaxAbsoluteDelay`|-|int|count|
|`ReplicasMaxInsertsInQueue`|-|int|count|
|`ReplicasMaxMergesInQueue`|-|int|count|
|`ReplicasMaxQueueSize`|-|int|count|
|`ReplicasMaxRelativeDelay`|-|int|count|
|`ReplicasSumInsertsInQueue`|-|int|count|
|`ReplicasSumMergesInQueue`|-|int|count|
|`ReplicasSumQueueSize`|-|int|count|
|`TCPThreads`|-|int|count|
|`TotalBytesOfMergeTreeTables`|-|int|count|
|`TotalPartsOfMergeTreeTables`|-|int|count|
|`TotalRowsOfMergeTreeTables`|-|int|count|
|`UncompressedCacheBytes`|-|int|count|
|`UncompressedCacheCells`|-|int|count|
|`Uptime`|-|int|count|
|`jemalloc_active`|-|int|count|
|`jemalloc_allocated`|-|int|count|
|`jemalloc_arenas_all_dirty_purged`|-|int|count|
|`jemalloc_arenas_all_muzzy_purged`|-|int|count|
|`jemalloc_arenas_all_pactive`|-|int|count|
|`jemalloc_arenas_all_pdirty`|-|int|count|
|`jemalloc_arenas_all_pmuzzy`|-|int|count|
|`jemalloc_background_thread_num_runs`|-|int|count|
|`jemalloc_background_thread_num_threads`|-|int|count|
|`jemalloc_background_thread_run_intervals`|-|int|count|
|`jemalloc_epoch`|-|int|count|
|`jemalloc_mapped`|-|int|count|
|`jemalloc_metadata`|-|int|count|
|`jemalloc_metadata_thp`|-|int|count|
|`jemalloc_resident`|-|int|count|
|`jemalloc_retained`|-|int|count|






### `ClickHouseMetrics`



-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`host`|host name|

- 字段列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`ActiveAsyncDrainedConnections`|Number of active connections drained asynchronously.|int|count|
|`ActiveSyncDrainedConnections`|Number of active connections drained synchronously.|int|count|
|`AsyncDrainedConnections`|Number of connections drained asynchronously.|int|count|
|`AsynchronousReadWait`|Number of threads waiting for asynchronous read.|int|count|
|`BackgroundBufferFlushSchedulePoolTask`|Number of active tasks in BackgroundBufferFlushSchedulePool. This pool is used for periodic Buffer flushes|int|count|
|`BackgroundCommonPoolTask`|Number of active tasks in an associated background pool|int|count|
|`BackgroundDistributedSchedulePoolTask`|Number of active tasks in BackgroundDistributedSchedulePool. |int|count|
|`BackgroundFetchesPoolTask`|Number of active fetches in an associated background pool|int|count|
|`BackgroundMergesAndMutationsPoolTask`|Number of active merges and mutations in an associated background pool|int|count|
|`BackgroundMessageBrokerSchedulePoolTask`|Number of active tasks in BackgroundProcessingPool for message streaming|int|count|
|`BackgroundMovePoolTask`|Number of active tasks in BackgroundProcessingPool for moves|int|count|
|`BackgroundSchedulePoolTask`|Number of active tasks in BackgroundSchedulePool. |int|count|
|`BrokenDistributedFilesToInsert`|Number of files for asynchronous insertion into Distributed tables that has been marked as broken.|int|count|
|`CacheDictionaryUpdateQueueBatches`|Number of 'batches' (a set of keys) in update queue in CacheDictionaries.|int|count|
|`CacheDictionaryUpdateQueueKeys`|Exact number of keys in update queue in CacheDictionaries.|int|count|
|`ContextLockWait`|Number of threads waiting for lock in Context. This is global lock.|int|count|
|`DelayedInserts`|Number of INSERT queries that are throttled due to high number of active data parts for partition in a MergeTree table.|int|count|
|`DictCacheRequests`|Number of requests in fly to data sources of dictionaries of cache type.|int|count|
|`DiskSpaceReservedForMerge`|Disk space reserved for currently running background merges. It is slightly more than the total size of currently merging parts.|int|count|
|`DistributedFilesToInsert`|Number of pending files to process for asynchronous insertion into Distributed tables. Number of files for every shard is summed.|int|count|
|`DistributedSend`|Number of connections to remote servers sending data that was INSERTed into Distributed tables. Both synchronous and asynchronous mode.|int|count|
|`EphemeralNode`|Number of ephemeral nodes hold in ZooKeeper.|int|count|
|`GlobalThread`|Number of threads in global thread pool.|int|count|
|`GlobalThreadActive`|Number of threads in global thread pool running a task.|int|count|
|`HTTPConnection`|Number of connections to HTTP server|int|count|
|`InterserverConnection`|Number of connections from other replicas to fetch parts|int|count|
|`LocalThread`|Number of threads in local thread pools. The threads in local thread pools are taken from the global thread pool.|int|count|
|`LocalThreadActive`|Number of threads in local thread pools running a task.|int|count|
|`MMappedFileBytes`|Sum size of mmapped file regions.|int|count|
|`MMappedFiles`|Total number of mmapped files.|int|count|
|`MaxDDLEntryID`|Max processed DDL entry of DDLWorker.|int|count|
|`MaxPushedDDLEntryID`|Max DDL entry of DDLWorker that pushed to zookeeper.|int|count|
|`MemoryTracking`|Total amount of memory (bytes) allocated by the server.|int|count|
|`Merge`|Number of executing background merges|int|count|
|`MySQLConnection`|Number of client connections using MySQL protocol|int|count|
|`NetworkReceive`|Number of threads receiving data from network. Only ClickHouse-related network interaction is included, not by 3rd party libraries.|int|count|
|`NetworkSend`|Number of threads sending data to network. Only ClickHouse-related network interaction is included, not by 3rd party libraries.|int|count|
|`OpenFileForRead`|Number of files open for reading|int|count|
|`OpenFileForWrite`|Number of files open for writing|int|count|
|`PartMutation`|Number of mutations (ALTER DELETE/UPDATE)|int|count|
|`PartsCommitted`|Active data part, used by current and upcoming SELECTs.|int|count|
|`PartsCompact`|Compact parts.|int|count|
|`PartsDeleteOnDestroy`|Part was moved to another disk and should be deleted in own destructor.|int|count|
|`PartsDeleting`|Not active data part with identity refcounter, it is deleting right now by a cleaner.|int|count|
|`PartsInMemory`|In-memory parts.|int|count|
|`PartsOutdated`|Not active data part, but could be used by only current SELECTs, could be deleted after SELECTs finishes.|int|count|
|`PartsPreCommitted`|The part is in data_parts, but not used for SELECTs.|int|count|
|`PartsTemporary`|The part is generating now, it is not in data_parts list.|int|count|
|`PartsWide`|Wide parts.|int|count|
|`PostgreSQLConnection`|Number of client connections using PostgreSQL protocol|int|count|
|`Query`|Number of executing queries|int|count|
|`QueryPreempted`|Number of queries that are stopped and waiting due to 'priority' setting.|int|count|
|`QueryThread`|Number of query processing threads|int|count|
|`RWLockActiveReaders`|Number of threads holding read lock in a table RWLock.|int|count|
|`RWLockActiveWriters`|Number of threads holding write lock in a table RWLock.|int|count|
|`RWLockWaitingReaders`|Number of threads waiting for read on a table RWLock.|int|count|
|`RWLockWaitingWriters`|Number of threads waiting for write on a table RWLock.|int|count|
|`Read`|Number of read (read, pread, io_getevents, etc.) syscalls in fly|int|count|
|`ReadonlyReplica`|Number of Replicated tables that are currently in readonly state due to re-initialization after ZooKeeper session loss or due to startup without ZooKeeper configured.|int|count|
|`ReplicatedChecks`|Number of data parts checking for consistency|int|count|
|`ReplicatedFetch`|Number of data parts being fetched from replica|int|count|
|`ReplicatedSend`|Number of data parts being sent to replicas|int|count|
|`Revision Revision`|of the server. It is a number incremented for every release or release candidate except patch releases.|int|count|
|`SendExternalTables`|Number of connections that are sending data for external tables to remote servers. |int|count|
|`SendScalars`|Number of connections that are sending data for scalars to remote servers.|int|count|
|`StorageBufferBytes`|Number of bytes in buffers of Buffer tables|int|count|
|`StorageBufferRows`|Number of rows in buffers of Buffer tables|int|count|
|`SyncDrainedConnections`|Number of connections drained synchronously.|int|count|
|`TCPConnection`|Number of connections to TCP server (clients with native interface), also included server-server distributed query connections|int|count|
|`TablesToDropQueueSize`|Number of dropped tables, that are waiting for background data removal.|int|count|
|`VersionInteger`|Version of the server in a single integer number in base-1000. For example, version 11.22.33 is translated to 11022033.|int|count|
|`Write`|Number of write (write, pwrite, io_getevents, etc.) syscalls in fly|int|count|
|`ZooKeeperRequest`|Number of requests to ZooKeeper in fly.|int|count|
|`ZooKeeperSession`|Number of sessions (connections) to ZooKeeper.|int|count|
|`ZooKeeperWatch`|Number of watches (event subscriptions) in ZooKeeper.|int|count|






### `ClickHouseProfileEvents`



-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`host`|host name|

- 字段列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`AIORead`|Number of reads with Linux or FreeBSD AIO interface|int|count|
|`AIOReadBytes`|Number of bytes read with Linux or FreeBSD AIO interface|int|count|
|`AIOWrite`|Number of writes with Linux or FreeBSD AIO interface|int|count|
|`AIOWriteBytes`|Number of bytes written with Linux or FreeBSD AIO interface|int|count|
|`ArenaAllocBytes`|-|int|count|
|`ArenaAllocChunks`|-|int|count|
|`AsynchronousReadWaitMicroseconds`|Time spent in waiting for asynchronous reads.|int|count|
|`CannotRemoveEphemeralNode`|Number of times an error happened while trying to remove ephemeral node. |int|count|
|`CannotWriteToWriteBufferDiscard`|Number of stack traces dropped by query profiler or signal handler because pipe is full or cannot write to pipe.|int|count|
|`CompileExpressionsBytes`|Number of bytes used for expressions compilation.|int|count|
|`CompileExpressionsMicroseconds`|Total time spent for compilation of expressions to LLVM code.|int|count|
|`CompileFunction`|Number of times a compilation of generated LLVM code (to create fused function for complex expressions) was initiated.|int|count|
|`CompiledFunctionExecute`|Number of times a compiled function was executed.|int|count|
|`CompressedReadBufferBlocks`|CompressedReadBufferBlocks Number of compressed blocks (the blocks of data that are compressed independent of each other) read from compressed sources (files, network).|int|count|
|`CompressedReadBufferBytes`|Number of uncompressed bytes (the number of bytes after decompression) read from compressed sources (files, network).|int|count|
|`ContextLock`|Number of times the lock of Context was acquired or tried to acquire. This is global lock.|int|count|
|`CreatedHTTPConnections`|Total amount of created HTTP connections (counter increase every time connection is created).|int|count|
|`CreatedLogEntryForMerge`|Successfully created log entry to merge parts in ReplicatedMergeTree.|int|count|
|`CreatedLogEntryForMutation`|Successfully created log entry to mutate parts in ReplicatedMergeTree.|int|count|
|`CreatedReadBufferDirectIO`|-|int|count|
|`CreatedReadBufferDirectIOFailed`|-|int|count|
|`CreatedReadBufferMMap`|-|int|count|
|`CreatedReadBufferMMapFailed`|-|int|count|
|`CreatedReadBufferOrdinary`|-|int|count|
|`DNSError`|Total count of errors in DNS resolution|int|count|
|`DataAfterMergeDiffersFromReplica`|-|int|count|
|`DataAfterMutationDiffersFromReplica`|-|int|count|
|`DelayedInserts`|Number of times the INSERT of a block to a MergeTree table was throttled due to high number of active data parts for partition.|int|count|
|`DelayedInsertsMilliseconds`|Total number of milliseconds spent while the INSERT of a block to a MergeTree table was throttled due to high number of active data parts for partition.|int|count|
|`DictCacheKeysExpired`|-|int|count|
|`DictCacheKeysHit`|-|int|count|
|`DictCacheKeysNotFound`|-|int|count|
|`DictCacheKeysRequested`|-|int|count|
|`DictCacheKeysRequestedFound`|-|int|count|
|`DictCacheKeysRequestedMiss`|-|int|count|
|`DictCacheLockReadNs`|-|int|count|
|`DictCacheLockWriteNs`|-|int|count|
|`DictCacheRequestTimeNs`|-|int|count|
|`DictCacheRequests`|-|int|count|
|`DiskReadElapsedMicroseconds`|Total time spent waiting for read syscall. This include reads from page cache.|int|count|
|`DiskWriteElapsedMicroseconds`|Total time spent waiting for write syscall. This include writes to page cache.|int|count|
|`DistributedConnectionFailAtAll`|Total count when distributed connection fails after all retries finished|int|count|
|`DistributedConnectionFailTry`|Total count when distributed connection fails with retry|int|count|
|`DistributedConnectionMissingTable`|-|int|count|
|`DistributedConnectionStaleReplica`|-|int|count|
|`DistributedDelayedInserts`|Number of times the INSERT of a block to a Distributed table was throttled due to high number of pending bytes.|int|count|
|`DistributedDelayedInsertsMilliseconds`|Total number of milliseconds spent while the INSERT of a block to a Distributed table was throttled due to high number of pending bytes.|int|count|
|`DistributedRejectedInserts`|Number of times the INSERT of a block to a Distributed table was rejected with 'Too many bytes' exception due to high number of pending bytes.|int|count|
|`DistributedSyncInsertionTimeoutExceeded`|-|int|count|
|`DuplicatedInsertedBlocks`|Number of times the INSERTed block to a ReplicatedMergeTree table was deduplicated.|int|count|
|`ExternalAggregationCompressedBytes`|-|int|count|
|`ExternalAggregationMerge`|-|int|count|
|`ExternalAggregationUncompressedBytes`|-|int|count|
|`ExternalAggregationWritePart`|-|int|count|
|`ExternalSortMerge`|-|int|count|
|`ExternalSortWritePart`|-|int|count|
|`FailedInsertQuery`|Same as FailedQuery, but only for INSERT queries|int|count|
|`FailedQuery`|Number of failed queries.|int|count|
|`FailedSelectQuery`|Same as FailedQuery, but only for SELECT queries|int|count|
|`FileOpen `|Number of files opened|int|count|
|`FunctionExecute`|-|int|count|
|`HardPageFaults`|-|int|count|
|`HedgedRequestsChangeReplica`|Total count when timeout for changing replica expired in hedged requests.|int|count|
|`IOBufferAllocBytes`|-|int|count|
|`IOBufferAllocs`|-|int|count|
|`InsertQuery`|Same as Query, but only for INSERT queries|int|count|
|`InsertQueryTimeMicroseconds`|Total time of INSERT queries.|int|count|
|`InsertedBytes`|Number of bytes (uncompressed; for columns as they stored in memory) inserted to all tables.|int|count|
|`InsertedRows`|Number of rows inserted to all tables.|int|count|
|`InvoluntaryContextSwitches`|-|int|count|
|`MarkCacheHits`|-|int|count|
|`MarkCacheMisses`|-|int|count|
|`Merge`|Number of launched background merges.|int|count|
|`MergeTreeDataProjectionWriterBlocks`|Number of blocks INSERTed to MergeTree tables projection. Each block forms a data part of level zero.|int|count|
|`MergeTreeDataProjectionWriterBlocksAlreadySorted`|Number of blocks INSERTed to MergeTree tables projection that appeared to be already sorted.|int|count|
|`MergeTreeDataProjectionWriterCompressedBytes`|Bytes written to filesystem for data INSERTed to MergeTree tables projection.|int|count|
|`MergeTreeDataProjectionWriterRows`|Number of rows INSERTed to MergeTree tables projection.|int|count|
|`MergeTreeDataProjectionWriterUncompressedBytes`|Uncompressed bytes (for columns as they stored in memory) INSERTed to MergeTree tables projection.|int|count|
|`MergeTreeDataWriterBlocks`|Number of blocks INSERTed to MergeTree tables. Each block forms a data part of level zero.|int|count|
|`MergeTreeDataWriterBlocksAlreadySorted`|Number of blocks INSERTed to MergeTree tables that appeared to be already sorted.|int|count|
|`MergeTreeDataWriterCompressedBytes`|Bytes written to filesystem for data INSERTed to MergeTree tables.|int|count|
|`MergeTreeDataWriterRows`|Number of rows INSERTed to MergeTree tables.|int|count|
|`MergeTreeDataWriterUncompressedBytes`|Uncompressed bytes (for columns as they stored in memory) INSERTed to MergeTree tables.|int|count|
|`MergedRows`|Rows read for background merges. This is the number of rows before merge.|int|count|
|`MergedUncompressedBytes`|Uncompressed bytes (for columns as they stored in memory) that was read for background merges. This is the number before merge.|int|count|
|`MergesTimeMilliseconds`|Total time spent for background merges.|int|count|
|`NetworkReceiveBytes`|Total number of bytes received from network. Only ClickHouse-related network interaction is included, not by 3rd party libraries.|int|count|
|`NetworkReceiveElapsedMicroseconds`|Total time spent waiting for data to receive or receiving data from network. Only ClickHouse-related network interaction is included, not by 3rd party libraries.|int|count|
|`NetworkSendBytes`|Total number of bytes send to network. Only ClickHouse-related network interaction is included, not by 3rd party libraries.|int|count|
|`NetworkSendElapsedMicroseconds`|Total time spent waiting for data to send to network or sending data to network. Only ClickHouse-related network interaction is included, not by 3rd party libraries..|int|count|
|`NotCreatedLogEntryForMerge`|Log entry to merge parts in ReplicatedMergeTree is not created due to concurrent log update by another replica.|int|count|
|`NotCreatedLogEntryForMutation`|Log entry to mutate parts in ReplicatedMergeTree is not created due to concurrent log update by another replica.|int|count|
|`OSCPUVirtualTimeMicroseconds`|CPU time spent seen by OS. Does not include involuntary waits due to virtualization.|int|count|
|`OSCPUWaitMicroseconds`|Total time a thread was ready for execution but waiting to be scheduled by OS, from the OS point of view.|int|count|
|`OSIOWaitMicroseconds`|Total time a thread spent waiting for a result of IO operation, from the OS point of view. This is real IO that doesn't include page cache.|int|count|
|`OSReadBytes`|Number of bytes read from disks or block devices. Doesn't include bytes read from page cache. |int|count|
|`OSReadChars`|Number of bytes read from filesystem, including page cache.|int|count|
|`OSWriteBytes`|Number of bytes written to disks or block devices. Doesn't include bytes that are in page cache dirty pages. |int|count|
|`OSWriteChars`|Number of bytes written to filesystem, including page cache.|int|count|
|`ObsoleteReplicatedParts`|-|int|count|
|`PerfAlignmentFaults`|Number of alignment faults. These happen when unaligned memory accesses happen; the kernel can handle these but it reduces performance.|int|count|
|`PerfBranchInstructions`|Retired branch instructions. Prior to Linux 2.6.35, this used the wrong event on AMD processors.|int|count|
|`PerfBranchMisses`|Mispredicted branch instructions.|int|count|
|`PerfBusCycles`|Bus cycles, which can be different from total cycles.|int|count|
|`PerfCacheMisses`|Cache misses. Usually this indicates Last Level Cache misses.|int|count|
|`PerfCacheReferences`|Cache accesses. Usually this indicates Last Level Cache accesses but this may vary depending on your CPU. |int|count|
|`PerfContextSwitches`|Number of context switches|int|count|
|`PerfCpuClock`|The CPU clock, a high-resolution per-CPU timer|int|count|
|`PerfCpuCycles`|Total cycles. Be wary of what happens during CPU frequency scaling.|int|count|
|`PerfCpuMigrations`|Number of times the process has migrated to a new CPU|int|count|
|`PerfDataTLBMisses`|Data TLB misses|int|count|
|`PerfDataTLBReferences`|Data TLB references|int|count|
|`PerfEmulationFaults`|Number of emulation faults. The kernel sometimes traps on unimplemented instructions and emulates them for user space.|int|count|
|`PerfInstructionTLBMisses`|Instruction TLB misses|int|count|
|`PerfInstructionTLBReferences`|Instruction TLB references|int|count|
|`PerfInstructions`|Retired instructions. Be careful, these can be affected by various issues, most notably hardware interrupt counts.|int|count|
|`PerfLocalMemoryMisses`|Local NUMA node memory read misses|int|count|
|`PerfLocalMemoryReferences`|Local NUMA node memory reads|int|count|
|`PerfMinEnabledRunningTime`|Running time for event with minimum enabled time. Used to track the amount of event multiplexing|int|count|
|`PerfMinEnabledTime`|For all events, minimum time that an event was enabled. Used to track event multiplexing influence|int|count|
|`PerfRefCpuCycles`|Total cycles; not affected by CPU frequency scaling.|int|count|
|`PerfStalledCyclesBackend`|Stalled cycles during retirement.|int|count|
|`PerfStalledCyclesFrontend`|Stalled cycles during issue.|int|count|
|`PerfTaskClock`|A clock count specific to the task that is running|int|count|
|`PolygonsAddedToPool`|-|int|count|
|`PolygonsInPoolAllocatedBytes`|-|int|count|
|`Query`|Number of queries to be interpreted and potentially executed.|int|count|
|`QueryMaskingRulesMatch`|Number of times query masking rules was successfully matched.|int|count|
|`QueryMemoryLimitExceeded`|Number of times when memory limit exceeded for query.|int|count|
|`QueryProfilerRuns`|Number of times QueryProfiler had been run.|int|count|
|`QueryProfilerSignalOverruns`|Number of times we drop processing of a query profiler signal due to overrun plus the number of signals that OS has not delivered due to overrun.|int|count|
|`QueryTimeMicroseconds`|Total time of all queries.|int|count|
|`RWLockAcquiredReadLocks`|-|int|count|
|`RWLockAcquiredWriteLocks`|-|int|count|
|`RWLockReadersWaitMilliseconds`|-|int|count|
|`RWLockWritersWaitMilliseconds`|-|int|count|
|`ReadBackoff`|Number of times the number of query processing threads was lowered due to slow reads.|int|count|
|`ReadBufferFromFileDescriptorRead`|Number of reads (read/pread) from a file descriptor. Does not include sockets.|int|count|
|`ReadBufferFromFileDescriptorReadBytes `|Number of bytes read from file descriptors. If the file is compressed, this will show the compressed data size.|int|count|
|`ReadBufferFromFileDescriptorReadFailed `|Number of times the read (read/pread) from a file descriptor have failed.|int|count|
|`ReadCompressedBytes`|Number of bytes (the number of bytes before decompression) read from compressed sources (files, network).|int|count|
|`RealTimeMicroseconds`|Total (wall clock) time spent in processing (queries and other tasks) threads (not that this is a sum).|int|count|
|`RegexpCreated`|Compiled regular expressions. Identical regular expressions compiled just once and cached forever.|int|count|
|`RejectedInserts`|Number of times the INSERT of a block to a MergeTree table was rejected with 'Too many parts' exception due to high number of active data parts for partition.|int|count|
|`RemoteFSBuffers`|Number of buffers created for asynchronous reading from remote filesystem|int|count|
|`RemoteFSCancelledPrefetches`|Number of canceled prefecthes (because of seek)|int|count|
|`RemoteFSPrefetchedReads`|Number of reads from prefecthed buffer|int|count|
|`RemoteFSPrefetches`|Number of prefetches made with asynchronous reading from remote filesystem|int|count|
|`RemoteFSReadBytes`|Read bytes from remote filesystem.|int|count|
|`RemoteFSReadMicroseconds`|Time of reading from remote filesystem.|int|count|
|`RemoteFSSeeks`|Total number of seeks for async buffer|int|count|
|`RemoteFSUnprefetchedReads`|Number of reads from unprefetched buffer|int|count|
|`RemoteFSUnusedPrefetches`|Number of prefetches pending at buffer destruction|int|count|
|`ReplicaPartialShutdown`|How many times Replicated table has to deinitialize its state due to session expiration in ZooKeeper. |int|count|
|`ReplicatedDataLoss`|Number of times a data part that we wanted doesn't exist on any replica (even on replicas that are offline right now). |int|count|
|`ReplicatedPartChecks`|-|int|count|
|`ReplicatedPartChecksFailed`|-|int|count|
|`ReplicatedPartFailedFetches`|Number of times a data part was failed to download from replica of a ReplicatedMergeTree table.|int|count|
|`ReplicatedPartFetches`|Number of times a data part was downloaded from replica of a ReplicatedMergeTree table.|int|count|
|`ReplicatedPartFetchesOfMerged`|Number of times we prefer to download already merged part from replica of ReplicatedMergeTree table instead of performing a merge ourself.|int|count|
|`ReplicatedPartMerges`|Number of times data parts of ReplicatedMergeTree tables were successfully merged.|int|count|
|`ReplicatedPartMutations`|-|int|count|
|`S3ReadBytes`|Read bytes (incoming) in GET and HEAD requests to S3 storage.|int|count|
|`S3ReadMicroseconds`|Time of GET and HEAD requests to S3 storage.|int|count|
|`S3ReadRequestsCount`|Number of GET and HEAD requests to S3 storage.|int|count|
|`S3ReadRequestsErrors`|Number of non-throttling errors in GET and HEAD requests to S3 storage.|int|count|
|`S3ReadRequestsRedirects`|Number of redirects in GET and HEAD requests to S3 storage.|int|count|
|`S3ReadRequestsThrottling`|Number of 429 and 503 errors in GET and HEAD requests to S3 storage.|int|count|
|`S3WriteBytes`|Write bytes (outgoing) in POST, DELETE, PUT and PATCH requests to S3 storage.|int|count|
|`S3WriteMicroseconds`|Time of POST, DELETE, PUT and PATCH requests to S3 storage.|int|count|
|`S3WriteRequestsCount`|Number of POST, DELETE, PUT and PATCH requests to S3 storage.|int|count|
|`S3WriteRequestsErrors`|Number of non-throttling errors in POST, DELETE, PUT and PATCH requests to S3 storage.|int|count|
|`S3WriteRequestsRedirects`|Number of redirects in POST, DELETE, PUT and PATCH requests to S3 storage.|int|count|
|`S3WriteRequestsThrottling`|Number of 429 and 503 errors in POST, DELETE, PUT and PATCH requests to S3 storage.|int|count|
|`Seek `|Number of times the 'lseek' function was called.|int|count|
|`SelectQuery`|Same as Query, but only for SELECT queries.|int|count|
|`SelectQueryTimeMicroseconds`|Total time of SELECT queries.|int|count|
|`SelectedBytes`|Number of bytes (uncompressed; for columns as they stored in memory) SELECTed from all tables.|int|count|
|`SelectedMarks`|Number of marks (index granules) selected to read from a MergeTree table.|int|count|
|`SelectedParts`|Number of data parts selected to read from a MergeTree table.|int|count|
|`SelectedRanges`|Number of (non-adjacent) ranges in all data parts selected to read from a MergeTree table.|int|count|
|`SelectedRows`|Number of rows selected from all tables.|int|count|
|`SleepFunctionCalls`|Number of times a sleep function (sleep, sleepEachRow) has been called.|int|count|
|`SleepFunctionMicroseconds`|Time spent sleeping due to a sleep function call.|int|count|
|`SlowRead`|Number of reads from a file that were slow. This indicate system overload. Thresholds are controlled by read_backoff_* settings.|int|count|
|`SoftPageFaults`|-|int|count|
|`StorageBufferErrorOnFlush`|-|int|count|
|`StorageBufferFlush`|-|int|count|
|`StorageBufferLayerLockReadersWaitMilliseconds`|Time for waiting for Buffer layer during reading|int|count|
|`StorageBufferLayerLockWritersWaitMilliseconds`|Time for waiting free Buffer layer to write to (can be used to tune Buffer layers)|int|count|
|`StorageBufferPassedAllMinThresholds`|-|int|count|
|`StorageBufferPassedBytesFlushThreshold`|-|int|count|
|`StorageBufferPassedBytesMaxThreshold`|-|int|count|
|`StorageBufferPassedRowsFlushThreshold`|-|int|count|
|`StorageBufferPassedRowsMaxThreshold`|-|int|count|
|`StorageBufferPassedTimeFlushThreshold`|-|int|count|
|`StorageBufferPassedTimeMaxThreshold`|-|int|count|
|`SystemTimeMicroseconds`|Total time spent in processing (queries and other tasks) threads executing CPU instructions in OS kernel space. |int|count|
|`TableFunctionExecute`|-|int|count|
|`ThreadPoolReaderPageCacheHit`|Number of times the read inside ThreadPoolReader was done from page cache.|int|count|
|`ThreadPoolReaderPageCacheHitBytes`|Number of bytes read inside ThreadPoolReader when it was done from page cache.|int|count|
|`ThreadPoolReaderPageCacheHitElapsedMicroseconds`|Time spent reading data from page cache in ThreadPoolReader.|int|count|
|`ThreadPoolReaderPageCacheMiss`|Number of times the read inside ThreadPoolReader was not done from page cache and was hand off to thread pool.|int|count|
|`ThreadPoolReaderPageCacheMissBytes`|Number of bytes read inside ThreadPoolReader when read was not done from page cache and was hand off to thread pool.|int|count|
|`ThreadPoolReaderPageCacheMissElapsedMicroseconds`|Time spent reading data inside the asynchronous job in ThreadPoolReader - when read was not done from page cache.|int|count|
|`ThrottlerSleepMicroseconds`|Total time a query was sleeping to conform the 'max_network_bandwidth' setting.|int|count|
|`UserTimeMicroseconds`|Total time spent in processing (queries and other tasks) threads executing CPU instructions in user space. |int|count|
|`VoluntaryContextSwitches`|-|int|count|
|`WriteBufferFromFileDescriptorWrite `|Number of writes (write/pwrite) to a file descriptor. Does not include sockets|int|count|
|`WriteBufferFromFileDescriptorWriteBytes`|Number of bytes written to file descriptors. If the file is compressed, this will show compressed data size.|int|count|
|`WriteBufferFromFileDescriptorWriteFailed `|Number of times the write (write/pwrite) to a file descriptor have failed.|int|count|
|`ZooKeeperBytesReceived`|-|int|count|
|`ZooKeeperBytesSent`|-|int|count|
|`ZooKeeperCheck`|-|int|count|
|`ZooKeeperClose`|-|int|count|
|`ZooKeeperCreate`|-|int|count|
|`ZooKeeperExists`|-|int|count|
|`ZooKeeperGet`|-|int|count|
|`ZooKeeperHardwareExceptions`|-|int|count|
|`ZooKeeperInit`|-|int|count|
|`ZooKeeperList`|-|int|count|
|`ZooKeeperMulti`|-|int|count|
|`ZooKeeperOtherExceptions`|-|int|count|
|`ZooKeeperRemove`|-|int|count|
|`ZooKeeperSet`|-|int|count|
|`ZooKeeperTransactions`|-|int|count|
|`ZooKeeperUserExceptions`|-|int|count|
|`ZooKeeperWaitMicroseconds`|-|int|count|
|`ZooKeeperWatchResponse`|-|int|count|






### `ClickHouseStatusInfo`



-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`host`|host name|

- 字段列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`DictionaryStatus`|Dictionary Status.|int|count|



