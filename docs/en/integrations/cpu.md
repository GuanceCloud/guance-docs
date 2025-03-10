---
title     : 'CPU'
summary   : 'Collect CPU Metrics data'
tags:
  - 'HOST'
__int_icon      : 'icon/cpu'
dashboard :
  - desc  : 'CPU'
    path  : 'dashboard/en/cpu'
monitor   :
  - desc  : 'Host Monitoring Library'
    path  : 'monitor/en/host'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :material-kubernetes: :material-docker:

---

The CPU collector is used to collect metrics such as system CPU usage.

## Configuration  {#config}

### Collector Configuration {#input-config}

After successfully installing and starting DataKit, the CPU collector will be enabled by default, requiring no manual activation.

<!-- markdownlint-disable MD046 -->

=== "Host Deployment"

    Navigate to the `conf.d/host` directory under the DataKit installation directory, copy `cpu.conf.sample`, and rename it to `cpu.conf`. An example configuration is shown below:

    ```toml
        
    [[inputs.cpu]]
      ## Collect interval, default is 10 seconds. (optional)
      interval = '10s'
    
      ## Collect CPU usage per core, default is false. (optional)
      percpu = false
    
      ## Setting disable_temperature_collect to false will collect CPU temperature stats for Linux. (deprecated)
      # disable_temperature_collect = false
    
      ## Enable to collect core temperature data.
      enable_temperature = true
    
      ## Enable to get average load information every five seconds.
      enable_load5s = true
    
    [inputs.cpu.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    
    ```

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can inject the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting) or set [ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) to enable the collector.

    Environment variables can also be used to modify configuration parameters (you need to add it to ENV_DEFAULT_ENABLED_INPUTS):

    - **ENV_INPUT_CPU_INTERVAL**
    
        Collector repeat interval duration
    
        **Field Type**: Duration
    
        **Collector Configuration Field**: `interval`
    
        **Default Value**: `10s`
    
    - **ENV_INPUT_CPU_PERCPU**
    
        Collect metrics for each CPU core
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `percpu`
    
        **Default Value**: false
    
    - **ENV_INPUT_CPU_ENABLE_TEMPERATURE**
    
        Collect CPU temperature
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_temperature`
    
        **Default Value**: `true`
    
    - **ENV_INPUT_CPU_ENABLE_LOAD5S**
    
        Get average load information every five seconds
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_load5s`
    
        **Default Value**: `false`
    
    - **ENV_INPUT_CPU_TAGS**
    
        Custom tags. If a tag with the same name exists in the configuration file, it will override it
    
        **Field Type**: String
    
        **Collector Configuration Field**: `tags`
    
        **Example**: `tag1=value1,tag2=value2`

<!-- markdownlint-enable -->

---

## Metrics {#metric}

By default, all collected data will append a global tag named `host` (the tag value is the hostname where DataKit resides). You can also specify other tags through `[inputs.cpu.tags]` in the configuration:

```toml
 [inputs.cpu.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `cpu`



- Tags


| Tag | Description |
|  ----  | --------|
|`cpu`|CPU core ID. For `cpu-total`, it means *all-CPUs-in-one-tag*. To collect metrics for each CPU, enable the `percpu` option in *cpu.conf* or set `ENV_INPUT_CPU_PERCPU` under K8s|
|`host`|System hostname.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`core_temperature`|Average CPU core temperature.|float|C|
|`load5s`|CPU average load over 5 seconds.|int|-|
|`usage_guest`|% CPU spent running a virtual CPU for guest operating systems.|float|percent|
|`usage_guest_nice`|% CPU spent running a nice guest (virtual CPU for guest operating systems).|float|percent|
|`usage_idle`|% CPU in the idle task.|float|percent|
|`usage_iowait`|% CPU waiting for I/O to complete.|float|percent|
|`usage_irq`|% CPU servicing hardware interrupts.|float|percent|
|`usage_nice`|% CPU in user mode with low priority (nice).|float|percent|
|`usage_softirq`|% CPU servicing soft interrupts.|float|percent|
|`usage_steal`|% CPU spent in other operating systems when running in a virtualized environment.|float|percent|
|`usage_system`|% CPU in system mode.|float|percent|
|`usage_total`|% CPU in total active usage, as well as (100 - usage_idle).|float|percent|
|`usage_user`|% CPU in user mode.|float|percent|