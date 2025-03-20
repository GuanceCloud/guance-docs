---
title     : 'Hardware Sensors Data Collection'
summary   : 'Collect hardware temperature metrics using the Sensors command'
tags:
  - 'HOSTs'
__int_icon      : 'icon/sensors'
dashboard :
  - desc  : 'None available'
    path  : '-'
monitor   :
  - desc  : 'None available'
    path  : '-'
---

:fontawesome-brands-linux:

---

Computer chip temperature data collection, using the `lm-sensors` command (currently only supports the `Linux` operating system)

## Configuration {#config}

### Prerequisites {#requrements}

- Run the installation command `apt install lm-sensors -y`
- Run the scanning command `sudo sensors-detect` and input `Yes` for every question.
- After running the scan, you will see `service kmod start` to load the detected Sensors; this command may vary depending on your operating system.

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "HOST Installation"

    Navigate to the `conf.d/sensors` directory under the DataKit installation directory, copy `sensors.conf.sample` and rename it to `sensors.conf`. Example as follows:

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

    After configuring, restart DataKit.

=== "Kubernetes"

    You can currently enable the collector by injecting the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

---

## Metrics {#metric}

All the following data collections will append a global tag named `host` by default (the tag value is the hostname where Datakit resides), or you can specify other tags in the configuration through `[inputs.sensors.tags]`:

```toml
[inputs.sensors.tags]
 # some_tag = "some_value"
 # more_tag = "some_other_value"
 # ...
```



### `sensors`



- Tags


| Tag | Description |
|  ----  | --------|
|`adapter`|Device adapter|
|`chip`|Chip id|
|`feature`|Gathering target|
|`hostname`|Host name|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`temp*_crit_alarm`|Alarm count, '*' is the order number in the chip list.|int|C|
|`temp*_input`|Current input temperature of this chip, '*' is the order number in the chip list.|int|C|
|`tmep*_crit`|Critical temperature of this chip, '*' is the order number in the chip list.|int|C|
|`tmep*_max`|Max temperature of this chip, '*' is the order number in the chip list.|int|C|