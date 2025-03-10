---
title     : 'NFS'
summary   : 'NFS Metrics Collection'
tags:
  - 'Host'
__int_icon      : 'icon/nfs'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor:
  - desc: 'Not available'
    path: '-'
---

:fontawesome-brands-linux: :material-kubernetes: :material-docker:

---

NFS metrics collector gathers the following data:

- RPC throughput metrics
- NFS mount point metrics (supports only NFSv3 and v4)
- NFSd throughput metrics

## Configuration {#config}

### Prerequisites {#requirements}

- Correctly configured NFS client environment
- NFS client correctly mounted to the server's shared directory

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->

=== "Host Installation"

    Enter the `conf.d/host` directory under the DataKit installation directory, copy `nfs.conf.sample` and rename it to `nfs.conf`. Example configuration:
    
    ```toml
        
    [[inputs.nfs]]
      ##(optional) collect interval, default is 10 seconds
      interval = '10s'
      ## Whether to enable NFSd metric collection
      # nfsd = true
    
      ## NFS mount point metric configuration
      [inputs.nfs.mountstats]
        ## Enable r/w statistics
        # rw = true
        ## Enable transport statistics
        # transport = true
        ## Enable event statistics
        # event = true
        ## Enable operation statistics
        # operations = true
    
      [inputs.nfs.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
    ```
    
    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can inject the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting) or configure [ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) to enable the collector.

    - **ENV_INPUT_NFS_INTERVAL**
    
        Collector repeat interval duration
    
        **Field Type**: Duration
    
        **Collector Configuration Field**: `interval`
    
        **Default Value**: `10s`
    
    - **ENV_INPUT_NFS_ENABLE_MOUNT_STATS_RW_BYTES**
    
        Enable detailed byte read/write information for NFS mount points
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_mount_stats_rw_bytes`
    
        **Default Value**: `false`
    
    - **ENV_INPUT_NFS_ENABLE_MOUNT_STATS_TRANSPORT**
    
        Enable transport information between NFS mount points and the server
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_mount_stats_transport`
    
        **Default Value**: `false`
    
    - **ENV_INPUT_NFS_ENABLE_MOUNT_STATS_EVENT**
    
        Enable NFS event statistics
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_mount_stats_event`
    
        **Default Value**: `false`
    
    - **ENV_INPUT_NFS_ENABLE_MOUNT_STATS_OPERATIONS**
    
        Enable transport information for given NFS operations
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_mount_stats_operations`
    
        **Default Value**: `false`
    
    - **ENV_INPUT_NFS_NFSD**
    
        Enable NFSd metrics
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `nfsd`
    
        **Default Value**: `false`

<!-- markdownlint-enable -->

### Enabling NFSd {#nfsd}

NFSd is the daemon process for NFS service, a key component on the server side that handles NFS requests from clients. If the local machine also acts as an NFS server, enabling this feature will allow you to view statistics such as network, disk I/O, and threads handling NFS requests.

To enable, modify the configuration file.

```toml
[[inputs.nfs]]
  ##(optional) collect interval, default is 10 seconds
  interval = '10s'
  ## Whether to enable NFSd metrics collection
  nfsd = true

...

```

### Enabling Detailed Statistics for NFS Mount Points {#nfs-mountstats}

By default, the enabled `nfs_mountstats` Measurement set only displays statistics on mount point disk usage and NFS runtime. To view R/W, Transport, Event, Operations information of NFS mount points, modify the configuration file.

```toml
[[inputs.nfs]]
  
  ...

  ## NFS mount point metrics configuration
  [inputs.nfs.mountstats]
    ## Enable R/W statistics
    # rw = true
    ## Enable transport statistics 
    # transport = true
    ## Enable event statistics
    # event = true
    ## Enable operation statistics
    # operations = true

...

```

## Metrics {#metric}

All collected data below will append a global tag named `host` (tag value is the hostname where DataKit resides), and additional tags can be specified in the configuration using `[inputs.nfs.tags]`:

