---
title: 'Lsblk'
summary: 'Collect metrics data from block devices'
tags:
  - 'Host'
__int_icon: 'icon/disk'
dashboard:
  - desc: 'lsblk'
    path: 'dashboard/lsblk'
---

:fontawesome-brands-linux: :material-kubernetes: :material-docker:

---

The lsblk collector is used to collect information from block devices on Linux hosts, such as device name, major/minor device numbers, available filesystem size, filesystem type, used filesystem size, percentage of filesystem usage, and mount points.

## Configuration {#config}

<!-- markdownlint-disable MD046 -->

=== "Host Installation"

    Navigate to the `conf.d/host` directory under the DataKit installation directory, copy `lsblk.conf.sample`, and rename it to `lsblk.conf`. Example configuration:

    ```toml
        
    [[inputs.lsblk]]
      ##(optional) collect interval, default is 10 seconds
      interval = '10s'
      # exclude_device = ['/dev/sda1','/dev/sda2']
    
    [inputs.lsblk.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    ```

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can enable the collector via [ConfigMap injection](../datakit/datakit-daemonset-deploy.md#configmap-setting) or by [setting ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting).

    Environment variables can also be used to modify configuration parameters (requires adding to ENV_DEFAULT_ENABLED_INPUTS):

    - **ENV_INPUT_LSBLK_INTERVAL**
    
        Interval for repeated collection
    
        **Field Type**: Duration
    
        **Collector Configuration Field**: `interval`
    
        **Default Value**: `10s`
    
    - **ENV_INPUT_LSBLK_EXCLUDE_DEVICE**
    
        Prefixes of devices to exclude. (By default, all devices with the prefix `dev` are collected)
    
        **Field Type**: List
    
        **Collector Configuration Field**: `exclude_device`
    
        **Example**: /dev/loop0,/dev/loop1

<!-- markdownlint-enable -->

## Metrics {#metric}

All collected data will have a global tag named `host` appended by default (tag value is the hostname where DataKit resides), and additional tags can be specified in the configuration using `[inputs.lsblk.tags]`:

```toml
 [inputs.lsblk.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

### `lsblk`

- Tags


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

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`fs_used_percent`|Percentage of used space on the filesystem.|float|percent|
|`fsavail`|Available space on the filesystem.|int|B|
|`fssize`|Total size of the filesystem.|int|B|
|`fsused`|Used space on the filesystem.|int|B|
|`rq_size`|Request queue size.|int|B|
|`size`|Size of the device.|int|B|
