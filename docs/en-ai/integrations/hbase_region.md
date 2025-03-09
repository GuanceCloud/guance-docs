---
title     : 'HBase Region'
summary   : 'Collect HBase Region Metrics Information'
__int_icon: 'icon/hbase'
dashboard :
  - desc  : 'Built-in Views for HBase Region'
    path  : 'dashboard/en/hbase_region'
---

Collect HBase Region Metrics Information

## Configuration {#config}

### 1. HBase Region Configuration

#### 1.1 Download jmx-exporter

Download link: `https://github.com/prometheus/jmx_exporter`

#### 1.2 Download jmx Script

Download link: `https://github.com/lrwh/jmx-exporter/blob/main/hbase.yaml`

#### 1.3 Adjust HBase Region Startup Parameters

Add the following to the HBase Region startup parameters:

> {JAVA_GC_ARGS} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:9407:/opt/guance/jmx/hbase.yaml

#### 1.4 Restart HBase

### 2. DataKit Collector Configuration

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Configure Collector

Since jmx-exporter can directly expose a `metrics` URL, you can use the [Prometheus](./prom.md) collector for data collection.

Navigate to the `conf.d/prom` directory under the [DataKit installation directory](./datakit_dir.md), and copy `prom.conf.sample` to `region.conf`.

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
<font color="red">*Other configurations should be adjusted as needed*</font>, parameter adjustment instructions:
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD004 -->
- urls: The `jmx-exporter` metrics address, fill in the metrics URL exposed by the corresponding component.
- source: Alias for the collector, it is recommended to differentiate.
- keep_exist_metric_name: Keep metric names unchanged.
- interval: Collection interval.
- inputs.prom.tags: Add additional tags.
<!-- markdownlint-enable -->

### 3. Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

### Hadoop Mearsurement Set

HBase Region metrics are located under the Hadoop Mearsurement set. This section mainly introduces the relevant metrics for HBase Region.

