---
title: 'Huawei Cloud DCAAS Cloud Direct Connect'
tags:
  - Huawei Cloud
summary: 'Collect Huawei Cloud DCAAS Metrics data'
__int_icon: 'icon/huawei_dcaas'
dashboard:
  - desc: 'Huawei Cloud DCAAS built-in view'
    path: 'dashboard/en/huawei_dcaas/'

monitor:
  - desc: 'Huawei Cloud DCAAS Monitor'
    path: 'monitor/en/huawei_dcaas/'
---

Collect Huawei Cloud DCAAS Metrics data

## Configuration {#config}

### Install Func

It is recommended to enable Guance Integration - Extensions - DataFlux Func (Automata): All prerequisites are automatically installed, please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/)

> It is recommended to deploy the GSE version

### Install Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize Huawei Cloud DCAAS monitoring data, install the corresponding collection script:

- **guance_huaweicloud_dcaas_virtual_interfaces**: Collects monitoring metrics data for DC cloud direct connect virtual interfaces.
- **guance_huaweicloud_dcaas_direct_connects**: Collects monitoring metrics data for DC cloud direct connect physical connections.

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy Startup Script】. The system will automatically create a `Startup` script set and configure the corresponding startup scripts.

After the script installation is complete, find the script "Guance Integration (Huawei Cloud - Cloud Direct Connect DC - Virtual Interface)" / "Guance Integration (Huawei Cloud - Cloud Direct Connect DC - Physical Connection)" under "Development" in Func. Expand and modify this script, edit the content of `region_projects` under `collector_configs` and `monitor_configs`, changing the region and Project ID to the actual region and Project ID, then click Save and Publish.

Additionally, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. Wait a moment, and you can check the execution task records and corresponding logs.

### Verification

1. Confirm in "Management / Automatic Trigger Configuration" whether the corresponding task has an automatic trigger configuration. You can also check the corresponding task records and logs for any anomalies.
2. In the Guance platform, check under "Infrastructure - Resource Catalog" if asset information exists.
3. In the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}

