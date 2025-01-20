---
title     : 'MongoDB'
summary   : 'Collect mongodb metrics data'
tags:
  - 'DATA STORES'
__int_icon      : 'icon/mongodb'
dashboard :
  - desc  : 'Mongodb'
    path  : 'dashboard/en/mongodb'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

MongoDb database, Collection, MongoDb database cluster running status data Collection.

## Config {#config}

### Preconditions {#requirements}

- Already tested version:
    - [x] 6.0
    - [x] 5.0
    - [x] 4.0
    - [x] 3.0
    - [x] 2.8.0

- Developed and used MongoDB version `4.4.5`;
- Write the configuration file in the corresponding directory and then start DataKit to complete the configuration;
- For secure connections using TLS, please configure the response certificate file path and configuration under `## TLS connection config` in the configuration file;
- If MongoDB has access control enabled, you need to configure the necessary user rights to establish an authorized connection:

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

>More authorization information can refer to official documentation [Built-In Roles](https://www.mongodb.com/docs/manual/reference/built-in-roles/){:target="_blank"}。

After done with commands above, filling the `user` and `pwd` to Datakit configuration file `conf.d/db/mongodb.conf`.

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Go to the `conf.d/db` directory under the DataKit installation directory, copy `mongodb.conf.sample` and name it `mongodb.conf`. Examples are as follows:

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

    Once configured, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

### TLS config (self-signed) {#tls}

Use OpenSSL to generate a certificate file for MongoDB TLS configuration to enable server-side encryption and client-side authentication.

- Configure TLS certificates

Install OpenSSL and run the following command:

```shell
sudo apt install openssl -y
```

- Configure MongoDB server-side encryption

Use OpenSSL to generate a certificate-level key file, run the following command and enter the corresponding authentication block information at the command prompt:

```shell
sudo openssl req -x509 -newkey rsa:<bits> -days <days> -keyout <mongod.key.pem> -out <mongod.cert.pem> -nodes
```

- `bits`: rsa key digits, for example, 2048
- `days`: expired date
- `mongod.key.pem`: key file
- `mongod.cert.pem`: CA certificate file

Running the above command generates the `cert.pem` file and the `key.pem` file, and we need to merge the `block` inside the two files to run the following command:

```shell
sudo bash -c "cat mongod.cert.pem mongod.key.pem >>mongod.pem"
```

Configure the TLS subentry in the /etc/mongod.config file after merging

```yaml
# TLS config
net:
  tls:
    mode: requireTLS
    certificateKeyFile: </etc/ssl/mongod.pem>
```

Start MongoDB with the configuration file and run the following command:

```shell
mongod --config /etc/mongod.conf
```

Start MongoDB from the command line and run the following command:

```shell
mongod --tlsMode requireTLS --tlsCertificateKeyFile </etc/ssl/mongod.pem> --dbpath <.db/mongodb>
```

Copy mongod.cert.pem as mongo.cert.pem to MongoDB client and enable TLS:

```shell
mongo --tls --host <mongod_url> --tlsCAFile </etc/ssl/mongo.cert.pem>
```

- Configuring MongoDB Client Authentication

Use OpenSSL to generate a certificate-level key file and run the following command:

```shell
sudo openssl req -x509 -newkey rsa:<bits> -days <days> -keyout <mongod.key.pem> -out <mongod.cert.pem> -nodes
```

- `bits`: rsa key digits, for example, 2048
- `days`: expired date
- `mongo.key.pem`: key file
- `mongo.cert.pem`: CA certificate file

Merging the block in the mongod.cert.pem and mongod.key.pem files runs the following command:

```shell
sudo bash -c "cat mongod.cert.pem mongod.key.pem >>mongod.pem"
```

Copy the mongod.cert.pem file to the MongoDB server and configure the TLS entry in the /etc/mongod.config file.

```yaml
# Tls config
net:
  tls:
    mode: requireTLS
    certificateKeyFile: </etc/ssl/mongod.pem>
    CAFile: </etc/ssl/mongod.cert.pem>
```

Start MongoDB and run the following command:

```shell
mongod --config /etc/mongod.conf
```

Copy mongod.cert.pem for mongo.cert.pem; Copy mongod.pem for mongo.pem to MongoDB client and enable TLS:

```shell
mongo --tls --host <mongod_url> --tlsCAFile </etc/ssl/mongo.cert.pem> --tlsCertificateKeyFile </etc/ssl/mongo.pem>
```

**Note:**`insecure_skip_verify` must be `true` in mongodb.conf configuration when using self-signed certificates.

## Metric {#metric}

For all of the following data collections, the global election tags will added automatically, we can add extra tags in `[inputs.mongodb.tags]` if needed:

```toml
 [inputs.mongodb.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```






### `mongodb_db_stats`

- explain

MongoDB stats measurement. Some metrics may not appear depending on the MongoDB version or DB running status.

- Tags


| Tag | Description |
|  ----  | --------|
|`db_name`|database name|
|`host`|mongodb host|
|`mongod_host`|mongodb host with port|

- Metrics


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

- explain

MongoDB collection measurement. Some metrics may not appear depending on the MongoDB version or DB running status.

- Tags


| Tag | Description |
|  ----  | --------|
|`collection`|collection name|
|`db_name`|database name|
|`host`|mongodb host|
|`mongod_host`|mongodb host with port|

- Metrics


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

- explain

MongoDB shard measurement. Some metrics may not appear depending on the MongoDB version or DB running status.

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|mongodb host|
|`mongod_host`|mongodb host with port|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`available`|The number of connections available for this host to connect to the mongos.|int|count|
|`created`|The number of connections the host has ever created to connect to the mongos.|int|count|
|`in_use`|Reports the total number of outgoing connections from the current mongod/mongos instance to other members of the sharded cluster or replica set that are currently in use.|int|count|
|`refreshing`|Reports the total number of outgoing connections from the current mongod/mongos instance to other members of the sharded cluster or replica set that are currently being refreshed.|int|count|





### `mongodb_top_stats`

- explain

MongoDB top measurement. Some metrics may not appear depending on the MongoDB version or DB running status.

- Tags


| Tag | Description |
|  ----  | --------|
|`collection`|collection name|
|`host`|mongodb host|
|`mongod_host`|mongodb host with port|

- Metrics


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






## Custom Object {#object}

























### `database`



- Tags


| Tag | Description |
|  ----  | --------|
|`col_co_status`|Current status of collector on Mongodb(`OK/NotOK`)|
|`host`|The server host address|
|`ip`|Connection IP of the Mongodb|
|`name`|Object uniq ID|
|`reason`|If status not ok, we'll get some reasons about the status|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`display_name`|Displayed name in UI|string|-|
|`uptime`|Current Mongodb uptime|int|s|
|`version`|Current version of Mongodb|string|-|




## Mongod Log Collection {#logging}

Annotate the configuration file `# enable_mongod_log = false` and change `false` to `true`. Other configuration options for mongod log are in `[inputs.mongodb.log]`, and the commented configuration is very default. If the path correspondence is correct, no configuration is needed. After starting Datakit, you will see a collection measurement named `mongod_log`.

Log raw data sample

```not-set
{"t":{"$date":"2021-06-03T09:12:19.977+00:00"},"s":"I",  "c":"STORAGE",  "id":22430,   "ctx":"WTCheckpointThread","msg":"WiredTiger message","attr":{"message":"[1622711539:977142][1:0x7f1b9f159700], WT_SESSION.checkpoint: [WT_VERB_CHECKPOINT_PROGRESS] saving checkpoint snapshot min: 653, snapshot max: 653 snapshot count: 0, oldest timestamp: (0, 0) , meta checkpoint timestamp: (0, 0)"}}
```

Log cut field

| Field Name | Field Value                   | Description                                                    |
| ---------- | ----------------------------- | -------------------------------------------------------------- |
| message    |                               | Log raw data                                                   |
| component  | STORAGE                       | The full component string of the log message                   |
| context    | WTCheckpointThread            | The name of the thread issuing the log statement               |
| msg        | WiredTiger message            | The raw log output message as passed from the server or driver |
| status     | I                             | The short severity code of the log message                     |
| time       | 2021-06-03T09:12:19.977+00:00 | Timestamp                                                      |
