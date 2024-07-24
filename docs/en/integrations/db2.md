---
title     : 'IBM Db2'
summary   : 'Collect IBM Db2 metrics'
__int_icon      : 'icon/db2'
dashboard :
  - desc  : 'IBM Db2'
    path  : 'dashboard/en/db2'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# IBM Db2
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

Collects [IBM Db2](https://www.ibm.com/products/db2){:target="_blank"} performance metrics.

Already tested version:

- [x] 11.5.0.0a

## Configuration {#config}

### Precondition {#reqirement}

- Download **DB2 ODBC/CLI driver** from [IBM Website](https://www-01.ibm.com/support/docview.wss?uid=swg21418043){:target="_blank"}, or from our website:

```sh
https://static.guance.com/otn_software/db2/linuxx64_odbc_cli.tar.gz
```

MD5: `A03356C83E20E74E06A3CC679424A47D`

- Extract the downloaded **DB2 ODBC/CLI driver** files, recommend path: `/opt/ibm/clidriver`

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

Then put the path /opt/ibm/clidriver/**lib** to the `LD_LIBRARY_PATH` line in *Datakit's IBM Db2 configuration file* .

- Additional dependency libraries may need to be installed for some operation system:

```shell
# Ubuntu/Debian
apt-get install -y libxml2

# CentOS
yum install -y libxml2
```

- Switch to the instance master user and run these commands at the `db2` prompt:

```sh
update dbm cfg using HEALTH_MON on
update dbm cfg using DFT_MON_STMT on
update dbm cfg using DFT_MON_LOCK on
update dbm cfg using DFT_MON_TABLE on
update dbm cfg using DFT_MON_BUFPOOL on
```

These commands will enable the database system monitor switches for each of the objects you want to monitor: Statement, Lock, Tables, Buffer pool.

Next, run `get dbm cfg` and you should see the following:

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

    Go to the `conf.d/db` directory under the DataKit installation directory, copy `db2.conf.sample` and name it `db2.conf`. Examples are as follows:
    
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
      # *--host           : IBM Db2 nstance address (IP)
      # *--port           : IBM Db2 listen port (Default is 50000)
      # *--username       : IBM Db2 username (Default is db2inst1)
      # *--password       : IBM Db2 password
      # *--database       : IBM Db2 database name
      #  --service-name   : IBM Db2 service name
    
    ```
    
    Once configured, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

## Metric {#metric}

For all of the following data collections, the global election tags will added automatically, we can add extra tags in `[inputs.db2.tags]` if needed:

``` toml
  [inputs.db2.tags]
    # some_tag = "some_value"
    # more_tag = "some_other_value"
    # ...
```



### `db2_instance`

- tag


| Tag | Description |
|  ----  | --------|
|`db2_server`|Server addr.|
|`db2_service`|Server service.|
|`host`|Host name.|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`connection_active`|The current number of connections.|int|count|



### `db2_database`

- tag


| Tag | Description |
|  ----  | --------|
|`db2_server`|Server addr.|
|`db2_service`|Server service.|
|`host`|Host name.|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`application_active`|The number of applications that are currently connected to the database.|int|count|
|`application_executing`|The number of applications for which the database manager is currently processing a request.|int|count|
|`backup_latest`|The time elapsed since the latest database backup was completed.|float|sec|
|`connection_max`|The highest number of simultaneous connections to the database since the database was activated.|int|count|
|`connection_total`|The total number of connections to the database since the first connect, activate, or last reset (coordinator agents).|int|count|
|`lock_active`|The number of locks currently held.|int|count|
|`lock_dead`|The total number of deadlocks that have occurred.|int|count|
|`lock_pages`|The memory pages (4 KiB each) currently in use by the lock list.|int|count|
|`lock_timeouts`|The number of times that a request to lock an object timed out instead of being granted.|int|count|
|`lock_wait`|The average wait time for a lock.|float|sec|
|`lock_waiting`|The number of agents waiting on a lock.|int|count|
|`row_modified_total`|The total number of rows inserted, updated, or deleted.|int|count|
|`row_reads_total`|The total number of rows that had to be read in order to return result sets.|int|count|
|`row_returned_total`|The total number of rows that have been selected by and returned to applications.|int|count|
|`status`|Database status. <br/>0: OK (ACTIVE, ACTIVE_STANDBY, STANDBY) <br/>1: WARNING (QUIESCE_PEND, ROLLFWD) <br/>2: CRITICAL (QUIESCED) <br/>3: UNKNOWN|int|-|



### `db2_buffer_pool`

- tag


| Tag | Description |
|  ----  | --------|
|`bp_name`|Buffer pool name.|
|`db2_server`|Server addr.|
|`db2_service`|Server service.|
|`host`|Host name.|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`bufferpool_column_hit_percent`|The percentage of time that the database manager did not need to load a page from disk to service a column-organized table data page request.|float|percent|
|`bufferpool_column_reads_logical`|The number of column-organized table data pages read from the logical table space containers for temporary, regular, and large table spaces.|int|count|
|`bufferpool_column_reads_physical`|The number of column-organized table data pages read from the physical table space containers for temporary, regular, and large table spaces.|int|count|
|`bufferpool_column_reads_total`|The total number of column-organized table data pages read from the table space containers for temporary, regular, and large table spaces.|int|count|
|`bufferpool_data_hit_percent`|The percentage of time that the database manager did not need to load a page from disk to service a data page request.|float|percent|
|`bufferpool_data_reads_logical`|The number of data pages read from the logical table space containers for temporary, regular and large table spaces.|int|count|
|`bufferpool_data_reads_physical`|The number of data pages read from the physical table space containers for temporary, regular and large table spaces.|int|count|
|`bufferpool_data_reads_total`|The total number of data pages read from the table space containers for temporary, regular and large table spaces.|int|count|
|`bufferpool_hit_percent`|The percentage of time that the database manager did not need to load a page from disk to service a page request.|float|percent|
|`bufferpool_index_hit_percent`|The percentage of time that the database manager did not need to load a page from disk to service an index page request.|float|percent|
|`bufferpool_index_reads_logical`|The number of index pages read from the logical table space containers for temporary, regular and large table spaces.|int|count|
|`bufferpool_index_reads_physical`|The number of index pages read from the physical table space containers for temporary, regular and large table spaces.|int|count|
|`bufferpool_index_reads_total`|The total number of index pages read from the table space containers for temporary, regular and large table spaces.|int|count|
|`bufferpool_reads_logical`|The number of pages read from the logical table space containers for temporary, regular and large table spaces.|int|count|
|`bufferpool_reads_physical`|The number of pages read from the physical table space containers for temporary, regular and large table spaces.|int|count|
|`bufferpool_reads_total`|The total number of pages read from the table space containers for temporary, regular and large table spaces.|int|count|
|`bufferpool_xda_hit_percent`|The percentage of time that the database manager did not need to load a page from disk to service an index page request.|float|percent|
|`bufferpool_xda_reads_logical`|The number of data pages for XML storage objects (XDAs) read from the logical table space containers for temporary, regular and large table spaces.|int|count|
|`bufferpool_xda_reads_physical`|The number of data pages for XML storage objects (XDAs) read from the physical table space containers for temporary, regular and large table spaces.|int|count|
|`bufferpool_xda_reads_total`|The total number of data pages for XML storage objects (XDAs) read from the table space containers for temporary, regular and large table spaces.|int|count|



### `db2_table_space`

- tag


| Tag | Description |
|  ----  | --------|
|`db2_server`|Server addr.|
|`db2_service`|Server service.|
|`host`|Host name.|
|`tablespace_name`|Tablespace name.|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`tablespace_size`|The total size of the table space in bytes.|int|count|
|`tablespace_usable`|The total usable size of the table space in bytes.|int|count|
|`tablespace_used`|The total used size of the table space in bytes.|int|count|
|`tablespace_utilized`|The utilization of the table space as a percentage.|float|percent|



### `db2_transaction_log`

- tag


| Tag | Description |
|  ----  | --------|
|`db2_server`|Server addr.|
|`db2_service`|Server service.|
|`host`|Host name.|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`log_available`|The disk blocks (4 KiB each) of active log space in the database that is not being used by uncommitted transactions.|int|count|
|`log_reads`|The number of log pages read from disk by the logger.|int|count|
|`log_used`|The disk blocks (4 KiB each) of active log space currently used in the database.|float|percent|
|`log_utilized`|The utilization of active log space as a percentage.|float|percent|
|`log_writes`|The number of log pages written to disk by the logger.|int|count|



## FAQ {#faq}

<!-- markdownlint-disable MD013 -->
### :material-chat-question: How to view the running log of IBM Db2 Collector? {#faq-logging}

Because the IBM Db2 collector is an external collector, its name is `db2`, its logs are stored separately in *[Datakit-install-path]/externals/db2.log*.

### :material-chat-question: After IBM Db2 collection is configured, why is there no data displayed in monitor? {#faq-no-data}

There are several possible reasons:

- IBM Db2 dynamic library dependencies are problematic

Even though you may already have a corresponding IBM Db2 package on your machine, it is recommended to use the dependency package specified in the above document and ensure that its installation path is consistent with the path specified by `LD_LIBRARY_PATH`.

- There is a problem with the glibc version

As the IBM Db2 collector is compiled independently and CGO is turned on, its runtime requires glibc dependencies. On Linux, you can check whether there is any problem with the glibc dependencies of the current machine by the following command:

```shell
$ ldd <Datakit-install-path>/externals/db2
  linux-vdso.so.1 (0x00007ffed33f9000)
  libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f70144e1000)
  libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f70144be000)
  libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f70142cc000)
  /lib64/ld-linux-x86-64.so.2 (0x00007f70144fc000)
```

If the following information is reported, it is basically caused by the low glibc version on the current machine:

```shell
externals/db2: /lib64/libc.so.6: version  `GLIBC_2.14` not found (required by externals/db2)
```

- IBM Db2 Collector is only available on Linux/AMD64 architecture DataKit and is not supported on other platforms.

This means that the IBM Db2 collector can only run on AMD64 Linux, and no other platform can run the current IBM Db2 collector.

<!-- markdownlint-enable -->
