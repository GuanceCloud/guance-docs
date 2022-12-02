
# Oracle
---

:fontawesome-brands-linux:  · [:fontawesome-solid-flag-checkered:](index.md#legends "支持选举")

---

Oracle 监控指标采集，具有以下数据收集功能

- process 相关
- tablespace 相关数据
- system 数据采集
- 自定义查询数据采集

## 前置条件 {#reqirement}

- 创建监控账号

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

- 安装依赖包

根据操作系统和 Oracle 版本选择安装对应的安装包,参考[这里](https://oracle.github.io/odpi/doc/installation.html){:target="_blank"}，如：

```shell
wget https://download.oracle.com/otn_software/linux/instantclient/211000/instantclient-basiclite-linux.x64-21.1.0.0.0.zip
unzip instantclient-basiclite-linux.x64-21.1.0.0.0.zip
```

将解压后的目录文件路径添加到以下配置信息中的`LD_LIBRARY_PATH`环境变量路径中。

> 也可以直接下载我们预先准备好的依赖包：

```shell
wget -q https://zhuyun-static-files-production.oss-cn-hangzhou.aliyuncs.com/otn_software/instantclient/instantclient-basiclite-linux.x64-19.8.0.0.0dbru.zip \
			-O /usr/local/datakit/externals/instantclient-basiclite-linux.zip \
			&& unzip /usr/local/datakit/externals/instantclient-basiclite-linux.zip -d /opt/oracle;
```

另外，可能还需要安装额外的依赖库：

```shell
apt-get install -y libaio-dev libaio1
```

## 配置 {#config}

=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/db` 目录，复制 `oracle.conf.sample` 并命名为 `oracle.conf`。示例如下：
    
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
      # *--interval       : 采集的频度，最小粒度5m
      # *--host           : oracle实例地址(ip)
      #  --port           : oracle监听端口
      # *--username       : oracle 用户名
      # *--password       : oracle 密码
      # *--service-name   : oracle的服务名
      # *--query          : 自定义查询语句，格式为<sql:metricName:tags>, sql为自定义采集的语句, tags填入使用tag字段
    
    ```
    
    配置好后，[重启 DataKit](datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](datakit-daemonset-deploy.md#configmap-setting)来开启采集器。

## 指标集 {#measurements}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.oracle.tags]` 指定其它标签：

``` toml
 [inputs.oracle.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `oracle_process`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`oracle_server`|Server addr|
|`oracle_service`|Server service|
|`program`|Program|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`pga_alloc_mem`|PGA memory allocated by process|float|B|
|`pga_freeable_mem`|PGA memory freeable by process|float|B|
|`pga_max_mem`|PGA maximum memory ever allocated by process|float|B|
|`pga_used_mem`|PGA memory used by process|float|B|



### `oracle_tablespace`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`oracle_server`|Server addr|
|`oracle_service`|Server service|
|`tablespace_name`|Table space|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`in_use`|Tablespace in-use|float|count|
|`off_use`|Tablespace offline|float|count|
|`ts_size`|Tablespace size|float|B|
|`used_space`|Used space|float|count|



### `oracle_system`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`oracle_server`|Server addr|
|`oracle_service`|Server service|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
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

### 如何查看 Oracle 采集器的运行日志？ {#faq-logging}

由于 Oracle 采集器是外部采集器，其日志是单独存放在 <DataKit 安装目录>/externals/oracle.log 中。

### 配置好 Oracle 采集之后，为何 monitor 中无数据显示？ {#faq-no-data}

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

- Oracle 采集器只能在 Linux/amd64 架构的 DataKit 使用，其它平台均不支持

这意味着 Oracle 这个采集器只能在 amd64(X86) 的 Linux 上运行，其它平台一律无法运行当前的 Oracle 采集器。
