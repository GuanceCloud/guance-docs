---
title     : 'Hadoop HDFS DataNode'
summary   : 'Collect HDFS datanode metric information'
__int_icon: 'icon/hadoop-hdfs'
dashboard :
  - desc  : 'HDFS DataNode'
    path  : 'dashboard/en/hadoop-hdfs-datanode'
monitor   :
  - desc: 'HDFS DataNode'
    path: 'monitor/en/hadoop_hdfs_datanode'
---

<!-- markdownlint-disable MD025 -->
# Hadoop HDFS DataNode
<!-- markdownlint-enable -->

Collect HDFS datanode metric information.

## Installation and deployment {#config}

Since DataNode is developed in Java language, it can collect metric information using jmx exporter.

### 1. DataNode configuration

#### 1.1 Download jmx-exporter

Download link：`https://github.com/prometheus/jmx_exporter`

#### 1.2 Download jmx script

Download link：`https://github.com/lrwh/jmx-exporter/blob/main/hadoop-hdfs-datanode.yml`

#### 1.3 DataNode startup parameter adjustment

Add startup parameters to the datanode

> {{JAVA_GC_ARGS}} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:17106:/opt/guance/jmx/hadoop-hdfs-datanode.yml

#### 1.4 Restart DataNode

### 2. DataKit Collector Configuration

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Configure collector

