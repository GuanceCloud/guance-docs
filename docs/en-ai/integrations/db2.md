---
title: 'DB2'
summary: 'Collect metrics data from IBM DB2'
tags:
  - 'Database'
__int_icon: 'icon/db2'
dashboard:
  - desc: 'IBM Db2'
    path: 'dashboard/en/db2'
monitor:
  - desc: 'Not available'
    path: '-'
---

:fontawesome-brands-linux:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

Collect performance metrics from [IBM Db2](https://www.ibm.com/products/db2){:target="_blank"}.

Tested versions:

- [x] 11.5.0.0a

## Configuration {#config}

### Prerequisites {#reqirement}

- Download the **DB2 ODBC/CLI driver** from the [IBM website](https://www-01.ibm.com/support/docview.wss?uid=swg21418043){:target="_blank"}, or use our pre-downloaded version:

```sh
https://static.guance.com/otn_software/db2/linuxx64_odbc_cli.tar.gz
```

MD5: `A03356C83E20E74E06A3CC679424A47D`

- Extract the downloaded **DB2 ODBC/CLI driver**, recommended path: `/opt/ibm/clidriver`

```sh
[root@Linux /opt/ibm/clidriver]# ls
.
├── bin
├── bnd
├── cfg
├── cfgcache
├── conv
├── db2dump
├── include
├── lib
├── license
├── msg
├── properties
└── security64
```

Then add the path `/opt/ibm/clidriver/lib` to the `LD_LIBRARY_PATH` environment variable in the *DataKit IBM Db2 configuration file*.

- For some systems, additional dependency libraries may need to be installed:

```sh
# Ubuntu/Debian
apt-get install -y libxml2

# CentOS
yum install -y libxml2
```

- Execute the following commands with administrative privileges in the `db2` command-line mode to enable monitoring features:

```sh
update dbm cfg using HEALTH_MON on
update dbm cfg using DFT_MON_STMT on
update dbm cfg using DFT_MON_LOCK on
update dbm cfg using DFT_MON_TABLE on
update dbm cfg using DFT_MON_BUFPOOL on
```

The above statements enable monitoring for: Statement, Lock, Tables, Buffer pool.

You can check the enabled monitoring status using the `get dbm cfg` command:

```sh
 Default database monitor switches
   Buffer pool                         (DFT_MON_BUFPOOL) = ON
   Lock                                   (DFT_MON_LOCK) = ON
   Sort                                   (DFT_MON_SORT) = OFF
   Statement                              (DFT_MON_STMT) = ON
   Table                                 (DFT_MON_TABLE) = ON
   Timestamp                         (DFT_MON_TIMESTAMP) = ON
   Unit of work                            (DFT_MON_UOW) = OFF
 Monitor health of instance and databases   (HEALTH_MON) = ON
```

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/db` directory under the DataKit installation directory, copy `db2.conf.sample` and rename it to `db2.conf`. Example configuration:
    
    ```toml
        
    [[inputs.external]]
      daemon = true
      name   = 'db2'
      cmd    = "/usr/local/datakit/externals/db2"
    
      ## Set true to enable election
      election = true
    
      ## The "--inputs" line below should not be modified.
      args = [
        '--interval'       , '1m'                        ,
        '--host'           , '<db2-host>'                ,
        '--port'           , '50000'                     ,
        '--username'       , 'db2inst1'                  ,
        '--password'       , '<db2-password>'            ,
        '--database'       , '<db2-database-name>'       ,
        '--service-name'   , '<db2-service-name>'        ,
      ]
      envs = [
        'LD_LIBRARY_PATH=/opt/ibm/clidriver/lib:$LD_LIBRARY_PATH',
      ]
    
      [inputs.external.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
      #############################
      # Parameter Description (Marked with * is mandatory field)
      #############################
      # *--interval       : Collect interval (Default is 1m)
      # *--host           : IBM Db2 instance address (IP)
      # *--port           : IBM Db2 listen port (Default is 50000)
      # *--username       : IBM Db2 username (Default is db2inst1)
      # *--password       : IBM Db2 password
      # *--database       : IBM Db2 database name
      #  --service-name   : IBM Db2 service name
    
    ```
    
    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

## Metrics {#metric}

By default, all collected data will append global election tags, or you can specify other tags in the configuration using `[inputs.db2.tags]`:

``` toml
  [inputs.db2.tags]
    # some_tag = "some_value"
    # more_tag = "some_other_value"
    # ...
```



### `db2_instance`

- Tags


| Tag | Description |
|  ----  | --------|
|`db2_server`|Server address.|
|`db2_service`|Server service.|
|`host`|Host name.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`connection_active`|The current number of connections.|int|count|



### `db2_database`

- Tags


| Tag | Description |
|  ----  | --------|
|`db2_server`|Server address.|
|`db2_service`|Server service.|
|`host`|Host name.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`application_active`|The number of applications currently connected to the database.|int|count|
|`application_executing`|The number of applications for which the database manager is currently processing a request.|int|count|
|`backup_latest`|The time elapsed since the latest database backup was completed.|float|sec|
|`connection_max`|The highest number of simultaneous connections to the database since activation.|int|count|
|`connection_total`|The total number of connections to the database since the first connect, activate, or last reset (coordinator agents).|int|count|
|`lock_active`|The number of locks currently held.|int|count|
|`lock_dead`|The total number of deadlocks that have occurred.|int|count|
|`lock_pages`|The memory pages (4 KiB each) currently in use by the lock list.|int|count|
|`lock_timeouts`|The number of times a request to lock an object timed out instead of being granted.|int|count|
|`lock_wait`|The average wait time for a lock.|float|sec|
|`lock_waiting`|The number of agents waiting on a lock.|int|count|
|`row_modified_total`|The total number of rows inserted, updated, or deleted.|int|count|
|`row_reads_total`|The total number of rows read to return result sets.|int|count|
|`row_returned_total`|The total number of rows selected by and returned to applications.|int|count|
|`status`|Database status. <br/>0: OK (ACTIVE, ACTIVE_STANDBY, STANDBY) <br/>1: WARNING (QUIESCE_PEND, ROLLFWD) <br/>2: CRITICAL (QUIESCED) <br/>3: UNKNOWN|int|-|



### `db2_buffer_pool`

- Tags


| Tag | Description |
|  ----  | --------|
|`bp_name`|Buffer pool name.|
|`db2_server`|Server address.|
|`db2_service`|Server service.|
|`host`|Host name.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`bufferpool_column_hit_percent`|The percentage of time the database manager did not need to load a page from disk to service a column-organized table data page request.|float|percent|
|`bufferpool_column_reads_logical`|The number of column-organized table data pages read from logical table space containers for temporary, regular, and large table spaces.|int|count|
|`bufferpool_column_reads_physical`|The number of column-organized table data pages read from physical table space containers for temporary, regular, and large table spaces.|int|count|
|`bufferpool_column_reads_total`|The total number of column-organized table data pages read from table space containers for temporary, regular, and large table spaces.|int|count|
|`bufferpool_data_hit_percent`|The percentage of time the database manager did not need to load a page from disk to service a data page request.|float|percent|
|`bufferpool_data_reads_logical`|The number of data pages read from logical table space containers for temporary, regular, and large table spaces.|int|count|
|`bufferpool_data_reads_physical`|The number of data pages read from physical table space containers for temporary, regular, and large table spaces.|int|count|
|`bufferpool_data_reads_total`|The total number of data pages read from table space containers for temporary, regular, and large table spaces.|int|count|
|`bufferpool_hit_percent`|The percentage of time the database manager did not need to load a page from disk to service a page request.|float|percent|
|`bufferpool_index_hit_percent`|The percentage of time the database manager did not need to load a page from disk to service an index page request.|float|percent|
|`bufferpool_index_reads_logical`|The number of index pages read from logical table space containers for temporary, regular, and large table spaces.|int|count|
|`bufferpool_index_reads_physical`|The number of index pages read from physical table space containers for temporary, regular, and large table spaces.|int|count|
|`bufferpool_index_reads_total`|The total number of index pages read from table space containers for temporary, regular, and large table spaces.|int|count|
|`bufferpool_reads_logical`|The number of pages read from logical table space containers for temporary, regular, and large table spaces.|int|count|
|`bufferpool_reads_physical`|The number of pages read from physical table space containers for temporary, regular, and large table spaces.|int|count|
|`bufferpool_reads_total`|The total number of pages read from table space containers for temporary, regular, and large table spaces.|int|count|
|`bufferpool_xda_hit_percent`|The percentage of time the database manager did not need to load a page from disk to service an index page request.|float|percent|
|`bufferpool_xda_reads_logical`|The number of data pages for XML storage objects (XDAs) read from logical table space containers for temporary, regular, and large table spaces.|int|count|
|`bufferpool_xda_reads_physical`|The number of data pages for XML storage objects (XDAs) read from physical table space containers for temporary, regular, and large table spaces.|int|count|
|`bufferpool_xda_reads_total`|The total number of data pages for XML storage objects (XDAs) read from table space containers for temporary, regular, and large table spaces.|int|count|



### `db2_table_space`

- Tags


| Tag | Description |
|  ----  | --------|
|`db2_server`|Server address.|
|`db2_service`|Server service.|
|`host`|Host name.|
|`tablespace_name`|Tablespace name.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`tablespace_size`|The total size of the table space in bytes.|int|count|
|`tablespace_usable`|The total usable size of the table space in bytes.|int|count|
|`tablespace_used`|The total used size of the table space in bytes.|int|count|
|`tablespace_utilized`|The utilization of the table space as a percentage.|float|percent|



### `db2_transaction_log`

- Tags


| Tag | Description |
|  ----  | --------|
|`db2_server`|Server address.|
|`db2_service`|Server service.|
|`host`|Host name.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`log_available`|The disk blocks (4 KiB each) of active log space in the database not being used by uncommitted transactions.|int|count|
|`log_reads`|The number of log pages read from disk by the logger.|int|count|
|`log_used`|The disk blocks (4 KiB each) of active log space currently used in the database.|float|percent|
|`log_utilized`|The utilization of active log space as a percentage.|float|percent|
|`log_writes`|The number of log pages written to disk by the logger.|int|count|



## FAQ {#faq}

<!-- markdownlint-disable MD013 -->
### :material-chat-question: How to view the logs of the IBM Db2 collector? {#faq-logging}

Since the IBM Db2 collector is an external collector, its program name is `db2`, and its logs are stored separately in *[Datakit installation directory]/externals/db2.log*.

### :material-chat-question: Why is there no data displayed in the monitor after configuring the IBM Db2 collector? {#faq-no-data}

Possible reasons include:

- Issues with IBM Db2 dynamic library dependencies

Even if you already have the corresponding IBM Db2 package on your local machine, it is still recommended to use the specified dependency package in the document and ensure that the installation path matches the path specified by `LD_LIBRARY_PATH`.

- glibc version issues

Since the IBM Db2 collector is independently compiled and CGO is enabled, it requires glibc dependencies. You can check the glibc dependencies on Linux using the following command:

```shell
$ ldd <DataKit installation directory>/externals/db2
    linux-vdso.so.1 (0x00007ffed33f9000)
    libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f70144e1000)
    libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f70144be000)
    libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f70142cc000)
    /lib64/ld-linux-x86-64.so.2 (0x00007f70144fc000)
```

If you see a report like this, it indicates that the glibc version on the current machine is too low:

```shell
externals/db2: /lib64/libc.so.6: version `GLIBC_2.14` not found (required by externals/db2)
```

- The IBM Db2 collector only supports Linux/AMD64 architecture DataKit; other platforms are not supported

This means the IBM Db2 collector can only run on AMD64 Linux, and it cannot run on other platforms.

<!-- markdownlint-enable -->