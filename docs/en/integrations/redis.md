---
title     : 'Redis'
summary   : 'Collect Redis metrics and logs'
__int_icon      : 'icon/redis'
dashboard :
  - desc  : 'Redis'
    path  : 'dashboard/en/redis'
monitor:
  - desc: 'Redis'
    path: 'monitor/en/redis'
---

<!-- markdownlint-disable MD025 -->
# Redis
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

Redis indicator collector, which collects the following data:

- Turn on AOF data persistence and collect relevant metrics
- RDB data persistence metrics
- Slowlog monitoring metrics
- bigkey scan monitoring
- Master-slave replication

## Configuration {#config}

Already tested version:

- [x] 7.0.11
- [x] 6.2.12
- [x] 5.0.14
- [x] 4.0.14

### Precondition {#reqirement}

- Redis version v5.0+

When collecting data under the master-slave architecture, please configure the host information of the slave node for data collection, and you can get the metric information related to the master-slave.

Create Monitor User (**optional**)

redis6.0+ goes to the rediss-cli command line, create the user and authorize

```sql
ACL SETUSER username >password
ACL SETUSER username on +@dangerous
ACL SETUSER username on +ping
```

- goes to the rediss-cli command line, authorization statistics hotkey information

```sql
CONFIG SET maxmemory-policy allkeys-lfu
```

- collect hotkey & `bigkey` remote, need install redis-cli (collect local need not install it)

```shell
# ubuntu 
apt-get install redis-tools

# centos
yum install -y  redis
```

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Go to the `conf.d/db` directory under the DataKit installation directory, copy `redis.conf.sample` and name it `redis.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.redis]]
      host = "localhost"
      port = 6379
      # unix_socket_path = "/var/run/redis/redis.sock"
      # 配置多个 db，配置了 dbs，db 也会放入采集列表。dbs=[] 或者不配置则会采集 Redis 中所有非空的 db
      # dbs=[]
      # username = "<USERNAME>"
      # password = "<PASSWORD>"
    
      ## @param connect_timeout - number - optional - default: 10s
      # connect_timeout = "10s"
    
      ## @param service - string - optional
      service = "redis"
    
      ## @param interval - number - optional - default: 15
      interval = "15s"
    
      ## @param hotkey - boolean - optional - default: false
      ## If you collet hotkey, set this to true
      # hotkey = false
    
      ## @param bigkey - boolean - optional - default: false
      ## If you collet bigkey, set this to true
      # bigkey = false
    
      ## @param key_interval - number - optional - default: 5m
      ## Interval of collet hotkey & bigkey
      # key_interval = "5m"
    
      ## @param key_timeout - number - optional - default: 5m
      ## Timeout of collet hotkey & bigkey
      # key_timeout = "5m"
    
      ## @param key_scan_sleep - string - optional - default: "0.1"
      ## Mean sleep 0.1 sec per 100 SCAN commands
      # key_scan_sleep = "0.1"
    
      ## @param keys - list of strings - optional
      ## The length is 1 for strings.
      ## The length is zero for keys that have a type other than list, set, hash, or sorted set.
      #
      # keys = ["KEY_1", "KEY_PATTERN"]
    
      ## @param warn_on_missing_keys - boolean - optional - default: true
      ## If you provide a list of 'keys', set this to true to have the Agent log a warning
      ## when keys are missing.
      #
      # warn_on_missing_keys = true
    
      ## @param slow_log - boolean - optional - default: true
      slow_log = true
    
      ## @param all_slow_log - boolean - optional - default: false
      ## Collect all slowlogs returned by Redis. When set to false, will only collect slowlog
      ## that are generated after this input starts, and collect the same slowlog only once.
      all_slow_log = false
    
      ## @param slowlog-max-len - integer - optional - default: 128
      slowlog-max-len = 128
    
      ## @param command_stats - boolean - optional - default: false
      ## Collect INFO COMMANDSTATS output as metrics.
      # command_stats = false
    
      ## @param latency_percentiles - boolean - optional - default: false
      ## Collect INFO LATENCYSTATS output as metrics.
      # latency_percentiles = false
    
      ## Set true to enable election
      election = true
    
      # [inputs.redis.log]
      # #required, glob logfiles
      # files = ["/var/log/redis/*.log"]
    
      ## glob filteer
      #ignore = [""]
    
      ## grok pipeline script path
      #pipeline = "redis.p"
    
      ## optional encodings:
      ##    "utf-8", "utf-16le", "utf-16le", "gbk", "gb18030" or ""
      #character_encoding = ""
    
      ## The pattern should be a regexp. Note the use of '''this regexp'''
      ## regexp link: https://golang.org/pkg/regexp/syntax/#hdr-Syntax
      #match = '''^\S.*'''
    
      [inputs.redis.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    
    ```
    
    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap injection collector configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting).

