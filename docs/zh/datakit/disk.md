
# Disk
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

disk 采集器用于主机磁盘信息采集，如磁盘存储空间、inodes 使用情况等。

## 前置条件 {#requirements}

暂无


## 配置 {#config}

=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/host` 目录，复制 `disk.conf.sample` 并命名为 `disk.conf`。示例如下：
    ```toml
        
    [[inputs.disk]]
      ##(optional) collect interval, default is 10 seconds
      interval = '10s'
    
      # Physical devices only (e.g. hard disks, cd-rom drives, USB keys)
      # and ignore all others (e.g. memory partitions such as /dev/shm)
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

    配置好后，[重启 DataKit](datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    支持以环境变量的方式修改配置参数：
    
    | 环境变量名                            | 对应的配置参数项       | 参数示例                                                                                 |
    | ---                                   | ---                    | ---                                                                                      |
    | `ENV_INPUT_DISK_EXCLUDE_DEVICE`       | `exclude_device`       | `"/dev/loop0","/dev/loop1"` 以英文逗号隔开                      |
    | `ENV_INPUT_DISK_EXTRA_DEVICE`         | `extra_device`         | `"/nfsdata"` 以英文逗号隔开                      |
    | `ENV_INPUT_DISK_TAGS`                 | `tags`                 | `tag1=value1,tag2=value2` 如果配置文件中有同名 tag，会覆盖它                             |
    | `ENV_INPUT_DISK_ONLY_PHYSICAL_DEVICE` | `only_physical_device` | 忽略非物理磁盘（如网盘、NFS 等，只采集本机硬盘/CD ROM/USB 磁盘等）任意给一个字符串值即可 |
    | `ENV_INPUT_DISK_INTERVAL`             | `interval`             | `10s`                                                                                    |

## 指标集 {#measurements}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.disk.tags]` 指定其它标签：

``` toml
 [inputs.disk.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `disk`

-  标签


| Tag | Descrition |
|  ----  | --------|
|`device`|Disk device name.|
|`fstype`|File system name.|
|`host`|System hostname.|
|`mode`|Read-write mode.|
|`path`|Disk mount point.|

- 指标列表


| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`free`|Free disk size in bytes.|int|B|
|`inodes_free`|Free inodes(**DEPRECATED: use inodes_free_mb instead**).|int|count|
|`inodes_free_mb`|Free inodes(in MB).|int|count|
|`inodes_total`|Total inodes(**DEPRECATED: use inodes_total_mb instead**).|int|count|
|`inodes_total_mb`|Total inodes(in MB).|int|count|
|`inodes_used`|Used inodes(**DEPRECATED: use inodes_used_mb instead**).|int|count|
|`inodes_used_mb`|Used inodes(in MB).|int|count|
|`total`|Total disk size in bytes.|int|B|
|`used`|Used disk size in bytes.|int|B|
|`used_percent`|Used disk size in percent.|float|percent|


