---
title     : 'MongoDB'
summary   : 'Collect MongoDB Metrics data'
tags:
  - 'DATABASE'
__int_icon      : 'icon/mongodb'
dashboard :
  - desc  : 'MongoDB Monitoring View'
    path  : 'dashboard/en/mongodb'
monitor   :
  - desc  : 'MongoDB Monitor'
    path  : 'monitor/en/mongodb'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

MongoDB DATABASE, Collection, MongoDB DATABASE cluster running status data collection.

## Configuration {#config}

### Prerequisites {#requirements}

- Tested versions:
    - [x] 6.0
    - [x] 5.0
    - [x] 4.0
    - [x] 3.0
    - [x] 2.8.0

- Development uses MongoDB version `4.4.5`;
- Write the configuration file in the corresponding directory and start DataKit to complete the configuration;
- Use TLS for secure connections by configuring the paths of the certificate files under `## TLS connection config` in the configuration file;
- If MongoDB starts with access control, configure the necessary user permissions to establish an authorized connection:

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

> For more permission details, refer to the official documentation [Built-In Roles](https://www.mongodb.com/docs/manual/reference/built-in-roles/){:target="_blank"}.

After executing the above commands, fill in the created "username" and "password" into the Datakit configuration file `conf.d/db/mongodb.conf`.

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "HOST Installation"

    Enter the `conf.d/db` directory under the DataKit installation directory, copy `mongodb.conf.sample`, and rename it to `mongodb.conf`. Example:

    ```toml
        
    [[inputs.mongodb]]
      ## Gathering interval
      interval = "10s"
    
      ## Specify one single Mongodb server. These server related fields will be ignored when the 'servers' field is not empty.
      ## connection_format is a string in the standard connection format (mongodb://) or SRV connection format (mongodb+srv://).
      connection_format = "mongodb://"
    
      ## The host and port. 
      host_port = "127.0.0.1:27017"
    
      ## Username
      username = "datakit"
    
      ## Password
      password = "<PASS>"
    
      ## The authentication database to use.
      # default_db = "admin"
    
      ## A query string that specifies connection specific options as <name>=<value> pairs.
      # query_string = "authSource=admin&authMechanism=SCRAM-SHA-256"
    
      ## A list of Mongodb servers URL
      ## Note: must escape special characters in password before connect to Mongodb server, otherwise parse will failed.
      ## Form: "mongodb://[user ":" pass "@"] host [ ":" port]"
      ## Some examples:
      ## mongodb://user:pswd@localhost:27017/?authMechanism=SCRAM-SHA-256&authSource=admin
      ## mongodb://user:pswd@127.0.0.1:27017,
      ## mongodb://10.10.3.33:18832,
      # servers = ["mongodb://127.0.0.1:27017"]
    
      ## When true, collect replica set stats
      gather_replica_set_stats = false
    
      ## When true, collect cluster stats
      ## Note that the query that counts jumbo chunks triggers a COLLSCAN, which may have an impact on performance.
      gather_cluster_stats = false
    
      ## When true, collect per DATABASE stats
      gather_per_db_stats = true
    
      ## When true, collect per collection stats
      gather_per_col_stats = true
    
      ## List of dbs where collections stats are collected, If empty, all dbs are concerned.
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

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector through [ConfigMap injection](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

### TLS Configuration (self-signed) {#tls}

Use `openssl` to generate certificate files for MongoDB TLS configuration, enabling server-side encryption and client authentication.

- Configure TLS certificates

Install `openssl` and run the following command:

```shell
sudo apt install openssl -y
```

- Configure MongoDB server-side encryption

Use `openssl` to generate certificate-level key files, run the following command and input the corresponding verification block information as prompted:

```shell
sudo openssl req -x509 -newkey rsa:<bits> -days <days> -keyout <mongod.key.pem> -out <mongod.cert.pem> -nodes
```

- `bits`: RSA key bit size, for example 2048
- `days`: Expiration date
- `mongod.key.pem`: Key file
- `mongod.cert.pem`: CA certificate file

After running the above command, merge the `block` from both generated files by running the following command:

```shell
sudo bash -c "cat mongod.cert.pem mongod.key.pem >>mongod.pem"
```

After merging, configure the TLS sub-item in the `/etc/mongod.config` file

```yaml
# TLS config
net:
  tls:
    mode: requireTLS
    certificateKeyFile: </etc/ssl/mongod.pem>
```

Start MongoDB using the configuration file by running the following command:

```shell
mongod --config /etc/mongod.conf
```

Start MongoDB via the command line by running the following command:

```shell
mongod --tlsMode requireTLS --tlsCertificateKeyFile </etc/ssl/mongod.pem> --dbpath <.db/mongodb>
```

Copy `mongod.cert.pem` as `mongo.cert.pem` to the MongoDB client and enable TLS:

```shell
mongo --tls --host <mongod_url> --tlsCAFile </etc/ssl/mongo.cert.pem>
```

- Configure MongoDB client authentication

Use `openssl` to generate certificate-level key files, run the following command:

```shell
sudo openssl req -x509 -newkey rsa:<bits> -days <days> -keyout <mongod.key.pem> -out <mongod.cert.pem> -nodes
```

- `bits`: RSA key bit size, for example 2048
- `days`: Expiration date
- `mongo.key.pem`: Key file
- `mongo.cert.pem`: CA certificate file

Merge `mongod.cert.pem` and `mongod.key.pem` files by running the following command:

```shell
sudo bash -c "cat mongod.cert.pem mongod.key.pem >>mongod.pem"
```

Copy the `mongod.cert.pem` file to the MongoDB server and configure the TLS item in the `/etc/mongod.config` file:

```yaml
# Tls config
net:
  tls:
    mode: requireTLS
    certificateKeyFile: </etc/ssl/mongod.pem>
    CAFile: </etc/ssl/mongod.cert.pem>
```

Start MongoDB by running the following command:

```shell
mongod --config /etc/mongod.conf
```

Copy `mongod.cert.pem` as `mongo.cert.pem`, copy `mongod.pem` as `mongo.pem` to the MongoDB client and enable TLS:

```shell
mongo --tls --host <mongod_url> --tlsCAFile </etc/ssl/mongo.cert.pem> --tlsCertificateKeyFile </etc/ssl/mongo.pem>
```

> Note: When using self-signed certificates, `insecure_skip_verify` in the `mongodb.conf` configuration must be `true`.

## Metrics {#metric}

All data collection below will append global election tag by default. You can also specify other tags via `[inputs.mongodb.tags]` in the configuration:

```toml
 [inputs.mongodb.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `mongodb`

- Description

MongoDB measurement. Some metrics may not appear depending on the MongoDB version or DB running status.

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|mongodb host|
|`mongod_host`|mongodb host with port|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active_reads`|The number of active client connections performing read operations.|int|count|
|`active_writes`|The number of active client connections performing write operations.|int|count|
|`aggregate_command_failed`|The number of times that 'aggregate' command failed on this mongod|int|count|
|`aggregate_command_total`|The number of times that 'aggregate' command executed on this mongod.|int|count|
|`assert_msg`|The number of message assertions raised since the MongoDB process started. Check the log file for more information about these messages.|int|count|
|`assert_regular`|The number of regular assertions raised since the MongoDB process started. Check the log file for more information about these messages.|int|count|
|`assert_rollovers`|The number of times that the rollover counters have rolled over since the last time the MongoDB process started. The counters will rollover to zero after 2 30 assertions. Use this value to provide context to the other values in the asserts data structure.|int|count|
|`assert_user`|The number of "user asserts" that have occurred since the last time the MongoDB process started. These are errors that users may generate, such as out of disk space or duplicate key. You can prevent these assertions by fixing a problem with your application or deployment. Check the MongoDB log for more information.|int|count|
|`assert_warning`|Changed in version 4.0. Starting in MongoDB 4.0, the field returns zero 0. In earlier versions, the field returns the number of warnings raised since the MongoDB process started.|int|count|
|`available_reads`|The number of concurrent read transactions allowed into the WiredTiger storage engine|int|count|
|`available_writes`|The number of concurrent write transactions allowed into the WiredTiger storage engine|int|count|
|`commands`|The total number of commands issued to the database since the mongod instance last started. `opcounters.command` counts all commands except the write commands: insert, update, and delete.|int|count|
|`commands_per_sec`|Deprecated, use commands.|int|count|
|`connections_available`|The number of unused incoming connections available.|int|count|
|`connections_current`|The number of incoming connections from clients to the database server .|int|count|
|`connections_total_created`|Count of all incoming connections created to the server. This number includes connections that have since closed.|int|count|
|`count_command_failed`|The number of times that 'count' command failed on this mongod|int|count|
|`count_command_total`|The number of times that 'count' command executed on this mongod|int|count|
|`cursor_no_timeout`|Deprecated, use cursor_no_timeout_count.|int|count|
|`cursor_no_timeout_count`|The number of open cursors with the option DBQuery.Option.noTimeout set to prevent timeout after a period of inactivity|int|count|
|`cursor_pinned`|Deprecated, use cursor_pinned_count.|int|count|
|`cursor_pinned_count`|The number of "pinned" open cursors.|int|count|
|`cursor_timed_out`|Deprecated, use cursor_timed_out_count.|int|count|
|`cursor_timed_out_count`|The total number of cursors that have timed out since the server process started. If this number is large or growing at a regular rate, this may indicate an application error.|int|count|
|`cursor_total`|Deprecated, use cursor_total_count.|int|count|
|`cursor_total_count`|The number of cursors that MongoDB is maintaining for clients. Because MongoDB exhausts unused cursors, typically this value small or zero. However, if there is a queue, stale *tailable* cursors, or a large number of operations this value may rise.|int|count|
|`delete_command_failed`|The number of times that 'delete' command failed on this mongod|int|count|
|`delete_command_total`|The number of times that 'delete' command executed on this mongod|int|count|
|`deletes`|The total number of delete operations since the mongod instance last started.|int|count|
|`deletes_per_sec`|Deprecated, use deletes.|int|count|
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
|`flushes_per_sec`|Deprecated, use flushes.|int|count|
|`flushes_total_time_ns`|The transaction checkpoint total time (ms)"|int|count|
|`get_more_command_failed`|The number of times that 'get more' command failed on this mongod|int|count|
|`get_more_command_total`|The number of times that 'get more' command executed on this mongod|int|count|
|`getmores`|The total number of `getMore` operations since the mongod instance last started. This counter can be high even if the query count is low. Secondary nodes send `getMore` operations as part of the replication process.|int|count|
|`getmores_per_sec`|Deprecated, use getmores|int|count|
|`insert_command_failed`|The number of times that 'insert' command failed on this mongod|int|count|
|`insert_command_total`|The number of times that 'insert' command executed on this mongod|int|count|
|`inserts`|The total number of insert operations received since the mongod instance last started.|int|count|
|`inserts_per_sec`|Deprecated, use inserts.|int|count|
|`jumbo_chunks`|Count jumbo flags in cluster chunk.|int|count|
|`mapped_megabytes`|Mapped megabytes. (Existed in 3.0 and earlier version)|int|count|
|`net_in_bytes`|Deprecated, use net_out_bytes_count.|int|count|
|`net_in_bytes_count`|The total number of bytes that the server has received over network connections initiated by clients or other mongod instances.|int|count|
|`net_out_bytes`|Deprecated, use net_out_bytes_count.|int|count|
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
|`queries_per_sec`|Deprecated, use queries.|int|count|
|`queued_reads`|The number of operations that are currently queued and waiting for the read lock. A consistently small read-queue, particularly of shorter operations, should cause no concern.|int|count|
|`queued_writes`|The number of operations that are currently queued and waiting for the write lock. A consistently small write-queue, particularly of shorter operations, is no cause for concern.|int|count|
|`repl_apply_batches_num`|The total number of batches applied across all DATABASEs.|int|count|
|`repl_apply_batches_total_millis`|The total amount of time in milliseconds the mongod has spent applying operations from the oplog.|int|count|
|`repl_apply_ops`|The total number of oplog operations applied. metrics.repl.apply.ops is incremented after each operation.|int|count|
|`repl_buffer_count`|The current number of operations in the oplog buffer.|int|count|
|`repl_buffer_size_bytes`|The current size of the contents of the oplog buffer.|int|count|
|`repl_commands`|The total number of replicated commands issued to the DATABASE since the mongod instance last started.|int|count|
|`repl_commands_per_sec`|Deprecated, use repl_commands.|int|count|
|`repl_deletes`|The total number of replicated delete operations since the mongod instance last started.|int|count|
|`repl_deletes_per_sec`|Deprecated, use repl_deletes.|int|count|
|`repl_executor_pool_in_progress_count`|The number of replication tasks that are currently being executed by the executor pool.|int|count|
|`repl_executor_queues_network_in_progress`|The number of network-related replication tasks that are currently being processed by the executor queues.|int|count|
|`repl_executor_queues_sleepers`|The number of replication tasks in the executor queues that are currently in a sleeping state.|int|count|
|`repl_executor_unsignaled_events`|The number of events related to the replication executor that have not yet been signaled.|int|count|
|`repl_getmores`|The total number of replicated getmore operations since the mongod instance last started.|int|count|
|`repl_getmores_per_sec`|Deprecated, use repl_getmores.|int|count|
|`repl_inserts`|The total number of replicated insert operations since the mongod instance last started.|int|count|
|`repl_inserts_per_sec`|Deprecated, use repl_inserts.|int|count|
|`repl_lag`|Delay between a write operation on the primary and its copy to a secondary.|int|count|
|`repl_network_bytes`|The total amount of data read from the replication sync source.|int|count|
|`repl_network_getmores_num`|The total number of getmore operations, which are operations that request an additional set of operations from the replication sync source.|int|count|
|`repl_network_getmores_total_millis`|The total amount of time required to collect data from getmore operations.|int|count|
|`repl_network_ops`|The total number of operations read from the replication source.|int|count|
|`repl_queries`|The total number of replicated queries since the mongod instance last started.|int|count|
|`repl_queries_per_sec`|Deprecated, use repl_queries.|int|count|
|`repl_state`|The node state of replication member.|int|count|
|`repl_updates`|The total number of replicated update operations since the mongod instance last started.|int|count|
|`repl_updates_per_sec`|Deprecated, use repl_updates.|int|count|
|`resident_megabytes`|The value of mem.resident is roughly equivalent to the amount of RAM, in MiB, currently used by the DATABASE process.|int|count|
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
|`tcmalloc_spinlock_total_delay_ns`|The total time (in nanoseconds) threads have been delayed while waiting for spinlocks in TCMalloc.|int|count|
|`tcmalloc_thread_cache_free_bytes`|Bytes in thread caches.|int|count|
|`tcmalloc_total_free_bytes`|Total bytes on normal free lists.|int|count|
|`tcmalloc_transfer_cache_free_bytes`|Bytes in central transfer cache.|int|count|
|`total_available`|The number of connections available from the mongos to the config servers, replica sets, and standalone mongod instances in the cluster.|int|count|
|`total_created`|The number of connections the mongos has ever created to other members of the cluster.|int|count|
|`total_docs_scanned`|The total number of index items scanned during queries and query-plan evaluation.|int|count|
|`total_in_use`|Reports the total number of outgoing connections from the current mongod/mongos instance to other members of the sharded cluster or replica set that are currently in use.|int|count|
|`total_keys_scanned`|The total number of index items scanned during queries and query-plan evaluation.|int|count|
|`total_refreshing`|Reports the total number of outgoing connections from the current mongod/mongos instance to other members of the sharded cluster or replica set that are currently being refreshed.|int|count|
|`total_tickets_reads`|A document that returns information on the number of concurrent read transactions allowed into the WiredTiger storage engine.|int|count|
|`total_tickets_writes`|A document that returns information on the number of concurrent write transactions allowed into the WiredTiger storage engine.|int|count|
|`ttl_deletes`|The total number of documents deleted from collections with a ttl index.|int|count|
|`ttl_deletes_per_sec`|Deprecated, use ttl_deletes.|int|count|
|`ttl_passes`|The number of times the background process removes documents from collections with a ttl index.|int|count|
|`ttl_passes_per_sec`|Deprecated, use ttl_passes.|int|count|
|`update_command_failed`|The number of times that 'update' command failed on this mongod|int|count|
|`update_command_total`|The number of times that 'update' command executed on this mongod|int|count|
|`updates`|The total number of update operations received since the mongod instance last started.|int|count|
|`updates_per_sec`|Deprecated, use updates.|int|count|
|`uptime_ns`|The total upon time of mongod in nano seconds.|int|count|
|`vsize_megabytes`|mem.virtual displays the quantity, in MiB, of virtual memory used by the mongod process.|int|count|
|`wtcache_app_threads_page_read_count`|The number of pages read by application threads from the WiredTiger cache.|int|count|
|`wtcache_app_threads_page_read_time`|The total time application threads spend reading pages from the WiredTiger cache.|int|count|
|`wtcache_app_threads_page_write_count`|The number of pages written by application threads to the WiredTiger cache.|int|count|
|`wtcache_bytes_read_into`|The total number of bytes read into the WiredTiger cache.|int|count|
|`wtcache_bytes_written_from`|The total number of bytes written from the WiredTiger cache.|int|count|
|`wtcache_current_bytes`|The current number of bytes being used in the WiredTiger cache.|int|count|
|`wtcache_internal_pages_evicted`|The number of internal pages evicted from the WiredTiger cache.|int|count|
|`wtcache_max_bytes_configured`|Maximum cache size.|int|count|
|`wtcache_modified_pages_evicted`|The number of modified pages evicted from the WiredTiger cache.|int|count|
|`wtcache_pages_evicted_by_app_thread`|The number of pages evicted from the WiredTiger cache by application threads.|int|count|
|`wtcache_pages_queued_for_eviction`|The current number of pages in the WiredTiger cache that are queued for eviction.|int|count|
|`wtcache_pages_read_into`|Number of pages read into the cache.|int|count|
|`wtcache_pages_requested_from`|Number of pages request from the cache.|int|count|
|`wtcache_pages_written_from`|Pages written from cache|int|count|
|`wtcache_server_evicting_pages`|The current number of pages in the WiredTiger cache that are being evicted by the server.|int|count|
|`wtcache_tracked_dirty_bytes`|The total number of bytes in the WiredTiger cache that are tracked as dirty.|int|count|
|`wtcache_unmodified_pages_evicted`|Main statistics for page eviction.|int|count|
|`wtcache_worker_thread_evictingpages`|The number of pages being evicted from the WiredTiger cache by worker threads.|int|count|






### `mongodb_db_stats`

- Description

MongoDB stats measurement. Some metrics may not appear depending on the MongoDB version or DB running status.

- Tags


| Tag | Description |
|  ----  | --------|
|`db_name`|DATABASE name|
|`host`|mongodb host|
|`mongod_host`|mongodb host with port|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`avg_obj_size`|The average size of each document in bytes.|float|count|
|`collections`|Contains a count of the number of collections in that DATABASE.|int|count|
|`data_size`|The total size of the uncompressed data held in this DATABASE. The dataSize decreases when you remove documents.|int|count|
|`index_size`|The total size of all indexes created on this DATABASE.|int|count|
|`indexes`|Contains a count of the total number of indexes across all collections in the DATABASE.|int|count|
|`mapped_megabytes`|Mapped megabytes. (Existed in 3.0 and earlier version)|int|count|
|`non-mapped_megabytes`|Non mapped megabytes. (Existed in 3.0 and earlier version)|int|count|
|`objects`|Contains a count of the number of objects (i.e. documents) in the DATABASE across all collections.|int|count|
|`ok`|Command execute state.|int|count|
|`page_faults_per_sec`|Page Faults/sec is the average number of pages faulted per second. (Existed in 3.0 and earlier version)|int|count|
|`percent_cache_dirty`|Size in bytes of the dirty data in the cache. This value should be less than the bytes currently in the cache value. (Existed in 3.0 and earlier version)|int|count|
|`percent_cache_used`|Size in byte of the data currently in cache. This value should not be greater than the maximum bytes configured value. (Existed in 3.0 and earlier version)|int|count|
|`storage_size`|The total amount of space allocated to collections in this DATABASE for document storage.|int|count|
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

- Description

MongoDB collection measurement. Some metrics may not appear depending on the MongoDB version or DB running status.

- Tags


| Tag | Description |
|  ----  | --------|
|`collection`|collection name|
|`db_name`|DATABASE name|
|`host`|mongodb host|
|`mongod_host`|mongodb host with port|

- Metrics List


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



## Custom Objects {#object}





### `DATABASE`



- Tags


| Tag | Description |
|  ----  | --------|
|`col_co_status`|Current status of collector on Mongodb(`OK/NotOK`)|
|`host`|The server host address|
|`ip`|Connection IP of the Mongodb|
|`name`|Object uniq ID|
|`reason`|If status not ok, we'll get some reasons about the status|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`display_name`|Displayed name in UI|string|-|
|`uptime`|Current Mongodb uptime|int|s|
|`version`|Current version of Mongodb|string|-|




## Log Collection {#logging}

Uncomment `# enable_mongod_log = false` in the configuration file and change `false` to `true`. Other mongod log configuration options are under `[inputs.mongodb.log]`. The commented-out configurations are default settings. If the paths correspond correctly, no additional configuration is required. After starting Datakit, you will see a collected Metrics set named `mongod_log`.

Log raw data sample

```log
{"t":{"$date":"2021-06-03T09:12:19.977+00:00"},"s":"I",  "c":"STORAGE",  "id":22430,   "ctx":"WTCheckpointThread","msg":"WiredTiger message","attr":{"message":"[1622711539:977142][1:0x7f1b9f159700], WT_SESSION.checkpoint: [WT_VERB_CHECKPOINT_PROGRESS] saving checkpoint snapshot min: 653, snapshot max: 653 snapshot count: 0, oldest timestamp: (0, 0) , meta checkpoint timestamp: (0, 0)"}}
```

Log segmentation fields

| Field Name    | Field Value                        | Description                                                           |
| ------------- | ---------------------------------- | --------------------------------------------------------------------- |
| message       |                                   | Log raw data                                                         |
| component     | STORAGE                           | The full component string of the log message                         |
| context       | WTCheckpointThread                | The name of the thread issuing the log statement                     |
| msg           | WiredTiger message                | The raw log output message as passed from the server or driver       |
| status        | I                                 | The short severity code of the log message                           |
| time          | 2021-06-03T09:12:19.977+00:00     | Timestamp                                                            |