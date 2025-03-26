---
title: 'Alibaba Cloud Billing'
tags: 
  - Alibaba Cloud
summary: 'Collecting Alibaba Cloud billing information'
__int_icon: 'icon/aliyun_billing'
dashboard:
  - desc: 'Cloud Billing Analysis View'
    path: 'dashboard/en/Intelligent_analysis_cloud_billing/'

cloudCollector:
  desc: 'cloud collector'
  path: 'cloud-collector/en/aliyun_billing'
---

## Configuration {#config}

### Install Func

It is recommended to enable the <<< custom_key.brand_name >>> integration - extension - managed Func: all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-hosted Func Deployment](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Enable Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

#### Enable Managed Script

1. Log in to the <<< custom_key.brand_name >>> console.
2. Click on the 【Manage】 menu and select 【Cloud Account Management】.
3. Click 【Add Cloud Account】, select 【Alibaba Cloud】, and fill in the required information on the interface. If the cloud account information has been configured before, skip this step.
4. Click 【Test】. After a successful test, click 【Save】. If the test fails, check whether the configuration information is correct and retest.
5. In the 【Cloud Account Management】 list, you can see the added cloud accounts. Click on the corresponding cloud account to enter the details page.
6. Click the 【Integration】 button on the cloud account details page. In the `Not Installed` list, find `Alibaba Cloud Billing`, click the 【Install】 button, and follow the installation interface to complete the installation.

#### Manually Enable Script

1. Log in to the Func console, click 【Script Market】, enter the official script market, and search for `guance_aliyun_billing_by_instance`.

2. After clicking 【Install】, input the corresponding parameters: Alibaba Cloud AK ID, AK Secret, and account name.

3. Click 【Deploy Start Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding start script.

4. After enabling, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

### Verification

In <<< custom_key.brand_name >>>, go to the 「Cloud Billing」 menu to check if there is corresponding cloud billing data.
