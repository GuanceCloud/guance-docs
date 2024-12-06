---
title     : 'HBase Region'
summary   : 'Collect HBase Region Metric Information'
__int_icon: 'icon/hbase'
dashboard :
  - desc  : 'HBase Region Built in View'
    path  : 'dashboard/en/hbase_region'
---

Collect HBase Region Metric Information

## Config {#config}

### 1.HBase Region configuration

#### 1.1 Download jmx-exporter

Download link：`https://github.com/prometheus/jmx_exporter`

#### 1.2 Download jmx script

Download link：`https://github.com/lrwh/jmx-exporter/blob/main/hbase.yaml`

#### 1.3 HBase Region Startup Parameter Adjustment

Add startup parameters in HBase Region

> {{JAVA_GC_ARGS}} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:9407:/opt/guance/jmx/hbase.yaml

#### 1.4 Restart HBase

### 2. DataKit Collector Configuration

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Configure collector

By using jmx exporter, the `metrics` URL can be directly exposed, so it can be collected directly through the [prom](./prom.md) collector.

Go to the `conf.d/prom` directory under the [DataKit installation directory](./datakit-dir.md), and copy `prom.conf.sample` to `region.conf`.

> `cp prom.conf.sample region.conf`

Adjust the content of `region.conf` as follows:

```toml
  urls = ["http://localhost:9407/metrics"]
  source ="hbase-region"
  [inputs.prom.tags]
    component = "hbase-region" 
  interval = "10s"
```

<!-- markdownlint-disable MD033 -->
<font color="red">*Adjust other configurations as needed*</font>，parameter adjustment instructions ：
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD004 -->
- urls：`jmx-exporter` metric address, fill in the URL of the metric exposed by the corresponding component here
- source：Collector alias, it is recommended to make a distinction
- keep_exist_metric_name: Maintain metric name
- interval：Collection interval
- inputs.prom.tags: Add additional tags
<!-- markdownlint-enable -->

### 3. Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metric {#metric}

### Hadoop Metric Set

The HBase Region metric is located under the Hadoop metric set, and here we mainly introduce the description of HBase Region related metrics.

