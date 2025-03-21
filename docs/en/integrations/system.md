---
title     : 'System'
summary   : 'Collect metrics data related to the host system'
tags:
  - 'HOST'
__int_icon      : 'icon/system'
dashboard :
  - desc  : 'System'
    path  : 'dashboard/en/system'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The System collector gathers data on system load, uptime, number of CPU cores, and the number of logged-in users.

## Configuration {#config}

After successfully installing and starting DataKit, the System collector will be enabled by default, with no manual activation required.

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->

=== "HOST Installation"

    Navigate to the `conf.d/host` directory under the DataKit installation directory, copy `system.conf.sample`, and rename it to `system.conf`. An example is as follows:

    ```toml
        
    [[inputs.system]]
      ##(optional) collect interval, default is 10 seconds
      interval = '10s'
    
      [inputs.system.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
    ```

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can enable the collector via [ConfigMap injection](../datakit/datakit-daemonset-deploy.md#configmap-setting) or by [setting ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting).

    It also supports modifying configuration parameters via environment variables (requires adding to ENV_DEFAULT_ENABLED_INPUTS as a default collector):

    - **ENV_INPUT_SYSTEM_INTERVAL**
    
        The repetition interval for the collector.
    
        **Field Type**: Duration
    
        **Collector Configuration Field**: `interval`
    
        **Default Value**: 10s
    
    - **ENV_INPUT_SYSTEM_TAGS**
    
        Custom tags. If there are tags with the same name in the configuration file, they will override them.
    
        **Field Type**: Map
    
        **Collector Configuration Field**: `tags`
    
        **Example**: tag1=value1,tag2=value2

<!-- markdownlint-enable -->

---

## Metrics {#metric}

All the following data collection will append a global tag named `host` by default (the tag value is the hostname where DataKit resides), and you can also specify other tags through `[inputs.system.tags]` in the configuration:

```toml
 [inputs.system.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `system`

Basic information about system operation.

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|hostname|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cpu_total_usage`|The percentage of used CPU.|float|percent|
|`load1`|CPU load average over the past 1 minute.|float|-|
|`load15`|CPU load average over the past 15 minutes.|float|-|
|`load15_per_core`|CPU single core load average over the past 15 minutes.|float|-|
|`load1_per_core`|CPU single core load average over the past 1 minute.|float|-|
|`load5`|CPU load average over the past 5 minutes.|float|-|
|`load5_per_core`|CPU single core load average over the last 5 minutes.|float|-|
|`memory_usage`|The percentage of used memory.|float|percent|
|`n_cpus`|CPU logical core count.|int|count|
|`n_users`|User number.|int|count|
|`process_count`|Number of Processes running on the machine.|int|-|
|`uptime`|System uptime.|int|s|



### `conntrack`

Connection track metrics (Linux only).

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|hostname|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`entries`|Current number of connections.|int|count|
|`entries_limit`|The size of the connection tracking table.|int|count|
|`stat_drop`|The number of packets dropped due to connection tracking failure.|int|count|
|`stat_early_drop`|The number of partially tracked packet entries dropped due to connection tracking table full.|int|count|
|`stat_found`|The number of successful search entries.|int|count|
|`stat_ignore`|The number of reports that have been tracked.|int|count|
|`stat_insert`|The number of packets inserted.|int|count|
|`stat_insert_failed`|The number of packages that failed to insert.|int|count|
|`stat_invalid`|The number of packets that cannot be tracked.|int|count|
|`stat_search_restart`|The number of connection tracking table query restarts due to hash table size modification.|int|count|



### `filefd`

System file handle metrics (Linux only).

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|hostname|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`allocated`|The number of allocated file handles.|int|count|
|`maximum_mega`|The maximum number of file handles, unit M(10^6).|float|count|



## FAQ {#faq}

### Why is there no `cpu_total_usage` metric? {#no-cpu}

The CPU collection feature does not support all platforms, such as macOS.
