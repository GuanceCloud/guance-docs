
# Host Directory
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Hostdir collector is used to collect directory files, such as the number of files, all file sizes, etc.

## Preconditions {#requrements}

None

## Configuration {#config}

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
    
    Once configured, [restart DataKit](datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap injection collector configuration](datakit-daemonset-deploy.md#configmap-setting).


## Measurements {#measurements}

For all of the following metric sets, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.hostdir.tags]`:

``` toml
 [inputs.hostdir.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `hostdir`

- tag


| 标签名 | 描述    |
|  ----  | --------|
|`file_ownership`|file ownership|
|`file_system`|file system type|
|`host_directory`|the start Dir|

- metric list


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`dir_count`|The number of Dir|int|count|
|`file_count`|The number of files|int|count|
|`file_size`|The size of files|int|count|


