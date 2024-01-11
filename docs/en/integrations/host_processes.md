---
title     : 'Process'
summary   : 'Collect host process and it's metrics'
__int_icon      : 'icon/process'
dashboard :
  - desc  : 'process'
    path  : 'dashboard/en/process'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Process
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The process collector can monitor various running processes in the system, acquire and analyze various metrics when the process is running, Including memory utilization rate, CPU time occupied, current state of the process, port of process monitoring, etc. According to various index information of process running, users can configure relevant alarms in Guance Cloud, so that users can know the state of the process, and maintain the failed process in time when the process fails.

<!-- markdownlint-disable MD046 -->

???+ attention

    Process collectors (whether objects or metrics) may consume a lot on macOS, causing CPU to soar, so you can turn them off manually. At present, the default collector still turns on the process object collector (it runs once every 5min by default).

<!-- markdownlint-enable -->

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
    
      # Extra tags
      [inputs.host_processes.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
      # ...
    
    ```
    
    Once configured, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    It supports modifying configuration parameters as environment variables (effective only when the DataKit is running in K8s daemonset mode, which is not supported for host-deployed DataKits):
    
    | Environment Variable Name                              | Corresponding Configuration Parameter Item | Parameter Example                                                     |
    | :---                                    | ---              | ---                                                          |
    | `ENV_INPUT_HOST_PROCESSES_OPEN_METRIC`  | `open_metric`    | `true`/`false`                                               |
    | `ENV_INPUT_HOST_PROCESSES_TAGS`         | `tags`           | `tag1=value1,tag2=value2`, If there is a tag with the same name in the configuration file, it will be overwritten |
    | `ENV_INPUT_HOST_PROCESSES_PROCESS_NAME` | `process_name`   | `".*datakit.*", "guance"`, separated by English commas                     |
    | `ENV_INPUT_HOST_PROCESSES_MIN_RUN_TIME` | `min_run_time`   | `"10m"`                                                      |
    | `ENV_INPUT_HOST_PROCESSES_ENABLE_LISTEN_PORTS` | `enable_listen_ports`   | `true`/`false`                                                     |
    | `ENV_INPUT_HOST_PROCESSES_ENABLE_OPEN_FILES` | `enable_open_files`   |`true`/`false`                                                      |

<!-- markdownlint-enable -->

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

- tag


| Tag | Description |
|  ----  | --------|
|`host`|Host name|
|`pid`|Process ID|
|`process_name`|Process name|
|`username`|Username|

- field list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cpu_usage`|CPU usage, the percentage of CPU occupied by the process since it was started. This value will be more stable (different from the instantaneous percentage of `top`)|float|percent|
|`cpu_usage_top`|CPU usage, the average CPU usage of the process within a collection cycle|float|percent|
|`mem_used_percent`|Memory usage percentage|float|percent|
|`open_files`|Number of open files (only supports Linux)|int|count|
|`rss`|Resident Set Size (resident memory size)|int|B|
|`threads`|Total number of threads|int|count| 








## Object {#object}









### `host_processes`

Collect data on process objects, including process names, process commands, etc.

- tag


| Tag | Description |
|  ----  | --------|
|`host`|Host name|
|`listen_ports`|The port the process is listening onW|
|`name`|Name field, consisting of `[host-name]_[pid]`|
|`process_name`|Process name|
|`state`|Process status, currently not supported on Windows|
|`username`|Username|

- field list


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
|`start_time`|process start time|int|msec|
|`started_duration`|Process startup time|int|sec|
|`state_zombie`|Whether it is a zombie process|bool|-|
|`threads`|Total number of threads|int|count|
|`work_directory`|Working directory (Linux only)|string|-| 



<!-- markdownlint-enable -->
