---
title     : 'SNMP'
summary   : 'Collect metrics and object data from SNMP devices'
__int_icon      : 'icon/snmp'
dashboard :
  - desc  : 'N/A'
    path  : '-'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# SNMP
<!-- markdownlint-enable -->

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

=== "Host Installation"

    Go to the `conf.d/snmp` directory under the DataKit installation directory, copy `snmp.conf.sample` and name it `snmp.conf`. Examples are as follows:
    
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
    
    Once configured, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service) is sufficient.

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting).

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
    3. "Specified device mode" and "auto-discovery mode", the two modes can coexist, but the SNMP protocol version number and the corresponding authentification fields must be the same among devices.


### Configure SNMP {#config-snmp}

- On the device side, configure the SNMP protocol

When SNMP devices are in the default, the general SNMP protocol is closed, you need to enter the management interface to open manually. At the same time, it is necessary to select the protocol version and fill in the corresponding information according to the actual situation.

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

- On the DataKit side, configure collection.

## Advanced features {#advanced-features}

### Custom Device OID configuration {#advanced-custom-oid}

If you find that the data reported by the collected device does not contain the indicators you want, then you may need to define an additional Profile for the device.

All OIDs of devices can generally be downloaded from their official website. Datakit defines some common OIDs, as well as some devices such as Cisco/Dell/HP. According to snmp protocol, each device manufacturer can customize [OID](https://www.dpstele.com/snmp/what-does-oid-network-elements.php){:target="_blank"} to identify its internal special objects. If you want to identify these, you need to customize the configuration of the device (we call this configuration Profile here, that is, "Custom Profile"), as follows.

To add metrics or a custom configuration, list the MIB name, table name, table OID, symbol, and symbol OID, for example:

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

Here is an example of operation.

Create the yml file `cisco-3850.yaml` under the path `conf.d/snmp/profiles` of the Datakit installation directory (in this case, Cisco 3850) as follows:

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

As shown above, a device with `sysobjectid` of `1.3.6.1.4.1.9.1.1745` is defined, and the next time Datakit captures a device with the same `sysobjectid`, the file will be applied, in this case:

- When device data is captured for an OID of `1.3.6.1.4.1.9.3.6.3.0`, the field with the name `serial_number` will added to the `device_meta` field(JSON), and appended to the set `snmp_object` to be reported as an Object;
- When device data is captured for an OID of `1.3.6.1.4.1.232.9.2.2.32`, the field with the name `temperature` will added to the the metric set `snmp_metric` and reported as a Metric;

???+ attention

    The folder `conf.d/snmp/profiles` requires the SNMP collector to run once before it appears.

## Metric {#metric}

All of the following data collections are appended by default with the name `host` (the value is the name of the SNMP device), or other labels can be specified in the configuration by `[inputs.snmp.tags]`:

``` toml
 [inputs.snmp.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

???+ attention

    All the following measurements and their metrics contain only some common fields, some device-specific fields, and some additional fields will be added according to different configurations and device models.









### `snmp_metric`

SNMP device metric data.

- tag


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

- field list


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



## Object {#objects}





### `snmp_object`

SNMP device object data.

- tag


| Tag | Description |
|  ----  | --------|
|`device_vendor`|Device vendor.|
|`host`|Device host, replace with IP.|
|`ip`|Device IP.|
|`name`|Device name, replace with IP.|
|`snmp_host`|Device host.|
|`snmp_profile`|Device SNMP profile file.|

- field list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`all`|Device all data (JSON format).|string|-|
|`cpus`|Device CPUs (JSON format).|string|-|
|`device_meta`|Device meta data (JSON format).|string|-|
|`interfaces`|Device network interfaces (JSON format).|string|-|
|`mem_pool_names`|Device memory pool names (JSON format).|string|-|
|`mems`|Device memories (JSON format).|string|-|
|`sensors`|Device sensors (JSON format).|string|-| 







## FAQ {#faq}

### :material-chat-question: How dows Datakit find devices? {#faq-discover}

Datakit supports "Specified device mode" and "auto-discovery mode" two modes. The two modes can enabled at the same time.

In "specified device mode", Datakit communicates with the specificed IP device using the SNMP protocol to know its current online status.

In "auto-discovery mode", Datakit sends SNMP packets to all address in the specified IP segment one by one, and if the response matches the corresponding profile, Datakit assumes that there is a SNMP device on that IP.

### :material-chat-question: I can't find metrics I'm looking for in [Guance](https://console.guance.com/){:target="_blank"}, what should I do?  {#faq-not-support}

Datakit collects generic base-line metrics from all devices. If you can't find the metric you want, you can [write a custom profile](snmp.md#advanced-custom-oid).

To archiving this, you probably needs to download the device's OID manual from its official website.

### :material-chat-question: Why I can't see any metrics in [Guance](https://console.guance.com/){:target="_blank"} after I completed configruation? {#faq-no-metrics}

Try loosening ACLs/firewall rules for your devices.

Run `snmpwalk -O bentU -v 2c -c <COMMUNITY_STRING> <IP_ADDRESS>:<PORT> 1.3.6` from the host Datakit is running on. If you get a timeout without any response, there is likely something blocking Datakit from collecting metrics from your device.
