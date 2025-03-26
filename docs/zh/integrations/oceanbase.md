---
title     : 'OceanBase'
summary   : '采集 OceanBase 的指标数据'
tags:
  - '数据库'
__int_icon      : 'icon/oceanbase'
dashboard :
  - desc  : 'OceanBase'
    path  : 'dashboard/zh/oceanbase'
monitor   :
  - desc  : '暂无'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

支持通过系统租户采集 OceanBase 监控指标。

已测试的版本：

- [x] OceanBase 3.2.4 企业版

## 配置 {#config}

### 前置条件 {#reqirement}

- 创建监控账号

使用 OceanBase 系统租户账号创建监控账号，并授予以下权限：

```sql
CREATE USER 'datakit'@'localhost' IDENTIFIED BY '<UNIQUEPASSWORD>';

-- MySQL 8.0+ create the datakit user with the caching_sha2_password method
CREATE USER 'datakit'@'localhost' IDENTIFIED WITH caching_sha2_password by '<UNIQUEPASSWORD>';

-- 授权
GRANT SELECT ON *.* TO 'datakit'@'localhost';
```

<!-- markdownlint-disable MD046 -->
???+ attention

    - 如用 `localhost` 时发现采集器有如下报错，需要将上述步骤的 `localhost` 换成 `::1` <br/>
    `Error 1045: Access denied for user 'datakit'@'localhost' (using password: YES)`

    - 以上创建、授权操作，均限定了 `datakit` 这个用户，只能在 OceanBase 主机上（`localhost`）访问。如果需要远程采集，建议将 `localhost` 替换成 `%`（表示 DataKit 可以在任意机器上访问），也可用特定的 DataKit 安装机器地址。
