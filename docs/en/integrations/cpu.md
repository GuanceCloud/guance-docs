
# CPU
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :material-kubernetes: :material-docker:

---

The CPU collector is used to collect the CPU utilization rate of the system.

## Precondition {#requirement}

None.

## Configuration  {#input-config}

=== "host installation"

    Go to the `conf.d/host` directory under the DataKit installation directory, copy `cpu.conf.sample` and name it `cpu.conf`. Examples are as follows:
    
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
    
    After configuration, [restart Datakit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Kubernetes supports modifying configuration parameters in the form of environment variables:
    
    | Environment Variable Name                   | Corresponding Configuration Parameter Item              | Parameter Example                                                                              |
    | :---                                        | ---                           | ---                                                                                   |
    | `ENV_INPUT_CPU_PERCPU`                      | `percpu`                      | `true/false`                                                                          |
    | `ENV_INPUT_CPU_ENABLE_TEMPERATURE`          | `enable_temperature`          | `true/false`                                                                          |
    | `ENV_INPUT_CPU_TAGS`                        | `tags`                        | `tag1=value1,tag2=value2` If there is a tag with the same name in the configuration file, it will be overwritten.                          |
    | `ENV_INPUT_CPU_INTERVAL`                    | `interval`                    | `10s`                                                                                 |
    | `ENV_INPUT_CPU_DISABLE_TEMPERATURE_COLLECT` | `disable_temperature_collect` | `false/true`. Any string is considered ` true `, and if it is not defined, it is ` false `.                     |
    | `ENV_INPUT_CPU_ENABLE_LOAD5S`               | `enable_load5s`               | `false/true`. Any string is considered ` true `, and if it is not defined, it is ` false `. |

---

## Measurements {#measurements}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration through `[inputs.cpu.tags]`:

``` toml
 [inputs.cpu.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `cpu`



- tag


| Tag | Description |
|  ----  | --------|
|`cpu`|CPU core ID. For `cpu-total`, it means *all-CPUs-in-one-tag*. If you want every CPU's metric, please enable `percpu` option in *cpu.conf* or set `ENV_INPUT_CPU_PERCPU` under K8s|
|`host`|System hostname.|

- Metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`core_temperature`|CPU core temperature. This is collected by default. Only collect the average temperature of all cores.|float|C|
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


