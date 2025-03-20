---
title     : 'IPMI'
summary   : 'IPMI Metrics display information about the current, voltage, power consumption, occupancy rate, fan speed, temperature, and device status of monitored devices.'
tags:
  - 'IPMI'
__int_icon      : 'icon/ipmi'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

IPMI Metrics display information about the current, voltage, power consumption, occupancy rate, fan speed, temperature, and device status of monitored devices.

IPMI stands for Intelligent Platform Management Interface, an industrial standard used to manage peripheral devices in enterprise systems based on Intel architecture. This standard was developed by companies such as Intel, HP, NEC, Dell USA, and SuperMicro. Users can monitor physical health characteristics of servers, such as temperature, voltage, fan operating state, power supply state, etc., using IPMI.

IPMI allows operation systems to obtain operational health metrics of monitored servers and other devices **non-invasively**, ensuring information security.

## Configuration  {#input-config}

### Prerequisites {#precondition}

- Install `ipmitool` package

Datakit collects IPMI data via the [`ipmitool`][1] tool, so this tool needs to be installed on the machine. You can install it with the following commands:

```shell
# CentOS
yum -y install ipmitool

# Ubuntu
sudo apt-get update && sudo apt -y install ipmitool

# macOS
brew install ipmitool # macOS
```

- Load modules

```shell
modprobe ipmi_msghandler
modprobe ipmi_devintf
```

After successful installation, run the following command to see the output information from the ipmi server:

```shell
ipmitool -I lanplus -H <IP Address> -U <Username> -P <Password> sdr elist

SEL              | 72h | ns  |  7.1 | No Reading
Intrusion        | 73h | ok  |  7.1 | 
Fan1A RPM        | 30h | ok  |  7.1 | 2160 RPM
Fan2A RPM        | 32h | ok  |  7.1 | 2280 RPM
Fan3A RPM        | 34h | ok  |  7.1 | 2280 RPM
Fan4A RPM        | 36h | ok  |  7.1 | 2400 RPM
Fan5A RPM        | 38h | ok  |  7.1 | 2280 RPM
Fan6A RPM        | 3Ah | ok  |  7.1 | 2160 RPM
Inlet Temp       | 04h | ok  |  7.1 | 23 degrees C
Exhaust Temp     | 01h | ok  |  7.1 | 37 degrees C
Temp             | 0Fh | ok  |  3.2 | 45 degrees C
... more
```

<!-- markdownlint-disable MD046 -->
???+ attention

    1. The IP address refers to the IPMI port IP address of the remote management server.
    1. In the server's 「IPMI Settings -> Enable IPMI on LAN」 must be checked.
    1. The server’s 「Channel Permission Level Restriction」 operator level must match the 「Username」.
    1. The `ipmitool` package is installed on the machine running Datakit.

### Collector Configuration {#input-config}

