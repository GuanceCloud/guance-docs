---
title     : 'SNMP'
summary   : '采集 SNMP 设备的指标和对象数据'
tags:
  - 'SNMP'
__int_icon      : 'icon/snmp'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

本文主要介绍 [SNMP](https://en.wikipedia.org/wiki/Simple_Network_Management_Protocol){:target="_blank"} 数据采集。

## 术语  {#terminology}

- `SNMP` (Simple network management protocol): 用于收集有关裸机网络设备信息的网络协议。
- `OID` (Object identifier): 设备上的唯一 ID 或地址，轮询时返回该值的响应代码。例如，OID 是 CPU 或设备风扇速度。
- `sysOID` (System object identifier): 定义设备类型的特定地址。所有设备都有一个定义它的唯一 ID。例如，`Meraki` 基础 sysOID 是“1.3.6.1.4.1.29671”。
- `MIB` (Managed information base): 与 MIB 相关的所有可能的 OID 及其定义的数据库或列表。例如，“IF-MIB”（接口 MIB）包含有关设备接口的描述性信息的所有 OID。

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
      ## Filling in specific device IP address, example ["10.200.10.240", "10.200.10.241"].
      ## And you can use auto_discovery and specific_devices at the same time.
      ## If you don't want to specific device, you don't need provide this.
      # specific_devices = ["***"] # SNMP Device IP.
    
      ## Filling in autodiscovery CIDR subnet, example ["10.200.10.0/24", "10.200.20.0/24"].
      ## If you don't want to enable autodiscovery feature, you don't need provide this.
      # auto_discovery = ["***"] # Used in autodiscovery mode only, ignore this in other cases.
    
      ## Consul server url for consul discovery
      ## We can discovery snmp instance from consul services
      # consul_discovery_url = "http://127.0.0.1:8500"
    
      ## Consul token, optional.
      # consul_token = "<consul token>"
    
      ## Instance ip key name. ("IP" case sensitive)
      # instance_ip_key = "IP"
    
      ## Witch task will collect, according to consul service filed "Address"
      ## [] mean collect all, optional, default to []
      # exporter_ips = ["<ip1>", "<ip2>"...]
    
      ## Consul TLS connection config, optional.
      # ca_certs = ["/opt/tls/ca.crt"]
      # cert = "/opt/tls/client.crt"
      # cert_key = "/opt/tls/client.key"
      # insecure_skip_verify = true
    
      ## SNMP protocol version the devices using, fill in 2 or 3.
      ## If you using the version 1, just fill in 2. Version 2 supported version 1.
      ## This is must be provided.
      snmp_version = 2
    
      ## SNMP port in the devices. Default is 161. In most cases, you don't need change this.
      ## This is optional.
      # port = 161
    
      ## Password in SNMP v2, enclose with single quote. Only worked in SNMP v2.
      ## If you are using SNMP v2, this is must be provided.
      ## If you are using SNMP v3, you don't need provide this.
      # v2_community_string = "***"
    
      ## Authentication stuff in SNMP v3.
      ## If you are using SNMP v2, you don't need provide this.
      ## If you are using SNMP v3, this is must be provided.
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
      # workers = 100
    
      ## Interval between each auto discovery in seconds. Default is "1h".
      ## Only worked in auto discovery feature.
      ## This is optional.
      # discovery_interval = "1h"
    
      ## Collect metric interval, default is 10s. (optional)
      # metric_interval = "10s"
    
      ## Collect object interval, default is 5m. (optional)
      # object_interval = "5m"
    
      ## Filling in excluded device IP address, example ["10.200.10.220", "10.200.10.221"].
      ## Only worked in auto discovery feature.
      ## This is optional.
      # discovery_ignored_ip = []
    
      ## Set true to enable election
      # election = true
    
      ## Device Namespace. Default is "default".
      # device_namespace = "default"
    
      ## Picking the metric data only contains the field's names below.
      # enable_picking_data = true # Default is "false", which means collecting all data.
      # status = ["sysUpTimeInstance", "tcpCurrEstab", "ifAdminStatus", "ifOperStatus", "cswSwitchState"]
      # speed = ["ifHCInOctets", "ifHCInOctetsRate", "ifHCOutOctets", "ifHCOutOctetsRate", "ifHighSpeed", "ifSpeed", "ifBandwidthInUsageRate", "ifBandwidthOutUsageRate"]
      # cpu = ["cpuUsage"]
      # mem = ["memoryUsed", "memoryUsage", "memoryFree"]
      # extra = []
    
      ## The matched tags would be dropped.
      # tags_ignore = ["Key1","key2"]
    
      ## The regexp matched tags would be dropped.
      # tags_ignore_regexp = ["^key1$","^(a|bc|de)$"]
    
      ## Zabbix profiles
      # [[inputs.snmp.zabbix_profiles]]
        ## Can be full path file name or only file name.
        ## If only file name, the path is "./conf.d/snmp/userprofiles/
        ## Suffix can be .yaml .yml .xml
        # profile_name = "xxx.yaml"
        ## ip_list is optional
        # ip_list = ["ip1", "ip2"]
        ## Device class, Best to use the following words:
        ## access_point, firewall, load_balancer, pdu, printer, router, sd_wan, sensor, server, storage, switch, ups, wlc, net_device
        # class = "server"
    
      # [[inputs.snmp.zabbix_profiles]]
        # profile_name = "yyy.xml"
        # ip_list = ["ip3", "ip4"]
        # class = "switch"
    
      # ...
    
      ## Prometheus snmp_exporter profiles, 
      ## If module mapping different class, can disassemble yml file.
      # [[inputs.snmp.prom_profiles]]
        # profile_name = "xxx.yml"
        ## ip_list useful when xxx.yml have 1 module 
        # ip_list = ["ip1", "ip2"]
        # class = "net_device"
    
      # ...
    
      ## Prometheus consul discovery module mapping.  ("type"/"isp" case sensitive)
      # [[inputs.snmp.module_regexps]]
        # module = "vpn5"
        ## There is an and relationship between step regularization
        # step_regexps = [["type", "vpn"],["isp", "CT"]]
    
      # [[inputs.snmp.module_regexps]]
        # module = "switch"
        # step_regexps = [["type", "switch"]]
    
      # ...
        
      ## Field key or tag key mapping. Do NOT edit.
      [inputs.snmp.key_mapping]
        CNTLR_NAME = "unit_name"
        DISK_NAME = "unit_name"
        ENT_CLASS = "unit_class"
        ENT_NAME = "unit_name"
        FAN_DESCR = "unit_desc"
        IF_OPERS_TATUS = "unit_status"
        IFADMINSTATUS = "unit_status"
        IFALIAS = "unit_alias"
        IFDESCR = "unit_desc"
        IFNAME = "unit_name"
        IFOPERSTATUS = "unit_status"
        IFTYPE = "unit_type"
        PSU_DESCR = "unit_desc"
        SENSOR_LOCALE = "unit_locale"
        SNMPINDEX = "snmp_index"
        SNMPVALUE = "snmp_value"
        TYPE = "unit_type"
        SENSOR_INFO = "unit_desc"
        ## We can add more mapping below
        # dev_fan_speed = "fanSpeed"
        # dev_disk_size = "diskTotal
      
      ## Reserved oid-key mappings. Do NOT edit.
      [inputs.snmp.oid_keys]
        "1.3.6.1.2.1.1.3.0" = "netUptime"
        "1.3.6.1.2.1.25.1.1.0" = "uptime"
        "1.3.6.1.2.1.2.2.1.13" = "ifInDiscards"
        "1.3.6.1.2.1.2.2.1.14" = "ifInErrors"
        "1.3.6.1.2.1.31.1.1.1.6" = "ifHCInOctets"
        "1.3.6.1.2.1.2.2.1.19" = "ifOutDiscards"
        "1.3.6.1.2.1.2.2.1.20" = "ifOutErrors"
        "1.3.6.1.2.1.31.1.1.1.10" = "ifHCOutOctets"
        "1.3.6.1.2.1.31.1.1.1.15" = "ifHighSpeed"
        "1.3.6.1.2.1.2.2.1.8" = "ifNetStatus"
        ## We can add more oid-key mapping below
    
      # [inputs.snmp.tags]
        # tag1 = "val1"
        # tag2 = "val2"
    
      [inputs.snmp.traps]
        enable = true
        bind_host = "0.0.0.0"
        port = 9162
        stop_timeout = 3    # stop timeout in seconds.
    
    ```

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    可通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting) 或 [配置 ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) 开启采集器。

### 多种配置格式 {#configuration-formats}

#### Zabbix 格式 {#format-zabbix}

- 配置

    ```toml
      [[inputs.snmp.zabbix_profiles]]
        profile_name = "xxx.yaml"
        ip_list = ["ip1", "ip2"]
        class = "server"
    
      [[inputs.snmp.zabbix_profiles]]
        profile_name = "yyy.xml"
        ip_list = ["ip3", "ip4"]
        class = "firewall"
    
      # ...
    ```
  
    `profile_name` 可以是全路径或只包含文件名，只包含文件名的话，文件要放到 *./conf.d/snmp/userprofiles/* 子目录下。

    您可以去 Zabbix 官方下载对应的的配置，也可以去 [社区](https://github.com/zabbix/community-templates){:target="_blank"} 下载。

    如果您对下载到的 yaml 或 xml 文件不满意，也可以自行修改。

- 自动发现
    - 自动发现在引入的多个 yaml 配置里面匹配采集规则，进行采集。
    - 自动发现请尽量按 C 段配置，配置 B 段可能会慢一些。
    - 万一自动发现匹配不到 yaml ，是因为已有的 yaml 里面没有被采集设备的生产商特征码。
        - 可以在 yaml 的 items 里面人为加入一条 oid 信息，引导自动匹配过程。

          ```yaml
          zabbix_export:
            templates:
            - items:
              - snmp_oid: 1.3.6.1.4.1.2011.5.2.1.1.1.1.6.114.97.100.105.117.115.0.0.0.0
          ```

        - 拟加入的 oid 通过执行以下命令获得，后面加上 .0.0.0.0 是为了防止产生无用的指标。

        ```shell
        $ snmpwalk -v 2c -c public <ip> 1.3.6.1.2.1.1.2.0
        iso.3.6.1.2.1.1.2.0 = OID: iso.3.6.1.4.1.2011.2.240.12
        
        $ snmpgetnext -v 2c -c public <ip> 1.3.6.1.4.1.2011.2.240.12
        iso.3.6.1.4.1.2011.5.2.1.1.1.1.6.114.97.100.105.117.115 = STRING: "radius"
        ```

#### Prometheus 格式 {#format-Prometheus}

- 配置

    ```toml
      [[inputs.snmp.prom_profiles]]
        profile_name = "xxx.yml"
        ip_list = ["ip1", "ip2"]
        class = "server"
    
      [[inputs.snmp.prom_profiles]]
        profile_name = "yyy.yml"
        ip_list = ["ip3", "ip4"]
        class = "firewall"
    
      # ...
    ```

    profile 参考 Prometheus [snmp_exporter](https://github.com/prometheus/snmp_exporter){:target="_blank"} 的 snmp.yml 文件，
    建议把不同 class 的 [module](https://github.com/prometheus/snmp_exporter?tab=readme-ov-file#prometheus-configuration){:target="_blank"} 拆分成  不同 .yml 配置。

    Prometheus 的 profile 允许为 module 单独配置团体名 community，这个团体名优先于采集器配置的团体名。

    ```yml
    switch:
      walk:
      ...
      get:
      ...
      metrics:
      ...
      auth:
        community: xxxxxxxxxxxx
    ```

- 自动发现

    SNMP 采集器支持通过 Consul 服务发现来发现被采集对象，服务注入格式参考 [prom 官网](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#consul_sd_config){:target="_blank"}。

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

### 配置被采集 SNMP 设备 {#config-snmp}

SNMP 设备在默认情况下，一般 SNMP 协议处于关闭状态，需要进入管理界面手动打开。同时，需要根据实际情况选择协议版本和填写相应信息。

<!-- markdownlint-disable MD046 -->
???+ tip

    有些设备为了安全需要额外配置放行 SNMP，具体因设备而异。比如华为系防火墙，需要在 "启用访问管理" 中勾选 SNMP 以放行。
    可以使用 `snmpwalk` 命令来测试采集侧与设备侧是否配置连通成功（在 Datakit 运行的主机上运行以下命令）：

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

## 指标 {#metric}

以下所有数据采集，默认会追加全局选举 tag，也可以在配置中通过 `[inputs.snmp.tags]` 指定其它标签：

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
|`device_type`|Device vendor.|
|`device_vendor`|Device vendor.|
|`entity_name`|Device entity name. Optional.|
|`host`|Device host, replace with IP.|
|`interface`|Device interface. Optional.|
|`interface_alias`|Device interface alias. Optional.|
|`ip`|Device IP.|
|`mac_addr`|Device MAC address. Optional.|
|`mem`|Memory index. Optional.|
|`mem_pool_name`|Memory pool name. Optional.|
|`name`|Device name and IP.|
|`oid`|OID.|
|`power_source`|Power source. Optional.|
|`power_status_descr`|Power status description. Optional.|
|`sensor_id`|Sensor ID. Optional.|
|`sensor_type`|Sensor type. Optional.|
|`snmp_host`|Device host.|
|`snmp_index`|Macro value. Optional.|
|`snmp_profile`|Device SNMP profile file.|
|`snmp_value`|Macro value. Optional.|
|`sys_name`|System name.|
|`sys_object_id`|System object id.|
|`temp_index`|Temperature index. Optional.|
|`temp_state`|Temperature state. Optional.|
|`unit_alias`|Macro value. Optional.|
|`unit_class`|Macro value. Optional.|
|`unit_desc`|Macro value. Optional.|
|`unit_locale`|Macro value. Optional.|
|`unit_name`|Macro value. Optional.|
|`unit_status`|Macro value. Optional.|
|`unit_type`|Macro value. Optional.|

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
|`cpuStatus`|CPU status.|float|bool|
|`cpuTemperature`|The Temperature of cpu.|float|C|
|`cpuUsage`|(Shown as percent) Percentage of CPU currently being used.|float|percent|
|`cswStackPortOperStatus`|[Cisco only] The state of the stack port.|float|count|
|`cswSwitchState`|[Cisco only] The current state of a switch.|float|count|
|`current`|The current of item.|float|unknown|
|`diskAvailable`|Number of disk available.|float|B|
|`diskFree`|(Shown as percent) The percentage of disk not being used.|float|percent|
|`diskTotal`|Total of disk size.|float|B|
|`diskUsage`|(Shown as percent) The percentage of disk currently being used.|float|percent|
|`diskUsed`|Number of disk currently being used.|float|B|
|`entSensorValue`|[Cisco only] The most recent measurement seen by the sensor.|float|count|
|`fanSpeed`|The fan speed.|float|unknown|
|`fanStatus`|The fan status.|float|bool|
|`ifAdminStatus`|The desired state of the interface.|float|-|
|`ifBandwidthInUsageRate`|(Shown as percent) The percent rate of used received bandwidth.|float|percent|
|`ifBandwidthOutUsageRate`|(Shown as percent) The percent rate of used sent bandwidth.|float|percent|
|`ifHCInBroadcastPkts`|(Shown as packet) The number of packets delivered by this sub-layer to a higher (sub-)layer that were addressed to a broadcast address at this sub-layer.|float|count|
|`ifHCInMulticastPkts`|(Shown as packet) The number of packets delivered by this sub-layer to a higher (sub-)layer which were addressed to a multicast address at this sub-layer.|float|count|
|`ifHCInOctets`|(Shown as byte) The total number of octets received on the interface including framing characters.|float|count|
|`ifHCInOctetsRate`|(Shown as byte) The total number of octets received on the interface including framing characters.|float|-|
|`ifHCInPkts`|(Shown as packet) The number of packets delivered by this sub-layer to a higher (sub-)layer that were not addressed to a multicast or broadcast address at this sub-layer.|float|count|
|`ifHCInUcastPkts`|(Shown as packet) The number of packets delivered by this sub-layer to a higher (sub-)layer that were not addressed to a multicast or broadcast address at this sub-layer.|float|count|
|`ifHCOutBroadcastPkts`|(Shown as packet) The total number of packets that higher-level protocols requested be transmitted that were addressed to a broadcast address at this sub-layer, including those that were discarded or not sent.|float|count|
|`ifHCOutMulticastPkts`|(Shown as packet) The total number of packets that higher-level protocols requested be transmitted that were addressed to a multicast address at this sub-layer including those that were discarded or not sent.|float|count|
|`ifHCOutOctets`|(Shown as byte) The total number of octets transmitted out of the interface including framing characters.|float|count|
|`ifHCOutOctetsRate`|(Shown as byte) The total number of octets transmitted out of the interface including framing characters.|float|count|
|`ifHCOutPkts`|(Shown as packet) The total number of packets higher-level protocols requested be transmitted that were not addressed to a multicast or broadcast address at this sub-layer including those that were discarded or not sent.|float|count|
|`ifHCOutUcastPkts`|(Shown as packet) The total number of packets higher-level protocols requested be transmitted that were not addressed to a multicast or broadcast address at this sub-layer including those that were discarded or not sent.|float|count|
|`ifHighSpeed`|An estimate of the interface's current bandwidth in units of 1,000,000 bits per second, or the nominal bandwidth.|float|count|
|`ifInDiscards`|(Shown as packet) The number of inbound packets chosen to be discarded even though no errors had been detected to prevent them being deliverable to a higher-layer protocol.|float|count|
|`ifInDiscardsRate`|(Shown as packet) The number of inbound packets chosen to be discarded even though no errors had been detected to prevent them being deliverable to a higher-layer protocol.|float|count|
|`ifInErrors`|(Shown as packet) The number of inbound packets that contained errors preventing them from being deliverable to a higher-layer protocol.|float|count|
|`ifInErrorsRate`|(Shown as packet) The number of inbound packets that contained errors preventing them from being deliverable to a higher-layer protocol.|float|count|
|`ifNetConnStatus`|The net connection status.|float|bool|
|`ifNetStatus`|The net status.|float|bool|
|`ifNumber`|Number of interface.|float|-|
|`ifOperStatus`|(Shown as packet) The current operational state of the interface.|float|count|
|`ifOutDiscards`|(Shown as packet) The number of outbound packets chosen to be discarded even though no errors had been detected to prevent them being transmitted.|float|count|
|`ifOutDiscardsRate`|(Shown as packet) The number of outbound packets chosen to be discarded even though no errors had been detected to prevent them being transmitted.|float|count|
|`ifOutErrors`|(Shown as packet) The number of outbound packets that could not be transmitted because of errors.|float|count|
|`ifOutErrorsRate`|(Shown as packet) The number of outbound packets that could not be transmitted because of errors.|float|count|
|`ifSpeed`|An estimate of the interface's current bandwidth in bits per second, or the nominal bandwidth.|float|count|
|`ifStatus`|The interface status.|float|bool|
|`itemAvailable`|Item available.|float|unknown|
|`itemFree`|(Shown as percent) Item not being used.|float|percent|
|`itemTotal`|Item total.|float|unknown|
|`itemUsage`|(Shown as percent) Item being used.|float|percent|
|`itemUsed`|Item being used.|float|unknown|
|`memoryAvailable`|(Shown as byte) Number of memory available.|float|B|
|`memoryFree`|(Shown as percent) The percentage of memory not being used.|float|percent|
|`memoryTotal`|(Shown as byte) Number of bytes of memory.|float|B|
|`memoryUsage`|(Shown as percent) The percentage of memory currently being used.|float|percent|
|`memoryUsed`|(Shown as byte) Number of bytes of memory currently being used.|float|B|
|`netUptime`|(in second) net uptime.|float|s|
|`power`|The power of item.|float|unknown|
|`powerStatus`|The power of item.|float|unknown|
|`sysUpTimeInstance`|The time (in hundredths of a second) since the network management portion of the system was last re-initialized.|float|count|
|`tcpActiveOpens`|The number of times that TCP connections have made a direct transition to the SYN-SENT state from the CLOSED state.|float|count|
|`tcpAttemptFails`|The number of times that TCP connections have made a direct transition to the CLOSED state from either the SYN-SENT state or the SYN-RCVD state, or to the LISTEN state from the SYN-RCVD state.|float|count|
|`tcpCurrEstab`|The number of TCP connections for which the current state is either ESTABLISHED or CLOSE-WAIT.|float|-|
|`tcpEstabResets`|The number of times that TCP connections have made a direct transition to the CLOSED state from either the ESTABLISHED state or the CLOSE-WAIT state.|float|count|
|`tcpInErrs`|(Shown as segment) The total number of segments received in error (e.g., bad TCP checksums).|float|count|
|`tcpOutRsts`|(Shown as segment) The number of TCP segments sent containing the RST flag.|float|count|
|`tcpPassiveOpens`|(Shown as connection) The number of times TCP connections have made a direct transition to the SYN-RCVD state from the LISTEN state.|float|count|
|`tcpRetransSegs`|(Shown as segment) The total number of segments retransmitted; that is, the number of TCP segments transmitted containing one or more previously transmitted octets.|float|count|
|`temperature`|The Temperature of item.|float|C|
|`udpInErrors`|(Shown as datagram) The number of received UDP datagram that could not be delivered for reasons other than the lack of an application at the destination port.|float|count|
|`udpNoPorts`|(Shown as datagram) The total number of received UDP datagram for which there was no application at the destination port.|float|count|
|`uptime`|(in second) uptime.|float|s|
|`uptimeTimestamp`|uptime timestamp.|float|sec|
|`voltage`|The Volt of item.|float|volt|
|`voltageStatus`|The voltage status of item.|float|bool|




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
