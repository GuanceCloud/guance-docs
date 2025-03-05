---
title: 'Azure Public Ip Address'
tags:
  - 'AZURE'
summary: 'Collect Azure Public Ip Address metric data'
__int_icon: 'icon/azure_public_ip'
dashboard:
  - desc: 'Azure Public Ip Address'
    path: 'dashboard/en/azure_public_ip'
monitor   :
  - desc  : 'Azure Public Ip Address'
    path  : 'monitor/en/azure_public_ip'
---

<!-- markdownlint-disable MD025 -->
# Azure Public Ip Address
<!-- markdownlint-enable -->

Collect Azure Public Ip Address metric data.

## Config {#config}

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> Recommend deploying GSE (Game Server Engine) edition translation.

### Installation script


> Tip: Please prepare the required Azure application registration information in advance and assign the role of subscribing to `Monitoring Reader` to the application registration

To synchronize the monitoring data of Azure Virtual Machines resources, we install the corresponding collection script: `ID:guance_azure_network_public_ip_address`


After clicking on **Install**, enter the corresponding parameters:

- `Azure Tenant ID`: Tenant ID
- `Azure Client ID`: Application Registration Client ID
- `Azure Client Secret Value`: Client password value, note not ID
- `Subscriptions`: subscription ID, multiple subscriptions used `,` split


tap **Deploy startup Script**，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in "**Management / Crontab Config**". Click "**Run**"，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-azure-network-public-ip-address/){:target="_blank"}



### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure Azure Virtual Machines monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Microsoft.Network/publicIPAddresses](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-publicipaddresses-metrics){:target="_blank"}

| Metric Name | Description| Unit |
| ---- | ------ | ------ |
|`byte_count_total`| Total number of Bytes transmitted within time period | byte|
|`packet_count_total`| Total number of Packets transmitted within time period| count |
|`syn_count_total`| Total number of SYN Packets transmitted within time period | count |
|`vip_availability_average`| Average IP Address availability per time duration | count |

