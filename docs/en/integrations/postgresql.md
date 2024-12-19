---
title     : 'PostgreSQL'
summary   : 'Collect PostgreSQL metrics'
tags:
  - 'DATA STORES'
__int_icon      : 'icon/postgresql'
dashboard :
  - desc  : 'PostgrepSQL'
    path  : 'dashboard/en/postgresql'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

PostgreSQL collector can collect the running status index from PostgreSQL instance, and collect the index to Guance Cloud to help monitor and analyze various abnormal situations of PostgreSQL.

## Configuration {#config}

### Preconditions {#reqirement}

- PostgreSQL version >= 9.0
- Create user

```sql
-- PostgreSQL >= 10
create user datakit with password '<PASSWORD>';
grant pg_monitor to datakit;
grant SELECT ON pg_stat_database to datakit;

-- PostgreSQL < 10
create user datakit with password '<PASSWORD>';
grant SELECT ON pg_stat_database to datakit;
```

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Go to the `conf.d/db` directory under the DataKit installation directory, copy `postgresql.conf.sample` and name it `postgresql.conf`. Examples are as follows:

    ```toml
        
    [[inputs.postgresql]]
      ## Server address
      # URI format
      # postgres://[datakit[:PASSWORD]]@localhost[/dbname]?sslmode=[disable|verify-ca|verify-full]
      # or simple string
      # host=localhost user=pqgotest password=... sslmode=... dbname=app_production
    
      address = "postgres://datakit:PASSWORD@localhost?sslmode=disable"
    
      ## Ignore databases which are gathered. Do not use with 'databases' option.
      #
      # ignored_databases = ["db1"]
    
      ## Specify the list of the databases to be gathered. Do not use with the 'ignored_databases' option.
      #
      # databases = ["db1"]
    
      ## Specify the name used as the "server" tag.
      #
      # outputaddress = "db01"
    
      ## Collect interval
      # Time unit: "ns", "us", "ms", "s", "m", "h"
      #
      interval = "10s"
    
      ## Relations config
      # The list of relations/tables can be specified to track per-relation metrics. To collect relation
      # relation_name refer to the name of a relation, either relation_name or relation_regex must be set.
      # relation_regex is a regex rule, only takes effect when relation_name is not set.
      # schemas used for filtering, ignore this field when it is empty
      # relkind can be a list of the following options:
      #   r(ordinary table), i(index), S(sequence), t(TOAST table), p(partitioned table),
      #   m(materialized view), c(composite type), f(foreign table)
      #
      # [[inputs.postgresql.relations]]
      # relation_name = "<TABLE_NAME>"
      # relation_regex = "<TABLE_PATTERN>"
      # schemas = ["public"]
      # relkind = ["r", "p"]
    
      ## Set true to enable election
      election = true
    
      ## Run a custom SQL query and collect corresponding metrics.
      #
      # [[inputs.postgresql.custom_queries]]
      #   sql = '''
      #     select datname,numbackends,blks_read
      #     from pg_stat_database
      #     limit 10
      #   '''
      #   metric = "postgresql_custom_stat"
      #   tags = ["datname" ]
      #   fields = ["numbackends", "blks_read"]
    
      ## Log collection
      #
      # [inputs.postgresql.log]
      # files = []
      # pipeline = "postgresql.p"
    
      ## Custom tags
      #
      [inputs.postgresql.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
      # ...
    
    ```

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

## Metric {#metric}

For all of the following data collections, the global election tags will added automatically, we can add extra tags in `[inputs.postgresql.tags]` if needed:



### `postgresql`

- tag


