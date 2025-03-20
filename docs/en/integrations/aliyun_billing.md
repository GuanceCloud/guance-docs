---
title: 'Alibaba Cloud Bill'
tags: 
  - Alibaba Cloud
summary: 'Collecting Alibaba Cloud bill information'
__int_icon: 'icon/aliyun_billing'
dashboard:
  - desc: 'Cloud bill analysis view'
    path: 'dashboard/en/Intelligent_analysis_cloud_billing/'

cloudCollector:
  desc: 'cloud collector'
  path: 'cloud-collector/en/aliyun_billing'
---

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize monitoring data of cloud resources from CDN, we install the corresponding collection script ID: `guance_aliyun_billing_by_instance`

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK and Alibaba Cloud account name.

Click 【Deploy Start Script】, and the system will automatically create a `Startup` script set, and automatically configure the corresponding start script.

After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to immediately execute once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

### Verification

On the Guance platform, check under the menu 「Cloud Bill」 to see if there is corresponding cloud bill data.