---
title     : 'PostgreSQL'
summary   : '采集 PostgreSQL 的指标数据'
__int_icon      : 'icon/postgresql'
dashboard :
  - desc  : 'PostgrepSQL'
    path  : 'dashboard/zh/postgresql'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# PostgreSQL
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

PostgreSQL 采集器可以从 PostgreSQL 实例中采集实例运行状态指标，并将指标采集到观测云，帮助监控分析 PostgreSQL 各种异常情况。

## 配置 {#config}

### 前置条件 {#reqirement}

- PostgreSQL 版本 >= 9.0
- 创建监控帐号

```sql
-- PostgreSQL >= 10
create user datakit with password '<PASSWORD>';
grant pg_monitor to datakit;
grant SELECT ON pg_stat_database to datakit;

-- PostgreSQL < 10
create user datakit with password '<PASSWORD>';
grant SELECT ON pg_stat_database to datakit;
```

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机部署"

    进入 DataKit 安装目录下的 `conf.d/db` 目录，复制 `postgresql.conf.sample` 并命名为 `postgresql.conf`。示例如下：

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

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

## 指标 {#metric}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[[inputs.postgresql.tags]]` 另择 host 来命名。



### `postgresql`

- 标签


| Tag | Description |
|  ----  | --------|
|`db`|The database name|
|`server`|The server address|

- 指标列表


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

- 标签


| Tag | Description |
|  ----  | --------|
|`db`|The database name|
|`locktype`|The lock type|
|`mode`|The lock mode|
|`schema`|The schema name|
|`server`|The server address|
|`table`|The table name|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`lock_count`|The number of locks active for this database.|int|count|



### `postgresql_index`

- 标签


| Tag | Description |
|  ----  | --------|
|`db`|The database name|
|`index`|The index name|
|`schema`|The schema name|
|`server`|The server address|
|`table`|The table name|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`idx_scan`|The number of index scans initiated on this table, tagged by index.|int|count|
|`idx_tup_fetch`|The number of live rows fetched by index scans.|int|count|
|`idx_tup_read`|The number of index entries returned by scans on this index.|int|count|



### `postgresql_replication`

- 标签


| Tag | Description |
|  ----  | --------|
|`db`|The database name|
|`server`|The server address|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`replication_delay`|The current replication delay in seconds. Only available with `postgresql` 9.1 and newer.|int|s|
|`replication_delay_bytes`|The current replication delay in bytes. Only available with `postgresql` 9.2 and newer.|int|B|



### `postgresql_size`

- 标签


| Tag | Description |
|  ----  | --------|
|`db`|The database name|
|`schema`|The schema name|
|`server`|The server address|
|`table`|The table name|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`index_size`|The total disk space used by indexes attached to the specified table.|int|B|
|`table_size`|The total disk space used by the specified table. Includes TOAST, free space map, and visibility map. Excludes indexes.|int|B|
|`total_size`|The total disk space used by the table, including indexes and TOAST data.|int|B|



### `postgresql_statio`

- 标签


| Tag | Description |
|  ----  | --------|
|`db`|The database name|
|`schema`|The schema name|
|`server`|The server address|
|`table`|The table name|

- 指标列表


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

- 标签


| Tag | Description |
|  ----  | --------|
|`db`|The database name|
|`schema`|The schema name|
|`server`|The server address|
|`table`|The table name|

- 指标列表


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

- 标签


| Tag | Description |
|  ----  | --------|
|`db`|The database name|
|`name`|The name of the `SLRU`|
|`server`|The server address|

- 指标列表


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

- 标签


| Tag | Description |
|  ----  | --------|
|`db`|The database name|
|`server`|The server address|

- 指标列表


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

- 标签


| Tag | Description |
|  ----  | --------|
|`db`|The database name|
|`server`|The server address|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`max_connections`|The maximum number of client connections allowed to this database.|float|count|
|`percent_usage_connections`|The number of connections to this database as a fraction of the maximum number of allowed connections.|float|count|



### `postgresql_conflict`

- 标签


