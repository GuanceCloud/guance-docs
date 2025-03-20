---
title     : 'SNMP'
summary   : 'Collect SNMP device Metrics and object data'
tags:
  - 'SNMP'
__int_icon      : 'icon/snmp'
dashboard :
  - desc  : 'Not available yet'
    path  : '-'
monitor   :
  - desc  : 'Not available yet'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

This article mainly introduces [SNMP](https://en.wikipedia.org/wiki/Simple_Network_Management_Protocol){:target="_blank"} data collection.

## Terminology  {#terminology}

- `SNMP` (Simple network management protocol): A network protocol used to collect information about bare-metal network devices.
- `OID` (Object identifier): The unique ID or address on the device that returns a response code when polled. For example, OID could be CPU or device fan speed.
- `sysOID` (System object identifier): A specific address defining the type of device. All devices have a unique ID that defines them. For example, the base sysOID for `Meraki` is “1.3.6.1.4.1.29671”.
- `MIB` (Managed information base): A database or list of all possible OIDs related to the MIB and their definitions. For example, “IF-MIB” (interface MIB) contains all OIDs with descriptive information about device interfaces.

## About SNMP Protocol {#config-pre}

The SNMP protocol has three versions: v1/v2c/v3, where:

- **v1 and v2c are compatible**. Many SNMP devices only offer choices between v2c and v3. The v2c version has the best compatibility, and many older devices only support this version;
- If higher security is required, choose v3. Security is the main difference between the v3 version and previous versions;

Datakit supports all the above versions.

### Selecting v1/v2c Version {#config-v2}

If you select the v1/v2c version, you need to provide a `community string`, which in Chinese translates as "group name/group string/unencrypted password", i.e., the password used for authentication when interacting with the SNMP device. Additionally, some devices further subdivide into "read-only community name" and "read-write community name". As the names suggest:

- Read-only community name: The device will only provide internal metric data to this party and cannot modify some internal configurations (this is sufficient for Datakit).
- Read-write community name: The provider has query and partial configuration modification permissions for the device's internal metrics.

### Selecting v3 Version {#config-v3}

If you choose the v3 version, you need to provide "username", "authentication algorithm/password", "encryption algorithm/password", "context", etc. Requirements vary by device, so fill in according to the configuration on the device side.

## Configuration {#config}

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "HOST"

    Enter the `conf.d/snmp` directory under the DataKit installation directory, copy `snmp.conf.sample` and rename it to `snmp.conf`. An example is as follows:
    
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

    After configuring, simply [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can enable the collector via [ConfigMap method](../datakit/datakit-daemonset-deploy.md#configmap-setting) or by [setting ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting).

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
  
    `profile_name` can be either a full path or just the filename. If only the filename is provided, the file should be placed in the *./conf.d/snmp/userprofiles/* subdirectory.

    You can download corresponding configurations from the official Zabbix site or from the [community](https://github.com/zabbix/community-templates){:target="_blank"}.

    If you're not satisfied with the downloaded yaml or xml files, you can also modify them yourself.

- Auto-discovery
    - Auto-discovery matches collection rules within multiple imported yaml configurations for collection.
    - Try to configure auto-discovery per C segment; configuring per B segment might be slower.
    - If auto-discovery fails to match any yaml, it may be because the existing yaml does not contain the manufacturer's feature code for the collected device.
        - You can manually add an OID entry in the items of the yaml to guide the auto-matching process.

          ```yaml
          zabbix_export:
            templates:
            - items:
              - snmp_oid: 1.3.6.1.4.1.2011.5.2.1.1.1.1.6.114.97.100.105.117.115.0.0.0.0
          ```

        - The OID to be added can be obtained by executing the following command, appending .0.0.0.0 to prevent unnecessary metrics.

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

    Profiles refer to Prometheus [snmp_exporter](https://github.com/prometheus/snmp_exporter){:target="_blank"}'s snmp.yml file,
    It is recommended to split different class modules into separate .yml configurations.

    Prometheus profiles allow setting a separate community name for each module, which takes precedence over the community name set in the collector configuration.

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

    The SNMP collector supports discovering targets through Consul service discovery. Refer to the [Prometheus official website](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#consul_sd_config){:target="_blank"} for service injection formats.

???+ tip

    After completing the above configuration, you can test if the configuration is correct using the `datakit debug --input-conf` command, as shown below:

    ```sh
    sudo datakit debug --input-conf /usr/local/datakit/conf.d/snmp/snmp.conf
    ```

    If the configuration is correct, it will output line protocol information; otherwise, no line protocol information will be visible.

???+ attention

    1. If the keys in `inputs.snmp.tags` conflict with the original fields, they will be overridden by the original data.
    2. The device's IP address (specific device mode)/subnet (auto-discovery mode), SNMP protocol version, and corresponding authentication fields are mandatory fields.
    3. Both "specific device" mode and "auto-discovery" mode can coexist, but the SNMP protocol version and corresponding authentication fields must be consistent across devices.
<!-- markdownlint-enable -->

### Configuring the Target SNMP Devices {#config-snmp}

By default, SNMP protocol is generally turned off on SNMP devices and needs to be manually enabled in the management interface. Additionally, the protocol version and relevant information need to be selected based on actual conditions.

<!-- markdownlint-disable MD046 -->
???+ tip

    Some devices require additional configuration for SNMP security. For example, Huawei series firewalls need SNMP to be checked in "Enable Access Management" to allow traffic.
    You can use the `snmpwalk` command to test if the communication between the collector and the device is properly configured (run the following command on the host where Datakit runs):

    ```shell
    # Applicable to v2c version
    snmpwalk -O bentU -v 2c -c [community string] [SNMP_DEVICE_IP] 1.3.6
    # Applicable to v3 version
    snmpwalk -v 3 -u user -l authPriv -a sha -A [authentication password] -x aes -X [encryption password] [SNMP_DEVICE_IP] 1.3.6
    ```

    If the configuration is correct, the command will output a large amount of data. `snmpwalk` is a testing tool that runs on the collector side. MacOS comes with it pre-installed, while Linux installation methods are as follows:

    ```shell
    sudo yum install net-snmp net-snmp-utils # CentOS
    sudo apt–get install snmp                # Ubuntu
    ```
<!-- markdownlint-enable -->

## Metrics {#metric}

All data collected by default appends global election tags, and other tags can be specified in the configuration via `[inputs.snmp.tags]`:

``` toml
[inputs.snmp.tags]
 # some_tag = "some_value"
 # more_tag = "some_other_value"
 # ...
```

<!-- markdownlint-disable MD046 -->
???+ attention
    The following metric sets and their metrics only include some common fields. Specific fields for certain devices may appear depending on the configuration and device model.
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

Datakit supports both "specific device" and "auto-discovery" modes. These two modes can be enabled simultaneously.

In specific device mode, Datakit communicates with devices using the specified IP via the SNMP protocol to determine their online status.

In auto-discovery mode, Datakit sends SNMP protocol packets to all addresses within the specified IP subnet. If a response matches the corresponding Profile, Datakit considers that there is an SNMP device on that IP.

### :material-chat-question: What should I do if I cannot see the metrics I want in Guance? {#faq-not-support}

Datakit can collect general baseline metrics from all SNMP devices. If you find that the data reported by the collected device does not include the metrics you want, then you may need to [customize a Profile for that device](snmp.md#advanced-custom-oid).

To complete the aforementioned work, you will likely need to download the OID manual for the device model from the device manufacturer's official website.

<!-- markdownlint-disable MD013 -->

### :material-chat-question: Why can't I see metrics after enabling SNMP device collection? {#faq-no-metrics}

<!-- markdownlint-enable -->

Try opening ACLs/firewall rules for your device.

Run the command `snmpwalk -O bentU -v 2c -c <COMMUNITY_STRING> <IP_ADDRESS>:<PORT> 1.3.6` on the host running Datakit. If you get a timeout without any response, something is likely blocking Datakit from collecting metrics from your device.