---
title     : 'MongoDB'
summary   : '采集 MongoDB 的指标数据'
__int_icon      : 'icon/mongodb'
dashboard :
  - desc  : 'Mongodb 监控视图'
    path  : 'dashboard/zh/mongodb'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# MongoDB
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

MongoDb 数据库，Collection， MongoDb 数据库集群运行状态数据采集。

## 配置 {#config}

### 前置条件 {#requirements}

- 已测试的版本：
    - [x] 6.0
    - [x] 5.0
    - [x] 4.0
    - [x] 3.0

- 开发使用 MongoDB 版本 `4.4.5`;
- 编写配置文件在对应目录下然后启动 DataKit 即可完成配置；
- 使用 TLS 进行安全连接请在配置文件中配置 `## TLS connection config` 下响应证书文件路径与配置；
- 如果 MongoDB 启动了访问控制那么需要配置必须的用户权限用于建立授权连接：

```sh
# Run MongoDB shell.
$ mongo

# Authenticate as the admin/root user.
> use admin
> db.auth("<admin OR root>", "<YOUR_MONGODB_ADMIN_PASSWORD>")

# Create the user for the Datakit.
> db.createUser({
  "user": "datakit",
  "pwd": "<YOUR_COLLECT_PASSWORD>",
  "roles": [
    { role: "read", db: "admin" },
    { role: "clusterMonitor", db: "admin" },
    { role: "backup", db: "admin" },
    { role: "read", db: "local" }
  ]
})
```

