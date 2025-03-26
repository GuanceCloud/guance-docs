---
title     : 'Host Directory'
summary   : 'Collect metrics from file directories'
tags:
  - 'HOST'
__int_icon      : 'icon/hostdir'
dashboard :
  - desc  : 'Host Directory'
    path  : 'dashboard/en/hostdir'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Host directory collector is used to collect directory files, such as the number of files, all file sizes, etc.

## Configuration {#config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Go to the `conf.d/host` directory under the DataKit installation directory, copy `hostdir.conf.sample` and name it `hostdir.conf`. Examples are as follows:
    
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
    
    Once configured, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap injection collector configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

## Metric {#metric}

For all of the following metric sets, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.hostdir.tags]`:

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

- Metrics


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


