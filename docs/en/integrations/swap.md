---
title     : 'Swap'
summary   : 'Collect metrics data for host swap memory'
tags:
  - 'HOST'
__int_icon      : 'icon/swap'
dashboard :
  - desc  : 'Swap'
    path  : 'dashboard/en/swap'
monitor   :
  - desc  : 'Host Monitoring Library'
    path  : 'monitor/en/host'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The swap collector is used to collect usage information about the swap memory on the host.

## Configuration {#config}

After successfully installing and starting DataKit, the Swap collector will be enabled by default, requiring no manual activation.

<!-- markdownlint-disable MD046 -->

=== "HOST Installation"

    Navigate to the `conf.d/host` directory under the DataKit installation directory, copy `swap.conf.sample`, and rename it to `swap.conf`. Example:

    ```toml
        
    [[inputs.swap]]
      ##(optional) collection interval, default is 10 seconds
      interval = '10s'
      ##
    
    [inputs.swap.tags]
    # some_tag = "some_value"
    # more_tag = "some_other_value"
    
    
    ```

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can enable the collector via [ConfigMap injection](../datakit/datakit-daemonset-deploy.md#configmap-setting) or by [setting ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting).

    It also supports modifying configuration parameters via environment variables (you need to add it as a default collector in ENV_DEFAULT_ENABLED_INPUTS):

    - **ENV_INPUT_SWAP_INTERVAL**
    
        Collector repeat interval duration
    
        **Field Type**: Duration
    
        **Collector Configuration Field**: `interval`
    
        **Default Value**: 10s
    
    - **ENV_INPUT_SWAP_TAGS**
    
        Custom tags. If there are tags with the same name in the configuration file, they will overwrite them.
    
        **Field Type**: Map
    
        **Collector Configuration Field**: `tags`
    
        **Example**: tag1=value1,tag2=value2

<!-- markdownlint-enable -->

## Metrics {#metric}

All the following data collections will append a global tag named `host` by default (the tag value is the hostname where DataKit resides), and you can also specify other tags through `[inputs.swap.tags]` in the configuration:

```toml
[inputs.swap.tags]
 # some_tag = "some_value"
 # more_tag = "some_other_value"
 # ...
```



### `swap`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|Hostname|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`free`|Total free swap memory on the host.|int|B|
|`in`|Moving data from swap space to the machine's main memory.|int|B|
|`out`|Moving contents of main memory to swap disk when main memory fills up.|int|B|
|`total`|Total swap memory on the host.|int|B|
|`used`|Used swap memory on the host.|int|B|
|`used_percent`|Percentage of used swap memory on the host.|float|percent|