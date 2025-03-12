---
title     : 'Process'
summary   : 'Collect host process metrics'
tags:
  - 'HOST'
__int_icon      : 'icon/process'
dashboard :
  - desc  : 'process'
    path  : 'dashboard/en/process'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The process collector can monitor various running processes in the system, acquire and analyze various metrics when the process is running, Including memory utilization rate, CPU time occupied, current state of the process, port of process monitoring, etc. According to various index information of process running, users can configure relevant alarms in Guance Cloud, so that users can know the state of the process, and maintain the failed process in time when the process fails.

<!-- markdownlint-disable MD046 -->
???+ attention

    Process collectors (whether objects or metrics) may consume a lot on macOS, causing CPU to soar, so you can turn them off manually. At present, the default collector still turns on the process object collector (it runs once every 5min by default).
<!-- markdownlint-enable MD046 -->

## Configuration {#config}

### Preconditions {#requirements}

- The process collector does not collect process metrics by default. To collect metrics-related data, set `open_metric` to `true` in `host_processes.conf`. For example:

```toml
[[inputs.host_processes]]
    ...
     open_metric = true
```

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Go to the `conf.d/host` directory under the DataKit installation directory, copy `host_processes.conf.sample` and name it `host_processes.conf`. Examples are as follows:

    ```toml
        
    [[inputs.host_processes]]
      # Only collect these matched process' metrics. For process objects
      # these white list not applied. Process name support regexp.
      # process_name = [".*nginx.*", ".*mysql.*"]
    
      # Process minimal run time(default 10m)
      # If process running time less than the setting, we ignore it(both for metric and object)
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

    Once configured, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Can be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [Config ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) .

    Can also be turned on by environment variables, (needs to be added as the default collector in ENV_DEFAULT_ENABLED_INPUTS):

    - **ENV_INPUT_HOST_PROCESSES_OPEN_METRIC**
    
        Enable process metric collecting
    
        **Type**: Boolean
    
        **input.conf**: `open_metric`
    
        **Default**: false
    
    - **ENV_INPUT_HOST_PROCESSES_PROCESS_NAME**
    
        Whitelist of process
    
        **Type**: List
    
        **input.conf**: `process_name`
    
        **Example**: `.*datakit.*,guance`
    
    - **ENV_INPUT_HOST_PROCESSES_MIN_RUN_TIME**
    
        Process minimal run time
    
        **Type**: Duration
    
        **input.conf**: `min_run_time`
    
        **Default**: 10m
    
    - **ENV_INPUT_HOST_PROCESSES_ENABLE_LISTEN_PORTS**
    
        Enable listen ports tag
    
        **Type**: Boolean
    
        **input.conf**: `enable_listen_ports`
    
        **Default**: false
    
    - **ENV_INPUT_HOST_PROCESSES_TAGS**
    
        Customize tags. If there is a tag with the same name in the configuration file, it will be overwritten
    
        **Type**: Map
    
        **input.conf**: `tags`
    
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

## Metric {#metric}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.host_processes.tags]`:

``` toml
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
|`container_id`|Container ID of the process, only supported Linux|
|`host`|Host name|
|`pid`|Process ID|
|`process_name`|Process name|
|`username`|Username|

- Metrics


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








## Object {#object}









### `host_processes`

Collect data on process objects, including process names, process commands, etc.

- Tags


| Tag | Description |
|  ----  | --------|
|`container_id`|Container ID of the process, only supported Linux|
|`host`|Host name|
|`name`|Name field, consisting of `[host-name]_[pid]`|
|`process_name`|Process name|
|`state`|Process status, currently not supported on Windows|
|`username`|Username|

- Metrics


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
|`start_time`|process start time|int|msec|
|`started_duration`|Process startup time|int|sec|
|`state_zombie`|Whether it is a zombie process|bool|-|
|`threads`|Total number of threads|int|count|
|`voluntary_ctxt_switches`|From /proc/[PID]/status. Context switches that voluntary drop the CPU, such as `sleep()/read()/sched_yield()`. Linux only|int|count|
|`work_directory`|Working directory (Linux only)|string|-|



<!-- markdownlint-enable -->
