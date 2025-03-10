---
title     : 'File Directory'
summary   : 'Collect metrics data from file directories'
tags:
  - 'Host'
__int_icon      : 'icon/hostdir'
dashboard :
  - desc  : 'File Directory'
    path  : 'dashboard/en/hostdir'
monitor   :
  - desc  : 'Not Available'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The host directory collector is used for collecting data from directory files, such as the number of files and the total size of all files.

## Configuration {#config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/host` directory under the DataKit installation directory, copy `hostdir.conf.sample`, and rename it to `hostdir.conf`. Example:
    
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

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

## Metrics {#metric}

All the following metric sets will append a global tag named `host` (tag value is the hostname where DataKit resides) by default. You can also specify additional tags in the configuration using `[inputs.hostdir.tags]`:

``` toml
 [inputs.hostdir.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `hostdir`

- Tags


| Tag | Description |
|  ----  | --------|
|`file_ownership`|File ownership.|
|`file_system`|File system type.|
|`host_directory`|The start Dir.|
|`mount_point`|Mount point.|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`dir_count`|The number of directories.|int|count|
|`file_count`|The number of files.|int|count|
|`file_size`|The size of files.|int|B|
|`free`|Free disk size in bytes.|int|B|
|`inodes_free`|Free inode.|int|count|
|`inodes_total`|Total inode.|int|count|
|`inodes_used`|Used inode (only this dir used).|int|count|
|`inodes_used_percent`|Inode used percentage (only this dir used in total inode).|float|percent|
|`total`|Total disk size in bytes.|int|B|
|`used_percent`|Used disk size percentage (only this dir used in total size).|float|percent|