---
title: 'Huawei Cloud DCAAS Cloud Dedicated Line'
tags:
  - Huawei Cloud
summary: 'Collect Huawei Cloud DCAAS metric data'
__int_icon: 'icon/huawei_dcaas'
dashboard:
  - desc: 'Huawei Cloud DCAAS Built in View'
    path: 'dashboard/en/huawei_dcaas/'

monitor:
  - desc: 'Huawei Cloud DCAAS Monitor'
    path: 'monitor/en/huawei_dcaas/'
---

Collect Huawei Cloud DCAAS metric data

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically,Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> Recommend deploying GSE (Game Server Engine) edition translation.

### Installation script

> Tip:Please prepare a Huawei Cloud AK that meets the requirements in advance (For simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize Huawei Cloud DCAAS monitoring data, we install the corresponding collection script:

- **guance_huaweicloud_dcaas_virtual_interfaces**: Collect monitoring metric data for DC cloud dedicated line virtual interface
- **guance_huaweicloud_dcaas_direct_connects**: Collect data on physical connection monitoring metrics for DC cloud dedicated lines

Click 【Install】 and enter the corresponding parameters: HUAWEI CLOUD AK, HUAWEI CLOUD account name.

Tap【Deploy startup Script】, the system automatically creates `Startup` script sets, and automatically configure the corresponding startup script.

After installing the script, find the script 「Guance Cloud Integration (Huawei Cloud Cloud Dedicated Line DC Virtual Interface)」/「「Guance Cloud Integration (Huawei Cloud Cloud Dedicated Line DC Physical Connection)」 in the 「Development」 section of Func. Expand and modify the script, find collector_configs and monitor_configs, and edit the content in region_projects below. Change the region and Project ID to the actual region and Project ID, and then click save and publish.

In addition, in「Management / Automatic Trigger Configuration」 you can see the corresponding automatic trigger configuration. Click 【Execute】 to run it immediately, without waiting for the scheduled time. After a short moment, you can check the execution task records and corresponding logs.

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure - Resource Catalog」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

Collecting Huawei Cloud DCAAS metrics, more metrics can be collected through configuration [Huawei Cloud DCAAS metric Details](https://support.huaweicloud.com/usermanual-dc/dc_04_0802.html){:target="_blank"}

| **MetricID**            |          **Metric Name**   | **Metric Meaning** | **Value Range**      | **Measured Object** | **Monitoring Period (Raw Metric)** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| `network_incoming_bits_rate`            |   Network bandwidth inflow    | The bit rate of inbound data on the cloud dedicated line connection side. Unit: bit/s   | ≥ 0 bit/s  | Physical connection and historical physical connection | 1 minute             |
| `network_outgoing_bits_rate`            |   Network outflow bandwidth    |The bit rate of outbound data on the cloud dedicated line connection side. Unit: bit/s   | ≥ 0 bit/s  | Physical connection and historical physical connection | 1 minute             |
| `network_incoming_bytes`            |   Network incoming traffic    |The number of bytes of inbound data on the cloud dedicated line connection side. Unit: byte   | ≥ 0 bytes  | Physical connection and historical physical connection | 1 minute             |
| `network_outgoing_bytes`            |   Network outflow traffic    |The number of bytes of outbound data on the cloud dedicated line connection side. Unit: byte   | ≥ 0 bytes  | Physical connection and historical physical connection | 1 minute             |
| `network_incoming_packets_rate`            |   Network incoming packet rate    |Cloud dedicated line connection side inbound packet rate. Unit: Packet/s   | ≥ 0 packets/s  | Physical connection and historical physical connection | 1 minute             |
| `network_outgoing_packets_rate`            |   Network packet outflow rate    |Outbound packet rate on the cloud dedicated line connection side. Unit: Packet/s   | ≥ 0 packets/s  | Physical connection and historical physical connection | 1 minute             |
| `network_incoming_packets`            |   Network incoming packet volume    |Number of inbound data packets on the cloud dedicated line connection side. Unit: Packet   | ≥ 0 packets  | Physical connection and historical physical connection | 1 minute             |
| `network_outgoing_packets`            |   Network packet outflow volume    |Number of outbound data packets on the cloud dedicated line connection side. Unit: Packet   | ≥ 0 packets  | Physical connection and historical physical connection | 1 minute             |
| `network_status`           |   Port status    |Port status of physical connection for cloud dedicated line   | 0-DOWN 1-UP  | Physical connection and historical physical connection | 1 minute             |
| `bgp_receive_route_num_v4`            |   Number of IPV4 routing entries received    |The number of IPV4 routing entries learned by the virtual interface through BGP protocol   | ≥0 个  | Virtual interface | 1 minute             |
| `bgp_receive_route_num_v6`            |   Number of IPV6 routing entries received    |The number of IPV6 routing entries learned by the virtual interface through BGP protocol   | ≥0 个  | Virtual interface | 1 minute             |
| `bgp_peer_status_v4`            |   IPv4 BGP PEER status    |IPv4 BGP PEER status   | 0-DOWN 1-ACTIVE  | Virtual interface | 1 minute             |
| `bgp_peer_status_v6`            |   IPv6 BGP PEER status    |IPv6 BGP PEER status   | 0-DOWN 1-ACTIVE  | Virtual interface | 1 minute          |
| `in_errors`            |   Number of erroneous packets flowing into the network    | Number of inbound error packets on the cloud dedicated line connection side  | 0-2^23 | Virtual interface | 1 minute           |

## Object {#object}

After normal data synchronization, data can be viewed in the 「Infrastructure - Resource Catalog」 section of the observation cloud.

- DC Cloud Dedicated Line Virtual Interface Object Data:

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
    "description"       : "{JSON data}",
    "device_id"         : "xx.87.xxx.9",
    "create_time"       : "2024/11/21 18:31:22",
    "tags"              : "[]"
  }
}
```

> *Note: Fields `tags` and `fields` might be subject to changes in future updates.*
>
> Tip 1:The value of `virtualid_interacte_id` is the DC virtual interface ID, which serves as a unique identifier.
>
> Tip 2:`ACTION` and `DOWN`are the values corresponding to status.

- DC Cloud Dedicated Line Physical Connection Object Data:

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
    "description"       : "{JSON data}",
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

> *Note: Fields `tags` and `fields` might be subject to changes in future updates.*
>
> Tip 1：The value of `direct_comnect_id` is the physical connection ID, which serves as a unique identifier.
>
> Tip 2:`ACTION` and `DOWN`are the values corresponding to status.
>