| Metrics | Description | Unit |
|:--------|:------------|:-----|
|`hadoop_hbase_regionCount` | Number of regions hosted by the region server | count |
|`hadoop_hbase_storeFileCount` | Number of store files on disk managed by the regionserver | count |
|`hadoop_hbase_storeFileSize` | Aggregate size of store files on disk | byte |
|`hadoop_hbase_hlogFileCount` | Number of unarchived pre-write logs | count |
|`hadoop_hbase_totalRequestCount` | Total number of received requests | count |
|`hadoop_hbase_readRequestCount` | Number of read requests received | count |
|`hadoop_hbase_writeRequestCount` | Number of write requests received | count |
|`hadoop_hbase_numOpenConnections` | Number of open connections at the RPC layer | count |
|`hadoop_hbase_numActiveHandler` | Number of RPC handlers actively servicing requests | count |
|`hadoop_hbase_numCallsInGeneralQueue` | Number of user requests currently queued | count |
|`hadoop_hbase_numCallsInReplicationQueue` | Number of replication operations currently queued | count |
|`hadoop_hbase_numCallsInPriorityQueue` | Number of priority (internal janitor) requests currently queued | count |
|`hadoop_hbase_flushQueueLength` | Current depth of the memstore flush queue | count |
|`hadoop_hbase_updatesBlockedTime` | Milliseconds updates have been blocked to flush the memstore | ms |
|`hadoop_hbase_compactionQueueLength` | Current depth of the compaction request queue | count |
|`hadoop_hbase_blockCacheHitCount` | Number of block cache hits | count |
|`hadoop_hbase_blockCacheMissCount` | Current depth of the memstore flush queue | count |
|`hadoop_hbase_blockCacheExpressHitPercent` | Percentage of time cached requests hit the cache | count |
|`hadoop_hbase_percentFilesLocal` | Percentage of stored file data that can be read from local DataNode | count |
|`hadoop_hbase_append_99th_percentile` | 99th percentile value of Append operation time | ms |
|`hadoop_hbase_delete_99th_percentile` | 99th percentile value of Delete operation time | ms |
|`hadoop_hbase_get_99th_percentile` | 99th percentile value of Get operation time | ms |
|`hadoop_hbase_checkandput_99th_percentile` | 99th percentile value of CheckAndPut operation time | ms |
|`hadoop_hbase_checkanddelete_99th_percentile` | 99th percentile value of CheckAndDelete operation time | ms |
|`hadoop_hbase_increment_99th_percentile` | 99th percentile value of Increment operation time | ms |
|`hadoop_hbase_hedgedreadwins` | Number of successful hedged read operations | count |
|`hadoop_hbase_hedgedreads` | Total number of hedged read operations | count |
|`hadoop_hbase_hedgedreadopsincurthread` | Number of hedged read operations in the current thread | count |
|`hadoop_hbase_l1cachehitratio` | L1 cache hit ratio | % |
|`hadoop_hbase_l1cachemissratio` | L1 cache miss ratio | % |
|`hadoop_hbase_l2cachehitratio` | L2 cache hit ratio | % |
|`hadoop_hbase_l2cachemissratio` | L2 cache miss ratio | % |
|`hadoop_hbase_logerror` | Number of logged errors | count |
|`hadoop_hbase_logfatal` | Number of logged fatal errors | count |
|`hadoop_hbase_loginfo` | Number of logged info-level messages | count |
|`hadoop_hbase_logwarn` | Number of logged warnings | count |
|`hadoop_hbase_majorcompactiontime_max` | Maximum time for compaction operations | ms |
|`hadoop_hbase_majorcompactiontime_mean` | Average time for compaction operations | ms |
|`hadoop_hbase_majorcompactiontime_median` | Median time for compaction operations | ms |
|`hadoop_hbase_majorcompactiontime_min` | Minimum time for compaction operations | ms |
|`hadoop_hbase_maxstorefileage` | Maximum age of store files | count |
|`hadoop_hbase_memheapcommittedm` | Amount of committed heap memory | MB |
|`hadoop_hbase_memheapmaxm` | Maximum amount of heap memory | MB |
|`hadoop_hbase_memheapusedm` | Amount of used heap memory | MB |
|`hadoop_hbase_memmaxm` | Maximum total memory | MB |
|`hadoop_hbase_memnonheapcommittedm` | Amount of committed non-heap memory | MB |
|`hadoop_hbase_memnonheapmaxm` | Maximum amount of non-heap memory | MB |
|`hadoop_hbase_memnonheapusedm` | Amount of used non-heap memory | MB |
|`hadoop_hbase_mobfilecachehitpercent` | Percentage of MOB file cache hits | % |
|`hadoop_hbase_mutationswithoutwalcount` | Number of mutations without write-ahead log (WAL) | count |
|`hadoop_hbase_averageregionsize` | Average size of regions | MB |
|`hadoop_hbase_avgstorefileage` | Average age of store files | ms |
|`hadoop_hbase_blockcachecount` | Total number of blocks in the block cache | count |
|`hadoop_hbase_blockcachecounthitpercent` | Percentage of block cache hits | % |
|`hadoop_hbase_blockcachedatahitcount` | Number of data block hits in the block cache | count |
|`hadoop_hbase_blockcacheevictioncount` | Number of block cache evictions | count |
|`hadoop_hbase_blockcachehitcount` | Number of block cache hits | count |
|`hadoop_hbase_blockcachemisscount` | Number of block cache misses | count |
|`hadoop_hbase_compactioninputfilecount_99th_percentile` | 99th percentile value of the number of input files for compaction operations | count |
|`hadoop_hbase_compactionoutputfilecount_99th_percentile` | 99th percentile value of the number of output files for compaction operations | count |
|`hadoop_hbase_compactiontime_99th_percentile` | 99th percentile value of compaction operation time | ms |
|`hadoop_hbase_flushedmemstorebytes` | Number of bytes flushed from MemStore | byte |
|`hadoop_hbase_flushedoutputbytes` | Number of bytes flushed as output | byte |
|`hadoop_hbase_flushmemstoresize_99th_percentile` | 99th percentile value of flushed MemStore size | byte |
|`hadoop_hbase_flushoutputsize_99th_percentile` | 99th percentile value of flushed output size | byte |
|`hadoop_hbase_flushtime_99th_percentile` | 99th percentile value of flush operation time | ms |
|`hadoop_hbase_get_25th_percentile` | 25th percentile value of Get operation time | ms |
|`hadoop_hbase_slowappendcount` | Number of slow Append operations | count |
|`hadoop_hbase_slowdeletecount` | Number of slow Delete operations | count |
|`hadoop_hbase_slowgetcount` | Number of slow Get operations | count |
|`hadoop_hbase_slowincrementcount` | Number of slow Increment operations | count |
|`hadoop_hbase_slowputcount` | Number of slow Put operations | count |
|`hadoop_hbase_snapshotavgtime` | Average time for snapshot operations | ms |
|`hadoop_hbase_snapshotnumops` | Total number of snapshot operations | count |
|`hadoop_hbase_source_logeditsread` | Number of log edits read by Source | count |
|`hadoop_hbase_source_shippedbytes` | Number of bytes shipped by Source | byte |
|`hadoop_hbase_source_shippedops` | Number of operations shipped by Source | count |
|`hadoop_hbase_splitreuestcount` | Number of split requests | count |
|`hadoop_hbase_splitsuccesscount` | Total number of successful splits | count |
|`hadoop_hbase_staticbloomsize` | Size of static bloom filter | count |
|`hadoop_hbase_staticindexsize` | Size of static index | count |
|`hadoop_hbase_storefileindexsize` | Size of store file index | count |
|`hadoop_hbase_storefilesize` | Size of store files | count |
|`hadoop_hbase_successfullogrolls` | Total number of successful log rolls | count |
|`hadoop_hbase_synctime_99th_percentile` | 99th percentile value of sync operation time | ms |
|`hadoop_hbase_tunerdonothingcounter` | Number of times the tuner did nothing | count |
|`hadoop_hbase_updatesblockedtime` | Time updates were blocked | ms |
|`hadoop_hbase_writereuestcount` | Total number of write requests | count |
|`hadoop_hbase_writtenbytes` | Total number of bytes written | byte |
|`hadoop_hbase_zerocopybytesread` | Number of bytes read with zero-copy | byte |