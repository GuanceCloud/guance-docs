# Redis 部署

## 1. 简介

REmote DIctionary Server(Redis) 是一个由 Salvatore Sanfilippo 写的 key-value 存储系统，是跨平台的非关系型数据库。

Redis 是一个开源的使用 ANSI C 语言编写、遵守 BSD 协议、支持网络、可基于内存、分布式、可选持久性的键值对(Key-Value)存储数据库，并提供多种语言的 API。

Redis 通常被称为数据结构服务器，因为值（value）可以是字符串(String)、哈希(Hash)、列表(list)、集合(sets)和有序集合(sorted sets)等类型。

## 2. 前提条件

- 已部署 Kubernetes 集群

  

## 3. 安装

```shell
# 若需要修改密码，请提前修改/etc/kubeasz/guance/infrastructure/yaml/redis.yaml
# 创建命名空间
kubectl  create  ns middleware
# 部署redis服务
kubectl  apply  -f /etc/kubeasz/guance/infrastructure/yaml/redis.yaml  -n middleware
```



## 4. 验证部署及配置

### 4.1  查看容器状态

```shell
[root@k8s-node01 ]# kubectl  get pods -n middleware  |grep redis
redis-5f9b78c6d6-75b2j      1/1     Running   0          2m2s
```

### 4.2 验证服务
???+ success "验证Redis服务可用性"

    ```shell
    # 默认密码 "pNpX15GZkgICqX5D"
    [root@k8s-node01 ~]# kubectl  exec -it -n middleware  redis-5f9b78c6d6-75b2j  -- redis-cli
    127.0.0.1:6379> auth pNpX15GZkgICqX5D
    OK
    127.0.0.1:6379> info
    # Server
    redis_version:5.0.7
    redis_git_sha1:00000000
    redis_git_dirty:0
    redis_build_id:825c96d6c798641
    redis_mode:standalone
    os:Linux 3.10.0-957.el7.x86_64 x86_64
    arch_bits:64
    multiplexing_api:epoll
    atomicvar_api:atomic-builtin
    gcc_version:8.3.0
    process_id:1
    run_id:9b86da362619ce26b54a1a4266d0b44aa0b44693
    tcp_port:6379
    uptime_in_seconds:254
    uptime_in_days:0
    hz:10
    configured_hz:10
    lru_clock:6527977
    executable:/data/redis-server
    config_file:/usr/local/etc/redis/redis.conf

    # Clients
    connected_clients:1
    client_recent_max_input_buffer:2
    client_recent_max_output_buffer:0
    blocked_clients:0

    # Memory
    used_memory:854216
    used_memory_human:834.20K
    used_memory_rss:2920448
    used_memory_rss_human:2.79M
    used_memory_peak:854216
    used_memory_peak_human:834.20K
    used_memory_peak_perc:100.00%
    used_memory_overhead:841014
    used_memory_startup:791320
    used_memory_dataset:13202
    used_memory_dataset_perc:20.99%
    allocator_allocated:1027544
    allocator_active:1220608
    allocator_resident:3780608
    total_system_memory:16826011648
    total_system_memory_human:15.67G
    used_memory_lua:37888
    used_memory_lua_human:37.00K
    used_memory_scripts:0
    used_memory_scripts_human:0B
    number_of_cached_scripts:0
    maxmemory:0
    maxmemory_human:0B
    maxmemory_policy:noeviction
    allocator_frag_ratio:1.19
    allocator_frag_bytes:193064
    allocator_rss_ratio:3.10
    allocator_rss_bytes:2560000
    rss_overhead_ratio:0.77
    rss_overhead_bytes:-860160
    mem_fragmentation_ratio:3.60
    mem_fragmentation_bytes:2108224
    mem_not_counted_for_evict:0
    mem_replication_backlog:0
    mem_clients_slaves:0
    mem_clients_normal:49694
    mem_aof_buffer:0
    mem_allocator:jemalloc-5.1.0
    active_defrag_running:0
    lazyfree_pending_objects:0

    # Persistence
    loading:0
    rdb_changes_since_last_save:0
    rdb_bgsave_in_progress:0
    rdb_last_save_time:1667472108
    rdb_last_bgsave_status:ok
    rdb_last_bgsave_time_sec:-1
    rdb_current_bgsave_time_sec:-1
    rdb_last_cow_size:0
    aof_enabled:1
    aof_rewrite_in_progress:0
    aof_rewrite_scheduled:0
    aof_last_rewrite_time_sec:-1
    aof_current_rewrite_time_sec:-1
    aof_last_bgrewrite_status:ok
    aof_last_write_status:ok
    aof_last_cow_size:0
    aof_current_size:0
    aof_base_size:0
    aof_pending_rewrite:0
    aof_buffer_length:0
    aof_rewrite_buffer_length:0
    aof_pending_bio_fsync:0
    aof_delayed_fsync:0

    # Stats
    total_connections_received:2
    total_commands_processed:4
    instantaneous_ops_per_sec:0
    total_net_input_bytes:197
    total_net_output_bytes:3624
    instantaneous_input_kbps:0.00
    instantaneous_output_kbps:0.00
    rejected_connections:0
    sync_full:0
    sync_partial_ok:0
    sync_partial_err:0
    expired_keys:0
    expired_stale_perc:0.00
    expired_time_cap_reached_count:0
    evicted_keys:0
    keyspace_hits:0
    keyspace_misses:0
    pubsub_channels:0
    pubsub_patterns:0
    latest_fork_usec:0
    migrate_cached_sockets:0
    slave_expires_tracked_keys:0
    active_defrag_hits:0
    active_defrag_misses:0
    active_defrag_key_hits:0
    active_defrag_key_misses:0

    # Replication
    role:master
    connected_slaves:0
    master_replid:2122733a132fdb442c0ca49b643f77530b3f167c
    master_replid2:0000000000000000000000000000000000000000
    master_repl_offset:0
    second_repl_offset:-1
    repl_backlog_active:0
    repl_backlog_size:1048576
    repl_backlog_first_byte_offset:0
    repl_backlog_histlen:0

    # CPU
    used_cpu_sys:0.228286
    used_cpu_user:0.330661
    used_cpu_sys_children:0.000000
    used_cpu_user_children:0.000000

    # Cluster
    cluster_enabled:0

    # Keyspace
    127.0.0.1:6379>
    ```

