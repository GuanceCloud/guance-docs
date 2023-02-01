
# PostgreSQL
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "支持选举")

---

Postgresql collector can collect the running status index from Postgresql instance, and collect the index to Guance to help monitor and analyze various abnormal situations of Postgresql.

## Preconditions {#reqirement}

- Postgresql version >= 9.0

## Configuration {#config}

Go to the `conf.d/db` directory under the DataKit installation directory, copy `postgresql.conf.sample` and name it `postgresql.conf`. Examples are as follows:

```toml

[[inputs.postgresql]]
  ## 服务器地址
  # URI格式
  # postgres://[pqgotest[:password]]@localhost[/dbname]?sslmode=[disable|verify-ca|verify-full]
  # 简单字符串格式
  # host=localhost user=pqgotest password=... sslmode=... dbname=app_production

  address = "postgres://postgres@localhost/test?sslmode=disable"

  ## 配置采集的数据库，默认会采集所有的数据库，当同时设置ignored_databases和databases会忽略databases
  # ignored_databases = ["db1"]
  # databases = ["db1"]

  ## 设置服务器Tag，默认是基于服务器地址生成
  # outputaddress = "db01"

  ## 采集间隔
  # 单位 "ns", "us" (or "µs"), "ms", "s", "m", "h"
  interval = "10s"

  ## Set true to enable election
  election = true

  ## 日志采集
  # [inputs.postgresql.log]
  # files = []
  # pipeline = "postgresql.p"

  ## 自定义Tag
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


| Tag | Descrition |
|  ----  | --------|
|`db`|The database name|
|`server`|The server address|

- metric list


| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
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
|`database_size`|The disk space used by this database.|float|count|
|`deadlocks`|The number of deadlocks detected in this database.|int|count|
|`max_connections`|The maximum number of client connections allowed to this database.|float|count|
|`maxwritten_clean`|The number of times the background writer stopped a cleaning scan due to writing too many buffers.|int|count|
|`numbackends`|The number of active connections to this database.|int|count|
|`percent_usage_connections`|The number of connections to this database as a fraction of the maximum number of allowed connections.|float|count|
|`temp_bytes`|The amount of data written to temporary files by queries in this database.|int|count|
|`temp_files`|The number of temporary files created by queries in this database.|int|count|
|`tup_deleted`|The number of rows deleted by queries in this database.|int|count|
|`tup_fetched`|The number of rows fetched by queries in this database.|int|count|
|`tup_inserted`|The number of rows inserted by queries in this database.|int|count|
|`tup_returned`|The number of rows returned by queries in this database.|int|count|
|`tup_updated`|The number of rows updated by queries in this database.|int|count|
|`xact_commit`|The number of transactions that have been committed in this database.|int|count|
|`xact_rollback`|The number of transactions that have been rolled back in this database.|int|count|



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
