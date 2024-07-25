---
title     : 'Swap'
summary   : 'Collect metrics of host swap'
__int_icon      : 'icon/swap'
dashboard :
  - desc  : 'Swap'
    path  : 'dashboard/en/swap'
monitor   :
  - desc  : 'Host monitoring library'
    path  : 'monitor/en/host'
---

<!-- markdownlint-disable MD025 -->
# Swap
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

## Configuration {#config}

The swap collector is used to collect the usage of the host swap memory.

<!-- markdownlint-disable MD046 -->
## Collector Configuration {#input-config}

=== "Host Installation"

    Go to the `conf.d/host` directory under the DataKit installation directory, copy `swap.conf.sample` and name it `swap.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.swap]]
      ##(optional) collect interval, default is 10 seconds
      interval = '10s'
      ##
    
    [inputs.swap.tags]
    # some_tag = "some_value"
    # more_tag = "some_other_value"
    
    
    ```

    After configuration, restart DataKit.

=== "Kubernetes"

    Can be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [Config ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) .

    Can also be turned on by environment variables, (needs to be added as the default collector in ENV_DEFAULT_ENABLED_INPUTS):
    
    - **ENV_INPUT_SWAP_INTERVAL**
    
        Collect interval
    
        **Type**: TimeDuration
    
        **input.conf**: `interval`
    
        **Default**: 10s
    
    - **ENV_INPUT_SWAP_TAGS**
    
        Customize tags. If there is a tag with the same name in the configuration file, it will be overwritten
    
        **Type**: Map
    
        **input.conf**: `tags`
    
        **Example**: tag1=value1,tag2=value2

<!-- markdownlint-enable -->

## Metric {#metric}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.swap.tags]`:

```toml
[inputs.swap.tags]
 # some_tag = "some_value"
 # more_tag = "some_other_value"
 # ...
```



### `swap`

- tag


| Tag | Description |
|  ----  | --------|
|`host`|hostname|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`free`|Host swap memory total.|int|B|
|`in`|Moving data from swap space to main memory of the machine.|int|B|
|`out`|Moving main memory contents to swap disk when main memory space fills up.|int|B|
|`total`|Host swap memory free.|int|B|
|`used`|Host swap memory used.|int|B|
|`used_percent`|Host swap memory percentage used.|float|percent|


