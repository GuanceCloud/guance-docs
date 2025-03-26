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

It is recommended to enable the <<< custom_key.brand_name >>> integration - extension - managed Func: all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-hosted Func Deployment](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Enable Script

> Note: Please prepare an AWS AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

#### Enable Managed Script

1. Log in to the <<< custom_key.brand_name >>> console.
2. Click on the 【Manage】 menu and select 【Cloud Account Management】.
3. Click 【Add Cloud Account】, select 【AWS】, and fill in the required information on the interface. If the cloud account information has been configured before, skip this step.
4. Click 【Test】. After a successful test, click 【Save】. If the test fails, check whether the configuration information is correct and retest.
5. In the 【Cloud Account Management】 list, you can see the added cloud accounts. Click on the corresponding cloud account to enter the details page.
6. Click the 【Integration】 button on the cloud account details page. In the `Not Installed` list, find `AWS Cloud Billing`, click the 【Install】 button, and follow the installation interface to complete the installation.

#### Manually Enable Script

1. Log in to the Func console, click 【Script Market】, enter the official script market, and search for `guance_aws_billing_by_instance`.

2. After clicking 【Install】, input the corresponding parameters: AWS AK ID, AK Secret, and account name.

3. Click 【Deploy Start Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding start script.

4. After enabling, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.


### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding automatic trigger configuration exists for the corresponding task, and you can also check the corresponding task records and logs for any anomalies.
2. In the <<< custom_key.brand_name >>> platform, under 「Cloud Billing / Billing Analysis」, check if the corresponding billing information exists.