
# Hardware Temperature Sensors
---

:fontawesome-brands-linux:

---

Computer chip temperature data acquisition using the `lm-sensors` command (currently only support `Linux` operating system).

## Preconditions {#requrements}

- Run the install command `apt install lm-sensors -y`
- Run the scan command `sudo sensors-detect` enter `Yes` for each question
- After running the scan, you will see 'service kmod start' to load the scanned sensors, which may vary depending on your operating system.

## Configuration {#config}

=== "Host Installation"

    Go to the `conf.d/sensors` directory under the DataKit installation directory, copy `sensors.conf.sample` and name it `sensors.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.sensors]]
      ## Command path of 'sensors' usually is /usr/bin/sensors
      # path = "/usr/bin/sensors"
    
      ## Gathering interval
      # interval = "10s"
    
      ## Command timeout
      # timeout = "3s"
    
      ## Customer tags, if set will be seen with every metric.
      [inputs.sensors.tags]
        # "key1" = "value1"
        # "key2" = "value2"
    
    ```
    
    After configuration, restart DataKit.

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](datakit-daemonset-deploy.md#configmap-setting).

## Measurements {#measurements}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.sensors.tags]`:

```toml
 [inputs.sensors.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `sensors`

- tag


| Tag | Description |
|  ----  | --------|
|`adapter`|device adapter|
|`chip`|chip id|
|`feature`|gathering target|
|`hostname`|host name|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`temp*_crit_alarm`|Alarm count, '*' is the order number in the chip list.|int|C|
|`temp*_input`|Current input temperature of this chip, '*' is the order number in the chip list.|int|C|
|`tmep*_crit`|Critical temperature of this chip, '*' is the order number in the chip list.|int|C|
|`tmep*_max`|Max temperature of this chip, '*' is the order number in the chip list.|int|C|


