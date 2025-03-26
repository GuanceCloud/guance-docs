---
title     : 'NFS'
summary   : 'NFS 指标采集'
tags:
  - '主机'
__int_icon      : 'icon/nfs'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor:
  - desc: '暂无'
    path: '-'
---

:fontawesome-brands-linux: :material-kubernetes: :material-docker:

---

NFS 指标采集器，采集以下数据：

- RPC 吞吐量指标
- NFS 挂载点指标（仅支持 NFSv3 和 v4）
- NFSd 吞吐量指标

## 配置 {#config}

### 前置条件 {#requirements}

- NFS 客户端环境正确配置
- NFS 客户端正确挂载至服务器的共享目录

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->

=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/host` 目录，复制 `nfs.conf.sample` 并命名为 `nfs.conf`。示例如下：
    
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
    
    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    可通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting) 或 [配置 ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) 开启采集器。

    - **ENV_INPUT_NFS_INTERVAL**
    
        采集器重复间隔时长
    
        **字段类型**: Duration
    
        **采集器配置字段**: `interval`
    
        **默认值**: `10s`
    
    - **ENV_INPUT_NFS_ENABLE_MOUNT_STATS_RW_BYTES**
    
        开启 NFS 挂载点的详细字节读写信息
    
        **字段类型**: Boolean
    
        **采集器配置字段**: `enable_mount_stats_rw_bytes`
    
        **默认值**: `false`
    
    - **ENV_INPUT_NFS_ENABLE_MOUNT_STATS_TRANSPORT**
    
        开启 NFS 挂载点与服务端的传输信息
    
        **字段类型**: Boolean
    
        **采集器配置字段**: `enable_mount_stats_transport`
    
        **默认值**: `false`
    
    - **ENV_INPUT_NFS_ENABLE_MOUNT_STATS_EVENT**
    
        开启 NFS 事件统计信息
    
        **字段类型**: Boolean
    
        **采集器配置字段**: `enable_mount_stats_event`
    
        **默认值**: `false`
    
    - **ENV_INPUT_NFS_ENABLE_MOUNT_STATS_OPERATIONS**
    
        开启 NFS 给定操作的传输信息
    
        **字段类型**: Boolean
    
        **采集器配置字段**: `enable_mount_stats_operations`
    
        **默认值**: `false`
    
    - **ENV_INPUT_NFS_NFSD**
    
        开启 NFSd 指标
    
        **字段类型**: Boolean
    
        **采集器配置字段**: `nfsd`
    
        **默认值**: `false`

<!-- markdownlint-enable -->

### NFSd 开启 {#nfsd}

NFSd 是 NFS 服务的守护进程，是服务器端的一个关键组件，负责处理客户端发送的 NFS 请求。如果本地机器同时作为 NFS 服务器，则可开启该指标查看网络、磁盘 I/O、用户处理 NFS 请求的线程等统计信息。

如需开启，则需修改配置文件。

```toml
[[inputs.nfs]]
  ##(optional) collect interval, default is 10 seconds
  interval = '10s'
  ## 是否开启 NFSd 指标采集
  nfsd = true

...

```

### NFS 挂载点详细统计信息开启 {#nfs-mountstats}

默认开启的 nfs_mountstats 指标集仅展示挂载点磁盘用量以及 NFS 运行时间的统计信息，如需查看 NFS 挂载点的 R/W、Transport、Event、Operations 等信息则需要修改配置文件。

```toml
[[inputs.nfs]]
  
  ...

  ## NFS 挂载点指标配置
  [inputs.nfs.mountstats]
    ## 开启 R/W 统计信息
    # rw = true
    ## 开启传输统计信息 
    # transport = true
    ## 开启事件统计信息
    # event = true
    ## 开启操作统计信息
    # operations = true

...

```

## 指标 {#metric}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.nfs.tags]` 指定其它标签：

``` toml
 [inputs.nfs.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `nfs`

- 标签


| Tag | Description |
|  ----  | --------|
|`method`|Invoked method.|
|`protocol`|Protocol type.|

- 指标列表


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

- 标签


| Tag | Description |
|  ----  | --------|
|`device`|Device name.|
|`mountpoint`|Where the device is mounted.|
|`type`|Device type.|

- 指标列表


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
|`operations_latency_seconds`|Average RPC latency (RTT) for a given operation, in seconds.|float|s|
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

- 标签


| Tag | Description |
|  ----  | --------|
|`error`|Error type.|
|`method`|Invoked method.|
|`protocol`|Protocol type.|

- 指标列表


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