---

???+ attention

    If it is Alibaba Cloud Redis and the corresponding username and PASSWORD are set, the `<PASSWORD>` should be set to `your-user:your-password`, such as `datakit:Pa55W0rd`.
<!-- markdownlint-enable -->

### Log Collection Configuration {#logging-config}

To collect Redis logs, you need to open the log file `redis.config` output configuration in Redis:

```toml
[inputs.redis.log]
    # Log path needs to be filled with absolute path
    files = ["/var/log/redis/*.log"]
```

<!-- markdownlint-disable MD046 -->
???+ attention

    When configuring log collection, you need to install the DataKit on the same host as the Redis service, or otherwise mount the log on the DataKit machine.
    
    In K8s, Redis logs can be exposed to stdout, and DataKit can automatically find its corresponding log.
<!-- markdownlint-enable -->

## Metrics {#metric}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.redis.tags]`:

``` toml
 [inputs.redis.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```













### `redis_client`



- tag


| Tag | Description |
|  ----  | --------|
|`addr`|Address without port of the client|
|`host`|Hostname|
|`name`|The name set by the client with `CLIENT SETNAME`, default unknown|
|`server`|Server addr|
|`service_name`|Service name|

- feld list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Total duration of the connection in seconds|float|s|
|`argv_mem`|Incomplete arguments for the next command (already extracted from query buffer).|float|count|
|`db`|Current database ID.|float|count|
|`fd`|File descriptor corresponding to the socket.|float|count|
|`id`|Unique 64-bit client ID.|float|count|
|`idle`|Idle time of the connection in seconds|float|s|
|`multi`|Number of commands in a MULTI/EXEC context.|float|count|
|`multi_mem`|Memory is used up by buffered multi commands. Added in Redis 7.0.|float|count|
|`obl`|Output buffer length.|float|count|
|`oll`|Output list length (replies are queued in this list when the buffer is full).|float|count|
|`omem`|Output buffer memory usage.|float|count|
|`psub`|Number of pattern matching subscriptions|float|count|
|`qbuf`|Query buffer length (0 means no query pending).|float|count|
|`qbuf_free`|Free space of the query buffer (0 means the buffer is full).|float|count|
|`redir`|Client id of current client tracking redirection.|float|count|
|`resp`|Client RESP protocol version. Added in Redis 7.0.|float|count|
|`ssub`|Number of shard channel subscriptions. Added in Redis 7.0.3.|float|count|
|`sub`|Number of channel subscriptions|float|count|
|`tot_mem`|Total memory consumed by this client in its various buffers.|float|count| 





### `redis_cluster`



- tag


| Tag | Description |
|  ----  | --------|
|`host`|Hostname|
|`server_addr`|Server addr|
|`service_name`|Service name|

