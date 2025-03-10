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

Since the DataNode is developed in Java, it can use the jmx-exporter method to collect Metrics information.

### 1. DataNode Configuration

#### 1.1 Download jmx-exporter

Download URL: `https://github.com/prometheus/jmx_exporter`

#### 1.2 Download jmx Script

Download URL: `https://github.com/lrwh/jmx-exporter/blob/main/hadoop-hdfs-datanode.yml`

#### 1.3 Adjust DataNode Startup Parameters

Add the following to the startup parameters of the datanode:

> {JAVA_GC_ARGS} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:17106:/opt/guance/jmx/hadoop-hdfs-datanode.yml

#### 1.4 Restart DataNode

### 2. DataKit Collector Configuration

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Configure the Collector

The jmx-exporter exposes a `metrics` URL directly, so you can use the [`prom`](./prom.md) collector for collection.

Navigate to the [DataKit installation directory](./datakit_dir.md) under `conf.d/prom`, copy `prom.conf.sample` to `datanode.conf`.

> `cp prom.conf.sample datanode.conf`

Adjust the content of `datanode.conf` as follows:

```toml

  urls = ["http://localhost:17106/metrics"]
  source ="hdfs-datanode"
  [inputs.prom.tags]
    component = "hdfs-datanode" 
  interval = "10s"
```

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations can be adjusted as needed*</font>
<!-- markdownlint-enable -->
Parameter adjustment explanation:

<!-- markdownlint-disable MD004 -->
- urls: The address of the `jmx-exporter` Metrics, fill in the exposed Metrics URL of the corresponding component.
- source: Alias for the collector, it is recommended to distinguish.
- keep_exist_metric_name: Keep metric names.
- interval: Collection interval.
- inputs.prom.tags: Add additional tags.
<!-- markdownlint-enable -->

### 3. Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

### Hadoop Measurement Set

DataNode Metrics are located under the Hadoop Measurement set. This section mainly introduces the relevant Metrics of the DataNode.

