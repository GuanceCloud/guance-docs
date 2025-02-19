---
title     : '进程'
summary   : '采集进程的指标和对象数据'
tags:
  - '主机'
__int_icon      : 'icon/process'
dashboard :
  - desc  : '进程'
    path  : 'dashboard/zh/process'
monitor   :
  - desc  : '暂无'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

进程采集器可以对系统中各种运行的进程进行实施监控， 获取、分析进程运行时各项指标，包括内存使用率、占用 CPU 时间、进程当前状态、进程监听的端口等，并根据进程运行时的各项指标信息，用户可以在观测云中配置相关告警，使用户了解进程的状态，在进程发生故障时，可以及时对发生故障的进程进行维护。

<!-- markdownlint-disable MD046 -->

???+ attention

    进程采集器（不管是对象还是指标），在 macOS 上可能消耗比较大，导致 CPU 飙升，可以手动将其关闭。目前默认采集器仍然开启进程对象采集器（默认 5min 运行一次）。

<!-- markdownlint-enable MD046 -->

## 配置 {#config}

### 前置条件 {#requirements}

- 进程采集器默认不采集进程指标数据，如需采集指标相关数据，可在 `host_processes.conf` 中 将 `open_metric` 设置为 `true`。比如：

```toml
[[inputs.host_processes]]
    ...
    open_metric = true
```

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->

=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/host` 目录，复制 `host_processes.conf.sample` 并命名为 `host_processes.conf`。示例如下：

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

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    可通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting) 或 [配置 ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) 开启采集器。

    也支持以环境变量的方式修改配置参数（需要在 ENV_DEFAULT_ENABLED_INPUTS 中加为默认采集器）：

    - **ENV_INPUT_HOST_PROCESSES_OPEN_METRIC**
    
        开启进程指标采集
    
        **字段类型**: Boolean
    
        **采集器配置字段**: `open_metric`
    
        **默认值**: false
    
    - **ENV_INPUT_HOST_PROCESSES_PROCESS_NAME**
    
        进程名白名单
    
        **字段类型**: List
    
        **采集器配置字段**: `process_name`
    
        **示例**: `.*datakit.*,guance`
    
    - **ENV_INPUT_HOST_PROCESSES_MIN_RUN_TIME**
    
        进程最短运行时间
    
        **字段类型**: Duration
    
        **采集器配置字段**: `min_run_time`
    
        **默认值**: 10m
    
    - **ENV_INPUT_HOST_PROCESSES_ENABLE_LISTEN_PORTS**
    
        启用监听端口标签
    
        **字段类型**: Boolean
    
        **采集器配置字段**: `enable_listen_ports`
    
        **默认值**: false
    
    - **ENV_INPUT_HOST_PROCESSES_TAGS**
    
        自定义标签。如果配置文件有同名标签，将会覆盖它
    
        **字段类型**: Map
    
        **采集器配置字段**: `tags`
    
        **示例**: tag1=value1,tag2=value2

<!-- markdownlint-enable -->

## 指标 {#metric}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.host_processes.tags]` 指定其它标签：

```toml
 [inputs.host_processes.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

<!-- markdownlint-disable MD024 -->





### `host_processes`

Collect process metrics, including CPU/memory usage, etc.

- 标签


| Tag | Description |
|  ----  | --------|
|`container_id`|Container ID of the process, only supported Linux|
|`host`|Host name|
|`pid`|Process ID|
|`process_name`|Process name|
|`username`|Username|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cpu_usage`|CPU usage, the percentage of CPU occupied by the process since it was started. This value will be more stable (different from the instantaneous percentage of `top`)|float|percent|
|`cpu_usage_top`|CPU usage, the average CPU usage of the process within a collection cycle|float|percent|
|`mem_used_percent`|Memory usage percentage|float|percent|
|`open_files`|Number of open files (only supports Linux)|int|count|
|`rss`|Resident Set Size (resident memory size)|int|B|
|`threads`|Total number of threads|int|count|








## 对象 {#object}









### `host_processes`

Collect data on process objects, including process names, process commands, etc.

- 标签


| Tag | Description |
|  ----  | --------|
|`container_id`|Container ID of the process, only supported Linux|
|`host`|Host name|
|`listen_ports`|The port the process is listening onW|
|`name`|Name field, consisting of `[host-name]_[pid]`|
|`process_name`|Process name|
|`state`|Process status, currently not supported on Windows|
|`username`|Username|

- 字段列表


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
