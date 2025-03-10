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

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you choose to deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Ensure that you have an Amazon AK that meets the requirements (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize AWS billing collection monitoring data, install the corresponding collection script: 「Guance Integration (AWS-Billing Collection-Instance Dimension)」(ID: `guance_aws_billing_by_instance`)

After clicking 【Install】, enter the required parameters: Amazon AK, Amazon account name, and Area.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Additionally, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.


### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding task has the automatic trigger configuration, and check the task records and logs for any anomalies.
2. In the Guance platform, under 「Cloud Billing / Billing Analysis」, check if the corresponding billing information exists.