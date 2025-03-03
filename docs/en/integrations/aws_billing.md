---
title: 'AWS Cloud Billing'
tags: 
  - AWS
summary: 'Collecting AWS cloud billing information'
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

It is recommended to enable the managed version of Guance Integration - Extension - Func: all prerequisites are automatically installed. Please proceed with script installation.

If you choose to deploy Func on your own, please refer to [Self-hosted Func Deployment](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

To synchronize AWS billing monitoring data, we will install the corresponding collection script:  ID: `guance_aws_billing_by_instance`

After clicking 【Install】, enter the corresponding parameters: Amazon AK, Amazon account name, Area.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a while, you can view the execution task records and corresponding logs.


### Verification

1. In 「Management / Automatic Trigger Configuration」confirm whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any abnormalities.
2. On the Guance platform, in 「Cloud Billing / Billing Analysis」check if there is corresponding billing information.
