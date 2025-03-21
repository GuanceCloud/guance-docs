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

The CPU collector is used for collecting system CPU usage and other Metrics.

## Configuration  {#config}

### Collector Configuration {#input-config}

After successfully installing and starting DataKit, the CPU collector will be enabled by default, no manual activation is required.

<!-- markdownlint-disable MD046 -->

=== "Host Deployment"

    Navigate to the `conf.d/host` directory under the DataKit installation directory, copy `cpu.conf.sample` and rename it to `cpu.conf`. An example is as follows:

    ```toml
        
    [[inputs.cpu]]
      ## Collect interval, default is 10 seconds. (optional)
      interval = '10s'
    
      ## Collect CPU usage per core, default is false. (optional)
      percpu = false
    
      ## Setting disable_temperature_collect to false will collect cpu temperature stats for linux. (deprecated)
      # disable_temperature_collect = false
    
      ## Enable to collect core temperature data.
      enable_temperature = true
    
      ## Enable gets average load information every five seconds.
      enable_load5s = true
    
    [inputs.cpu.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    
    ```

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can enable the collector via [ConfigMap injection](../datakit/datakit-daemonset-deploy.md#configmap-setting) or by [setting ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting).

    It also supports modifying configuration parameters using environment variables (you need to add it to ENV_DEFAULT_ENABLED_INPUTS as a default collector):

    - **ENV_INPUT_CPU_INTERVAL**
    
        Collector repeat interval duration
    
        **Field Type**: Duration
    
        **Collector Configuration Field**: `interval`
    
        **Default Value**: `10s`
    
    - **ENV_INPUT_CPU_PERCPU**
    
        Collect each CPU core
    
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
    
        Custom tags. If the configuration file has tags with the same name, they will override them.
    
        **Field Type**: String
    
        **Collector Configuration Field**: `tags`
    
        **Example**: `tag1=value1,tag2=value2`

<!-- markdownlint-enable -->

---

## Metrics {#metric}

By default, all collected data will append a global tag named `host` (the tag value is the hostname where DataKit resides), and you can also specify other tags in the configuration through `[inputs.cpu.tags]`:

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
|`cpu`|CPU core ID. For `cpu-total`, it means *all-CPUs-in-one-tag*. If you want every CPU's metrics, please enable `percpu` option in *cpu.conf* or set `ENV_INPUT_CPU_PERCPU` under K8s|
|`host`|System hostname.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`core_temperature`|CPU core temperature. This is collected by default. Only collects the average temperature of all cores.|float|C|
|`load5s`|CPU average load in 5 seconds.|int|-|
|`usage_guest`|% CPU spent running a virtual CPU for guest operating systems.|float|percent|
|`usage_guest_nice`|% CPU spent running a nice guest(virtual CPU for guest operating systems).|float|percent|
|`usage_idle`|% CPU in the idle task.|float|percent|
|`usage_iowait`|% CPU waiting for I/O to complete.|float|percent|
|`usage_irq`|% CPU servicing hardware interrupts.|float|percent|
|`usage_nice`|% CPU in user mode with low priority (nice).|float|percent|
|`usage_softirq`|% CPU servicing soft interrupts.|float|percent|
|`usage_steal`|% CPU spent in other operating systems when running in a virtualized environment.|float|percent|
|`usage_system`|% CPU in system mode.|float|percent|
|`usage_total`|% CPU in total active usage, as well as (100 - usage_idle).|float|percent|
|`usage_user`|% CPU in user mode.|float|percent|