By using jmx exporter, the 'metrics' URL can be directly exposed, so it can be collected directly through the [prom'] (./pro. md) collector.

Go to the installation directory of [DataKit] (./datakit-dir. md) and copy ` prom.d/prom.sample ` to ` datanode. conf `.

> `cp prom.conf.sample datanode.conf`

Adjust the content of 'datanode. conf' as follows:

```toml

  urls = ["http://localhost:17106/metrics"]
  source ="hdfs-datanode"
  [inputs.prom.tags]
    component = "hdfs-datanode" 
  interval = "10s"
```

<!-- markdownlint-disable MD033 -->
<font color="red">*Adjust other configurations as needed*</font>
<!-- markdownlint-enable -->
，parameter adjustment instructions ：

<!-- markdownlint-disable MD004 -->
- urls：`Jmx exporter 'indicator address, fill in the URL of the indicator exposed by the corresponding component here
- source：Collector alias, it is recommended to make a distinction
- keep_exist_metric_name: Maintain indicator name
- interval：Collection interval
- inputs.prom.tags: Add additional tags
<!-- markdownlint-enable -->

### 3. Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Target {#metric}

### Hadoop Indicator set

The DataNode metric is located under the Hadoop metric set, and here we mainly introduce the description of DataNode related metrics

| Metrics | Description |Unit |
|:--------|:-----|:--|
|`datanode_block_verification_failures` |`Number of failed data node block verification attempts` | count |
|`datanode_blocks_cached` |`The number of blocks cached by data nodes` | count |
|`datanode_blocks_read` |`Number of blocks read by data nodes` | count |
|`datanode_blocks_removed` |`Number of blocks removed by data nodes` | count |
|`datanode_blocks_replicated` |`Number of blocks replicated by data nodes` | count |
|`datanode_blocks_uncached` |`Number of uncached blocks in data nodes` | count |
|`datanode_blocks_verified` |`Number of validated blocks for data nodes` | count |
|`datanode_blocks_written` |`Number of blocks written by data nodes` | count |
|`datanode_bytes_read` |`The number of bytes read by the data node` | byte |
|`datanode_bytes_written` |`The number of bytes written by the data node` | byte |
|`datanode_cache_capacity` |`Data node cache capacity` | byte |
| `datanode_cache_reports_avg_time` | `Data node cache report average time` | ms |
|`datanode_cache_reports_num_ops` |`Number of data node cache report operations` | count |
|`datanode_cache_used` |`The amount of cache already used by the data node` | byte |
|`datanode_capacity` |`Data node capacity` | count |
|`datanode_data_node_active_xceivers_count` |`Number of active receivers for data nodes` | count |
|`datanode_datanode_network_errors` |`Number of network errors in data nodes` | count |
| `datanode_dfs_used` | `DFS space already used by data nodes` | btye |
|`datanode_dropped_pub_all` |`The total number of published messages with data node loss` | count |
|`datanode_estimated_capacity_lost` |`Estimation of lost capacity of data nodes` | byte |
| `datanode_flush_io_rate_avg_time` | `Average refresh I/O rate time of data nodes` | ms |
|`datanode_flush_io_rate_num_ops` |`Number of data node refresh I/O operations` | count |
|`datanode_flush_nanos_avg_time` |`Average refresh time of data nodes (nanoseconds)` | ns |
|`datanode_flush_nanos_num_ops` |`Number of data node refresh operations` | count |
|`datanode_fsync_count` |`Number of fsync operations on data nodes` | count |
|`datanode_heartbeats_avg_time` |`Average heartbeat time of data node` | ms |
|`datanode_heartbeats_num_ops` |`Number of heartbeat operations of data node` | count |
|`datanode_heartbeats_total_avg_time` |`Average total heartbeat time of data nodes` | ms |
|`datanode_heartbeats_total_num_ops` |`Total number of heartbeat operations for data nodes` | count |
|`datanode_incremental_block_reports_avg_time` |`Average time for incremental block reporting of data nodes` | ms |
|`datanode_incremental_block_reports_num_ops` |`Number of incremental block report operations for data nodes` | count |
|`datanode_lifelines_avg_time` |`Average time of data node lifecycle signal` | ms |
|`datanode_lifelines_num_ops` |`Number of signal operations during the lifecycle of data nodes` | count |
|`datanode_metadata_operation_rate_avg_time` |`Average rate and time of metadata operations on data nodes` | ms |
|`datanode_metadata_operation_rate_num_ops` |`Number of metadata operations on data nodes` | count |
|`datanode_num_active_sinks` |`Number of active receivers for data nodes` | count |
|`datanode_num_active_sources` |`Number of active sources for data nodes` | count |
|`datanode_num_all_sinks` |`Number of all receivers in the data node` | count |
|`datanode_num_all_sources` |`Number of all sources for data nodes` | count |
|`datanode_num_blocks_cached` |`The number of blocks cached by data nodes` | count |
|`datanode_num_blocks_failed_to_cache` |`Number of blocks with failed data node caching` | count |
|`datanode_num_blocks_failed_to_un_cache` |`The number of blocks that failed to cache in the data node` | count |
|`datanode_num_blocks_failed_to_uncache` |`Number of blocks that failed to cache data nodes` | count |
|`datanode_num_failed_volumes` |`Number of volumes with failed data nodes` | count |
|`datanode_publish_avg_time` |`Average publishing time of data nodes` | ms |
|`datanode_publish_num_ops` |`Number of data node publishing operations` | count |
|`datanode_ram_disk_blocks_deleted_before_lazy_persisted` |`The number of RAM disk blocks deleted before data node delay persistence` | count |
|`datanode_ram_disk_blocks_evicted` |`The number of RAM disk blocks evicted by data nodes` | count |
|`datanode_ram_disk_blocks_read_hits` |`Number of read hits on data node RAM disk blocks` | count |
|`datanode_ram_disk_blocks_write` |`Number of writes to data node RAM disk blocks` | count |
|`datanode_ram_disk_bytes_write` |`Number of bytes written to data node RAM disk` | byte |
|`datanode_read_block_op_avg_time` |`The average time for data node read block operations` | ms |
|`datanode_read_block_op_num_ops` |`Number of block read operations for data nodes` | count |
|`datanode_read_io_rate_avg_time` |`Data node read I/O average rate time` | ms |
|`datanode_read_io_rate_num_ops` |`Number of data node read I/O operations` | count |
|`datanode_reads_from_local_client` |`The number of times the data node is read from the local client` | count |
|`datanode_reads_from_remote_client` |`The number of times data nodes are read from remote clients` | count |
|`datanode_remaining` |`Remaining space of data nodes` | byte |
|`datanode_remote_bytes_read` |`Number of bytes remotely read by data nodes` | byte |
|`datanode_remote_bytes_written` |`Number of bytes remotely written to data nodes` | byte |
|`datanode_replace_block_op_avg_time` |`Average time for data node replacement block operation` | ms |
|`datanode_replace_block_op_num_ops` |`Number of data node replacement block operations` | count |
|`datanode_send_data_packet_blocked_on_network_nanos_avg_time` |`Average network blocking time (nanoseconds) for data nodes to send data packets` | ns |
|`datanode_send_data_packet_blocked_on_network_nanos_num_ops` |`Number of network blocking operations for data nodes sending data packets` | count |
|`datanode_send_data_packet_transfer_nanos_avg_time` |`Average packet transmission time (nanoseconds) for data nodes to send data packets` | ns |
|`datanode_send_data_packet_transfer_nanos_num_ops` |`Number of packet transmission operations sent by data nodes` | count |
|`datanode_snapshot_avg_time` |`Average snapshot time of data nodes` | ms |
|`datanode_snapshot_num_ops` |`Number of snapshot operations on data nodes` | count |
| `datanode_sync_io_rate_avg_time` | `Data node synchronous I/O average rate time` | ms |
|`datanode_sync_io_rate_num_ops` |`Number of synchronous I/O operations for data nodes` |count  |
|`datanode_total_data_file_ios` |`Total number of data file I/O times for data nodes` | count |
|`datanode_total_file_io_errors` |`Total number of file I/O errors in data nodes` | count |
|`datanode_total_metadata_operations` |`Total number of metadata operations on data nodes` | count |
| `datanode_total_read_time` | `Total read time of data nodes` | ms |
| `datanode_total_write_time` | `Total write time of data nodes` | ms |
|`datanode_volume_failures` |`Number of data node volume failures` | count |
|`datanode_write_block_op_avg_time` |`The average time for data node block writing operations` | ms  |
|`datanode_write_block_op_num_ops` |`Number of block writing operations for data nodes` | count |
|`datanode_write_io_rate_avg_time` |`Data node write I/O average rate time` | ms |
|`datanode_write_io_rate_num_ops` |`Number of I/O operations written by data nodes` | count |
|`datanode_writes_from_local_client` |`The number of writes from the local client to the data node` | count |
|`datanode_writes_from_remote_client` |`The number of writes from remote clients to data nodes` | count |
|`datanode_xceiver_count` |`Number of data node receivers` | count |
|`datanode_xmits_in_progress` |`The number of transmissions being carried out by the data node` | count |

