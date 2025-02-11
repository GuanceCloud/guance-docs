---
title     : 'Hadoop HDFS NameNode'
summary   : 'Collect HDFS namenode metrics information'
__int_icon: 'icon/hadoop-hdfs'
dashboard :
  - desc  : 'HDFS NameNode'
    path  : 'dashboard/en/hadoop_hdfs_namenode'
monitor   :
  - desc  : 'HDFS NameNode'
    path  : 'monitor/en/hadoop_hdfs_namenode'
---

<!-- markdownlint-disable MD025 -->
# Hadoop HDFS NameNode
<!-- markdownlint-enable -->

Collect HDFS namenode metrics information.

## Installation and Deployment {#config}

Since NameNode is developed in Java, the JMX Exporter method can be used to collect metrics information.

### 1. NameNode Configuration

#### 1.1 Download JMX Exporter

Download link: `https://github.com/prometheus/jmx_exporter`

#### 1.2 Download JMX Script

Download link: `https://github.com/lrwh/jmx-exporter/blob/main/hadoop-hdfs-namenode.yml`

#### 1.3 Adjust NameNode Startup Parameters

Add the following to the NameNode startup parameters:

> {JAVA_GC_ARGS} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:17107:/opt/guance/jmx/hadoop-hdfs-namenode.yml

#### 1.4 Restart NameNode

### 2. DataKit Collector Configuration

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Configure the Collector

The JMX Exporter can directly expose a `metrics` URL, so the [`prom`](./prom.md) collector can be used for collection.

Navigate to the [DataKit installation directory](./datakit_dir.md) under `conf.d/prom`, copy `prom.conf.sample` to `namenode.conf`.

> `cp prom.conf.sample namenode.conf`

Adjust the content of `namenode.conf` as follows:

```toml
  urls = ["http://localhost:17107/metrics"]
  source ="hdfs-namenode"
  [inputs.prom.tags]
    component = "hdfs-namenode" 
  interval = "10s"
```

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations can be adjusted as needed*</font>
<!-- markdownlint-enable -->
, parameter adjustment explanation:

<!-- markdownlint-disable MD004 -->
- urls: The address of the `JMX Exporter` metrics, fill in the exposed metrics URL of the corresponding component.
- source: Alias for the collector, it's recommended to differentiate them.
- keep_exist_metric_name: Keep the metric name.
- interval: Collection interval.
- inputs.prom.tags: Add additional tags.

<!-- markdownlint-enable -->
### 3. Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

### Hadoop Metrics Set

NameNode metrics are located under the Hadoop metrics set. Here we mainly introduce the relevant metrics of NameNode.