=== "HOST Deployment"

    Go to the `conf.d/ipmi` directory under the DataKit installation directory, copy `ipmi.conf.sample` and rename it to `ipmi.conf`. Example follows:

    ```toml
        
    [[inputs.ipmi]]
      ## If you have so many servers that 10 seconds can't finish the job.
      ## You can start multiple collectors.
    
      ## (Optional) Collect interval: (defaults to "10s").
      interval = "10s"
    
      ## Set true to enable election
      election = true
    
      ## The binPath of ipmitool
      ## (Example) bin_path = "/usr/bin/ipmitool"
      bin_path = "/usr/bin/ipmitool"
    
      ## (Optional) The envs of LD_LIBRARY_PATH
      ## (Example) envs = [ "LD_LIBRARY_PATH=XXXX:$LD_LIBRARY_PATH" ]
    
      ## The ips of ipmi servers
      ## (Example) ipmi_servers = ["192.168.1.1"]
      ipmi_servers = ["192.168.1.1"]
    
      ## The interfaces of ipmi servers: (defaults to []string{"lan"}).
      ## If len(ipmi_users)<len(ipmi_ips), will use ipmi_users[0].
      ## (Example) ipmi_interfaces = ["lanplus"]
      ipmi_interfaces = ["lanplus"]
    
      ## The users name of ipmi servers: (defaults to []string{}).
      ## If len(ipmi_users)<len(ipmi_ips), will use ipmi_users[0].
      ## (Example) ipmi_users = ["root"]
      ## (Warning!) You'd better use hex_keys, it's more secure.
      ipmi_users = ["root"]
    
      ## The passwords of ipmi servers: (defaults to []string{}).
      ## If len(ipmi_passwords)<len(ipmi_ips), will use ipmi_passwords[0].
      ## (Example) ipmi_passwords = ["calvin"]
      ## (Warning!) You'd better use hex_keys, it's more secure.
      ipmi_passwords = ["calvin"]
    
      ## (Optional) Provide the hex key for the IMPI connection: (defaults to []string{}).
      ## If len(hex_keys)<len(ipmi_ips), will use hex_keys[0].
      ## (Example) hex_keys = ["XXXX"]
      # hex_keys = []
    
      ## (Optional) Schema Version: (defaults to [1]).input.go
      ## If len(metric_versions)<len(ipmi_ips), will use metric_versions[0].
      ## (Example) metric_versions = [2]
      metric_versions = [2]
    
      ## (Optional) Exec ipmitool timeout: (defaults to "5s").
      timeout = "5s"
    
      ## (Optional) Ipmi server drop warning delay: (defaults to "300s").
      ## (Example) drop_warning_delay = "300s"
      drop_warning_delay = "300s"
    
      ## Key words of current.
      ## (Example) regexp_current = ["current"]
      regexp_current = ["current"]
    
      ## Key words of voltage.
      ## (Example) regexp_voltage = ["voltage"]
      regexp_voltage = ["voltage"]
    
      ## Key words of power.
      ## (Example) regexp_power = ["pwr","power"]
      regexp_power = ["pwr","power"]
    
      ## Key words of temp.
      ## (Example) regexp_temp = ["temp"]
      regexp_temp = ["temp"]
    
      ## Key words of fan speed.
      ## (Example) regexp_fan_speed = ["fan"]
      regexp_fan_speed = ["fan"]
    
      ## Key words of usage.
      ## (Example) regexp_usage = ["usage"]
      regexp_usage = ["usage"]
    
      ## Key words of usage.
      ## (Example) regexp_count = []
      # regexp_count = []
    
      ## Key words of status.
      ## (Example) regexp_status = ["fan"]
      regexp_status = ["fan"]
    
    [inputs.ipmi.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    
    ```

    After configuring, restart DataKit.

