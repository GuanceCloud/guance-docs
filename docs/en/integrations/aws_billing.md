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

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize AWS-billing monitoring data, we install the corresponding collection script: 「Guance Integration (AWS-Billing Collection-Instance Dimension)」(ID: `guance_aws_billing_by_instance`)

After clicking 【Install】, enter the corresponding parameters: Amazon AK, Amazon account name, Area.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to immediately execute it once without waiting for the scheduled time. After a while, you can check the execution task records and corresponding logs.


### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding automatic trigger configuration exists for the corresponding task, and you can also check the corresponding task records and logs for any anomalies.
2. In the Guance platform, under 「Cloud Billing / Billing Analysis」, check if the corresponding billing information exists.