- feld list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cluster_current_epoch`|The local Current Epoch variable. This is used in order to create unique increasing version numbers during fail overs.|float|-|
|`cluster_known_nodes`|The total number of known nodes in the cluster, including nodes in HANDSHAKE state that may not currently be proper members of the cluster.|float|count|
|`cluster_my_epoch`|The Config Epoch of the node we are talking with. This is the current configuration version assigned to this node.|float|-|
|`cluster_size`|The number of master nodes serving at least one hash slot in the cluster.|float|count|
|`cluster_slots_assigned`| Number of slots which are associated to some node (not unbound). This number should be 16384 for the node to work properly, which means that each hash slot should be mapped to a node.|float|count|
|`cluster_slots_fail`|Number of hash slots mapping to a node in FAIL state. If this number is not zero the node is not able to serve queries unless cluster-require-full-coverage is set to no in the configuration.|float|count|
|`cluster_slots_ok`|Number of hash slots mapping to a node not in `FAIL` or `PFAIL` state.|float|count|
|`cluster_slots_pfail`|Number of hash slots mapping to a node in `PFAIL` state. Note that those hash slots still work correctly, as long as the `PFAIL` state is not promoted to FAIL by the failure detection algorithm. `PFAIL` only means that we are currently not able to talk with the node, but may be just a transient error.|float|count|
|`cluster_state`|State is ok if the node is able to receive queries. fail if there is at least one hash slot which is unbound (no node associated), in error state (node serving it is flagged with FAIL flag), or if the majority of masters can't be reached by this node.|float|-|
|`cluster_stats_messages_auth_ack_received`|Message indicating a vote during leader election.|float|count|
|`cluster_stats_messages_auth_ack_sent`|Message indicating a vote during leader election.|float|count|
|`cluster_stats_messages_auth_req_received`|Replica initiated leader election to replace its master.|float|count|
|`cluster_stats_messages_auth_req_sent`|Replica initiated leader election to replace its master.|float|count|
|`cluster_stats_messages_fail_received`|Mark node xxx as failing received.|float|count|
|`cluster_stats_messages_fail_sent`|Mark node xxx as failing send.|float|count|
|`cluster_stats_messages_meet_received`|Handshake message received from a new node, either through gossip or CLUSTER MEET.|float|count|
|`cluster_stats_messages_meet_sent`|Handshake message sent to a new node, either through gossip or CLUSTER MEET.|float|count|
|`cluster_stats_messages_mfstart_received`|Pause clients for manual failover.|float|count|
|`cluster_stats_messages_mfstart_sent`|Pause clients for manual failover.|float|count|
|`cluster_stats_messages_module_received`|Module cluster API message.|float|count|
|`cluster_stats_messages_module_sent`|Module cluster API message.|float|count|
|`cluster_stats_messages_ping_received`|Cluster bus received PING (not to be confused with the client command PING).|float|count|
|`cluster_stats_messages_ping_sent`|Cluster bus send PING (not to be confused with the client command PING).|float|count|
|`cluster_stats_messages_pong_received`|PONG received (reply to PING).|float|count|
|`cluster_stats_messages_pong_sent`|PONG send (reply to PING).|float|count|
|`cluster_stats_messages_publish_received`|Pub/Sub Publish propagation received.|float|count|
|`cluster_stats_messages_publish_sent`|Pub/Sub Publish propagation send.|float|count|
|`cluster_stats_messages_publishshard_received`|Pub/Sub Publish shard propagation, see Sharded Pubsub.|float|count|
|`cluster_stats_messages_publishshard_sent`|Pub/Sub Publish shard propagation, see Sharded Pubsub.|float|count|
|`cluster_stats_messages_received`|Number of messages received via the cluster node-to-node binary bus.|float|count|
|`cluster_stats_messages_sent`|Number of messages sent via the cluster node-to-node binary bus.|float|count|
|`cluster_stats_messages_update_received`|Another node slots configuration.|float|count|
|`cluster_stats_messages_update_sent`|Another node slots configuration.|float|count|
|`total_cluster_links_buffer_limit_exceeded`|Accumulated count of cluster links freed due to exceeding the `cluster-link-sendbuf-limit` configuration.|float|count| 





### `redis_command_stat`



- tag


| Tag | Description |
|  ----  | --------|
|`host`|Hostname|
|`method`|Command type|
|`server`|Server addr|
|`service_name`|Service name|

- feld list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`calls`|The number of calls that reached command execution.|float|count|
|`failed_calls`|The number of failed calls (errors within the command execution).|float|count|
|`rejected_calls`|The number of rejected calls (errors prior command execution).|float|count|
|`usec`|The total CPU time consumed by these commands.|float|μs|
|`usec_per_call`|The average CPU consumed per command execution.|float|μs| 





### `redis_db`



- tag


| Tag | Description |
|  ----  | --------|
|`db`|DB name.|
|`host`|Hostname.|
|`server`|Server addr.|
|`service_name`|Service name.|

- feld list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`avg_ttl`|Average ttl.|int|-|
|`expires`|expires time.|int|-|
|`keys`|Key.|int|-| 





### `redis_info`



- tag


| Tag | Description |
|  ----  | --------|
|`command_type`|Command type.|
|`error_type`|Error type.|
|`host`|Hostname.|
|`quantile`|Histogram `quantile`.|
|`redis_version`|Version of the Redis server.|
|`server`|Server addr.|
|`service_name`|Service name.|

- feld list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`acl_access_denied_auth`|Number of authentication failures.|float|count|
|`acl_access_denied_channel`|Number of commands rejected because of access denied to a channel.|float|count|
|`acl_access_denied_cmd`|Number of commands rejected because of access denied to the command.|float|count|
|`acl_access_denied_key`|Number of commands rejected because of access denied to a key.|float|count|
|`active_defrag_hits`|Number of value reallocations performed by active the defragmentation process|float|count|
|`active_defrag_key_hits`|Number of keys that were actively defragmented|float|count|
|`active_defrag_key_misses`|Number of keys that were skipped by the active defragmentation process|float|count|
|`active_defrag_misses`|Number of aborted value reallocations started by the active defragmentation process|float|count|
|`active_defrag_running`|Flag indicating if active defragmentation is active|float|bool|
|`allocator_active`|Total bytes in the allocator active pages, this includes external-fragmentation..|float|B|
|`allocator_allocated`|Total bytes allocated form the allocator, including internal-fragmentation. Normally the same as used_memory..|float|B|
|`allocator_frag_bytes`|Delta between allocator_active and allocator_allocated. See note about mem_fragmentation_bytes..|float|B|
|`allocator_frag_ratio`|Ratio between allocator_active and allocator_allocated. This is the true (external) fragmentation metric (not mem_fragmentation_ratio)..|float|unknown|
|`allocator_resident`|Total bytes resident (RSS) in the allocator, this includes pages that can be released to the OS (by MEMORY PURGE, or just waiting)..|float|B|
|`allocator_rss_bytes`|Delta between allocator_resident and allocator_active.|float|B|
|`allocator_rss_ratio`|Ratio between allocator_resident and allocator_active. This usually indicates pages that the allocator can and probably will soon release back to the OS..|float|unknown|
|`aof_base_size`|AOF file size on latest startup or rewrite.|float|B|
|`aof_buffer_length`|Size of the AOF buffer|float|B|
|`aof_current_rewrite_time_sec`|Duration of the on-going AOF rewrite operation if any.|float|s|
|`aof_current_size`|AOF current file size|float|B|
|`aof_delayed_fsync`|Delayed fsync counter.|float|count|
|`aof_enabled`|Flag indicating AOF logging is activated.|float|bool|
|`aof_last_cow_size`|The size in bytes of copy-on-write memory during the last AOF rewrite operation.|float|B|
|`aof_last_rewrite_time_sec`|Duration of the last AOF rewrite operation in seconds|float|s|
|`aof_pending_bio_fsync`|Number of fsync pending jobs in background I/O queue.|float|count|
|`aof_pending_rewrite`|Flag indicating an AOF rewrite operation will be scheduled once the on-going RDB save is complete..|float|bool|
|`aof_rewrite_buffer_length`|Size of the AOF rewrite buffer. Note this field was removed in Redis 7.0.|float|B|
|`aof_rewrite_in_progress`|Flag indicating a AOF rewrite operation is on-going|float|bool|
|`aof_rewrite_scheduled`|Flag indicating an AOF rewrite operation will be scheduled once the on-going RDB save is complete..|float|bool|
|`aof_rewrites`|Number of AOF rewrites performed since startup.|float|count|
|`arch_bits`|Architecture (32 or 64 bits).|float|count|
|`async_loading`|Currently loading replication data-set asynchronously while serving old data. This means `repl-diskless-load` is enabled and set to `swapdb`. Added in Redis 7.0..|float|bool|
|`blocked_clients`|Number of clients pending on a blocking call (`BLPOP/BRPOP/BRPOPLPUSH/BLMOVE/BZPOPMIN/BZPOPMAX`)|float|count|
|`client_biggest_input_buf`|Biggest input buffer among current client connections|float|B|
|`client_longest_output_list`|Longest output list among current client connections|float|count|
|`client_recent_max_input_buffer`|Biggest input buffer among current client connections.|float|count|
|`client_recent_max_output_buffer`|Biggest output buffer among current client connections.|float|count|
|`clients_in_timeout_table`|Number of clients in the clients timeout table.|float|count|
|`cluster_connections`|An approximation of the number of sockets used by the cluster's bus.|float|count|
|`cluster_enabled`|Indicate Redis cluster is enabled.|float|bool|
|`configured_hz`|The server's configured frequency setting.|float|count|
|`connected_clients`| Number of client connections (excluding connections from replicas)|float|count|
|`connected_slaves`|Number of connected replicas|float|count|
|`current_active_defrag_time`|The time passed since memory fragmentation last was over the limit, in milliseconds.|float|ms|
|`current_cow_peak`|The peak size in bytes of copy-on-write memory while a child fork is running.|float|B|
|`current_cow_size`|The size in bytes of copy-on-write memory while a child fork is running.|float|B|
|`current_cow_size_age`|The age, in seconds, of the current_cow_size value..|float|s|
|`current_eviction_exceeded_time`|The time passed since used_memory last rose above `maxmemory`, in milliseconds.|float|ms|
|`current_fork_perc`|The percentage of progress of the current fork process. For AOF and RDB forks it is the percentage of current_save_keys_processed out of current_save_keys_total..|float|percent|
|`current_save_keys_processed`|Number of keys processed by the current save operation.|float|count|
|`current_save_keys_total`|Number of keys at the beginning of the current save operation.|float|count|
|`dump_payload_sanitizations`|Total number of dump payload deep integrity validations (see sanitize-dump-payload config)..|float|count|
|`errorstat`|Track of the different errors that occurred within Redis.|int|count|
|`eventloop_cycles`|Total number of `eventloop` cycles.|float|count|
|`eventloop_duration_cmd_sum`|Total time spent on executing commands in microseconds.|float|μs|
|`eventloop_duration_sum`|Total time spent in the `eventloop` in microseconds (including I/O and command processing).|float|μs|
|`evicted_clients`|Number of evicted clients due to `maxmemory-clients` limit. Added in Redis 7.0..|float|count|
|`evicted_keys`|Number of evicted keys due to Max-Memory limit|float|count|
|`expire_cycle_cpu_milliseconds`|The cumulative amount of time spent on active expiry cycles.|float|ms|
|`expired_keys`|Total number of key expiration events|float|count|
|`expired_stale_perc`|The percentage of keys probably expired.|float|percent|
|`expired_time_cap_reached_count`|The count of times that active expiry cycles have stopped early.|float|count|
|`hz`|The server's current frequency setting.|float|count|
|`info_latency_ms`|The latency of the redis INFO command.|float|ms|
|`instantaneous_eventloop_cycles_per_sec`|Number of `eventloop` cycles per second.|float|-|
|`instantaneous_eventloop_duration_usec`|Average time spent in a single `eventloop` cycle in microseconds.|float|μs|
|`instantaneous_input_kbps`|The network's read rate per second in KB/sec.|float|B/S|
|`instantaneous_input_repl_kbps`|The network's read rate per second in KB/sec for replication purposes.|float|B/S|
|`instantaneous_ops_per_sec`|Number of commands processed per second.|float|count|
|`instantaneous_output_kbps`|The network's write rate per second in KB/sec.|float|B/S|
|`instantaneous_output_repl_kbps`|The network's write rate per second in KB/sec for replication purposes.|float|B/S|
|`io_threaded_reads_processed`|Number of read events processed by the main and I/O threads.|float|count|
|`io_threaded_writes_processed`|Number of write events processed by the main and I/O threads.|float|count|
|`io_threads_active`|Flag indicating if I/O threads are active.|float|bool|
|`keyspace_hits`|Number of successful lookup of keys in the main dictionary|float|count|
|`keyspace_misses`|Number of failed lookup of keys in the main dictionary|float|count|
|`latency_percentiles_usec`|Latency percentile distribution statistics based on the command type.|float|ms|
|`latest_fork_usec`|Duration of the latest fork operation in microseconds|float|μs|
|`lazyfree_pending_objects`|The number of objects waiting to be freed (as a result of calling UNLINK, or `FLUSHDB` and `FLUSHALL` with the ASYNC option).|float|count|
|`lazyfreed_objects`|The number of objects that have been lazy freed..|float|count|
|`loading`|Flag indicating if the load of a dump file is on-going.|float|bool|
|`loading_eta_seconds`|ETA in seconds for the load to be complete|float|s|
|`loading_loaded_bytes`|Number of bytes already loaded|float|B|
|`loading_loaded_perc`|Same value expressed as a percentage|float|percent|
|`loading_rdb_used_mem`|The memory usage of the server that had generated the RDB file at the time of the file's creation.|float|B|
|`loading_start_time`|Epoch-based timestamp of the start of the load operation.|float|sec|
|`loading_total_bytes`|Total file size.|float|B|
|`lru_clock`|Clock incrementing every minute, for LRU management.|float|ms|
|`master_last_io_seconds_ago`|Number of seconds since the last interaction with master|float|s|
|`master_link_down_since_seconds`|Number of seconds since the link is down.|float|s|
|`master_repl_offset`|The server's current replication offset|float|count|
|`master_sync_in_progress`|Indicate the master is syncing to the replica|float|bool|
|`master_sync_last_io_seconds_ago`|Number of seconds since last transfer I/O during a SYNC operation.|float|s|
|`master_sync_left_bytes`|Number of bytes left before syncing is complete (may be negative when master_sync_total_bytes is 0)|float|B|
|`master_sync_perc`|The percentage master_sync_read_bytes from master_sync_total_bytes, or an approximation that uses loading_rdb_used_mem when master_sync_total_bytes is 0.|float|percent|
|`master_sync_read_bytes`|Number of bytes already transferred.|float|B|
|`master_sync_total_bytes`|Total number of bytes that need to be transferred. this may be 0 when the size is unknown (for example, when the `repl-diskless-sync` configuration directive is used).|float|B|
|`maxclients`|The value of the `maxclients` configuration directive. This is the upper limit for the sum of connected_clients, connected_slaves and cluster_connections.|float|count|
|`maxmemory`|The value of the Max Memory configuration directive|float|B|
|`mem_aof_buffer`|Transient memory used for AOF and AOF rewrite buffers.|float|B|
|`mem_clients_normal`|Memory used by normal clients.|float|B|
|`mem_clients_slaves`|Memory used by replica clients - Starting Redis 7.0, replica buffers share memory with the replication backlog, so this field can show 0 when replicas don't trigger an increase of memory usage..|float|B|
|`mem_cluster_links`|Memory used by links to peers on the cluster bus when cluster mode is enabled..|float|B|
|`mem_fragmentation_bytes`|Delta between used_memory_rss and used_memory. Note that when the total fragmentation bytes is low (few megabytes), a high ratio (e.g. 1.5 and above) is not an indication of an issue..|float|B|
|`mem_fragmentation_ratio`|Ratio between used_memory_rss and used_memory|float|unknown|
|`mem_not_counted_for_evict`|Used memory that's not counted for key eviction. This is basically transient replica and AOF buffers..|float|B|
|`mem_replication_backlog`|Memory used by replication backlog.|float|B|
|`mem_total_replication_buffers`|Total memory consumed for replication buffers - Added in Redis 7.0..|float|B|
|`migrate_cached_sockets`|The number of sockets open for MIGRATE purposes.|float|count|
|`min_slaves_good_slaves`|Number of replicas currently considered good.|float|count|
|`module_fork_in_progress`|Flag indicating a module fork is on-going.|float|bool|
|`module_fork_last_cow_size`|The size in bytes of copy-on-write memory during the last module fork operation.|float|B|
|`pubsub_channels`|Global number of pub/sub channels with client subscriptions|float|count|
|`pubsub_patterns`|Global number of pub/sub pattern with client subscriptions|float|count|
|`pubsubshard_channels`|Global number of pub/sub shard channels with client subscriptions. Added in Redis 7.0.3.|float|count|
|`rdb_bgsave_in_progress`|Flag indicating a RDB save is on-going|float|bool|
|`rdb_changes_since_last_save`|Refers to the number of operations that produced some kind of changes in the dataset since the last time either `SAVE` or `BGSAVE` was called.|float|count|
|`rdb_current_bgsave_time_sec`|Duration of the on-going RDB save operation if any.|float|s|
|`rdb_last_bgsave_time_sec`|Duration of the last RDB save operation in seconds|float|s|
|`rdb_last_cow_size`|The size in bytes of copy-on-write memory during the last RDB save operation.|float|B|
|`rdb_last_load_keys_expired`|Number of volatile keys deleted during the last RDB loading. Added in Redis 7.0..|float|count|
|`rdb_last_load_keys_loaded`|Number of keys loaded during the last RDB loading. Added in Redis 7.0..|float|count|
|`rdb_last_save_time`|Epoch-based timestamp of last successful RDB save.|float|sec|
|`rdb_saves`|Number of RDB snapshots performed since startup.|float|count|
|`rejected_connections`|Number of connections rejected because of Max-Clients limit|float|count|
|`repl_backlog_active`|Flag indicating replication backlog is active.|float|bool|
|`repl_backlog_first_byte_offset`|The master offset of the replication backlog buffer.|float|count|
|`repl_backlog_histlen`|Size in bytes of the data in the replication backlog buffer|float|B|
|`repl_backlog_size`|Total size in bytes of the replication backlog buffer.|float|B|
|`replica_announced`|Flag indicating if the replica is announced by Sentinel..|float|count|
|`rss_overhead_bytes`|Delta between used_memory_rss (the process RSS) and allocator_resident.|float|B|
|`rss_overhead_ratio`|Ratio between used_memory_rss (the process RSS) and allocator_resident. This includes RSS overheads that are not allocator or heap related..|float|unknown|
|`second_repl_offset`|The offset up to which replication IDs are accepted.|float|count|
|`server_time_usec`|Epoch-based system time with microsecond precision.|float|ms|
|`shutdown_in_milliseconds`|The maximum time remaining for replicas to catch up the replication before completing the shutdown sequence. This field is only present during shutdown.|float|ms|
|`slave_expires_tracked_keys`|The number of keys tracked for expiry purposes (applicable only to writable replicas).|float|count|
|`slave_priority`|The priority of the instance as a candidate for failover.|float|count|
|`slave_read_only`|Flag indicating if the replica is read-only.|float|count|
|`slave_read_repl_offset`|The read replication offset of the replica instance..|float|count|
|`slave_repl_offset`|The replication offset of the replica instance|float|count|
|`stat_reply_buffer_expands`|Total number of output buffer expands.|float|count|
|`stat_reply_buffer_shrinks`|Total number of output buffer shrinks.|float|count|
|`sync_full`|The number of full `resyncs` with replicas.|float|count|
|`sync_partial_err`|The number of denied partial resync requests.|float|count|
|`sync_partial_ok`|The number of accepted partial resync requests.|float|count|
|`tcp_port`|TCP/IP listen port.|float|ms|
|`total_active_defrag_time`|Total time memory fragmentation was over the limit, in milliseconds.|float|ms|
|`total_blocking_keys`|Number of blocking keys.|float|count|
|`total_blocking_keys_on_nokey`|Number of blocking keys that one or more clients that would like to be unblocked when the key is deleted.|float|count|
|`total_commands_processed`|Total number of commands processed by the server.|float|count|
|`total_connections_received`|Total number of connections accepted by the server.|float|count|
|`total_error_replies`|Total number of issued error replies, that is the sum of rejected commands (errors prior command execution) and failed commands (errors within the command execution).|float|count|
|`total_eviction_exceeded_time`|Total time used_memory was greater than `maxmemory` since server startup, in milliseconds.|float|ms|
|`total_forks`|Total number of fork operations since the server start.|float|count|
|`total_net_input_bytes`|The total number of bytes read from the network|float|B|
|`total_net_output_bytes`|The total number of bytes written to the network|float|B|
|`total_net_repl_input_bytes`|The total number of bytes read from the network for replication purposes.|float|B|
|`total_net_repl_output_bytes`|The total number of bytes written to the network for replication purposes.|float|B|
|`total_reads_processed`|Total number of read events processed.|float|count|
|`total_system_memory`|The total amount of memory that the Redis host has.|float|B|
|`total_writes_processed`|Total number of write events processed.|float|count|
|`tracking_clients`|Number of clients being tracked (CLIENT TRACKING).|float|count|
|`tracking_total_items`|Number of items, that is the sum of clients number for each key, that are being tracked.|float|count|
|`tracking_total_keys`|Number of keys being tracked by the server.|float|count|
|`tracking_total_prefixes`|Number of tracked prefixes in server's prefix table (only applicable for broadcast mode).|float|count|
|`unexpected_error_replies`|Number of unexpected error replies, that are types of errors from an AOF load or replication.|float|count|
|`uptime_in_days`|Same value expressed in days.|float|d|
|`uptime_in_seconds`|Number of seconds since Redis server start.|float|s|
|`used_cpu_sys`|System CPU consumed by the Redis server, which is the sum of system CPU consumed by all threads of the server process (main thread and background threads).|float|s|
|`used_cpu_sys_children`|System CPU consumed by the background processes.|float|s|
|`used_cpu_sys_main_thread`|System CPU consumed by the Redis server main thread.|float|s|
|`used_cpu_sys_percent`|System CPU percentage consumed by the Redis server, which is the sum of system CPU consumed by all threads of the server process (main thread and background threads)|float|percent|
|`used_cpu_user`|User CPU consumed by the Redis server, which is the sum of user CPU consumed by all threads of the server process (main thread and background threads).|float|s|
|`used_cpu_user_children`|User CPU consumed by the background processes.|float|s|
|`used_cpu_user_main_thread`|User CPU consumed by the Redis server main thread.|float|s|
|`used_cpu_user_percent`|User CPU percentage consumed by the Redis server, which is the sum of user CPU consumed by all threads of the server process (main thread and background threads)|float|percent|
|`used_memory`|Total number of bytes allocated by Redis using its allocator (either standard libc, jemalloc, or an alternative allocator such as tcmalloc)|float|B|
|`used_memory_dataset`|The size in bytes of the dataset (used_memory_overhead subtracted from used_memory).|float|B|
|`used_memory_dataset_perc`|The percentage of used_memory_dataset out of the net memory usage (used_memory minus used_memory_startup).|float|percent|
|`used_memory_lua`|Number of bytes used by the Lua engine|float|B|
|`used_memory_overhead`|The sum in bytes of all overheads that the server allocated for managing its internal data structures|float|B|
|`used_memory_peak`|Peak memory consumed by Redis (in bytes)|float|B|
|`used_memory_peak_perc`|The percentage of used_memory_peak out of used_memory.|float|percent|
|`used_memory_rss`|Number of bytes that Redis allocated as seen by the operating system (a.k.a resident set size)|float|B|
|`used_memory_scripts`|Number of bytes used by cached Lua scripts.|float|B|
|`used_memory_startup`|Initial amount of memory consumed by Redis at startup in bytes|float|B| 











## Logging {#logging}

<!-- markdownlint-disable MD024 -->




### `redis_bigkey`



- tag


| Tag | Description |
|  ----  | --------|
|`db_name`|DB name.|
|`host`|Hostname.|
|`key`|Key name.|
|`key_type`|Key type.|
|`server`|Server addr.|
|`service_name`|Service name.|

- field list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`keys_sampled`|Sampled keys in the key space.|int|-|
|`value_length`|Key length.|int|-| 





### `redis_hotkey`



- tag


| Tag | Description |
|  ----  | --------|
|`db_name`|DB name.|
|`host`|Hostname.|
|`key`|Key name.|
|`server`|Server addr.|
|`service_name`|Service name.|

- field list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`key_count`|Key count times.|int|-|
|`keys_sampled`|Sampled keys in the key space.|int|-| 

























### `redis_latency`



- tag


| Tag | Description |
|  ----  | --------|
|`server`|Server addr|
|`service_name`|Service name|

- field list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cost_time`|Latest event latency in millisecond.|int|ms|
|`event_name`|Event name.|string|-|
|`max_cost_time`|All-time maximum latency for this event.|int|ms|
|`occur_time`|Unix timestamp of the latest latency spike for the event.|int|sec| 





### `redis_slowlog`

Redis 慢查询命令历史，这里我们将其以日志的形式采集

- tag


| Tag | Description |
|  ----  | --------|
|`host`|host|
|`message`|log message|
|`server`|server|
|`service_name`|Service name|

- field list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`command`|Slow command|int|μs|
|`slowlog_id`|Slow log unique id|int|-|
|`slowlog_micros`|Cost time|int|μs| 



### Logging Pipeline {#pipeline}

The original log is:

```
122:M 14 May 2019 19:11:40.164 * Background saving terminated with success
```

The list of cut fields is as follows:

| Field Name  | Field Value                                 | Description                                  |
| ---         | ---                                         | ---                                          |
| `pid`       | `122`                                       | process id                                   |
| `role`      | `M`                                         | role                                         |
| `serverity` | `*`                                         | service                                      |
| `statu`     | `notice`                                    | log level                                    |
| `msg`       | `Background saving terminated with success` | log content                                  |
| `time`      | `1557861100164000000`                       | Nanosecond timestamp (as line protocol time) |
