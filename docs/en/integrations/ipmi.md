---
title     : 'IPMI'
summary   : 'Collect IPMI metrics'
tags:
  - 'IPMI'
__int_icon      : 'icon/ipmi'
dashboard :
  - desc  : 'N/A'
    path  : '-'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

IPMI metrics show the current, voltage, power consumption, occupancy rate, fan speed, temperature and equipment status of the monitored equipment.

IPMI is the abbreviation of Intelligent Platform Management Interface, which is an industry standard for managing peripheral devices used in enterprise systems based on Intel structure. This standard is formulated by Intel, Hewlett-Packard, NEC, Dell Computer and SuperMicro. Users can use IPMI to monitor the physical health characteristics of the server, such as temperature, voltage, fan working status, power status, etc.

IPMI enables the operation and maintenance system to obtain the operation health indicators of monitored servers and other devices **without intrusion**, thus ensuring information security.

## Configuration {#config}

### Preconditions {#requirements}

- Install the `ipmitool` Toolkit

DataKit collects IPMI data through the [`ipmitool`][1]  tool, so it needs to be installed on the machine. It can be installed by the following command:

```shell
# CentOS
yum -y install ipmitool

# Ubuntu
sudo apt-get update && sudo apt -y install ipmitool

# macOS
brew install ipmitool # macOS
```

- Loading Module

```shell
modprobe ipmi_msghandler
modprobe ipmi_devintf
```

After successful installation, you can see the information output by ipmi server by running the following command:

