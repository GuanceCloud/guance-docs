---
title: 'Azure Virtual Network Gateway'
tags: 
  - 'AZURE'
summary: 'Collect metrics data from Azure Virtual Network Gateway'
__int_icon: 'icon/azure_Virtual_network_gateway'
dashboard:
  - desc: 'Azure Virtual Network Gateway'
    path: 'dashboard/en/azure_Virtual_network_gateway'
monitor   :
  - desc  : 'Azure Virtual Network Gateway monitoring library'
    path  : 'monitor/en/azure_Virtual_network_gateway'
---

Collect metrics data from Azure Virtual Network Gateway

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare the required Azure application registration information in advance and assign the `Monitoring Reader` role to the application registration.

To synchronize Azure Virtual Network Gateway monitoring data, we install the corresponding collection script: "Integration (Azure-Virtual Network Gateway Collection)" (ID: `guance_azure_virtual_network_gateway`)

After clicking 【Install】, enter the corresponding parameters:

- `Azure Tenant ID`: Tenant ID
- `Azure Client ID`: Application Registration Client ID
- `Azure Client Secret Value`: Client secret value, note that it is not the ID
- `Subscriptions`: Subscription ID, multiple subscriptions can be separated by `,`

Click 【Deploy Start Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configurations. You can also check the corresponding task records and logs to see if there are any abnormalities.
2. On the Guance platform, in "Infrastructure - Resource Catalog", check if asset information exists.
3. On the Guance platform, in "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}

Collect Azure Virtual Network Gateway metrics, more metrics can be collected through configuration [microsoft.network/virtualnetworkgateways supported metrics](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-virtualnetworkgateways-metrics){:target="_blank"}

| Metric Name | Description | Unit |
| ---- | ------ | ------ |
|`average_bandwidth_average`| Gateway S2S bandwidth | Bytes/s |
|`bgp_peer_status_average`| BGP peer status | count |
|`bgp_routes_advertised_total`| Number of advertised BGP routes | count |
|`bgp_routes_learned_total`| Number of learned BGP routes | count |
|`express_route_gateway_active_flows_average`| Number of active flows | count |
|`express_route_gateway_bits_per_second_average`| Number of bits received per second | Bytes/s |
|`express_route_gateway_count_of_routes_advertised_to_peer_maximum`| Count of routes advertised to peer| count |
|`express_route_gateway_count_of_routes_learned_from_peer_maximum`| Count of routes learned from peer| count |
|`express_route_gateway_cpu_utilization_average`| CPU utilization | % |
|`express_route_gateway_frequency_of_routes_changed_total`| Route change frequency| % |
|`express_route_gateway_max_flows_creation_rate_maximum`| Maximum number of flows created per second | count |
|`express_route_gateway_number_of_vm_in_vnet_maximum`| Number of VMs in the virtual network | count |
|`express_route_gateway_packets_per_second_average`| Number of packets received per second | count |
|`inbound_flows_count_maximum`| Gateway inbound flows | % |
|`outbound_flows_count_maximum`| Gateway outbound flows | % |
|`vnet_address_prefix_count_total`| VNet address prefix count| count |
|`mesa_count_total`| Tunnel MMSA count | count |
|`qmsa_count_total`| Tunnel QMSA count | count |
|`tunnel_average_bandwidth_average`| Tunnel bandwidth | Bytes/s |
|`tunnel_egress_bytes_total`| Tunnel egress bytes | Byte |
|`tunnel_ingress_bytes_total`| Tunnel ingress bytes| Byte |
|`tunnel_egress_packets_total`| Tunnel egress packet count | count |
|`tunnel_ingress_packets_total`| Tunnel ingress packet count | count |