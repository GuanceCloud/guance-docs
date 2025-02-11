---
title: 'OceanBase'
summary: 'Collect metrics data from OceanBase'
tags:
  - 'Database'
__int_icon: 'icon/oceanbase'
dashboard:
  - desc: 'OceanBase'
    path: 'dashboard/en/oceanbase'
monitor:
  - desc: 'Not available'
    path: '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

Supports collecting monitoring Metrics from system tenants of OceanBase.

Tested versions:

- [x] OceanBase 3.2.4 Enterprise Edition

## Configuration {#config}

### Prerequisites {#reqirement}

- Create a monitoring account

Use the OceanBase system tenant account to create a monitoring account and grant the following permissions:

```sql
CREATE USER 'datakit'@'localhost' IDENTIFIED BY '<UNIQUEPASSWORD>';

-- MySQL 8.0+ create the datakit user with the caching_sha2_password method
CREATE USER 'datakit'@'localhost' IDENTIFIED WITH caching_sha2_password by '<UNIQUEPASSWORD>';

-- Grant privileges
GRANT SELECT ON *.* TO 'datakit'@'localhost';
```

<!-- markdownlint-disable MD046 -->
???+ attention

    - If you encounter the following error when using `localhost`, replace `localhost` with `::1` in the steps above.<br/>
    `Error 1045: Access denied for user 'datakit'@'localhost' (using password: YES)`

    - The above creation and authorization operations limit the `datakit` user to access only from the OceanBase host (`localhost`). For remote collection, it is recommended to replace `localhost` with `%` (indicating DataKit can access from any machine), or use a specific DataKit installation machine address.
<!-- markdownlint-enable -->

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/db` directory under the DataKit installation directory, copy `oceanbase.conf.sample` and rename it to `oceanbase.conf`. Example configuration:
    
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
    
      ## OceanBase slow query time threshold defined. If larger than this, the executed SQL will be reported.
      slow_query_time = "0s"
    
      ## Set true to enable election
      election = true
    
      ## Run a custom SQL query and collect corresponding Metrics.
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
    
    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).

<!-- markdownlint-enable -->

## Slow Query Support {#slow}

DataKit can report SQL statements that take longer than a user-defined time to Guance, displaying them in logs with the source name `oceanbase_log`.

This feature is disabled by default. Users can enable it in the OceanBase configuration file as follows:

Change the value after `slow_query_time` from `0s` to the desired threshold, with a minimum of 1 millisecond, typically recommended at 10 seconds.

```conf

slow_query_time = "10s"

```

???+ info "Field Description"
    - `failed_obfuscate`: Reason for SQL obfuscation failure. This field appears only if SQL obfuscation fails. The original SQL statement will be reported if obfuscation fails.
    More field explanations can be found [here](https://www.oceanbase.com/docs/enterprise-oceanbase-database-cn-10000000000376688){:target="_blank"}.

???+ attention "Important Information"
    - If the value is `0s`, empty, or less than 1 millisecond, the slow query feature of the OceanBase collector will not be enabled, which is the default state.
    - SQL statements that have not completed execution will not be queried.

## Metrics {#metric}

By default, all collected data will append global election tags. Additional tags can also be specified in the configuration through `[inputs.oceanbase.tags]`:

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

- Field List


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

- Field List


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

- Field List


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

- Field List


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

- Field List


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

- Field List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`max_clog_sync_delay_seconds`|The max clog synchronization delay of an tenant.|int|s|




## Logs {#logging}

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

- Field List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`message`|The text of the logging.|string|-|
|`status`|The status of the logging, only supported `info/emerg/alert/critical/error/warning/debug/OK/unknown`.|string|-|