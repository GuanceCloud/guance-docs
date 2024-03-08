---
title     : 'IPMI'
summary   : 'IPMI 指标展示被监测设备的电流、电压、功耗、占用率、风扇转速、温度以及设备状态等信息'
__int_icon      : 'icon/ipmi'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# IPMI
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

IPMI 指标展示被监测设备的电流、电压、功耗、占用率、风扇转速、温度以及设备状态等信息。

IPMI 是智能型平台管理接口（Intelligent Platform Management Interface）的缩写，是管理基于 Intel 结构的企业系统中所使用的外围设备采用的一种工业标准，该标准由英特尔、惠普、NEC、美国戴尔电脑和 SuperMicro 等公司制定。用户可以利用 IPMI 监视服务器的物理健康特征，如温度、电压、风扇工作状态、电源状态等。

IPMI 可以让运维系统**无侵入**获得被监控服务器等设备的运行健康指标，保障信息安全。

## 配置  {#input-config}

### 前置条件 {#precondition}

- 安装 `ipmitool` 工具包

Datakit 是通过 [`ipmitool`][1] 这个工具来采集 IPMI 数据的，故需要机器上安装这个工具。可通过如下命令安装：

```shell
# CentOS
yum -y install ipmitool

# Ubuntu
sudo apt-get update && sudo apt -y install ipmitool

# macOS
brew install ipmitool # macOS
```

- 加载模块

```shell
modprobe ipmi_msghandler
modprobe ipmi_devintf
```

安装成功后，运行如下命令，即可以看到 ipmi 服务器输出的信息：

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

    1. IP 地址指的是被您远程管理服务器的 IPMI 口 IP 地址
    1. 服务器的「IPMI 设置 -> 启用 LAN 上的 IPMI」需要勾选
    1. 服务器「信道权限级别限制」操作员级别需要和「用户名」保持级别一致
    1. `ipmitool` 工具包是安装到运行 Datakit 的机器里。

### 采集器配置 {#input-config}

=== "主机部署"

    进入 DataKit 安装目录下的 `conf.d/ipmi` 目录，复制 `ipmi.conf.sample` 并命名为 `ipmi.conf`。示例如下：

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

    配置好后，重启 DataKit 即可。

