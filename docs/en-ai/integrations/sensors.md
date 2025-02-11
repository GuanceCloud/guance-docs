---
title: 'Hardware Sensors Data Collection'
summary: 'Collect hardware temperature metrics using the Sensors command'
tags:
  - 'Host'
__int_icon: 'icon/sensors'
dashboard:
  - desc: 'Not available'
    path: '-'
monitor:
  - desc: 'Not available'
    path: '-'
---

:fontawesome-brands-linux:

---

Data collection for computer chip temperature using the `lm-sensors` command (currently only supported on the `Linux` operating system)

## Configuration {#config}

### Prerequisites {#requirements}

- Run the installation command `apt install lm-sensors -y`
- Run the scan command `sudo sensors-detect` and input `Yes` to each question.
- After the scan completes, you will see `service kmod start` to load the detected sensors. This command may vary depending on your operating system.

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Enter the `conf.d/sensors` directory under the DataKit installation directory, copy `sensors.conf.sample` and rename it to `sensors.conf`. Example configuration:

    ```toml
        
    [[inputs.sensors]]
      ## Command path of 'sensors' usually is /usr/bin/sensors
      # path = "/usr/bin/sensors"
    
      ## Gathering interval
      # interval = "10s"
    
      ## Command timeout
      # timeout = "3s"
    
      ## Custom tags, if set will be seen with every metric.
      [inputs.sensors.tags]
        # "key1" = "value1"
        # "key2" = "value2"
    
    ```

    After configuring, restart DataKit.

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

---

## Metrics {#metric}

By default, all collected data will append a global tag named `host` (the tag value is the hostname where DataKit resides). You can also specify additional tags in the configuration using `[inputs.sensors.tags]`:

```toml
[inputs.sensors.tags]
 # some_tag = "some_value"
 # more_tag = "some_other_value"
 # ...
```

### `sensors`

- Tags

| Tag       | Description          |
| --------- | -------------------- |
| `adapter` | Device adapter       |
| `chip`    | Chip ID              |
| `feature` | Gathering target     |
| `hostname`| Host name            |

- Metric List

| Metric           | Description                                                                 | Type | Unit |
| ---------------- | --------------------------------------------------------------------------- | ---: | ----:|
| `temp*_crit_alarm` | Alarm count, '*' is the order number in the chip list.                     | int  | C    |
| `temp*_input`      | Current input temperature of this chip, '*' is the order number in the chip list. | int  | C    |
| `temp*_crit`       | Critical temperature of this chip, '*' is the order number in the chip list. | int  | C    |
| `temp*_max`        | Maximum temperature of this chip, '*' is the order number in the chip list. | int  | C    |