>更多权限说明可参见官方文档 [Built-In Roles](https://www.mongodb.com/docs/manual/reference/built-in-roles/){:target="_blank"}。

执行完上述命令后将创建的「用户名」和「密码」填入 Datakit 的配置文件 `conf.d/db/mongodb.conf` 中。

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/db` 目录，复制 `mongodb.conf.sample` 并命名为 `mongodb.conf`。示例如下：

    ```toml
        
    [[inputs.mongodb]]
      ## Gathering interval
      interval = "10s"
    
      ## A list of Mongodb servers URL
      ## Note: must escape special characters in password before connect to Mongodb server, otherwise parse will failed.
      ## Form: "mongodb://" [user ":" pass "@"] host [ ":" port]
      ## Some examples:
      ## mongodb://user:pswd@localhost:27017/?authMechanism=SCRAM-SHA-256&authSource=admin
      ## mongodb://user:pswd@127.0.0.1:27017,
      ## mongodb://10.10.3.33:18832,
      servers = ["mongodb://127.0.0.1:27017"]
    
      ## When true, collect replica set stats
      gather_replica_set_stats = false
    
      ## When true, collect cluster stats
      ## Note that the query that counts jumbo chunks triggers a COLLSCAN, which may have an impact on performance.
      gather_cluster_stats = false
    
      ## When true, collect per database stats
      gather_per_db_stats = true
    
      ## When true, collect per collection stats
      gather_per_col_stats = true
    
      ## List of db where collections stats are collected, If empty, all dbs are concerned.
      col_stats_dbs = []
    
      ## When true, collect top command stats.
      gather_top_stat = true
    
      ## Set true to enable election
      election = true
    
      ## TLS connection config
      # ca_certs = ["/etc/ssl/certs/mongod.cert.pem"]
      # cert = "/etc/ssl/certs/mongo.cert.pem"
      # cert_key = "/etc/ssl/certs/mongo.key.pem"
      # insecure_skip_verify = true
      # server_name = ""
    
      ## Mongodb log files and Grok Pipeline files configuration
      # [inputs.mongodb.log]
        # files = ["/var/log/mongodb/mongod.log"]
        # pipeline = "mongod.p"
    
      ## Customer tags, if set will be seen with every metric.
      # [inputs.mongodb.tags]
        # "key1" = "value1"
        # "key2" = "value2"
        # ...
    
    ```

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

### TLS config (self-signed) {#tls}

使用 `openssl` 生成证书文件用于 MongoDB TLS 配置，用于开启服务端加密和客户端认证。

- 配置 TLS 证书

安装 `openssl` 运行以下命令：

```shell
sudo apt install openssl -y
```

- 配置 MongoDB 服务端加密

使用 `openssl` 生成证书级密钥文件，运行以下命令并按照命令提示符输入相应验证块信息：

```shell
sudo openssl req -x509 -newkey rsa:<bits> -days <days> -keyout <mongod.key.pem> -out <mongod.cert.pem> -nodes
```

- `bits`: rsa 密钥位数，例如 2048
- `days`: expired 日期
- `mongod.key.pem`: 密钥文件
- `mongod.cert.pem`: CA 证书文件

运行上面的命令后生成 `cert.pem` 文件和 `key.pem` 文件，我们需要合并两个文件内的 `block` 运行以下命令：

```shell
sudo bash -c "cat mongod.cert.pem mongod.key.pem >>mongod.pem"
```

合并后配置 `/etc/mongod.config` 文件中的 TLS 子项

```yaml
# TLS config
net:
  tls:
    mode: requireTLS
    certificateKeyFile: </etc/ssl/mongod.pem>
```

使用配置文件启动 MongoDB 运行以下命令：

```shell
mongod --config /etc/mongod.conf
```

使用命令行启动 MongoDB 运行一下命令：

```shell
mongod --tlsMode requireTLS --tlsCertificateKeyFile </etc/ssl/mongod.pem> --dbpath <.db/mongodb>
```

复制 `mongod.cert.pem` 为 `mongo.cert.pem` 到 MongoDB 客户端并启用 TLS：

```shell
mongo --tls --host <mongod_url> --tlsCAFile </etc/ssl/mongo.cert.pem>
```

- 配置 MongoDB 客户端认证

使用 `openssl` 生成证书级密钥文件，运行以下命令：

```shell
sudo openssl req -x509 -newkey rsa:<bits> -days <days> -keyout <mongod.key.pem> -out <mongod.cert.pem> -nodes
```

- `bits`: rsa 密钥位数，例如 2048
- `days`: expired 日期
- `mongo.key.pem`: 密钥文件
- `mongo.cert.pem`: CA 证书文件

合并 `mongod.cert.pem` 和 `mongod.key.pem` 文件中的 block 运行以下命令：

```shell
sudo bash -c "cat mongod.cert.pem mongod.key.pem >>mongod.pem"
```

复制 `mongod.cert.pem` 文件到 MongoDB 服务端然后配置 `/etc/mongod.config` 文件中的 TLS 项：

```yaml
# Tls config
net:
  tls:
    mode: requireTLS
    certificateKeyFile: </etc/ssl/mongod.pem>
    CAFile: </etc/ssl/mongod.cert.pem>
```

启动 MongoDB 运行以下命令：

```shell
mongod --config /etc/mongod.conf
```

复制 `mongod.cert.pem` 为 `mongo.cert.pem` ，复制 `mongod.pem` 为 `mongo.pem` 到 MongoDB 客户端并启用 TLS：

```shell
mongo --tls --host <mongod_url> --tlsCAFile </etc/ssl/mongo.cert.pem> --tlsCertificateKeyFile </etc/ssl/mongo.pem>
```

> 注意：使用自签名证书时，`mongodb.conf` 配置中 `insecure_skip_verify` 必须是 `true`

## 指标 {#metric}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.mongodb.tags]` 指定其它标签：

```toml
 [inputs.mongodb.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `mongodb`

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|mongodb host|
|`mongod_host`|mongodb host with port|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active_reads`|The number of the active client connections performing read operations.|int|count|
|`active_writes`|The number of active client connections performing write operations.|int|count|
|`aggregate_command_failed`|The number of times that 'aggregate' command failed on this mongod|int|count|
|`aggregate_command_total`|The number of times that 'aggregate' command executed on this mongod.|int|count|
|`assert_msg`|The number of message assertions raised since the MongoDB process started. Check the log file for more information about these messages.|int|count|
|`assert_regular`|The number of regular assertions raised since the MongoDB process started. Check the log file for more information about these messages.|int|count|
|`assert_rollovers`|The number of times that the rollover counters have rolled over since the last time the MongoDB process started. The counters will rollover to zero after 2 30 assertions. Use this value to provide context to the other values in the asserts data structure.|int|count|
|`assert_user`|The number of "user asserts" that have occurred since the last time the MongoDB process started. These are errors that user may generate, such as out of disk space or duplicate key. You can prevent these assertions by fixing a problem with your application or deployment. Check the MongoDB log for more information.|int|count|
|`assert_warning`|Changed in version 4.0. Starting in MongoDB 4.0, the field returns zero 0. In earlier versions, the field returns the number of warnings raised since the MongoDB process started.|int|count|
|`available_reads`|The number of concurrent of read transactions allowed into the WiredTiger storage engine|int|count|
|`available_writes`|The number of concurrent of write transactions allowed into the WiredTiger storage engine|int|count|
|`commands`|The total number of commands issued to the database since the mongod instance last started. `opcounters.command` counts all commands except the write commands: insert, update, and delete.|int|count|
|`commands_per_sec`||int|count|
|`connections_available`|The number of unused incoming connections available.|int|count|
|`connections_current`|The number of incoming connections from clients to the database server .|int|count|
|`connections_total_created`|Count of all incoming connections created to the server. This number includes connections that have since closed.|int|count|
|`count_command_failed`|The number of times that 'count' command failed on this mongod|int|count|
|`count_command_total`|The number of times that 'count' command executed on this mongod|int|count|
|`cursor_no_timeout`||int|count|
|`cursor_no_timeout_count`|The number of open cursors with the option DBQuery.Option.noTimeout set to prevent timeout after a period of inactivity|int|count|
|`cursor_pinned`||int|count|
|`cursor_pinned_count`|The number of "pinned" open cursors.|int|count|
|`cursor_timed_out`||int|count|
|`cursor_timed_out_count`|The total number of cursors that have timed out since the server process started. If this number is large or growing at a regular rate, this may indicate an application error.|int|count|
|`cursor_total`||int|count|
|`cursor_total_count`|The number of cursors that MongoDB is maintaining for clients. Because MongoDB exhausts unused cursors, typically this value small or zero. However, if there is a queue, stale *tailable* cursors, or a large number of operations this value may rise.|int|count|
|`delete_command_failed`|The number of times that 'delete' command failed on this mongod|int|count|
|`delete_command_total`|The number of times that 'delete' command executed on this mongod|int|count|
|`deletes`|The total number of delete operations since the mongod instance last started.|int|count|
|`deletes_per_sec`||int|count|
|`distinct_command_failed`|The number of times that 'distinct' command failed on this mongod|int|count|
|`distinct_command_total`|The number of times that 'distinct' command executed on this mongod|int|count|
|`document_deleted`|The total number of documents deleted.|int|count|
|`document_inserted`|The total number of documents inserted.|int|count|
|`document_returned`|The total number of documents returned by queries.|int|count|
|`document_updated`|The total number of documents updated.|int|count|
|`find_and_modify_command_failed`|The number of times that 'find' and 'modify' commands failed on this mongod|int|count|
|`find_and_modify_command_total`|The number of times that 'find' and 'modify' commands executed on this mongod|int|count|
|`find_command_failed`|The number of times that 'find' command failed on this mongod|int|count|
|`find_command_total`|The number of times that 'find' command executed on this mongod|int|count|
|`flushes`|The number of transaction checkpoints|int|count|
|`flushes_per_sec`||int|count|
|`flushes_total_time_ns`|The transaction checkpoint total time (ms)"|int|count|
|`get_more_command_failed`|The number of times that 'get more' command failed on this mongod|int|count|
|`get_more_command_total`|The number of times that 'get more' command executed on this mongod|int|count|
|`getmores`|The total number of `getMore` operations since the mongod instance last started. This counter can be high even if the query count is low. Secondary nodes send `getMore` operations as part of the replication process.|int|count|
|`getmores_per_sec`||int|count|
|`insert_command_failed`|The number of times that 'insert' command failed on this mongod|int|count|
|`insert_command_total`|The number of times that 'insert' command executed on this mongod|int|count|
|`inserts`|The total number of insert operations received since the mongod instance last started.|int|count|
|`inserts_per_sec`||int|count|
|`jumbo_chunks`|Count jumbo flags in cluster chunk.|int|count|
|`mapped_megabytes`|Mapped megabytes. (Existed in 3.0 and earlier version)|int|count|
|`net_in_bytes`||int|count|
|`net_in_bytes_count`|The total number of bytes that the server has received over network connections initiated by clients or other mongod instances.|int|count|
|`net_out_bytes`||int|count|
|`net_out_bytes_count`|The total number of bytes that the server has sent over network connections initiated by clients or other mongod instances.|int|count|
|`non-mapped_megabytes`|Non mapped megabytes. (Existed in 3.0 and earlier version)|int|count|
|`open_connections`|The number of incoming connections from clients to the database server.|int|count|
|`operation_scan_and_order`|The total number of queries that return sorted numbers that cannot perform the sort operation using an index.|int|count|
|`operation_write_conflicts`|The total number of queries that encountered write conflicts.|int|count|
|`page_faults`|The total number of page faults.|int|count|
|`page_faults_per_sec`|Page Faults/sec is the average number of pages faulted per second. (Existed in 3.0 and earlier version)|int|count|
|`percent_cache_dirty`|Size in bytes of the dirty data in the cache. This value should be less than the bytes currently in the cache value.|float|count|
|`percent_cache_used`|Size in byte of the data currently in cache. This value should not be greater than the maximum bytes configured value.|float|count|
|`queries`|The total number of queries received since the mongod instance last started.|int|count|
|`queries_per_sec`||int|count|
|`queued_reads`|The number of operations that are currently queued and waiting for the read lock. A consistently small read-queue, particularly of shorter operations, should cause no concern.|int|count|
|`queued_writes`|The number of operations that are currently queued and waiting for the write lock. A consistently small write-queue, particularly of shorter operations, is no cause for concern.|int|count|
|`resident_megabytes`|The value of mem.resident is roughly equivalent to the amount of RAM, in MiB, currently used by the database process.|int|count|
|`storage_freelist_search_bucket_exhausted`|The number of times that mongod has checked the free list without finding a suitably large record allocation.|int|count|
|`storage_freelist_search_requests`|The number of times mongod has searched for available record allocations.|int|count|
|`storage_freelist_search_scanned`|The number of available record allocations mongod has searched.|int|count|
|`tcmalloc_central_cache_free_bytes`|Number of free bytes in the central cache that have been assigned to size classes. They always count towards virtual memory usage, and unless the underlying memory is swapped.|int|count|
|`tcmalloc_current_allocated_bytes`|Number of bytes currently allocated by application.|int|count|
|`tcmalloc_current_total_thread_cache_bytes`|Number of bytes used across all thread caches.|int|count|
|`tcmalloc_heap_size`|Number of bytes in the heap.|int|count|
|`tcmalloc_max_total_thread_cache_bytes`|Upper limit on total number of bytes stored across all per-thread caches. Default: 16MB.|int|count|
|`tcmalloc_pageheap_commit_count`|Number of virtual memory commits.|int|count|
|`tcmalloc_pageheap_committed_bytes`|Bytes committed, always <= system_bytes_.|int|count|
|`tcmalloc_pageheap_decommit_count`|Number of virtual memory de-commits.|int|count|
|`tcmalloc_pageheap_free_bytes`|Number of bytes in free, mapped pages in page heap.|int|count|
|`tcmalloc_pageheap_reserve_count`|Number of virtual memory reserves.|int|count|
|`tcmalloc_pageheap_scavenge_count`|Number of times scavaged flush pages.|int|count|
|`tcmalloc_pageheap_total_commit_bytes`|Bytes committed in lifetime of process.|int|count|
|`tcmalloc_pageheap_total_decommit_bytes`|Bytes de-committed in lifetime of process.|int|count|
|`tcmalloc_pageheap_total_reserve_bytes`|Number of virtual memory reserves.|int|count|
|`tcmalloc_pageheap_unmapped_bytes`|Total bytes on returned free lists.|int|count|
|`tcmalloc_spinlock_total_delay_ns`|TODO|int|count|
|`tcmalloc_thread_cache_free_bytes`|Bytes in thread caches.|int|count|
|`tcmalloc_total_free_bytes`|Total bytes on normal free lists.|int|count|
|`tcmalloc_transfer_cache_free_bytes`|Bytes in central transfer cache.|int|count|
|`total_available`|The number of connections available from the mongos to the config servers, replica sets, and standalone mongod instances in the cluster.|int|count|
|`total_created`|The number of connections the mongos has ever created to other members of the cluster.|int|count|
|`total_docs_scanned`|The total number of index items scanned during queries and query-plan evaluation.|int|count|
|`total_in_use`|Reports the total number of outgoing connections from the current mongod/mongos instance to other members of the sharded cluster or replica set that are currently in use.|int|count|
|`total_keys_scanned`|The total number of index items scanned during queries and query-plan evaluation.|int|count|
|`total_refreshing`|Reports the total number of outgoing connections from the current mongod/mongos instance to other members of the sharded cluster or replica set that are currently being refreshed.|int|count|
|`total_tickets_reads`|A document that returns information on the number of concurrent of read transactions allowed into the WiredTiger storage engine.|int|count|
|`total_tickets_writes`|A document that returns information on the number of concurrent of write transactions allowed into the WiredTiger storage engine.|int|count|
|`ttl_deletes`|The total number of documents deleted from collections with a ttl index.|int|count|
|`ttl_deletes_per_sec`||int|count|
|`ttl_passes`|The number of times the background process removes documents from collections with a ttl index.|int|count|
|`ttl_passes_per_sec`||int|count|
|`update_command_failed`|The number of times that 'update' command failed on this mongod|int|count|
|`update_command_total`|The number of times that 'update' command executed on this mongod|int|count|
|`updates`|The total number of update operations received since the mongod instance last started.|int|count|
|`updates_per_sec`||int|count|
|`uptime_ns`|The total upon time of mongod in nano seconds.|int|count|
|`vsize_megabytes`|mem.virtual displays the quantity, in MiB, of virtual memory used by the mongod process.|int|count|
|`wtcache_app_threads_page_read_count`|TODO|int|count|
|`wtcache_app_threads_page_read_time`|TODO|int|count|
|`wtcache_app_threads_page_write_count`|TODO|int|count|
|`wtcache_bytes_read_into`|TODO|int|count|
|`wtcache_bytes_written_from`|TODO|int|count|
|`wtcache_current_bytes`|TODO|int|count|
|`wtcache_internal_pages_evicted`|TODO|int|count|
|`wtcache_max_bytes_configured`|Maximum cache size.|int|count|
|`wtcache_modified_pages_evicted`|TODO|int|count|
|`wtcache_pages_evicted_by_app_thread`|TODO|int|count|
|`wtcache_pages_queued_for_eviction`|TODO|int|count|
|`wtcache_pages_read_into`|Number of pages read into the cache.|int|count|
|`wtcache_pages_requested_from`|Number of pages request from the cache.|int|count|
|`wtcache_pages_written_from`|Pages written from cache|int|count|
|`wtcache_server_evicting_pages`|TODO|int|count|
|`wtcache_tracked_dirty_bytes`|TODO|int|count|
|`wtcache_unmodified_pages_evicted`|Main statistics for page eviction.|int|count|
|`wtcache_worker_thread_evictingpages`|TODO|int|count|



### `mongodb_db_stats`

- 标签


| Tag | Description |
|  ----  | --------|
|`db_name`|database name|
|`host`|mongodb host|
|`mongod_host`|mongodb host with port|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`avg_obj_size`|The average size of each document in bytes.|float|count|
|`collections`|Contains a count of the number of collections in that database.|int|count|
|`data_size`|The total size of the uncompressed data held in this database. The dataSize decreases when you remove documents.|int|count|
|`index_size`|The total size of all indexes created on this database.|int|count|
|`indexes`|Contains a count of the total number of indexes across all collections in the database.|int|count|
|`mapped_megabytes`|Mapped megabytes. (Existed in 3.0 and earlier version)|int|count|
|`non-mapped_megabytes`|Non mapped megabytes. (Existed in 3.0 and earlier version)|int|count|
|`objects`|Contains a count of the number of objects (i.e. documents) in the database across all collections.|int|count|
|`ok`|Command execute state.|int|count|
|`page_faults_per_sec`|Page Faults/sec is the average number of pages faulted per second. (Existed in 3.0 and earlier version)|int|count|
|`percent_cache_dirty`|Size in bytes of the dirty data in the cache. This value should be less than the bytes currently in the cache value. (Existed in 3.0 and earlier version)|int|count|
|`percent_cache_used`|Size in byte of the data currently in cache. This value should not be greater than the maximum bytes configured value. (Existed in 3.0 and earlier version)|int|count|
|`storage_size`|The total amount of space allocated to collections in this database for document storage.|int|count|
|`wtcache_app_threads_page_read_count`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_app_threads_page_read_time`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_app_threads_page_write_count`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_bytes_read_into`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_bytes_written_from`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_current_bytes`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_internal_pages_evicted`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_max_bytes_configured`|Maximum cache size. (Existed in 3.0 and earlier version)|int|count|
|`wtcache_modified_pages_evicted`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_pages_evicted_by_app_thread`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_pages_queued_for_eviction`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_pages_read_into`|Number of pages read into the cache. (Existed in 3.0 and earlier version)|int|count|
|`wtcache_pages_requested_from`|Number of pages request from the cache. (Existed in 3.0 and earlier version)|int|count|
|`wtcache_pages_written_from`|Pages written from cache. (Existed in 3.0 and earlier version)|int|count|
|`wtcache_server_evicting_pages`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_tracked_dirty_bytes`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_unmodified_pages_evicted`|Main statistics for page eviction. (Existed in 3.0 and earlier version)|int|count|
|`wtcache_worker_thread_evictingpages`|(Existed in 3.0 and earlier version)|int|count|



### `mongodb_col_stats`

- 标签


| Tag | Description |
|  ----  | --------|
|`collection`|collection name|
|`db_name`|database name|
|`host`|mongodb host|
|`mongod_host`|mongodb host with port|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`avg_obj_size`|The average size of an object in the collection. |float|count|
|`count`|The number of objects or documents in this collection.|int|count|
|`mapped_megabytes`|Mapped megabytes. (Existed in 3.0 and earlier version)|int|count|
|`non-mapped_megabytes`|Non mapped megabytes. (Existed in 3.0 and earlier version)|int|count|
|`ok`|Command execute state.|int|count|
|`page_faults_per_sec`|Page Faults/sec is the average number of pages faulted per second. (Existed in 3.0 and earlier version)|int|count|
|`percent_cache_dirty`|Size in bytes of the dirty data in the cache. This value should be less than the bytes currently in the cache value. (Existed in 3.0 and earlier version)|int|count|
|`percent_cache_used`|Size in byte of the data currently in cache. This value should not be greater than the maximum bytes configured value. (Existed in 3.0 and earlier version)|int|count|
|`size`|The total uncompressed size in memory of all records in a collection.|int|count|
|`storage_size`|The total amount of storage allocated to this collection for document storage.|int|count|
|`total_index_size`|The total size of all indexes.|int|count|
|`wtcache_app_threads_page_read_count`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_app_threads_page_read_time`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_app_threads_page_write_count`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_bytes_read_into`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_bytes_written_from`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_current_bytes`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_internal_pages_evicted`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_max_bytes_configured`|Maximum cache size. (Existed in 3.0 and earlier version)|int|count|
|`wtcache_modified_pages_evicted`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_pages_evicted_by_app_thread`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_pages_queued_for_eviction`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_pages_read_into`|Number of pages read into the cache. (Existed in 3.0 and earlier version)|int|count|
|`wtcache_pages_requested_from`|Number of pages request from the cache. (Existed in 3.0 and earlier version)|int|count|
|`wtcache_pages_written_from`|Pages written from cache. (Existed in 3.0 and earlier version)|int|count|
|`wtcache_server_evicting_pages`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_tracked_dirty_bytes`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_unmodified_pages_evicted`|Main statistics for page eviction. (Existed in 3.0 and earlier version)|int|count|
|`wtcache_worker_thread_evictingpages`|(Existed in 3.0 and earlier version)|int|count|



### `mongodb_shard_stats`

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|mongodb host|
|`mongod_host`|mongodb host with port|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`available`|The number of connections available for this host to connect to the mongos.|int|count|
|`created`|The number of connections the host has ever created to connect to the mongos.|int|count|
|`in_use`|Reports the total number of outgoing connections from the current mongod/mongos instance to other members of the sharded cluster or replica set that are currently in use.|int|count|
|`refreshing`|Reports the total number of outgoing connections from the current mongod/mongos instance to other members of the sharded cluster or replica set that are currently being refreshed.|int|count|



### `mongodb_top_stats`

- 标签


| Tag | Description |
|  ----  | --------|
|`collection`|collection name|
|`host`|mongodb host|
|`mongod_host`|mongodb host with port|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`commands_count`|The total number of "command" event issues.|int|count|
|`commands_time`|The amount of time in microseconds that "command" costs.|int|count|
|`get_more_count`|The total number of `getmore` event issues.|int|count|
|`get_more_time`|The amount of time in microseconds that `getmore` costs.|int|count|
|`insert_count`|The total number of "insert" event issues.|int|count|
|`insert_time`|The amount of time in microseconds that "insert" costs.|int|count|
|`mapped_megabytes`|Mapped megabytes. (Existed in 3.0 and earlier version)|int|count|
|`non-mapped_megabytes`|Non mapped megabytes. (Existed in 3.0 and earlier version)|int|count|
|`page_faults_per_sec`|Page Faults/sec is the average number of pages faulted per second. (Existed in 3.0 and earlier version)|int|count|
|`percent_cache_dirty`|Size in bytes of the dirty data in the cache. This value should be less than the bytes currently in the cache value. (Existed in 3.0 and earlier version)|int|count|
|`percent_cache_used`|Size in byte of the data currently in cache. This value should not be greater than the maximum bytes configured value. (Existed in 3.0 and earlier version)|int|count|
|`queries_count`|The total number of "queries" event issues.|int|count|
|`queries_time`|The amount of time in microseconds that "queries" costs.|int|count|
|`read_lock_count`|The total number of "readLock" event issues.|int|count|
|`read_lock_time`|The amount of time in microseconds that "readLock" costs.|int|count|
|`remove_count`|The total number of "remove" event issues.|int|count|
|`remove_time`|The amount of time in microseconds that "remove" costs.|int|count|
|`total_count`|The total number of "total" event issues.|int|count|
|`total_time`|The amount of time in microseconds that "total" costs.|int|count|
|`update_count`|The total number of "update" event issues.|int|count|
|`update_time`|The amount of time in microseconds that "update" costs.|int|count|
|`write_lock_count`|The total number of "writeLock" event issues.|int|count|
|`write_lock_time`|The amount of time in microseconds that "writeLock" costs.|int|count|
|`wtcache_app_threads_page_read_count`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_app_threads_page_read_time`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_app_threads_page_write_count`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_bytes_read_into`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_bytes_written_from`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_current_bytes`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_internal_pages_evicted`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_max_bytes_configured`|Maximum cache size. (Existed in 3.0 and earlier version)|int|count|
|`wtcache_modified_pages_evicted`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_pages_evicted_by_app_thread`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_pages_queued_for_eviction`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_pages_read_into`|Number of pages read into the cache. (Existed in 3.0 and earlier version)|int|count|
|`wtcache_pages_requested_from`|Number of pages request from the cache. (Existed in 3.0 and earlier version)|int|count|
|`wtcache_pages_written_from`|Pages written from cache. (Existed in 3.0 and earlier version)|int|count|
|`wtcache_server_evicting_pages`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_tracked_dirty_bytes`|(Existed in 3.0 and earlier version)|int|count|
|`wtcache_unmodified_pages_evicted`|Main statistics for page eviction. (Existed in 3.0 and earlier version)|int|count|
|`wtcache_worker_thread_evictingpages`|(Existed in 3.0 and earlier version)|int|count|



## 日志采集 {#logging}

去注释配置文件中 `# enable_mongod_log = false` 然后将 `false` 改为 `true`，其他关于 mongod log 配置选项在 `[inputs.mongodb.log]` 中，注释掉的配置极为默认配置，如果路径对应正确将无需任何配置启动 Datakit 后将会看到指标名为 `mongod_log` 的采集指标集。

日志原始数据 sample

```log
{"t":{"$date":"2021-06-03T09:12:19.977+00:00"},"s":"I",  "c":"STORAGE",  "id":22430,   "ctx":"WTCheckpointThread","msg":"WiredTiger message","attr":{"message":"[1622711539:977142][1:0x7f1b9f159700], WT_SESSION.checkpoint: [WT_VERB_CHECKPOINT_PROGRESS] saving checkpoint snapshot min: 653, snapshot max: 653 snapshot count: 0, oldest timestamp: (0, 0) , meta checkpoint timestamp: (0, 0)"}}
```

日志切割字段

| 字段名    | 字段值                        | 说明                                                           |
| --------- | ----------------------------- | -------------------------------------------------------------- |
| message   |                               | Log raw data                                                   |
| component | STORAGE                       | The full component string of the log message                   |
| context   | WTCheckpointThread            | The name of the thread issuing the log statement               |
| msg       | WiredTiger message            | The raw log output message as passed from the server or driver |
| status    | I                             | The short severity code of the log message                     |
| time      | 2021-06-03T09:12:19.977+00:00 | Timestamp                                                      |
