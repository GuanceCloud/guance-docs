---
title     : 'Hadoop HDFS DataNode'
summary   : 'Collect HDFS datanode Metrics information'
__int_icon: 'icon/hadoop-hdfs'
dashboard :
  - desc  : 'HDFS DataNode'
    path  : 'dashboard/en/hadoop_hdfs_datanode'
monitor   :
  - desc  : 'HDFS DataNode'
    path  : 'monitor/en/hadoop_hdfs_datanode'
---

<!-- markdownlint-disable MD025 -->
# Hadoop HDFS DataNode
<!-- markdownlint-enable -->

Collect HDFS datanode Metrics information.

## Installation and Deployment {#config}

Since the DataNode is developed in the LANGUAGE, it is possible to use jmx-exporter to collect Metrics information.

### 1. DataNode Configuration

#### 1.1 Download jmx-exporter

Download address: `https://github.com/prometheus/jmx_exporter`

#### 1.2 Download jmx Script

Download address: `https://github.com/lrwh/jmx-exporter/blob/main/hadoop-hdfs-datanode.yml`

#### 1.3 Adjust DataNode Startup Parameters

Add the following to the startup parameters of the datanode:

> {JAVA_GC_ARGS} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:17106:/opt/guance/jmx/hadoop-hdfs-datanode.yml

#### 1.4 Restart DataNode

### 2. DataKit Collector Configuration

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Configure the Collector

jmx-exporter can directly expose `metrics` url, so the [`prom`](./prom.md) collector can be used for collection.

Go to the [DataKit installation directory](./datakit_dir.md) under `conf.d/prom`, copy `prom.conf.sample` as `datanode.conf`.

> `cp prom.conf.sample datanode.conf`

Adjust the content of `datanode.conf` as follows:

```toml

  urls = ["http://localhost:17106/metrics"]
  source = "hdfs-datanode"
  [inputs.prom.tags]
    component = "hdfs-datanode" 
  interval = "10s"
```

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations should be adjusted as needed*</font>
<!-- markdownlint-enable -->
, parameter adjustment instructions:

<!-- markdownlint-disable MD004 -->
- urls: The `jmx-exporter` Metrics address, fill in the corresponding component's exposed Metrics url here.
- source: Alias for the collector, recommended to distinguish.
- keep_exist_metric_name: Keep metric names.
- interval: Collection interval.
- inputs.prom.tags: Add extra tags.
<!-- markdownlint-enable -->

### 3. Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

### Hadoop Measurement

DataNode Metrics are located under the Hadoop Measurement set, mainly introducing the explanation of DataNode related Metrics.

