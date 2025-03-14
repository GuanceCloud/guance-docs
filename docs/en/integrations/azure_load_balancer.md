---
title: 'Azure Load Balancer'
tags: 
  - 'AZURE'
summary: 'Collect Azure Load Balancer metric data'
__int_icon: 'icon/azure_load_balancer'
dashboard:
  - desc: 'Azure Load Balancer monitoring view'
    path: 'dashboard/en/azure_load_balancer'
monitor   :
  - desc  : 'Azure Load Balancer detection library'
    path  : 'monitor/en/azure_load_balancer'
---

Collect Azure Load Balancer metric data

## Configuration {#config}

### Install Func

We recommend using the managed version of Func from Guance Cloud Integration Extensions: all prerequisites are automatically installed. Please proceed with the script installation.

If you choose to deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation Script

> Note: Ensure you have prepared the required Azure application registration information and assigned the `Monitoring Reader` role to the application registration.

To synchronize Azure Load Balancer monitoring data, install the corresponding collection script: `ID:guance_azure_load_balancer`

After clicking 【Install】, enter the following parameters:

- `Azure Tenant ID`: Tenant ID
- `Azure Client ID`: Application Registration Client ID
- `Azure Client Secret Value`: Client secret value, not the ID
- `Subscriptions`: Subscription ID; use `,` to separate multiple subscriptions

Click 【Deploy Startup Script】. The system will automatically create a `Startup` script set and configure the necessary startup scripts.

Once enabled, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short while, you can check the execution task records and logs.

### Verify

1. In 「Management / Automatic Trigger Configuration」, confirm that the corresponding task has an automatic trigger configuration. You can also check the task records and logs for any anomalies.
2. On the Guance Cloud platform, under 「Infrastructure - Resource Catalog」, check if asset information exists.
3. On the Guance Cloud platform, under 「Metrics」, check if the corresponding monitoring data is available.

## Metric {#metric}

Azure Load Balancer metrics can be collected through configuration. For more metrics supported by [Microsoft.Network/loadBalancers](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-loadbalancers-metrics){:target="_blank"}, please refer to the official documentation.

| Metric Name | Description | Unit |
| ---- | ------ | ------ |
|`byte_count_total`| Total bytes transferred during the period | byte|
|`packet_count_total`| Total packets transferred during the period | count |
|`syncount_total`| Total SYN packets transferred during the period | count |
|`vip_availability_average`| Average availability of IP addresses over each duration | % |
|`dip_availability_average`| Average availability of dedicated IPs | % |