``` toml
 [inputs.nfs.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `nfs`

- Tags


| Tag | Description |
|  ----  | --------|
|`method`|Invoked method.|
|`protocol`|Protocol type.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`connections_total`|Total number of NFSd TCP connections.|int|count|
|`requests_total`|Number of NFS procedures invoked.|int|count|
|`rpc_authentication_refreshes_total`|Number of RPC authentication refreshes performed.|int|count|
|`rpc_retransmissions_total`|Number of RPC transmissions performed.|int|count|
|`rpcs_total`|Total number of RPCs performed.|int|count|
|`tcp_packets_total`|Total NFSd network TCP packets (sent+received) by protocol type.|int|count|
|`udp_packets_total`|Total NFSd network UDP packets (sent+received) by protocol type.|int|count|



### `nfs_mountstats`

- Tags


| Tag | Description |
|  ----  | --------|
|`device`|Device name.|
|`mountpoint`|Where the device is mounted.|
|`type`|Device type.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age_seconds_total`|The age of the NFS mount in seconds.|int|s|
|`direct_read_bytes_total`|Number of bytes read using the read() syscall in O_DIRECT mode.|int|B|
|`direct_write_bytes_total`|Number of bytes written using the write() syscall in O_DIRECT mode.|int|B|
|`event_attribute_invalidate_total`|Number of times cached inode attributes are invalidated.|int|count|
|`event_data_invalidate_total`|Number of times an inode cache is cleared.|int|count|
|`event_dnode_revalidate_total`|Number of times cached dentry nodes are re-validated from the server.|int|count|
|`event_inode_revalidate_total`|Number of times cached inode attributes are re-validated from the server.|int|count|
|`event_jukebox_delay_total`|Number of times the NFS server indicated EJUKEBOX; retrieving data from offline storage.|int|count|
|`event_pnfs_read_total`|Number of NFS v4.1+ pNFS reads.|int|count|
|`event_pnfs_write_total`|Number of NFS v4.1+ pNFS writes.|int|count|
|`event_short_read_total`|Number of times the NFS server gave less data than expected while reading.|int|count|
|`event_short_write_total`|Number of times the NFS server wrote less data than expected while writing.|int|count|
|`event_silly_rename_total`|Number of times a file was removed while still open by another process.|int|count|
|`event_truncation_total`|Number of times files have been truncated.|int|count|
|`event_vfs_access_total`|Number of times permissions have been checked.|int|count|
|`event_vfs_file_release_total`|Number of times files have been closed and released.|int|count|
|`event_vfs_flush_total`|Number of pending writes that have been forcefully flushed to the server.|int|count|
|`event_vfs_fsync_total`|Number of times fsync() has been called on directories and files.|int|count|
|`event_vfs_getdents_total`|Number of times directory entries have been read with getdents().|int|count|
|`event_vfs_lock_total`|Number of times locking has been attempted on a file.|int|count|
|`event_vfs_lookup_total`|Number of times a directory lookup has occurred.|int|count|
|`event_vfs_open_total`|Number of times cached inode attributes are invalidated.|int|count|
|`event_vfs_read_page_total`|Number of pages read directly via mmap()'d files.|int|count|
|`event_vfs_read_pages_total`|Number of times a group of pages have been read.|int|count|
|`event_vfs_setattr_total`|Number of times directory entries have been read with getdents().|int|count|
|`event_vfs_update_page_total`|Number of updates (and potential writes) to pages.|int|count|
|`event_vfs_write_page_total`|Number of pages written directly via mmap()'d files.|int|count|
|`event_vfs_write_pages_total`|Number of times a group of pages have been written.|int|count|
|`event_write_extension_total`|Number of times a file has been grown due to writes beyond its existing end.|int|count|
|`fs_avail`|Available space on the filesystem.|int|B|
|`fs_size`|Total size of the filesystem.|int|B|
|`fs_used`|Used space on the filesystem.|int|B|
|`fs_used_percent`|Percentage of used space on the filesystem.|float|percent|
|`operations_major_timeouts_total`|Number of times a request has had a major timeout for a given operation.|int|count|
|`operations_queue_time_seconds_total`|Duration all requests spent queued for transmission for a given operation before they were sent, in seconds.|s|count|
|`operations_received_bytes_total`|Number of bytes received for a given operation, including RPC headers and payload.|int|B|
|`operations_request_time_seconds_total`|Duration all requests took from when a request was enqueued to when it was completely handled for a given operation, in seconds.|s|count|
|`operations_requests_total`|Number of requests performed for a given operation.|int|count|
|`operations_response_time_seconds_total`|Duration all requests took to get a reply back after a request for a given operation was transmitted, in seconds.|s|count|
|`operations_sent_bytes_total`|Number of bytes sent for a given operation, including RPC headers and payload.|int|B|
|`operations_transmissions_total`|Number of times an actual RPC request has been transmitted for a given operation.|int|count|
|`read_bytes_total`|Number of bytes read using the read() syscall.|int|B|
|`read_pages_total`|Number of pages read directly via mmap()'d files.|int|count|
|`total_read_bytes_total`|Number of bytes read from the NFS server, in total.|int|B|
|`total_write_bytes_total`|Number of bytes written to the NFS server, in total.|int|B|
|`transport_backlog_queue_total`|Total number of items added to the RPC backlog queue.|int|count|
|`transport_bad_transaction_ids_total`|Number of times the NFS server sent a response with a transaction ID unknown to this client.|int|count|
|`transport_bind_total`|Number of times the client has had to establish a connection from scratch to the NFS server.|int|count|
|`transport_connect_total`|Number of times the client has made a TCP connection to the NFS server.|int|count|
|`transport_idle_time_seconds`|Duration since the NFS mount last saw any RPC traffic, in seconds.|int|s|
|`transport_maximum_rpc_slots`|Maximum number of simultaneously active RPC requests ever used.|int|count|
|`transport_pending_queue_total`|Total number of items added to the RPC transmission pending queue.|int|count|
|`transport_receives_total`|Number of RPC responses for this mount received from the NFS server.|int|count|
|`transport_sending_queue_total`|Total number of items added to the RPC transmission sending queue.|int|count|
|`transport_sends_total`|Number of RPC requests for this mount sent to the NFS server.|int|count|
|`write_bytes_total`|Number of bytes written using the write() syscall.|int|B|
|`write_pages_total`|Number of pages written directly via mmap()'d files.|int|count|



