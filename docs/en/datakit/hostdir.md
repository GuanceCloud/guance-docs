<!-- This file required to translate to EN. -->

# 主机目录
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

hostdir 采集器用于目录文件的采集，例如文件个数，所有文件大小等。

## 前置条件 {#requrements}

暂无

## 配置 {#config}

=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/host` 目录，复制 `hostdir.conf.sample` 并命名为 `hostdir.conf`。示例如下：
    
    ```toml
        
    [[inputs.hostdir]]
      interval = "10s"
    
      # directory to collect
      # Windows example: C:\\Users
      # UNIX-like example: /usr/local/
      dir = "" # required
    
    	# optional, i.e., "*.exe", "*.so"
      exclude_patterns = []
    
    [inputs.hostdir.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    ```

    配置好后，[重启 DataKit](datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](datakit-daemonset-deploy.md#configmap-setting)来开启采集器。


## 指标集 {#measurements}

以下所有指标集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.hostdir.tags]` 指定其它标签：

``` toml
 [inputs.hostdir.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `hostdir`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`file_ownership`|file ownership|
|`file_system`|file system type|
|`host_directory`|the start Dir|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`dir_count`|The number of Dir|int|count|
|`file_count`|The number of files|int|count|
|`file_size`|The size of files|int|count|

