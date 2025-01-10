---
title     : 'Lsblk'
summary   : 'Collect metrics of block device'
tags:
  - 'HOST'
__int_icon      : 'icon/disk'
dashboard :
  - desc  : 'Lsblk'
    path  : 'dashboard/lsblk'
---

:fontawesome-brands-linux: :material-kubernetes: :material-docker:

---

Lsblk collector is used for Linux host block device information collection, such as device name, primary and secondary device number, filesystem available size, filesystem type, filesystem used size, filesystem usage percentage, device mount location, etc.

## Configuration {#config}

<!-- markdownlint-disable MD046 -->

### Collector Configuration {#input-config}

=== "Host Installation"

    Go to the `conf.d/host` directory under the DataKit installation directory, copy `lsblk.conf.sample` and name it `lsblk.conf`. Examples are as follows:

    ```toml
        
    [[inputs.lsblk]]
      ##(optional) collect interval, default is 10 seconds
      interval = '10s'
      # exclude_device = ['/dev/sda1','/dev/sda2']
    
    [inputs.lsblk.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    ```
    
    Once configured, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Can be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [Config ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) .

    Can also be turned on by environment variables, (needs to be added as the default collector in ENV_DEFAULT_ENABLED_INPUTS):
    
    - **ENV_INPUT_LSBLK_INTERVAL**
    
        Collect interval
    
        **Type**: Duration
    
        **input.conf**: `interval`
    
        **Default**: `10s`
    
    - **ENV_INPUT_LSBLK_EXCLUDE_DEVICE**
    
        Excluded device prefix. (By default, collect all devices with dev as the prefix)
    
        **Type**: List
    
        **input.conf**: `exclude_device`
    
        **Example**: /dev/loop0,/dev/loop1

<!-- markdownlint-enable -->

## Metric {#metric}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.lsblk.tags]`:

``` toml
 [inputs.lsblk.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `lsblk`

- tag


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

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`fs_used_percent`|Percentage of used space on the filesystem.|float|percent|
|`fsavail`|Available space on the filesystem.|int|B|
|`fssize`|Total size of the filesystem.|int|B|
|`fsused`|Used space on the filesystem.|int|B|
|`rq_size`|Request queue size.|int|B|
|`size`|Size of the device.|int|B|


