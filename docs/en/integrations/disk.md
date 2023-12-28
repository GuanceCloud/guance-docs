---
title     : 'Disk'
summary   : 'Collect metrics of disk'
__int_icon      : 'icon/disk'
dashboard :
  - desc  : 'disk'
    path  : 'dashboard/en/disk'
monitor   :
  - desc  : 'host detection library'
    path  : 'monitor/en/host'
---

<!-- markdownlint-disable MD025 -->
# Disk
<!-- markdownlint-enable -->

<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Disk collector is used to collect disk information, such as disk storage space, inodes usage, etc.

## Configuration {#config}

After successfully installing and starting DataKit, the disk collector will be enabled by default without the need for manual activation.

<!-- markdownlint-disable MD046 -->


=== "Host Installation"

    Go to the `conf.d/host` directory under the DataKit installation directory, copy `disk.conf.sample` and name it `disk.conf`. Examples are as follows:


​    
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
    
    Once configured, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Supports modifying configuration parameters as environment variables:
    
    | Environment Variable Name                            | Corresponding Configuration Parameter Item       | Parameter Example                                                                                 |
    | ---                                   | ---                    | ---                                                                                      |
    | `ENV_INPUT_DISK_EXCLUDE_DEVICE`       | `exclude_device`       | `"/dev/loop0","/dev/loop1"`, separated by English commas                      |
    | `ENV_INPUT_DISK_EXTRA_DEVICE`         | `extra_device`         | `"/nfsdata"`， separated by English commas                        |
    | `ENV_INPUT_DISK_TAGS`                 | `tags`                 | `tag1=value1,tag2=value2`; If there is a tag with the same name in the configuration file, it will be overwritten                             |
    | `ENV_INPUT_DISK_ONLY_PHYSICAL_DEVICE` | `only_physical_device` | Ignore non-physical disks (such as network disk, NFS, etc., only collect local hard disk/CD ROM/USB disk, etc.) and give a string value at will|
    | `ENV_INPUT_DISK_INTERVAL`             | `interval`             | `10s`                                                                                    |

<!-- markdownlint-enable -->

## Metric {#metric}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.disk.tags]`:

``` toml
 [inputs.disk.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `disk`

- tag


| Tag | Description |
|  ----  | --------|
|`device`|Disk device name. (on /dev/mapper return symbolic link, like `readlink /dev/mapper/*` result)|
|`fstype`|File system name.|
|`host`|System hostname.|
|`mount_point`|Mount point.|

- metric list


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


