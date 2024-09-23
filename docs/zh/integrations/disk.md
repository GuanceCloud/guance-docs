---
title     : '磁盘'
summary   : '采集磁盘的指标数据'
tags:
  - '主机'
__int_icon      : 'icon/disk'
dashboard :
  - desc  : '磁盘'
    path  : 'dashboard/zh/disk'
monitor   :
  - desc  : '主机检测库'
    path  : 'monitor/zh/host'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

磁盘采集器用于主机磁盘信息采集，如磁盘存储空间、Inode 使用情况等。

## 配置 {#config}

成功安装 DataKit 并启动后，会默认开启 Disk 采集器，无需手动开启。

<!-- markdownlint-disable MD046 -->

=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/host` 目录，复制 `disk.conf.sample` 并命名为 `disk.conf`。示例如下：

    ```toml
        
    [[inputs.disk]]
      ##(optional) collect interval, default is 10 seconds
      interval = '10s'
    
      ## Physical devices only (e.g. hard disks, cd-rom drives, USB keys)
      ## and ignore all others (e.g. memory partitions such as /dev/shm)
      only_physical_device = false
    
      ## Deprecated
      # ignore_mount_points = ["/"]
    
      ## Deprecated
      # mount_points = ["/"]
    
      ## Deprecated
      # ignore_fs = ["tmpfs", "devtmpfs", "devfs", "iso9660", "overlay", "aufs", "squashfs"]
    
      ## Deprecated
      # fs = ["ext2", "ext3", "ext4", "NTFS"]
    
      ## We collect all devices prefixed with dev by default,If you want to collect additional devices, it's in extra_device add
      # extra_device = ["/nfsdata"]
    
      ## exclude some with dev prefix (We collect all devices prefixed with dev by default)
      # exclude_device = ["/dev/loop0","/dev/loop1"]
    
      [inputs.disk.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
    ```

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    可通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting) 或 [配置 ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) 开启采集器。

    也支持以环境变量的方式修改配置参数（需要在 ENV_DEFAULT_ENABLED_INPUTS 中加为默认采集器）：

    - **ENV_INPUT_DISK_INTERVAL**
    
        采集器重复间隔时长
    
        **字段类型**: TimeDuration
    
        **采集器配置字段**: `interval`
    
        **默认值**: 10s
    
    - **ENV_INPUT_DISK_EXTRA_DEVICE**
    
        额外的设备前缀。（默认收集以 dev 为前缀的所有设备）
    
        **字段类型**: List
    
        **采集器配置字段**: `extra_device`
    
        **示例**: `/nfsdata,other_data`
    
    - **ENV_INPUT_DISK_EXCLUDE_DEVICE**
    
        排除的设备前缀。（默认收集以 dev 为前缀的所有设备）
    
        **字段类型**: List
    
        **采集器配置字段**: `exclude_device`
    
        **示例**: /dev/loop0,/dev/loop1
    
    - **ENV_INPUT_DISK_ONLY_PHYSICAL_DEVICE**
    
        忽略非物理磁盘（如网盘、NFS 等，只采集本机硬盘/CD ROM/USB 磁盘等）
    
        **字段类型**: Boolean
    
        **采集器配置字段**: `only_physical_device`
    
        **默认值**: false
    
    - **ENV_INPUT_DISK_TAGS**
    
        自定义标签。如果配置文件有同名标签，将会覆盖它
    
        **字段类型**: Map
    
        **采集器配置字段**: `tags`
    
        **示例**: tag1=value1,tag2=value2

<!-- markdownlint-enable -->

## 指标 {#metric}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.disk.tags]` 指定其它标签：

```toml
 [inputs.disk.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `disk`

- 标签


| Tag | Description |
|  ----  | --------|
|`device`|Disk device name. (on /dev/mapper return symbolic link, like `readlink /dev/mapper/*` result)|
|`fstype`|File system name.|
|`host`|System hostname.|
|`mount_point`|Mount point.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`free`|Free disk size in bytes.|int|B|
|`inodes_free`|Free Inode(**DEPRECATED: use inodes_free_mb instead**).|int|count|
|`inodes_free_mb`|Free Inode(need to multiply by 10^6).|int|count|
|`inodes_total`|Total Inode(**DEPRECATED: use inodes_total_mb instead**).|int|count|
|`inodes_total_mb`|Total Inode(need to multiply by 10^6).|int|count|
|`inodes_used`|Used Inode(**DEPRECATED: use inodes_used_mb instead**).|int|count|
|`inodes_used_mb`|Used Inode(need to multiply by 10^6).|int|count|
|`inodes_used_percent`|Inode used percent|float|percent|
|`total`|Total disk size in bytes.|int|B|
|`used`|Used disk size in bytes.|int|B|
|`used_percent`|Used disk size in percent.|float|percent|


