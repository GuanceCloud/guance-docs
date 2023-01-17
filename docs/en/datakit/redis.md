
# Redis
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "支持选举")

---

Redis indicator collector, which collects the following data:

- Turn on AOF data persistence and collect relevant metrics
- RDB data persistence metrics
- Slowlog monitoring metrics
- bigkey scan monitoring
- Master-slave replication

## Precondition {#reqirement}

- Redis version v5.0+

When collecting data under the master-slave architecture, please configure the host information of the slave node for data collection, and you can get the metric information related to the master-slave.

Create Monitor User

redis6.0+ goes to the rediss-cli command line, create the user and authorize

```sql
ACL SETUSER username >password
ACL SETUSER username on +@dangerous
ACL SETUSER username on +ping
```

## Configuration {#config}

=== "Host Installation"

    Go to the `conf.d/db` directory under the DataKit installation directory, copy `redis.conf.sample` and name it `redis.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.redis]]
      host = "localhost"
      port = 6379
      # unix_socket_path = "/var/run/redis/redis.sock"
      # Configure multiple dbs, and dbs will also be put into the collection list. if dbs=[] or not configured, all non-empty dbs in redis will be collected.
      # dbs=[]
      # username = "<USERNAME>"
      # password = "<PASSWORD>"
      
      ## @param connect_timeout - number - optional - default: 10s
      # connect_timeout = "10s"
      
      ## @param service - string - optional
      # service = "<SERVICE>"
      
      ## @param interval - number - optional - default: 15
      interval = "15s"
      
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
      
      ## @param slow_log - boolean - optional - default: false
      slow_log = true
      
      ## @param slowlog-max-len - integer - optional - default: 128
      slowlog-max-len = 128
      
      ## @param command_stats - boolean - optional - default: false
      ## Collect INFO COMMANDSTATS output as metrics.
      # command_stats = false
    
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
    
    After configuration, [restart DataKit](datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap injection collector configuration](datakit-daemonset-deploy.md#configmap-setting).

---

???+ attention

    If it is Alibaba Cloud Redis and the corresponding username and PASSWORD are set, the `<PASSWORD>` should be set to `your-user:your-password`, such as `datakit:Pa55W0rd`.

## Measurement {#reqirement}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.redis.tags]`:

