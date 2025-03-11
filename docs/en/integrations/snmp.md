---
title     : 'SNMP'
summary   : 'Collect metrics and object data from SNMP devices'
tags:
  - 'SNMP'
__int_icon      : 'icon/snmp'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

This document primarily introduces [SNMP](https://en.wikipedia.org/wiki/Simple_Network_Management_Protocol){:target="_blank"} data collection.

## Terminology  {#terminology}

- `SNMP` (Simple Network Management Protocol): A network protocol used to collect information about bare-metal network devices.
- `OID` (Object Identifier): A unique ID or address on the device that returns a response code when polled. For example, OID can refer to CPU or device fan speed.
- `sysOID` (System Object Identifier): A specific address defining the type of device. All devices have a unique ID that defines them. For example, the base sysOID for `Meraki` is “1.3.6.1.4.1.29671”.
- `MIB` (Managed Information Base): A database or list of all possible OIDs related to the MIB and their definitions. For example, “IF-MIB” (Interface MIB) contains all OIDs with descriptive information about the device's interfaces.

## About the SNMP Protocol {#config-pre}

The SNMP protocol has three versions: v1/v2c/v3, where:

- **v1 and v2c are compatible**. Many SNMP devices only provide v2c and v3 options. Version v2c has the best compatibility, and many older devices only support this version;
- If higher security is required, choose v3. Security is the main difference between v3 and previous versions;

Datakit supports all these versions.

### Choosing v1/v2c Versions {#config-v2}

If you choose the v1/v2c version, you need to provide the `community string`, which translates to "community name/string/unencrypted password" in Chinese, essentially acting as a password for authentication with SNMP devices. Additionally, some devices may further differentiate between "read-only community name" and "read-write community name". As the names suggest:

- Read-only community name: The device only provides internal metric data to the party and does not allow modification of internal configurations (this is sufficient for Datakit)
- Read-write community name: The provider has permissions to query internal metric data and modify certain configurations

### Choosing v3 Version {#config-v3}

If you choose the v3 version, you need to provide "username", "authentication algorithm/password", "encryption algorithm/password", "context", etc., which vary by device. Fill in the details according to the configuration on the device side.

## Configuration {#config}

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/snmp` directory under the DataKit installation directory, copy `snmp.conf.sample` and rename it to `snmp.conf`. Example configuration:
    
    ```toml
        
    [[inputs.snmp]]
      ## Filling in specific device IP address, example ["10.200.10.240", "10.200.10.241"].
      ## And you can use auto_discovery and specific_devices at the same time.
      ## If you don't want to specify a device, you don't need to provide this.
      # specific_devices = ["***"] # SNMP Device IP.
    
      ## Filling in autodiscovery CIDR subnet, example ["10.200.10.0/24", "10.200.20.0/24"].
      ## If you don't want to enable the autodiscovery feature, you don't need to provide this.
      # auto_discovery = ["***"] # Used in autodiscovery mode only, ignore this in other cases.
    
      ## Consul server URL for consul discovery
      ## We can discover SNMP instances from Consul services
      # consul_discovery_url = "http://127.0.0.1:8500"
    
      ## Consul token, optional.
      # consul_token = "<consul token>"
    
      ## Instance IP key name. ("IP" case sensitive)
      # instance_ip_key = "IP"
    
      ## Which task will collect, according to Consul service field "Address"
      ## [] means collect all, optional, defaults to []
      # exporter_ips = ["<ip1>", "<ip2>"...]
    
      ## Consul TLS connection config, optional.
      # ca_certs = ["/opt/tls/ca.crt"]
      # cert = "/opt/tls/client.crt"
      # cert_key = "/opt/tls/client.key"
      # insecure_skip_verify = true
    
      ## SNMP protocol version the devices use, fill in 2 or 3.
      ## If using version 1, just fill in 2. Version 2 supports version 1.
      ## This is mandatory.
      snmp_version = 2
    
      ## SNMP port on the devices. Default is 161. In most cases, you don't need to change this.
      ## This is optional.
      # port = 161
    
      ## Password in SNMP v2, enclosed in single quotes. Only works in SNMP v2.
      ## If using SNMP v2, this is mandatory.
      ## If using SNMP v3, you don't need to provide this.
      # v2_community_string = "***"
    
      ## Authentication details in SNMP v3.
      ## If using SNMP v2, you don't need to provide this.
      ## If using SNMP v3, this is mandatory.
      # v3_user = "***"
      # v3_auth_protocol = "***"
      # v3_auth_key = "***"
      # v3_priv_protocol = "***"
      # v3_priv_key = "***"
      # v3_context_engine_id = "***"
      # v3_context_name = "***"
    
      ## Number of workers used to collect and discover devices concurrently. Default is 100.
      ## Modify based on the number of devices and network scale.
      ## This is optional.
      # workers = 100
    
      ## Maximum number of OIDs during walk (default 1000)
      # max_oids = 1000
    
      ## Interval between each auto discovery in seconds. Default is "1h".
      ## Only works in auto discovery feature.
      ## This is optional.
      # discovery_interval = "1h"
    
      ## Collection metric interval, default is 10s. (optional)
      # metric_interval = "10s"
    
      ## Collection object interval, default is 5m. (optional)
      # object_interval = "5m"
    
      ## Filling in excluded device IP address, example ["10.200.10.220", "10.200.10.221"].
      ## Only works in auto discovery feature.
      ## This is optional.
      # discovery_ignored_ip = []
    
      ## Set true to enable election
      # election = true
    
      ## Device Namespace. Default is "default".
      # device_namespace = "default"
    
      ## Picking the metric data only contains the fields' names below.
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
      ## If module mapping different classes, can disassemble yml file.
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
        # dev_disk_size = "diskTotal"
      
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

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can inject collector configuration via [ConfigMap method](../datakit/datakit-daemonset-deploy.md#configmap-setting) or configure [ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) to enable the collector.

### Multiple Configuration Formats {#configuration-formats}

#### Zabbix Format {#format-zabbix}

- Configuration

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
  
    `profile_name` can be a full path or just a filename. If it's just a filename, place it in the *./conf.d/snmp/userprofiles/* subdirectory.

    You can download corresponding configurations from the official Zabbix website or from the [community](https://github.com/zabbix/community-templates){:target="_blank"}.

    If you are not satisfied with the downloaded yaml or xml files, you can modify them yourself.

- Auto-discovery
    - Auto-discovery matches collection rules within multiple imported yaml configurations and performs collection.
    - Auto-discovery should be configured per C segment; configuring B segments might be slower.
    - If auto-discovery fails to match any yaml, it’s because the existing yaml lacks the manufacturer's characteristic code for the device being collected.
        - You can manually add an OID entry in the items section of the yaml to guide the auto-matching process.

          ```yaml
          zabbix_export:
            templates:
            - items:
              - snmp_oid: 1.3.6.1.4.1.2011.5.2.1.1.1.1.6.114.97.100.105.117.115.0.0.0.0
          ```

        - Obtain the OID by executing the following command, appending .0.0.0.0 to prevent generating unnecessary metrics.

        ```shell
        $ snmpwalk -v 2c -c public <ip> 1.3.6.1.2.1.1.2.0
        iso.3.6.1.2.1.1.2.0 = OID: iso.3.6.1.4.1.2011.2.240.12
        
        $ snmpgetnext -v 2c -c public <ip> 1.3.6.1.4.1.2011.2.240.12
        iso.3.6.1.4.1.2011.5.2.1.1.1.1.6.114.97.100.105.117.115 = STRING: "radius"
        ```

#### Prometheus Format {#format-Prometheus}

- Configuration

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

    Refer to Prometheus [snmp_exporter](https://github.com/prometheus/snmp_exporter){:target="_blank"} snmp.yml file. It is recommended to split different class modules into separate .yml configurations.

    Prometheus profiles allow specifying a community string for individual modules, which takes precedence over the collector configuration's community string.

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

- Auto-discovery

    The SNMP collector supports discovering targets through Consul service discovery. Refer to [Prometheus official documentation](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#consul_sd_config){:target="_blank"} for service injection format.

???+ tip

    After completing the above configuration, you can use the `datakit debug --input-conf` command to test if the configuration is correct. Example:

    ```sh
    sudo datakit debug --input-conf /usr/local/datakit/conf.d/snmp/snmp.conf
    ```

    If the configuration is correct, it will output line protocol information; otherwise, no line protocol information will be displayed.

???+ attention

    1. If there are duplicate keys in `inputs.snmp.tags` with the original fields, they will be overridden by the original data.
    2. The device's IP address (for specified device mode)/subnet (for auto-discovery mode), SNMP protocol version, and corresponding authentication fields are mandatory.
    3. Both "specified device" and "auto-discovery" modes can coexist, but the SNMP protocol version and corresponding authentication fields must be consistent across devices.

<!-- markdownlint-enable -->

### Configuring the Target SNMP Device {#config-snmp}

By default, SNMP protocol is usually disabled on SNMP devices and needs to be manually enabled via the management interface. Additionally, select the appropriate protocol version and fill in the necessary information.

<!-- markdownlint-disable MD046 -->
???+ tip

    Some devices require additional configuration to allow SNMP for security reasons. For example, Huawei firewalls need to check SNMP in "Enable Access Management" to allow it.
    You can use the `snmpwalk` command to test if the configuration between the collector and the device is successful (run this command on the host running Datakit):

    ```shell
    # For v2c version
    snmpwalk -O bentU -v 2c -c [community string] [SNMP_DEVICE_IP] 1.3.6
    # For v3 version
    snmpwalk -v 3 -u user -l authPriv -a sha -A [authentication password] -x aes -X [encryption password] [SNMP_DEVICE_IP] 1.3.6
    ```

    If the configuration is correct, this command will output a large amount of data. `snmpwalk` is a testing tool run on the collector side. MacOS includes it by default, while Linux installation methods are as follows:

    ```shell
    sudo yum install net-snmp net-snmp-utils # CentOS
    sudo apt–get install snmp                # Ubuntu
    ```
<!-- markdownlint-enable -->

## Metrics {#metric}

All data collected by default appends global election tags. Additional tags can be specified in the configuration using `[inputs.snmp.tags]`:

``` toml
[inputs.snmp.tags]
 # some_tag = "some_value"
 # more_tag = "some_other_value"
 # ...
```

<!-- markdownlint-disable MD046 -->
???+ attention
    The following metric sets and their metrics only include some common fields. Specific device fields may vary depending on the configuration and device model.
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

- Fields List


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




## Objects {#object}





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

- Fields List


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

### :material-chat-question: How does Datakit discover devices? {#faq-discover}

Datakit supports both "specified device" and "auto-discovery" modes, which can be enabled simultaneously.

In specified device mode, Datakit communicates with devices using SNMP protocol based on specified IPs and can know their online status.

In auto-discovery mode, Datakit sends SNMP protocol packets to all addresses within the specified IP subnet. If a response matches a corresponding Profile, Datakit recognizes an SNMP device on that IP.

### :material-chat-question: What should I do if I cannot see the metrics I want in Guance? {#faq-not-support}

Datakit collects baseline metrics from all SNMP devices. If you find that the collected data from your device does not contain the metrics you want, you may need to [customize a Profile for the device](snmp.md#advanced-custom-oid).

To accomplish this, you likely need to download the OID manual for the device model from the manufacturer's website.

<!-- markdownlint-disable MD013 -->

### :material-chat-question: Why do I not see any metrics after enabling SNMP device collection? {#faq-no-metrics}

<!-- markdownlint-enable -->

Try opening ACLs/firewall rules for your device.

Run the command `snmpwalk -O bentU -v 2c -c <COMMUNITY_STRING> <IP_ADDRESS>:<PORT> 1.3.6` on the host running Datakit. If you get a timeout without any response, something is likely blocking Datakit from collecting metrics from your device.