<!-- markdownlint-enable -->

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/db` 目录，复制 `oceanbase.conf.sample` 并命名为 `oceanbase.conf`。示例如下：
    
    ```toml
        
    [[inputs.oceanbase]]
      # host name
      host = "localhost"
    
      ## port
      port = 2883
    
      ## tenant name
      tenant = "sys"
    
      ## cluster name
      cluster = "obcluster"
    
      ## user name
      user = "datakit"
    
      ## password
      password = "<PASS>"
    
      ## database name
      database = "oceanbase"
    
      ## mode. mysql only.
      mode = "mysql"
    
      ## @param connect_timeout - number - optional - default: 10s
      # connect_timeout = "10s"
    
      interval = "10s"
    
      ## OceanBase slow query time threshold defined. If larger than this, the executed sql will be reported.
      slow_query_time = "0s"
    
      ## Set true to enable election
      election = true
    
      ## Run a custom SQL query and collect corresponding metrics.
      # [[inputs.oceanbase.custom_queries]]
        # sql = '''
        #   select
        #     CON_ID tenant_id,
        #     STAT_ID,
        #     replace(name, " ", "_") metric_name,
        #     VALUE
        #   from
        #     v$sysstat;
        # '''
        # metric = "oceanbase_custom"
        # tags = ["metric_name", "tenant_id"]
        # fields = ["VALUE"]
    
      [inputs.oceanbase.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
    ```
    
    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。

<!-- markdownlint-enable -->

## 慢查询支持 {#slow}

Datakit 可以将执行超过用户自定义时间的 SQL 语句报告给<<<custom_key.brand_name>>>，在日志中显示，来源名是 `oceanbase_log`。

该功能默认情况下是关闭的，用户可以在 OceanBase 的配置文件中将其打开，方法如下：

将 `slow_query_time` 后面的值从 `0s` 改成用户心中的阈值，最小值 1 毫秒，一般推荐 10 秒。

```conf

slow_query_time = "10s"

```

???+ info "字段说明"
    - `failed_obfuscate`：SQL 脱敏失败的原因。只有在 SQL 脱敏失败才会出现。SQL 脱敏失败后原 SQL 会被上报。
    更多字段解释可以查看[这里](https://www.oceanbase.com/docs/enterprise-oceanbase-database-cn-10000000000376688){:target="_blank"}。

???+ attention "重要信息"
    - 如果值是 `0s` 或空或小于 1 毫秒，则不会开启 OceanBase 采集器的慢查询功能，即默认状态。
    - 没有执行完成的 SQL 语句不会被查询到。

## 指标 {#metric}

以下所有数据采集，默认会追加全局选举 tag，也可以在配置中通过 `[inputs.oceanbase.tags]` 指定其它标签：

``` toml
 [inputs.oceanbase.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```





### `oceanbase_stat`



- 标签


| Tag | Description |
|  ----  | --------|
|`cluster`|Cluster Name|
|`host`|The server address or the host Name|
|`metric_name`|The name of the statistical event.|
|`stat_id`|The ID of the statistical event.|
|`svr_ip`|The IP address of the server where the information is located.|
|`tenant_id`|Tenant id|
|`tenant_name`|Tenant Name|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`metric_value`|The value of the statistical item.|int|-|










### `oceanbase_cache_block`



- 标签


| Tag | Description |
|  ----  | --------|
|`cache_name`|The cache name.|
|`cluster`|Cluster Name|
|`host`|The server address or the host Name|
|`svr_ip`|The IP address of the server where the information is located.|
|`svr_port`|The port of the server where the information is located.|
|`tenant_id`|Tenant id|
|`tenant_name`|Tenant Name|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cache_size`|The block cache size in the specified statistical range.|int|MB|






### `oceanbase_cache_plan`



- 标签


| Tag | Description |
|  ----  | --------|
|`cluster`|Cluster Name|
|`host`|The server address or the host Name|
|`svr_ip`|The IP address of the server where the information is located.|
|`svr_port`|The port of the server where the information is located.|
|`tenant_id`|Tenant id|
|`tenant_name`|Tenant Name|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`access_count`|The number of times that the query accesses the plan cache.|int|count|
|`hit_count`|The number of plan cache hits.|int|count|






### `oceanbase_event`



- 标签


| Tag | Description |
|  ----  | --------|
|`cluster`|Cluster Name|
|`event_group`|The group of the event.|
|`host`|The server address or the host Name|
|`svr_ip`|The IP address of the server where the information is located.|
|`tenant_id`|Tenant id|
|`tenant_name`|Tenant Name|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`time_waited`|The total wait time for the event in seconds.|int|s|
|`total_waits`|The total number of waits for the event.|int|count|






### `oceanbase_session`



- 标签


| Tag | Description |
|  ----  | --------|
|`cluster`|Cluster Name|
|`host`|The server address or the host Name|
|`svr_ip`|The IP address of the server where the information is located.|
|`svr_port`|The port of the server where the information is located.|
|`tenant_id`|Tenant id|
|`tenant_name`|Tenant Name|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active_cnt`|The number of active sessions within a tenant.|int|count|
|`all_cnt`|The total number of sessions within a tenant.|int|count|






### `oceanbase_clog`



- 标签


| Tag | Description |
|  ----  | --------|
|`cluster`|Cluster Name|
|`host`|The server address or the host Name|
|`replica_type`|The type of the replica|
|`svr_ip`|The IP address of the server where the information is located.|
|`svr_port`|The port of the server where the information is located.|
|`tenant_id`|Tenant id|
|`tenant_name`|Tenant Name|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`max_clog_sync_delay_seconds`|The max clog synchronization delay of an tenant.|int|s|




## 日志 {#logging}









### `oceanbase_log`



- 标签


| Tag | Description |
|  ----  | --------|
|`cluster`|Cluster Name|
|`host`|Hostname.|
|`oceanbase_server`|The address of the database instance (including port).|
|`oceanbase_service`|OceanBase service name.|
|`tenant_id`|Tenant id|
|`tenant_name`|Tenant Name|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`message`|The text of the logging.|string|-|
|`status`|The status of the logging, only supported `info/emerg/alert/critical/error/warning/debug/OK/unknown`.|string|-|