=== "Kubernetes"

    You can inject collector configurations via [ConfigMap method](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [configure ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) to enable the collector.

    It also supports modifying configuration parameters through environment variables (you need to add it as a default collector in ENV_DEFAULT_ENABLED_INPUTS):

    - **ENV_INPUT_IPMI_INTERVAL**
    
        Collector repetition interval duration
    
        **Field type**: Duration
    
        **Collector configuration field**: `interval`
    
        **Default value**: 10s
    
    - **ENV_INPUT_IPMI_TIMEOUT**
    
        Timeout duration
    
        **Field type**: Duration
    
        **Collector configuration field**: `timeout`
    
        **Default value**: 5s
    
    - **ENV_INPUT_IPMI_DROP_WARNING_DELAY**
    
        Service degradation warning delay
    
        **Field type**: Duration
    
        **Collector configuration field**: `drop_warning_delay`
    
        **Default value**: 5m
    
    - **ENV_INPUT_IPMI_BIN_PATH**
    
        Execution file path
    
        **Field type**: String
    
        **Collector configuration field**: `bin_path`
    
        **Example**: `/usr/bin/ipmitool`
    
    - **ENV_INPUT_IPMI_ENVS**
    
        Path to execution dependency libraries
    
        **Field type**: JSON
    
        **Collector configuration field**: `envs`
    
        **Example**: ["LD_LIBRARY_PATH=XXXX:$LD_LIBRARY_PATH"]
    
    - **ENV_INPUT_IPMI_SERVERS**
    
        IPMI server URL
    
        **Field type**: JSON
    
        **Collector configuration field**: `ipmi_servers`
    
        **Example**: ["192.168.1.1","192.168.1.2"]
    
    - **ENV_INPUT_IPMI_INTERFACES**
    
        IPMI server interface protocol
    
        **Field type**: JSON
    
        **Collector configuration field**: `ipmi_interfaces`
    
        **Example**: ["`lanplus`"]
    
    - **ENV_INPUT_IPMI_USERS**
    
        Login name
    
        **Field type**: JSON
    
        **Collector configuration field**: `ipmi_users`
    
        **Example**: ["root"]
    
    - **ENV_INPUT_IPMI_PASSWORDS**
    
        Login password
    
        **Field type**: JSON
    
        **Collector configuration field**: `ipmi_passwords`
    
        **Example**: ["Calvin"]
    
    - **ENV_INPUT_IPMI_HEX_KEYS**
    
        Hexadecimal connection keys
    
        **Field type**: JSON
    
        **Collector configuration field**: `hex_keys`
    
        **Example**: ["50415353574F5244"]
    
    - **ENV_INPUT_IPMI_METRIC_VERSIONS**
    
        Metric versions
    
        **Field type**: JSON
    
        **Collector configuration field**: `metric_versions`
    
        **Example**: [2] or [3]
    
    - **ENV_INPUT_IPMI_REGEXP_CURRENT**
    
        Current metric regular expression
    
        **Field type**: JSON
    
        **Collector configuration field**: `regexp_current`
    
        **Example**: ["current"]
    
    - **ENV_INPUT_IPMI_REGEXP_VOLTAGE**
    
        Voltage metric regular expression
    
        **Field type**: JSON
    
        **Collector configuration field**: `regexp_voltage`
    
        **Example**: ["voltage"]
    
    - **ENV_INPUT_IPMI_REGEXP_POWER**
    
        Power metric regular expression
    
        **Field type**: JSON
    
        **Collector configuration field**: `regexp_power`
    
        **Example**: ["pwr","power"]
    
    - **ENV_INPUT_IPMI_REGEXP_TEMP**
    
        Temperature metric regular expression
    
        **Field type**: JSON
    
        **Collector configuration field**: `regexp_temp`
    
        **Example**: ["temp"]
    
    - **ENV_INPUT_IPMI_REGEXP_FAN_SPEED**
    
        Fan speed metric regular expression
    
        **Field type**: JSON
    
        **Collector configuration field**: `regexp_fan_speed`
    
        **Example**: ["fan"]
    
    - **ENV_INPUT_IPMI_REGEXP_USAGE**
    
        Usage metric regular expression
    
        **Field type**: JSON
    
        **Collector configuration field**: `regexp_usage`
    
        **Example**: ["usage"]
    
    - **ENV_INPUT_IPMI_REGEXP_COUNT**
    
        Count metric regular expression
    
        **Field type**: JSON
    
        **Collector configuration field**: `regexp_count`
    
        **Example**: []
    
    - **ENV_INPUT_IPMI_REGEXP_STATUS**
    
        Status metric regular expression
    
        **Field type**: JSON
    
        **Collector configuration field**: `regexp_status`
    
        **Example**: ["fan"]
    
    - **ENV_INPUT_IPMI_TAGS**
    
        Custom tags. If the configuration file has tags with the same name, they will override them.
    
        **Field type**: Map
    
        **Collector configuration field**: `tags`
    
        **Example**: tag1=value1,tag2=value2

???+ tip "Configuration Tips"

    - All keywords categorized into parameters should be in lowercase.
    - Refer to the data returned by the `ipmitool -I ...` command to configure keywords appropriately.

<!-- markdownlint-enable -->

<!--
## Election Configuration {#election-config}

The IPMI collector supports election functionality. When multiple machines are running DataKit, elections prevent duplicate data collection.

Enable election in the `/conf.d/datakit.conf` file:
```
[election]
  # Enable election
  enable = true

  # Set election namespace (default is "default")
  namespace = "default"

  # Allow appending election space tags to data
  enable_namespace_tag = false
```
Enable election in the `conf.d/ipmi/ipmi.conf` file:
```
  ## Set true to enable election
  election = true
```
-->

## Metrics {#metric}

All data collected by default appends the global election tag unless specified otherwise in the configuration through `[inputs.ipmi.tags]`:

``` toml
 [inputs.ipmi.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



- Tags


| Tag | Description |
|  ----  | --------|
|`host`|Monitored host name|
|`unit`|Unit name within the host|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`count`|Count.|int|count|
|`current`|Current.|float|ampere|
|`fan_speed`|Fan speed.|int|RPM|
|`power_consumption`|Power consumption.|float|watt|
|`status`|Status of the unit.|int|-|
|`temp`|Temperature.|float|C|
|`usage`|Usage.|float|percent|
|`voltage`|Voltage.|float|volt|
|`warning`|Warning on/off.|int|-|



[1]: https://github.com/ipmitool/ipmitool