=== "Kubernetes"

    可通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting) 或 [配置 ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) 开启采集器。

    也支持以环境变量的方式修改配置参数（需要在 ENV_DEFAULT_ENABLED_INPUTS 中加为默认采集器）：

    - **ENV_INPUT_IPMI_INTERVAL**
    
        采集器重复间隔时长
    
        **Type**: TimeDuration
    
        **ConfField**: `interval`
    
        **Default**: 10s
    
    - **ENV_INPUT_IPMI_TIMEOUT**
    
        超时时长
    
        **Type**: TimeDuration
    
        **ConfField**: `timeout`
    
        **Default**: 5s
    
    - **ENV_INPUT_IPMI_DROP_WARNING_DELAY**
    
        退服告警延迟
    
        **Type**: TimeDuration
    
        **ConfField**: `drop_warning_delay`
    
        **Default**: 5m
    
    - **ENV_INPUT_IPMI_BIN_PATH**
    
        执行文件路径
    
        **Type**: String
    
        **ConfField**: `bin_path`
    
        **Example**: `/usr/bin/ipmitool`
    
    - **ENV_INPUT_IPMI_ENVS**
    
        执行依赖库的路径
    
        **Type**: JSON
    
        **ConfField**: `envs`
    
        **Example**: ["LD_LIBRARY_PATH=XXXX:$LD_LIBRARY_PATH"]
    
    - **ENV_INPUT_IPMI_SERVERS**
    
        IPMI 服务器 URL
    
        **Type**: JSON
    
        **ConfField**: `ipmi_servers`
    
        **Example**: ["192.168.1.1","192.168.1.2"]
    
    - **ENV_INPUT_IPMI_INTERFACES**
    
        IPMI 服务器接口协议
    
        **Type**: JSON
    
        **ConfField**: `ipmi_interfaces`
    
        **Example**: ["`lanplus`"]
    
    - **ENV_INPUT_IPMI_USERS**
    
        登录名
    
        **Type**: JSON
    
        **ConfField**: `ipmi_users`
    
        **Example**: ["root"]
    
    - **ENV_INPUT_IPMI_PASSWORDS**
    
        登录密码
    
        **Type**: JSON
    
        **ConfField**: `ipmi_passwords`
    
        **Example**: ["Calvin"]
    
    - **ENV_INPUT_IPMI_HEX_KEYS**
    
        十六进制连接秘钥
    
        **Type**: JSON
    
        **ConfField**: `hex_keys`
    
        **Example**: ["50415353574F5244"]
    
    - **ENV_INPUT_IPMI_METRIC_VERSIONS**
    
        指标版本
    
        **Type**: JSON
    
        **ConfField**: `metric_versions`
    
        **Example**: [2] or [3]
    
    - **ENV_INPUT_IPMI_REGEXP_CURRENT**
    
        电流指标正则
    
        **Type**: JSON
    
        **ConfField**: `regexp_current`
    
        **Example**: ["current"]
    
    - **ENV_INPUT_IPMI_REGEXP_VOLTAGE**
    
        电压指标正则
    
        **Type**: JSON
    
        **ConfField**: `regexp_voltage`
    
        **Example**: ["voltage"]
    
    - **ENV_INPUT_IPMI_REGEXP_POWER**
    
        功率指标正则
    
        **Type**: JSON
    
        **ConfField**: `regexp_power`
    
        **Example**: ["pwr","power"]
    
    - **ENV_INPUT_IPMI_REGEXP_TEMP**
    
        温度电流指标正则
    
        **Type**: JSON
    
        **ConfField**: `regexp_temp`
    
        **Example**: ["temp"]
    
    - **ENV_INPUT_IPMI_REGEXP_FAN_SPEED**
    
        风扇转速指标正则
    
        **Type**: JSON
    
        **ConfField**: `regexp_fan_speed`
    
        **Example**: ["fan"]
    
    - **ENV_INPUT_IPMI_REGEXP_USAGE**
    
        使用率指标正则
    
        **Type**: JSON
    
        **ConfField**: `regexp_usage`
    
        **Example**: ["usage"]
    
    - **ENV_INPUT_IPMI_REGEXP_COUNT**
    
        统计指标正则
    
        **Type**: JSON
    
        **ConfField**: `regexp_count`
    
        **Example**: []
    
    - **ENV_INPUT_IPMI_REGEXP_STATUS**
    
        状态指标正则
    
        **Type**: JSON
    
        **ConfField**: `regexp_status`
    
        **Example**: ["fan"]
    
    - **ENV_INPUT_IPMI_TAGS**
    
        自定义标签。如果配置文件有同名标签，将会覆盖它
    
        **Type**: Map
    
        **ConfField**: `tags`
    
        **Example**: tag1=value1,tag2=value2

???+ tip "配置提示"

    - 各个参数归类的关键词，一律用小写
    - 参考 `ipmitool -I ...` 指令返回的数据，合理配置关键词

<!-- markdownlint-enable -->

<!--
## 选举配置 {#election-config}

IPMI 采集器支持选举功能，当多台机器运行 DataKit 时，通过选举，防止大家重复采集数据。

`/conf.d/datakit.conf` 文件打开选举功能：
```
[election]
  # 开启选举
  enable = true

  # 设置选举的命名空间（默认 default）
  namespace = "default"

  # 允许在数据上追加选举空间的 tag
  enable_namespace_tag = false
```
`conf.d/ipmi/ipmi.conf` 文件打开选举功能：
```
  ## Set true to enable election
  election = true
```
-->

## 指标 {#metric}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.ipmi.tags]` 指定其它标签：

``` toml
 [inputs.ipmi.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



- 标签


| Tag | Description |
|  ----  | --------|
|`host`|Monitored host name|
|`unit`|Unit name in the host|

- 指标列表


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
