---
title: 'Huawei Cloud DCAAS Dedicated Line'
tags:
  - Huawei Cloud
summary: 'Collect Huawei Cloud DCAAS Metrics data'
__int_icon: 'icon/huawei_dcaas'
dashboard:
  - desc: 'Huawei Cloud DCAAS built-in views'
    path: 'dashboard/en/huawei_dcaas/'

monitor:
  - desc: 'Huawei Cloud DCAAS monitors'
    path: 'monitor/en/huawei_dcaas/'
---

Collect Huawei Cloud DCAAS Metrics data

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/)

> We recommend deploying the GSE version

### Install Script

> Note: Prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize Huawei Cloud DCAAS monitoring data, we install the corresponding collection scripts:

- **guance_huaweicloud_dcaas_virtual_interfaces**: Collects metrics data for DC dedicated line virtual interfaces.
- **guance_huaweicloud_dcaas_direct_connects**: Collects metrics data for DC dedicated line physical connections.

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the startup scripts.

After the script is installed, find the scripts "Guance Integration (Huawei Cloud - Dedicated Line DC-Virtual Interface)" / "Guance Integration (Huawei Cloud - Dedicated Line DC-Physical Connection)" under "Development" in Func, expand and modify these scripts. Edit the contents of `region_projects` in `collector_configs` and `monitor_configs`, change the region and Project ID to the actual ones, and click Save and Publish.

Additionally, you can see the corresponding automatic trigger configurations in "Management / Automatic Trigger Configurations". Click 【Execute】 to immediately execute once without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

### Verification

1. In "Management / Automatic Trigger Configurations", confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and check the task records and logs for any anomalies.
2. On the Guance platform, go to "Infrastructure - Resource Catalog" to check if asset information exists.
3. On the Guance platform, go to "Metrics" to check if there is corresponding monitoring data.

## Metrics {#metric}

