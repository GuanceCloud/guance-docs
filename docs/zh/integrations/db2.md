---
title     : 'DB2'
summary   : '采集 IBM DB2 的指标数据'
tags:
  - '数据库'
__int_icon      : 'icon/db2'
dashboard :
  - desc  : 'IBM Db2'
    path  : 'dashboard/zh/db2'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

:fontawesome-brands-linux:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

采集 [IBM Db2](https://www.ibm.com/products/db2){:target="_blank"} 的性能指标。

已测试的版本：

- [x] 11.5.0.0a

## 配置 {#config}

### 前置条件 {#reqirement}

- 在 [IBM 网站](https://www-01.ibm.com/support/docview.wss?uid=swg21418043){:target="_blank"} 上下载 **DB2 ODBC/CLI driver**，也可以使用我们下载好的：

```sh
https://static.<<< custom_key.brand_main_domain >>>/otn_software/db2/linuxx64_odbc_cli.tar.gz
```

MD5: `A03356C83E20E74E06A3CC679424A47D`

- 将下载好的 **DB2 ODBC/CLI driver** 解压，推荐路径：`/opt/ibm/clidriver`

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

然后将路径 /opt/ibm/clidriver/**lib** 填入 *Datakit 的 IBM Db2 配置文件* 中的 `LD_LIBRARY_PATH` 环境变量中。

- 对于部分系统可能还需要安装额外的依赖库：

```sh
# Ubuntu/Debian
apt-get install -y libxml2

# CentOS
yum install -y libxml2
```

- 以管理员权限进入 `db2` 命令行模式执行以下命令开启监控功能：

```sh
update dbm cfg using HEALTH_MON on
update dbm cfg using DFT_MON_STMT on
update dbm cfg using DFT_MON_LOCK on
update dbm cfg using DFT_MON_TABLE on
update dbm cfg using DFT_MON_BUFPOOL on
```

以上语句开启了以下监控： Statement, Lock, Tables, Buffer pool 。

可以通过 `get dbm cfg` 命令查看开启的监控状态：

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

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/db` 目录，复制 `db2.conf.sample` 并命名为 `db2.conf`。示例如下：
    
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
    
    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

## 指标 {#metric}

以下所有数据采集，默认会追加全局选举 tag，也可以在配置中通过 `[inputs.db2.tags]` 指定其它标签：

``` toml
  [inputs.db2.tags]
    # some_tag = "some_value"
    # more_tag = "some_other_value"
    # ...
```



### `db2_instance`

- 标签


| Tag | Description |
|  ----  | --------|
|`db2_server`|Server addr.|
|`db2_service`|Server service.|
|`host`|Host name.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`connection_active`|The current number of connections.|int|count|



### `db2_database`

- 标签


| Tag | Description |
|  ----  | --------|
|`db2_server`|Server addr.|
|`db2_service`|Server service.|
|`host`|Host name.|

- 指标列表


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

- 标签


| Tag | Description |
|  ----  | --------|
|`bp_name`|Buffer pool name.|
|`db2_server`|Server addr.|
|`db2_service`|Server service.|
|`host`|Host name.|

- 指标列表


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

- 标签


| Tag | Description |
|  ----  | --------|
|`db2_server`|Server addr.|
|`db2_service`|Server service.|
|`host`|Host name.|
|`tablespace_name`|Tablespace name.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`tablespace_size`|The total size of the table space in bytes.|int|count|
|`tablespace_usable`|The total usable size of the table space in bytes.|int|count|
|`tablespace_used`|The total used size of the table space in bytes.|int|count|
|`tablespace_utilized`|The utilization of the table space as a percentage.|float|percent|



### `db2_transaction_log`

- 标签


| Tag | Description |
|  ----  | --------|
|`db2_server`|Server addr.|
|`db2_service`|Server service.|
|`host`|Host name.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`log_available`|The disk blocks (4 KiB each) of active log space in the database that is not being used by uncommitted transactions.|int|count|
|`log_reads`|The number of log pages read from disk by the logger.|int|count|
|`log_used`|The disk blocks (4 KiB each) of active log space currently used in the database.|float|percent|
|`log_utilized`|The utilization of active log space as a percentage.|float|percent|
|`log_writes`|The number of log pages written to disk by the logger.|int|count|



## FAQ {#faq}

<!-- markdownlint-disable MD013 -->
### :material-chat-question: 如何查看 IBM Db2 采集器的运行日志？ {#faq-logging}

由于 IBM Db2 采集器是外部采集器，程序名称为 `db2`，其日志是单独存放在 *[Datakit 安装目录]/externals/db2.log* 中。

### :material-chat-question: 配置好 IBM Db2 采集之后，为何 monitor 中无数据显示？ {#faq-no-data}

大概原因有如下几种可能：

- IBM Db2 动态库依赖有问题

即使你本机当前可能已经有对应的 IBM Db2 包，仍然建议使用上面文档中指定的依赖包且确保其安装路径跟 `LD_LIBRARY_PATH` 所指定的路径一致。

- glibc 版本有问题

由于 IBM Db2 采集器是独立编译的，且开启了 CGO，故其运行时需要 glibc 的依赖在 Linux 上可通过如下命令检查当前机器的 glibc 依赖是否有问题：

```shell
$ ldd <DataKit 安装目录>/externals/db2
    linux-vdso.so.1 (0x00007ffed33f9000)
    libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f70144e1000)
    libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f70144be000)
    libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f70142cc000)
    /lib64/ld-linux-x86-64.so.2 (0x00007f70144fc000)
```

如果有报告如下信息，则基本是当前机器上的 glibc 版本较低导致：

```shell
externals/db2: /lib64/libc.so.6: version  `GLIBC_2.14` not found (required by externals/db2)
```

- IBM Db2 采集器只能在 Linux/AMD64 架构的 DataKit 使用，其它平台均不支持

这意味着 IBM Db2 这个采集器只能在 AMD64 的 Linux 上运行，其它平台一律无法运行当前的 IBM Db2 采集器。

<!-- markdownlint-enable -->
