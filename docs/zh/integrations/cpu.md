---
title     : 'CPU'
summary   : '采集 CPU 指标数据'
__int_icon      : 'icon/cpu'
dashboard :
  - desc  : 'CPU'
    path  : 'dashboard/zh/cpu'
monitor   :
  - desc  : '主机检测库'
    path  : 'monitor/zh/host'
---

<!-- markdownlint-disable MD025 -->
# CPU
<!-- markdownlint-enable -->
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :material-kubernetes: :material-docker:

---

CPU 采集器用于系统 CPU 使用率等指标的采集。

## 配置  {#config}

成功安装 DataKit 并启动后，会默认开启 CPU 采集器，无需手动开启。

<!-- markdownlint-disable MD046 -->

=== "主机部署"

    进入 DataKit 安装目录下的 `conf.d/host` 目录，复制 `cpu.conf.sample` 并命名为 `cpu.conf`。示例如下：

    ```toml
        
    [[inputs.cpu]]
      ## Collect interval, default is 10 seconds. (optional)
      interval = '10s'
      ##
      ## Collect CPU usage per core, default is false. (optional)
      percpu = false
      ##
      ## Setting disable_temperature_collect to false will collect cpu temperature stats for linux.
      ##
      # disable_temperature_collect = false
      enable_temperature = true
      ##
      enable_load5s = true
      ##
      [inputs.cpu.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
    ```

    配置好后，[重启 DataKit](datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    Kubernetes 中支持以环境变量的方式修改配置参数：

    | 环境变量名                                  | 对应的配置参数项              | 参数示例                                                                              |
    | :---                                        | ---                           | ---                                                                                   |
    | `ENV_INPUT_CPU_PERCPU`                      | `percpu`                      | `true/false`                                                                          |
    | `ENV_INPUT_CPU_ENABLE_TEMPERATURE`          | `enable_temperature`          | `true/false`                                                                          |
    | `ENV_INPUT_CPU_TAGS`                        | `tags`                        | `tag1=value1,tag2=value2` 如果配置文件中有同名 tag，会覆盖它                          |
    | `ENV_INPUT_CPU_INTERVAL`                    | `interval`                    | `10s`                                                                                 |
    | `ENV_INPUT_CPU_DISABLE_TEMPERATURE_COLLECT` | `disable_temperature_collect` | `false/true`。给任意字符串就认为是 `true`，没定义就是 `false`。                       |
    | `ENV_INPUT_CPU_ENABLE_LOAD5S`               | `enable_load5s`               | `false/true`。给任意字符串就认为是。给任意字符串就认为是 `true`，没定义就是 `false`。 |

<!-- markdownlint-enable -->

---

## 指标 {#metric}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.cpu.tags]` 指定其它标签：

```toml
 [inputs.cpu.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `cpu`



- 标签


| Tag | Description |
|  ----  | --------|
|`cpu`|CPU core ID. For `cpu-total`, it means *all-CPUs-in-one-tag*. If you want every CPU's metric, please enable `percpu` option in *cpu.conf* or set `ENV_INPUT_CPU_PERCPU` under K8s|
|`host`|System hostname.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`core_temperature`|CPU core temperature. This is collected by default. Only collect the average temperature of all cores.|float|C|
|`load5s`|CPU average load in 5 seconds.|int|-|
|`usage_guest`|% CPU spent running a virtual CPU for guest operating systems.|float|percent|
|`usage_guest_nice`|% CPU spent running a nice guest(virtual CPU for guest operating systems).|float|percent|
|`usage_idle`|% CPU in the idle task.|float|percent|
|`usage_iowait`|% CPU waiting for I/O to complete.|float|percent|
|`usage_irq`|% CPU servicing hardware interrupts.|float|percent|
|`usage_nice`|% CPU in user mode with low priority (nice).|float|percent|
|`usage_softirq`|% CPU servicing soft interrupts.|float|percent|
|`usage_steal`|% CPU spent in other operating systems when running in a virtualized environment.|float|percent|
|`usage_system`|% CPU in system mode.|float|percent|
|`usage_total`|% CPU in total active usage, as well as (100 - usage_idle).|float|percent|
|`usage_user`|% CPU in user mode.|float|percent|


