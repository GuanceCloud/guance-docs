---
title: 'Azure Public IP Address'
tags:
  - 'AZURE'
  - 'NETWORK'
summary: 'Collect Azure Public IP Address Metrics data'
__int_icon: 'icon/azure_public_ip'
dashboard:
  - desc: 'Azure Public IP Address monitoring view'
    path: 'dashboard/en/azure_public_ip'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Azure Public IP Address
<!-- markdownlint-enable -->

Collect Azure Public IP Address Metrics data.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func manually, refer to [Manual Func Deployment](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> We recommend deploying the GSE version.

### Installation Script

> Note: Please prepare the required Azure application registration information in advance and assign the `Monitoring Reader` role to the application registration.

To synchronize Azure Public IP Address monitoring data, we install the corresponding collection script: 「Guance Integration (Azure-Network Public IP Address Collection)」(ID: `guance_azure_network_public_ip_address`)

After clicking 【Install】, enter the corresponding parameters:

- `Azure Tenant ID`: Tenant ID
- `Azure Client ID`: Application Registration Client ID
- `Azure Client Secret Value`: Client secret value, note that it is not the ID
- `Subscriptions`: Subscription ID, multiple subscriptions are separated by `,`

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After activation, you can see the corresponding automatic trigger configuration in the 「Manage / Automatic Trigger Configuration」section. Click 【Execute】to run immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

We default collect some configurations; for details, see the Metrics section.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-azure-vm/){:target="_blank"}

### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding tasks have the corresponding automatic trigger configuration, and check the corresponding task records and logs for any anomalies.
2. In the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. In the Guance platform, under 「Metrics」, check if there are corresponding monitoring data.

## Metrics {#metric}

After configuring Azure Public IP Address monitoring data, the default Metric set is as follows. You can collect more metrics through configuration [Microsoft.Network/publicIPAddresses supported metrics](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-publicipaddresses-metrics){:target="_blank"}

| Metric Name | Description| Unit |
| ---- | ------ | ------ |
|`byte_count_total`| Total number of bytes transmitted during the time period | byte|
|`packet_count_total`| Total number of packets transmitted during the time period| count |
|`syn_count_total`| Total number of SYN packets transmitted during the time period| count |
|`vip_availability_average`| Average availability of the IP address for each duration| count |