---
title     : 'System'
summary   : '采集主机系统相关的指标数据'
<<<<<<< HEAD
icon      : 'icon/system'
=======
__int_icon      : 'icon/system'
>>>>>>> bcdb7fa10debda85713fee55db2e1181e9301f46
dashboard :
  - desc  : 'System'
    path  : 'dashboard/zh/system'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# System
<!-- markdownlint-enable -->

<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

System 采集器收集系统负载、正常运行时间、CPU 核心数量以及登录的用户数。

## 配置 {#config}

成功安装 DataKit 并启动后，会默认开启 System 采集器，无需手动开启。

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

    配置好后，[重启 DataKit](datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    支持以环境变量的方式修改配置参数：

    | 环境变量名              | 对应的配置参数项 | 参数示例                                                     |
    | :---                    | ---              | ---                                                          |
    | `ENV_INPUT_SYSTEM_TAGS` | `tags`           | `tag1=value1,tag2=value2` 如果配置文件中有同名 tag，会覆盖它 |
    | `ENV_INPUT_SYSTEM_INTERVAL` | `interval` | `10s` |

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


