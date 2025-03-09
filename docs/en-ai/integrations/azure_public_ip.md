---
title: 'Azure Public IP Address'
tags:
  - 'AZURE'
  - 'Network'
summary: 'Collect Azure Public IP Address Metrics data'
__int_icon: 'icon/azure_public_ip'
dashboard:
  - desc: 'Azure Public IP Address monitoring view'
    path: 'dashboard/en/azure_public_ip'
monitor:
  - desc: 'Not available yet'
    path: '-'
---

<!-- markdownlint-disable MD025 -->
# Azure Public IP Address
<!-- markdownlint-enable -->

Collect Azure Public IP Address Metrics data.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - Extensions - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> We recommend deploying the GSE version

### Install Script

> Note: Please prepare the required Azure application registration information in advance and assign the `Monitoring Reader` role to the application registration.

To synchronize Azure Public IP Address monitoring data, we install the corresponding collection script: 「Guance Integration (Azure-Network Public IP Address Collection)」(ID: `guance_azure_network_public_ip_address`)

After clicking 【Install】, enter the corresponding parameters:

- `Azure Tenant ID`: Tenant ID
- `Azure Client ID`: Application Registration Client ID
- `Azure Client Secret Value`: Client secret value, not the ID
- `Subscriptions`: Subscription ID, multiple subscriptions separated by `,`

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.

We have configured some defaults; for details, see the Metrics section.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-azure-vm/){:target="_blank"}

### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm that the corresponding tasks have the automatic trigger configurations, and check the task records and logs for any anomalies.
2. In the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. In the Guance platform, under 「Metrics」, check if the corresponding monitoring data is present.

## Metrics {#metric}

After configuring Azure Public IP Address monitoring data, the default metric set is as follows. You can collect more metrics through configuration [Microsoft.Network/publicIPAddresses supported metrics](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-publicipaddresses-metrics){:target="_blank"}

| Metric Name | Description | Unit |
| ---- | ------ | ------ |
| `byte_count_total` | Total bytes transmitted during the period | byte |
| `packet_count_total` | Total packets transmitted during the period | count |
| `syn_count_total` | Total SYN packets transmitted during the period | count |
| `vip_availability_average` | Average availability of the IP address for each duration | count |