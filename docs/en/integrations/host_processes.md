---
title     : 'Processes'
summary   : 'Collect metrics and object data for processes'
tags:
  - 'HOST'
__int_icon      : 'icon/process'
dashboard :
  - desc  : 'Processes'
    path  : 'dashboard/en/process'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The process collector can monitor various running processes in the system in real time, obtaining and analyzing various metrics of process execution, including memory usage, CPU time occupied, current process status, ports listened by the process, etc. Based on various metric information of process execution, users can configure relevant alerts in <<< custom_key.brand_name >>>, allowing them to understand the state of processes and maintain faulty processes promptly when issues arise.

<!-- markdownlint-disable MD046 -->

???+ attention

    The process collector (whether objects or metrics) may consume a lot of resources on macOS, leading to high CPU usage. It can be manually turned off if necessary. Currently, the default collector still enables the process object collector (default running once every 5 minutes).

<!-- markdownlint-enable MD046 -->

## Configuration {#config}

### Prerequisites {#requirements}

- The process collector does not collect process metric data by default. To collect metric-related data, set `open_metric` to `true` in `host_processes.conf`. For example:

```toml
[[inputs.host_processes]]
    ...
    open_metric = true
```

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->

=== "Host Installation"

    Navigate to the `conf.d/host` directory under the DataKit installation directory, copy `host_processes.conf.sample` and rename it to `host_processes.conf`. An example is as follows:

    ```toml
        
    [[inputs.host_processes]]
      # Only collect metrics for these matched processes. For process objects,
      # this white list is not applied. Process name supports regexp.
      # process_name = [".*nginx.*", ".*mysql.*"]
    
      # Process minimal run time(default 10m)
      # If process running time is less than the setting, we ignore it(both for metric and object)
      min_run_time = "10m"
    
      ## Enable process metric collecting
      open_metric = false
    
      ## Enable listen ports tag, default is false
      enable_listen_ports = false
    
      ## Enable open files field, default is false
      enable_open_files = false
    
      ## only collect container-based process(object and metric)
      only_container_processes = false
    
      # Extra tags
      [inputs.host_processes.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
      # ...
    
    ```

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can inject the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [configure ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) to enable the collector.

    You can also modify configuration parameters via environment variables (you need to add it to ENV_DEFAULT_ENABLED_INPUTS as a default collector):

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
    
        Enable listening port tags
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_listen_ports`
    
        **Default Value**: false
    
    - **ENV_INPUT_HOST_PROCESSES_TAGS**
    
        Custom tags. If the configuration file has the same named tags, they will overwrite it.
    
        **Field Type**: Map
    
        **Collector Configuration Field**: `tags`
    
        **Example**: tag1=value1,tag2=value2
    
    - **ENV_INPUT_HOST_PROCESSES_ONLY_CONTAINER_PROCESSES**
    
        Only collect container process for metric and object
    
        **Type**: Boolean
    
        **input.conf**: `only_container_processes`
    
        **Default**: false
    
    - **ENV_INPUT_HOST_PROCESSES_METRIC_INTERVAL**
    
        Collect interval on metric
    
        **Type**: Duration
    
        **input.conf**: `metric_interval`
    
        **Default**: 30s
    
    - **ENV_INPUT_HOST_PROCESSES_object_interval**
    
        Collect interval on object
    
        **Type**: Duration
    
        **input.conf**: `object_interval`
    
        **Default**: 300s
<!-- markdownlint-enable MD046 -->

<!-- markdownlint-enable -->

## Metrics {#metric}

By default, all the following data collections will append a global tag named `host` (the tag value is the hostname where DataKit resides). You can also specify other tags through `[inputs.host_processes.tags]` in the configuration:

```toml
 [inputs.host_processes.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

<!-- markdownlint-disable MD024 -->





### `host_processes`

Collects process metrics, including CPU/memory usage, etc.

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
|`nonvoluntary_ctxt_switches`|From /proc/[PID]/status. Context switches that nonvoluntary drop the CPU. Linux only|int|count|
|`open_files`|Number of open files (only supports Linux)|int|count|
|`page_children_major_faults`|Linux from */proc/[PID]/stat*. The number of major page faults for this process. Linux only|int|B|
|`page_children_minor_faults`|Linux from */proc/[PID]/stat*. The number of minor page faults for this process. Linux only|int|B|
|`page_major_faults`|Linux from */proc/[PID]/stat*. The number of major page faults. Linux only|int|B|
|`page_minor_faults`|Linux from */proc/[PID]/stat*. The number of minor page faults. Linux only|int|B|
|`proc_read_bytes`|Linux from */proc/[PID]/io*, Windows from `GetProcessIoCounters()`. Read bytes from disk|int|B|
|`proc_syscr`|Linux from */proc/[PID]/io*, Windows from `GetProcessIoCounters()`. Count of `read()` like syscall`. Linux&Windows only|int|count|
|`proc_syscw`|Linux from */proc/[PID]/io*, Windows from `GetProcessIoCounters()`. Count of `write()` like syscall`. Linux&Windows only|int|count|
|`proc_write_bytes`|Linux from */proc/[PID]/io*, Windows from `GetProcessIoCounters()`. Written bytes to disk|int|B|
|`rss`|Resident Set Size (resident memory size)|int|B|
|`threads`|Total number of threads|int|count|
|`voluntary_ctxt_switches`|From /proc/[PID]/status. Context switches that voluntary drop the CPU, such as `sleep()/read()/sched_yield()`. Linux only|int|count|








## Objects {#object}









### `host_processes`

Collects data on process objects, including process names, process commands, etc.

- Tags


| Tag | Description |
|  ----  | --------|
|`container_id`|Container ID of the process, only supported on Linux|
|`host`|Host name|
|`listen_ports`|The port the process is listening on|
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
|`listen_ports`|The port the process is listening on|string|-|
|`mem_used_percent`|Memory usage percentage|float|percent|
|`message`|Process details|string|-|
|`nonvoluntary_ctxt_switches`|From /proc/[PID]/status. Context switches that nonvoluntary drop the CPU. Linux only|int|count|
|`open_files`|Number of open files (only supports Linux, and the `enable_open_files` option needs to be turned on)|int|count|
|`page_children_major_faults`|Linux from */proc/[PID]/stat*. The number of major page faults of it's child processes. Linux only|int|B|
|`page_children_minor_faults`|Linux from */proc/[PID]/stat*. The number of minor page faults of it's child processes. Linux only|int|B|
|`page_major_faults`|Linux from */proc/[PID]/stat*. The number of major page faults. Linux only|int|B|
|`page_minor_faults`|Linux from */proc/[PID]/stat*. The number of minor page faults. Linux only|int|B|
|`pid`|Process ID|int|-|
|`proc_read_bytes`|Linux from */proc/[PID]/io*, Windows from `GetProcessIoCounters()`. Read bytes from disk|int|B|
|`proc_syscr`|Linux from */proc/[PID]/io*, Windows from `GetProcessIoCounters()`. Count of `read()` like syscall`. Linux&Windows only|int|count|
|`proc_syscw`|Linux from */proc/[PID]/io*, Windows from `GetProcessIoCounters()`. Count of `write()` like syscall`. Linux&Windows only|int|count|
|`proc_write_bytes`|Linux from */proc/[PID]/io*, Windows from `GetProcessIoCounters()`. Written bytes to disk|int|B|
|`rss`|Resident Set Size (resident memory size)|int|B|
|`start_time`|Process start time|int|msec|
|`started_duration`|Process startup time|int|sec|
|`state_zombie`|Whether it is a zombie process|bool|-|
|`threads`|Total number of threads|int|count|
|`voluntary_ctxt_switches`|From /proc/[PID]/status. Context switches that voluntary drop the CPU, such as `sleep()/read()/sched_yield()`. Linux only|int|count|
|`work_directory`|Working directory (Linux only)|string|-|




<!-- markdownlint-enable -->