| Metrics | Description | Unit |
| -- | -- | -- |
|`namenode_add_block_ops` | Number of add block operations | count |
|`namenode_allow_snapshot_ops` | Number of allow snapshot operations | count |
|`namenode_block_capacity` | Block capacity | byte |
|`namenode_block_deletion_start_time` | Block deletion start time | count |
|`namenode_block_ops_batched` | Number of batched block operations | count |
|`namenode_block_ops_queued` | Number of queued block operations | count |
|`namenode_block_pool_used_space` | Used block pool space | count |
|`namenode_block_received_and_deleted_ops` | Number of received and deleted block operations | count |
|`namenode_blocks` | Number of blocks | count |
|`namenode_bytes_in_future_ecblock_groups` | Number of bytes in future EC block groups | count |
|`namenode_bytes_in_future_replicated_blocks` | Number of bytes in future replicated blocks | count |
|`namenode_bytes_with_future_generation_stamps` | Number of bytes with future generation stamps | count |
|`namenode_cache_capacity` | Cache capacity | byte |
|`namenode_cache_report_avg_time` | Average cache report time | count |
|`namenode_cache_report_num_ops` | Number of cache report operations | count |
|`namenode_cache_used` | Used cache | count |
|`namenode_capacity` | Capacity | count |
|`namenode_capacity_remaining` | Remaining capacity | byte |
|`namenode_capacity_remaining_gb` | Remaining capacity (GB) | GB |
|`namenode_capacity_total_gb` | Total capacity (GB) | GB |
|`namenode_capacity_used` | Used capacity | byte |
|`namenode_capacity_used_gb` | Used capacity (GB) | GB |
|`namenode_capacity_used_non_dfs` | Non-DFS used capacity | GB |
|`namenode_corrupt_blocks` | Number of corrupt blocks | count |
|`namenode_corrupt_ecblock_groups` | Number of corrupt EC block groups | count |
|`namenode_corrupt_replicated_blocks` | Number of corrupt replicated blocks | count |
|`namenode_create_file_ops` | Number of create file operations | count |
|`namenode_create_snapshot_ops` | Number of create snapshot operations | count |
|`namenode_create_symlink_ops` | Number of create symlink operations | count |
|`namenode_delete_file_ops` | Number of delete file operations | count |
|`namenode_delete_snapshot_ops` | Number of delete snapshot operations | count |
|`namenode_disallow_snapshot_ops` | Number of disallow snapshot operations | count |
|`namenode_distinct_version_count` | Distinct version count | count |
|`namenode_distinct_versions` | Distinct versions | count |
|`namenode_dropped_pub_all` | Number of dropped pub_all | count |
|`namenode_elapsed_time` | Elapsed time | ms |
|`namenode_estimated_capacity_lost` | Estimated lost capacity | byte |
|`namenode_excess_blocks` | Number of excess blocks | count |
|`namenode_expired_heartbeats` | Number of expired heartbeats | count |
|`namenode_file_info_ops` | Number of file info operations | count |
|`namenode_files` | Number of files | count |
|`namenode_files_appended` | Number of appended files | count |
|`namenode_files_deleted` | Number of deleted files | count |
|`namenode_files_in_get_listing_ops` | Number of files in get listing operations | count |
|`namenode_files_renamed` | Number of renamed files | count |
|`namenode_files_truncated` | Number of truncated files | count |
|`namenode_free` | Free | count |
|`namenode_fs_image_load_time` | File system image load time | ms |
|`namenode_fs_lock_queue_length` | File system lock queue length | count |
|`namenode_gc_count` | Garbage collection count | count |
|`namenode_generate_edektime_avg_time` | Average generate EDEK time | ms |
|`namenode_generate_edektime_num_ops` | Number of generate EDEK operations | count |
|`namenode_get_additional_datanode_ops` | Number of get additional datanode operations | count |
|`namenode_highest_priority_low_redundancy_ecblocks` | Highest priority low redundancy EC blocks | count |
|`namenode_highest_priority_low_redundancy_replicated_blocks` | Highest priority low redundancy replicated blocks | count |
|`namenode_last_checkpoint_time` | Last checkpoint time | ms |
|`namenode_last_hatransition_time` | Last HA transition time | ms |
|`namenode_last_written_transaction_id` | Last written transaction ID | count |
|`namenode_list_snapshottable_dir_ops` | Number of list snapshottable directory operations | count |
|`namenode_lock_queue_length` | Lock queue length | count |
|`namenode_low_redundancy_ecblock_groups` | Low redundancy EC block groups | count |
|`namenode_low_redundancy_replicated_blocks` | Low redundancy replicated blocks | count |
|`namenode_max_objects` | Maximum number of objects | count |
|`namenode_millis_since_last_loaded_edits` | Milliseconds since last loaded edits | ms |
|`namenode_missing_blocks` | Missing blocks | count |
|`namenode_missing_ecblock_groups` | Missing EC block groups | count |
|`namenode_missing_repl_one_blocks` | Missing one replica blocks | count |
|`namenode_missing_replicated_blocks` | Missing replicated blocks | count |
|`namenode_missing_replication_one_blocks` | Missing one replica replicated blocks | count |
|`namenode_nnstarted_time_in_millis` | Start time (milliseconds) | ms |
|`namenode_non_dfs_used_space` | Non-DFS used space | count |
|`namenode_num_active_clients` | Number of active clients | count |
|`namenode_num_active_sinks` | Number of active sink data nodes | count |
|`namenode_num_active_sources` | Number of active source data nodes | count |
|`namenode_num_all_sinks` | Number of all sink data nodes | count |
|`namenode_num_all_sources` | Number of all source data nodes | count |
|`namenode_num_dead_data_nodes` | Number of dead data nodes | count |
|`namenode_num_decom_dead_data_nodes` | Number of decommissioned dead data nodes | count |
|`namenode_num_decom_live_data_nodes` | Number of decommissioned live data nodes | count |
|`namenode_num_decommissioning_data_nodes` | Number of decommissioning data nodes | count |
|`namenode_num_edit_log_loaded_avg_count` | Average edit log loaded count | count |
|`namenode_num_edit_log_loaded_num_ops` | Number of edit log loaded operations | count |
|`namenode_num_encryption_zones` | Number of encryption zones | count |
|`namenode_num_entering_maintenance_data_nodes` | Number of entering maintenance data nodes | count |
|`namenode_num_files_under_construction` | Number of files under construction | count |
|`namenode_num_in_maintenance_dead_data_nodes` | Number of in-maintenance dead data nodes | count |
|`namenode_num_in_maintenance_live_data_nodes` | Number of in-maintenance live data nodes | count |
|`namenode_num_live_data_nodes` | Number of live data nodes | count |
|`namenode_num_stale_data_nodes` | Number of stale data nodes | count |
|`namenode_num_stale_storages` | Number of stale storages | count |
|`namenode_num_timed_out_pending_reconstructions` | Number of timed-out pending reconstructions | count |
|`namenode_num_times_re_replication_not_scheduled` | Number of times re-replication not scheduled | count |
|`namenode_number_of_missing_blocks` | Number of missing blocks | count |
|`namenode_number_of_missing_blocks_with_replication_factor_one` | Number of missing blocks with replication factor one | count |
|`namenode_number_of_snapshottable_dirs` | Number of snapshottable directories | count |
|`namenode_pending_data_node_message_count` | Pending data node message count | count |
|`namenode_pending_deletion_blocks` | Number of pending deletion blocks | count |
|`namenode_pending_deletion_ecblocks` | Number of pending deletion EC blocks | count |
|`namenode_pending_deletion_replicated_blocks` | Number of pending deletion replicated blocks | count |
|`namenode_pending_reconstruction_blocks` | Number of pending reconstruction blocks | count |
|`namenode_pending_replication_blocks` | Number of pending replication blocks | count |
|`namenode_percent_block_pool_used` | Percentage of block pool used | percent |
|`namenode_percent_complete` | Percentage complete | percent |
|`namenode_percent_remaining` | Percentage remaining | percent |
|`namenode_percent_used` | Percentage used | percent |
|`namenode_postponed_misreplicated_blocks` | Number of postponed misreplicated blocks | count |
|`namenode_publish_avg_time` | Average publish time | ms |
|`namenode_publish_num_ops` | Number of publish operations | count |
|`namenode_put_image_avg_time` | Average put image time | ms |
|`namenode_put_image_num_ops` | Number of put image operations | count |
|`namenode_rename_snapshot_ops` | Number of rename snapshot operations | count |
|`namenode_resource_check_time_avg_time` | Average resource check time | ms |
|`namenode_resource_check_time_num_ops` | Number of resource check operations | count |
|`namenode_safe_mode` | Safe mode | count |
|`namenode_safe_mode_count` | Number of safe mode occurrences | count |
|`namenode_safe_mode_elapsed_time` | Safe mode elapsed time | count |
|`namenode_safe_mode_percent_complete` | Safe mode percentage complete | percent |
|`namenode_safe_mode_time` | Safe mode time | ms |
|`namenode_saving_checkpoint` | Saving checkpoint | count |
|`namenode_saving_checkpoint_count` | Number of saving checkpoints | count |
|`namenode_saving_checkpoint_elapsed_time` | Saving checkpoint elapsed time | ms |
|`namenode_saving_checkpoint_percent_complete` | Saving checkpoint percentage complete | count |
|`namenode_scheduled_replication_blocks` | Number of scheduled replication blocks | count |
|`namenode_stale_data_nodes` | Stale data nodes | count |
|`namenode_storage_block_report_avg_time` | Average storage block report time | ms |
|`namenode_storage_block_report_num_ops` | Number of storage block report operations | count |
|`namenode_successful_re_replications` | Number of successful re-replications | count |
|`namenode_syncs_avg_time` | Average sync time | ms |
|`namenode_syncs_num_ops` | Number of sync operations | count |
|`namenode_tag_total_sync_times` | Total sync times | count |
|`namenode_timeout_re_replications` | Number of timeout re-replications | count |
|`namenode_total_blocks` | Total number of blocks | count |
|`namenode_total_ecblock_groups` | Total number of EC block groups | count |
|`namenode_total_file_ops` | Total number of file operations | count |
|`namenode_total_load` | Total load | count |
|`namenode_total_replicated_blocks` | Total number of replicated blocks | count |
|`namenode_total_sync_count` | Total sync count | count |
|`namenode_total_sync_times` | Total sync times | count |
|`namenode_transactions_avg_time` | Average transaction time | ms |
|`namenode_transactions_batched_in_sync` | Number of transactions batched in sync | count |
|`namenode_transactions_num_ops` | Number of transaction operations | count |
|`namenode_transactions_since_last_checkpoint` | Number of transactions since last checkpoint | count |
|`namenode_transactions_since_last_log_roll` | Number of transactions since last log roll | count |
|`namenode_under_replicated_blocks` | Number of under-replicated blocks | count |
|`namenode_used` | Used | count |
|`namenode_volume_failures` | Volume failure count | count |
|`namenode_warm_up_edektime_avg_time` | Average warm-up EDEK time | ms |
|`namenode_warm_up_edektime_num_ops` | Number of warm-up EDEK operations | count |


</input_content>
<target_language>英语</target_language>
</input>
</example>
</example>
</instruction>
</instructions>
