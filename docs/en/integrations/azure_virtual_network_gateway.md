---
title: 'Azure Virtual Network Gateway'
tags: 
  - 'AZURE'
summary: 'Collect Azure Virtual Network Gateway Metrics data'
__int_icon: 'icon/azure_virtual_network_gateway'
dashboard:
  - desc: 'Azure Virtual Network Gateway'
    path: 'dashboard/en/azure_virtual_network_gateway'
monitor   :
  - desc  : 'Azure Virtual Network Gateway Monitoring Library'
    path  : 'monitor/en/azure_virtual_network_gateway'
---

Collect Azure Virtual Network Gateway Metrics data

## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> Integration - Extension - Managed Func: All prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Installation Script

> Note: Please prepare the required Azure application registration information in advance and assign the `Monitoring Reader` role to the application registration.

To synchronize monitoring data for Azure Virtual Network Gateway, we install the corresponding collection script: 「Integration (Azure-Virtual Network Gateway Collection)」(ID: `guance_azure_virtual_network_gateway`)

After clicking 【Install】, enter the corresponding parameters:

- `Azure Tenant ID`: Tenant ID
- `Azure Client ID`: Application Registration Client ID
- `Azure Client Secret Value`: Client secret value, note it's not the ID
- `Subscriptions`: Subscription ID, multiple subscriptions separated by `,`

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to immediately run once without waiting for the scheduled time. After a while, you can view the execution task records and corresponding logs.

### Validation

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and you can also check the corresponding task records and logs for any abnormalities.
2. In <<< custom_key.brand_name >>>, 「Infrastructure - Resource Catalog」check if asset information exists.
3. In <<< custom_key.brand_name >>>, 「Metrics」check if there are corresponding monitoring data.

## Metrics {#metric}

Collect Azure Virtual Network Gateway metrics. You can collect more metrics via configuration [Supported metrics for microsoft.network/virtualnetworkgateways](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-virtualnetworkgateways-metrics){:target="_blank"}

| Metric Name | Description | Unit |
| ---- | ------ | ------ |
|`average_bandwidth_average`| Gateway S2S bandwidth | Bytes/s |
|`bgp_peer_status_average`| BGP peer status | count |
|`bgp_routes_advertised_total`| Advertised BGP routes | count |
|`bgp_routes_learned_total`| Learned BGP routes | count |
|`express_route_gateway_active_flows_average`| Number of active flows | count |
|`express_route_gateway_bits_per_second_average`| Bits received per second | Bytes/s |
|`express_route_gateway_count_of_routes_advertised_to_peer_maximum`| Count of routes advertised to peer | count |
|`express_route_gateway_count_of_routes_learned_from_peer_maximum`| Count of routes learned from peer | count |
|`express_route_gateway_cpu_utilization_average`| CPU utilization | % |
|`express_route_gateway_frequency_of_routes_changed_total`| Route change frequency | % |
|`express_route_gateway_max_flows_creation_rate_maximum`| Maximum number of flows created per second | count |
|`express_route_gateway_number_of_vm_in_vnet_maximum`| Number of VMs in virtual network | count |
|`express_route_gateway_packets_per_second_average`| Packets received per second | count |
|`inbound_flows_count_maximum`| Gateway inbound flows | % |
|`outbound_flows_count_maximum`| Gateway outbound flows | % |
|`vnet_address_prefix_count_total`| VNet address prefix count | count |
|`mesa_count_total`| Tunnel MMSA count | count |
|`qmsa_count_total`| Tunnel QMSA count | count |
|`tunnel_average_bandwidth_average`| Tunnel bandwidth | Bytes/s |
|`tunnel_egress_bytes_total`| Tunnel egress bytes | Byte |
|`tunnel_ingress_bytes_total`| Tunnel ingress bytes | Byte |
|`tunnel_egress_packets_total`| Tunnel egress packets | count |
|`tunnel_ingress_packets_total`| Tunnel ingress packets | count |