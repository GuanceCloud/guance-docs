<!-- This file required to translate to EN. -->
# Demo 采集器
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

这只是个采集器开发示例。

注意

- 这里进行文档描述的时候，一些英文描述，比如 `Oracle`，不要写成 `oracle`，`NGINX` 不应该写成 `nginx`，至少也应该写成 `Nginx`。这写都是一些专用名词
- 中英文之间用空格，比如：`这是一个 Oracle 采集器`。不要写成 `这是一个Oracle采集器`
- 不要滥用代码字体，比如 DataFlux 不要写成 `DataFlux`
- 这里统一用中文标点符号

## 前置条件 {#requirements}

注意：

- 这里尽量说明下必要前置条件，比如 Redis 版本要求，需要额外安装的软件等等
- 这里不用加 `安装 DataKit` 这个条件，实属废话

## 配置 {#config}

进入 DataKit 安装目录下的 `conf.d/testing` 目录，复制 `demo.conf.sample` 并命名为 `demo.conf`。示例如下：

```toml

[inputs.demo]
  ## 这里是一些测试配置

  # 是否开启 CPU 爆满
  eat_cpu = false

  ## Set true to enable election
  election = true

[inputs.demo.tags] # 所有采集器，都应该有 tags 配置项
  # tag_a = "val1"
  # tag_b = "val2"
 
```

Sample 注意事项：

1. 这里不要写太多英文描述
2. 请做好 sample 格式化（对齐好格式），不要用 tab 缩进，统一用空格。因为用户终端 tab 宽度显示可能有差异
3. 一些分段点，如 `[[inputs.oracle.options]]`，不要加注释，因为部分用户改完 `options` 下的配置后，可能会忘记打开这一行的配置，导致解析失败（用户甚至不知道需要打开这一行）
4. 一些默认打开的选项，不要注释掉了，不然用户使用的时候，还要手动去打开
5. 当某些采集器无需额外配置时，在 sample 中加一行 `# 这里无需额外配置`，让用户知道不用其它配置了
6. 总体原则是，配置项能不注释就不注释

配置好后，重启 DataKit 即可。

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.demo.tags]` 指定其它标签：

``` toml
 [inputs.demo.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

## 指标 {#M}





### `demo-metric`
这是一个指标集的 demo(**务必加上每个指标集的描述**)

-  标签


| Tag | Description |
|  ----  | --------|
|`tag_a`|示例 tag A|
|`tag_b`|示例 tag B|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`disk_size`|this is disk size|int|B|
|`mem_size`|this is memory size|int|B|
|`ok`|some boolean field|bool|-|
|`some_string`|some string field|string|-|
|`usage`|this is CPU usage|float|percent|






### `demo-metric2`
这是一个指标集的 demo(**务必加上每个指标集的描述**)

-  标签


| Tag | Description |
|  ----  | --------|
|`tag_a`|示例 tag A|
|`tag_b`|示例 tag B|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`disk_size`|this is disk size|int|B|
|`mem_size`|this is memory size|int|B|
|`ok`|some boolean field|bool|-|
|`some_string`|some string field|string|-|
|`usage`|this is CPU usage|float|percent|












## 对象 {#O}













### `demo-obj`

这是一个对象的 demo(**务必加上每个指标集的描述**)

-  标签


| Tag | Description |
|  ----  | --------|
|`tag_a`|示例 tag A|
|`tag_b`|示例 tag B|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`disk_size`|this is disk size|int|B|
|`mem_size`|this is memory size|int|B|
|`ok`|some boolean field|bool|-|
|`some_string`|some string field|string|-|
|`usage`|this is CPU usage|float|percent|








## 日志 {#L}

















### `demo-log`

这是一个日志的 demo(**务必加上每个指标集的描述**)

-  标签


| Tag | Description |
|  ----  | --------|
|`tag_a`|示例 tag A|
|`tag_b`|示例 tag B|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`disk_size`|this is disk size|int|B|
|`mem_size`|this is memory size|int|B|
|`ok`|some boolean field|bool|-|
|`some_string`|some string field|string|-|
|`usage`|this is CPU usage|float|percent|



