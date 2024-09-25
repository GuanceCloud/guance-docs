---
title     : 'System'
summary   : '采集主机系统相关的指标数据'
tags:
  - '主机'
__int_icon      : 'icon/system'
dashboard :
  - desc  : 'System'
    path  : 'dashboard/zh/system'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

System 采集器收集系统负载、正常运行时间、CPU 核心数量以及登录的用户数。

## 配置 {#config}

成功安装 DataKit 并启动后，会默认开启 System 采集器，无需手动开启。

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->

=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/host` 目录，复制 `system.conf.sample` 并命名为 `system.conf`。示例如下：

    ```toml
        
    [[inputs.system]]
      ##(optional) collect interval, default is 10 seconds
      interval = '10s'
    
      [inputs.system.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
    ```

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    可通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting) 或 [配置 ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) 开启采集器。

    也支持以环境变量的方式修改配置参数（需要在 ENV_DEFAULT_ENABLED_INPUTS 中加为默认采集器）：

    - **ENV_INPUT_SYSTEM_INTERVAL**
    
        采集器重复间隔时长
    
        **字段类型**: TimeDuration
    
        **采集器配置字段**: `interval`
    
        **默认值**: 10s
    
    - **ENV_INPUT_SYSTEM_TAGS**
    
        自定义标签。如果配置文件有同名标签，将会覆盖它
    
        **字段类型**: Map
    
        **采集器配置字段**: `tags`
    
        **示例**: tag1=value1,tag2=value2

<!-- markdownlint-enable -->

---

## 指标 {#metric}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.system.tags]` 指定其它标签：

```toml
 [inputs.system.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `system`

Basic information about system operation.

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|hostname|

- 指标列表


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

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|hostname|

- 指标列表


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

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|hostname|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`allocated`|The number of allocated file handles.|int|count|
|`maximum_mega`|The maximum number of file handles, unit M(10^6).|float|count|



## FAQ {#faq}

### 为什么没有 `cpu_total_usage` 指标？ {#no-cpu}

CPU 部分采集功能不支持部分平台，如 macOS。
