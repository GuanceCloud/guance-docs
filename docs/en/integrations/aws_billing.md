---
title: 'AWS Cloud Billing'
tags: 
  - AWS
summary: 'Collect AWS cloud billing information'
__int_icon: 'icon/aws'
dashboard:
  - desc: 'Cloud billing analysis view'
    path: 'dashboard/en/Intelligent_analysis_cloud_billing/'

cloudCollector:
  desc: 'cloud collector'
  path: 'cloud-collector/en/aws_billing'
---

## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata)

If you deploy Func by yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Enable Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

#### Enable Script for Managed Version

1. Log in to the <<< custom_key.brand_name >>> console
2. Click on the 【Manage】 menu and select 【Cloud Account Management】
3. Click 【Add Cloud Account】, choose 【AWS】, and fill in the required information on the interface; if the cloud account information has been configured before, skip this step
4. Click 【Test】, after a successful test click 【Save】; if the test fails, check whether the relevant configuration information is correct and retest
5. On the 【Cloud Account Management】 list, you can see the added cloud accounts, click the corresponding cloud account to enter the details page
6. Click the 【Integration】 button on the cloud account details page, find `AWS Cloud Billing` under the `Not Installed` list, click the 【Install】 button, and follow the installation interface to install.


#### Manually Enable Script

1. Log in to the Func console, click 【Script Market】, go to the official script market, and search for `guance_aws_billing_by_instance`

2. After clicking 【Install】, input the corresponding parameters: AWS AK ID, AK Secret, and account name.

3. Click 【Deploy Start Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding start script.

4. After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to immediately run once without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.


### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding task has an automatic trigger configuration, and at the same time, you can check the corresponding task records and logs to verify for any anomalies.
2. In <<< custom_key.brand_name >>>, under 「Cloud Billing / Billing Analysis」, check if the corresponding billing information exists.