---
title     : 'SNMP'
summary   : 'Collect metrics and object data from SNMP devices'
tags:
  - 'SNMP'
__int_icon      : 'icon/snmp'
dashboard :
  - desc  : 'N/A'
    path  : '-'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

This article focuses on [SNMP](https://en.wikipedia.org/wiki/Simple_Network_Management_Protocol/){:target="_blank"} data collection.

## Terminology  {#terminology}

- `SNMP` (Simple network management protocol): A network protocol that is used to collect information about bare metal networking gear.
- `OID` (Object identifier): A unique ID or address on a device that when polled returns the response code of that value. For example, OIDs are CPU or device fan speed.
- `sysOID` (System object identifier): A specific address that defines the device type. All devices have a unique ID that defines it. For example, the Meraki base sysOID is `1.3.6.1.4.1.29671`.
- `MIB` (Managed information base): A database or list of all the possible OIDs and their definitions that are related to the MIB. For example, the `IF-MIB` (interface MIB) contains all the OIDs for descriptive information about a device’s interface.

## About SNMP Protocol {#config-pre}

The SNMP protocol is divided into three versions: v1/v2c/v3, of which:

- V1 and v2c are compatible. Many SNMP devices only offer v2c and v3 versions. v2c version, the best compatibility, many older devices only support this version.
- If the safety requirements are high, choose v3. Security is also the main difference between v3 version and previous versions.

Datakit supports all of the above versions.

### Choosing v1/v2c version {#config-v2}

If you choose v1/v2c version, you need to provide `community string`, AKA `community name/community string/unencrypted password`, which is required for authentication when interacting with an SNMP device. In addition, some devices will be distinguished into `read-only community name` and `read-write community name`. As the name implies:

- `Read-only community name`: The device will only provide internal metrics data to that party, and cannot modify some internal configurations (this is enough for DataKit).
- `Read-write community name`: The provider has the permission to query the internal metrics data of the equipment and modify some configurations.

### Choosing v3 version {#config-v3}

If you choose v3 version, you need to provide `username`, `authentication algorithm/password`, `encryption algorithm/password`, `context`, etc. Each device is different and should be filled in as same as configuration in SNMP device.

## Configuration {#config}

### Input Configuration {#config-input}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Go to the `conf.d/snmp` directory under the DataKit installation directory, copy `snmp.conf.sample` and name it `snmp.conf`. Examples are as follows:
    
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
    
      ## Number of max OIDs during walk(default 1000)
      # max_oids = 1000
    
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
    
    Once configured, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service) is sufficient.

=== "Kubernetes"

    Can be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [Config ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) .

---

???+ tip

    Once the above configuration is complete, you can use the `datakit debug --input-conf` command to test if the configuration is correct, as shown in the following example:

    ```sh
    sudo datakit debug --input-conf /usr/local/datakit/conf.d/snmp/snmp.conf
    ```

    If correct the line protocol information would print out in output, otherwise no line protocol information is seen.

???+ attention

    1. If the `inputs.snmp.tags` configured above duplicates the key in the original fields with the same name, it will be overwritten by the original data.
    2. The IP address (required in specified device mode)/segment (required in auto-discovery mode) of the device, the version number of the SNMP protocol and the corresponding authentication fields are required.
    3. "Specified device mode" and "auto-discovery mode", the two modes can coexist, but the SNMP protocol version number and the corresponding authentication fields must be the same among devices.

<!-- markdownlint-enable -->

### Multiple configuration formats {#configuration-formats}

#### Zabbix format {#format-zabbix}

