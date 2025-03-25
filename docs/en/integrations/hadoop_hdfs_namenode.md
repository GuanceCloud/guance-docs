---
title     : 'Hadoop HDFS NameNode'
summary   : 'Collect HDFS namenode Metrics information'
__int_icon: 'icon/hadoop-hdfs'
dashboard :
  - desc  : 'HDFS NameNode'
    path  : 'dashboard/zh/hadoop_hdfs_namenode'
monitor   :
  - desc  : 'HDFS NameNode'
    path  : 'monitor/zh/hadoop_hdfs_namenode'
---

<!-- markdownlint-disable MD025 -->
# Hadoop HDFS NameNode
<!-- markdownlint-enable -->

Collect HDFS namenode Metrics information.

## Installation and Deployment {#config}

Since the NameNode is developed in the java LANGUAGE, it is possible to use the jmx-exporter method to collect Metrics information.

### 1. NameNode Configuration

#### 1.1 Download jmx-exporter

Download address: `https://github.com/prometheus/jmx_exporter`

#### 1.2 Download jmx Script

Download address: `https://github.com/lrwh/jmx-exporter/blob/main/hadoop-hdfs-namenode.yml`

#### 1.3 Adjust NameNode Startup Parameters

Add the following to the startup parameters of namenode:

> {JAVA_GC_ARGS} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:17107:/opt/guance/jmx/hadoop-hdfs-namenode.yml

#### 1.4 Restart NameNode

### 2. DataKit Collector Configuration

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Configure Collector

The jmx-exporter can directly expose `metrics` url, so it can be collected directly through the [`prom`](./prom.md) collector.

Go to the `conf.d/prom` under the [DataKit installation directory](./datakit_dir.md), copy `prom.conf.sample` to `namenode.conf`.

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
, adjustment parameter description :

<!-- markdownlint-disable MD004 -->
- urls: The `jmx-exporter` Metrics address, fill in the Metrics url exposed by the corresponding component here
- source: Collector alias, it's recommended to make distinctions
- keep_exist_metric_name: Keep the metric name
- interval: Collection interval
- inputs.prom.tags: Add extra tags

<!-- markdownlint-enable -->
### 3. Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

### Hadoop Measurement Sets

NameNode Metrics are located under the Hadoop Measurement sets, here we mainly introduce the related NameNode Metrics descriptions.

