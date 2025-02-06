---
title     : 'Oracle'
summary   : '采集 Oracle 的指标数据'
tags:
  - '数据库'
__int_icon      : 'icon/oracle'
dashboard :
  - desc  : 'Oracle'
    path  : 'dashboard/zh/oracle'
monitor   :
  - desc  : 'Oracle 监控器'
    path  : 'monitor/zh/oracle'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

Oracle 监控指标采集，具有以下数据收集功能

- Process 相关
- Table Space 相关数据
- System 数据采集
- 自定义查询数据采集

已测试的版本：

- [x] Oracle 19c
- [x] Oracle 12c
- [x] Oracle 11g

自 DataKit [1.32.0 版本](../datakit/changelog.md#cl-1.32.0) 开始，支持通过 DataKit 直接采集和外部采集器两种方式采集 Oracle 指标。

## 配置 {#config}

### 前置条件 {#reqirement}

- 创建监控账号

如果是使用单 PDB 或者非 CDB 实例，一个本地用户(local user)就足够了：

```sql
-- Create the datakit user. Replace the password placeholder with a secure password.
CREATE USER datakit IDENTIFIED BY <PASSWORD>;

-- Grant access to the datakit user.
GRANT CONNECT, CREATE SESSION TO datakit;
GRANT SELECT_CATALOG_ROLE to datakit;
GRANT SELECT ON DBA_TABLESPACE_USAGE_METRICS TO datakit;
GRANT SELECT ON DBA_TABLESPACES TO datakit;
GRANT SELECT ON DBA_USERS TO datakit;
GRANT SELECT ON SYS.DBA_DATA_FILES TO datakit;
GRANT SELECT ON V_$ACTIVE_SESSION_HISTORY TO datakit;
GRANT SELECT ON V_$ARCHIVE_DEST TO datakit;
GRANT SELECT ON V_$ASM_DISKGROUP TO datakit;
GRANT SELECT ON V_$DATABASE TO datakit;
GRANT SELECT ON V_$DATAFILE TO datakit;
GRANT SELECT ON V_$INSTANCE TO datakit;
GRANT SELECT ON V_$LOG TO datakit;
GRANT SELECT ON V_$OSSTAT TO datakit;
GRANT SELECT ON V_$PGASTAT TO datakit;
GRANT SELECT ON V_$PROCESS TO datakit;
GRANT SELECT ON V_$RECOVERY_FILE_DEST TO datakit;
GRANT SELECT ON V_$RESTORE_POINT TO datakit;
GRANT SELECT ON V_$SESSION TO datakit;
GRANT SELECT ON V_$SGASTAT TO datakit;
GRANT SELECT ON V_$SYSMETRIC TO datakit;
GRANT SELECT ON V_$SYSTEM_PARAMETER TO datakit;
```

如果想监控来自 CDB 和所有 PDB 中的表空间(Table Spaces)，需要一个有合适权限的公共用户(common user):

```sql
-- Create the datakit user. Replace the password placeholder with a secure password.
CREATE USER datakit IDENTIFIED BY <PASSWORD>;

-- Grant access to the datakit user.
ALTER USER datakit SET CONTAINER_DATA=ALL CONTAINER=CURRENT;
GRANT CONNECT, CREATE SESSION TO datakit;
GRANT SELECT_CATALOG_ROLE to datakit;
GRANT SELECT ON v_$instance TO datakit;
GRANT SELECT ON v_$database TO datakit;
GRANT SELECT ON v_$sysmetric TO datakit;
GRANT SELECT ON v_$system_parameter TO datakit;
GRANT SELECT ON v_$session TO datakit;
GRANT SELECT ON v_$recovery_file_dest TO datakit;
GRANT SELECT ON v_$active_session_history TO datakit;
GRANT SELECT ON v_$osstat TO datakit;
GRANT SELECT ON v_$restore_point TO datakit;
GRANT SELECT ON v_$process TO datakit;
GRANT SELECT ON v_$datafile TO datakit;
GRANT SELECT ON v_$pgastat TO datakit;
GRANT SELECT ON v_$sgastat TO datakit;
GRANT SELECT ON v_$log TO datakit;
GRANT SELECT ON v_$archive_dest TO datakit;
GRANT SELECT ON v_$asm_diskgroup TO datakit;
GRANT SELECT ON sys.dba_data_files TO datakit;
GRANT SELECT ON DBA_TABLESPACES TO datakit;
GRANT SELECT ON DBA_TABLESPACE_USAGE_METRICS TO datakit;
GRANT SELECT ON DBA_USERS TO datakit;
```

>注意：上述的 SQL 语句由于 Oracle 版本的原因部分可能会出现 "表不存在" 等错误，忽略即可。

- 安装依赖包

如果使用 DataKit 直接采集，可以跳过此步骤。

根据操作系统和 Oracle 版本选择安装对应的安装包，参考[这里](https://oracle.github.io/odpi/doc/installation.html){:target="_blank"}，如：

<!-- markdownlint-disable MD046 -->

=== "x86_64 系统"

    ```shell
    wget https://download.oracle.com/otn_software/linux/instantclient/2110000/instantclient-basiclite-linux.x64-21.10.0.0.0dbru.zip
    unzip instantclient-basiclite-linux.x64-21.10.0.0.0dbru.zip
    ```

    将解压后的目录文件路径添加到以下配置信息中的 `LD_LIBRARY_PATH` 环境变量路径中。

    > 也可以直接下载我们预先准备好的依赖包：

    ```shell
    wget https://static.guance.com/otn_software/instantclient/instantclient-basiclite-linux.x64-21.10.0.0.0dbru.zip \
        -O /usr/local/datakit/externals/instantclient-basiclite-linux.zip \
        && unzip /usr/local/datakit/externals/instantclient-basiclite-linux.zip -d /opt/oracle \
        && mv /opt/oracle/instantclient_21_10 /opt/oracle/instantclient;
    ```

=== "ARM64 系统"

    ```shell
    wget https://download.oracle.com/otn_software/linux/instantclient/1919000/instantclient-basiclite-linux.arm64-19.19.0.0.0dbru.zip
    unzip instantclient-basiclite-linux.arm64-19.19.0.0.0dbru.zip
    ```

    将解压后的目录文件路径添加到以下配置信息中的 `LD_LIBRARY_PATH` 环境变量路径中。

    > 也可以直接下载我们预先准备好的依赖包：

    ```shell
    wget https://static.guance.com/otn_software/instantclient/instantclient-basiclite-linux.arm64-19.19.0.0.0dbru.zip \
        -O /usr/local/datakit/externals/instantclient-basiclite-linux.zip \
        && unzip /usr/local/datakit/externals/instantclient-basiclite-linux.zip -d /opt/oracle \
        && mv /opt/oracle/instantclient_19_19 /opt/oracle/instantclient;
    ```

<!-- markdownlint-enable -->

 部分系统需要安装额外的依赖库：

```shell
apt-get install -y libaio-dev libaio1
```

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->

=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/db` 目录，复制 `oracle.conf.sample` 并命名为 `oracle.conf`。示例如下：
    
    ```toml
        
    [[inputs.oracle]]
      # host name
      host = "localhost"
    
      ## port
      port = 1521
    
      ## user name
      user = "datakit"
    
      ## password
      password = "<PASS>"
    
      ## service
      service = "XE"
    
      ## interval
      interval = "10s"
    
      ## connection timeout
      connect_timeout = "30s"
    
      ## slow query time threshold defined. If larger than this, the executed sql will be reported.
      slow_query_time = "0s"
    
      ## Set true to enable election
      election = true
    
      ## Run a custom SQL query and collect corresponding metrics.
      # [[inputs.oracle.custom_queries]]
      #   sql = '''
      #     SELECT
      #       GROUP_ID, METRIC_NAME, VALUE
      #     FROM GV$SYSMETRIC
      #   '''
      #   metric = "oracle_custom"
      #   tags = ["GROUP_ID", "METRIC_NAME"]
      #   fields = ["VALUE"]
    
      [inputs.oracle.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
    ```
    
    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。

=== "外部采集器"

    外部采集器的配置示例如下：

    ```toml
    [[inputs.external]]
      daemon = true
      name   = "oracle"
      cmd    = "/usr/local/datakit/externals/oracle"

      ## Set true to enable election
      election = true

      ## Modify below if necessary.
      ## The password use environment variable named "ENV_INPUT_ORACLE_PASSWORD".
      args = [
        "--interval"        , "1m"                           ,
        "--host"            , "<your-oracle-host>"           ,
        "--port"            , "1521"                         ,
        "--username"        , "<oracle-user-name>"           ,
        "--service-name"    , "<oracle-service-name>"        ,
        "--slow-query-time" , "0s"                           ,
        "--log"             , "/var/log/datakit/oracle.log"  ,
      ]
      envs = [
        "ENV_INPUT_ORACLE_PASSWORD=<oracle-password>",
        "LD_LIBRARY_PATH=/opt/oracle/instantclient:$LD_LIBRARY_PATH",
      ]

      [inputs.external.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"

      ## Run a custom SQL query and collect corresponding metrics.
      # [[inputs.external.custom_queries]]
      #   sql = '''
      #     SELECT
      #       GROUP_ID, METRIC_NAME, VALUE
      #     FROM GV$SYSMETRIC
      #   '''
      #   metric = "oracle_custom"
      #   tags = ["GROUP_ID", "METRIC_NAME"]
      #   fields = ["VALUE"]

      #############################
      # Parameter Description (Marked with * is required field)
      #############################
      # *--interval                   : Collect interval (Default is 1m).
      # *--host                       : Oracle instance address (IP).
      # *--port                       : Oracle listen port (Default is 1521).
      # *--username                   : Oracle username.
      # *--service-name               : Oracle service name.
      # *--slow-query-time            : Oracle slow query time threshold defined. If larger than this, the executed sql will be reported.
      # *--log                        : Collector log path.
      # *ENV_INPUT_ORACLE_PASSWORD    : Oracle password.
    ```

    ???+ tip

        上述配置会以命令行形式展示在进程列表中（包括密码），如果想隐藏密码，可以通过将密码写进环境变量 `ENV_INPUT_ORACLE_PASSWORD` 形式实现，示例：

        ```toml
        envs = [
          "ENV_INPUT_ORACLE_PASSWORD=<YOUR-SAFE-PASSWORD>"
        ] 
        ```

        该环境变量在读取密码时有最高优先级，即只要出现该环境变量，那密码就以该环境变量中的值为准。如果密码中有特殊字符，可以参见[这里](../datakit/datakit-input-conf.md#toml-raw-string)的做法来处理。

<!-- markdownlint-enable -->

## 指标 {#metric}

以下所有数据采集，默认会追加全局选举 tag，也可以在配置中通过 `[inputs.oracle.tags]` 指定其它标签：

``` toml
 [inputs.oracle.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```





### `oracle_process`

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|Host name|
|`oracle_server`|Server addr|
|`oracle_service`|Server service|
|`pdb_name`|PDB name|
|`program`|Program in progress|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`pga_alloc_mem`|PGA memory allocated by process|float|B|
|`pga_freeable_mem`|PGA memory freeable by process|float|B|
|`pga_max_mem`|PGA maximum memory ever allocated by process|float|B|
|`pga_used_mem`|PGA memory used by process|float|B|
|`pid`|Oracle process identifier|int|-|






### `oracle_tablespace`

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|Host name|
|`oracle_server`|Server addr|
|`oracle_service`|Server service|
|`pdb_name`|PDB name|
|`tablespace_name`|Table space name|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`in_use`|Percentage of used space,as a function of the maximum possible Tablespace size|float|percent|
|`off_use`|Total space consumed by the Tablespace,in database blocks|float|B|
|`ts_size`|Table space size|float|B|
|`used_space`|Used space|float|B|






### `oracle_system`

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|Host name|
|`oracle_server`|Server addr|
|`oracle_service`|Server service|
|`pdb_name`|PDB name|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active_sessions`|Number of active sessions|float|count|
|`buffer_cachehit_ratio`|Ratio of buffer cache hits|float|percent|
|`cache_blocks_corrupt`|Corrupt cache blocks|float|count|
|`cache_blocks_lost`|Lost cache blocks|float|count|
|`consistent_read_changes`|Consistent read changes per second|float|count|
|`consistent_read_gets`|Consistent read gets per second|float|count|
|`cursor_cachehit_ratio`|Ratio of cursor cache hits|float|percent|
|`database_cpu_time_ratio`|Database CPU time ratio|float|percent|
|`database_wait_time_ratio`|Memory sorts per second|float|percent|
|`db_block_changes`|DB block changes per second|float|count|
|`db_block_gets`|DB block gets per second|float|count|
|`disk_sorts`|Disk sorts per second|float|count|
|`enqueue_timeouts`|Enqueue timeouts per second|float|count|
|`execute_without_parse`|Execute without parse ratio|float|count|
|`gc_cr_block_received`|GC CR block received|float|count|
|`host_cpu_utilization`|Host CPU utilization (%)|float|percent|
|`library_cachehit_ratio`|Ratio of library cache hits|float|percent|
|`logical_reads`|Logical reads per second|float|count|
|`logons`|Number of logon attempts|float|count|
|`memory_sorts_ratio`|Memory sorts ratio|float|percent|
|`pga_over_allocation_count`|Over-allocating PGA memory count|float|count|
|`physical_reads`|Physical reads per second|float|count|
|`physical_reads_direct`|Physical reads direct per second|float|count|
|`physical_writes`|Physical writes per second|float|count|
|`redo_generated`|Redo generated per second|float|count|
|`redo_writes`|Redo writes per second|float|count|
|`rows_per_sort`|Rows per sort|float|count|
|`service_response_time`|Service response time|float|sec|
|`session_count`|Session count|float|count|
|`session_limit_usage`|Session limit usage|float|percent|
|`shared_pool_free`|Shared pool free memory %|float|percent|
|`soft_parse_ratio`|Soft parse ratio|float|percent|
|`sorts_per_user_call`|Sorts per user call|float|count|
|`temp_space_used`|Temp space used|float|B|
|`user_rollbacks`|Number of user rollbacks|float|count|







## 自定义对象 {#object}

















### `database`



- 标签


| Tag | Description |
|  ----  | --------|
|`col_co_status`|Current status of collector on Oracle(`OK/NotOK`)|
|`host`|The server host address|
|`ip`|Connection IP of the Oracle|
|`name`|Object uniq ID|
|`reason`|If status not ok, we'll get some reasons about the status|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`display_name`|Displayed name in UI|string|-|
|`uptime`|Current Oracle uptime|int|s|
|`version`|Current version of Oracle|string|-|




## 慢查询支持 {#slow}

Datakit 可以将执行超过用户自定义时间的 SQL 语句报告给观测云，在日志中显示，来源名是 `oracle_log`。

该功能默认情况下是关闭的，用户可以在 Oracle 的配置文件中将其打开，方法如下：

将 `slow_query_time` 的值从 `0s` 改成用户心中的阈值，最小值 1 毫秒。一般推荐 10 秒。

???+ info "字段说明"
    - `avg_elapsed`: 该 SQL 语句执行的平均耗时。
    - `username`：执行该语句的用户名。
    - `failed_obfuscate`：SQL 脱敏失败的原因。只有在 SQL 脱敏失败才会出现。SQL 脱敏失败后原 SQL 会被上报。
    更多字段解释可以查看[这里](https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/V-SQLAREA.html#GUID-09D5169F-EE9E-4297-8E01-8D191D87BDF7)。

???+ attention "重要信息"
    - 如果值是 `0s` 或空或小于 1 毫秒，则不会开启 Oracle 采集器的慢查询功能，即默认状态。
    - 没有执行完成的 SQL 语句不会被查询到。

## FAQ {#faq}

<!-- markdownlint-disable MD013 -->
### :material-chat-question: 通过外部采集器采集时，如何查看 Oracle 采集器的运行日志？ {#faq-logging}

由于 Oracle 采集器是外部采集器，其日志是默认单独存放在 *[Datakit 安装目录]/externals/oracle.log* 中。

另外，可以在配置文件中通过 `--log` 参数来指定日志文件位置。

### :material-chat-question: 配置好外部采集器采集之后，为何 monitor 中无数据显示？ {#faq-no-data}

大概原因有如下几种可能：

- Oracle 动态库依赖有问题

即使你本机当前可能已经有对应的 Oracle 包，仍然建议使用上面文档中指定的依赖包且确保其安装路径跟 `LD_LIBRARY_PATH` 所指定的路径一致。

- glibc 版本有问题

由于 Oracle 采集器是独立编译的，且开启了 CGO，故其运行时需要 glibc 的依赖在 Linux 上可通过如下命令检查当前机器的 glibc 依赖是否有问题：

```shell
$ ldd <DataKit 安装目录>/externals/oracle
    linux-vdso.so.1 (0x00007ffed33f9000)
    libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f70144e1000)
    libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f70144be000)
    libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f70142cc000)
    /lib64/ld-linux-x86-64.so.2 (0x00007f70144fc000)
```

如果有报告如下信息，则基本是当前机器上的 glibc 版本较低导致：

```shell
externals/oracle: /lib64/libc.so.6: version  `GLIBC_2.14` not found (required by externals/oracle)
```

- Oracle 采集器只能在 Linux x86_64/ARM64 架构的 DataKit 使用，其它平台均不支持

这意味着 Oracle 这个采集器只能在 x86_64/ARM64 的 Linux 上运行，其它平台一律无法运行当前的 Oracle 采集器。

### :material-chat-question: 为什么看不到 `oracle_system` 指标集? {#faq-no-system}

需要数据库运行起来之后，过 1 分钟才能看到。

<!-- markdownlint-enable -->