- Config

  ```toml
    [[inputs.snmp.zabbix_profiles]]
      profile_name = "xxx.yaml"
      ip_list = ["ip1", "ip2"]
      class = "server"
  
    [[inputs.snmp.zabbix_profiles]]
      profile_name = "yyy.xml"
      ip_list = ["ip3", "ip4"]
      class = "switch"
  
    # ...
  ```

  `profile_name` can be full path file name or only file name.
  If only file name, the path is *./conf.d/snmp/userprofiles/*

  profile_name can from Zabbix official, or from [community](https://github.com/zabbix/community-templates){:target="_blank"} .

  You can modify the yaml or xml.

- AutoDiscovery

    - Automatic discovery matches the collection rules in the imported multiple yaml configurations and performs collection.

    - Please try to configure according to class C. Configuring class B may be slower.

    - If automatic discovery fails to match yaml, it is because these yaml does not contain the manufacturer's signature code of the collected     device.

        - Add an oid message to the items of yaml to guide the automatic matching process.

          ```yaml
          zabbix_export:
            templates:
            - items:
              - snmp_oid: 1.3.6.1.4.1.2011.5.2.1.1.1.1.6.114.97.100.105.117.115.0.0.0.0
          ```

        - The oid to be added is obtained by executing the following command. .0.0.0.0 is added at the end to prevent the generation of useless     indicators.

          ```shell
          $ snmpwalk -v 2c -c public <ip> 1.3.6.1.2.1.1.2.0
          iso.3.6.1.2.1.1.2.0 = OID: iso.3.6.1.4.1.2011.2.240.12
          
          $ snmpgetnext -v 2c -c public <ip> 1.3.6.1.4.1.2011.2.240.12
          iso.3.6.1.4.1.2011.5.2.1.1.1.1.6.114.97.100.105.117.115 = STRING: "radius"
          ```

#### Prometheus format {#format-Prometheus}

- Config

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

    Please refer to the snmp.yml file of  Prometheus [snmp_exporter](https://github.com/prometheus/snmp_exporter){:target="_blank"}  for the profile.
    It is recommended to split [module](https://github.com/prometheus/snmp_exporter?tab=readme-ov-file#prometheus-configuration){:target="_blank"} of different classes into different .yml configurations.

    Prometheus profile allows you to configure a separate community name for a module.
    This community name takes precedence over the community name configured for the input.
  
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

- AutoDiscovery

  The SNMP collector can discovery instance through Consul service, and the service injection format can be found on [prom official website](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#consul_sd_config){:target="_blank"}。


### Configure SNMP device {#config-snmp}

When SNMP devices are in the default, the general SNMP protocol is closed, you need to enter the management interface to open manually. At the same time, it is necessary to select the protocol version and fill in the corresponding information according to the actual situation.

<!-- markdownlint-disable MD046 -->
???+ tip

    Some devices require additional configuration to release SNMP for security, which varies from device to device. For example, Huawei is a firewall, so it is necessary to check SNMP in "Enable Access Management" to release it. You can use the `snmpwalk` command to test whether the acquisition side and the device side are configured to connect successfully(These commands runs on the host which Datakit running on):
    
    ```shell
    # Applicable v2c version
    snmpwalk -O bentU -v 2c -c [community string] [SNMP_DEVICE_IP] 1.3.6
    # Applicable v3 version
    snmpwalk -v 3 -u user -l authPriv -a sha -A [AUTH_PASSWORD] -x aes -X [ENCRYPT_PASSWORD] [SNMP_DEVICE_IP] 1.3.6
    ```
    
    If there is no problem with the configuration, the command will output a large amount of data. `snmpwalk` is a test tool running on the collection side, which comes with MacOS. Linux installation method:
    
    ```shell
    sudo yum install net-snmp net-snmp-utils # CentOS
    sudo apt–get install snmp                # Ubuntu
    ```

<!-- markdownlint-enable -->

## Metric {#metric}

For all of the following data collections, the global election tags will added automatically, we can add extra tags in `[inputs.snmp.tags]` if needed:

``` toml
 [inputs.snmp.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

<!-- markdownlint-disable MD046 -->
???+ attention

    All the following measurements and their metrics contain only some common fields, some device-specific fields, and some additional fields will be added according to different configurations and device models.
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD024 -->








### `snmp_metric`

SNMP device metric data.

- Tags


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

- Metrics


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




## Object {#objects}





### `snmp_object`

SNMP device object data.

- Tags


| Tag | Description |
|  ----  | --------|
|`device_vendor`|Device vendor.|
|`host`|Device host, replace with IP.|
|`ip`|Device IP.|
|`name`|Device name, replace with IP.|
|`snmp_host`|Device host.|
|`snmp_profile`|Device SNMP profile file.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`all`|Device all data (JSON format).|string|-|
|`cpus`|Device CPUs (JSON format).|string|-|
|`device_meta`|Device meta data (JSON format).|string|-|
|`interfaces`|Device network interfaces (JSON format).|string|-|
|`mem_pool_names`|Device memory pool names (JSON format).|string|-|
|`mems`|Device memories (JSON format).|string|-|
|`sensors`|Device sensors (JSON format).|string|-|







<!-- markdownlint-disable MD013 -->
## FAQ {#faq}

### :material-chat-question: How dows Datakit find devices? {#faq-discover}

Datakit supports "Specified device mode" and "auto-discovery mode" two modes. The two modes can enabled at the same time.

In "specified device mode", Datakit communicates with the specified IP device using the SNMP protocol to know its current online status.

In "auto-discovery mode", Datakit sends SNMP packets to all address in the specified IP segment one by one, and if the response matches the corresponding profile, Datakit assumes that there is a SNMP device on that IP.

### :material-chat-question: I can't find metrics I'm looking for in [Guance](https://console.guance.com/){:target="_blank"}, what should I do?  {#faq-not-support}

Datakit collects generic base-line metrics from all devices. If you can't find the metric you want, you can [write a custom profile](snmp.md#advanced-custom-oid).

To archiving this, you probably needs to download the device's OID manual from its official website.

### :material-chat-question: Why I can't see any metrics in [Guance](https://console.guance.com/){:target="_blank"} after I completed configuration? {#faq-no-metrics}

<!-- markdownlint-enable -->

Try loosening ACLs/firewall rules for your devices.

Run `snmpwalk -O bentU -v 2c -c <COMMUNITY_STRING> <IP_ADDRESS>:<PORT> 1.3.6` from the host Datakit is running on. If you get a timeout without any response, there is likely something blocking Datakit from collecting metrics from your device.

