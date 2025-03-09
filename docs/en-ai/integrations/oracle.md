---
title     : 'Oracle'
summary   : 'Collect metrics data from Oracle'
tags:
  - 'Database'
__int_icon      : 'icon/oracle'
dashboard :
  - desc  : 'Oracle'
    path  : 'dashboard/en/oracle'
monitor   :
  - desc  : 'Oracle Monitor'
    path  : 'monitor/en/oracle'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

The Oracle metric collection has the following data collection functions:

- Process related
- Table Space related data
- System data collection
- Custom query data collection

Tested versions:

- [x] Oracle 19c
- [x] Oracle 12c
- [x] Oracle 11g

Since DataKit version [1.32.0](../datakit/changelog.md#cl-1.32.0), it supports collecting Oracle metrics directly through DataKit or via an external collector.

## Configuration {#config}

### Prerequisites {#reqirement}

- Create a monitoring account

If you are using a single PDB or non-CDB instance, a local user is sufficient:

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

If you want to monitor table spaces (Table Spaces) from CDB and all PDBs, you need a common user with appropriate permissions:

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

> Note: Some of the above SQL statements may result in errors like "table does not exist" due to Oracle version differences. These can be ignored.

- Install dependencies

If you are using direct collection with DataKit, you can skip this step.

Choose and install the corresponding package based on your operating system and Oracle version, refer to [this link](https://oracle.github.io/odpi/doc/installation.html){:target="_blank"}, for example:

<!-- markdownlint-disable MD046 -->

=== "x86_64 System"

    ```shell
    wget https://download.oracle.com/otn_software/linux/instantclient/2110000/instantclient-basiclite-linux.x64-21.10.0.0.0dbru.zip
    unzip instantclient-basiclite-linux.x64-21.10.0.0.0dbru.zip
    ```

    Add the unzipped directory path to the `LD_LIBRARY_PATH` environment variable path in the configuration information below.

    > You can also download our pre-prepared dependency package directly:

    ```shell
    wget https://static.guance.com/otn_software/instantclient/instantclient-basiclite-linux.x64-21.10.0.0.0dbru.zip \
        -O /usr/local/datakit/externals/instantclient-basiclite-linux.zip \
        && unzip /usr/local/datakit/externals/instantclient-basiclite-linux.zip -d /opt/oracle \
        && mv /opt/oracle/instantclient_21_10 /opt/oracle/instantclient;
    ```

=== "ARM64 System"

    ```shell
    wget https://download.oracle.com/otn_software/linux/instantclient/1919000/instantclient-basiclite-linux.arm64-19.19.0.0.0dbru.zip
    unzip instantclient-basiclite-linux.arm64-19.19.0.0.0dbru.zip
    ```

    Add the unzipped directory path to the `LD_LIBRARY_PATH` environment variable path in the configuration information below.

    > You can also download our pre-prepared dependency package directly:

    ```shell
    wget https://static.guance.com/otn_software/instantclient/instantclient-basiclite-linux.arm64-19.19.0.0.0dbru.zip \
        -O /usr/local/datakit/externals/instantclient-basiclite-linux.zip \
        && unzip /usr/local/datakit/externals/instantclient-basiclite-linux.zip -d /opt/oracle \
        && mv /opt/oracle/instantclient_19_19 /opt/oracle/instantclient;
    ```

<!-- markdownlint-enable -->

Some systems require additional libraries:

```shell
apt-get install -y libaio-dev libaio1
```

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->

=== "Host Installation"

    Go to the `conf.d/db` directory under the DataKit installation directory, copy `oracle.conf.sample` and rename it to `oracle.conf`. Example:

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
    
    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector by injecting the configuration through [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).

=== "External Collector"

    Example configuration for an external collector:

    ```toml
    [[inputs.external]]
      daemon = true
      name   = "oracle"
      cmd    = "/usr/local/datakit/externals/oracle"

      ## Set true to enable election
      election = true

      ## Modify below if necessary.
      ## The password uses an environment variable named "ENV_INPUT_ORACLE_PASSWORD".
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

        The above configuration will be displayed in the process list as command-line arguments (including passwords). To hide the password, you can store it in the environment variable `ENV_INPUT_ORACLE_PASSWORD`, for example:

        ```toml
        envs = [
          "ENV_INPUT_ORACLE_PASSWORD=<YOUR-SAFE-PASSWORD>"
        ] 
        ```

        This environment variable takes precedence when reading the password. If the password contains special characters, refer to [here](../datakit/datakit-input-conf.md#toml-raw-string) for handling.

<!-- markdownlint-enable -->

## Metrics {#metric}

By default, all collected data will append the global election tag. Additional tags can be specified in the configuration using `[inputs.oracle.tags]`:

``` toml
 [inputs.oracle.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `oracle_process`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|Host name|
|`oracle_server`|Server addr|
|`oracle_service`|Server service|
|`pdb_name`|PDB name|
|`program`|Program in progress|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`pga_alloc_mem`|PGA memory allocated by process|float|B|
|`pga_freeable_mem`|PGA memory freeable by process|float|B|
|`pga_max_mem`|PGA maximum memory ever allocated by process|float|B|
|`pga_used_mem`|PGA memory used by process|float|B|
|`pid`|Oracle process identifier|int|-|






### `oracle_tablespace`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|Host name|
|`oracle_server`|Server addr|
|`oracle_service`|Server service|
|`pdb_name`|PDB name|
|`tablespace_name`|Table space name|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`in_use`|Percentage of used space,as a function of the maximum possible Tablespace size|float|percent|
|`off_use`|Total space consumed by the Tablespace,in database blocks|float|B|
|`ts_size`|Table space size|float|B|
|`used_space`|Used space|float|B|






### `oracle_system`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|Host name|
|`oracle_server`|Server addr|
|`oracle_service`|Server service|
|`pdb_name`|PDB name|

- Metric List


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







## Custom Objects {#object}

















### `database`

- Tags


| Tag | Description |
|  ----  | --------|
|`col_co_status`|Current status of collector on Oracle(`OK/NotOK`)|
|`host`|The server host address|
|`ip`|Connection IP of the Oracle|
|`name`|Object uniq ID|
|`reason`|If status not ok, we'll get some reasons about the status|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`display_name`|Displayed name in UI|string|-|
|`uptime`|Current Oracle uptime|int|s|
|`version`|Current version of Oracle|string|-|




## Slow Query Support {#slow}

DataKit can report SQL statements that take longer than a user-defined time to execute to Guance, displaying them in logs with the source name `oracle_log`.

This feature is disabled by default. Users can enable it in the Oracle configuration file by changing the value of `slow_query_time` from `0s` to a threshold value, with a minimum of 1 millisecond. It is generally recommended to set it to 10 seconds.

???+ info "Field Description"
    - `avg_elapsed`: Average execution time of the SQL statement.
    - `username`: Username executing the statement.
    - `failed_obfuscate`: Reason for SQL obfuscation failure. This appears only if SQL obfuscation fails. The original SQL statement will be reported after obfuscation failure.
    For more field explanations, see [here](https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/V-SQLAREA.html#GUID-09D5169F-EE9E-4297-8E01-8D191D87BDF7).

???+ attention "Important Information"
    - If the value is `0s`, empty, or less than 1 millisecond, the slow query feature of the Oracle collector will not be enabled, which is the default state.
    - Uncompleted SQL statements will not be queried.

## FAQ {#faq}

<!-- markdownlint-disable MD013 -->
### :material-chat-question: How to view the running logs of the Oracle collector when using an external collector? {#faq-logging}

Since the Oracle collector is an external collector, its logs are stored separately in *[Datakit installation directory]/externals/oracle.log* by default.

Alternatively, you can specify the log file location in the configuration file using the `--log` parameter.

### :material-chat-question: Why is there no data in the monitor after configuring the external collector? {#faq-no-data}

There could be several possible reasons:

- Oracle dynamic library dependencies are problematic

Even if you already have the corresponding Oracle packages installed locally, it is still recommended to use the dependency packages specified in the documentation and ensure their installation path matches the path specified by `LD_LIBRARY_PATH`.

- glibc version issues

Since the Oracle collector is independently compiled and CGO is enabled, it requires glibc dependencies on Linux. You can check the current machine's glibc dependencies using the following command:

```shell
$ ldd <DataKit installation directory>/externals/oracle
    linux-vdso.so.1 (0x00007ffed33f9000)
    libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f70144e1000)
    libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f70144be000)
    libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f70142cc000)
    /lib64/ld-linux-x86-64.so.2 (0x00007f70144fc000)
```

If you receive the following message, it usually indicates that the glibc version on the current machine is too low:

```shell
externals/oracle: /lib64/libc.so.6: version  `GLIBC_2.14` not found (required by externals/oracle)
```

- The Oracle collector can only be used with Linux x86_64/ARM64 architecture DataKit, other platforms are not supported

This means the Oracle collector can only run on x86_64/ARM64 Linux, and it cannot run on other platforms.

### :material-chat-question: Why can't I see the `oracle_system` measurement set? {#faq-no-system}

You need to wait one minute after the database starts up before you can see it.

<!-- markdownlint-enable -->