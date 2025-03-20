---
title     : 'Disk'
summary   : 'Collect metrics data for disk'
tags:
  - 'HOST'
__int_icon      : 'icon/disk'
dashboard :
  - desc  : 'Disk'
    path  : 'dashboard/en/disk'
monitor   :
  - desc  : 'Host Monitoring Library'
    path  : 'monitor/en/host'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The disk collector is used to collect information about the host disk, such as disk storage space and Inode usage.

## Configuration {#config}

After successfully installing and starting DataKit, the Disk collector will be enabled by default, without requiring manual activation.

<!-- markdownlint-disable MD046 -->

=== "Host Installation"

    Navigate to the `conf.d/host` directory under the DataKit installation directory, copy `disk.conf.sample`, and rename it to `disk.conf`. Example as follows:

    ```toml
        
    [[inputs.disk]]
      ##(optional) collection interval, default is 10 seconds
      interval = '10s'
    
      ## Physical devices only (e.g. hard disks, cd-rom drives, USB keys)
      ## and ignore all others (e.g. memory partitions such as /dev/shm)
      only_physical_device = false
    
      ## merge disks that with the same device name(default true)
      # merge_on_device = true
    
      ## We collect all devices prefixed with dev by default,If you want to collect additional devices, it's in extra_device add
      # extra_device = ["/nfsdata"]
    
      ## exclude some with dev prefix (We collect all devices prefixed with dev by default)
      # exclude_device = ["/dev/loop0","/dev/loop1"]
    
      ignore_fstypes = '''^(tmpfs|autofs|binfmt_misc|devpts|fuse.lxcfs|overlay|proc|squashfs|sysfs)$'''
      ignore_mountpoints = '''^(/usr/local/datakit/.*|/run/containerd/.*)$'''
    
      #[inputs.disk.tags]
      #  some_tag = "some_value"
      #  more_tag = "some_other_value"
    
    ```

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can enable the collector via [ConfigMap injection](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [configure ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting).

    It also supports modifying configuration parameters via environment variables (you need to add it to ENV_DEFAULT_ENABLED_INPUTS as a default collector):

    - **ENV_INPUT_DISK_INTERVAL**
    
        Collector repetition interval duration
    
        **Field Type**: Duration
    
        **Collector Configuration Field**: `interval`
    
        **Default Value**: 10s
    
    - **ENV_INPUT_DISK_EXTRA_DEVICE**
    
        Additional device prefix. (By default collect all devices with dev as the prefix)
    
        **Type**: List
    
        **input.conf**: `extra_device`
    
        **Example**: `/nfsdata,other_data`
    
    - **ENV_INPUT_DISK_EXCLUDE_DEVICE**
    
        Excluded device prefix. (By default collect all devices with dev as the prefix)
    
        **Type**: List
    
        **input.conf**: `exclude_device`
    
        **Example**: /dev/loop0,/dev/loop1
    
    - **ENV_INPUT_DISK_IGNORE_MOUNTPOINTS**
    
        Excluded mount points
    
        **Type**: String
    
        **input.conf**: `ignore_mountpoints`
    
        **Example**: `^(/usr/local/datakit/.*|/run/containerd/.*)$`
    
    - **ENV_INPUT_DISK_INPUT_DISK_IGNORE_FSTYPES**
    
        Excluded file systems
    
        **Type**: String
    
        **input.conf**: `input_disk_ignore_fstypes`
    
        **Example**: `^(tmpfs|autofs|binfmt_misc|devpts|fuse.lxcfs|overlay|proc|squashfs|sysfs)$`

<!-- markdownlint-enable -->

## Metrics {#metric}

All the following data collected will append a global tag named `host` by default (the tag value is the hostname of the machine where DataKit resides), or you can specify other tags through `[inputs.disk.tags]` in the configuration:

```toml
 [inputs.disk.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

<!-- markdownlint-disable MD046 -->
???+ info "Disk Metrics Source"
    On Linux, metrics are obtained by fetching mount information from */proc/self/mountinfo* and then sequentially obtaining disk metrics for each mount point (`statfs()`). For Windows, this is done through a series of Windows APIs such as `GetLogicalDriveStringsW()` system calls to obtain mount points, followed by `GetDiskFreeSpaceExW()` to get disk usage information.

    In the [:octicons-tag-24: Version-1.66.0](../datakit/changelog-2025.md#cl-1.66.0) release, the disk collector has been optimized. However, mount points for the same device will still be merged into one, with only the first mount point being taken. If you need to collect all mount points, a specific flag(`merge_on_device/ENV_INPUT_DISK_MERGE_ON_DEVICE`) must be disable. While this flag disabled, this may result in a significant increase in the number of time series in the disk measurement.
<!-- markdownlint-enable -->



### `disk`

- Tags


| Tag | Description |
|  ----  | --------|
|`device`|Disk device name. (on /dev/mapper return symbolic link, like `readlink /dev/mapper/*` result)|
|`disk_name`|Disk name.|
|`fstype`|File system name.|
|`host`|System hostname.|
|`mount_point`|Mount point.|

- Metrics List


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