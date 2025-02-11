---
title: 'System'
summary: 'Collect metrics data related to the host system'
tags:
  - 'Host'
__int_icon: 'icon/system'
dashboard:
  - desc: 'System'
    path: 'dashboard/en/system'
monitor:
  - desc: 'N/A'
    path: '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The System collector gathers data on system load, uptime, number of CPU cores, and the number of logged-in users.

## Configuration {#config}

After successfully installing and starting DataKit, the System collector is enabled by default and does not require manual activation.

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->

=== "Host Installation"

    Navigate to the `conf.d/host` directory under the DataKit installation directory, copy `system.conf.sample`, and rename it to `system.conf`. Example configuration:

    ```toml
        
    [[inputs.system]]
      ## (optional) collection interval, default is 10 seconds
      interval = '10s'
    
      [inputs.system.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
    ```

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can inject the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [configure ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) to enable the collector.

    Environment variables can also be used to modify configuration parameters (requires adding the collector to ENV_DEFAULT_ENABLED_INPUTS):

    - **ENV_INPUT_SYSTEM_INTERVAL**

        Collector repeat interval

        **Field Type**: Duration

        **Collector Configuration Field**: `interval`

        **Default Value**: 10s

    - **ENV_INPUT_SYSTEM_TAGS**

        Custom tags. If the configuration file has tags with the same name, they will override them.

        **Field Type**: Map

        **Collector Configuration Field**: `tags`

        **Example**: tag1=value1,tag2=value2

<!-- markdownlint-enable -->

---

## Metrics {#metric}

All collected data below will append a global tag named `host` (tag value is the hostname where DataKit resides), or you can specify other tags in the configuration using `[inputs.system.tags]`:

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
| ---- | --------|
|`host`|hostname|

- Metrics List

| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cpu_total_usage`|Percentage of CPU usage.|float|percent|
|`load1`|CPU load average over the past 1 minute.|float|-|
|`load15`|CPU load average over the past 15 minutes.|float|-|
|`load15_per_core`|Single-core CPU load average over the past 15 minutes.|float|-|
|`load1_per_core`|Single-core CPU load average over the past 1 minute.|float|-|
|`load5`|CPU load average over the past 5 minutes.|float|-|
|`load5_per_core`|Single-core CPU load average over the past 5 minutes.|float|-|
|`memory_usage`|Percentage of memory usage.|float|percent|
|`n_cpus`|Logical CPU core count.|int|count|
|`n_users`|Number of users.|int|count|
|`process_count`|Number of processes running on the machine.|int|-|
|`uptime`|System uptime.|int|s|

### `conntrack`

Connection tracking metrics (Linux only).

- Tags

| Tag | Description |
| ---- | --------|
|`host`|hostname|

- Metrics List

| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`entries`|Current number of connections.|int|count|
|`entries_limit`|Size of the connection tracking table.|int|count|
|`stat_drop`|Number of packets dropped due to connection tracking failure.|int|count|
|`stat_early_drop`|Number of partially tracked packet entries dropped due to a full connection tracking table.|int|count|
|`stat_found`|Number of successful search entries.|int|count|
|`stat_ignore`|Number of reports that have been tracked.|int|count|
|`stat_insert`|Number of packets inserted.|int|count|
|`stat_insert_failed`|Number of packets that failed to insert.|int|count|
|`stat_invalid`|Number of packets that cannot be tracked.|int|count|
|`stat_search_restart`|Number of connection tracking table query restarts due to hash table size modification.|int|count|

### `filefd`

System file handle metrics (Linux only).

- Tags

| Tag | Description |
| ---- | --------|
|`host`|hostname|

- Metrics List

| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`allocated`|Number of allocated file handles.|int|count|
|`maximum_mega`|Maximum number of file handles, unit M(10^6).|float|count|

## FAQ {#faq}

### Why is there no `cpu_total_usage` metric? {#no-cpu}

The CPU collection feature is not supported on some platforms, such as macOS.