---
title: 'Alibaba Cloud Billing'
tags: 
  - Alibaba Cloud
summary: 'Collect Alibaba Cloud billing information'
__int_icon: 'icon/aliyun_billing'
dashboard:
  - desc: 'Cloud Billing Analysis View'
    path: 'dashboard/en/Intelligent_analysis_cloud_billing/'

---

## Configuration {#config}

### Install Func

It is recommended to activate Observability Cloud Integration - Extensions - Managed Func: All prerequisites are automatically installed. Please proceed with the script installation.

If you are deploying Func on your own, refer to [Self-Deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation Script

> Note: Please prepare the required Alibaba Cloud AK in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize monitoring data of CDN cloud resources, install the corresponding collection script ID: `guance_aliyun_billing_by_instance`

Click [Install], then input the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click [Deploy and Start Script], the system will automatically create a `Startup` script set and configure the corresponding startup script automatically.

After enabling, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click [Execute] to run it immediately without waiting for the scheduled time. After a moment, you can view the execution task records and corresponding logs.


### Verification

In the Observability Cloud platform, check if there is corresponding cloud billing data in the "Cloud Billing" menu.
