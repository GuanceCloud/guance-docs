---
title: 'Azure Public IP Address'
tags:
  - 'AZURE'
  - 'Network'
summary: 'Collect metrics data for Azure Public IP Address'
__int_icon: 'icon/azure_public_ip'
dashboard:
  - desc: 'Azure Public IP Address monitoring view'
    path: 'dashboard/en/azure_public_ip'
monitor:
  - desc: 'Not available'
    path: '-'
---

<!-- markdownlint-disable MD025 -->
# Azure Public IP Address
<!-- markdownlint-enable -->

Collect metrics data for Azure Public IP Address.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> We recommend deploying the GSE version.

### Install Script

> Note: Please prepare the required Azure application registration information in advance and assign the `Monitoring Reader` role to the application registration.

To synchronize Azure Public IP Address monitoring data, we install the corresponding collection script: 「Guance Integration (Azure-Network Public IP Address Collection)」(ID: `guance_azure_network_public_ip_address`)

After clicking 【Install】, enter the corresponding parameters:

- `Azure Tenant ID`: Tenant ID
- `Azure Client ID`: Application Registration Client ID
- `Azure Client Secret Value`: Client secret value, not the ID
- `Subscriptions`: Subscription ID; multiple subscriptions should be separated by `,`

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Once enabled, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations; for more details, see the Metrics section.

[Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-azure-vm/){:target="_blank"}

### Verification

1. In 「Management / Automatic Trigger Configuration」confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and check the task records and logs for any abnormalities.
2. On the Guance platform, under 「Infrastructure / Custom」check if asset information exists.
3. On the Guance platform, under 「Metrics」check if there is corresponding monitoring data.

## Metrics {#metric}

After configuring Azure Public IP Address monitoring data, the default metric set is as follows. You can collect more metrics through configuration [Supported metrics for Microsoft.Network/publicIPAddresses](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-publicipaddresses-metrics){:target="_blank"}

| Metric Name | Description | Unit |
| ---- | ------ | ------ |
|`byte_count_total`| Total bytes transmitted during the period | byte|
|`packet_count_total`| Total packets transmitted during the period | count |
|`syn_count_total`| Total SYN packets transmitted during the period | count |
|`vip_availability_average`| Average availability of the IP address for each duration | count |