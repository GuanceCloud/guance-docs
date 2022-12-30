<!-- This file required to translate to EN. -->

# PostgreSQL
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "支持选举")

---

Postgresql 采集器可以从 Postgresql 实例中采集实例运行状态指标，并将指标采集到观测云，帮助监控分析 Postgresql 各种异常情况

## 前置条件 {#reqirement}

- Postgresql 版本 >= 9.0

## 配置 {#config}

进入 DataKit 安装目录下的 `conf.d/db` 目录，复制 `postgresql.conf.sample` 并命名为 `postgresql.conf`。示例如下：

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

配置好后，重启 DataKit 即可。

## 指标集 {#measurements}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[[inputs.postgresql.tags]]` 另择 host 来命名。



### `postgresql`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`db`|The database name|
|`server`|The server address|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
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



## 日志采集 {#logging}

- Postgresql 日志默认是输出至`stderr`，如需开启文件日志，可在 Postgresql 的配置文件 `/etc/postgresql/<VERSION>/main/postgresql.conf` ， 进行如下配置:

```
logging_collector = on    # 开启日志写入文件功能

log_directory = 'pg_log'  # 设置文件存放目录，绝对路径或相对路径(相对PGDATA)

log_filename = 'pg.log'   # 日志文件名称
log_statement = 'all'     # 记录所有查询

#log_duration = on
log_line_prefix= '%m [%p] %d [%a] %u [%h] %c ' # 日志行前缀
log_file_mode = 0644

# For Windows
#log_destination = 'eventlog'
```

更多配置，请参考[官方文档](https://www.postgresql.org/docs/11/runtime-config-logging.html){:target="_blank"}。

- Postgresql 采集器默认是未开启日志采集功能，可在 `conf.d/db/postgresql.conf` 中 将 `files` 打开，并写入 Postgresql 日志文件的绝对路径。比如:

```
[[inputs.postgresql]]

  ...

  [inputs.postgresql.log]
  files = ["/tmp/pgsql/postgresql.log"]
```

开启日志采集后，默认会产生日志来源(`source`)为`postgresql`的日志。

**注意**

- 日志采集仅支持已安装 DataKit 主机上的日志。

## 日志 pipeline 切割 {#pipeline}

原始日志为

```
2021-05-31 15:23:45.110 CST [74305] test [pgAdmin 4 - DB:postgres] postgres [127.0.0.1] 60b48f01.12241 LOG:  statement:
		SELECT psd.*, 2^31 - age(datfrozenxid) as wraparound, pg_database_size(psd.datname) as pg_database_size
		FROM pg_stat_database psd
		JOIN pg_database pd ON psd.datname = pd.datname
		WHERE psd.datname not ilike 'template%'   AND psd.datname not ilike 'rdsadmin'
		AND psd.datname not ilike 'azure_maintenance'   AND psd.datname not ilike 'postgres'
```

切割后的字段说明：

| 字段名           | 字段值                  | 说明                                                      |
| ---              | ---                     | ---                                                       |
| application_name | pgAdmin 4 - DB:postgres | 连接当前数据库的应用的名称                                |
| db_name          | test                    | 访问的数据库                                              |
| process_id       | 74305                   | 当前连接的客户端进程ID                                    |
| remote_host      | 127.0.0.1               | 客户端的地址                                              |
| session_id       | 60b48f01.12241          | 当前会话的ID                                              |
| user             | postgres                | 当前访问用户名                                            |
| status           | LOG                     | 当前日志的级别(LOG,ERROR,FATAL,PANIC,WARNING,NOTICE,INFO) |
| time             | 1622445825110000000     | 日志产生时间                                              |
