---
title     : 'SNMP'
summary   : '采集 SNMP 设备的指标和对象数据'
__int_icon      : 'icon/snmp'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# SNMP
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

本文主要介绍 [SNMP](https://en.wikipedia.org/wiki/Simple_Network_Management_Protocol){:target="_blank"} 数据采集。

## 术语  {#terminology}

- `SNMP` (Simple network management protocol): A network protocol that is used to collect information about bare metal networking gear.
- `OID` (Object identifier): A unique ID or address on a device that when polled returns the response code of that value. For example, OIDs are CPU or device fan speed.
- `sysOID` (System object identifier): A specific address that defines the device type. All devices have a unique ID that defines it. For example, the Meraki base sysOID is `1.3.6.1.4.1.29671`.
- `MIB` (Managed information base): A database or list of all the possible OIDs and their definitions that are related to the MIB. For example, the `IF-MIB` (interface MIB) contains all the OIDs for descriptive information about a device’s interface.

## 关于 SNMP 协议 {#config-pre}

SNMP 协议分为 3 个版本：v1/v2c/v3，其中：

- **v1 和 v2c 是兼容的**。很多 SNMP 设备只提供 v2c 和 v3 两种版本的选择。v2c 版本，兼容性最好，很多旧设备只支持这个版本；
- 如果对安全性要求高，选用 v3。安全性也是 v3 版本与之前版本的主要区别；

Datakit 支持以上所有版本。

### 选择 v1/v2c 版本 {#config-v2}

如果选择 v1/v2c 版本，需要提供 `community string`，中文翻译为「团体名/团体字符串/未加密的口令」，即密码，与 SNMP 设备进行交互需要提供这个进行鉴权。另外，有的设备会进一步进行细分，分为「只读团体名」和「读写团体名」。顾名思义：

- 只读团体名：设备只会向该方提供内部指标数据，不能修改内部的一些配置（Datakit 用这个就够了）
- 读写团体名：提供方拥有设备内部指标数据查询与部分配置修改权限

### 选择 v3 版本 {#config-v3}

如果选择 v3 版本，需要提供 「用户名」、「认证算法/密码」、「加密算法/密码」、「上下文」 等，各个设备要求不同，根据设备侧的配置进行填写。

## 配置 {#config}

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/snmp` 目录，复制 `snmp.conf.sample` 并命名为 `snmp.conf`。示例如下：
    
    ```toml
        
    [[inputs.snmp]]
      ## Filling in specific device IP address, like ["10.200.10.240", "10.200.10.241"].
      ## And you can use auto_discovery and specific_devices at the same time.
      ## If you don't want to specific device, you don't need provide this.
      #
      # specific_devices = ["***"] # SNMP Device IP.
    
      ## Filling in autodiscovery CIDR subnet, like ["10.200.10.0/24", "10.200.20.0/24"].
      ## If you don't want to enable autodiscovery feature, you don't need provide this.
      #
      # auto_discovery = ["***"] # Used in autodiscovery mode only, ignore this in other cases.
    
      ## SNMP protocol version the devices using, fill in 2 or 3.
      ## If you using the version 1, just fill in 2. Version 2 supported version 1.
      ## This is must be provided.
      #
      snmp_version = 2
    
      ## SNMP port in the devices. Default is 161. In most cases, you don't need change this.
      ## This is optional.
      #
      # port = 161
    
      ## Password in SNMP v2, enclose with single quote. Only worked in SNMP v2.
      ## If you are using SNMP v2, this is must be provided.
      ## If you are using SNMP v3, you don't need provide this.
      #
      # v2_community_string = "***"
    
      ## Authentication stuff in SNMP v3.
      ## If you are using SNMP v2, you don't need provide this.
      ## If you are using SNMP v3, this is must be provided.
      #
      # v3_user = "***"
      # v3_auth_protocol = "***"
      # v3_auth_key = "***"
      # v3_priv_protocol = "***"
      # v3_priv_key = "***"
      # v3_context_engine_id = "***"
      # v3_context_name = "***"
    
      ## Number of workers used to collect and discovery devices concurrently. Default is 100.
      ## Modifying it based on device's number and network scale.
      ## This is optional.
      #
      # workers = 100
    
      ## Interval between each autodiscovery in seconds. Default is "1h".
      ## Only worked in autodiscovery feature.
      ## This is optional.
      #
      # discovery_interval = "1h"
    
      ## Filling in excluded device IP address, like ["10.200.10.220", "10.200.10.221"].
      ## Only worked in autodiscovery feature.
      ## This is optional.
      #
      # discovery_ignored_ip = []
    
      ## Set true to enable election
      #
      # election = true
    
      ## Device Namespace. Default is "default".
      #
      # device_namespace = "default"
    
      ## Picking the metric data only contains the field's names below.
      #
      # enable_picking_data = true # Default is "false", which means collecting all data.
      # status = ["sysUpTimeInstance", "tcpCurrEstab", "ifAdminStatus", "ifOperStatus", "cswSwitchState"]
      # speed = ["ifHCInOctets", "ifHCInOctetsRate", "ifHCOutOctets", "ifHCOutOctetsRate", "ifHighSpeed", "ifSpeed", "ifBandwidthInUsageRate", "ifBandwidthOutUsageRate"]
      # cpu = ["cpuUsage"]
      # mem = ["memoryUsed", "memoryUsage", "memoryFree"]
      # extra = []
    
      [inputs.snmp.tags]
      # tag1 = "val1"
      # tag2 = "val2"
    
      [inputs.snmp.traps]
      # enable = true
      # bind_host = "0.0.0.0"
      # port = 9162
      # stop_timeout = 3    # stop timeout in seconds.
    
    ```

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。

---

???+ tip

    上述配置完成后，可以使用 `datakit debug --input-conf` 命令来测试配置是否正确，示例如下：

    ```sh
    sudo datakit debug --input-conf /usr/local/datakit/conf.d/snmp/snmp.conf
    ```

    如果正确会输出行协议信息，否则看不到行协议信息。

???+ attention

    1. 上面配置的 `inputs.snmp.tags` 中如果与原始 fields 中的 key 同名重复，则会被原始数据覆盖
    2. 设备的 IP 地址(指定设备模式)/网段(自动发现模式)、SNMP 协议的版本号及相对应的鉴权字段是必填字段
    3. 「指定设备」模式和「自动发现」模式，两种模式可以共存，但设备间的 SNMP 协议的版本号及相对应的鉴权字段必须保持一致
<!-- markdownlint-enable -->

### 配置 SNMP {#config-snmp}

- 在设备侧，配置 SNMP 协议

SNMP 设备在默认情况下，一般 SNMP 协议处于关闭状态，需要进入管理界面手动打开。同时，需要根据实际情况选择协议版本和填写相应信息。

<!-- markdownlint-disable MD046 -->
???+ tip

    有些设备为了安全需要额外配置放行 SNMP，具体因设备而异。比如华为系防火墙，需要在 "启用访问管理" 中勾选 SNMP 以放行。可以使用 `snmpwalk` 命令来测试采集侧与设备侧是否配置连通成功（在 Datakit 运行的主机上运行以下命令）：

    ```shell
    # 适用 v2c 版本
    snmpwalk -O bentU -v 2c -c [community string] [SNMP_DEVICE_IP] 1.3.6
    # 适用 v3 版本
    snmpwalk -v 3 -u user -l authPriv -a sha -A [认证密码] -x aes -X [加密密码] [SNMP_DEVICE_IP] 1.3.6
    ```

    如果配置没有问题的话，该命令会输出大量数据。`snmpwalk` 是运行在采集侧的一个测试工具，MacOS 下自带，Linux 安装方法：

    ```shell
    sudo yum install net-snmp net-snmp-utils # CentOS
    sudo apt–get install snmp                # Ubuntu
    ```
<!-- markdownlint-enable -->

- 在 DataKit 侧，配置采集。

## 高级功能 {#advanced-features}

### 自定义设备的 OID 配置 {#advanced-custom-oid}

如果你发现被采集的设备上报的数据中没有你想要的指标，那么，你可以需要为该设备额外定义一份 Profile。

设备的所有 OID 一般都可以在其官网上下载。Datakit 定义了一些通用的 OID，以及 Cisco/Dell/HP 等部分设备。根据 SNMP 协议，各设备生产商可以自定义 [OID](https://www.dpstele.com/snmp/what-does-oid-network-elements.php){:target="_blank"}，用于标识其内部特殊对象。如果想要标识这些，你需要自定义设备的配置(我们这里称这种配置为 Profile，即 "自定义 Profile")，方法如下。

要增加指标或者自定义配置，需要列出 MIB name, table name, table OID, symbol 和 symbol OID，例如：

```yaml
- MIB: EXAMPLE-MIB
    table:
      # Identification of the table which metrics come from.
      OID: 1.3.6.1.4.1.10
      name: exampleTable
    symbols:
      # List of symbols ('columns') to retrieve.
      # Same format as for a single OID.
      # Each row in the table emits these metrics.
      - OID: 1.3.6.1.4.1.10.1.1
        name: exampleColumn1
```

下面是一个操作示例。

在 Datakit 的安装目录的路径 `conf.d/snmp/profiles` 下，如下所示创建 yml 文件 `cisco-3850.yaml`（这里以 Cisco 3850 为例）：

``` yaml
# Backward compatibility shim. Prefer the Cisco Catalyst profile directly
# Profile for Cisco 3850 devices

extends:
  - _base.yaml
  - _cisco-generic.yaml
  - _cisco-catalyst.yaml

sysobjectid: 1.3.6.1.4.1.9.1.1745 # cat38xxstack

device:
  vendor: "cisco"

# Example sysDescr:
#   Cisco IOS Software, IOS-XE Software, Catalyst L3 Switch Software (CAT3K_CAA-UNIVERSALK9-M), Version 03.06.06E RELEASE SOFTWARE (fc1) Technical Support: http://www.cisco.com/techsupport Copyright (c) 1986-2016 by Cisco Systems, Inc. Compiled Sat 17-Dec-

metadata:
  device:
    fields:
      serial_number:
        symbol:
          MIB: OLD-CISCO-CHASSIS-MIB
          OID: 1.3.6.1.4.1.9.3.6.3.0
          name: info

metrics:
  # iLO controller metrics.

  - # Power state.
    # NOTE: unknown(1), poweredOff(2), poweredOn(3), insufficientPowerOrPowerOnDenied(4)
    MIB: CPQSM2-MIB
    symbol:
      OID: 1.3.6.1.4.1.232.9.2.2.32
      name: temperature
```

如上所示，定义了一个 `sysobjectid` 为 `1.3.6.1.4.1.9.1.1745` 的设备，下次 Datakit 如果采集到 `sysobjectid` 相同的设备时，便会应用该文件，在此情况下：

- 采集到 OID 为 `1.3.6.1.4.1.9.3.6.3.0` 的数据时会把名称为 `serial_number` 的字段加到 `device_meta` 字段（JSON）里面，然后附加到指标集 `snmp_object` 中作为 Object 上报；
- 采集到 OID 为 `1.3.6.1.4.1.232.9.2.2.32` 的数据时把名称为 `temperature` 的字段附加到指标集 `snmp_metric` 中作为 Metric 上报；

<!-- markdownlint-disable MD046 -->
???+ attention

    `conf.d/snmp/profiles` 这个文件夹需要 SNMP 采集器运行一次后才会出现。
<!-- markdownlint-enable -->

## 指标 {#metric}

以下所有数据采集，默认会追加名为 `host`（值为 SNMP 设备的名称），也可以在配置中通过 `[inputs.snmp.tags]` 指定其它标签：

``` toml
[inputs.snmp.tags]
 # some_tag = "some_value"
 # more_tag = "some_other_value"
 # ...
```

<!-- markdownlint-disable MD046 -->
???+ attention
    以下所有指标集以及其指标，只包含部分常见的字段，一些设备特定的字段，根据配置和设备型号不同，会额外多出一些字段。
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD024 -->








### `snmp_metric`

SNMP device metric data.

- 标签


| Tag | Description |
|  ----  | --------|
|`cpu`|CPU index. Optional.|
|`device_vendor`|Device vendor.|
|`entity_name`|Device entity name. Optional.|
|`host`|Device host, replace with IP.|
|`interface`|Device interface. Optional.|
|`interface_alias`|Device interface alias. Optional.|
|`ip`|Device IP.|
|`mac_addr`|Device MAC address. Optional.|
|`mem`|Memory index. Optional.|
|`mem_pool_name`|Memory pool name. Optional.|
|`name`|Device name, replace with IP.|
|`power_source`|Power source. Optional.|
|`power_status_descr`|Power status description. Optional.|
|`sensor_id`|Sensor ID. Optional.|
|`sensor_type`|Sensor type. Optional.|
|`snmp_host`|Device host.|
|`snmp_profile`|Device SNMP profile file.|
|`temp_index`|Temperature index. Optional.|
|`temp_state`|Temperature state. Optional.|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cieIfInputQueueDrops`|[Cisco only] (Shown as packet) The number of input packets dropped.|float|count|
|`cieIfLastInTime`|[Cisco only] (Shown as millisecond) The elapsed time in milliseconds since the last protocol input packet was received.|float|ms|
|`cieIfLastOutTime`|[Cisco only] (Shown as millisecond) The elapsed time in milliseconds since the last protocol output packet was transmitted.|float|ms|
|`cieIfOutputQueueDrops`|[Cisco only] (Shown as packet) The number of output packets dropped by the interface even though no error was detected to prevent them being transmitted.|float|count|
|`cieIfResetCount`|[Cisco only] The number of times the interface was internally reset and brought up.|float|count|
|`ciscoEnvMonFanState`|[Cisco only] The current state of the fan being instrumented.|float|count|
|`ciscoEnvMonSupplyState`|[Cisco only] The current state of the power supply being instrumented.|float|count|
|`ciscoEnvMonTemperatureStatusValue`|[Cisco only] The current value of the test point being instrumented.|float|count|
|`ciscoMemoryPoolFree`|[Cisco only] Indicates the number of bytes from the memory pool that are currently unused on the managed device.|float|count|
|`ciscoMemoryPoolLargestFree`|[Cisco only] Indicates the largest number of contiguous bytes from the memory pool that are currently unused on the managed device.|float|count|
|`ciscoMemoryPoolUsed`|[Cisco only] Indicates the number of bytes from the memory pool that are currently in use by applications on the managed device.|float|count|
|`cpmCPUTotal1minRev`|[Cisco only] [Shown as percent] The overall CPU busy percentage in the last 1 minute period.|float|percent|
|`cpmCPUTotalMonIntervalValue`|[Cisco only] (Shown as percent) The overall CPU busy percentage in the last cpmCPUMonInterval period.|float|percent|
|`cpuUsage`|(Shown as percent) Percentage of CPU currently being used.|float|percent|
|`cswStackPortOperStatus`|[Cisco only] The state of the stack port.|float|count|
|`cswSwitchState`|[Cisco only] The current state of a switch.|float|count|
|`entSensorValue`|[Cisco only] The most recent measurement seen by the sensor.|float|count|
|`ifAdminStatus`|The desired state of the interface.|float|-|
|`ifBandwidthInUsageRate`|(Shown as percent) The percent rate of used received bandwidth.|float|percent|
|`ifBandwidthOutUsageRate`|(Shown as percent) The percent rate of used sent bandwidth.|float|percent|
|`ifHCInBroadcastPkts`|(Shown as packet) The number of packets delivered by this sub-layer to a higher (sub-)layer that were addressed to a broadcast address at this sub-layer.|float|count|
|`ifHCInMulticastPkts`|(Shown as packet) The number of packets delivered by this sub-layer to a higher (sub-)layer which were addressed to a multicast address at this sub-layer.|float|count|
|`ifHCInOctets`|(Shown as byte) The total number of octets received on the interface including framing characters.|float|count|
|`ifHCInOctetsRate`|(Shown as byte) The total number of octets received on the interface including framing characters.|float|-|
|`ifHCInUcastPkts`|(Shown as packet) The number of packets delivered by this sub-layer to a higher (sub-)layer that were not addressed to a multicast or broadcast address at this sub-layer.|float|count|
|`ifHCOutBroadcastPkts`|(Shown as packet) The total number of packets that higher-level protocols requested be transmitted that were addressed to a broadcast address at this sub-layer, including those that were discarded or not sent.|float|count|
|`ifHCOutMulticastPkts`|(Shown as packet) The total number of packets that higher-level protocols requested be transmitted that were addressed to a multicast address at this sub-layer including those that were discarded or not sent.|float|count|
|`ifHCOutOctets`|(Shown as byte) The total number of octets transmitted out of the interface including framing characters.|float|count|
|`ifHCOutOctetsRate`|(Shown as byte) The total number of octets transmitted out of the interface including framing characters.|float|count|
|`ifHCOutUcastPkts`|(Shown as packet) The total number of packets higher-level protocols requested be transmitted that were not addressed to a multicast or broadcast address at this sub-layer including those that were discarded or not sent.|float|count|
|`ifHighSpeed`|An estimate of the interface's current bandwidth in units of 1,000,000 bits per second, or the nominal bandwidth.|float|count|
|`ifInDiscards`|(Shown as packet) The number of inbound packets chosen to be discarded even though no errors had been detected to prevent them being deliverable to a higher-layer protocol.|float|count|
|`ifInDiscardsRate`|(Shown as packet) The number of inbound packets chosen to be discarded even though no errors had been detected to prevent them being deliverable to a higher-layer protocol.|float|count|
|`ifInErrors`|(Shown as packet) The number of inbound packets that contained errors preventing them from being deliverable to a higher-layer protocol.|float|count|
|`ifInErrorsRate`|(Shown as packet) The number of inbound packets that contained errors preventing them from being deliverable to a higher-layer protocol.|float|count|
|`ifNumber`|Number of interface.|float|-|
|`ifOperStatus`|(Shown as packet) The current operational state of the interface.|float|count|
|`ifOutDiscards`|(Shown as packet) The number of outbound packets chosen to be discarded even though no errors had been detected to prevent them being transmitted.|float|count|
|`ifOutDiscardsRate`|(Shown as packet) The number of outbound packets chosen to be discarded even though no errors had been detected to prevent them being transmitted.|float|count|
|`ifOutErrors`|(Shown as packet) The number of outbound packets that could not be transmitted because of errors.|float|count|
|`ifOutErrorsRate`|(Shown as packet) The number of outbound packets that could not be transmitted because of errors.|float|count|
|`ifSpeed`|An estimate of the interface's current bandwidth in bits per second, or the nominal bandwidth.|float|count|
|`memoryFree`|(Shown as percent) The percentage of memory not being used.|float|percent|
|`memoryUsage`|(Shown as percent) The percentage of memory currently being used.|float|percent|
|`memoryUsed`|(Shown as byte) Number of bytes of memory currently being used.|float|count|
|`sysUpTimeInstance`|The time (in hundredths of a second) since the network management portion of the system was last re-initialized.|float|count|
|`tcpActiveOpens`|The number of times that TCP connections have made a direct transition to the SYN-SENT state from the CLOSED state.|float|count|
|`tcpAttemptFails`|The number of times that TCP connections have made a direct transition to the CLOSED state from either the SYN-SENT state or the SYN-RCVD state, or to the LISTEN state from the SYN-RCVD state.|float|count|
|`tcpCurrEstab`|The number of TCP connections for which the current state is either ESTABLISHED or CLOSE-WAIT.|float|-|
|`tcpEstabResets`|The number of times that TCP connections have made a direct transition to the CLOSED state from either the ESTABLISHED state or the CLOSE-WAIT state.|float|count|
|`tcpInErrs`|(Shown as segment) The total number of segments received in error (e.g., bad TCP checksums).|float|count|
|`tcpOutRsts`|(Shown as segment) The number of TCP segments sent containing the RST flag.|float|count|
|`tcpPassiveOpens`|(Shown as connection) The number of times TCP connections have made a direct transition to the SYN-RCVD state from the LISTEN state.|float|count|
|`tcpRetransSegs`|(Shown as segment) The total number of segments retransmitted; that is, the number of TCP segments transmitted containing one or more previously transmitted octets.|float|count|
|`udpInErrors`|(Shown as datagram) The number of received UDP datagram that could not be delivered for reasons other than the lack of an application at the destination port.|float|count|
|`udpNoPorts`|(Shown as datagram) The total number of received UDP datagram for which there was no application at the destination port.|float|count|




## 对象 {#object}





### `snmp_object`

SNMP device object data.

- 标签


| Tag | Description |
|  ----  | --------|
|`device_vendor`|Device vendor.|
|`host`|Device host, replace with IP.|
|`ip`|Device IP.|
|`name`|Device name, replace with IP.|
|`snmp_host`|Device host.|
|`snmp_profile`|Device SNMP profile file.|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`all`|Device all data (JSON format).|string|-|
|`cpus`|Device CPUs (JSON format).|string|-|
|`device_meta`|Device meta data (JSON format).|string|-|
|`interfaces`|Device network interfaces (JSON format).|string|-|
|`mem_pool_names`|Device memory pool names (JSON format).|string|-|
|`mems`|Device memories (JSON format).|string|-|
|`sensors`|Device sensors (JSON format).|string|-|







<!-- markdownlint-enable -->

## FAQ {#faq}

### :material-chat-question: Datakit 是如何发现设备的? {#faq-discover}

Datakit 支持 "指定设备" 和 "自动发现" 两种模式。两种模式可以同时开启。

指定设备模式下，Datakit 与指定 IP 的设备使用 SNMP 协议进行通信，可以获知其目前在线状态。

自动发现模式下，Datakit 向指定 IP 网段内的所有地址逐一发送 SNMP 协议数据包，如果其响应可以匹配到相应的 Profile，那么 Datakit 认为该 IP 上有一个 SNMP 设备。

### :material-chat-question: 在观测云上看不到我想要的指标怎么办? {#faq-not-support}

Datakit 可以从所有 SNMP 设备中收集通用的基线指标。如果你发现被采集的设备上报的数据中没有你想要的指标，那么，你可以需要为该设备[自定义一份 Profile](snmp.md#advanced-custom-oid)。

为了完成上述工作，你很可能需要从设备厂商的官网下载该设备型号的 OID 手册。

<!-- markdownlint-disable MD013 -->

### :material-chat-question: 为什么开启 SNMP 设备采集但看不到指标? {#faq-no-metrics}

<!-- markdownlint-enable -->

尝试为你的设备放开 ACLs/防火墙 规则。

可以在运行 Datakit 的主机上运行命令 `snmpwalk -O bentU -v 2c -c <COMMUNITY_STRING> <IP_ADDRESS>:<PORT> 1.3.6`。如果得到一个没有任何响应的超时，很可能是有什么东西阻止了 Datakit 从你的设备上收集指标。
