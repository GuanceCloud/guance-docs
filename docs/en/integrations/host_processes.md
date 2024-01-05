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

采集进程指标数据，包括 CPU/内存使用率等

- tag


| Tag | Description |
|  ----  | --------|
|`host`|主机名|
|`pid`|进程 ID|
|`process_name`|进程名|
|`username`|用户名|

- field list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cpu_usage`|CPU 使用占比，进程自启动以来所占 CPU 百分比，该值相对会比较稳定（跟 `top` 的瞬时百分比不同）|float|percent|
|`cpu_usage_top`|CPU 使用占比，一个采集周期内的进程的 CPU 使用率均值|float|percent|
|`mem_used_percent`|内存使用占比|float|percent|
|`open_files`|打开文件个数(仅支持 Linux, 且需开启 `enable_open_files` 选项)|int|count|
|`rss`|Resident Set Size （常驻内存大小）|int|B|
|`threads`|线程数|int|count| 








## Object {#object}









### `host_processes`

采集进程对象的数据，包括进程名，进程命令等

- tag


| Tag | Description |
|  ----  | --------|
|`host`|主机名|
|`listen_ports`|进程正在监听的端口。对应配置文件的 `enable_listen_ports`，默认为 false，不携带此字段|
|`name`|name 字段，由 `[host-name]_[pid]` 组成|
|`process_name`|进程名|
|`state`|进程状态，暂不支持 Windows|
|`username`|用户名|

- field list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cmdline`|进程的命令行参数|string|-|
|`cpu_usage`|CPU 使用占比（%*100），进程自启动以来所占 CPU 百分比，该值相对会比较稳定（跟 `top` 的瞬时百分比不同）|float|percent|
|`cpu_usage_top`|CPU 使用占比（%*100）, 一个采集周期内的进程的 CPU 使用率均值|float|percent|
|`mem_used_percent`|内存使用占比（%*100）|float|percent|
|`message`|进程详细信息|string|-|
|`open_files`|打开的文件个数(仅支持 Linux, 且需开启 `enable_open_files` 选项)|int|count|
|`pid`|进程 ID|int|-|
|`rss`|Resident Set Size （常驻内存大小）|int|B|
|`start_time`|进程启动时间|int|msec|
|`started_duration`|进程启动时长|int|sec|
|`state_zombie`|是否是僵尸进程|bool|-|
|`threads`|线程数|int|count|
|`work_directory`|工作目录(仅支持 Linux)|string|-| 



<!-- markdownlint-enable -->