| Tag | Description |
|  ----  | --------|
|`db`|The database name|
|`server`|The server address|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`confl_bufferpin`|Number of queries in this database that have been canceled due to pinned buffers.|int|count|
|`confl_deadlock`|Number of queries in this database that have been canceled due to deadlocks.|int|count|
|`confl_lock`|Number of queries in this database that have been canceled due to dropped tablespaces. This will occur when a `temp_tablespace` is dropped while being used on a standby.|int|count|
|`confl_snapshot`|Number of queries in this database that have been canceled due to old snapshots.|int|count|
|`confl_tablespace`|Number of queries in this database that have been canceled due to dropped tablespaces. This will occur when a `temp_tablespace` is dropped while being used on a standby.|int|count|



### `postgresql_archiver`

- 标签


| Tag | Description |
|  ----  | --------|
|`db`|The database name|
|`server`|The server address|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`archived_count`|Number of WAL files that have been successfully archived.|int|count|
|`archived_failed_count`|Number of failed attempts for archiving WAL files.|int|count|



## 日志 {#logging}

- PostgreSQL 日志默认是输出至 `stderr`，如需开启文件日志，可在 PostgreSQL 的配置文件 `/etc/postgresql/<VERSION>/main/postgresql.conf` ， 进行如下配置：

```toml
logging_collector = on    # 开启日志写入文件功能

log_directory = 'pg_log'  # 设置文件存放目录，绝对路径或相对路径（相对 PGDATA）

log_filename = 'pg.log'   # 日志文件名称
log_statement = 'all'     # 记录所有查询

#log_duration = on
log_line_prefix= '%m [%p] %d [%a] %u [%h] %c ' # 日志行前缀
log_file_mode = 0644

# For Windows
#log_destination = 'eventlog'
```

更多配置，请参考[官方文档](https://www.postgresql.org/docs/11/runtime-config-logging.html){:target="_blank"}。

- PostgreSQL 采集器默认是未开启日志采集功能，可在 *conf.d/db/postgresql.conf* 中 将 `files` 打开，并写入 PostgreSQL 日志文件的绝对路径。比如：

```toml
[[inputs.postgresql]]

  ...

  [inputs.postgresql.log]
  files = ["/tmp/pgsql/postgresql.log"]
```

开启日志采集后，默认会产生日志来源（`source`）为 PostgreSQL 的日志。

> 注意：日志采集仅支持已安装 DataKit 主机上的日志。

### 日志 Pipeline 切割 {#pipeline}

原始日志为

``` log
2021-05-31 15:23:45.110 CST [74305] test [pgAdmin 4 - DB:postgres] postgres [127.0.0.1] 60b48f01.12241 LOG:  statement:
        SELECT psd.*, 2^31 - age(datfrozenxid) as wraparound, pg_database_size(psd.datname) as pg_database_size
        FROM pg_stat_database psd
        JOIN pg_database pd ON psd.datname = pd.datname
        WHERE psd.datname not ilike 'template%'   AND psd.datname not ilike 'rdsadmin'
        AND psd.datname not ilike 'azure_maintenance'   AND psd.datname not ilike 'postgres'
```

切割后的字段说明：

| 字段名             | 字段值                    | 说明                                                        |
| ---                | ---                       | ---                                                         |
| `application_name` | `pgAdmin 4 - DB:postgres` | 连接当前数据库的应用的名称                                  |
| `db_name`          | `test`                    | 访问的数据库                                                |
| `process_id`       | `74305`                   | 当前连接的客户端进程 ID                                     |
| `remote_host`      | `127.0.0.1`               | 客户端的地址                                                |
| `session_id`       | `60b48f01.12241`          | 当前会话的 ID                                               |
| `user`             | `postgres`                | 当前访问用户名                                              |
| `status`           | `LOG`                     | 当前日志的级别（LOG,ERROR,FATAL,PANIC,WARNING,NOTICE,INFO） |
| `time`             | `1622445825110000000`     | 日志产生时间                                                |

## FAQ {#faq}

<!-- markdownlint-disable MD013 -->
### :material-chat-question: 缺失指标 `postgresql_lock`, `postgresql_stat`, `postgresql_index`, `postgresql_size`, `postgresql_statio` {#faq-missing-relation-metrics}

这些指标上报，需要开启配置文件中的 `relations` 字段。如果这些指标存在部分缺失，可能是因为相关指标不存在数据导致的。

<!-- markdownlint-enable -->
