
# System
---

- DataKit 版本：1.4.6
- 操作系统支持：:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple:

system 采集器收集系统负载、正常运行时间、CPU 核心数量以及登录的用户数。

![](imgs/input-system-01.png)

## 前置条件

无

## 配置

进入 DataKit 安装目录下的 `conf.d/host` 目录，复制 `system.conf.sample` 并命名为 `system.conf`。示例如下：

```toml

[[inputs.system]]
  ##(optional) collect interval, default is 10 seconds
  interval = '10s'

  [inputs.system.tags]
    # some_tag = "some_value"
    # more_tag = "some_other_value"

```

配置好后，重启 DataKit 即可。

支持以环境变量的方式修改配置参数（只在 DataKit 以 K8s daemonset 方式运行时生效，主机部署的 DataKit 不支持此功能）：

| 环境变量名              | 对应的配置参数项 | 参数示例                                                     |
| :---                    | ---              | ---                                                          |
| `ENV_INPUT_SYSTEM_TAGS` | `tags`           | `tag1=value1,tag2=value2` 如果配置文件中有同名 tag，会覆盖它 |
| `ENV_INPUT_SYSTEM_INTERVAL` | `interval` | `10s` |

## 指标预览

![](imgs/input-system-02.png)

## 指标集

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.system.tags]` 指定其它标签：

``` toml
 [inputs.system.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `system`

系统运行基础信息

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`host`|主机名|

- 指标列表


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

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`host`|主机名|

- 指标列表


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

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`host`|主机名|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`allocated`|已分配文件句柄的数目|int|count|
|`maximum_mega`|文件句柄的最大数目, 单位 M(10^6)|float|count|



## 场景视图

<场景 - 新建仪表板 - 内置模板库 - System>

## 异常检测

<监控 - 模板新建 - 主机检测库>
