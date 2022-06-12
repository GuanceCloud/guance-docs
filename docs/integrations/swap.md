
# Swap

- DataKit 版本：1.4.0
- 文档发布日期：2022-06-12 10:58:47
- 操作系统支持：`windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

swap 采集器用于采集主机 swap 内存的使用情况

## 前置条件

暂无

## 配置

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

配置好后，重启 DataKit 即可。

支持以环境变量的方式修改配置参数（只在 DataKit 以 K8s daemonset 方式运行时生效，主机部署的 DataKit 不支持此功能）：

| 环境变量名            | 对应的配置参数项 | 参数示例                                                     |
| :---                  | ---              | ---                                                          |
| `ENV_INPUT_SWAP_TAGS` | `tags`           | `tag1=value1,tag2=value2` 如果配置文件中有同名 tag，会覆盖它 |
| `ENV_INPUT_SWAP_INTERVAL` | `interval` | `10s` |

## 指标集

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.swap.tags]` 指定其它标签：

``` toml
 [inputs.swap.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `swap`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`host`|主机名|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`free`|Host swap memory total|int|B|
|`in`|Moving data from swap space to main memory of the machine|int|B|
|`out`|Moving main memory contents to swap disk when main memory space fills up|int|B|
|`total`|Host swap memory free|int|B|
|`used`|Host swap memory used|int|B|
|`used_percent`|Host swap memory percentage used|float|percent|


