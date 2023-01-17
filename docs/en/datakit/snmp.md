
# SNMP
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

This article focuses on [SNMP](https://en.wikipedia.org/wiki/Simple_Network_Management_Protocol/){:target="_blank"} data collection.

## About SNMP Protocol {#config-pre}

The SNMP protocol is divided into three versions: v1/v2c/v3, of which:

    - V1 and v2c are compatible. Many SNMP devices only offer v2c and v3 versions. v2c version, the best compatibility, many older devices only support this version.
    - If the safety requirements are high, choose v3. Security is also the main difference between v3 version and previous versions.

If you choose v2c version, you need to provide `community string`, which translates into `community name/community string`in Chinese. An `unencrypted password` is a password, which is required for authentication when interacting with an SNMP device. In addition, some devices will be distinguished into `read-only community name` and `read-write community name`. As the name implies:

- `Read-only community name`: The device will only provide internal metrics data to that party, and cannot modify some internal configurations (this is enough for DataKit).
- `Read and write community name`: The provider has the permission to query the internal metrics data of the equipment and modify some configurations.

If you choose v3 version, you need to provide `username`, `authentication algorithm/password`, `encryption algorithm/password`, `context`, etc. Each device is different and should be filled in as required.

## Configure Collector {#config-input}

=== "Host Installation"

    Go to the `conf.d/snmp` directory under the DataKit installation directory, copy `snmp.conf.sample` and name it `snmp.conf`. Examples are as follows: 
    
    ```toml
        
    [[inputs.snmp]]
      ## Filling in autodiscovery CIDR subnet, like ["10.200.10.0/24", "10.200.20.0/24"].
      ## If you don't want to enable autodiscovery feature, you don't need provide this.
      #
      # auto_discovery = []
    
      ## Filling in specific device IP address, like ["10.200.10.240", "10.200.10.241"].
      ## And you can use auto_discovery and specific_devices at the same time.
      ## If you don't want to specific device, you don't need provide this.
      #
      # specific_devices = []
    
      ## SNMP protocol version the devices using, fill in 2 or 3.
      ## If you using the version 1, just fill in 2. Version 2 supported version 1.
      ## This is must be provided.
      #
      # snmp_version = 2
    
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
    
      [inputs.snmp.tags]
      # tag1 = "val1"
      # tag2 = "val2"
    
      [inputs.snmp.traps]
      # enable = true
      # bind_host = "0.0.0.0"
      # port = 9162
      # stop_timeout = 3    # stop timeout in seconds.
    
    ```

    Once configured, [restart DataKit](datakit-service-how-to.md#manage-service) is sufficient.

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](datakit-daemonset-deploy.md#configmap-setting).

---
    
???+ attention

    If the `inputs.snmp.tags` configured above duplicates the key in the original fields with the same name, it will be overwritten by the original data.


### Configure SNMP {#config-snmp}

- On the device side, configure the SNMP protocol

When SNMP devices are in the default, the general SNMP protocol is closed, you need to enter the management interface to open manually. At the same time, it is necessary to select the protocol version and fill in the corresponding information according to the actual situation.

???+ tip

    Some devices require additional configuration to release SNMP for security, which varies from device to device. For example, Huawei is a firewall, so it is necessary to check SNMP in "Enable Access Management" to release it. You can use the `snmpwalk` command to test whether the acquisition side and the device side are configured to connect successfully:

    ```shell
    # Applicable v2c version
    snmpwalk -O bentU -v 2c -c [community string] [IP] 1.3.6` 
    # Applicable v3 version
    snmpwalk -v 3 -u user -l authPriv -a sha -A [认证密码] -x aes -X [加密密码] [IP] 1.3.6 
    ```

    If there is no problem with the configuration, the command will output a large amount of data. `snmpwalk` is a test tool running on the collection side, which comes with MacOS. Linux installation method:

    ```shell
    sudo yum install net–snmp–utils # CentOS
    sudo apt–get install snmp       # Ubuntu
    ```

- On the DataKit side, configure collection.

## Custom Device OID c=Configuration {#custom-oid}

If you find that the data reported by the collected device does not contain the indicators you want, then you may need to define an additional Profile for the device.

All OIDs of devices can generally be downloaded from their official website. Datakit defines some common OIDs, as well as some devices such as Cisco/Dell/HP. According to snmp protocol, each device manufacturer can customize [OID](https://www.dpstele.com/snmp/what-does-oid-network-elements.php) to identify its internal special objects. If you want to identify these, you need to customize the configuration of the device (we call this configuration Profile here, that is, "Custom Profile"), as follows.

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
          name: chassisId
```

As shown above, a device with `sysobjectid` of `1.3.6.1.4.1.9.1.1745` is defined, and the file will be applied the next time Datakit collects a device with the same `sysobjectid`, in which case the collected data with an OID of `1.3.6.1.4.1.9.3.6.3.0` will be reported as an indicator with the name `chassisId`.

> Note: The folder `conf.d/snmp/profiles` requires the SNMP collector to run once before it appears.

## Measurements {#measurements}

All of the following data collections are appended by default with the name `host` (the value is the name of the SNMP device), or other labels can be specified in the configuration by `[inputs.snmp.tags]`:

``` toml
 [inputs.snmp.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

???+ attention

    All the following measurements and their metrics contain only some common fields, some device-specific fields, and some additional fields will be added according to different configurations and device models.

### Metrics {#metrics}









#### `snmp`

Collect data of SNMP equipment index.

- Tg


| Tag Name | Description    |
|  ----  | --------|
|`cpu`|CPU index.|
|`device_vendor`|Equipment manufacturer|
|`entity_name`|Entity name|
|`host`|Device name|
|`interface`|Device interface name|
|`interface_alias`|Device interface alias|
|`mac_addr`|MAC address of the device|
|`mem`|Memory index.|
|`mem_pool_name`|Memory pool name.|
|`power_source`|Power source.|
|`power_status_descr`|Power status description.|
|`snmp_profile`|SNMP configuration file name|
|`temp_index`|Temperature index.|
|`temp_state`|Temperature state.|

- Field List


| Metrics | Description| Data Type | Unit   |
| ---- |---- | :---:    | :----: |
|`cieIfInputQueueDrops`|[Cisco only] (Shown as packet) The number of input packets dropped.|int|count|
|`cieIfLastInTime`|[Cisco only] (Shown as millisecond) The elapsed time in milliseconds since the last protocol input packet was received.|int|msec|
|`cieIfLastOutTime`|[Cisco only] (Shown as millisecond) The elapsed time in milliseconds since the last protocol output packet was transmitted.|int|msec|
|`cieIfOutputQueueDrops`|[Cisco only] (Shown as packet) The number of output packets dropped by the interface even though no error was detected to prevent them being transmitted.|int|count|
|`cieIfResetCount`|[Cisco only] The number of times the interface was internally reset and brought up.|int|count|
|`ciscoEnvMonFanState`|[Cisco only] The current state of the fan being instrumented.|int|count|
|`ciscoEnvMonSupplyState`|[Cisco only] The current state of the power supply being instrumented.|int|count|
|`ciscoEnvMonTemperatureStatusValue`|[Cisco only] The current value of the testpoint being instrumented.|int|count|
|`ciscoMemoryPoolFree`|[Cisco only] Indicates the number of bytes from the memory pool that are currently unused on the managed device.|int|count|
|`ciscoMemoryPoolLargestFree`|[Cisco only] Indicates the largest number of contiguous bytes from the memory pool that are currently unused on the managed device.|int|count|
|`ciscoMemoryPoolUsed`|[Cisco only] Indicates the number of bytes from the memory pool that are currently in use by applications on the managed device.|int|count|
|`cpmCPUTotal1minRev`|[Cisco only] [Shown as percent] The overall CPU busy percentage in the last 1 minute period.|float|percent|
|`cpmCPUTotalMonIntervalValue`|[Cisco only] (Shown as percent) The overall CPU busy percentage in the last cpmCPUMonInterval period.|float|percent|
|`cpuUsage`|(Shown as percent) Percentage of CPU currently being used.|float|percent|
|`cswStackPortOperStatus`|[Cisco only] The state of the stackport.|int|count|
|`cswSwitchState`|[Cisco only] The current state of a switch.|int|count|
|`ifAdminStatus`|The desired state of the interface.|int|-|
|`ifBandwidthInUsageRate`|(Shown as percent) The percent rate of used received bandwidth.|float|percent|
|`ifBandwidthOutUsageRate`|(Shown as percent) The percent rate of used sent bandwidth.|float|percent|
|`ifHCInBroadcastPkts`|(Shown as packet) The number of packets delivered by this sub-layer to a higher (sub-)layer that were addressed to a broadcast address at this sub-layer.|int|count|
|`ifHCInMulticastPkts`|(Shown as packet) The number of packets delivered by this sub-layer to a higher (sub-)layer which were addressed to a multicast address at this sub-layer.|int|count|
|`ifHCInOctets`|(Shown as byte) The total number of octets received on the interface including framing characters.|int|count|
|`ifHCInOctetsRate`|(Shown as byte) The total number of octets received on the interface including framing characters.|int|-|
|`ifHCInUcastPkts`|(Shown as packet) The number of packets delivered by this sub-layer to a higher (sub-)layer that were not addressed to a multicast or broadcast address at this sub-layer.|int|count|
|`ifHCOutBroadcastPkts`|(Shown as packet) The total number of packets that higher-level protocols requested be transmitted that were addressed to a broadcast address at this sub-layer, including those that were discarded or not sent.|int|count|
|`ifHCOutMulticastPkts`|(Shown as packet) The total number of packets that higher-level protocols requested be transmitted that were addressed to a multicast address at this sub-layer including those that were discarded or not sent.|int|count|
|`ifHCOutOctets`|(Shown as byte) The total number of octets transmitted out of the interface including framing characters.|int|count|
|`ifHCOutOctetsRate`|(Shown as byte) The total number of octets transmitted out of the interface including framing characters.|int|count|
|`ifHCOutUcastPkts`|(Shown as packet) The total number of packets higher-level protocols requested be transmitted that were not addressed to a multicast or broadcast address at this sub-layer including those that were discarded or not sent.|int|count|
|`ifHighSpeed`|An estimate of the interface's current bandwidth in units of 1,000,000 bits per second, or the nominal bandwidth.|int|count|
|`ifInDiscards`|(Shown as packet) The number of inbound packets chosen to be discarded even though no errors had been detected to prevent them being deliverable to a higher-layer protocol.|int|count|
|`ifInDiscardsRate`|(Shown as packet) The number of inbound packets chosen to be discarded even though no errors had been detected to prevent them being deliverable to a higher-layer protocol.|int|count|
|`ifInErrors`|(Shown as packet) The number of inbound packets that contained errors preventing them from being deliverable to a higher-layer protocol.|int|count|
|`ifInErrorsRate`|(Shown as packet) The number of inbound packets that contained errors preventing them from being deliverable to a higher-layer protocol.|int|count|
|`ifNumber`|Number of interface.|int|-|
|`ifOperStatus`|(Shown as packet) The current operational state of the interface.|int|count|
|`ifOutDiscards`|(Shown as packet) The number of outbound packets chosen to be discarded even though no errors had been detected to prevent them being transmitted.|int|count|
|`ifOutDiscardsRate`|(Shown as packet) The number of outbound packets chosen to be discarded even though no errors had been detected to prevent them being transmitted.|int|count|
|`ifOutErrors`|(Shown as packet) The number of outbound packets that could not be transmitted because of errors.|int|count|
|`ifOutErrorsRate`|(Shown as packet) The number of outbound packets that could not be transmitted because of errors.|int|count|
|`ifSpeed`|An estimate of the interface's current bandwidth in bits per second, or the nominal bandwidth.|int|count|
|`memoryFree`|(Shown as percent) The percentage of memory not being used.|float|percent|
|`memoryUsage`|(Shown as percent) The percentage of memory currently being used.|float|percent|
|`memoryUsed`|(Shown as byte) Number of bytes of memory currently being used.|int|count|
|`sysUpTimeInstance`|The time (in hundredths of a second) since the network management portion of the system was last re-initialized.|int|count|
|`tcpActiveOpens`|The number of times that TCP connections have made a direct transition to the SYN-SENT state from the CLOSED state.|int|count|
|`tcpAttemptFails`|The number of times that TCP connections have made a direct transition to the CLOSED state from either the SYN-SENT state or the SYN-RCVD state, or to the LISTEN state from the SYN-RCVD state.|int|count|
|`tcpCurrEstab`|The number of TCP connections for which the current state is either ESTABLISHED or CLOSE-WAIT.|int|-|
|`tcpEstabResets`|The number of times that TCP connections have made a direct transition to the CLOSED state from either the ESTABLISHED state or the CLOSE-WAIT state.|int|count|
|`tcpInErrs`|(Shown as segment) The total number of segments received in error (e.g., bad TCP checksums).|int|count|
|`tcpOutRsts`|(Shown as segment) The number of TCP segments sent containing the RST flag.|int|count|
|`tcpPassiveOpens`|(Shown as connection) The number of times TCP connections have made a direct transition to the SYN-RCVD state from the LISTEN state.|int|count|
|`tcpRetransSegs`|(Shown as segment) The total number of segments retransmitted; that is, the number of TCP segments transmitted containing one or more previously transmitted octets.|int|count|
|`udpInErrors`|(Shown as datagram) The number of received UDP datagrams that could not be delivered for reasons other than the lack of an application at the destination port.|int|count|
|`udpNoPorts`|(Shown as datagram) The total number of received UDP datagrams for which there was no application at the destination port.|int|count|




### Object {#objects}





#### `snmp`

Collect data from SNMP device objects.

- Tag


| Tag Name | Description    |
|  ----  | --------|
|`cpu`|CPU index.|
|`device_vendor`|Equipment manufacturer|
|`entity_name`|Entity name|
|`host`|Device name|
|`interface`|Device interface name|
|`interface_alias`|Device interface alias|
|`mac_addr`|MAC address of the device|
|`mem`|Memory index.|
|`mem_pool_name`|Memory pool name.|
|`power_source`|Power source.|
|`power_status_descr`|Power status description.|
|`snmp_profile`|SNMP configuration file name|
|`temp_index`|Temperature index.|
|`temp_state`|Temperature state.|

- Field List


| Metrics | Description| Data Type | Unit   |
| ---- |---- | :---:    | :----: |
|`cieIfInputQueueDrops`|[Cisco only] (Shown as packet) The number of input packets dropped.|int|count|
|`cieIfLastInTime`|[Cisco only] (Shown as millisecond) The elapsed time in milliseconds since the last protocol input packet was received.|int|msec|
|`cieIfLastOutTime`|[Cisco only] (Shown as millisecond) The elapsed time in milliseconds since the last protocol output packet was transmitted.|int|msec|
|`cieIfOutputQueueDrops`|[Cisco only] (Shown as packet) The number of output packets dropped by the interface even though no error was detected to prevent them being transmitted.|int|count|
|`cieIfResetCount`|[Cisco only] The number of times the interface was internally reset and brought up.|int|count|
|`ciscoEnvMonFanState`|[Cisco only] The current state of the fan being instrumented.|int|count|
|`ciscoEnvMonSupplyState`|[Cisco only] The current state of the power supply being instrumented.|int|count|
|`ciscoEnvMonTemperatureStatusValue`|[Cisco only] The current value of the testpoint being instrumented.|int|count|
|`ciscoMemoryPoolFree`|[Cisco only] Indicates the number of bytes from the memory pool that are currently unused on the managed device.|int|count|
|`ciscoMemoryPoolLargestFree`|[Cisco only] Indicates the largest number of contiguous bytes from the memory pool that are currently unused on the managed device.|int|count|
|`ciscoMemoryPoolUsed`|[Cisco only] Indicates the number of bytes from the memory pool that are currently in use by applications on the managed device.|int|count|
|`cpmCPUTotal1minRev`|[Cisco only] [Shown as percent] The overall CPU busy percentage in the last 1 minute period.|float|percent|
|`cpmCPUTotalMonIntervalValue`|[Cisco only] (Shown as percent) The overall CPU busy percentage in the last cpmCPUMonInterval period.|float|percent|
|`cpuUsage`|(Shown as percent) Percentage of CPU currently being used.|float|percent|
|`cswStackPortOperStatus`|[Cisco only] The state of the stackport.|int|count|
|`cswSwitchState`|[Cisco only] The current state of a switch.|int|count|
|`device_meta`|Metadata for the device (JSON format string)|string|-|
|`ifAdminStatus`|The desired state of the interface.|int|-|
|`ifBandwidthInUsageRate`|(Shown as percent) The percent rate of used received bandwidth.|float|percent|
|`ifBandwidthOutUsageRate`|(Shown as percent) The percent rate of used sent bandwidth.|float|percent|
|`ifHCInBroadcastPkts`|(Shown as packet) The number of packets delivered by this sub-layer to a higher (sub-)layer that were addressed to a broadcast address at this sub-layer.|int|count|
|`ifHCInMulticastPkts`|(Shown as packet) The number of packets delivered by this sub-layer to a higher (sub-)layer which were addressed to a multicast address at this sub-layer.|int|count|
|`ifHCInOctets`|(Shown as byte) The total number of octets received on the interface including framing characters.|int|count|
|`ifHCInOctetsRate`|(Shown as byte) The total number of octets received on the interface including framing characters.|int|-|
|`ifHCInUcastPkts`|(Shown as packet) The number of packets delivered by this sub-layer to a higher (sub-)layer that were not addressed to a multicast or broadcast address at this sub-layer.|int|count|
|`ifHCOutBroadcastPkts`|(Shown as packet) The total number of packets that higher-level protocols requested be transmitted that were addressed to a broadcast address at this sub-layer, including those that were discarded or not sent.|int|count|
|`ifHCOutMulticastPkts`|(Shown as packet) The total number of packets that higher-level protocols requested be transmitted that were addressed to a multicast address at this sub-layer including those that were discarded or not sent.|int|count|
|`ifHCOutOctets`|(Shown as byte) The total number of octets transmitted out of the interface including framing characters.|int|count|
|`ifHCOutOctetsRate`|(Shown as byte) The total number of octets transmitted out of the interface including framing characters.|int|count|
|`ifHCOutUcastPkts`|(Shown as packet) The total number of packets higher-level protocols requested be transmitted that were not addressed to a multicast or broadcast address at this sub-layer including those that were discarded or not sent.|int|count|
|`ifHighSpeed`|An estimate of the interface's current bandwidth in units of 1,000,000 bits per second, or the nominal bandwidth.|int|count|
|`ifInDiscards`|(Shown as packet) The number of inbound packets chosen to be discarded even though no errors had been detected to prevent them being deliverable to a higher-layer protocol.|int|count|
|`ifInDiscardsRate`|(Shown as packet) The number of inbound packets chosen to be discarded even though no errors had been detected to prevent them being deliverable to a higher-layer protocol.|int|count|
|`ifInErrors`|(Shown as packet) The number of inbound packets that contained errors preventing them from being deliverable to a higher-layer protocol.|int|count|
|`ifInErrorsRate`|(Shown as packet) The number of inbound packets that contained errors preventing them from being deliverable to a higher-layer protocol.|int|count|
|`ifNumber`|Number of interface.|int|-|
|`ifOperStatus`|(Shown as packet) The current operational state of the interface.|int|count|
|`ifOutDiscards`|(Shown as packet) The number of outbound packets chosen to be discarded even though no errors had been detected to prevent them being transmitted.|int|count|
|`ifOutDiscardsRate`|(Shown as packet) The number of outbound packets chosen to be discarded even though no errors had been detected to prevent them being transmitted.|int|count|
|`ifOutErrors`|(Shown as packet) The number of outbound packets that could not be transmitted because of errors.|int|count|
|`ifOutErrorsRate`|(Shown as packet) The number of outbound packets that could not be transmitted because of errors.|int|count|
|`ifSpeed`|An estimate of the interface's current bandwidth in bits per second, or the nominal bandwidth.|int|count|
|`memoryFree`|(Shown as percent) The percentage of memory not being used.|float|percent|
|`memoryUsage`|(Shown as percent) The percentage of memory currently being used.|float|percent|
|`memoryUsed`|(Shown as byte) Number of bytes of memory currently being used.|int|count|
|`sysUpTimeInstance`|The time (in hundredths of a second) since the network management portion of the system was last re-initialized.|int|count|
|`tcpActiveOpens`|The number of times that TCP connections have made a direct transition to the SYN-SENT state from the CLOSED state.|int|count|
|`tcpAttemptFails`|The number of times that TCP connections have made a direct transition to the CLOSED state from either the SYN-SENT state or the SYN-RCVD state, or to the LISTEN state from the SYN-RCVD state.|int|count|
|`tcpCurrEstab`|The number of TCP connections for which the current state is either ESTABLISHED or CLOSE-WAIT.|int|-|
|`tcpEstabResets`|The number of times that TCP connections have made a direct transition to the CLOSED state from either the ESTABLISHED state or the CLOSE-WAIT state.|int|count|
|`tcpInErrs`|(Shown as segment) The total number of segments received in error (e.g., bad TCP checksums).|int|count|
|`tcpOutRsts`|(Shown as segment) The number of TCP segments sent containing the RST flag.|int|count|
|`tcpPassiveOpens`|(Shown as connection) The number of times TCP connections have made a direct transition to the SYN-RCVD state from the LISTEN state.|int|count|
|`tcpRetransSegs`|(Shown as segment) The total number of segments retransmitted; that is, the number of TCP segments transmitted containing one or more previously transmitted octets.|int|count|
|`udpInErrors`|(Shown as datagram) The number of received UDP datagrams that could not be delivered for reasons other than the lack of an application at the destination port.|int|count|
|`udpNoPorts`|(Shown as datagram) The total number of received UDP datagrams for which there was no application at the destination port.|int|count|







