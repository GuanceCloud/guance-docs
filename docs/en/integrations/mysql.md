---
title     : 'MySQL'
summary   : 'Collect MySQL Metrics data'
tags:
  - 'DATABASE'
__int_icon      : 'icon/mysql'
dashboard :
  - desc  : 'MySQL'
    path  : 'dashboard/en/mysql'
monitor   :
  - desc  : 'MySQL'
    path  : 'monitor/en/mysql'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

MySQL metrics collection, collecting the following data:

- Basic data collection of MySQL Global Status
- Schema related data
- InnoDB related metrics
- Support custom query data collection

## Configuration {#config}

### Prerequisites {#requirements}

- MySQL version 5.7+
- Create a monitoring account (in most cases, need to log in with the MySQL `root` account to create a MySQL user)

```sql
CREATE USER 'datakit'@'localhost' IDENTIFIED BY '<UNIQUEPASSWORD>';

-- MySQL 8.0+ create the datakit user with the caching_sha2_password method
CREATE USER 'datakit'@'localhost' IDENTIFIED WITH caching_sha2_password by '<UNIQUEPASSWORD>';
```

- Authorization

```sql
GRANT PROCESS ON *.* TO 'datakit'@'localhost';
GRANT SELECT ON *.* TO 'datakit'@'localhost';
show databases like 'performance_schema';
GRANT SELECT ON performance_schema.* TO 'datakit'@'localhost';
GRANT SELECT ON mysql.user TO 'datakit'@'localhost';
GRANT replication client on *.*  to 'datakit'@'localhost';
```

<!-- markdownlint-disable MD046 -->
???+ attention

    - If you encounter the following error when using `localhost`, replace `localhost` with `::1` in the steps above<br/>
    `Error 1045: Access denied for user 'datakit'@'localhost' (using password: YES)`

    - The above creation and authorization operations are limited to the `datakit` user who can only access MySQL on the MySQL host (`localhost`). If remote collection is required, replace `localhost` with `%` (indicating that DataKit can access MySQL from any machine), or use a specific DataKit installation machine address.
