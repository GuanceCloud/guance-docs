---
title: 'Swap'
summary: 'Collect metrics data from host swap memory'
tags:
  - 'Host'
__int_icon: 'icon/swap'
dashboard:
  - desc: 'Swap'
    path: 'dashboard/en/swap'
monitor:
  - desc: 'Host Monitoring Library'
    path: 'monitor/en/host'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The Swap collector is used to collect the usage of swap memory on hosts.

## Configuration {#config}

After successfully installing and starting DataKit, the Swap collector will be enabled by default, and there is no need to manually enable it.

<!-- markdownlint-disable MD046 -->

=== "Host Installation"

    Navigate to the `conf.d/host` directory under the DataKit installation directory, copy `swap.conf.sample`, and rename it to `swap.conf`. An example is as follows:

    ```toml
        
    [[inputs.swap]]
      ## (optional) collection interval, default is 10 seconds
      interval = '10s'
      ##
    
    [inputs.swap.tags]
    # some_tag = "some_value"
    # more_tag = "some_other_value"
    
    
    ```

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can enable the collector by injecting configuration through [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting) or by [configuring ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting).

    It also supports modifying configuration parameters via environment variables (you need to add it to ENV_DEFAULT_ENABLED_INPUTS as a default collector):

    - **ENV_INPUT_SWAP_INTERVAL**

        Collector repetition interval duration

        **Field Type**: Duration

        **Collector Configuration Field**: `interval`

        **Default Value**: 10s

    - **ENV_INPUT_SWAP_TAGS**

        Custom tags. If there are tags with the same name in the configuration file, they will override them.

        **Field Type**: Map

        **Collector Configuration Field**: `tags`

        **Example**: tag1=value1,tag2=value2

<!-- markdownlint-enable -->

## Metrics {#metric}

All the following data collections will append a global tag named `host` (the tag value is the hostname where DataKit resides) by default, or you can specify other tags using `[inputs.swap.tags]` in the configuration:

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
|`in`|Moving data from swap space to main memory of the machine.|int|B|
|`out`|Moving main memory contents to swap disk when main memory space fills up.|int|B|
|`total`|Total swap memory on the host.|int|B|
|`used`|Used swap memory on the host.|int|B|
|`used_percent`|Percentage of used swap memory on the host.|float|percent|


</example>
