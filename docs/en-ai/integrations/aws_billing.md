---
title: 'AWS Cloud Billing'
tags: 
  - AWS
summary: 'Collect AWS cloud billing information'
__int_icon: 'icon/aws'
dashboard:
  - desc: 'Cloud billing analysis view'
    path: 'dashboard/en/Intelligent_analysis_cloud_billing/'
---

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you choose to deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize AWS billing monitoring data, we install the corresponding collection script: 「Guance integration (AWS-billing collection-instance dimension)」(ID: `guance_aws_billing_by_instance`)

After clicking 【Install】, enter the corresponding parameters: Amazon AK, Amazon account name, Area.

Click 【Deploy startup script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Additionally, you can see the corresponding automatic trigger configuration in 「Manage / Automatic trigger configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.


### Verification

1. In 「Manage / Automatic trigger configuration」confirm whether the corresponding task has the corresponding automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, in 「Cloud billing / Billing analysis」check if the corresponding billing information exists.