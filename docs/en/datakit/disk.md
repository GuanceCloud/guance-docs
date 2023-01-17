
# Disk
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Disk collector is used to collect disk information, such as disk storage space, inodes usage, etc.

## Preconditions {#requirements}

None


## Configuration {#config}

=== "Host Installation"

    Go to the `conf.d/host` directory under the DataKit installation directory, copy `disk.conf.sample` and name it `disk.conf`. Examples are as follows:
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

    Once configured, [restart DataKit](datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Supports modifying configuration parameters as environment variables:
    
    | Environment Variable Name                            | Corresponding Configuration Parameter Item       | Parameter Example                                                                                 |
    | ---                                   | ---                    | ---                                                                                      |
    | `ENV_INPUT_DISK_EXCLUDE_DEVICE`       | `exclude_device`       | `"/dev/loop0","/dev/loop1"`, separated by English commas                      |
    | `ENV_INPUT_DISK_EXTRA_DEVICE`         | `extra_device`         | `"/nfsdata"`， separated by English commas                        |
    | `ENV_INPUT_DISK_TAGS`                 | `tags`                 | `tag1=value1,tag2=value2`; If there is a tag with the same name in the configuration file, it will be overwritten                             |
    | `ENV_INPUT_DISK_ONLY_PHYSICAL_DEVICE` | `only_physical_device` | Ignore non-physical disks (such as network disk, NFS, etc., only collect local hard disk/CD ROM/USB disk, etc.) and give a string value at will|
    | `ENV_INPUT_DISK_INTERVAL`             | `interval`             | `10s`                                                                                    |

## Measurements {#measurements}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.disk.tags]`:

``` toml
 [inputs.disk.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `disk`

-  Tag


| Tag Name | Description    |
|  ----  | --------|
|`device`|Disk device name|
|`fstype`|File system name|
|`host`|hostname|
|`mode`|Read-write mode|
|`path`|Disk mount point|

- Metrics List


| Metrics | Description| Data Type | Unit   |
| ---- |---- | :---:    | :----: |
|`free`|Free disk size in bytes|int|B|
|`inodes_free`|Free inodes(**DEPRECATED: use inodes_free_mb instead**)|int|count|
|`inodes_free_mb`|Free inodes(in MB)|int|count|
|`inodes_total`|Total inodes(**DEPRECATED: use inodes_total_mb instead**)|int|count|
|`inodes_total_mb`|Total inodes(in MB)|int|count|
|`inodes_used`|Used inodes(**DEPRECATED: use inodes_used_mb instead**)|int|count|
|`inodes_used_mb`|Used inodes(in MB)|int|count|
|`total`|Total disk size in bytes|int|B|
|`used`|Used disk size in bytes|int|B|
|`used_percent`|Used disk size in percent|float|percent|


