---
title     : 'Lsblk'
summary   : '采集块设备的指标数据'
tags:
  - '主机'
__int_icon      : 'icon/disk'
dashboard :
  - desc  : 'lsblk'
    path  : 'dashboard/lsblk'
---

:fontawesome-brands-linux: :material-kubernetes: :material-docker:

---

lsblk 采集器用于 Linux 主机块设备信息采集，如设备名称、主次设备号、文件系统可用大小、文件系统类型、文件系统已用大小、文件系统使用百分比、设备挂载位置等。

## 配置 {#config}

<!-- markdownlint-disable MD046 -->

=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/host` 目录，复制 `lsblk.conf.sample` 并命名为 `lsblk.conf`。示例如下：

    ```toml
        
    [[inputs.lsblk]]
      ##(optional) collect interval, default is 10 seconds
      interval = '10s'
      # exclude_device = ['/dev/sda1','/dev/sda2']
    
    [inputs.lsblk.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    ```

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    可通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting) 或 [配置 ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) 开启采集器。

    也支持以环境变量的方式修改配置参数（需要在 ENV_DEFAULT_ENABLED_INPUTS 中加为默认采集器）：

    - **ENV_INPUT_LSBLK_INTERVAL**
    
        采集器重复间隔时长
    
        **字段类型**: Duration
    
        **采集器配置字段**: `interval`
    
        **默认值**: `10s`
    
    - **ENV_INPUT_LSBLK_EXCLUDE_DEVICE**
    
        排除的设备前缀。（默认收集以 dev 为前缀的所有设备）
    
        **字段类型**: List
    
        **采集器配置字段**: `exclude_device`
    
        **示例**: /dev/loop0,/dev/loop1

<!-- markdownlint-enable -->

## 指标 {#metric}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.lsblk.tags]` 指定其它标签：

```toml
 [inputs.lsblk.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `lsblk`

- 标签


| Tag | Description |
|  ----  | --------|
|`fstype`|Filesystem type.|
|`group`|Group name.|
|`kname`|Internal kernel device name.|
|`label`|Filesystem LABEL.|
|`maj_min`|Major:Minor device number.|
|`model`|Device identifier.|
|`mountpoint`|Where the device is mounted.|
|`name`|Device name.|
|`owner`|User name.|
|`parent`|Parent device name.|
|`serial`|Disk serial number.|
|`state`|State of the device.|
|`type`|Device type.|
|`uuid`|Filesystem UUID.|
|`vendor`|Device vendor.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`fs_used_percent`|Percentage of used space on the filesystem.|float|percent|
|`fsavail`|Available space on the filesystem.|int|B|
|`fssize`|Total size of the filesystem.|int|B|
|`fsused`|Used space on the filesystem.|int|B|
|`rq_size`|Request queue size.|int|B|
|`size`|Size of the device.|int|B|