### `nfsd`

- Tags


| Tag | Description |
|  ----  | --------|
|`error`|Error type.|
|`method`|Invoked method.|
|`protocol`|Protocol type.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`connections_total`|Total number of NFSd TCP connections.|int|count|
|`disk_bytes_read_total`|Total NFSd bytes read.|int|count|
|`disk_bytes_written_total`|Total NFSd bytes written.|int|count|
|`file_handles_stale_total`|Total number of NFSd stale file handles|int|count|
|`read_ahead_cache_not_found_total`|Total number of NFSd read ahead cache not found.|int|count|
|`read_ahead_cache_size_blocks`|How large the read ahead cache is in blocks.|int|count|
|`reply_cache_hits_total`|Total number of NFSd Reply Cache hits (client lost server response).|int|count|
|`reply_cache_misses_total`|Total number of NFSd Reply Cache an operation that requires caching (idempotent).|int|count|
|`reply_cache_nocache_total`|Total number of NFSd Reply Cache non-idempotent operations (rename/delete/…).|int|count|
|`rpc_errors_total`|Total number of NFSd RPC errors by error type.|int|count|
|`server_rpcs_total`|Total number of NFSd RPCs.|int|count|
|`server_threads`|Total number of NFSd kernel threads that are running.|int|count|
|`tcp_packets_total`|Total NFSd network TCP packets (sent+received) by protocol type.|int|count|
|`udp_packets_total`|Total NFSd network UDP packets (sent+received) by protocol type.|int|count|