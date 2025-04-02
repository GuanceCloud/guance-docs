---
title: 'Azure Network Interfaces'
tags: 
  - 'AZURE'
summary: 'Collect Azure Network Interface Metrics data'
__int_icon: 'icon/azure_network_interfaces'
dashboard:
  - desc: 'Azure Network Interface monitoring view'
    path: 'dashboard/en/azure_network_interfaces'
monitor   :
  - desc  : 'Azure Network Interface detection library'
    path  : 'monitor/en/azure_network_interfaces'
---

Collect Azure Network Interfaces Metrics data

## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - hosted Func: all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Installation Script

> Note: Please prepare the required Azure application registration information in advance and assign the `Monitoring Reader` role to the application registration.

To synchronize Azure Network Interface monitoring data, we install the corresponding collection script: 「Integration (Azure-Network Interface Collection)」(ID: `guance_azure_network_interface`)

After clicking 【Install】, enter the corresponding parameters:

- `Azure Tenant ID`: Tenant ID
- `Azure Client ID`: Application registration Client ID
- `Azure Client Secret Value`: Client secret value, note that it is not the ID
- `Subscriptions`: Subscription ID, multiple subscriptions are separated by `,`

Click 【Deploy and Start Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to immediately run once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

### Validation

1. In 「Manage / Automatic Trigger Configuration」confirm whether the corresponding task has an automatic trigger configuration, and at the same time, you can check the corresponding task records and logs for any abnormalities.
2. In <<< custom_key.brand_name >>>, under 「Infrastructure - Resource Catalog」, check if there is asset information.
3. In <<< custom_key.brand_name >>>, under 「Metrics」check if there is corresponding monitoring data.

## Metrics {#metric}

Collect Azure Network Interfaces Metrics data, more Metrics can be collected through configuration [Microsoft.Network/networkinterfaces supported Metrics](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-networkinterfaces-metrics){:target="_blank"}

| Metric Name | Description | Unit |
| ---- | ------ | ------ |
|`BytesReceivedRate`| Number of bytes received | byte|
|`BytesSentRate`| Number of bytes sent | byte |
|`CreationRateMaxTotalFlowsIn`| Maximum inbound flow creation rate | count |
|`CreationRateMaxTotalFlowsOut`| Maximum outbound flow creation rate | count/s |
|`CurrentTotalFlowsIn`| Inbound flows | count |
|`CurrentTotalFlowsOut`| Outbound flows | count |
|`PacketsReceivedRate`| Number of packets received | count |
|`PacketsSentRate`| Number of packets sent | count |