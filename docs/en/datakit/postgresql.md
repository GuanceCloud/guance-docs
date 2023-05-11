
# PostgreSQL
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "支持选举")

---

Postgresql collector can collect the running status index from Postgresql instance, and collect the index to Guance Cloud to help monitor and analyze various abnormal situations of Postgresql.

## Preconditions {#reqirement}

- Postgresql version >= 9.0
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

## Configuration {#config}

Go to the `conf.d/db` directory under the DataKit installation directory, copy `postgresql.conf.sample` and name it `postgresql.conf`. Examples are as follows:

```toml

[[inputs.postgresql]]
  ## Server address 
  # URI format
  # postgres://[pqgotest[:password]]@localhost[/dbname]?sslmode=[disable|verify-ca|verify-full]
  # or simple string 
  # host=localhost user=pqgotest password=... sslmode=... dbname=app_production

  address = "postgres://postgres@localhost/test?sslmode=disable"

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
  # Time unit: "ns", "us" (or "µs"), "ms", "s", "m", "h"
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

After setting it, restart the DataKit.

## Measurements {#measurements}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or it can be named by `[[inputs.postgresql.tags]]` alternative host in the configuration.



### `postgresql`

- tag


| Tag | Description |
|  ----  | --------|
|`db`|The database name|
|`server`|The server address|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active_time`|Time spent executing SQL statements in this database, in milliseconds.|int|count|
|`archived_count`|Number of WAL files that have been successfully archived.|int|count|
|`archived_failed_count`|Number of failed attempts for archiving WAL files.|int|count|
|`blks_hit`|The number of times disk blocks were found in the buffer cache, preventing the need to read from the database.|int|count|
|`blks_read`|The number of disk blocks read in this database.|int|count|
|`buffers_alloc`|The number of buffers allocated|int|count|
|`buffers_backend`|The number of buffers written directly by a backend.|int|count|
|`buffers_backend_fsync`|The of times a backend had to execute its own fsync call instead of the background writer.|int|count|
|`buffers_checkpoint`|The number of buffers written during checkpoints.|int|count|
|`buffers_clean`|The number of buffers written by the background writer.|int|count|
|`checkpoint_sync_time`|The total amount of checkpoint processing time spent synchronizing files to disk.|float|ms|
|`checkpoint_write_time`|The total amount of checkpoint processing time spent writing files to disk.|float|ms|
|`checkpoints_req`|The number of requested checkpoints that were performed.|int|count|
|`checkpoints_timed`|The number of scheduled checkpoints that were performed.|int|count|
|`confl_bufferpin`|Number of queries in this database that have been canceled due to pinned buffers.|int|count|
|`confl_deadlock`|Number of queries in this database that have been canceled due to deadlocks.|int|count|
|`confl_lock`|Number of queries in this database that have been canceled due to dropped tablespaces. This will occur when a `temp_tablespace` is dropped while being used on a standby.|int|count|
|`confl_snapshot`|Number of queries in this database that have been canceled due to old snapshots.|int|count|
|`confl_tablespace`|Number of queries in this database that have been canceled due to dropped tablespaces. This will occur when a `temp_tablespace` is dropped while being used on a standby.|int|count|
|`database_size`|The disk space used by this database.|float|count|
|`deadlocks`|The number of deadlocks detected in this database.|int|count|
|`idle_in_transaction_time`|Time spent idling while in a transaction in this database, in milliseconds.|int|count|
|`max_connections`|The maximum number of client connections allowed to this database.|float|count|
|`maxwritten_clean`|The number of times the background writer stopped a cleaning scan due to writing too many buffers.|int|count|
|`numbackends`|The number of active connections to this database.|int|count|
|`percent_usage_connections`|The number of connections to this database as a fraction of the maximum number of allowed connections.|float|count|
|`session_time`|Time spent by database sessions in this database, in milliseconds.|int|count|
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
|`wraparound`|The number of transactions that can occur until a transaction wraparound.|int|count|
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
|`table`|The table name|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`lock_count`|The number of locks active for this database.|int|count|



### `postgresql_index`

- tag


| Tag | Description |
|  ----  | --------|
|`index`|The index name|
|`schema`|The schema name|
|`table`|The table name|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`idx_scan`|The number of index scans initiated on this table, tagged by index.|int|count|
|`idx_tup_fetch`|The number of live rows fetched by index scans.|int|count|
|`idx_tup_read`|The number of index entries returned by scans on this index.|int|count|



### `postgresql_replication`

- tag

NA

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`replication_delay`|The current replication delay in seconds. Only available with `postgresql` 9.1 and newer.|int|s|
|`replication_delay_bytes`|The current replication delay in bytes. Only available with `postgresql` 9.2 and newer.|int|B|



### `postgresql_size`

- tag


| Tag | Description |
|  ----  | --------|
|`schema`|The schema name|
|`table`|The table name|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`index_size`|The total disk space used by indexes attached to the specified table.|float|B|
|`table_size`|The total disk space used by the specified table. Includes TOAST, free space map, and visibility map. Excludes indexes.|float|B|
|`total_size`|The total disk space used by the table, including indexes and TOAST data.|float|B|



### `postgresql_statio`

- tag


| Tag | Description |
|  ----  | --------|
|`schema`|The schema name|
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
|`name`|The name of the `SLRU`|

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



## Log Collection {#logging}

- Postgresql logs are output to `stderr` by default. To open file logs, configure them in postgresql's configuration file `/etc/postgresql/<VERSION>/main/postgresql.conf` as follows:

```
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

- The Postgresql collector does not have log collection enabled by default. You can open `files` in `conf.d/db/postgresql.conf`  and write to the absolute path of the Postgresql log file. For example:

```
[[inputs.postgresql]]

  ...

  [inputs.postgresql.log]
  files = ["/tmp/pgsql/postgresql.log"]
```

When log collection is turned on, a log with a log `source` of `postgresql` is generated by default.

**Notices:**

- Log collection only supports logs on hosts where DataKit is installed.

## Log Pipeline Cut {#pipeline}

The original log is

```
2021-05-31 15:23:45.110 CST [74305] test [pgAdmin 4 - DB:postgres] postgres [127.0.0.1] 60b48f01.12241 LOG:  statement:
		SELECT psd.*, 2^31 - age(datfrozenxid) as wraparound, pg_database_size(psd.datname) as pg_database_size
		FROM pg_stat_database psd
		JOIN pg_database pd ON psd.datname = pd.datname
		WHERE psd.datname not ilike 'template%'   AND psd.datname not ilike 'rdsadmin'
		AND psd.datname not ilike 'azure_maintenance'   AND psd.datname not ilike 'postgres'
```

Description of the cut field:

| Field name           | Field Value                  | Description                                                      |
| ---              | ---                     | ---                                                       |
| application_name | pgAdmin 4 - DB:postgres | The name of the application connecting to the current database                                |
| db_name          | test                    | Database accessed                                              |
| process_id       | 74305                   | The client process ID of the current connection                                    |
| remote_host      | 127.0.0.1               | Address of the client                                              |
| session_id       | 60b48f01.12241          | ID of the current session                                              |
| user             | postgres                | Current Access User Name                                            |
| status           | LOG                     | Current log level (LOG,ERROR,FATAL,PANIC,WARNING,NOTICE,INFO) |
| time             | 1622445825110000000     | Log generation time                                              |
