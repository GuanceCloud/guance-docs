---
title     : 'OceanBase'
summary   : 'Collect OceanBase metrics'
tags:
  - 'DATA STORES'
__int_icon      : 'icon/oceanbase'
dashboard :
  - desc  : 'OceanBase'
    path  : 'dashboard/en/oceanbase'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

Collecting OceanBase performance metrics through the sys tenant.

Already tested version:

- [x] OceanBase Enterprise 3.2.4

## Configuration {#config}

### Precondition {#reqirement}

- Create a monitoring account

Create a monitoring account using a sys tenant account and grant the following privileges:

```sql
CREATE USER 'datakit'@'localhost' IDENTIFIED BY '<UNIQUEPASSWORD>';

-- MySQL 8.0+ create the datakit user with the caching_sha2_password method
CREATE USER 'datakit'@'localhost' IDENTIFIED WITH caching_sha2_password by '<UNIQUEPASSWORD>';

-- Grant the required permissions 
GRANT SELECT ON *.* TO 'datakit'@'localhost';
```

<!-- markdownlint-disable MD046 -->
???+ attention

    - Note that if you find the collector has the following error when using `localhost` , you need to replace the above `localhost` with `::1` <br/>
    `Error 1045: Access denied for user 'datakit'@'localhost' (using password: YES)`

    - All the above creation and authorization operations limit that the user `datakit` can only access OceanBase on local host (`localhost`). If OceanBase is collected remotely, it is recommended to replace `localhost` with `%` (indicating that DataKit can access OceanBase on any machine), or use a specific DataKit installation machine address.


### Collector Configuration {#input-config}

=== "Host Installation"

    Go to the `conf.d/db` directory under the DataKit installation directory, copy `oceanbase.conf.sample` and name it `oceanbase.conf`. Examples are as follows:
    
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
    
    Once configured, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting).

## Long Running Queries {#slow}

Datakit could reports the SQLs, those executed time exceeded the threshold time defined by user, to Guance Cloud, displays in the `Logs` side bar, the source name is `oceanbase_log`.

This function is disabled by default, user could enabling it by modify Datakit's OceanBase configuration like followings:

Change the string value after `slow_query_time` from `0s` to the threshold time, minimal value is 1 millsecond. Generally, recommand it to `10s`.

```conf

slow_query_time = "0s"

```

???+ info "Fields description"
    - `failed_obfuscate`：SQL obfuscated failed reason. Only exist when SQL obfuscated failed. Original SQL will be reported when SQL obfuscated failed.
    [More fields](https://www.oceanbase.com/docs/enterprise-oceanbase-database-cn-10000000000376688){:target="_blank"}.

???+ attention "Attention"
    - If the string value after `--slow-query-time` is `0s` or empty or less than 1 millisecond, this function is disabled, which is also the default state.
    - The SQL would not display here when NOT executed completed.

<!-- markdownlint-enable -->
## Metric {#metric}

For all of the following data collections, the global election tags will added automatically, we can add extra tags in `[inputs.oceanbase.tags]` if needed:

``` toml
 [inputs.oceanbase.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```





### `oceanbase_stat`



- Tags


| Tag | Description |
|  ----  | --------|
|`cluster`|Cluster Name|
|`host`|The server address or the host Name|
|`metric_name`|The name of the statistical event.|
|`stat_id`|The ID of the statistical event.|
|`svr_ip`|The IP address of the server where the information is located.|
|`tenant_id`|Tenant id|
|`tenant_name`|Tenant Name|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`metric_value`|The value of the statistical item.|int|-|










### `oceanbase_cache_block`



- Tags


| Tag | Description |
|  ----  | --------|
|`cache_name`|The cache name.|
|`cluster`|Cluster Name|
|`host`|The server address or the host Name|
|`svr_ip`|The IP address of the server where the information is located.|
|`svr_port`|The port of the server where the information is located.|
|`tenant_id`|Tenant id|
|`tenant_name`|Tenant Name|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cache_size`|The block cache size in the specified statistical range.|int|MB|






### `oceanbase_cache_plan`



- Tags


| Tag | Description |
|  ----  | --------|
|`cluster`|Cluster Name|
|`host`|The server address or the host Name|
|`svr_ip`|The IP address of the server where the information is located.|
|`svr_port`|The port of the server where the information is located.|
|`tenant_id`|Tenant id|
|`tenant_name`|Tenant Name|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`access_count`|The number of times that the query accesses the plan cache.|int|count|
|`hit_count`|The number of plan cache hits.|int|count|






### `oceanbase_event`



- Tags


| Tag | Description |
|  ----  | --------|
|`cluster`|Cluster Name|
|`event_group`|The group of the event.|
|`host`|The server address or the host Name|
|`svr_ip`|The IP address of the server where the information is located.|
|`tenant_id`|Tenant id|
|`tenant_name`|Tenant Name|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`time_waited`|The total wait time for the event in seconds.|int|s|
|`total_waits`|The total number of waits for the event.|int|count|






### `oceanbase_session`



- Tags


| Tag | Description |
|  ----  | --------|
|`cluster`|Cluster Name|
|`host`|The server address or the host Name|
|`svr_ip`|The IP address of the server where the information is located.|
|`svr_port`|The port of the server where the information is located.|
|`tenant_id`|Tenant id|
|`tenant_name`|Tenant Name|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active_cnt`|The number of active sessions within a tenant.|int|count|
|`all_cnt`|The total number of sessions within a tenant.|int|count|






### `oceanbase_clog`



- Tags


| Tag | Description |
|  ----  | --------|
|`cluster`|Cluster Name|
|`host`|The server address or the host Name|
|`replica_type`|The type of the replica|
|`svr_ip`|The IP address of the server where the information is located.|
|`svr_port`|The port of the server where the information is located.|
|`tenant_id`|Tenant id|
|`tenant_name`|Tenant Name|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`max_clog_sync_delay_seconds`|The max clog synchronization delay of an tenant.|int|s|




## Log {#logging}









### `oceanbase_log`



- Tags


| Tag | Description |
|  ----  | --------|
|`cluster`|Cluster Name|
|`host`|Hostname.|
|`oceanbase_server`|The address of the database instance (including port).|
|`oceanbase_service`|OceanBase service name.|
|`tenant_id`|Tenant id|
|`tenant_name`|Tenant Name|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`message`|The text of the logging.|string|-|
|`status`|The status of the logging, only supported `info/emerg/alert/critical/error/warning/debug/OK/unknown`.|string|-|























