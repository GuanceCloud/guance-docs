
# Oracle
---

:fontawesome-brands-linux:  · [:fontawesome-solid-flag-checkered:](index.md#legends "支持选举")

---

Oracle monitoring metrics collection has the following data collection functions.

- process correlation
- tablespace related data
- system data collection
- Custom query data collection

Already tested version:

- [x] Oracle 19c
- [x] Oracle 12c
- [x] Oracle 11g

## Precondition {#reqirement}

- Create a monitoring account

```sql
-- Create the datakit user. Replace the password placeholder with a secure password.
CREATE USER datakit IDENTIFIED BY <PASSWORD>;

-- Grant access to the datakit user.
GRANT CONNECT TO datakit;
GRANT SELECT ON GV_$PROCESS TO datakit;
GRANT SELECT ON gv_$sysmetric TO datakit;
GRANT SELECT ON sys.dba_data_files TO datakit;
GRANT SELECT ON sys.dba_tablespaces TO datakit;
GRANT SELECT ON sys.dba_tablespace_usage_metrics TO datakit;
```

- Assemble dependency package

Select the appropriate installation package based on the operating system and Oracle version, refer to [here](https://oracle.github.io/odpi/doc/installation.html){:target="_blank"}，如：

```shell
wget https://download.oracle.com/otn_software/linux/instantclient/211000/instantclient-basiclite-linux.x64-21.1.0.0.0.zip
unzip instantclient-basiclite-linux.x64-21.1.0.0.0.zip
```

Add the extracted directory file path to the `LD_LIBRARY_PATH` environment variable path in the following configuration information.

> You can also download our pre-prepared dependency package directly:

```shell
wget -q https://static.guance.com/otn_software/instantclient/instantclient-basiclite-linux.x64-19.8.0.0.0dbru.zip \
			-O /usr/local/datakit/externals/instantclient-basiclite-linux.zip \
			&& unzip /usr/local/datakit/externals/instantclient-basiclite-linux.zip -d /opt/oracle;
```

In addition, you may need to install additional dependent libraries: 

```shell
apt-get install -y libaio-dev libaio1
```

## Configuration {#config}

=== "Host Installation"

    Go to the `conf.d/db` directory under the DataKit installation directory, copy `oracle.conf.sample` and name it `oracle.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.external]]
      daemon = true
      name = 'oracle'
      cmd  = "/usr/local/datakit/externals/oracle"
    
      ## Set true to enable election
      election = true
    
      args = [
        '--interval'       , '1m'                        ,
        '--host'           , '<your-oracle-host>'        ,
        '--port'           , '1521'                      ,
        '--username'       , '<oracle-user-name>'        ,
        '--password'       , '<oracle-password>'         ,
        '--service-name'   , '<oracle-service-name>'     ,
      ]
      envs = [
        'LD_LIBRARY_PATH=/opt/oracle/instantclient_19_8:$LD_LIBRARY_PATH',
      ]
    
      [inputs.external.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
      #############################
      # 参数说明(标 * 为必选项)
      #############################
      # *--interval       : 采集的频度，最小粒度 5m
      # *--host           : Oracle 实例地址(ip)
      #  --port           : Oracle 监听端口
      # *--username       : Oracle 用户名
      # *--password       : Oracle 密码
      # *--service-name   : Oracle 的服务名
      # *--query          : 自定义查询语句，格式为 <sql:metricName:tags>, sql 为自定义采集的语句, tags 填入使用 tag 字段
    
    ```
    
    Once configured, [restart DataKit](datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](datakit-daemonset-deploy.md#configmap-setting).

## Measurements {#measurements}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.oracle.tags]`:

``` toml
 [inputs.oracle.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `oracle_process`

- tag


| Tag | Description |
|  ----  | --------|
|`host`|host|
|`oracle_server`|Server addr|
|`oracle_service`|Server service|
|`program`|Program|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`pga_alloc_mem`|PGA memory allocated by process|float|B|
|`pga_freeable_mem`|PGA memory freeable by process|float|B|
|`pga_max_mem`|PGA maximum memory ever allocated by process|float|B|
|`pga_used_mem`|PGA memory used by process|float|B|



### `oracle_tablespace`

- tag


| Tag | Description |
|  ----  | --------|
|`host`|host|
|`oracle_server`|Server addr|
|`oracle_service`|Server service|
|`tablespace_name`|Table space|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`in_use`|Table space in-use|float|count|
|`off_use`|Table space offline|float|count|
|`ts_size`|Table space size|float|B|
|`used_space`|Used space|float|count|



### `oracle_system`

- tag


| Tag | Description |
|  ----  | --------|
|`host`|host|
|`oracle_server`|Server addr|
|`oracle_service`|Server service|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active_sessions`|Number of active sessions|float|count|
|`buffer_cachehit_ratio`|Ratio of buffer cache hits|float|count|
|`cache_blocks_corrupt`|Corrupt cache blocks|float|count|
|`cache_blocks_lost`|Lost cache blocks|float|count|
|`cursor_cachehit_ratio`|Ratio of cursor cache hits|float|count|
|`database_wait_time_ratio`|Memory sorts per second|float|count|
|`disk_sorts`|Disk sorts per second|float|count|
|`enqueue_timeouts`|Enqueue timeouts per sec|float|count|
|`gc_cr_block_received`|GC CR block received|float|count|
|`library_cachehit_ratio`|Ratio of library cache hits|float|count|
|`memory_sorts_ratio`|Memory sorts ratio|float|count|
|`physical_reads`|Physical reads per sec|float|count|
|`physical_writes`|Physical writes per sec|float|count|
|`rows_per_sort`|Rows per sort|float|count|
|`service_response_time`|Service response time|float|count|
|`session_count`|Session count|float|count|
|`session_limit_usage`|Session limit usage|float|count|
|`shared_pool_free`|Shared pool free memory %|float|B|
|`sorts_per_user_call`|Sorts per user call|float|count|
|`temp_space_used`|Temp space used|float|count|
|`user_rollbacks`|Number of user rollbacks|float|count|



## FAQ {#faq}

### :material-chat-question: How to view the running log of Oracle Collector? {#faq-logging}

Because the Oracle collector is an external collector, its logs are stored separately in *[Datakit-install-path]/externals/oracle.log*.

### :material-chat-question: After Oracle collection is configured, why is there no data displayed in monitor? {#faq-no-data}

There are several possible reasons:

- Oracle dynamic library dependencies are problematic

Even though you may already have a corresponding Oracle package on your machine, it is recommended to use the dependency package specified in the above document and ensure that its installation path is consistent with the path specified by `LD_LIBRARY_PATH`.

- There is a problem with the glibc version

As the Oracle collector is compiled independently and CGO is turned on, its runtime requires glibc dependencies. On Linux, you can check whether there is any problem with the glibc dependencies of the current machine by the following command:

```shell
$ ldd <Datakit-install-path>/externals/oracle
	linux-vdso.so.1 (0x00007ffed33f9000)
	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f70144e1000)
	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f70144be000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f70142cc000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f70144fc000)
```

If the following information is reported, it is basically caused by the low glibc version on the current machine:

```shell
externals/oracle: /lib64/libc.so.6: version  `GLIBC_2.14` not found (required by externals/oracle)
```

- Oracle Collector is only available on Linux/amd64 Architecture DataKit and is not supported on other platforms.

This means that the Oracle collector can only run on amd64 (X86) Linux, and no other platform can run the current Oracle collector.

### Why can't see `oracle_system` measurements? {#faq-no-system}

It is version related. Earlier version than `12c`, it needs to taking a few minutes to see them after the database system starting up.