| Metrics | Description | Unit |
|:--------|:------------|:-----|
|`datanode_block_verification_failures` | Number of block verification failures on the data node | count |
|`datanode_blocks_cached` | Number of blocks cached by the data node | count |
|`datanode_blocks_read` | Number of blocks read by the data node | count |
|`datanode_blocks_removed` | Number of blocks removed by the data node | count |
|`datanode_blocks_replicated` | Number of blocks replicated by the data node | count |
|`datanode_blocks_uncached` | Number of blocks not cached by the data node | count |
|`datanode_blocks_verified` | Number of blocks verified by the data node | count |
|`datanode_blocks_written` | Number of blocks written by the data node | count |
|`datanode_bytes_read` | Number of bytes read by the data node | byte |
|`datanode_bytes_written` | Number of bytes written by the data node | byte |
|`datanode_cache_capacity` | Cache capacity of the data node | byte |
| `datanode_cache_reports_avg_time` | Average time for cache reports on the data node | ms |
|`datanode_cache_reports_num_ops` | Number of cache report operations on the data node | count |
|`datanode_cache_used` | Cache used by the data node | byte |
|`datanode_capacity` | Capacity of the data node | count |
|`datanode_data_node_active_xceivers_count` | Number of active receivers on the data node | count |
|`datanode_datanode_network_errors` | Number of network errors on the data node | count |
| `datanode_dfs_used` | DFS space used by the data node | byte |
|`datanode_dropped_pub_all` | Total number of dropped publish messages on the data node | count |
|`datanode_estimated_capacity_lost` | Estimated lost capacity on the data node | byte |
| `datanode_flush_io_rate_avg_time` | Average flush I/O rate time on the data node | ms |
|`datanode_flush_io_rate_num_ops` | Number of flush I/O operations on the data node | count |
|`datanode_flush_nanos_avg_time` | Average time for flush operations (nanoseconds) on the data node | ns |
|`datanode_flush_nanos_num_ops` | Number of flush operations on the data node | count |
|`datanode_fsync_count` | Number of fsync operations on the data node | count |
|`datanode_heartbeats_avg_time` | Average heartbeat time on the data node | ms |
|`datanode_heartbeats_num_ops` | Number of heartbeat operations on the data node | count |
|`datanode_heartbeats_total_avg_time` | Total average heartbeat time on the data node | ms |
|`datanode_heartbeats_total_num_ops` | Total number of heartbeat operations on the data node | count |
|`datanode_incremental_block_reports_avg_time` | Average time for incremental block reports on the data node | ms |
|`datanode_incremental_block_reports_num_ops` | Number of incremental block report operations on the data node | count |
|`datanode_lifelines_avg_time` | Average time for lifecycle signals on the data node | ms |
|`datanode_lifelines_num_ops` | Number of lifecycle signal operations on the data node | count |
|`datanode_metadata_operation_rate_avg_time` | Average metadata operation rate time on the data node | ms |
|`datanode_metadata_operation_rate_num_ops` | Number of metadata operations on the data node | count |
|`datanode_num_active_sinks` | Number of active sinks on the data node | count |
|`datanode_num_active_sources` | Number of active sources on the data node | count |
|`datanode_num_all_sinks` | Number of all sinks on the data node | count |
|`datanode_num_all_sources` | Number of all sources on the data node | count |
|`datanode_num_blocks_cached` | Number of blocks cached by the data node | count |
|`datanode_num_blocks_failed_to_cache` | Number of blocks that failed to cache on the data node | count |
|`datanode_num_blocks_failed_to_un_cache` | Number of blocks that failed to uncache on the data node | count |
|`datanode_num_blocks_failed_to_uncache` | Number of blocks that failed to uncache on the data node | count |
|`datanode_num_failed_volumes` | Number of failed volumes on the data node | count |
|`datanode_publish_avg_time` | Average publish time on the data node | ms |
|`datanode_publish_num_ops` | Number of publish operations on the data node | count |
|`datanode_ram_disk_blocks_deleted_before_lazy_persisted` | Number of RAM disk blocks deleted before lazy persistence on the data node | count |
|`datanode_ram_disk_blocks_evicted` | Number of RAM disk blocks evicted from the data node | count |
|`datanode_ram_disk_blocks_read_hits` | Number of read hits for RAM disk blocks on the data node | count |
|`datanode_ram_disk_blocks_write` | Number of writes to RAM disk blocks on the data node | count |
|`datanode_ram_disk_bytes_write` | Number of bytes written to RAM disk blocks on the data node | byte |
|`datanode_read_block_op_avg_time` | Average time for read block operations on the data node | ms |
|`datanode_read_block_op_num_ops` | Number of read block operations on the data node | count |
|`datanode_read_io_rate_avg_time` | Average read I/O rate time on the data node | ms |
|`datanode_read_io_rate_num_ops` | Number of read I/O operations on the data node | count |
|`datanode_reads_from_local_client` | Number of reads from local clients on the data node | count |
|`datanode_reads_from_remote_client` | Number of reads from remote clients on the data node | count |
|`datanode_remaining` | Remaining space on the data node | byte |
|`datanode_remote_bytes_read` | Number of bytes read remotely on the data node | byte |
|`datanode_remote_bytes_written` | Number of bytes written remotely on the data node | byte |
|`datanode_replace_block_op_avg_time` | Average time for replace block operations on the data node | ms |
|`datanode_replace_block_op_num_ops` | Number of replace block operations on the data node | count |
|`datanode_send_data_packet_blocked_on_network_nanos_avg_time` | Average time blocked on network while sending data packets on the data node (nanoseconds) | ns |
|`datanode_send_data_packet_blocked_on_network_nanos_num_ops` | Number of network blocking operations while sending data packets on the data node | count |
|`datanode_send_data_packet_transfer_nanos_avg_time` | Average transfer time for sending data packets on the data node (nanoseconds) | ns |
|`datanode_send_data_packet_transfer_nanos_num_ops` | Number of transfer operations for sending data packets on the data node | count |
|`datanode_snapshot_avg_time` | Average snapshot time on the data node | ms |
|`datanode_snapshot_num_ops` | Number of snapshot operations on the data node | count |
| `datanode_sync_io_rate_avg_time` | Average sync I/O rate time on the data node | ms |
|`datanode_sync_io_rate_num_ops` | Number of sync I/O operations on the data node | count |
|`datanode_total_data_file_ios` | Total number of data file I/O operations on the data node | count |
|`datanode_total_file_io_errors` | Total number of file I/O errors on the data node | count |
|`datanode_total_metadata_operations` | Total number of metadata operations on the data node | count |
| `datanode_total_read_time` | Total read time on the data node | ms |
| `datanode_total_write_time` | Total write time on the data node | ms |
|`datanode_volume_failures` | Number of volume failures on the data node | count |
|`datanode_write_block_op_avg_time` | Average time for write block operations on the data node | ms |
|`datanode_write_block_op_num_ops` | Number of write block operations on the data node | count |
|`datanode_write_io_rate_avg_time` | Average write I/O rate time on the data node | ms |
|`datanode_write_io_rate_num_ops` | Number of write I/O operations on the data node | count |
|`datanode_writes_from_local_client` | Number of writes from local clients on the data node | count |
|`datanode_writes_from_remote_client` | Number of writes from remote clients on the data node | count |
|`datanode_xceiver_count` | Number of receivers on the data node | count |
|`datanode_xmits_in_progress` | Number of ongoing transmissions on the data node | count |

</input_content>