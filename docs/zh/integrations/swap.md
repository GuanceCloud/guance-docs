---
title     : 'Swap'
summary   : '采集主机 swap 的指标数据'
__int_icon      : 'icon/swap'
dashboard :
  - desc  : 'Swap'
    path  : 'dashboard/zh/swap'
monitor   :
  - desc  : '主机检测库'
    path  : 'monitor/zh/host'
---

<!-- markdownlint-disable MD025 -->
# Swap
<!-- markdownlint-enable -->

<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

swap 采集器用于采集主机 swap 内存的使用情况。

## 配置 {#config}

成功安装 DataKit 并启动后，会默认开启 Swap 采集器，无需手动开启。

<!-- markdownlint-disable MD046 -->

=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/host` 目录，复制 `swap.conf.sample` 并命名为 `swap.conf`。示例如下：

    ```toml
        
    [[inputs.swap]]
      ##(optional) collect interval, default is 10 seconds
      interval = '10s'
      ##
    
    [inputs.swap.tags]
    # some_tag = "some_value"
    # more_tag = "some_other_value"
    
    
    ```

    配置好后，[重启 DataKit](datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    支持以环境变量的方式修改配置参数：

    | 环境变量名                | 对应的配置参数项 | 参数示例                                                     |
    | :---                      | ---              | ---                                                          |
    | `ENV_INPUT_SWAP_TAGS`     | `tags`           | `tag1=value1,tag2=value2` 如果配置文件中有同名 tag，会覆盖它 |
    | `ENV_INPUT_SWAP_INTERVAL` | `interval`       | `10s`                                                        |

<!-- markdownlint-enable -->

## 指标 {#metric}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.swap.tags]` 指定其它标签：

```toml
[inputs.swap.tags]
 # some_tag = "some_value"
 # more_tag = "some_other_value"
 # ...
```



### `swap`

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|hostname|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`free`|Host swap memory total.|int|B|
|`in`|Moving data from swap space to main memory of the machine.|int|B|
|`out`|Moving main memory contents to swap disk when main memory space fills up.|int|B|
|`total`|Host swap memory free.|int|B|
|`used`|Host swap memory used.|int|B|
|`used_percent`|Host swap memory percentage used.|float|percent|


