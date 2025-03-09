---
title     : 'Process'
summary   : 'Collect metrics and object data from processes'
tags:
  - 'Host'
__int_icon      : 'icon/process'
dashboard :
  - desc  : 'Process'
    path  : 'dashboard/en/process'
monitor   :
  - desc  : 'None'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The Process Collector can monitor various running processes in the system in real-time, obtaining and analyzing metrics such as memory usage rate, CPU time consumed, current process state, ports listened by the process, etc. Based on these metrics, users can configure relevant alerts in Guance to understand the status of the processes and promptly maintain faulty processes when issues occur.

<!-- markdownlint-disable MD046 -->

???+ attention

    The Process Collector (whether for objects or metrics) may consume a lot of resources on macOS, leading to high CPU usage. It can be manually disabled. Currently, the default collector still enables the process object collector (default run every 5 minutes).

<!-- markdownlint-enable MD046 -->

## Configuration {#config}

### Prerequisites {#requirements}

- The Process Collector does not collect process metrics by default. To collect metric-related data, set `open_metric` to `true` in `host_processes.conf`. For example:

```toml
[[inputs.host_processes]]
    ...
    open_metric = true
```

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->

=== "Host Installation"

    Navigate to the `conf.d/host` directory under the DataKit installation directory, copy `host_processes.conf.sample`, and rename it to `host_processes.conf`. Example:

    ```toml
        
    [[inputs.host_processes]]
      # Only collect metrics from these matched processes. For process objects
      # these white list not applied. Process name supports regexp.
      # process_name = [".*nginx.*", ".*mysql.*"]
    
      # Minimum process run time (default 10m)
      # If the process running time is less than the setting, we ignore it (both for metric and object)
      min_run_time = "10m"
    
      ## Enable process metric collecting
      open_metric = false
    
      ## Enable listen ports tag, default is false
      enable_listen_ports = false
    
      ## Enable open files field, default is false
      enable_open_files = false
    
      # Extra tags
      [inputs.host_processes.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
      # ...
    
    ```

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can enable the collector via [ConfigMap injection](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [configure ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting).

    Environment variables can also be used to modify configuration parameters (add to ENV_DEFAULT_ENABLED_INPUTS as default collectors):

    - **ENV_INPUT_HOST_PROCESSES_OPEN_METRIC**
    
        Enable process metric collection
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `open_metric`
    
        **Default Value**: false
    
    - **ENV_INPUT_HOST_PROCESSES_PROCESS_NAME**
    
        Process name whitelist
    
        **Field Type**: List
    
        **Collector Configuration Field**: `process_name`
    
        **Example**: `.*datakit.*,guance`
    
    - **ENV_INPUT_HOST_PROCESSES_MIN_RUN_TIME**
    
        Minimum process runtime
    
        **Field Type**: Duration
    
        **Collector Configuration Field**: `min_run_time`
    
        **Default Value**: 10m
    
    - **ENV_INPUT_HOST_PROCESSES_ENABLE_LISTEN_PORTS**
    
        Enable listening ports tag
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_listen_ports`
    
        **Default Value**: false
    
    - **ENV_INPUT_HOST_PROCESSES_TAGS**
    
        Custom tags. If the configuration file has the same named tags, they will be overridden.
    
        **Field Type**: Map
    
        **Collector Configuration Field**: `tags`
    
        **Example**: tag1=value1,tag2=value2

<!-- markdownlint-enable -->

## Metrics {#metric}

By default, all collected data will append a global tag named `host` (tag value is the hostname where DataKit resides). Additional tags can be specified using `[inputs.host_processes.tags]` in the configuration:

```toml
 [inputs.host_processes.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

<!-- markdownlint-disable MD024 -->


### `host_processes`

Collect process metrics, including CPU/memory usage, etc.

- Tags


| Tag | Description |
|  ----  | --------|
|`container_id`|Container ID of the process, only supported on Linux|
|`host`|Host name|
|`pid`|Process ID|
|`process_name`|Process name|
|`username`|Username|

- Field List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cpu_usage`|CPU usage, the percentage of CPU occupied by the process since it was started. This value will be more stable (different from the instantaneous percentage of `top`)|float|percent|
|`cpu_usage_top`|CPU usage, the average CPU usage of the process within a collection cycle|float|percent|
|`mem_used_percent`|Memory usage percentage|float|percent|
|`open_files`|Number of open files (only supports Linux)|int|count|
|`rss`|Resident Set Size (resident memory size)|int|B|
|`threads`|Total number of threads|int|count|




## Objects {#object}




### `host_processes`

Collect data on process objects, including process names, process commands, etc.

- Tags


| Tag | Description |
|  ----  | --------|
|`container_id`|Container ID of the process, only supported on Linux|
|`host`|Host name|
|`listen_ports`|Ports listened by the process|
|`name`|Name field, consisting of `[host-name]_[pid]`|
|`process_name`|Process name|
|`state`|Process status, currently not supported on Windows|
|`username`|Username|

- Field List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cmdline`|Command line parameters for the process|string|-|
|`cpu_usage`|CPU usage, the percentage of CPU occupied by the process since it was started. This value will be more stable (different from the instantaneous percentage of `top`)|float|percent|
|`cpu_usage_top`|CPU usage, the average CPU usage of the process within a collection cycle|float|percent|
|`mem_used_percent`|Memory usage percentage|float|percent|
|`message`|Process details|string|-|
|`open_files`|Number of open files (only supports Linux, and the `enable_open_files` option needs to be turned on)|int|count|
|`pid`|Process ID|int|-|
|`rss`|Resident Set Size (resident memory size)|int|B|
|`start_time`|Process start time|int|msec|
|`started_duration`|Process startup time|int|sec|
|`state_zombie`|Whether it is a zombie process|bool|-|
|`threads`|Total number of threads|int|count|
|`work_directory`|Working directory (Linux only)|string|-|


<!-- markdownlint-enable -->