```shell
ipmitool -I lanplus -H <IP 地址> -U <用户名> -P <密码> sdr elist

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

    1. IP address refers to the IP address of the IPMI port of the server that you remotely manage
    1. Server `IPMI Settings -> Enable IPMI on LAN` needs to be checked
    1. Server `Channel Privilege Level Restrictions` operator level requirements and `<User Name>` keep level consistent
    1. `ipmitool` toolkit is installed on the machine running DataKit.

### Collector Configuration {#input-config}

=== "Host deployment"

    Go to the `conf.d/ipmi` directory under the DataKit installation directory, copy `ipmi.conf.sample` and name it `ipmi.conf`. Examples are as follows:
    
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
    
    After configuration, restart DataKit.

=== "Kubernetes"

    Can be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [Config ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) .

    Can also be turned on by environment variables, (needs to be added as the default collector in ENV_DEFAULT_ENABLED_INPUTS):
    
    - **ENV_INPUT_IPMI_INTERVAL**
    
        Collect interval
    
        **Type**: Duration
    
        **input.conf**: `interval`
    
        **Default**: 10s
    
    - **ENV_INPUT_IPMI_TIMEOUT**
    
        Timeout
    
        **Type**: Duration
    
        **input.conf**: `timeout`
    
        **Default**: 5s
    
    - **ENV_INPUT_IPMI_DROP_WARNING_DELAY**
    
        Ipmi server drop warning delay
    
        **Type**: Duration
    
        **input.conf**: `drop_warning_delay`
    
        **Default**: 5m
    
    - **ENV_INPUT_IPMI_BIN_PATH**
    
        The binPath of `ipmitool`
    
        **Type**: String
    
        **input.conf**: `bin_path`
    
        **Example**: `/usr/bin/ipmitool`
    
    - **ENV_INPUT_IPMI_ENVS**
    
        The envs of LD_LIBRARY_PATH
    
        **Type**: JSON
    
        **input.conf**: `envs`
    
        **Example**: ["LD_LIBRARY_PATH=XXXX:$LD_LIBRARY_PATH"]
    
    - **ENV_INPUT_IPMI_SERVERS**
    
        IPMI servers URL
    
        **Type**: JSON
    
        **input.conf**: `ipmi_servers`
    
        **Example**: ["192.168.1.1","192.168.1.2"]
    
    - **ENV_INPUT_IPMI_INTERFACES**
    
        The interfaces of IPMI servers
    
        **Type**: JSON
    
        **input.conf**: `ipmi_interfaces`
    
        **Example**: ["`lanplus`"]
    
    - **ENV_INPUT_IPMI_USERS**
    
        User name
    
        **Type**: JSON
    
        **input.conf**: `ipmi_users`
    
        **Example**: ["root"]
    
    - **ENV_INPUT_IPMI_PASSWORDS**
    
        Password
    
        **Type**: JSON
    
        **input.conf**: `ipmi_passwords`
    
        **Example**: ["Calvin"]
    
    - **ENV_INPUT_IPMI_HEX_KEYS**
    
        Provide the hex key for the IMPI connection
    
        **Type**: JSON
    
        **input.conf**: `hex_keys`
    
        **Example**: ["50415353574F5244"]
    
    - **ENV_INPUT_IPMI_METRIC_VERSIONS**
    
        Metric versions
    
        **Type**: JSON
    
        **input.conf**: `metric_versions`
    
        **Example**: [2] or [3]
    
    - **ENV_INPUT_IPMI_REGEXP_CURRENT**
    
        Regexp of current
    
        **Type**: JSON
    
        **input.conf**: `regexp_current`
    
        **Example**: ["current"]
    
    - **ENV_INPUT_IPMI_REGEXP_VOLTAGE**
    
        Regexp of voltage
    
        **Type**: JSON
    
        **input.conf**: `regexp_voltage`
    
        **Example**: ["voltage"]
    
    - **ENV_INPUT_IPMI_REGEXP_POWER**
    
        Regexp of power
    
        **Type**: JSON
    
        **input.conf**: `regexp_power`
    
        **Example**: ["pwr","power"]
    
    - **ENV_INPUT_IPMI_REGEXP_TEMP**
    
        Regexp of temperature
    
        **Type**: JSON
    
        **input.conf**: `regexp_temp`
    
        **Example**: ["temp"]
    
    - **ENV_INPUT_IPMI_REGEXP_FAN_SPEED**
    
        Regexp of fan speed
    
        **Type**: JSON
    
        **input.conf**: `regexp_fan_speed`
    
        **Example**: ["fan"]
    
    - **ENV_INPUT_IPMI_REGEXP_USAGE**
    
        Regexp of usage
    
        **Type**: JSON
    
        **input.conf**: `regexp_usage`
    
        **Example**: ["usage"]
    
    - **ENV_INPUT_IPMI_REGEXP_COUNT**
    
        Regexp of count metrics
    
        **Type**: JSON
    
        **input.conf**: `regexp_count`
    
        **Example**: []
    
    - **ENV_INPUT_IPMI_REGEXP_STATUS**
    
        Regexp of status metrics
    
        **Type**: JSON
    
        **input.conf**: `regexp_status`
    
        **Example**: ["fan"]
    
    - **ENV_INPUT_IPMI_TAGS**
    
        Customize tags. If there is a tag with the same name in the configuration file, it will be overwritten
    
        **Type**: Map
    
        **input.conf**: `tags`
    
        **Example**: tag1=value1,tag2=value2

???+ tip "Configuration"

    - The keywords for each parameter classification are all in lowercase
    - Refer to `ipmitool -I ...` The data returned by the command, then the keywords are reasonably configured
<!-- markdownlint-enable -->

<!--
## Election Configuration {#election-config}

IPMI collector supports election function. When multiple machines run DataKit, it prevents everyone from collecting data repeatedly through election.

`/conf.d/datakit.conf `file opens the `election `function:

```
[election]
  # Start election
  enable = true

  # Set the namespace of the election (default)
  namespace = "default"

  # Tag that allows election space to be appended to data
  enable_namespace_tag = false
```
`conf.d/ipmi/ipmi.conf` file opens the `election` function:
```
  ## Set true to enable election
  election = true
```
-->

## Metric {#metric}

For all of the following data collections, the global election tags will added automatically, we can add extra tags in `[inputs.ipmi.tags]` if needed:

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
|`unit`|Unit name in the host|

- Metrics


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
