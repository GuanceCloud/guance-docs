
# ClickHouse
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "支持选举")

---

ClickHouse collector can collect various metrics actively exposed by ClickHouse server instances, such as the number of statements executed, memory storage, IO interaction and other metrics, and collect the metrics into Guance Cloud to help you monitor and analyze various abnormal situations of ClickHouse.

## Preconditions {#requirements}

ClickHouse version >=v20.1.2.4

Find the following code snippet in the config.xml configuration file of clickhouse-server, uncomment it, and set the port number exposed by metrics (which is unique if you choose it yourself). Restart after modification (if it is a cluster, every machine needs to operate).

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

Field description:

- HTTP Routing of `endpoint` Prometheus Server Fetch Metrics
- `port` number of the port endpoint
- `metrics` grabs exposed metrics flags from ClickHouse's `system.metrics` table
- `events` grabs exposed event flags from ClickHouse's `table.events`.
- `asynchronous_metrics` grabs exposed asynchronous_metrics flags from ClickHouse's `system.asynchronous_metrics` table

See [ClickHouse official documents](https://ClickHouse.com/docs/en/operations/server-configuration-parameters/settings/#server_configuration_parameters-prometheus){:target="_blank"}

=== "Host Installation"

    Go to the `conf.d/db` directory under the DataKit installation directory, copy `clickhousev1.conf.sample` and name it `clickhousev1.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.prom]]
      ## Exporter HTTP URL.
      url = "http://127.0.0.1:9363/metrics"
    
      ## Collector alias.
      source = "clickhouse"
    
      ## Collect data output.
      # Fill this when want to collect the data to local file nor center.
      # After filling, could use 'datakit --prom-conf /path/to/this/conf' to debug local storage measurement set.
      # Using '--prom-conf' when priority debugging data in 'output' path.
      # output = "/abs/path/to/file"
    
      ## Collect data upper limit as bytes.
      # Only available when set output to local file.
      # If collect data exceeded the limit, the data would be dropped.
      # Default is 32MB.
      # max_file_size = 0
    
      ## Metrics type whitelist. Optional: counter, gauge, histogram, summary
      # Default only collect 'counter' and 'gauge'.
      # Collect all if empty.
      metric_types = ["counter", "gauge"]
    
      ## Metrics name whitelist.
      # Regex supported. Multi supported, conditions met when one matched.
      # Collect all if empty.
      # metric_name_filter = ["cpu"]
    
      ## Measurement prefix.
      # Add prefix to measurement set name.
      measurement_prefix = ""
    
      ## Measurement name.
      # If measurement_name is empty, split metric name by '_', the first field after split as measurement set name, the rest as current metric name.
      # If measurement_name is not empty, using this as measurement set name.
      # Always add 'measurement_prefix' prefix at last.
      # measurement_name = "prom"
    
      ## Collect interval, support "ns", "us" (or "µs"), "ms", "s", "m", "h".
      interval = "10s"
    
      # Ignore tags. Multi supported.
      # The matched tags would be dropped, but the item would still be sent.
      # tags_ignore = ["xxxx"]
    
      ## TLS configuration.
      tls_open = false
      # tls_ca = "/tmp/ca.crt"
      # tls_cert = "/tmp/peer.crt"
      # tls_key = "/tmp/peer.key"
    
      ## Customize measurement set name.
      # Treat those metrics with prefix as one set.
      # Prioritier over 'measurement_name' configuration.
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
    
      ## Customize tags.
      [inputs.prom.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    
    ```
    
    After configuration, [restart DataKit](datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    At present, you can [inject collector configuration in ConfigMap mode](datakit-daemonset-deploy.md#configmap-setting)。

## Measurements {#measurements}

For all the following data collections, a global tag named `host` is appended by default (the tag value is the host name where the DataKit is located), or other tags can be customized in the configuration through `[inputs.prom.tags]`(Hostname can be added to the cluster).

``` toml
    [inputs.prom.tags]
    # some_tag = "some_value"
    # more_tag = "some_other_value"
```

## Metrics {#metrics}





### `ClickHouseAsyncMetrics`



- tag


| Tag | Description |
|  ----  | --------|
|`host`|host name|

- field list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`AsynchronousMetricsCalculationTimeSpent`|TODO|int|count|
|`BlockActiveTimePerOp_dm_1`|TODO|int|count|
|`BlockActiveTime_dm_0`|TODO|int|count|
|`BlockActiveTime_dm_1`|TODO|int|count|
|`BlockActiveTime_sda`|TODO|int|count|
|`BlockActiveTime_sr0`|TODO|int|count|
|`BlockDiscardBytes_dm_0`|TODO|int|count|
|`BlockDiscardBytes_dm_1`|TODO|int|count|
|`BlockDiscardBytes_sda`|TODO|int|count|
|`BlockDiscardBytes_sr0`|TODO|int|count|
|`BlockDiscardMerges_dm_0`|TODO|int|count|
|`BlockDiscardMerges_dm_1`|TODO|int|count|
|`BlockDiscardMerges_sda`|TODO|int|count|
|`BlockDiscardMerges_sr0`|TODO|int|count|
|`BlockDiscardOps_dm_0`|TODO|int|count|
|`BlockDiscardOps_dm_1`|TODO|int|count|
|`BlockDiscardOps_sda`|TODO|int|count|
|`BlockDiscardOps_sr0`|TODO|int|count|
|`BlockDiscardTime_dm_0`|TODO|int|count|
|`BlockDiscardTime_dm_1`|TODO|int|count|
|`BlockDiscardTime_sda`|TODO|int|count|
|`BlockDiscardTime_sr0`|TODO|int|count|
|`BlockInFlightOps_dm_0`|TODO|int|count|
|`BlockInFlightOps_dm_1`|TODO|int|count|
|`BlockInFlightOps_sda`|TODO|int|count|
|`BlockInFlightOps_sr0`|TODO|int|count|
|`BlockQueueTimePerOp_dm_1`|TODO|int|count|
|`BlockQueueTime_dm_0`|TODO|int|count|
|`BlockQueueTime_dm_1`|TODO|int|count|
|`BlockQueueTime_sda`|TODO|int|count|
|`BlockQueueTime_sr0`|TODO|int|count|
|`BlockReadBytes_dm_0`|TODO|int|count|
|`BlockReadBytes_dm_1`|TODO|int|count|
|`BlockReadBytes_sda`|TODO|int|count|
|`BlockReadBytes_sr0`|TODO|int|count|
|`BlockReadMerges_dm_0`|TODO|int|count|
|`BlockReadMerges_dm_1`|TODO|int|count|
|`BlockReadMerges_sda`|TODO|int|count|
|`BlockReadMerges_sr0`|TODO|int|count|
|`BlockReadOps_dm_0`|TODO|int|count|
|`BlockReadOps_dm_1`|TODO|int|count|
|`BlockReadOps_sda`|TODO|int|count|
|`BlockReadOps_sr0`|TODO|int|count|
|`BlockReadTime_dm_0`|TODO|int|count|
|`BlockReadTime_dm_1`|TODO|int|count|
|`BlockReadTime_sda`|TODO|int|count|
|`BlockReadTime_sr0`|TODO|int|count|
|`BlockWriteBytes_dm_0`|TODO|int|count|
|`BlockWriteBytes_dm_1`|TODO|int|count|
|`BlockWriteBytes_sda`|TODO|int|count|
|`BlockWriteBytes_sr0`|TODO|int|count|
|`BlockWriteMerges_dm_0`|TODO|int|count|
|`BlockWriteMerges_dm_1`|TODO|int|count|
|`BlockWriteMerges_sda`|TODO|int|count|
|`BlockWriteMerges_sr0`|TODO|int|count|
|`BlockWriteOps_dm_0`|TODO|int|count|
|`BlockWriteOps_dm_1`|TODO|int|count|
|`BlockWriteOps_sda`|TODO|int|count|
|`BlockWriteOps_sr0`|TODO|int|count|
|`BlockWriteTime_dm_0`|TODO|int|count|
|`BlockWriteTime_dm_1`|TODO|int|count|
|`BlockWriteTime_sda`|TODO|int|count|
|`BlockWriteTime_sr0`|TODO|int|count|
|`CPUFrequencyMHz_0`|TODO|int|count|
|`CompiledExpressionCacheBytes`|TODO|int|count|
|`CompiledExpressionCacheCount`|TODO|int|count|
|`DiskAvailable_default`|TODO|int|count|
|`DiskTotal_default`|TODO|int|count|
|`DiskUnreserved_default`|TODO|int|count|
|`DiskUsed_default`|TODO|int|count|
|`FilesystemLogsPathAvailableByte`|TODO|int|count|
|`FilesystemLogsPathAvailableINodes`|TODO|int|count|
|`FilesystemLogsPathTotalBytes`|TODO|int|count|
|`FilesystemLogsPathTotalINodes`|TODO|int|count|
|`FilesystemLogsPathUsedBytes`|TODO|int|count|
|`FilesystemLogsPathUsedINodes`|TODO|int|count|
|`FilesystemMainPathAvailableBytes`|TODO|int|count|
|`FilesystemMainPathAvailableINodes`|TODO|int|count|
|`FilesystemMainPathTotalBytes`|TODO|int|count|
|`FilesystemMainPathTotalINodes`|TODO|int|count|
|`FilesystemMainPathUsedBytes`|TODO|int|count|
|`FilesystemMainPathUsedINodes`|TODO|int|count|
|`HTTPThreads`|TODO|int|count|
|`InterserverThreads`|TODO|int|count|
|`Jitter`|TODO|int|count|
|`LoadAverage1`|TODO|int|count|
|`LoadAverage15`|TODO|int|count|
|`LoadAverage5`|TODO|int|count|
|`MMapCacheCells`|TODO|int|count|
|`MarkCacheBytes`|TODO|int|count|
|`MarkCacheFiles`|TODO|int|count|
|`MaxPartCountForPartition`|TODO|int|count|
|`MemoryCode`|TODO|int|count|
|`MemoryDataAndStack`|TODO|int|count|
|`MemoryResident`|TODO|int|count|
|`MemoryShared`|TODO|int|count|
|`MemoryVirtual`|TODO|int|count|
|`MySQLThreads`|TODO|int|count|
|`NetworkReceiveBytes_ens33`|TODO|int|count|
|`NetworkReceiveBytes_virbr0`|TODO|int|count|
|`NetworkReceiveBytes_virbr0_nic`|TODO|int|count|
|`NetworkReceiveDrop_ens33`|TODO|int|count|
|`NetworkReceiveDrop_virbr0`|TODO|int|count|
|`NetworkReceiveDrop_virbr0_nic`|TODO|int|count|
|`NetworkReceiveErrors_ens33`|TODO|int|count|
|`NetworkReceiveErrors_virbr0`|TODO|int|count|
|`NetworkReceiveErrors_virbr0_nic`|TODO|int|count|
|`NetworkReceivePackets_ens33`|TODO|int|count|
|`NetworkReceivePackets_virbr0`|TODO|int|count|
|`NetworkReceivePackets_virbr0_nic`|TODO|int|count|
|`NetworkSendBytes_ens33`|TODO|int|count|
|`NetworkSendBytes_virbr0`|TODO|int|count|
|`NetworkSendBytes_virbr0_nic`|TODO|int|count|
|`NetworkSendDrop_ens33`|TODO|int|count|
|`NetworkSendDrop_virbr0`|TODO|int|count|
|`NetworkSendDrop_virbr0_nic`|TODO|int|count|
|`NetworkSendErrors_ens33`|TODO|int|count|
|`NetworkSendErrors_virbr0`|TODO|int|count|
|`NetworkSendErrors_virbr0_nic`|TODO|int|count|
|`NetworkSendPackets_ens33`|TODO|int|count|
|`NetworkSendPackets_virbr0`|TODO|int|count|
|`NetworkSendPackets_virbr0_nic`|TODO|int|count|
|`NumberOfDatabases`|TODO|int|count|
|`NumberOfTables`|TODO|int|count|
|`OSContextSwitches`|TODO|int|count|
|`OSGuestNiceTime`|TODO|int|count|
|`OSGuestNiceTimeCPU0`|TODO|int|count|
|`OSGuestNiceTimeNormalized`|TODO|int|count|
|`OSGuestTime`|TODO|int|count|
|`OSGuestTimeCPU0`|TODO|int|count|
|`OSGuestTimeNormalized`|TODO|int|count|
|`OSIOWaitTime`|TODO|int|count|
|`OSIOWaitTimeCPU0`|TODO|int|count|
|`OSIOWaitTimeNormalized`|TODO|int|count|
|`OSIdleTime`|TODO|int|count|
|`OSIdleTimeCPU0`|TODO|int|count|
|`OSIdleTimeNormalized`|TODO|int|count|
|`OSInterrupts`|TODO|int|count|
|`OSIrqTime`|TODO|int|count|
|`OSIrqTimeCPU0`|TODO|int|count|
|`OSIrqTimeNormalized`|TODO|int|count|
|`OSMemoryAvailable`|TODO|int|count|
|`OSMemoryCached`|TODO|int|count|
|`OSMemoryFreePlusCached`|TODO|int|count|
|`OSMemoryFreeWithoutCached`|TODO|int|count|
|`OSMemorySwapCached`|TODO|int|count|
|`OSMemoryTotal`|TODO|int|count|
|`OSNiceTime`|TODO|int|count|
|`OSNiceTimeCPU0`|TODO|int|count|
|`OSNiceTimeNormalized`|TODO|int|count|
|`OSOpenFiles`|TODO|int|count|
|`OSProcessesBlocked`|TODO|int|count|
|`OSProcessesCreated`|TODO|int|count|
|`OSProcessesRunning`|TODO|int|count|
|`OSSoftIrqTime`|TODO|int|count|
|`OSSoftIrqTimeCPU0`|TODO|int|count|
|`OSSoftIrqTimeNormalized`|TODO|int|count|
|`OSStealTime`|TODO|int|count|
|`OSStealTimeCPU0`|TODO|int|count|
|`OSStealTimeNormalized`|TODO|int|count|
|`OSSystemTime`|TODO|int|count|
|`OSSystemTimeCPU0`|TODO|int|count|
|`OSSystemTimeNormalized`|TODO|int|count|
|`OSThreadsRunnable`|TODO|int|count|
|`OSThreadsTotal`|TODO|int|count|
|`OSUptime`|TODO|int|count|
|`OSUserTime`|TODO|int|count|
|`OSUserTimeCPU0`|TODO|int|count|
|`OSUserTimeNormalized`|TODO|int|count|
|`PostgreSQLThreads`|TODO|int|count|
|`PrometheusThreads`|TODO|int|count|
|`ReplicasMaxAbsoluteDelay`|TODO|int|count|
|`ReplicasMaxInsertsInQueue`|TODO|int|count|
|`ReplicasMaxMergesInQueue`|TODO|int|count|
|`ReplicasMaxQueueSize`|TODO|int|count|
|`ReplicasMaxRelativeDelay`|TODO|int|count|
|`ReplicasSumInsertsInQueue`|TODO|int|count|
|`ReplicasSumMergesInQueue`|TODO|int|count|
|`ReplicasSumQueueSize`|TODO|int|count|
|`TCPThreads`|TODO|int|count|
|`TotalBytesOfMergeTreeTables`|TODO|int|count|
|`TotalPartsOfMergeTreeTables`|TODO|int|count|
|`TotalRowsOfMergeTreeTables`|TODO|int|count|
|`UncompressedCacheBytes`|TODO|int|count|
|`UncompressedCacheCells`|TODO|int|count|
|`Uptime`|TODO|int|count|
|`jemalloc_active`|TODO|int|count|
|`jemalloc_allocated`|TODO|int|count|
|`jemalloc_arenas_all_dirty_purged`|TODO|int|count|
|`jemalloc_arenas_all_muzzy_purged`|TODO|int|count|
|`jemalloc_arenas_all_pactive`|TODO|int|count|
|`jemalloc_arenas_all_pdirty`|TODO|int|count|
|`jemalloc_arenas_all_pmuzzy`|TODO|int|count|
|`jemalloc_background_thread_num_runs`|TODO|int|count|
|`jemalloc_background_thread_num_threads`|TODO|int|count|
|`jemalloc_background_thread_run_intervals`|TODO|int|count|
|`jemalloc_epoch`|TODO|int|count|
|`jemalloc_mapped`|TODO|int|count|
|`jemalloc_metadata`|TODO|int|count|
|`jemalloc_metadata_thp`|TODO|int|count|
|`jemalloc_resident`|TODO|int|count|
|`jemalloc_retained`|TODO|int|count| 





### `ClickHouseMetrics`



- tag


| Tag | Description |
|  ----  | --------|
|`host`|host name|

- field list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`ActiveAsyncDrainedConnections`|Number of active connections drained asynchronously.|int|count|
|`ActiveSyncDrainedConnections`|Number of active connections drained synchronously.|int|count|
|`AsyncDrainedConnections`|Number of connections drained asynchronously.|int|count|
|`AsynchronousReadWait`|Number of threads waiting for asynchronous read.|int|count|
|`BackgroundBufferFlushSchedulePoolTask`|Number of active tasks in BackgroundBufferFlushSchedulePool. This pool is used for periodic Buffer flushes|int|count|
|`BackgroundCommonPoolTask`|Number of active tasks in an associated background pool|int|count|
|`BackgroundDistributedSchedulePoolTask`|Number of active tasks in BackgroundDistributedSchedulePool.|int|count|
|`BackgroundFetchesPoolTask`|Number of active fetches in an associated background pool|int|count|
|`BackgroundMergesAndMutationsPoolTask`|Number of active merges and mutations in an associated background pool|int|count|
|`BackgroundMessageBrokerSchedulePoolTask`|Number of active tasks in BackgroundProcessingPool for message streaming|int|count|
|`BackgroundMovePoolTask`|Number of active tasks in BackgroundProcessingPool for moves|int|count|
|`BackgroundSchedulePoolTask`|Number of active tasks in BackgroundSchedulePool.|int|count|
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
|`PartsDeleting`|Not active data part with identity *refcounter*, it is deleting right now by a cleaner.|int|count|
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
|`Read`|Number of read (`read/pread/io_getevents` etc.) syscall in fly|int|count|
|`ReadonlyReplica`|Number of Replicated tables that are currently in readonly state due to re-initialization after ZooKeeper session loss or due to startup without ZooKeeper configured.|int|count|
|`ReplicatedChecks`|Number of data parts checking for consistency|int|count|
|`ReplicatedFetch`|Number of data parts being fetched from replica|int|count|
|`ReplicatedSend`|Number of data parts being sent to replicas|int|count|
|`Revision Revision`|of the server. It is a number incremented for every release or release candidate except patch releases.|int|count|
|`SendExternalTables`|Number of connections that are sending data for external tables to remote servers.|int|count|
|`SendScalars`|Number of connections that are sending data for scalars to remote servers.|int|count|
|`StorageBufferBytes`|Number of bytes in buffers of Buffer tables|int|count|
|`StorageBufferRows`|Number of rows in buffers of Buffer tables|int|count|
|`SyncDrainedConnections`|Number of connections drained synchronously.|int|count|
|`TCPConnection`|Number of connections to TCP server (clients with native interface), also included server-server distributed query connections|int|count|
|`TablesToDropQueueSize`|Number of dropped tables, that are waiting for background data removal.|int|count|
|`VersionInteger`|Version of the server in a single integer number in base-1000. For example, version 11.22.33 is translated to 11022033.|int|count|
|`Write`|Number of write (`write/pwrite/io_getevents`, etc.) syscall in fly|int|count|
|`ZooKeeperRequest`|Number of requests to ZooKeeper in fly.|int|count|
|`ZooKeeperSession`|Number of sessions (connections) to ZooKeeper.|int|count|
|`ZooKeeperWatch`|Number of watches (event subscriptions) in ZooKeeper.|int|count| 





### `ClickHouseProfileEvents`



- tag


| Tag | Description |
|  ----  | --------|
|`host`|host name|

- field list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`AIORead`|Number of reads with Linux or FreeBSD AIO interface|int|count|
|`AIOReadBytes`|Number of bytes read with Linux or FreeBSD AIO interface|int|count|
|`AIOWrite`|Number of writes with Linux or FreeBSD AIO interface|int|count|
|`AIOWriteBytes`|Number of bytes written with Linux or FreeBSD AIO interface|int|count|
|`ArenaAllocBytes`|TODO|int|count|
|`ArenaAllocChunks`|TODO|int|count|
|`AsynchronousReadWaitMicroseconds`|Time spent in waiting for asynchronous reads.|int|count|
|`CannotRemoveEphemeralNode`|Number of times an error happened while trying to remove ephemeral node.|int|count|
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
|`CreatedReadBufferDirectIO`|TODO|int|count|
|`CreatedReadBufferDirectIOFailed`|TODO|int|count|
|`CreatedReadBufferMMap`|TODO|int|count|
|`CreatedReadBufferMMapFailed`|TODO|int|count|
|`CreatedReadBufferOrdinary`|TODO|int|count|
|`DNSError`|Total count of errors in DNS resolution|int|count|
|`DataAfterMergeDiffersFromReplica`|TODO|int|count|
|`DataAfterMutationDiffersFromReplica`|TODO|int|count|
|`DelayedInserts`|Number of times the INSERT of a block to a MergeTree table was throttled due to high number of active data parts for partition.|int|count|
|`DelayedInsertsMilliseconds`|Total number of milliseconds spent while the INSERT of a block to a MergeTree table was throttled due to high number of active data parts for partition.|int|count|
|`DictCacheKeysExpired`|TODO|int|count|
|`DictCacheKeysHit`|TODO|int|count|
|`DictCacheKeysNotFound`|TODO|int|count|
|`DictCacheKeysRequested`|TODO|int|count|
|`DictCacheKeysRequestedFound`|TODO|int|count|
|`DictCacheKeysRequestedMiss`|TODO|int|count|
|`DictCacheLockReadNs`|TODO|int|count|
|`DictCacheLockWriteNs`|TODO|int|count|
|`DictCacheRequestTimeNs`|TODO|int|count|
|`DictCacheRequests`|TODO|int|count|
|`DiskReadElapsedMicroseconds`|Total time spent waiting for read syscall. This include reads from page cache.|int|count|
|`DiskWriteElapsedMicroseconds`|Total time spent waiting for write syscall. This include writes to page cache.|int|count|
|`DistributedConnectionFailAtAll`|Total count when distributed connection fails after all retries finished|int|count|
|`DistributedConnectionFailTry`|Total count when distributed connection fails with retry|int|count|
|`DistributedConnectionMissingTable`|TODO|int|count|
|`DistributedConnectionStaleReplica`|TODO|int|count|
|`DistributedDelayedInserts`|Number of times the INSERT of a block to a Distributed table was throttled due to high number of pending bytes.|int|count|
|`DistributedDelayedInsertsMilliseconds`|Total number of milliseconds spent while the INSERT of a block to a Distributed table was throttled due to high number of pending bytes.|int|count|
|`DistributedRejectedInserts`|Number of times the INSERT of a block to a Distributed table was rejected with 'Too many bytes' exception due to high number of pending bytes.|int|count|
|`DistributedSyncInsertionTimeoutExceeded`|TODO|int|count|
|`DuplicatedInsertedBlocks`|Number of times the INSERTed block to a ReplicatedMergeTree table was deduplicated.|int|count|
|`ExternalAggregationCompressedBytes`|TODO|int|count|
|`ExternalAggregationMerge`|TODO|int|count|
|`ExternalAggregationUncompressedBytes`|TODO|int|count|
|`ExternalAggregationWritePart`|TODO|int|count|
|`ExternalSortMerge`|TODO|int|count|
|`ExternalSortWritePart`|TODO|int|count|
|`FailedInsertQuery`|Same as FailedQuery, but only for INSERT queries|int|count|
|`FailedQuery`|Number of failed queries.|int|count|
|`FailedSelectQuery`|Same as FailedQuery, but only for SELECT queries|int|count|
|`FileOpen`|Number of files opened|int|count|
|`FunctionExecute`|TODO|int|count|
|`HardPageFaults`|TODO|int|count|
|`HedgedRequestsChangeReplica`|Total count when timeout for changing replica expired in hedged requests.|int|count|
|`IOBufferAllocBytes`|TODO|int|count|
|`IOBufferAllocs`|TODO|int|count|
|`InsertQuery`|Same as Query, but only for INSERT queries|int|count|
|`InsertQueryTimeMicroseconds`|Total time of INSERT queries.|int|count|
|`InsertedBytes`|Number of bytes (uncompressed; for columns as they stored in memory) inserted to all tables.|int|count|
|`InsertedRows`|Number of rows inserted to all tables.|int|count|
|`InvoluntaryContextSwitches`|TODO|int|count|
|`MarkCacheHits`|TODO|int|count|
|`MarkCacheMisses`|TODO|int|count|
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
|`OSReadBytes`|Number of bytes read from disks or block devices. Doesn't include bytes read from page cache.|int|count|
|`OSReadChars`|Number of bytes read from filesystem, including page cache.|int|count|
|`OSWriteBytes`|Number of bytes written to disks or block devices. Doesn't include bytes that are in page cache dirty pages.|int|count|
|`OSWriteChars`|Number of bytes written to filesystem, including page cache.|int|count|
|`ObsoleteReplicatedParts`|TODO|int|count|
|`PerfAlignmentFaults`|Number of alignment faults. These happen when unaligned memory accesses happen; the kernel can handle these but it reduces performance.|int|count|
|`PerfBranchInstructions`|Retired branch instructions. Prior to Linux 2.6.35, this used the wrong event on AMD processors.|int|count|
|`PerfBranchMisses`|Mis-predicted branch instructions.|int|count|
|`PerfBusCycles`|Bus cycles, which can be different from total cycles.|int|count|
|`PerfCacheMisses`|Cache misses. Usually this indicates Last Level Cache misses.|int|count|
|`PerfCacheReferences`|Cache accesses. Usually this indicates Last Level Cache accesses but this may vary depending on your CPU.|int|count|
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
|`PolygonsAddedToPool`|TODO|int|count|
|`PolygonsInPoolAllocatedBytes`|TODO|int|count|
|`Query`|Number of queries to be interpreted and potentially executed.|int|count|
|`QueryMaskingRulesMatch`|Number of times query masking rules was successfully matched.|int|count|
|`QueryMemoryLimitExceeded`|Number of times when memory limit exceeded for query.|int|count|
|`QueryProfilerRuns`|Number of times QueryProfiler had been run.|int|count|
|`QueryProfilerSignalOverruns`|Number of times we drop processing of a query profiler signal due to overrun plus the number of signals that OS has not delivered due to overrun.|int|count|
|`QueryTimeMicroseconds`|Total time of all queries.|int|count|
|`RWLockAcquiredReadLocks`|TODO|int|count|
|`RWLockAcquiredWriteLocks`|TODO|int|count|
|`RWLockReadersWaitMilliseconds`|TODO|int|count|
|`RWLockWritersWaitMilliseconds`|TODO|int|count|
|`ReadBackoff`|Number of times the number of query processing threads was lowered due to slow reads.|int|count|
|`ReadBufferFromFileDescriptorRead`|Number of reads (`read/pread`) from a file descriptor. Does not include sockets.|int|count|
|`ReadBufferFromFileDescriptorReadBytes`|Number of bytes read from file descriptors. If the file is compressed, this will show the compressed data size.|int|count|
|`ReadBufferFromFileDescriptorReadFailed`|Number of times the read (`read/pread`) from a file descriptor have failed.|int|count|
|`ReadCompressedBytes`|Number of bytes (the number of bytes before decompression) read from compressed sources (files, network).|int|count|
|`RealTimeMicroseconds`|Total (wall clock) time spent in processing (queries and other tasks) threads (not that this is a sum).|int|count|
|`RegexpCreated`|Compiled regular expressions. Identical regular expressions compiled just once and cached forever.|int|count|
|`RejectedInserts`|Number of times the INSERT of a block to a MergeTree table was rejected with 'Too many parts' exception due to high number of active data parts for partition.|int|count|
|`RemoteFSBuffers`|Number of buffers created for asynchronous reading from remote filesystem|int|count|
|`RemoteFSCancelledPrefetches`|Number of canceled prefetch (because of seek)|int|count|
|`RemoteFSPrefetchedReads`|Number of reads from prefetched buffer|int|count|
|`RemoteFSPrefetches`|Number of prefetches made with asynchronous reading from remote filesystem|int|count|
|`RemoteFSReadBytes`|Read bytes from remote filesystem.|int|count|
|`RemoteFSReadMicroseconds`|Time of reading from remote filesystem.|int|count|
|`RemoteFSSeeks`|Total number of seeks for async buffer|int|count|
|`RemoteFSUnprefetchedReads`|Number of reads from un-prefetched buffer|int|count|
|`RemoteFSUnusedPrefetches`|Number of prefetches pending at buffer destruction|int|count|
|`ReplicaPartialShutdown`|How many times Replicated table has to de-initialize its state due to session expiration in ZooKeeper.|int|count|
|`ReplicatedDataLoss`|Number of times a data part that we wanted doesn't exist on any replica (even on replicas that are offline right now).|int|count|
|`ReplicatedPartChecks`|TODO|int|count|
|`ReplicatedPartChecksFailed`|TODO|int|count|
|`ReplicatedPartFailedFetches`|Number of times a data part was failed to download from replica of a ReplicatedMergeTree table.|int|count|
|`ReplicatedPartFetches`|Number of times a data part was downloaded from replica of a ReplicatedMergeTree table.|int|count|
|`ReplicatedPartFetchesOfMerged`|Number of times we prefer to download already merged part from replica of ReplicatedMergeTree table instead of performing a merge ourself.|int|count|
|`ReplicatedPartMerges`|Number of times data parts of ReplicatedMergeTree tables were successfully merged.|int|count|
|`ReplicatedPartMutations`|TODO|int|count|
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
|`Seek`|Number of times the `lseek` function was called.|int|count|
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
|`SoftPageFaults`|TODO|int|count|
|`StorageBufferErrorOnFlush`|TODO|int|count|
|`StorageBufferFlush`|TODO|int|count|
|`StorageBufferLayerLockReadersWaitMilliseconds`|Time for waiting for Buffer layer during reading|int|count|
|`StorageBufferLayerLockWritersWaitMilliseconds`|Time for waiting free Buffer layer to write to (can be used to tune Buffer layers)|int|count|
|`StorageBufferPassedAllMinThresholds`|TODO|int|count|
|`StorageBufferPassedBytesFlushThreshold`|TODO|int|count|
|`StorageBufferPassedBytesMaxThreshold`|TODO|int|count|
|`StorageBufferPassedRowsFlushThreshold`|TODO|int|count|
|`StorageBufferPassedRowsMaxThreshold`|TODO|int|count|
|`StorageBufferPassedTimeFlushThreshold`|TODO|int|count|
|`StorageBufferPassedTimeMaxThreshold`|TODO|int|count|
|`SystemTimeMicroseconds`|Total time spent in processing (queries and other tasks) threads executing CPU instructions in OS kernel space.|int|count|
|`TableFunctionExecute`|TODO|int|count|
|`ThreadPoolReaderPageCacheHit`|Number of times the read inside ThreadPoolReader was done from page cache.|int|count|
|`ThreadPoolReaderPageCacheHitBytes`|Number of bytes read inside ThreadPoolReader when it was done from page cache.|int|count|
|`ThreadPoolReaderPageCacheHitElapsedMicroseconds`|Time spent reading data from page cache in ThreadPoolReader.|int|count|
|`ThreadPoolReaderPageCacheMiss`|Number of times the read inside ThreadPoolReader was not done from page cache and was hand off to thread pool.|int|count|
|`ThreadPoolReaderPageCacheMissBytes`|Number of bytes read inside ThreadPoolReader when read was not done from page cache and was hand off to thread pool.|int|count|
|`ThreadPoolReaderPageCacheMissElapsedMicroseconds`|Time spent reading data inside the asynchronous job in ThreadPoolReader - when read was not done from page cache.|int|count|
|`ThrottlerSleepMicroseconds`|Total time a query was sleeping to conform the 'max_network_bandwidth' setting.|int|count|
|`UserTimeMicroseconds`|Total time spent in processing (queries and other tasks) threads executing CPU instructions in user space.|int|count|
|`VoluntaryContextSwitches`|TODO|int|count|
|`WriteBufferFromFileDescriptorWrite`|Number of writes (`write/pwrite`) to a file descriptor. Does not include sockets|int|count|
|`WriteBufferFromFileDescriptorWriteBytes`|Number of bytes written to file descriptors. If the file is compressed, this will show compressed data size.|int|count|
|`WriteBufferFromFileDescriptorWriteFailed`|Number of times the write (`write/pwrite`) to a file descriptor have failed.|int|count|
|`ZooKeeperBytesReceived`|TODO|int|count|
|`ZooKeeperBytesSent`|TODO|int|count|
|`ZooKeeperCheck`|TODO|int|count|
|`ZooKeeperClose`|TODO|int|count|
|`ZooKeeperCreate`|TODO|int|count|
|`ZooKeeperExists`|TODO|int|count|
|`ZooKeeperGet`|TODO|int|count|
|`ZooKeeperHardwareExceptions`|TODO|int|count|
|`ZooKeeperInit`|TODO|int|count|
|`ZooKeeperList`|TODO|int|count|
|`ZooKeeperMulti`|TODO|int|count|
|`ZooKeeperOtherExceptions`|TODO|int|count|
|`ZooKeeperRemove`|TODO|int|count|
|`ZooKeeperSet`|TODO|int|count|
|`ZooKeeperTransactions`|TODO|int|count|
|`ZooKeeperUserExceptions`|TODO|int|count|
|`ZooKeeperWaitMicroseconds`|TODO|int|count|
|`ZooKeeperWatchResponse`|TODO|int|count| 





### `ClickHouseStatusInfo`



- tag


| Tag | Description |
|  ----  | --------|
|`host`|host name|

- field list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`DictionaryStatus`|Dictionary Status.|int|count| 