| Metrics | Description | Unit |
| -- | -- |-- |
|`namenode_add_block_ops` |`Add block operation counts` | count |
|`namenode_allow_snapshot_ops` |`Allow snapshot operation counts` | count |
|`namenode_block_capacity` |`Block capacity` | byte |
|`namenode_block_deletion_start_time` |`Block deletion start time` | count |
|`namenode_block_ops_batched` |`Batched block operation counts` | count |
|`namenode_block_ops_queued` |`Queued block operation counts` | count |
|`namenode_block_pool_used_space` |`Used block pool space` | count |
|`namenode_block_received_and_deleted_ops` |`Received and deleted block operation counts` | count |
|`namenode_blocks` |`Block counts` | count |
|`namenode_bytes_in_future_ecblock_groups` |`Bytes in future EC block groups` | count |
|`namenode_bytes_in_future_replicated_blocks` |`Bytes in future replicated blocks` | count |
|`namenode_bytes_with_future_generation_stamps` |`Bytes with future generation stamps` | count |
|`namenode_cache_capacity` |`Cache capacity` | byte |
|`namenode_cache_report_avg_time` |`Cache report average time` | count |
|`namenode_cache_report_num_ops` |`Cache report operation counts` | count |
|`namenode_cache_used` |`Used cache` | count |
|`namenode_capacity` |`Capacity` | count |
|`namenode_capacity_remaining` |`Remaining capacity` | byte |
|`namenode_capacity_remaining_gb` |`Remaining capacity (GB)` | GB |
|`namenode_capacity_total_gb` |`Total capacity (GB)` | GB |
|`namenode_capacity_used` |`Used capacity` | byte |
|`namenode_capacity_used_gb` |`Used capacity (GB)` | GB |
|`namenode_capacity_used_non_dfs` |`Non-DFS used capacity` | GB |
|`namenode_corrupt_blocks` |`Corrupt blocks` | count |
|`namenode_corrupt_ecblock_groups` |`Corrupt EC block groups` | count |
|`namenode_corrupt_replicated_blocks` |`Corrupt replicated blocks` | count |
|`namenode_create_file_ops` |`Create file operation counts` | count |
|`namenode_create_snapshot_ops` |`Create snapshot operation counts` | count |
|`namenode_create_symlink_ops` |`Create symbolic link operation counts` | count |
|`namenode_delete_file_ops` |`Delete file operation counts` | count |
|`namenode_delete_snapshot_ops` |`Delete snapshot operation counts` | count |
|`namenode_disallow_snapshot_ops` |`Disallow snapshot operation counts` | count |
|`namenode_distinct_version_count` |`Distinct version counts` | count |
|`namenode_distinct_versions` |`Distinct versions` | count |
|`namenode_dropped_pub_all` |`Dropped pub_all` | count |
|`namenode_elapsed_time` |`Elapsed time` | ms |
|`namenode_estimated_capacity_lost` |`Estimated lost capacity` | byte |
|`namenode_excess_blocks` |`Excess blocks` | count |
|`namenode_expired_heartbeats` |`Expired heartbeats` | count |
|`namenode_file_info_ops` |`File info operation counts` | count |
|`namenode_files` |`File counts` | count |
|`namenode_files_appended` |`Appended file counts` | count |
|`namenode_files_deleted` |`Deleted file counts` | count |
|`namenode_files_in_get_listing_ops` |`File counts in get listing operations` | count |
|`namenode_files_renamed` |`Renamed file counts` | count |
|`namenode_files_truncated` |`Truncated file counts` | count |
|`namenode_free` |`Free` | count |
|`namenode_fs_image_load_time` |`File system image load time` | ms |
|`namenode_fs_lock_queue_length` |`File system lock queue length` | count |
|`namenode_gc_count` |`Garbage collection counts` | count |
|`namenode_generate_edektime_avg_time` |`Generate EDEK time average time` | ms |
|`namenode_generate_edektime_num_ops` |`Generate EDEK operation counts` | count |
|`namenode_get_additional_datanode_ops` |`Get additional data node operation counts` | count |
|`namenode_highest_priority_low_redundancy_ecblocks` |`Highest priority low redundancy EC blocks` | count |
|`namenode_highest_priority_low_redundancy_replicated_blocks` |`Highest priority low redundancy replicated blocks` | count |
|`namenode_last_checkpoint_time` |`Last checkpoint time` | ms |
|`namenode_last_hatransition_time` |`Last HA transition time` | ms |
|`namenode_last_written_transaction_id` |`Last written transaction ID` | count |
|`namenode_list_snapshottable_dir_ops` |`List snapshottable directory operation counts` | count |
|`namenode_lock_queue_length` |`Lock queue length` | count |
|`namenode_low_redundancy_ecblock_groups` |`Low redundancy EC block groups` | count |
|`namenode_low_redundancy_replicated_blocks` |`Low redundancy replicated blocks` | count |
|`namenode_max_objects` |`Max object counts` | count |
|`namenode_millis_since_last_loaded_edits` |`Milliseconds since last loaded edits` | ms |
|`namenode_missing_blocks` |`Missing blocks` | count |
|`namenode_missing_ecblock_groups` |`Missing EC block groups` | count |
|`namenode_missing_repl_one_blocks` |`Missing replication one blocks` | count |
|`namenode_missing_replicated_blocks` |`Missing replicated blocks` | count |
|`namenode_missing_replication_one_blocks` |`Missing replication one blocks` | count |
|`namenode_nnstarted_time_in_millis` |`Start time (milliseconds)` | ms |
|`namenode_non_dfs_used_space` |`Non-DFS used space` | count |
|`namenode_num_active_clients` |`Active client counts` | count |
|`namenode_num_active_sinks` |`Active sink data node counts` | count |
|`namenode_num_active_sources` |`Active source data node counts` | count |
|`namenode_num_all_sinks` |`All sink data node counts` | count |
|`namenode_num_all_sources` |`All source data node counts` | count |
|`namenode_num_dead_data_nodes` |`Dead data node counts` | count |
|`namenode_num_decom_dead_data_nodes` |`Decommissioned dead data node counts` | count |
|`namenode_num_decom_live_data_nodes` |`Decommissioned live data node counts` | count |
|`namenode_num_decommissioning_data_nodes` |`Decommissioning data node counts` | count |
|`namenode_num_edit_log_loaded_avg_count` |`Edit log loaded average counts` | count |
|`namenode_num_edit_log_loaded_num_ops` |`Edit log loaded operation counts` | count |
|`namenode_num_encryption_zones` |`Encryption zone counts` | count |
|`namenode_num_entering_maintenance_data_nodes` |`Entering maintenance data node counts` | count |
|`namenode_num_files_under_construction` |`Files under construction counts` | count |
|`namenode_num_in_maintenance_dead_data_nodes` |`Maintenance dead data node counts` | count |
|`namenode_num_in_maintenance_live_data_nodes` |`Maintenance live data node counts` | count |
|`namenode_num_live_data_nodes` |`Live data node counts` | count |
|`namenode_num_stale_data_nodes` |`Stale data node counts` | count |
|`namenode_num_stale_storages` |`Stale storage counts` | count |
|`namenode_num_timed_out_pending_reconstructions` |`Timed out pending reconstruction counts` | count |
|`namenode_num_times_re_replication_not_scheduled` |`Not scheduled re-replication counts` | count |
|`namenode_number_of_missing_blocks` |`Missing block counts` | count |
|`namenode_number_of_missing_blocks_with_replication_factor_one` |`Missing block counts with replication factor one` | count |
|`namenode_number_of_snapshottable_dirs` |`Snapshottable directory counts` | count |
|`namenode_pending_data_node_message_count` |`Pending data node message counts` | count |
|`namenode_pending_deletion_blocks` |`Pending deletion block counts` | count |
|`namenode_pending_deletion_ecblocks` |`Pending deletion EC block counts` | count |
|`namenode_pending_deletion_replicated_blocks` |`Pending deletion replicated block counts` | count |
|`namenode_pending_reconstruction_blocks` |`Pending reconstruction block counts` | count |
|`namenode_pending_replication_blocks` |`Pending replication block counts` | count |
|`namenode_percent_block_pool_used` |`Block pool used percentage` | percent |
|`namenode_percent_complete` |`Complete percentage` | percent |
|`namenode_percent_remaining` |`Remaining percentage` | percent |
|`namenode_percent_used` |`Used percentage` | percent |
|`namenode_postponed_misreplicated_blocks` |`Postponed misreplicated block counts` | count |
|`namenode_publish_avg_time` |`Publish average time` | ms |
|`namenode_publish_num_ops` |`Publish operation counts` | count |
|`namenode_put_image_avg_time` |`Put image average time` | ms |
|`namenode_put_image_num_ops` |`Put image operation counts` | count |
|`namenode_rename_snapshot_ops` |`Rename snapshot operation counts` | count |
|`namenode_resource_check_time_avg_time` |`Resource check average time` | ms |
|`namenode_resource_check_time_num_ops` |`Resource check operation counts` | count |
|`namenode_safe_mode` |`Safe mode` | count |
|`namenode_safe_mode_count` |`Safe mode counts` | count |
|`namenode_safe_mode_elapsed_time` |`Safe mode elapsed time` | count |
|`namenode_safe_mode_percent_complete` |`Safe mode complete percentage` | percent |
|`namenode_safe_mode_time` |`Safe mode time` | ms |
|`namenode_saving_checkpoint` |`Saving checkpoint` | count |
|`namenode_saving_checkpoint_count` |`Saving checkpoint counts` | count |
|`namenode_saving_checkpoint_elapsed_time` |`Saving checkpoint elapsed time` | ms |
|`namenode_saving_checkpoint_percent_complete` |`Saving checkpoint complete percentage` | count |
|`namenode_scheduled_replication_blocks` |`Scheduled replication block counts` | count |
|`namenode_stale_data_nodes` |`Stale data nodes` | count |
|`namenode_storage_block_report_avg_time` |`Storage block report average time` | ms |
|`namenode_storage_block_report_num_ops` |`Storage block report operation counts` | count |
|`namenode_successful_re_replications` |`Successful re-replications` | count |
|`namenode_syncs_avg_time` |`Syncs average time` | ms |
|`namenode_syncs_num_ops` |`Syncs operation counts` | count |
|`namenode_tag_total_sync_times` |`Tag total sync times` | count |
|`namenode_timeout_re_replications` |`Timeout re-replications` | count |
|`namenode_total_blocks` |`Total block counts` | count |
|`namenode_total_ecblock_groups` |`Total EC block group counts` | count |
|`namenode_total_file_ops` |`Total file operation counts` | count |
|`namenode_total_load` |`Total load` | count |
|`namenode_total_replicated_blocks` |`Total replicated block counts` | count |
|`namenode_total_sync_count` |`Total sync counts` | count |
|`namenode_total_sync_times` |`Total sync times` | count |
|`namenode_transactions_avg_time` |`Transactions average time` | ms |
|`namenode_transactions_batched_in_sync` |`Transactions batched in sync` | count |
|`namenode_transactions_num_ops` |`Transactions operation counts` | count |
|`namenode_transactions_since_last_checkpoint` |`Transactions since last checkpoint` | count |
|`namenode_transactions_since_last_log_roll` |`Transactions since last log roll` | count |
|`namenode_under_replicated_blocks` |`Under replicated block counts` | count |
|`namenode_used` |`Used` | count |
|`namenode_volume_failures` |`Volume failure counts` | count |
|`namenode_warm_up_edektime_avg_time` |`Warm up EDEK average time` | ms |
|`namenode_warm_up_edektime_num_ops` |`Warm up EDEK operation counts` | count |