| Metrics | Description |Unit |
|:--------|:-----|:--|
|`hadoop_hbase_regionCount` |`Number of regions hosted by regional servers` | count |
|`hadoop_hbase_storeFileCount` |`The current number of stored files on the disk managed by regionserver` | count |
|`hadoop_hbase_storeFileSize` |`Aggregate size of files stored on disk` | byte |
|`hadoop_hbase_hlogFileCount` |`Number of pre written logs that have not been archived yet` | count |
|`hadoop_hbase_totalRequestCount` |`Total number of requests received` | count |
|`hadoop_hbase_readRequestCount` |`Number of read requests received` | count |
|`hadoop_hbase_writeRequestCount` |`Number of write requests received` | count |
|`hadoop_hbase_numOpenConnections` |`The number of open connections in the RPC layer` | count |
|`hadoop_hbase_numActiveHandler` |`The number of RPC handlers actively serving requests` | count |
|`hadoop_hbase_numCallsInGeneralQueue` |`The current number of queued user requests` | count |
|`hadoop_hbase_numCallsInReplicationQueue` |`The current number of queued operations received from replication` | count |
|`hadoop_hbase_numCallsInPriorityQueue` |`The number of priority (internal steward) requests currently queued` | count |
|`hadoop_hbase_flushQueueLength` |`The current depth of the memstore refresh queue` | count |
|`hadoop_hbase_updatesBlockedTime` |`The number of milliseconds that the update has been blocked, so the memstore can be refreshed` | ms |
|`hadoop_hbase_compactionQueueLength` |`The current depth of the compressed request queue` | count |
|`hadoop_hbase_blockCacheHitCount` |`Block cache hit count` | count |
|`hadoop_hbase_blockCacheMissCount` |`The current depth of the memstore refresh queue` | count |
|`hadoop_hbase_blockCacheExpressHitPercent` |`The percentage of time to open cache requests reaches cache` | count |
|`hadoop_hbase_percentFilesLocal` |`The percentage of stored file data that can be read from the local DataNode` | count |
|`hadoop_hbase_append_99th_percentile` |`The 99th percentile value of the Append operation time` | ms |
|`hadoop_hbase_delete_99th_percentile` |`99th percentile value of Delete operation time` | ms |
|`hadoop_hbase_get_99th_percentile` |`99th percentile value of Get operation time` | ms |
|`hadoop_hbase_checkandput_99th_percentile` |`99th percentile value of CheckAndPut operation time` | ms |
|`hadoop_hbase_checkanddelete_99th_percentile` |`99th percentile value of CheckAndDelete operation time` | ms |
|`hadoop_hbase_increment_99th_percentile` |`99th percentile value of incremental operation time` | ms |
|`hadoop_hbase_hedgedreadwins` |`The number of successful hedged read operations` | count |
|`hadoop_hbase_hedgedreads` |`The total number of hedged read operations` | count |
|`hadoop_hbase_hedgedreadopsincurthread` |`The number of hedged read operations in the current thread` | count |
|`hadoop_hbase_l1cachehitratio` |`L1 cache hit rate` | % |
|`hadoop_hbase_l1cachemissratio` |`L1 cache miss rate` | % |
|`hadoop_hbase_l2cachehitratio` |`Hit rate of L2 cache` | % |
|`hadoop_hbase_l2cachemissratio` |`L2 cache miss rate` | % |
|`hadoop_hbase_logerror` |`Number of errors recorded` | count |
|`hadoop_hbase_logfatal` |`Number of fatal errors recorded` | count |
|`hadoop_hbase_loginfo` |`Number of information level logs recorded` | count |
|`hadoop_hbase_logwarn` |`Number of warnings recorded` | count |
|`hadoop_hbase_majorcompactiontime_max` |`Maximum time for compression operation` | ms |
|`hadoop_hbase_majorcompactiontime_mean` |`The average time for compression operation` | ms |
|`hadoop_hbase_majorcompactiontime_median` |`Median time of compression operation` | ms |
|`hadoop_hbase_majorcompactiontime_min` |`Minimum time for compression operation` | ms |
|`hadoop_hbase_maxstorefileage` |`Maximum storage file age` | count |
|`hadoop_hbase_memheapcommittedm` |`The amount of committed memory in heap memory` | MB |
|`hadoop_hbase_memheapmaxm` |`Maximum amount of heap memory` | MB |
|`hadoop_hbase_memheapusedm` |`The amount of memory used in heap memory` | MB |
|`hadoop_hbase_memmaxm` |`Maximum amount of total memory` | MB |
|`hadoop_hbase_memnonheapcommittedm` |`The amount of committed memory in non heap memory` | MB |
|`hadoop_hbase_memnonheapmaxm` |`Maximum amount of non heap memory` | MB |
|`hadoop_hbase_memnonheapusedm` |`The amount of memory used in non heap memory` | MB |
|`hadoop_hbase_mobfilecachehitpercent` |`Hit rate percentage of MOB file cache` | % |
|`hadoop_hbase_mutationswithoutwalcount` |`Number of changes without pre writing log (WAL)` | count |
|`hadoop_hbase_averageregionsize` |`The average size of the region` | MB |
|`hadoop_hbase_avgstorefileage` |`The average age of stored files` | ms |
|`hadoop_hbase_blockcachecount` |`The total number of blocks in the block cache` | count |
|`hadoop_hbase_blockcachecounthitpercent` |`Percentage hit rate of block cache` | % |
|`hadoop_hbase_blockcachedatahitcount` |`The number of data block hits in the block cache` | count |
|`hadoop_hbase_blockcacheevictioncount` |`Number of eviction times for block cache` | count |
|`hadoop_hbase_blockcachehitcount` |`The number of hits in the block cache` | count |
|`hadoop_hbase_blockcachemisscount` |`Number of misses in block cache` | count |
|`hadoop_hbase_compactioninputfilecount_99th_percentile` |`99th percentile value of the number of input files for compression operation` | count |
|`hadoop_hbase_compactionoutputfilecount_99th_percentile` |`99th percentile value of the number of output files for compression operation` | count |
|`hadoop_hbase_compactiontime_99th_percentile` |`99th percentile value of compression operation time` | ms |
|`hadoop_hbase_flushedmemstorebytes` |`Number of refreshed MemStore bytes` | byte |
|`hadoop_hbase_flushedoutputbytes` |`Number of output bytes refreshed` | byte |
|`hadoop_hbase_flushmemstoresize_99th_percentile` |`Refresh the 99th percentile value of MemStore size` | byte |
|`hadoop_hbase_flushoutputsize_99th_percentile` |`Refresh the 99th percentile of output size` | byte |
|`hadoop_hbase_flushtime_99th_percentile` |`99th percentile value of refresh operation time` | ms |
|`hadoop_hbase_get_25th_percentile` |`25th percentile value of Get operation time` | ms |
|`hadoop_hbase_slowappendcount` |`The number of slow append operations` | count |
|`hadoop_hbase_slowdeletecount` |`The number of slow delete operations` | count |
|`hadoop_hbase_slowgetcount` |`The number of slow Get operations` | count |
|`hadoop_hbase_slowincrementcount` |`The number of slow increment operations` | count |
|`hadoop_hbase_slowputcount` |`The number of slow put operations` | count |
|`hadoop_hbase_snapshotavgtime` |`The average time for snapshot operations` | ms |
|`hadoop_hbase_snapshotnumops` |`The total number of snapshot operations` | count |
|`hadoop_hbase_source_logeditsread` |`Number of log edits read by Source` | count |
|`hadoop_hbase_source_shippedbytes` |`The number of bytes shipped by Source` | byte |
|`hadoop_hbase_source_shippedops` |`Number of operations for Source shipment` | count |
|`hadoop_hbase_splitreuestcount` |`The number of split requests` | count |
|`hadoop_hbase_splitsuccesscount` |`The total number of successful splits` | count |
|`hadoop_hbase_staticbloomsize` |`Size of static Bloom filter` | count |
|`hadoop_hbase_staticindexsize` |`Size of static index` | count |
|`hadoop_hbase_storefileindexsize` |`Size of storage file index` | count |
|`hadoop_hbase_storefilesize` |`Size of stored files` | count |
|`hadoop_hbase_successfullogrolls` |`The number of successful log scrolls` | count |
|`hadoop_hbase_synctime_99th_percentile` |`99th percentile value of synchronous operation time` | ms |
|`hadoop_hbase_tunerdonothingcounter` |`The number of times the tuner has no operation` | count |
|`hadoop_hbase_updatesblockedtime` |`The time when the update operation was blocked` | ms |
|`hadoop_hbase_writereuestcount` |`The total number of requests written` | count |
|`hadoop_hbase_writtenbytes` |`Total number of bytes written` | byte |
|`hadoop_hbase_zerocopybytesread` |`Zero copy read byte count` | byte |
