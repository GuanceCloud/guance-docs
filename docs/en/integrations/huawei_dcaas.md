---
title: 'Huawei Cloud DCAAS Cloud Direct Connect'
tags:
  - Huawei Cloud
summary: 'Collect Huawei Cloud DCAAS Metrics data'
__int_icon: 'icon/huawei_dcaas'
dashboard:
  - desc: 'Huawei Cloud DCAAS Built-in Views'
    path: 'dashboard/en/huawei_dcaas/'

monitor:
  - desc: 'Huawei Cloud DCAAS Monitors'
    path: 'monitor/en/huawei_dcaas/'
---

Collect Huawei Cloud DCAAS Metrics data

## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> Integration - Extensions - DataFlux Func (Automata): All prerequisites are automatically installed, please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/)

> It is recommended to deploy the GSE version.

### Install Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize Huawei Cloud DCAAS monitoring data, we install the corresponding collection script:

- **guance_huaweicloud_dcaas_virtual_interfaces**: Collects DC cloud direct connect virtual interface monitoring Metrics data.
- **guance_huaweicloud_dcaas_direct_connects**: Collects DC cloud direct connect physical connection monitoring Metrics data.

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After the script is installed, find the script "<<< custom_key.brand_name >>> Integration (Huawei Cloud - Cloud Direct Connect DC - Virtual Interface)" / "<<< custom_key.brand_name >>> Integration (Huawei Cloud - Cloud Direct Connect DC - Physical Connection)" under "Development" in Func, unfold and modify this script. Find `collector_configs` and `monitor_configs`, respectively edit the content of `region_projects`, change the region and Project ID to the actual region and Project ID, then click Save and Publish.

In addition, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute it once without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.

### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding automatic trigger configuration exists for the task, and you can also check the corresponding task records and logs for any anomalies.
2. On the <<< custom_key.brand_name >>> platform, in "Infrastructure - Resource Catalog", check if there is any asset information.
3. On the <<< custom_key.brand_name >>> platform, in "Metrics", check if there is any corresponding monitoring data.

## Metrics {#metric}

You can collect more Metrics from Huawei Cloud DCAAS by configuring them [Huawei Cloud DCAAS Metrics Details](https://support.huaweicloud.com/usermanual-dc/dc_04_0802.html){:target="_blank"}

|   **Metric ID**  |   **Metric Name**   |  **Metric Meaning** |  **Value Range**  | **Measurement Object** | **Monitoring Period (Original Metric)** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| `network_incoming_bits_rate`            |   Network Incoming Bandwidth    |Bitrate of incoming data at the cloud direct connect side. Unit: bit/s   | ≥ 0 bit/s  | Physical connection and historical physical connections | 1 minute             |
| `network_outgoing_bits_rate`            |   Network Outgoing Bandwidth    |Bitrate of outgoing data at the cloud direct connect side. Unit: bit/s   | ≥ 0 bit/s  | Physical connection and historical physical connections | 1 minute             |
| `network_incoming_bytes`            |   Network Incoming Traffic    |Number of bytes of incoming data at the cloud direct connect side. Unit: byte   | ≥ 0 bytes  | Physical connection and historical physical connections | 1 minute             |
| `network_outgoing_bytes`            |   Network Outgoing Traffic    |Number of bytes of outgoing data at the cloud direct connect side. Unit: byte   | ≥ 0 bytes  | Physical connection and historical physical connections | 1 minute             |
| `network_incoming_packets_rate`            |   Network Incoming Packet Rate    |Packet rate of incoming data at the cloud direct connect side. Unit: Packet/s   | ≥ 0 packets/s  | Physical connection and historical physical connections | 1 minute             |
| `network_outgoing_packets_rate`            |   Network Outgoing Packet Rate    |Packet rate of outgoing data at the cloud direct connect side. Unit: Packet/s   | ≥ 0 packets/s  | Physical connection and historical physical connections | 1 minute             |
| `network_incoming_packets`            |   Network Incoming Packets    |Number of incoming data packets at the cloud direct connect side. Unit: Packet   | ≥ 0 packets  | Physical connection and historical physical connections | 1 minute             |
| `network_outgoing_packets`            |   Network Outgoing Packets    |Number of outgoing data packets at the cloud direct connect side. Unit: Packet   | ≥ 0 packets  | Physical connection and historical physical connections | 1 minute             |
| `network_status`            |   Port Status    |Port status of the cloud direct connect physical connection.   | 0-DOWN 1-UP  | Physical connection and historical physical connections | 1 minute             |
| `bgp_receive_route_num_v4`            |   Received IPV4 Route Entries    |Number of IPV4 route entries learned by the virtual interface through BGP protocol.   | ≥0 entries  | Virtual interfaces | 1 minute             |
| `bgp_receive_route_num_v6`            |   Received IPV6 Route Entries    |Number of IPV6 route entries learned by the virtual interface through BGP protocol.   | ≥0 entries  | Virtual interfaces | 1 minute             |
| `bgp_peer_status_v4`            |   IPv4 BGP PEER Status    |IPv4 BGP PEER status   | 0-DOWN 1-ACTIVE  | Virtual interfaces | 1 minute             |
| `bgp_peer_status_v6`            |   IPv6 BGP PEER Status    |IPv6 BGP PEER status   | 0-DOWN 1-ACTIVE  | Virtual interfaces | 1 minute             |
| `in_errors`            |   Network Incoming Error Packets    |Number of incoming error packets at the cloud direct connect side.   | 0-2^23 | Virtual interfaces | 1 minute             |

## Objects {#object}

After data synchronization is normal, you can view the data in "Infrastructure - Resource Catalog" on the <<< custom_key.brand_name >>> platform.

- DC cloud direct connect virtual interface object data:

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
> Tip 1: The value of `virtual_interface_id` is the DC virtual interface ID, used as unique identification.
>
> Tip 2: `ACTIVE`,`DOWN` are the values corresponding to status.

- DC cloud direct connect physical connection object data:

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
> Tip 1: The value of `direct_connect_id` is the physical connection ID, used as unique identification.
>
> Tip 2: `ACTIVE`,`DOWN` are the values corresponding to status.