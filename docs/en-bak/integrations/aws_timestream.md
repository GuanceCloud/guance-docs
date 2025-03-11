---
title: 'AWS Timestream'
tags: 
  - AWS
summary: 'AWS Timestream displays the metrics include the number of system errors (internal service errors), the total number of invalid requests for the current AWS region and the current AWS account, the time elapsed for successful requests and the number of samples, the amount of data stored in memory, and the amount of data stored in magnetic storage.'
__int_icon: 'icon/aws_timestream'
dashboard:

  - desc: 'AWS Timestream dashboard'
    path: 'dashboard/en/aws_timestream'

monitor:
  - desc: 'AWS Timestream monitor'
    path: 'monitor/en/aws_timestream'

---

<!-- markdownlint-disable MD025 -->
# AWS `Timestream`
<!-- markdownlint-enable -->

AWS `Timestream` displays the metrics include the number of system errors (internal service errors), the total number of invalid requests for the current AWS region and the current AWS account, the time elapsed for successful requests and the number of samples, the amount of data stored in memory, and the amount of data stored in magnetic storage.

## Config {#config}

### Install Func

Recommend opening [ Integrations - Extension - DataFlux Func (Automata) ]: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip: Please prepare AWS AK that meets the requirements in advance (For simplicity's sake, you can directly grant the global read-only permission for CloudWatch `CloudWatchReadOnlyAccess`)

To synchronize the monitoring data of AWS `Timestream` cloud resources, we install the corresponding collection script: `ID:guance_aws_timestream`

Click [Install] and enter the corresponding parameters: Alibaba Cloud AK ID, Alibaba Cloud AK SECRET and Account Name.

Tap [Deploy startup Script],The system automatically creates `Startup` script sets,And automatically configure the corresponding startup script.

Then, in the collection script, add the collector_configs and cloudwatch_change the regions in configs to the actual regions

After this function is enabled, you can view the automatic triggering configuration in [Management / Crontab Config]. Click[Run],you can immediately execute once, without waiting for a regular time. After a while, you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verify

1. In [ Management / Crontab Config ] check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click [ Infrastructure / Custom ] to check whether asset information exists
3. On the Guance platform, press [ Metrics ] to check whether monitoring data exists

## Metric {#metric}

After configure AWS Simple Queue Service monitoring, the default metric set is as follows. You can collect more metrics by configuring them:

[Available CloudWatch metrics for AWS `Timestream`](https://docs.aws.amazon.com/timestream/latest/developerguide/metrics-dimensions.html){:target="_blank"}


| Metric | Description | Units | Valid Statistics |
| :---: | :---: | :---: | :---: |
| `SystemErrors` | The requests to `Timestream` that generate a SystemError during the specified time period. A SystemError usually indicates an internal service error. | Count | Sum, SampleCount |
| `UserErrors` | Requests to `Timestream` that generate an InvalidRequest error during the specified time period. An InvalidRequest usually indicates a client-side error, such as an invalid combination of parameters, an attempt to update a nonexistent table, or an incorrect request signature. UserErrors represents the aggregate of invalid requests for the current AWS Region and the current AWS account. | Count | Sum, SampleCount |
| `SuccessfulRequestLatency` | The successful requests to `Timestream` during the specified time period.  SuccessfulRequestLatency can provide two different kinds of information: The elapsed time for successful requests (Minimum, Maximum,Sum, or Average). The number of successful requests (SampleCount). SuccessfulRequestLatency reflects activity only within `Timestream` and does not take into account network latency or client-side activity. | Milliseconds | Average, Minimum, Maximum, Sum, SampleCount |
| `MemoryCumulativeBytesMetered` | The amount of data stored in memory store, in bytes. | Bytes | Average |
| `MagneticCumulativeBytesMetered`| The amount of data stored in magnetic store, in bytes. | Bytes | Average |