| Metrics | Description | Unit |
|:--------|:-----|:--|
|`datanode_block_verification_failures` |`Number of block verification failures on data nodes` | count |
|`datanode_blocks_cached` |`Number of blocks cached on data nodes` | count |
|`datanode_blocks_read` |`Number of blocks read by data nodes` | count |
|`datanode_blocks_removed` |`Number of blocks removed by data nodes` | count |
|`datanode_blocks_replicated` |`Number of blocks replicated by data nodes` | count |
|`datanode_blocks_uncached` |`Number of blocks not cached on data nodes` | count |
|`datanode_blocks_verified` |`Number of blocks verified by data nodes` | count |
|`datanode_blocks_written` |`Number of blocks written by data nodes` | count |
|`datanode_bytes_read` |`Number of bytes read by data nodes` | byte |
|`datanode_bytes_written` |`Number of bytes written by data nodes` | byte |
|`datanode_cache_capacity` |`Cache capacity on data nodes` | byte |
| `datanode_cache_reports_avg_time` | `Average time for cache reports on data nodes` | ms |
|`datanode_cache_reports_num_ops` |`Number of operations for cache reports on data nodes` | count |
|`datanode_cache_used` |`Amount of cache used on data nodes` | byte |
|`datanode_capacity` |`Capacity of data nodes` | count |
|`datanode_data_node_active_xceivers_count` |`Number of active receivers on data nodes` | count |
|`datanode_datanode_network_errors` |`Number of network errors on data nodes` | count |
| `datanode_dfs_used` | `Amount of DFS space used by data nodes` | byte |
|`datanode_dropped_pub_all` |`Total number of published messages dropped by data nodes` | count |
|`datanode_estimated_capacity_lost` |`Estimated capacity lost by data nodes` | byte |
| `datanode_flush_io_rate_avg_time` | `Average time for flushing I/O rate on data nodes` | ms |
|`datanode_flush_io_rate_num_ops` |`Number of flush I/O operations on data nodes` | count |
|`datanode_flush_nanos_avg_time` |`Average time for flush operation (nanoseconds) on data nodes` | ns |
|`datanode_flush_nanos_num_ops` |`Number of flush operations on data nodes` | count |
|`datanode_fsync_count` |`Number of fsync operations on data nodes` | count |
|`datanode_heartbeats_avg_time` |`Average time for heartbeats on data nodes` | ms |
|`datanode_heartbeats_num_ops` |`Number of heartbeat operations on data nodes` | count |
|`datanode_heartbeats_total_avg_time` |`Total average time for heartbeats on data nodes` | ms |
|`datanode_heartbeats_total_num_ops` |`Total number of heartbeat operations on data nodes` | count |
|`datanode_incremental_block_reports_avg_time` |`Average time for incremental block reports on data nodes` | ms |
|`datanode_incremental_block_reports_num_ops` |`Number of operations for incremental block reports on data nodes` | count |
|`datanode_lifelines_avg_time` |`Average time for lifeline signals on data nodes` | ms |
|`datanode_lifelines_num_ops` |`Number of operations for lifeline signals on data nodes` | count |
|`datanode_metadata_operation_rate_avg_time` |`Average time for metadata operations on data nodes` | ms |
|`datanode_metadata_operation_rate_num_ops` |`Number of metadata operations on data nodes` | count |
|`datanode_num_active_sinks` |`Number of active sinks on data nodes` | count |
|`datanode_num_active_sources` |`Number of active sources on data nodes` | count |
|`datanode_num_all_sinks` |`Number of all sinks on data nodes` | count |
|`datanode_num_all_sources` |`Number of all sources on data nodes` | count |
|`datanode_num_blocks_cached` |`Number of blocks cached on data nodes` | count |
|`datanode_num_blocks_failed_to_cache` |`Number of blocks failed to cache on data nodes` | count |
|`datanode_num_blocks_failed_to_un_cache` |`Number of blocks failed to uncache on data nodes` | count |
|`datanode_num_blocks_failed_to_uncache` |`Number of blocks failed to uncache on data nodes` | count |
|`datanode_num_failed_volumes` |`Number of failed volumes on data nodes` | count |
|`datanode_publish_avg_time` |`Average time for publishing on data nodes` | ms |
|`datanode_publish_num_ops` |`Number of publish operations on data nodes` | count |
|`datanode_ram_disk_blocks_deleted_before_lazy_persisted` |`Number of RAM disk blocks deleted before lazy persistence on data nodes` | count |
|`datanode_ram_disk_blocks_evicted` |`Number of RAM disk blocks evicted on data nodes` | count |
|`datanode_ram_disk_blocks_read_hits` |`Number of hits when reading RAM disk blocks on data nodes` | count |
|`datanode_ram_disk_blocks_write` |`Number of writes to RAM disk blocks on data nodes` | count |
|`datanode_ram_disk_bytes_write` |`Number of bytes written to RAM disk on data nodes` | byte |
|`datanode_read_block_op_avg_time` |`Average time for reading block operations on data nodes` | ms |
|`datanode_read_block_op_num_ops` |`Number of read block operations on data nodes` | count |
|`datanode_read_io_rate_avg_time` |`Average time for read I/O rate on data nodes` | ms |
|`datanode_read_io_rate_num_ops` |`Number of read I/O operations on data nodes` | count |
|`datanode_reads_from_local_client` |`Number of reads from local clients on data nodes` | count |
|`datanode_reads_from_remote_client` |`Number of reads from remote clients on data nodes` | count |
|`datanode_remaining` |`Remaining space on data nodes` | byte |
|`datanode_remote_bytes_read` |`Number of bytes read remotely on data nodes` | byte |
|`datanode_remote_bytes_written` |`Number of bytes written remotely on data nodes` | byte |
|`datanode_replace_block_op_avg_time` |`Average time for replacing block operations on data nodes` | ms |
|`datanode_replace_block_op_num_ops` |`Number of replace block operations on data nodes` | count |
|`datanode_send_data_packet_blocked_on_network_nanos_avg_time` |`Average time blocked on network while sending data packets (nanoseconds) on data nodes` | ns |
|`datanode_send_data_packet_blocked_on_network_nanos_num_ops` |`Number of network blocking operations while sending data packets on data nodes` | count |
|`datanode_send_data_packet_transfer_nanos_avg_time` |`Average time transferring data packets (nanoseconds) on data nodes` | ns |
|`datanode_send_data_packet_transfer_nanos_num_ops` |`Number of transfer operations for data packets on data nodes` | count |
|`datanode_snapshot_avg_time` |`Average time for snapshots on data nodes` | ms |
|`datanode_snapshot_num_ops` |`Number of snapshot operations on data nodes` | count |
| `datanode_sync_io_rate_avg_time` | `Average time for sync I/O rate on data nodes` | ms |
|`datanode_sync_io_rate_num_ops` |`Number of sync I/O operations on data nodes` | count |
|`datanode_total_data_file_ios` |`Total number of data file I/O operations on data nodes` | count |
|`datanode_total_file_io_errors` |`Total number of file I/O errors on data nodes` | count |
|`datanode_total_metadata_operations` |`Total number of metadata operations on data nodes` | count |
| `datanode_total_read_time` | `Total read time on data nodes` | ms |
| `datanode_total_write_time` | `Total write time on data nodes` | ms |
|`datanode_volume_failures` |`Number of volume failures on data nodes` | count |
|`datanode_write_block_op_avg_time` |`Average time for writing block operations on data nodes` | ms |
|`datanode_write_block_op_num_ops` |`Number of write block operations on data nodes` | count |
|`datanode_write_io_rate_avg_time` |`Average time for write I/O rate on data nodes` | ms |
|`datanode_write_io_rate_num_ops` |`Number of write I/O operations on data nodes` | count |
|`datanode_writes_from_local_client` |`Number of writes from local clients on data nodes` | count |
|`datanode_writes_from_remote_client` |`Number of writes from remote clients on data nodes` | count |
|`datanode_xceiver_count` |`Number of xceivers on data nodes` | count |
|`datanode_xmits_in_progress` |`Number of ongoing transmissions on data nodes` | count |