You can collect more Huawei Cloud DCAAS metrics by configuring [Huawei Cloud DCAAS Metric Details](https://support.huaweicloud.com/usermanual-dc/dc_04_0802.html){:target="_blank"}

| **Metric ID** | **Metric Name** | **Metric Meaning** | **Value Range** | **Measurement Object** | **Monitoring Period (Original Metric)** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| `network_incoming_bits_rate`            |   Network Incoming Bandwidth    | Bit rate of inbound data on the dedicated line connection side. Unit: bit/s   | ≥ 0 bit/s  | Physical connection and historical physical connection | 1 minute             |
| `network_outgoing_bits_rate`            |   Network Outgoing Bandwidth    | Bit rate of outbound data on the dedicated line connection side. Unit: bit/s   | ≥ 0 bit/s  | Physical connection and historical physical connection | 1 minute             |
| `network_incoming_bytes`            |   Network Incoming Traffic    | Number of inbound bytes on the dedicated line connection side. Unit: byte   | ≥ 0 bytes  | Physical connection and historical physical connection | 1 minute             |
| `network_outgoing_bytes`            |   Network Outgoing Traffic    | Number of outbound bytes on the dedicated line connection side. Unit: byte   | ≥ 0 bytes  | Physical connection and historical physical connection | 1 minute             |
| `network_incoming_packets_rate`            |   Network Incoming Packet Rate    | Packet rate of inbound data on the dedicated line connection side. Unit: Packet/s   | ≥ 0 packets/s  | Physical connection and historical physical connection | 1 minute             |
| `network_outgoing_packets_rate`            |   Network Outgoing Packet Rate    | Packet rate of outbound data on the dedicated line connection side. Unit: Packet/s   | ≥ 0 packets/s  | Physical connection and historical physical connection | 1 minute             |
| `network_incoming_packets`            |   Network Incoming Packets    | Number of inbound packets on the dedicated line connection side. Unit: Packet   | ≥ 0 packets  | Physical connection and historical physical connection | 1 minute             |
| `network_outgoing_packets`            |   Network Outgoing Packets    | Number of outbound packets on the dedicated line connection side. Unit: Packet   | ≥ 0 packets  | Physical connection and historical physical connection | 1 minute             |
| `network_status`            |   Port Status    | Port status of the dedicated line physical connection.   | 0-DOWN 1-UP  | Physical connection and historical physical connection | 1 minute             |
| `bgp_receive_route_num_v4`            |   Received IPV4 Route Entries    | Number of IPV4 route entries learned through BGP protocol by the virtual interface.   | ≥0  | Virtual interface | 1 minute             |
| `bgp_receive_route_num_v6`            |   Received IPV6 Route Entries    | Number of IPV6 route entries learned through BGP protocol by the virtual interface.   | ≥0  | Virtual interface | 1 minute             |
| `bgp_peer_status_v4`            |   IPv4 BGP PEER Status    | IPv4 BGP PEER status   | 0-DOWN 1-ACTIVE  | Virtual interface | 1 minute             |
| `bgp_peer_status_v6`            |   IPv6 BGP PEER Status    | IPv6 BGP PEER status   | 0-DOWN 1-ACTIVE  | Virtual interface | 1 minute             |
| `in_errors`            |   Network Incoming Error Packets    | Number of inbound error packets on the dedicated line connection side   | 0-2^23 | Virtual interface | 1 minute             |

## Objects {#object}

After data synchronization is normal, you can view the data in the "Infrastructure - Resource Catalog" of Guance.

- DC Dedicated Line Virtual Interface Object Data:

```json
{
  "measurement": "huaweicloud_dcass_virtual_interface",
  "tags": {
    "RegionId"                : "cn-south-1",
    "project_id"              : "756ada1aa17exxxxb2a16ea41912e52d",
    "enterprise_project_id"   : "320a1900-b6d2-xxxx-a348-0979986b730b",
    "tenant_id"               : "07d662153ada40c5bd984601976xxxx",
    "virtual_interface_id"    : "ccaad430-389c-4fe6-xxxx-2543e1b0d1b5",
    "virtual_interface_name"  : "vif-xxxx-xx-2g02",
    "direct_connect_id"       : "b032de49-2932-4ae3-xxxx-c0234f60afce",
    "status"                  : "ACTIVE"
  },
  "fields": {
    "type"              : "private",
    "service_type"      : "GDGW",
    "vgw_id"            : "xxxxxxxxxx",
    "bandwidth"         : "500",
    "description"       : "{JSON Data}",
    "device_id"         : "120.87.xxx.9",
    "create_time"       : "2024/11/21 18:31:22",
    "tags"              : "[]"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `virtual_interface_id` is the DC virtual interface ID, used as a unique identifier.
>
> Tip 2: `ACTIVE`, `DOWN` are the values corresponding to `status`.

- DC Dedicated Line Physical Connection Object Data:

```json
{
  "measurement": "huaweicloud_dcass_virtual_interface",
  "tags": {
    "RegionId"                : "cn-south-1",
    "project_id"              : "756ada1aa17exxxxb2a16ea41912e52d",
    "enterprise_project_id"   : "320a1900-b6d2-xxxx-a348-0979986b730b",
    "tenant_id"               : "07d662153ada40c5bd984601976xxxx",
    "direct_connect_id"       : "ccaad430-389c-4fe6-xxxx-2543e1b0d1b5",
    "direct_connect_name"     : "vif-xxxx-xx-2g02",
    "status"                  : "ACTIVE"
  },
  "fields": {
    "type"              : "private",
    "bandwidth"         : "500",
    "description"       : "{JSON Data}",
    "location"          : "Shanghaixx-xxx",
    "provider"          : "others",
    "provider_status"   : "ACTIVE",
    "charge_mode"       : "prepayment",
    "device_id"         : "xx.87.xxx.9",
    "hosting_id"        : "345ed71f-91b6-4248-xxxx-952bdb1c3706",
    "port_type"         : "40G",
    "apply_time"        : "2023-05-24T08:53:05.000Z",
    "create_time"       : "2024/11/21 18:31:22",
    "tags"              : "[]"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `direct_connect_id` is the physical connection ID, used as a unique identifier.
>
> Tip 2: `ACTIVE`, `DOWN` are the values corresponding to `status`.