``` toml
 [inputs.redis.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

### Metrics {#metric}





#### `redis_bigkey`



- Tag


| Tag Na me | Description    |
|  ----  | --------|
|`db_name`|db|
|`key`|monitor key|
|`server`|Server addr|

- Field List


| Metrics | Description| Data Type | Uni t   |
| ---- |---- | :---:    | :----: |
|`value_length`|Key length|int|-|






#### `redis_client`



- Tag


| Tag Name | Description    |
|  ----  | --------|
|`name`|The name set by the client with CLIENT SETNAME, default unknown|
|`server`|Server addr|

- Field List


| Metrics | Description| Data Type | Unit   |
| ---- |---- | :---:    | :----: |
|`addr`|Address/port of the client|string|-|
|`age`|Total duration of the connection in seconds|int|count|
|`fd`|File descriptor corresponding to the socket|int|count|
|`id`|AN unique 64-bit client ID|string|-|
|`idle`|Idle time of the connection in seconds|int|count|
|`psub`|Number of pattern matching subscriptions|int|count|
|`sub`|Number of channel subscriptions|int|count|






#### `redis_cluster`



- Tag


| Tag Name | Description    |
|  ----  | --------|
|`server`|Server addr|

- Field List


| Metrics | Description| Data Type | Unit   |
| ---- |---- | :---:    | :----: |
|`cluster_current_epoch`|The local Current Epoch variable. This is used in order to create unique increasing version numbers during fail overs.|int|-|
|`cluster_known_nodes`|The total number of known nodes in the cluster, including nodes in HANDSHAKE state that may not currently be proper members of the cluster.|int|count|
|`cluster_my_epoch`|The Config Epoch of the node we are talking with. This is the current configuration version assigned to this node.|int|-|
|`cluster_size`|The number of master nodes serving at least one hash slot in the cluster.|int|count|
|`cluster_slots_assigned`| Number of slots which are associated to some node (not unbound). This number should be 16384 for the node to work properly, which means that each hash slot should be mapped to a node.|int|count|
|`cluster_slots_fail`|Number of hash slots mapping to a node in FAIL state. If this number is not zero the node is not able to serve queries unless cluster-require-full-coverage is set to no in the configuration.|int|count|
|`cluster_slots_ok`|Number of hash slots mapping to a node not in FAIL or PFAIL state.|int|count|
|`cluster_slots_pfail`|Number of hash slots mapping to a node in PFAIL state. Note that those hash slots still work correctly, as long as the PFAIL state is not promoted to FAIL by the failure detection algorithm. PFAIL only means that we are currently not able to talk with the node, but may be just a transient error.|int|count|
|`cluster_state`|State is ok if the node is able to receive queries. fail if there is at least one hash slot which is unbound (no node associated), in error state (node serving it is flagged with FAIL flag), or if the majority of masters can't be reached by this node.|int|-|
|`cluster_stats_messages_received`|Number of messages received via the cluster node-to-node binary bus.|int|count|
|`cluster_stats_messages_sent`|Number of messages sent via the cluster node-to-node binary bus.|int|count|






#### `redis_command_stat`



- Tag


| Tag Name | Description    |
|  ----  | --------|
|`method`|Command type|
|`server`|Server addr|

- Field List


| Metrics | Description| Data Type | Unit   |
| ---- |---- | :---:    | :----: |
|`calls`|The number of calls that reached command execution|int|count|
|`usec`|The total CPU time consumed by these commands|int|μs|
|`usec_per_call`|The average CPU consumed per command execution|float|μs|






#### `redis_db`



- Tag


| Tag Name | Description    |
|  ----  | --------|
|`db`|db name|

- Field List


| Metrics | Description| Data Type | Unit   |
| ---- |---- | :---:    | :----: |
|`avg_ttl`|avg ttl|int|-|
|`expires`|Expired time|int|-|
|`keys`|key|int|-|






#### `redis_info`



- Tag


| Tag Name | Description    |
|  ----  | --------|
|`server`|Server addr|

- Field List


| Metrics | Description| Data Type | Unit   |
| ---- |---- | :---:    | :----: |
|`active_defrag_hits`|Number of value reallocations performed by active the defragmentation process|int|count|
|`active_defrag_key_hits`|Number of keys that were actively defragmented|int|count|
|`active_defrag_key_misses`|Number of keys that were skipped by the active defragmentation process|int|count|
|`active_defrag_misses`|Number of aborted value reallocations started by the active defragmentation process|int|count|
|`active_defrag_running`|Flag indicating if active defragmentation is active|bool|count|
|`aof_buffer_length`|Size of the AOF buffer|float|B|
|`aof_current_size`|AOF current file size|float|B|
|`aof_last_rewrite_time_sec`|Duration of the last AOF rewrite operation in seconds|int|count|
|`aof_rewrite_in_progress`|Flag indicating a AOF rewrite operation is on-going|bool|count|
|`blocked_clients`|Number of clients pending on a blocking call (BLPOP, BRPOP, BRPOPLPUSH, BLMOVE, BZPOPMIN, BZPOPMAX)|int|count|
|`client_biggest_input_buf`|Biggest input buffer among current client connections|int|B|
|`client_longest_output_list`|Longest output list among current client connections|int|count|
|`connected_clients`| Number of client connections (excluding connections from replicas)|int|count|
|`connected_slaves`|Number of connected replicas|int|count|
|`evicted_keys`|Number of evicted keys due to maxmemory limit|int|count|
|`expired_keys`|Total number of key expiration events|int|count|
|`info_latency_ms`|The latency of the redis INFO command.|float|ms|
|`keyspace_hits`|Number of successful lookup of keys in the main dictionary|int|count|
|`keyspace_misses`|Number of failed lookup of keys in the main dictionary|int|count|
|`latest_fork_usec`|Duration of the latest fork operation in microseconds|int|ms|
|`loading_eta_seconds`|ETA in seconds for the load to be complete|int|s|
|`loading_loaded_bytes`|Number of bytes already loaded|float|B|
|`loading_loaded_perc`|Same value expressed as a percentage|float|percent|
|`loading_total_bytes`|Total file size|float|B|
|`master_last_io_seconds_ago`|Number of seconds since the last interaction with master|int|s|
|`master_repl_offset`|The server's current replication offset|int|count|
|`master_sync_in_progress`|Indicate the master is syncing to the replica|bool|-|
|`master_sync_left_bytes`|Number of bytes left before syncing is complete (may be negative when master_sync_total_bytes is 0)|float|B|
|`maxmemory`|The value of the maxmemory configuration directive|float|B|
|`mem_fragmentation_ratio`|Ratio between used_memory_rss and used_memory|float|percent|
|`pubsub_channels`|Global number of pub/sub channels with client subscriptions|int|count|
|`pubsub_patterns`|Global number of pub/sub pattern with client subscriptions|int|count|
|`rdb_bgsave_in_progress`|Flag indicating a RDB save is on-going|bool|-|
|`rdb_changes_since_last_save`|Refers to the number of operations that produced some kind of changes in the dataset since the last time either SAVE or BGSAVE was called.|int|count|
|`rdb_last_bgsave_time_sec`|Duration of the last RDB save operation in seconds|int|s|
|`redis_version`|Version of the Redis server|string|-|
|`rejected_connections`|Number of connections rejected because of maxclients limit|int|count|
|`repl_backlog_histlen`|Size in bytes of the data in the replication backlog buffer|float|B|
|`slave_repl_offset`|The replication offset of the replica instance|int|count|
|`total_net_input_bytes`|The total number of bytes read from the network|int|count|
|`total_net_output_bytes`|The total number of bytes written to the network|int|count|
|`used_cpu_sys`|System CPU consumed by the Redis server, which is the sum of system CPU consumed by all threads of the server process (main thread and background threads)|float|s|
|`used_cpu_sys_children`|System CPU consumed by the background processes|float|s|
|`used_cpu_sys_percent`|System CPU percentage consumed by the Redis server, which is the sum of system CPU consumed by all threads of the server process (main thread and background threads)|float|percent|
|`used_cpu_user`|User CPU consumed by the Redis server, which is the sum of user CPU consumed by all threads of the server process (main thread and background threads)|float|s|
|`used_cpu_user_children`|User CPU consumed by the background processes|float|s|
|`used_cpu_user_percent`|User CPU percentage consumed by the Redis server, which is the sum of user CPU consumed by all threads of the server process (main thread and background threads)|float|percent|
|`used_memory`|Total number of bytes allocated by Redis using its allocator (either standard libc, jemalloc, or an alternative allocator such as tcmalloc)|float|B|
|`used_memory_lua`|Number of bytes used by the Lua engine|float|B|
|`used_memory_overhead`|The sum in bytes of all overheads that the server allocated for managing its internal data structures|float|B|
|`used_memory_peak`|Peak memory consumed by Redis (in bytes)|float|B|
|`used_memory_rss`|Number of bytes that Redis allocated as seen by the operating system (a.k.a resident set size)|float|B|
|`used_memory_startup`|Initial amount of memory consumed by Redis at startup in bytes|float|B|












### Log {#logging}

[:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6)





























#### `redis_latency`



- Tag


| Tag Name | Description    |
|  ----  | --------|
|`server`|Server addr|

- Field List


| Metrics | Description| Data Typ e | Unit   |
| ---- |---- | :---:    | :----: |
|`cost_time`|Latest event latency in millisecond.|int|ms|
|`event_name`|Event name.|string|-|
|`max_cost_time`|All-time maximum latency for this event.|int|ms|
|`occur_time`|Unix timestamp of the latest latency spike for the event.|int|sec|






#### `redis_slowlog`

Redis 慢查询命令历史，这里我们将其以日志的形式采集

- Tag


| Tag Name | Description    |
|  ----  | --------|
|`host`|host|
|`message`|log message|
|`server`|server|

- Field List


| Metrics | Description| Data Type | Unit   |
| ---- |---- | :---:    | :----: |
|`command`|slow command|int|μs|
|`slowlog_id`|slowlog unique id|int|-|
|`slowlog_micros`|cost time|int|μs|




## 日志采集 {#redis-logging}

需要采集 Redis 日志，需要开启 Redis `redis.config`中日志文件输出配置：

```toml
[inputs.redis.log]
    # 日志路径需要填入绝对路径
    files = ["/var/log/redis/*.log"]
```

???+ attention

    在配置日志采集时，需要将 DataKit 安装在 Redis 服务同一台主机中，或使用其它方式将日志挂载到 DataKit 所在机器。

    在 K8s 中，可以将 Redis 日志暴露到 stdout，DataKit 能自动找到其对应的日志。

### Pipeline 日志切割 {#pipeline}

原始日志为

```
122:M 14 May 2019 19:11:40.164 * Background saving terminated with success
```

切割后的字段列表如下：

| 字段名      | 字段值                                      | 说明                         |
| ---         | ---                                         | ---                          |
| `pid`       | `122`                                       | 进程id                       |
| `role`      | `M`                                         | 角色                         |
| `serverity` | `*`                                         | 服务                         |
| `statu`     | `notice`                                    | 日志级别                     |
| `msg`       | `Background saving terminated with success` | 日志内容                     |
| `time`      | `1557861100164000000`                       | 纳秒时间戳（作为行协议时间） |
