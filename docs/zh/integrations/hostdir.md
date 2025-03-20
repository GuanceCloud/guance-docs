---
title     : '文件目录'
summary   : '采集文件目录的指标数据'
tags:
  - '主机'
__int_icon      : 'icon/hostdir'
dashboard :
  - desc  : '文件目录'
    path  : 'dashboard/zh/hostdir'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

主机目录采集器用于目录文件的采集，例如文件个数、所有文件大小等。

## 配置 {#config}

<!-- markdownlint-disable MD046 -->
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

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

## 指标 {#metric}

以下所有指标集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.hostdir.tags]` 指定其它标签：

``` toml
 [inputs.hostdir.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `hostdir`

- 标签


| Tag | Description |
|  ----  | --------|
|`file_ownership`|File ownership.|
|`file_system`|File system type.|
|`host_directory`|The start Dir.|
|`mount_point`|Mount point.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`dir_count`|The number of Dir.|int|count|
|`file_count`|The number of files.|int|count|
|`file_size`|The size of files.|int|B|
|`free`|Free disk size in bytes.|int|B|
|`inodes_free`|Free inode.|int|count|
|`inodes_total`|Total inode.|int|count|
|`inodes_used`|Used inode(only this dir used).|int|count|
|`inodes_used_percent`|Inode used percent(only this dir used in total inode).|float|percent|
|`total`|Total disk size in bytes.|int|B|
|`used_percent`|Used disk size in percent(only this dir used in total size).|float|percent|


