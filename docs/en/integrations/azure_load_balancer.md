---
title: 'Azure Load Balancer'
tags: 
  - 'AZURE'
summary: 'Collect Azure Load Balancer Metrics data'
__int_icon: 'icon/azure_load_balancer'
dashboard:
  - desc: 'Azure Load Balancer monitoring view'
    path: 'dashboard/en/azure_load_balancer'
monitor   :
  - desc  : 'Azure Load Balancer detection library'
    path  : 'monitor/en/azure_load_balancer'
---

Collect Azure Load Balancer Metrics data

## Configuration {#config}

### Install Func

We recommend enabling the <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare the required Azure application registration information in advance and assign the `Monitoring Reader` role to the application registration.

To synchronize the monitoring data of Azure Load Balancer, we install the corresponding collection script: 「Integration (Azure-Load Balancer Collection)」(ID: `guance_azure_load_balancer`)

After clicking 【Install】, enter the corresponding parameters:

- `Azure Tenant ID`: Tenant ID
- `Azure Client ID`: Application registration Client ID
- `Azure Client Secret Value`: Client secret value, note that it is not the ID
- `Subscriptions`: Subscription ID, multiple subscriptions are separated by `,`

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to immediately execute once without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.

### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding task has the corresponding automatic trigger configuration, and at the same time, you can check the corresponding task records and logs to see if there are any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, in 「Infrastructure - Resource Catalog」, check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, in 「Metrics」check if there is corresponding monitoring data.

## Metrics {#metric}

Collect Azure Load Balancer Metrics, more metrics can be collected through configuration [Microsoft.Network/loadBalancers supported metrics](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-loadbalancers-metrics){:target="_blank"}

| Metric Name | Description | Unit |
| ---- | ------ | ------ |
|`byte_count_total`| Total number of bytes transferred within the time period | byte|
|`packet_count_total`| Total number of packets transferred within the time period| count |
|`syncount_total`| Total number of SYN packets transferred within the time period| count |
|`vip_availability_average`| Average availability of IP addresses for each duration | % |
|`dip_availability_average`| Average availability of dedicated IPs| % |