---
title: 'Azure Network Interfaces'
tags: 
  - 'AZURE'
summary: 'Collect Azure Network Interface metric data'
__int_icon: 'icon/azure_network_interfaces'
dashboard:
  - desc: 'Azure Network Interface monitoring view'
    path: 'dashboard/en/azure_network_interfaces'
monitor   :
  - desc  : 'Azure Network Interface detection library'
    path  : 'monitor/en/azure_network_interfaces'
---

Collect Azure Network Interfaces metric data

## Configuration {#config}

### Install Func

It is recommended to enable the Guance Cloud integration - Extension - Managed Func: All preconditions will be automatically installed. Please proceed with the script installation.

If you deploy Func manually, refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}.

### Install the script

> Note: Please prepare the required Azure application registration information in advance and assign the `Monitoring Reader` role to the application registration.

To synchronize the monitoring data of Azure Network Interface, we install the corresponding collection script: `ID:guance_azure_network_interface`.

After clicking [Install], enter the corresponding parameters:

- `Azure Tenant ID`: Tenant ID
- `Azure Client ID`: Application registration Client ID
- `Azure Client Secret Value`: Client secret value, note that it is not the ID
- `Subscriptions`: Subscription ID, separate multiple subscriptions with a comma

Click [Deploy Startup Script], and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click [Execute] to execute it immediately without waiting for the regular time. Wait a moment, and you can view the execution task records and corresponding logs.

### Verify

1. In 「Management / Automatic Trigger Configuration」, confirm that the corresponding task has an automatic trigger configuration. You can also check the task records and logs for any anomalies.
2. On the Guance Cloud platform, under 「Infrastructure - Resource Catalog」, check if asset information exists.
3. On the Guance Cloud platform, under 「Metrics」, check if the corresponding monitoring data is available.

## Metrics {#metric}

Collect Azure Network Interfaces metrics. You can collect more metrics through configuration [Supported metrics for Microsoft.Network/networkinterfaces](https://learn.microsoft.com/zh-cn/azure/azure-monitor/reference/supported-metrics/microsoft-network-networkinterfaces-metrics){:target="_blank"}

| Metric Name | Description | Unit |
| ---- | ------ | ------ |
|`BytesReceivedRate`| Number of bytes received | byte|
|`BytesSentRate`| Number of bytes sent | byte |
|`CreationRateMaxTotalFlowsIn`| Maximum creation rate of inbound flows | count |
|`CreationRateMaxTotalFlowsOut`| Maximum creation rate of outbound flows | count/s |
|`CurrentTotalFlowsIn`| Inbound flows | count |
|`CurrentTotalFlowsOut`| Outbound flows | count |
|`PacketsReceivedRate`| Number of packets received | count |
|`PacketsSentRate`| Number of packets sent | count |