| Tag | Description |
|  ----  | --------|
|`db`|The database name|
|`server`|The server address|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active_time`|Time spent executing SQL statements in this database, in milliseconds.|float|count|
|`blks_hit`|The number of times disk blocks were found in the buffer cache, preventing the need to read from the database.|int|count|
|`blks_read`|The number of disk blocks read in this database.|int|count|
|`database_size`|The disk space used by this database.|int|count|
|`deadlocks`|The number of deadlocks detected in this database.|int|count|
|`idle_in_transaction_time`|Time spent idling while in a transaction in this database, in milliseconds.|float|count|
|`numbackends`|The number of active connections to this database.|int|count|
|`session_time`|Time spent by database sessions in this database, in milliseconds.|float|count|
|`sessions`|Total number of sessions established to this database.|int|count|
|`sessions_abandoned`|Number of database sessions to this database that were terminated because connection to the client was lost.|int|count|
|`sessions_fatal`|Number of database sessions to this database that were terminated by fatal errors.|int|count|
|`sessions_killed`|Number of database sessions to this database that were terminated by operator intervention.|int|count|
|`temp_bytes`|The amount of data written to temporary files by queries in this database.|int|count|
|`temp_files`|The number of temporary files created by queries in this database.|int|count|
|`tup_deleted`|The number of rows deleted by queries in this database.|int|count|
|`tup_fetched`|The number of rows fetched by queries in this database.|int|count|
|`tup_inserted`|The number of rows inserted by queries in this database.|int|count|
|`tup_returned`|The number of rows returned by queries in this database.|int|count|
|`tup_updated`|The number of rows updated by queries in this database.|int|count|
|`wraparound`|The number of transactions that can occur until a transaction wraparound.|float|count|
|`xact_commit`|The number of transactions that have been committed in this database.|int|count|
|`xact_rollback`|The number of transactions that have been rolled back in this database.|int|count|



### `postgresql_lock`

- tag


| Tag | Description |
|  ----  | --------|
|`db`|The database name|
|`locktype`|The lock type|
|`mode`|The lock mode|
|`schema`|The schema name|
|`server`|The server address|
|`table`|The table name|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`lock_count`|The number of locks active for this database.|int|count|



### `postgresql_index`

- tag


| Tag | Description |
|  ----  | --------|
|`db`|The database name|
|`index`|The index name|
|`schema`|The schema name|
|`server`|The server address|
|`table`|The table name|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`idx_scan`|The number of index scans initiated on this table, tagged by index.|int|count|
|`idx_tup_fetch`|The number of live rows fetched by index scans.|int|count|
|`idx_tup_read`|The number of index entries returned by scans on this index.|int|count|



### `postgresql_replication`

- tag


| Tag | Description |
|  ----  | --------|
|`db`|The database name|
|`server`|The server address|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`replication_delay`|The current replication delay in seconds. Only available with `postgresql` 9.1 and newer.|int|s|
|`replication_delay_bytes`|The current replication delay in bytes. Only available with `postgresql` 9.2 and newer.|int|B|



### `postgresql_replication_slot`

- tag


| Tag | Description |
|  ----  | --------|
|`db`|The database name|
|`server`|The server address|
|`slot_name`|The replication slot name|
|`slot_type`|The replication slot type|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`spill_bytes`|Amount of decoded transaction data spilled to disk while performing decoding of changes from WAL for this slot. This and other spill counters can be used to gauge the I/O which occurred during logical decoding and allow tuning `logical_decoding_work_mem`. Only available with PostgreSQL 14 and newer.|int|B|
|`spill_count`|Number of times transactions were spilled to disk while decoding changes from WAL for this slot. This counter is incremented each time a transaction is spilled, and the same transaction may be spilled multiple times. Only available with PostgreSQL 14 and newer.|int|count|
|`spill_txns`|Number of transactions spilled to disk once the memory used by logical decoding to decode changes from WAL has exceeded `logical_decoding_work_mem`. The counter gets incremented for both top-level transactions and subtransactions. Only available with PostgreSQL 14 and newer.|int|count|
|`stream_bytes`|Amount of transaction data decoded for streaming in-progress transactions to the decoding output plugin while decoding changes from WAL for this slot. This and other streaming counters for this slot can be used to tune `logical_decoding_work_mem`. Only available with PostgreSQL 14 and newer.|int|B|
|`stream_count`|Number of times in-progress transactions were streamed to the decoding output plugin while decoding changes from WAL for this slot. This counter is incremented each time a transaction is streamed, and the same transaction may be streamed multiple times. Only available with PostgreSQL 14 and newer.|int|count|
|`stream_txns`|Number of in-progress transactions streamed to the decoding output plugin after the memory used by logical decoding to decode changes from WAL for this slot has exceeded `logical_decoding_work_mem`. Streaming only works with top-level transactions (subtransactions can't be streamed independently), so the counter is not incremented for subtransactions. Only available with PostgreSQL 14 and newer.|int|count|
|`total_bytes`|Amount of transaction data decoded for sending transactions to the decoding output plugin while decoding changes from WAL for this slot. Note that this includes data that is streamed and/or spilled. Only available with PostgreSQL 14 and newer.|int|B|
|`total_txns`|Number of decoded transactions sent to the decoding output plugin for this slot. This counts top-level transactions only, and is not incremented for subtransactions. Note that this includes the transactions that are streamed and/or spilled. Only available with PostgreSQL 14 and newer.|int|count|



### `postgresql_size`

- tag


| Tag | Description |
|  ----  | --------|
|`db`|The database name|
|`schema`|The schema name|
|`server`|The server address|
|`table`|The table name|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`index_size`|The total disk space used by indexes attached to the specified table.|int|B|
|`table_size`|The total disk space used by the specified table with TOAST data. Free space map and visibility map are not included.|int|B|
|`total_size`|The total disk space used by the table, including indexes and TOAST data.|int|B|



### `postgresql_statio`

- tag


| Tag | Description |
|  ----  | --------|
|`db`|The database name|
|`schema`|The schema name|
|`server`|The server address|
|`table`|The table name|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`heap_blks_hit`|The number of buffer hits in this table.|int|count|
|`heap_blks_read`|The number of disk blocks read from this table.|int|count|
|`idx_blks_hit`|The number of buffer hits in all indexes on this table.|int|count|
|`idx_blks_read`|The number of disk blocks read from all indexes on this table.|int|count|
|`tidx_blks_hit`|The number of buffer hits in this table's TOAST table index.|int|count|
|`tidx_blks_read`|The number of disk blocks read from this table's TOAST table index.|int|count|
|`toast_blks_hit`|The number of buffer hits in this table's TOAST table.|int|count|
|`toast_blks_read`|The number of disk blocks read from this table's TOAST table.|int|count|



### `postgresql_stat`

- tag


| Tag | Description |
|  ----  | --------|
|`db`|The database name|
|`schema`|The schema name|
|`server`|The server address|
|`table`|The table name|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`analyze_count`|The number of times this table has been manually analyzed.|int|count|
|`autoanalyze_count`|The number of times this table has been analyzed by the `autovacuum` daemon.|int|count|
|`autovacuum_count`|The number of times this table has been vacuumed by the `autovacuum` daemon.|int|count|
|`idx_scan`|The number of index scans initiated on this table, tagged by index.|int|count|
|`idx_tup_fetch`|The number of live rows fetched by index scans.|int|count|
|`n_dead_tup`|The estimated number of dead rows.|int|count|
|`n_live_tup`|The estimated number of live rows.|int|count|
|`n_tup_del`|The number of rows deleted by queries in this database.|int|count|
|`n_tup_hot_upd`|The number of rows HOT updated, meaning no separate index update was needed.|int|count|
|`n_tup_ins`|The number of rows inserted by queries in this database.|int|count|
|`n_tup_upd`|The number of rows updated by queries in this database.|int|count|
|`seq_scan`|The number of sequential scans initiated on this table.|int|count|
|`seq_tup_read`|The number of live rows fetched by sequential scans.|int|count|
|`vacuum_count`|The number of times this table has been manually vacuumed.|int|count|



### `postgresql_slru`

- tag


| Tag | Description |
|  ----  | --------|
|`db`|The database name|
|`name`|The name of the `SLRU`|
|`server`|The server address|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`blks_exists`|Number of blocks checked for existence for this `SLRU` (simple least-recently-used) cache.|int|count|
|`blks_hit`|Number of times disk blocks were found already in the `SLRU` (simple least-recently-used.)|int|count|
|`blks_read`|Number of disk blocks read for this `SLRU` (simple least-recently-used) cache. `SLRU` caches are created with a fixed number of pages.|int|count|
|`blks_written`|Number of disk blocks written for this `SLRU` (simple least-recently-used) cache.|int|count|
|`blks_zeroed`|Number of blocks zeroed during initializations of `SLRU` (simple least-recently-used) cache.|int|count|
|`flushes`|Number of flush of dirty data for this `SLRU` (simple least-recently-used) cache.|int|count|
|`truncates`|Number of truncates for this `SLRU` (simple least-recently-used) cache.|int|count|



### `postgresql_bgwriter`

- tag


| Tag | Description |
|  ----  | --------|
|`db`|The database name|
|`server`|The server address|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`buffers_alloc`|The number of buffers allocated|int|count|
|`buffers_backend`|The number of buffers written directly by a backend.|int|count|
|`buffers_backend_fsync`|The of times a backend had to execute its own fsync call instead of the background writer.|int|count|
|`buffers_checkpoint`|The number of buffers written during checkpoints.|int|count|
|`buffers_clean`|The number of buffers written by the background writer.|int|count|
|`checkpoint_sync_time`|The total amount of checkpoint processing time spent synchronizing files to disk.|float|ms|
|`checkpoint_write_time`|The total amount of checkpoint processing time spent writing files to disk.|float|ms|
|`checkpoints_req`|The number of requested checkpoints that were performed.|int|count|
|`checkpoints_timed`|The number of scheduled checkpoints that were performed.|int|count|
|`maxwritten_clean`|The number of times the background writer stopped a cleaning scan due to writing too many buffers.|int|count|



### `postgresql_connection`

- tag


| Tag | Description |
|  ----  | --------|
|`db`|The database name|
|`server`|The server address|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`max_connections`|The maximum number of client connections allowed to this database.|float|count|
|`percent_usage_connections`|The number of connections to this database as a fraction of the maximum number of allowed connections.|float|count|



### `postgresql_conflict`

- tag


| Tag | Description |
|  ----  | --------|
|`db`|The database name|
|`server`|The server address|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`confl_bufferpin`|Number of queries in this database that have been canceled due to pinned buffers.|int|count|
|`confl_deadlock`|Number of queries in this database that have been canceled due to deadlocks.|int|count|
|`confl_lock`|Number of queries in this database that have been canceled due to dropped tablespaces. This will occur when a `temp_tablespace` is dropped while being used on a standby.|int|count|
|`confl_snapshot`|Number of queries in this database that have been canceled due to old snapshots.|int|count|
|`confl_tablespace`|Number of queries in this database that have been canceled due to dropped tablespaces. This will occur when a `temp_tablespace` is dropped while being used on a standby.|int|count|



### `postgresql_archiver`

- tag


| Tag | Description |
|  ----  | --------|
|`db`|The database name|
|`server`|The server address|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`archived_count`|Number of WAL files that have been successfully archived.|int|count|
|`archived_failed_count`|Number of failed attempts for archiving WAL files.|int|count|



## Custom Object {#object}























































## Log Collection {#logging}

- PostgreSQL logs are output to `stderr` by default. To open file logs, configure them in postgresql's configuration file `/etc/postgresql/<VERSION>/main/postgresql.conf` as follows:

```toml
logging_collector = on    # Enable log writing to files