<!-- markdownlint-enable -->

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Go to the `conf.d/db` directory under the DataKit installation directory, copy `mysql.conf.sample` and rename it as `mysql.conf`. Example as follows:
    
    ```toml
        
    [[inputs.mysql]]
      host = "localhost"
      user = "datakit"
      pass = "<PASS>"
      port = 3306
      # sock = "<SOCK>"
      # charset = "utf8"
    
      ## @param connect_timeout - number - optional - default: 10s
      # connect_timeout = "10s"
    
      ## Deprecated
      # service = "<SERVICE>"
    
      interval = "10s"
    
      ## @param inno_db
      innodb = true
    
      ## table_schema
      tables = []
    
      ## user
      users = []
    
      ## Set replication to true to collect replication metrics
      # replication = false
      ## Set group_replication to true to collect group replication metrics
      # group_replication = false
    
      ## Set dbm to true to collect database activity 
      # dbm = false
    
      ## Set true to enable election
      election = true
    
      [inputs.mysql.log]
        # #required, glob logfiles
        # files = ["/var/log/mysql/*.log"]
    
        ## glob filteer
        # ignore = [""]
    
        ## optional encodings:
        ## "utf-8", "utf-16le", "utf-16le", "gbk", "gb18030" or ""
        # character_encoding = ""
    
        ## The pattern should be a regexp. Note the use of '''this regexp'''
        ## regexp link: https://golang.org/pkg/regexp/syntax/#hdr-Syntax
        multiline_match = '''^(# Time|\d{4}-\d{2}-\d{2}|\d{6}\s+\d{2}:\d{2}:\d{2}).*'''
    
        ## grok pipeline script path
        pipeline = "mysql.p"
    
      ## Run a custom SQL query and collect corresponding metrics.
      # [[inputs.mysql.custom_queries]]
      #   sql = '''
      #     select ENGINE as engine,TABLE_SCHEMA as table_schema,count(*) as table_count 
      #     from information_schema.tables 
      #     group by engine,table_schema
      #   '''
      #   metric = "mysql_custom"
      #   tags = ["engine", "table_schema"]
      #   fields = ["table_count"] 
    
      ## Config dbm metric 
      [inputs.mysql.dbm_metric]
        enabled = true
      
      ## Config dbm sample 
      [inputs.mysql.dbm_sample]
        enabled = true  
    
      ## Config dbm activity
      [inputs.mysql.dbm_activity]
        enabled = true  
    
      ## TLS Config
      # [inputs.mysql.tls]
        # tls_ca = "/etc/mysql/ca.pem"
        # tls_cert = "/etc/mysql/cert.pem"
        # tls_key = "/etc/mysql/key.pem"
    
        ## Use TLS but skip chain & host verification
        # insecure_skip_verify = true
    
        ## by default, support TLS 1.2 and above.
        ## set to true if server side uses TLS 1.0 or TLS 1.1
        # allow_tls10 = false
    
      [inputs.mysql.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
    ```

    After configuration, simply [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector via [ConfigMap injection](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

---

### Binlog Activation {#binlog}

By default, MySQL Binlog is not activated. To count the size of Binlog, you need to activate the corresponding Binlog feature in MySQL:

```sql
-- ON: turn on, OFF: turn off
SHOW VARIABLES LIKE 'log_bin';
```

To activate Binlog, refer to [this Q&A](https://stackoverflow.com/questions/40682381/how-do-i-enable-mysql-binary-logging){:target="_blank"} or [this Q&A](https://serverfault.com/questions/706699/enable-binlog-in-mysql-on-ubuntu){:target="_blank"}

### Database Performance Metrics Collection {#performance-schema}

Database performance metrics mainly come from MySQL's built-in `performance_schema`, which provides a way to obtain internal execution details of the server at runtime. Through this database, DataKit can collect various statistical metrics of historical queries and the execution plans of query statements, as well as other related performance metrics. The collected performance metrics data is saved as logs with sources being `mysql_dbm_metric`, `mysql_dbm_sample`, and `mysql_dbm_activity`.

To activate this, follow these steps.

- Modify the configuration file to activate the monitoring collection

```toml
[[inputs.mysql]]

# Turn on database performance metric collection
dbm = true

...

# Monitor metric configuration
[inputs.mysql.dbm_metric]
  enabled = true

# Monitor sampling configuration
[inputs.mysql.dbm_sample]
  enabled = true

# Waiting for event collection
[inputs.mysql.dbm_activity]
  enabled = true   
...

```

- MySQL Configuration

Modify the configuration file (such as `mysql.conf`), open the `MySQL Performance Schema`, and configure the parameters:

```toml
[mysqld]
performance_schema = on
max_digest_length = 4096
performance_schema_max_digest_length = 4096
performance_schema_max_sql_text_length = 4096
performance-schema-consumer-events-statements-current = on
performance-schema-consumer-events-waits-current = on
performance-schema-consumer-events-statements-history-long = on
performance-schema-consumer-events-statements-history = on

```

- Account Configuration

Account authorization

```sql
-- MySQL 5.6 & 5.7
GRANT REPLICATION CLIENT ON *.* TO datakit@'%' WITH MAX_USER_CONNECTIONS 5;
GRANT PROCESS ON *.* TO datakit@'%';

-- MySQL >= 8.0
ALTER USER datakit@'%' WITH MAX_USER_CONNECTIONS 5;
GRANT REPLICATION CLIENT ON *.* TO datakit@'%';
GRANT PROCESS ON *.* TO datakit@'%';
```

Create database

```sql
CREATE SCHEMA IF NOT EXISTS datakit;
GRANT EXECUTE ON datakit.* to datakit@'%';
GRANT CREATE TEMPORARY TABLES ON datakit.* TO datakit@'%';
```

Create stored procedure `explain_statement` to get SQL execution plan

```sql
DELIMITER $$
CREATE PROCEDURE datakit.explain_statement(IN query TEXT)
    SQL SECURITY DEFINER
BEGIN
    SET @explain := CONCAT('EXPLAIN FORMAT=json ', query);
    PREPARE stmt FROM @explain;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END $$
DELIMITER ;
```

Create separate stored procedures for databases requiring execution plan collection (optional)

```sql
DELIMITER $$
CREATE PROCEDURE <database_name>.explain_statement(IN query TEXT)
    SQL SECURITY DEFINER
BEGIN
    SET @explain := CONCAT('EXPLAIN FORMAT=json ', query);
    PREPARE stmt FROM @explain;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END $$
DELIMITER ;
GRANT EXECUTE ON PROCEDURE <database_name>.explain_statement TO datakit@'%';
```

- `consumers` Configuration

Method one (recommended): Dynamically configure `performance_schema.events_*` through `DataKit`, creating the following stored procedure:

```sql
DELIMITER $$
CREATE PROCEDURE datakit.enable_events_statements_consumers()
    SQL SECURITY DEFINER
BEGIN
    UPDATE performance_schema.setup_consumers SET enabled='YES' WHERE name LIKE 'events_statements_%';
    UPDATE performance_schema.setup_consumers SET enabled='YES' WHERE name = 'events_waits_current';
END $$
DELIMITER ;

GRANT EXECUTE ON PROCEDURE datakit.enable_events_statements_consumers TO datakit@'%';
```

Method two: Manually configure `consumers`

```sql
UPDATE performance_schema.setup_consumers SET enabled='YES' WHERE name LIKE 'events_statements_%';
UPDATE performance_schema.setup_consumers SET enabled='YES' WHERE name = 'events_waits_current';
```

### Master-Slave Replication Metrics Collection {#replication_metrics}

The prerequisite for collecting `mysql_replication` metrics is enabling master-slave replication. All `mysql_replication` metrics are collected from the slave database. You can check whether the master-slave replication environment is normal by entering the following command on the slave database:

```sql
SHOW SLAVE STATUS;
```

If both `Replica_IO_Running` and `Replica_SQL_Running` values are Yes, it indicates that the master-slave replication environment status is normal.

To collect group replication metrics such as `count_transactions_in_queue`, you need to add the group replication plugin to the list of plugins loaded at startup (group_replication is supported starting from MySQL version 5.7.17). Add the following line to the configuration file `/etc/my.cnf` on the slave database:

```toml
plugin_load_add ='group_replication.so'
```

You can confirm that the group replication plugin has been installed by running `show plugins;`.

To activate this, follow these steps.

- Modify the configuration file to activate the monitoring collection

```toml
[[inputs.mysql]]

  ## Set replication to true to collect replication metrics
  replication = true
  ## Set group_replication to true to collect group replication metrics
  group_replication = true  
  ...

```

## Metrics {#metric}

All the data collected below will append global election tags by default. You can also specify additional tags via `[inputs.mysql.tags]` in the configuration:

```toml
 [inputs.mysql.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

<!-- markdownlint-disable MD024 -->




### `mysql`



- Tags


| Tag | Description |
|  ----  | --------|
|`host`|The server host address|
|`server`|Server addr|

- Field List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`Aborted_clients`|The number of connections that were aborted because the client died without closing the connection properly.|int|count|
|`Aborted_connects`|The number of failed attempts to connect to the MySQL server.|int|count|
|`Binlog_cache_disk_use`|The number of transactions that used the temporary binary log cache but that exceeded the value of binlog_cache_size and used a temporary file to store statements from the transaction.|int|B|
|`Binlog_cache_use`|The number of transactions that used the binary log cache.|int|B|
|`Binlog_space_usage_bytes`|Total binary log file size.|int|B|
|`Bytes_received`|The number of bytes received from all clients.|int|B|
|`Bytes_sent`|The number of bytes sent to all clients.|int|B|
|`Com_commit`|The number of times of commit statement has been executed.|int|count|
|`Com_delete`|The number of times of delete statement has been executed.|int|count|
|`Com_delete_multi`|The number of times of delete-multi statement has been executed.|int|count|
|`Com_insert`|The number of times of insert statement has been executed.|int|count|
|`Com_insert_select`|The number of times of insert-select statement has been executed.|int|count|
|`Com_load`|The number of times of load statement has been executed.|int|count|
|`Com_replace`|The number of times of replace statement has been executed.|int|count|
|`Com_replace_select`|The number of times of replace-select statement has been executed.|int|count|
|`Com_rollback`|The number of times of rollback statement has been executed.|int|count|
|`Com_select`|The number of times of select statement has been executed.|int|count|
|`Com_update`|The number of times of update statement has been executed.|int|count|
|`Com_update_multi`|The number of times of update-mult has been executed.|int|count|
|`Connections`|The rate of connections to the server.|int|count|
|`Created_tmp_disk_tables`|The rate of internal on-disk temporary tables created by second by the server while executing statements.|int|count|
|`Created_tmp_files`|The rate of temporary files created by second.|int|count|
|`Created_tmp_tables`|The rate of internal temporary tables created by second by the server while executing statements.|int|count|
|`Handler_commit`|The number of internal COMMIT statements.|int|count|
|`Handler_delete`|The number of internal DELETE statements.|int|count|
|`Handler_prepare`|The number of internal PREPARE statements.|int|count|
|`Handler_read_first`|The number of internal READ_FIRST statements.|int|count|
|`Handler_read_key`|The number of internal READ_KEY statements.|int|count|
|`Handler_read_next`|The number of internal READ_NEXT statements.|int|count|
|`Handler_read_prev`|The number of internal READ_PREV statements.|int|count|
|`Handler_read_rnd`|The number of internal READ_RND statements.|int|count|
|`Handler_read_rnd_next`|The number of internal READ_RND_NEXT statements.|int|count|
|`Handler_rollback`|The number of internal ROLLBACK statements.|int|count|
|`Handler_update`|The number of internal UPDATE statements.|int|count|
|`Handler_write`|The number of internal WRITE statements.|int|count|
|`Key_buffer_bytes_unflushed`|MyISAM key buffer bytes unflushed.|int|count|
|`Key_buffer_bytes_used`|MyISAM key buffer bytes used.|int|count|
|`Key_buffer_size`|Size of the buffer used for index blocks.|int|B|
|`Key_cache_utilization`|The key cache utilization ratio.|int|percent|
|`Key_read_requests`|The number of requests to read a key block from the MyISAM key cache.|int|count|
|`Key_reads`|The number of physical reads of a key block from disk into the MyISAM key cache. If Key_reads is large, then your key_buffer_size value is probably too small. The cache miss rate can be calculated as Key_reads/Key_read_requests.|int|count|
|`Key_write_requests`|The number of requests to write a key block to the MyISAM key cache.|int|count|
|`Key_writes`|The number of physical writes of a key block from the MyISAM key cache to disk.|int|count|
|`Max_used_connections`|The maximum number of connections that have been in use simultaneously since the server started.|int|count|
|`Mysqlx_ssl_ctx_verify_depth`||int|-|
|`Open_files`|The number of open files.|int|count|
|`Open_tables`|The number of of tables that are open.|int|count|
|`Opened_tables`|The number of tables that have been opened. If Opened_tables is big, your table_open_cache value is probably too small.|int|count|
|`Qcache_free_blocks`|The number of free memory blocks in the query cache.|int|B|
|`Qcache_free_memory`|The amount of free memory for the query cache.|int|B|
|`Qcache_hits`|The rate of query cache hits.|int|count|
|`Qcache_inserts`|The number of queries added to the query cache.|int|count|
|`Qcache_lowmem_prunes`|The number of queries that were deleted from the query cache because of low memory.|int|count|
|`Qcache_not_cached`|The number of noncached queries (not cacheable, or not cached due to the query_cache_type setting).|int|count|
|`Qcache_queries_in_cache`|The number of queries registered in the query cache.|int|count|
|`Qcache_total_blocks`|The total number of blocks in the query cache.|int|count|
|`Queries`|The rate of queries.|int|count|
|`Questions`|The rate of statements executed by the server.|int|count|
|`Select_full_join`|The number of joins that perform table scans because they do not use indexes. If this value is not 0, you should carefully check the indexes of your tables.|int|count|
|`Select_full_range_join`|The number of joins that used a range search on a reference table.|int|count|
|`Select_range`|The number of joins that used ranges on the first table. This is normally not a critical issue even if the value is quite large.|int|count|
|`Select_range_check`|The number of joins without keys that check for key usage after each row. If this is not 0, you should carefully check the indexes of your tables.|int|count|
|`Select_scan`|The number of joins that did a full scan of the first table.|int|count|
|`Slow_queries`|The rate of slow queries.|int|count|
|`Sort_merge_passes`|The number of merge passes that the sort algorithm has had to do. If this value is large, you should consider increasing the value of the sort_buffer_size system variable.|int|count|
|`Sort_range`|The number of sorts that were done using ranges.|int|count|
|`Sort_rows`|The number of sorted rows.|int|count|
|`Sort_scan`|The number of sorts that were done by scanning the table.|int|count|
|`Ssl_ctx_verify_depth`||int|-|
|`Table_locks_immediate`|The number of times that a request for a table lock could be granted immediately.|int|count|
|`Table_locks_waited`|The total number of times that a request for a table lock could not be granted immediately and a wait was needed.|int|count|
|`Threads_cached`|The number of threads in the thread cache.|int|count|
|`Threads_connected`|The number of currently open connections.|int|count|
|`Threads_created`|The number of threads created to handle connections. If Threads_created is big, you may want to increase the thread_cache_size value.|int|count|
|`Threads_running`|The number of threads that are not sleeping.|int|count|
|`connection_memory_limit`||int|B|
|`global_connection_memory_limit`||int|B|
|`max_connections`|The maximum number of connections that have been in use simultaneously since the server started.|int|count|
|`max_join_size`||int|count|
|`max_seeks_for_key`||int|count|
|`max_write_lock_count`||int|-|
|`myisam_mmap_size`||int|B|
|`parser_max_mem_size`||int|B|
|`query_cache_size`|The amount of memory allocated for caching query results.|int|B|
|`sql_select_limit`||int|-|
|`table_open_cache`|The number of open tables for all threads. Increasing this value increases the number of file descriptors that mysqld requires.|int|count|
|`thread_cache_size`|How many threads the server should cache for reuse. When a client disconnects, the client's threads are put in the cache if there are fewer than thread_cache_size threads there.|int|B|






### `mysql_replication`



- Tags


| Tag | Description |
|  ----  | --------|
|`host`|The server host address|
|`server`|Server addr|

- Field List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`Auto_Position`|1 if auto-positioning is in use; otherwise 0.|bool|count|
|`Connect_Retry:`|The number of seconds between connect retries (default 60). This can be set with the CHANGE MASTER TO statement.|int|count|
|`Exec_Master_Log_Pos`|The position in the current source binary log file to which the SQL thread has read and executed, marking the start of the next transaction or event to be processed.|int|count|
|`Last_Errno`|These columns are aliases for Last_SQL_Errno|int|count|
|`Last_IO_Errno`|The error number of the most recent error that caused the I/O thread to stop. An error number of 0 and message of the empty string mean “no error.”|int|count|
|`Last_SQL_Errno`|The error number of the most recent error that caused the SQL thread to stop. An error number of 0 and message of the empty string mean “no error.”|int|count|
|`Master_Server_Id`|The server_id value from the source.|int|count|
|`Relay_Log_Space`|The total combined size of all existing relay log files.|int|count|
|`Replicas_connected`|Number of replicas connected to a replication source.|int|count|
|`SQL_Delay`|The number of seconds that the replica must lag the source.|int|count|
|`Seconds_Behind_Master`|The lag in seconds between the master and the slave.|int|count|
|`Skip_Counter`|The current value of the sql_slave_skip_counter system variable.|int|count|
|`Slave_IO_Running`|Whether the I/O thread is started and has connected successfully to the source. 1 if the state is Yes, 0 if the state is No.|bool|count|
|`Slave_SQL_Running`|Whether the SQL thread is started. 1 if the state is Yes, 0 if the state is No.|bool|count|
|`count_conflicts_detected`|The number of transactions that have not passed the conflict detection check. Collected as group replication metric.|int|count|
|`count_transactions_checked`|The number of transactions that have been checked for conflicts. Collected as group replication metric.|int|count|
|`count_transactions_in_queue`|The number of transactions in the queue pending conflict detection checks. Collected as group replication metric.|int|count|
|`count_transactions_local_proposed`|The number of transactions which originated on this member and were sent to the group. Collected as group replication metric.|int|count|
|`count_transactions_local_rollback`|The number of transactions which originated on this member and were rolled back by the group. Collected as group replication metric.|int|count|
|`count_transactions_remote_applied`|The number of transactions this member has received from the group and applied. Collected as group replication metric.|int|count|
|`count_transactions_remote_in_applier_queue`|The number of transactions that this member has received from the replication group which are waiting to be applied. Collected as group replication metric.|int|count|
|`count_transactions_rows_validating`|The number of transaction rows which can be used for certification, but have not been garbage collected. Collected as group replication metric.|int|count|






### `mysql_schema`

MySQL schema information

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|The server host address|
|`schema_name`|Schema name|
|`server`|Server addr|

- Field List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`query_run_time_avg`|Avg query response time per schema.|float|ns|
|`schema_size`|Size of schemas(MiB)|float|MB|






### `mysql_innodb`



- Tags


| Tag | Description |
|  ----  | --------|
|`host`|The server host address|
|`server`|Server addr|

- Field List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :---: |
|`active_transactions`|The number of active transactions on InnoDB tables|int|count|
|`adaptive_hash_searches`|Number of successful searches using Adaptive Hash Index|int|count|
|`adaptive_hash_searches_btree`|Number of searches using B-tree on an index search|int|count|
|`buffer_data_reads`|Amount of data read in bytes (innodb_data_reads)|int|count|
|`buffer_data_written`|Amount of data written in bytes (innodb_data_written)|int|count|
|`buffer_pages_created`|Number of pages created (innodb_pages_created)|int|count|
|`buffer_pages_read`|Number of pages read (innodb_pages_read)|int|count|
|`buffer_pages_written`|Number of pages written (innodb_pages_written)|int|count|
|`buffer_pool_bytes_data`|The total number of bytes in the InnoDB buffer pool containing data. The number includes both dirty and clean pages.|int|B|
|`buffer_pool_bytes_dirty`|Buffer bytes containing data (innodb_buffer_pool_bytes_data)|int|count|
|`buffer_pool_pages_data`|Buffer pages containing data (innodb_buffer_pool_pages_data)|int|count|
|`buffer_pool_pages_dirty`|Buffer pages currently dirty (innodb_buffer_pool_pages_dirty)|int|count|
|`buffer_pool_pages_flushed`|The number of requests to flush pages from the InnoDB buffer pool|int|count|
|`buffer_pool_pages_free`|Buffer pages currently free (innodb_buffer_pool_pages_free)|int|count|
|`buffer_pool_pages_misc`|Buffer pages for misc use such as row locks or the adaptive hash index (innodb_buffer_pool_pages_misc)|int|count|
|`buffer_pool_pages_total`|Total buffer pool size in pages (innodb_buffer_pool_pages_total)|int|count|
|`buffer_pool_read_ahead`|Number of pages read as read ahead (innodb_buffer_pool_read_ahead)|int|count|
|`buffer_pool_read_ahead_evicted`|Read-ahead pages evicted without being accessed (innodb_buffer_pool_read_ahead_evicted)|int|count|
|`buffer_pool_read_ahead_rnd`|The number of random `read-aheads` initiated by InnoDB. This happens when a query scans a large portion of a table but in random order.|int|count|
|`buffer_pool_read_requests`|Number of logical read requests (innodb_buffer_pool_read_requests)|int|count|
|`buffer_pool_reads`|Number of reads directly from disk (innodb_buffer_pool_reads)|int|count|
|`buffer_pool_size`|Server buffer pool size (all buffer pools) in bytes|int|count|
|`buffer_pool_wait_free`|Number of times waited for free buffer (innodb_buffer_pool_wait_free)|int|count|
|`buffer_pool_write_requests`|Number of write requests (innodb_buffer_pool_write_requests)|int|count|
|`checkpoint_age`|Checkpoint age as shown in the LOG section of the `SHOW ENGINE INNODB STATUS` output|int|count|
|`current_transactions`|Current `InnoDB` transactions|int|count|
|`data_fsyncs`|The number of fsync() operations per second.|int|count|
|`data_pending_fsyncs`|The current number of pending fsync() operations.|int|count|
|`data_pending_reads`|The current number of pending reads.|int|count|
|`data_pending_writes`|The current number of pending writes.|int|count|
|`data_read`|The amount of data read per second.|int|B|
|`data_written`|The amount of data written per second.|int|B|
|`dblwr_pages_written`|The number of pages written per second to the `doublewrite` buffer.|int|count|
|`dblwr_writes`|The number of `doublewrite` operations performed per second.|int|B|
|`dml_deletes`|Number of rows deleted|int|count|
|`dml_inserts`|Number of rows inserted|int|count|
|`dml_updates`|Number of rows updated|int|count|
|`file_num_open_files`|Number of files currently open (innodb_num_open_files)|int|count|
|`hash_index_cells_total`|Total number of cells of the adaptive hash index|int|count|
|`hash_index_cells_used`|Number of used cells of the adaptive hash index|int|count|
|`history_list_length`|History list length as shown in the TRANSACTIONS section of the `SHOW ENGINE INNODB STATUS` output.|int|count|
|`ibuf_free_list`|Insert buffer free list, as shown in the INSERT BUFFER AND ADAPTIVE HASH INDEX section of the `SHOW ENGINE INNODB STATUS` output.|int|count|
|`ibuf_merged`|Insert buffer and `adaptative` hash index merged|int|count|
|`ibuf_merged_delete_marks`|Insert buffer and `adaptative` hash index merged delete marks|int|count|
|`ibuf_merged_deletes`|Insert buffer and `adaptative` hash index merged delete|int|count|
|`ibuf_merged_inserts`|Insert buffer and `adaptative` hash index merged inserts|int|count|
|`ibuf_merges`|Number of change buffer merges|int|count|
|`ibuf_merges_delete`|Number of purge records merged by change buffering|int|count|
|`ibuf_merges_delete_mark`|Number of deleted records merged by change buffering|int|count|
|`ibuf_merges_discard_delete`|Number of purge merged  operations discarded|int|count|
|`ibuf_merges_discard_delete_mark`|Number of deleted merged operations discarded|int|count|
|`ibuf_merges_discard_insert`|Number of insert merged operations discarded|int|count|
|`ibuf_merges_insert`|Number of inserted records merged by change buffering|int|count|
|`ibuf_size`|Change buffer size in pages|int|count|
|`innodb_activity_count`|Current server activity count|int|count|
|`innodb_dblwr_pages_written`|Number of pages that have been written for `doublewrite` operations (innodb_dblwr_pages_written)|int|count|
|`innodb_dblwr_writes`|Number of `doublewrite` operations that have been performed (innodb_dblwr_writes)|int|count|
|`innodb_page_size`|InnoDB page size in bytes (innodb_page_size)|int|count|
|`innodb_rwlock_s_os_waits`|Number of OS waits due to shared latch request|int|count|
|`innodb_rwlock_s_spin_rounds`|Number of rwlock spin loop rounds due to shared latch request|int|count|
|`innodb_rwlock_s_spin_waits`|Number of rwlock spin waits due to shared latch request|int|count|
|`innodb_rwlock_sx_os_waits`|Number of OS waits due to sx latch request|int|count|
|`innodb_rwlock_sx_spin_rounds`|Number of rwlock spin loop rounds due to sx latch request|int|count|
|`innodb_rwlock_sx_spin_waits`|Number of rwlock spin waits due to sx latch request|int|count|
|`innodb_rwlock_x_os_waits`|Number of OS waits due to exclusive latch request|int|count|
|`innodb_rwlock_x_spin_rounds`|Number of rwlock spin loop rounds due to exclusive latch request|int|count|
|`innodb_rwlock_x_spin_waits`|Number of rwlock spin waits due to exclusive latch request|int|count|
|`lock_deadlocks`|Number of deadlocks|int|count|
|`lock_row_lock_current_waits`|Number of row locks currently being waited for (innodb_row_lock_current_waits)|int|count|
|`lock_row_lock_time`|Time spent in acquiring row locks, in milliseconds (innodb_row_lock_time)|int|ms|
|`lock_row_lock_time_avg`|The average time to acquire a row lock, in milliseconds (innodb_row_lock_time_avg)|int|ms|
|`lock_row_lock_time_max`|The maximum time to acquire a row lock, in milliseconds (innodb_row_lock_time_max)|int|ms|
|`lock_row_lock_waits`|Number of times a row lock had to be waited for (innodb_row_lock_waits)|int|count|
|`lock_structs`|Lock `structs`|int|count|
|`lock_timeouts`|Number of lock timeouts|int|count|
|`locked_tables`|Locked tables|int|count|
|`locked_transactions`|Locked transactions|int|count|
|`log_padded`|Bytes of log padded for log write ahead|int|count|
|`log_waits`|Number of log waits due to small log buffer (innodb_log_waits)|int|count|
|`log_write_requests`|Number of log write requests (innodb_log_write_requests)|int|count|
|`log_writes`|Number of log writes (innodb_log_writes)|int|count|
|`lsn_current`|Log sequence number as shown in the LOG section of the `SHOW ENGINE INNODB STATUS` output.|int|count|
|`lsn_flushed`|Flushed up to log sequence number as shown in the LOG section of the `SHOW ENGINE INNODB STATUS` output.|int|count|
|`lsn_last_checkpoint`|Log sequence number last checkpoint as shown in the LOG section of the `SHOW ENGINE INNODB STATUS` output.|int|count|
|`mem_adaptive_hash`|As shown in the BUFFER POOL AND MEMORY section of the `SHOW ENGINE INNODB STATUS` output.|int|B|
|`mem_additional_pool`|As shown in the BUFFER POOL AND MEMORY section of the `SHOW ENGINE INNODB STATUS` output.|int|B|
|`mem_dictionary`|As shown in the BUFFER POOL AND MEMORY section of the `SHOW ENGINE INNODB STATUS` output.|int|B|
|`mem_file_system`|As shown in the BUFFER POOL AND MEMORY section of the `SHOW ENGINE INNODB STATUS` output.|int|B|
|`mem_lock_system`|As shown in the BUFFER POOL AND MEMORY section of the `SHOW ENGINE INNODB STATUS` output.|int|count|
|`mem_page_hash`|As shown in the BUFFER POOL AND MEMORY section of the `SHOW ENGINE INNODB STATUS` output.|int|count|
|`mem_recovery_system`|As shown in the BUFFER POOL AND MEMORY section of the `SHOW ENGINE INNODB STATUS` output.|int|count|
|`mem_thread_hash`|As shown in the BUFFER POOL AND MEMORY section of the `SHOW ENGINE INNODB STATUS` output.|int|count|
|`mem_total`|As shown in the BUFFER POOL AND MEMORY section of the `SHOW ENGINE INNODB STATUS` output.|int|count|
|`os_data_fsyncs`|Number of fsync() calls (innodb_data_fsyncs)|int|count|
|`os_data_reads`|Number of reads initiated (innodb_data_reads)|int|count|
|`os_data_writes`|Number of writes initiated (innodb_data_writes)|int|count|
|`os_file_fsyncs`|(Delta) The total number of fsync() operations performed by InnoDB.|int|count|
|`os_file_reads`|(Delta) The total number of files reads performed by read threads within InnoDB.|int|count|
|`os_file_writes`|(Delta) The total number of file writes performed by write threads within InnoDB.|int|count|
|`os_log_bytes_written`|Bytes of log written (innodb_os_log_written)|int|count|
|`os_log_fsyncs`|Number of fsync log writes (innodb_os_log_fsyncs)|int|count|
|`os_log_pending_fsyncs`|Number of pending fsync write (innodb_os_log_pending_fsyncs)|int|count|
|`os_log_pending_writes`|Number of pending log file writes (innodb_os_log_pending_writes)|int|count|
|`os_log_written`|Number of bytes written to the InnoDB log.|int|B|
|`pages_created`|Number of InnoDB pages created.|int|count|
|`pages_read`|Number of InnoDB pages read.|int|count|
|`pages_written`|Number of InnoDB pages written.|int|count|
|`pending_aio_log_ios`|As shown in the FILE I/O section of the `SHOW ENGINE INNODB STATUS` output.|int|count|
|`pending_aio_sync_ios`|As shown in the FILE I/O section of the `SHOW ENGINE INNODB STATUS` output.|int|count|
|`pending_buffer_pool_flushes`|As shown in the FILE I/O section of the `SHOW ENGINE INNODB STATUS` output.|int|count|
|`pending_checkpoint_writes`|As shown in the FILE I/O section of the `SHOW ENGINE INNODB STATUS` output.|int|count|
|`pending_ibuf_aio_reads`|As shown in the FILE I/O section of the `SHOW ENGINE INNODB STATUS` output.|int|count|
|`pending_log_flushes`|As shown in the FILE I/O section of the `SHOW ENGINE INNODB STATUS` output.|int|count|
|`pending_log_writes`|As shown in the FILE I/O section of the `SHOW ENGINE INNODB STATUS` output.|int|count|
|`pending_normal_aio_reads`|As shown in the FILE I/O section of the `SHOW ENGINE INNODB STATUS` output.|int|count|
|`pending_normal_aio_writes`|As shown in the FILE I/O section of the `SHOW ENGINE INNODB STATUS` output.|int|count|
|`queries_inside`|As shown in the FILE I/O section of the `SHOW ENGINE INNODB STATUS` output.|int|count|
|`queries_queued`|As shown in the FILE I/O section of the `SHOW ENGINE INNODB STATUS` output.|int|count|
|`read_views`|As shown in the FILE I/O section of the `SHOW ENGINE INNODB STATUS` output.|int|count|
|`rows_deleted`|Number of rows deleted from InnoDB tables.|int|count|
|`rows_inserted`|Number of rows inserted into InnoDB tables.|int|count|
|`rows_read`|Number of rows read from InnoDB tables.|int|count|
|`rows_updated`|Number of rows updated in InnoDB tables.|int|count|
|`s_lock_os_waits`|As shown in the SEMAPHORES section of the `SHOW ENGINE INNODB STATUS` output|int|count|
|`s_lock_spin_rounds`|As shown in the SEMAPHORES section of the `SHOW ENGINE INNODB STATUS` output.|int|count|
|`s_lock_spin_waits`|As shown in the SEMAPHORES section of the `SHOW ENGINE INNODB STATUS` output.|int|count|
|`semaphore_wait_time`|Semaphore wait time|int|count|
|`semaphore_waits`|The number semaphore currently being waited for by operations on InnoDB tables.|int|count|
|`tables_in_use`|Tables in use|int|count|
|`trx_rseg_history_len`|Length of the TRX_RSEG_HISTORY list|int|count|
|`x_lock_os_waits`|As shown in the SEMAPHORES section of the `SHOW ENGINE INNODB STATUS` output.|int|count|
|`x_lock_spin_rounds`|As shown in the SEMAPHORES section of the `SHOW ENGINE INNODB STATUS` output.|int|count|
|`x_lock_spin_waits`|As shown in the SEMAPHORES section of the `SHOW ENGINE INNODB STATUS` output.|int|count|






### `mysql_table_schema`

MySQL table information

- Tags


| Tag | Description |
|  ----  | --------|
|`engine`|The storage engine for the table. See The InnoDB Storage Engine, and Alternative Storage Engines.|
|`host`|The server host address|
|`server`|Server addr|
|`table_name`|The name of the table.|
|`table_schema`|The name of the schema (database) to which the table belongs.|
|`table_type`|BASE TABLE for a table, VIEW for a view, or SYSTEM VIEW for an INFORMATION_SCHEMA table.|
|`version`|The version number of the table's .frm file.|

- Field List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`data_free`|The number of rows. Some storage engines, such as MyISAM, store the exact count. For other storage engines, such as InnoDB, this value is an approximation, and may vary from the actual value by as much as 40% to 50%. In such cases, use SELECT COUNT(*) to obtain an accurate count.|int|count|
|`data_length`|For InnoDB, DATA_LENGTH is the approximate amount of space allocated for the clustered index, in bytes. Specifically, it is the clustered index size, in pages, multiplied by the InnoDB page size|int|count|
|`index_length`|For InnoDB, INDEX_LENGTH is the approximate amount of space allocated for non-clustered indexes, in bytes. Specifically, it is the sum of non-clustered index sizes, in pages, multiplied by the InnoDB page size|int|count|
|`table_rows`|The number of rows. Some storage engines, such as MyISAM, store the exact count. For other storage engines, such as InnoDB, this value is an approximation, and may vary from the actual value by as much as 40% to 50%. In such cases, use SELECT COUNT(*) to obtain an accurate count.|int|count|






### `mysql_user_status`

MySQL user information

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|The server host address|
|`server`|The server address containing both host and port|
|`user`|user|

- Field List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`bytes_received`|The number of bytes received this user|int|count|
|`bytes_sent`|The number of bytes sent this user|int|count|
|`current_connect`|The number of current connect|int|count|
|`max_execution_time_exceeded`|The number of SELECT statements for which the execution timeout was exceeded.|int|count|
|`max_execution_time_set`|The number of SELECT statements for which a nonzero execution timeout was set. This includes statements that include a nonzero MAX_EXECUTION_TIME optimizer hint, and statements that include no such hint but execute while the timeout indicated by the max_execution_time system variable is nonzero.|int|count|
|`max_execution_time_set_failed`|The number of SELECT statements for which the attempt to set an execution timeout failed.|int|count|
|`slow_queries`|The number of queries that have taken more than long_query_time seconds. This counter increments regardless of whether the slow query log is enabled|int|count|
|`sort_rows`|The number of sorted rows.|int|count|
|`sort_scan`|The number of sorts that were done by scanning the table.|int|count|
|`table_open_cache_hits`|The number of hits for open tables cache lookups.|int|count|
|`table_open_cache_misses`|The number of misses for open tables cache lookups.|int|count|
|`table_open_cache_overflows`|The number of overflows for the open tables cache. This is the number of times, after a table is opened or closed, a cache instance has an unused entry and the size of the instance is larger than table_open_cache / table_open_cache_instances.|int|count|
|`total_connect`|The number of total connect|int|count|



## Custom Objects {#object}

### `database`



- Tags


| Tag | Description |
|  ----  | --------|
|`col_co_status`|Current status of collector on MySQL(`OK/NotOK`)|
|`host`|The server host address|
|`ip`|Connection IP of the MySQl|
|`name`|Object uniq ID|
|`reason`|If status not ok, we'll get some reasons about the status|

- Field List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`display_name`|Displayed name in UI|string|-|
|`uptime`|Current MySQL uptime|int|s|
|`version`|Current version of MySQL|string|-|




## Logs {#logging}

[:octicons-tag-24: Version-1.4.6](../datakit/changelog.md#cl-1.4.6)









### `mysql_dbm_metric`

Record the number of executions of the query statement, wait time, lock time, and the number of rows queried.

- Tags


| Tag | Description |
|  ----  | --------|
|`digest`|The digest hash value computed from the original normalized statement. |
|`host`|The server host address|
|`query_signature`|The hash value computed from digest_text|
|`schema_name`|The schema name|
|`server`|The server address containing both host and port|
|`service`|The service name and the value is 'mysql'|

- Field List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`count_star`|The total count of executed queries per normalized query and schema.|int|count|
|`message`|The text of the normalized statement digest.|string|-|
|`sum_errors`|The total count of queries run with an error per normalized query and schema.|int|count|
|`sum_lock_time`|The total time(nanosecond) spent waiting on locks per normalized query and schema.|int|count|
|`sum_no_good_index_used`|The total count of queries which used a sub-optimal index per normalized query and schema.|int|count|
|`sum_no_index_used`|The total count of queries which do not use an index per normalized query and schema.|int|count|
|`sum_rows_affected`|The number of rows mutated per normalized query and schema.|int|count|
|`sum_rows_examined`|The number of rows examined per normalized query and schema.|int|count|
|`sum_rows_sent`|The number of rows sent per normalized query and schema.|int|count|
|`sum_select_full_join`|The total count of full table scans on a joined table per normalized query and schema.|int|count|
|`sum_select_scan`|The total count of full table scans on the first table per normalized query and schema.|int|count|
|`sum_timer_wait`|The total query execution time(nanosecond) per normalized query and schema.|int|count|






### `mysql_dbm_sample`

Select some of the SQL statements with high execution time, collect their execution plans, and collect various performance indicators during the actual execution process.

- Tags


| Tag | Description |
|  ----  | --------|
|`current_schema`|The name of the current schema.|
|`digest`|The digest hash value computed from the original normalized statement. |
|`digest_text`|The digest_text of the statement.|
|`host`| The server host address|
|`network_client_ip`|The ip address of the client|
|`plan_definition`|The plan definition of JSON format.|
|`plan_signature`|The hash value computed from plan definition.|
|`processlist_db`|The name of the database.|
|`processlist_user`|The user name of the client.|
|`query_signature`|The hash value computed from digest_text.|
|`query_truncated`|It indicates whether the query is truncated.|
|`resource_hash`|The hash value computed from SQL text.|
|`server`|The server address containing both host and port|
|`service`|The service name and the value is 'mysql'|

- Field List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`duration`|Value in nanoseconds of the event's duration.|float|count|
|`lock_time_ns`|Time in nanoseconds spent waiting for locks. |int|count|
|`message`|The text of the normalized statement digest.|string|-|
|`no_good_index_used`|0 if a good index was found for the statement, 1 if no good index was found.|int|-|
|`no_index_used`|0 if the statement performed a table scan with an index, 1 if without an index.|int|-|
|`rows_affected`|Number of rows the statement affected.|int|count|
|`rows_examined`|Number of rows read during the statement's execution.|int|count|
|`rows_sent`|Number of rows returned. |int|count|
|`select_full_join`|Number of joins performed by the statement which did not use an index.|int|count|
|`select_full_range_join`|Number of joins performed by the statement which used a range search of the int first table. |int|count|
|`select_range`|Number of joins performed by the statement which used a range of the first table. |int|count|
|`select_range_check`|Number of joins without keys performed by the statement that check for key usage after int each row. |int|count|
|`select_scan`|Number of joins performed by the statement which used a full scan of the first table.|int|count|
|`sort_merge_passes`|Number of merge passes by the sort algorithm performed by the statement. |int|count|
|`sort_range`|Number of sorts performed by the statement which used a range.|int|count|
|`sort_rows`|Number of rows sorted by the statement. |int|count|
|`sort_scan`|Number of sorts performed by the statement which used a full table scan.|int|count|
|`timer_wait_ns`|Value in nanoseconds of the event's duration |float|ns|
|`timestamp`|The timestamp(millisecond) when then the event ends.|float|msec|






### `mysql_dbm_activity`

Collect the waiting event of the current thread

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|The server host address|
|`server`|The server address|
|`service`|The service name and the value is 'mysql'|

- Field List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`connections`|The total number of the connection|int|count|
|`current_schema`|The default database for the statement, NULL if there is none|string|-|
|`end_event_id`|The thread current event number when the event ends|string|-|
|`event_id`|The event id|string|-|
|`event_name`|The name of the instrument that produced the event|string|-|
|`event_source`|The name of the source file|string|-|
|`event_timer_end`|The time when event timing ended|int|ns|
|`event_timer_start`|The time when event timing started|int|ns|
|`event_timer_wait`|The time the event has elapsed so far|int|ns|
|`index_name`|The name of the index used|string|-|
|`ip`|The client IP address|string|-|
|`lock_time`|The time spent waiting for table locks|int|ns|
|`message`|The text of the normalized SQL text|string|-|
|`object_name`|The name of the object being acted on|string|-|
|`object_schema`|The schema of th object being acted on|string|-|
|`object_type`|The type of the object being acted on|string|-|
|`port`|The TCP/IP port number, in the range from 0 to 65535|string|-|
|`processlist_command`|The command of the thread|string|-|
|`processlist_db`|The default database for the thread, or NULL if none has been selected|string|-|
|`processlist_host`|The host name of the client with a thread|string|-|
|`processlist_id`|The process list ID|string|-|
|`processlist_state`|The state of the thread|string|-|
|`processlist_user`|The user associated with a thread|string|-|
|`query_signature`|The hash value computed from SQL text|string|-|
|`socket_event_name`|The name of the wait/io/socket/* instrument that produced the event|string|-|
|`sql_text`|The statement the thread is executing|string|-|
|`thread_id`|The thread ID|string|-|
|`wait_event`|The name of the wait event|string|-|
|`wait_timer_end`|The time when the waiting event timing ended|int|ns|
|`wait_timer_start`|The time when the waiting event timing started|int|ns|






### `mysql_replication_log`

Record the replication string information.

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|The server host address|
|`server`|Server addr|

- Field List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`Executed_Gtid_Set`|The set of global transaction IDs written in the binary log.|string|-|
|`Master_Host`|The host name of the master.|string|-|
|`Master_Log_File`|The name of the binary log file from which the server is reading.|string|-|
|`Master_Port`|The network port used to connect to the master.|int|count|
|`Master_User`|The user name used to connect to the master.|string|-|








## Custom Objects {#customobject}





### `database`



- Tags


| Tag | Description |
|  ----  | --------|
|`col_co_status`|Current status of collector on MySQL(`OK/NotOK`)|
|`host`|The server host address|
|`ip`|Connection IP of the MySQl|
|`name`|Object uniq ID|
|`reason`|If status not ok, we'll get some reasons about the status|

- Field List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`display_name`|Displayed name in UI|string|-|
|`uptime`|Current MySQL uptime|int|s|
|`version`|Current version of MySQL|string|-|



<!-- markdownlint-enable -->

### MySQL Operational Logs {#mysql-logging}

To collect MySQL logs, enable the relevant log configurations in the configuration file. To activate MySQL slow query logging, you need to enable the slow query log by executing the following statements in MySQL:

```sql
SET GLOBAL slow_query_log = 'ON';

-- Queries not using indexes are also considered possible slow queries
set global log_queries_not_using_indexes = 'ON';
```

```toml
[inputs.mysql.log]
    # Insert absolute path
    files = ["/var/log/mysql/*.log"]
```

> Note: When using log collection, DataKit must be installed on the same host as the MySQL service, or logs should be mounted to the machine where DataKit resides through other methods.

MySQL logs come in two types: general logs and slow logs.

### MySQL General Logs {#mysql-app-logging}

Original log:

``` log
2017-12-29T12:33:33.095243Z         2 Query     SELECT TABLE_SCHEMA, TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE CREATE_OPTIONS LIKE '%partitioned%';
```

The parsed field list is as follows:

| Field Name   | Field Value                                                   | Description                         |
| ------------ | ------------------------------------------------------------- | ----------------------------------- |
| `status`     | `Warning`                                                     | Log level                           |
| `msg`        | `System table 'plugin' is expected to be transactional.`      | Log content                         |
| `time`       | `1514520249954078000`                                        | Nanosecond timestamp (as line protocol time) |

### MySQL Slow Query Logs {#mysql-slow-logging}

Original log:

``` log
# Time: 2019-11-27T10:43:13.460744Z
# User@Host: root[root] @ localhost [1.2.3.4]  Id:    35
# Query_time: 0.214922  Lock_time: 0.000184 Rows_sent: 248832  Rows_examined: 72
# Thread_id: 55   Killed: 0  Errno: 0
# Bytes_sent: 123456   Bytes_received: 0
SET timestamp=1574851393;
SELECT * FROM fruit f1, fruit f2, fruit f3, fruit f4, fruit f5
```

The parsed field list is as follows:

| Field Name              | Field Value                                                                                      | Description                           |
| ----------------------- | ----------------------------------------------------------------------------------------------- | ------------------------------------- |
| `bytes_sent`           | `123456`                                                                                        | Sent bytes count                     |
| `db_host`              | `localhost`                                                                                     | Hostname                             |
| `db_ip`                | `1.2.3.4`                                                                                       | IP                                   |
| `db_slow_statement`    | `SET timestamp=1574851393;\nSELECT * FROM fruit f1, fruit f2, fruit f3, fruit f4, fruit f5`      | Slow query SQL                       |
| `db_user`              | `root[root]`                                                                                    | User                                 |
| `lock_time`            | `0.000184`                                                                                      | Lock time                            |
| `query_id`             | `35`                                                                                            | Query ID                             |
| `query_time`           | `0.214922`                                                                                      | SQL execution time                   |
| `rows_examined`       | `72`                                                                                            | Number of rows read                 |
| `rows_sent`            | `248832`                                                                                        | Number of rows returned             |
| `thread_id`            | `55`                                                                                            | Thread ID                           |
| `time`                 | `1514520249954078000`                                                                            | Nanosecond timestamp (as line protocol time) |

## FAQ {#faq}

<!-- markdownlint-disable MD013 -->
### :material-chat-question: Why does the metric `mysql_user_status` not report data when collecting from Alibaba Cloud RDS? {#faq-user-no-data}

This metric requires enabling `performance_schema`, which can be checked via the following SQL query:

```sql
show variables like "performance_schema";

+--------------------+-------+
| Variable_name      | Value |
+--------------------+-------+
| performance_schema | ON    |
+--------------------+-------+

```

If the value is `OFF`, refer to the related Alibaba Cloud [documentation](https://help.aliyun.com/document_detail/41726.html?spm=a2c4g.276975.0.i9){:target="_blank"} to enable it.

<!-- markdownlint-enable -->