Collect Huawei Cloud DCAAS Metrics data. You can collect more metrics by configuring them. Refer to [Huawei Cloud DCAAS Metrics Details](https://support.huaweicloud.com/usermanual-dc/dc_04_0802.html){:target="_blank"}

| **Metric ID** | **Metric Name** | **Metric Description** | **Value Range** | **Measurement Object** | **Monitoring Period (Original Metric)** |
| --- | --- | --- | --- | --- | --- |
| `network_incoming_bits_rate` | Network Incoming Bandwidth | Bit rate of inbound data on the cloud direct connect side. Unit: bit/s | ≥ 0 bit/s | Physical connection and historical physical connections | 1 minute |
| `network_outgoing_bits_rate` | Network Outgoing Bandwidth | Bit rate of outbound data on the cloud direct connect side. Unit: bit/s | ≥ 0 bit/s | Physical connection and historical physical connections | 1 minute |
| `network_incoming_bytes` | Network Incoming Traffic | Number of bytes of inbound data on the cloud direct connect side. Unit: byte | ≥ 0 bytes | Physical connection and historical physical connections | 1 minute |
| `network_outgoing_bytes` | Network Outgoing Traffic | Number of bytes of outbound data on the cloud direct connect side. Unit: byte | ≥ 0 bytes | Physical connection and historical physical connections | 1 minute |
| `network_incoming_packets_rate` | Network Incoming Packet Rate | Packet rate of inbound data on the cloud direct connect side. Unit: Packet/s | ≥ 0 packets/s | Physical connection and historical physical connections | 1 minute |
| `network_outgoing_packets_rate` | Network Outgoing Packet Rate | Packet rate of outbound data on the cloud direct connect side. Unit: Packet/s | ≥ 0 packets/s | Physical connection and historical physical connections | 1 minute |
| `network_incoming_packets` | Network Incoming Packets | Number of inbound packets on the cloud direct connect side. Unit: Packet | ≥ 0 packets | Physical connection and historical physical connections | 1 minute |
| `network_outgoing_packets` | Network Outgoing Packets | Number of outbound packets on the cloud direct connect side. Unit: Packet | ≥ 0 packets | Physical connection and historical physical connections | 1 minute |
| `network_status` | Port Status | Port status of the cloud direct connect physical connection. | 0-DOWN 1-UP | Physical connection and historical physical connections | 1 minute |
| `bgp_receive_route_num_v4` | Received IPV4 Route Entries | Number of IPV4 route entries learned by the virtual interface via BGP protocol. | ≥0 entries | Virtual interface | 1 minute |
| `bgp_receive_route_num_v6` | Received IPV6 Route Entries | Number of IPV6 route entries learned by the virtual interface via BGP protocol. | ≥0 entries | Virtual interface | 1 minute |
| `bgp_peer_status_v4` | IPv4 BGP PEER Status | IPv4 BGP PEER status | 0-DOWN 1-ACTIVE | Virtual interface | 1 minute |
| `bgp_peer_status_v6` | IPv6 BGP PEER Status | IPv6 BGP PEER status | 0-DOWN 1-ACTIVE | Virtual interface | 1 minute |
| `in_errors` | Network Incoming Error Packets | Number of inbound error packets on the cloud direct connect side. | 0-2^23 | Virtual interface | 1 minute |

## Objects {#object}

After data synchronization is successful, you can view the data in the Guance platform under "Infrastructure - Resource Catalog".

- DC Cloud Direct Connect Virtual Interface Object Data:

```json
{
  "measurement": "huaweicloud_dcass_virtual_interface",
  "tags": {
    "RegionId": "cn-south-1",
    "project_id": "756ada1aa17exxxxb2a16ea41912e52d",
    "enterprise_project_id": "320a1900-b6d2-xxxx-a348-0979986b730b",
    "tenant_id": "07d662153ada40c5bd984601976xxxx",
    "virtual_interface_id": "ccaad430-389c-4fe6-xxxx-2543e1b0d1b5",
    "virtual_interface_name": "vif-xxxx-xx-2g02",
    "direct_connect_id": "b032de49-2932-4ae3-xxxx-c0234f60afce",
    "status": "ACTIVE"
  },
  "fields": {
    "type": "private",
    "service_type": "GDGW",
    "vgw_id": "xxxxxxxxxx",
    "bandwidth": "500",
    "description": "{JSON data}",
    "device_id": "120.87.xxx.9",
    "create_time": "2024/11/21 18:31:22",
    "tags": "[]"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `virtual_interface_id` is the DC virtual interface ID, used as a unique identifier.
>
> Tip 2: `ACTIVE`, `DOWN` are the values corresponding to status.

- DC Cloud Direct Connect Physical Connection Object Data:

```json
{
  "measurement": "huaweicloud_dcass_virtual_interface",
  "tags": {
    "RegionId": "cn-south-1",
    "project_id": "756ada1aa17exxxxb2a16ea41912e52d",
    "enterprise_project_id": "320a1900-b6d2-xxxx-a348-0979986b730b",
    "tenant_id": "07d662153ada40c5bd984601976xxxx",
    "direct_connect_id": "ccaad430-389c-4fe6-xxxx-2543e1b0d1b5",
    "direct_connect_name": "vif-xxxx-xx-2g02",
    "status": "ACTIVE"
  },
  "fields": {
    "type": "private",
    "bandwidth": "500",
    "description": "{JSON data}",
    "location": "Shanghaixx-xxx",
    "provider": "others",
    "provider_status": "ACTIVE",
    "charge_mode": "prepayment",
    "device_id": "xx.87.xxx.9",
    "hosting_id": "345ed71f-91b6-4248-xxxx-952bdb1c3706",
    "port_type": "40G",
    "apply_time": "2023-05-24T08:53:05.000Z",
    "create_time": "2024/11/21 18:31:22",
    "tags": "[]"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `direct_connect_id` is the physical connection ID, used as a unique identifier.
>
> Tip 2: `ACTIVE`, `DOWN` are the values corresponding to status.