log_directory = 'pg_log'  # Set the file storage directory, absolute path or relative path (relative PGDATA)

log_filename = 'pg.log'   # Log file name
log_statement = 'all'     # Record all queries

#log_duration = on
log_line_prefix= '%m [%p] %d [%a] %u [%h] %c ' # 日志行前缀
log_file_mode = 0644

# For Windows
#log_destination = 'eventlog'
```

For more configuration, please refer to the [doc](https://www.postgresql.org/docs/11/runtime-config-logging.html){:target="_blank"}。

- The PostgreSQL collector does not have log collection enabled by default. You can open `files` in `conf.d/db/postgresql.conf`  and write to the absolute path of the PostgreSQL log file. For example:

```toml
[[inputs.postgresql]]

  ...

  [inputs.postgresql.log]
  files = ["/tmp/pgsql/postgresql.log"]
```

When log collection is turned on, a log with a log `source` of `postgresql` is generated by default.

**Notices:**

- Log collection only supports logs on hosts where DataKit is installed.

### Log Pipeline Cut {#pipeline}

The original log is

``` log
2021-05-31 15:23:45.110 CST [74305] test [pgAdmin 4 - DB:postgres] postgres [127.0.0.1] 60b48f01.12241 LOG:  statement:
        SELECT psd.*, 2^31 - age(datfrozenxid) as wraparound, pg_database_size(psd.datname) as pg_database_size
        FROM pg_stat_database psd
        JOIN pg_database pd ON psd.datname = pd.datname
        WHERE psd.datname not ilike 'template%'   AND psd.datname not ilike 'rdsadmin'
        AND psd.datname not ilike 'azure_maintenance'   AND psd.datname not ilike 'postgres'
```

Description of the cut field:

| Field name         | Field Value               | Description                                                    |
| ------------------ | ------------------------- | -------------------------------------------------------------- |
| `application_name` | `pgAdmin 4 - DB:postgres` | The name of the application connecting to the current database |
| `db_name`          | `test`                    | Database accessed                                              |
| `process_id`       | `74305`                   | The client process ID of the current connection                |
| `remote_host`      | `127.0.0.1`               | Address of the client                                          |
| `session_id`       | `60b48f01.12241`          | ID of the current session                                      |
| `user`             | `postgres`                | Current Access User Name                                       |
| `status`           | `LOG`                     | Current log level (LOG,ERROR,FATAL,PANIC,WARNING,NOTICE,INFO)  |
| `time`             | `1622445825110000000`     | Log generation time                                            |

## FAQ {#faq}

<!-- markdownlint-disable MD013 -->
### :material-chat-question: Missing metrics `postgresql_lock`, `postgresql_stat`, `postgresql_index`, `postgresql_size`, `postgresql_statio` {#faq-missing-relation-metrics}

To report these metrics, the `relations` field in the configuration file needs to be enabled. If some of these metrics are partially missing, it may be because there is no data for the relevant metrics.

<!-- markdownlint-enable -->
