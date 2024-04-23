---
title: 'AWS MediaConvert'
tags: 
  - AWS
summary: 'AWS MediaConvert, including data transfer, video errors, job count, padding, etc.'
__int_icon: 'icon/aws_mediaconvert'
dashboard:

  - desc: 'AWS MediaConvert Monitoring View'
    path: 'dashboard/zh/aws_mediaconvert'

monitor:
  - desc: 'AWS MediaConvert Monitor'
    path: 'monitor/zh/aws_mediaconvert'

---

<!-- markdownlint-disable MD025 -->
# AWS MediaConvert
<!-- markdownlint-enable -->


AWS MediaConvert, including data transfer, video errors, job count, padding, etc.


## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare AWS AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of AWS MediaConvert, we install the corresponding collection script：「Guance Integration（AWS-MediaConvert Collect）」(ID：`guance_aws_mediaconvert`)

Click 【Install】 and enter the corresponding parameters: Aws AK, Aws account name.。

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure AWS MediaConvert. The default metric set is as follows. You can collect more metrics by configuring them [Aws Cloud Monitor Metrics Details](https://docs.amazonaws.cn/mediaconvert/latest/ug/what-is.html){:target="_blank"}



