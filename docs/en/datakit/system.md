
# System
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The system collector collects system load, uptime, the number of CPU cores, and the number of users logged in.

## Preconditions {#requrements}

None

## Configuration {#config}

=== "Host Installation"

    Go to the `conf.d/host` directory under the DataKit installation directory, copy `system.conf.sample` and name it `system.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.system]]
      ##(optional) collect interval, default is 10 seconds
      interval = '10s'
    
      [inputs.system.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
    ```
    
    After configuration, restart DataKit.

=== "Kubernetes"

    Modifying configuration parameters as environment variables is supported:
    
    | Environment variable name              | Corresponding configuration parameter item | Parameter example                                                     |
    | :---                    | ---              | ---                                                          |
    | `ENV_INPUT_SYSTEM_TAGS` | `tags`           | `tag1=value1,tag2=value2`. If there is a tag with the same name in the configuration file, it will be overwritten. |
    | `ENV_INPUT_SYSTEM_INTERVAL` | `interval` | `10s` |

---

## Measurements {#measurements}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration through `[inputs.system.tags]`:

``` toml
 [inputs.system.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `system`

系统运行基础信息

- tag


| 标签名 | 描述    |
|  ----  | --------|
|`host`|主机名|

- metric list


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`load1`|过去 1 分钟的 CPU 平均负载|float|-|
|`load15`|过去 15 分钟的 CPU 平均负载|float|-|
|`load15_per_core`|每个核心过去 15 分钟的 CPU 平均负载|float|-|
|`load1_per_core`|每个核心过去 1 分钟的 CPU 平均负载|float|-|
|`load5`|过去 5 分钟的 CPU 平均负载|float|-|
|`load5_per_core`|每个核心过去 5 分钟的 CPU 平均负载|float|-|
|`n_cpus`|CPU 逻辑核心数|int|count|
|`n_users`|用户数|int|count|
|`uptime`|系统运行时间|int|s|



### `conntrack`

系统网络连接指标（仅 Linux 支持）

- tag


| 标签名 | 描述    |
|  ----  | --------|
|`host`|主机名|

- metric list


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`entries`|当前连接数量|int|count|
|`entries_limit`|连接跟踪表的大小|int|count|
|`stat_drop`|跟踪失败被丢弃的包数目|int|count|
|`stat_early_drop`|由于跟踪表满而导致部分已跟踪包条目被丢弃的数目|int|count|
|`stat_found`|成功的搜索条目数目|int|count|
|`stat_ignore`|已经被跟踪的报数目|int|count|
|`stat_insert`|插入的包数目|int|count|
|`stat_insert_failed`|插入失败的包数目|int|count|
|`stat_invalid`|不能被跟踪的包数目|int|count|
|`stat_search_restart`|由于hash表大小修改而导致跟踪表查询重启的数目|int|count|



### `filefd`

系统文件句柄指标（仅 Linux 支持）

- tag


| 标签名 | 描述    |
|  ----  | --------|
|`host`|主机名|

- metric list


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`allocated`|已分配文件句柄的数目|int|count|
|`maximum_mega`|文件句柄的最大数目, 单位 M(10^6)|float|count|


