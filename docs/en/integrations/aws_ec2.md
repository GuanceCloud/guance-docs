---
title: 'AWS EC2'
tags: 
  - AWS
summary: 'Use the script packages in the Script Market series "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/aws_ec2'
dashboard:

  - desc: 'Built-in views for AWS EC2'
    path: 'dashboard/en/aws_ec2'

monitor:
  - desc: 'AWS EC2 Monitor'
    path: 'monitor/en/aws_ec2'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_ec2'
---


<!-- markdownlint-disable MD025 -->
# AWS EC2
<!-- markdownlint-enable -->

Use the script packages in the Script Market series "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data of EC2 cloud resources, we install the corresponding collection script: "Guance Integration (AWS EC2 Collection)" (ID: `guance_aws_ec2`)

After clicking 【Install】, enter the corresponding parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup scripts automatically.

Additionally, you can see the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a while, you can view the execution task records and corresponding logs.

We default to collecting some configurations; for details, see [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」confirm whether the corresponding automatic trigger configuration exists for the task, and check the corresponding task records and logs for any anomalies.
2. On the Guance platform, under 「Infrastructure / Custom」check if asset information exists.
3. On the Guance platform, under 「Metrics」check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric set is as follows. You can collect more metrics through configuration [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/viewing_metrics_with_cloudwatch.html){:target="_blank"}

> Note: If you find no memory or disk metrics reported, go to the AWS console to manually enable collection.

### Instance Metrics

The `AWS/EC2` namespace includes the following instance metrics.

| Metric                    | Description                                                         |
| :---------------------- | :----------------------------------------------------------- |
| `CPUUtilization`    | The percentage of physical CPU time used by Amazon EC2 to run EC2 instances, including the time spent running user code and Amazon EC2 code. At a high level, `CPUUtilization` is the sum of guest `CPUUtilization` and hypervisor `CPUUtilization`. Due to factors such as legacy device emulation, non-legacy device configuration, interrupt-intensive workloads, live migration, and live updates, the percentage displayed by tools in the operating system may differ from CloudWatch. Unit: Percentage |
| `DiskReadOps`       | The number of read operations completed on all instance store volumes available to the instance during the specified time period. To calculate the average I/O operations per second (IOPS) for this period, divide the total number of operations by the total seconds. If there are no instance store volumes, the value is 0 or the metric is not reported. Unit: Count |
| `DiskWriteOps`      | The number of write operations completed on all instance store volumes available to the instance during the specified time period. To calculate the average I/O operations per second (IOPS) for this period, divide the total number of operations by the total seconds. If there are no instance store volumes, the value is 0 or the metric is not reported. Unit: Count |
| `DiskReadBytes`     | The number of bytes read from all instance store volumes available to the instance. This metric determines the amount of data the application reads from the instance's hard drive. It can be used to determine the speed of the application. The reported quantity is the number of bytes received during the period. For basic (5-minute) monitoring, you can divide this number by 300 to get bytes/second. For detailed (1-minute) monitoring, divide by 60. You can also use the CloudWatch metric math function `DIFF_TIME` to find bytes per second. For example, if you plot `DiskReadBytes` as `m1` in CloudWatch, the metric math formula `m1/(DIFF_TIME(m1))` returns the metric in bytes/second. For more information about `DIFF_TIME` and other metric math functions, see [Using Metric Math](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html){:target="_blank"} in the Amazon CloudWatch User Guide. If there are no instance store volumes, the value is 0 or the metric is not reported. Unit: Bytes |
| `DiskWriteBytes`    | The number of bytes written to all instance store volumes available to the instance. This metric determines the amount of data the application writes to the instance's hard drive. It can be used to determine the speed of the application. The reported quantity is the number of bytes received during the period. For basic (5-minute) monitoring, you can divide this number by 300 to get bytes/second. For detailed (1-minute) monitoring, divide by 60. You can also use the CloudWatch metric math function `DIFF_TIME` to find bytes per second. For example, if you plot `DiskWriteBytes` as `m1` in CloudWatch, the metric math formula `m1/(DIFF_TIME(m1))` returns the metric in bytes/second. For more information about `DIFF_TIME` and other metric math functions, see [Using Metric Math](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html){:target="_blank"} in the Amazon CloudWatch User Guide. If there are no instance store volumes, the value is 0 or the metric is not reported. Unit: Bytes |
| `MetadataNoToken`   | The number of successful accesses to the instance metadata service without a token. This metric is used to determine if any processes are using Instance Metadata Service Version 1 to access instance metadata without a token. If all requests use token-supported sessions (i.e., Instance Metadata Service Version 2), this value is 0. For more information, see [Transition to Using Instance Metadata Service Version 2](https://docs.aws.amazon.com/zh_cn/AWSEC2/latest/UserGuide/instance-metadata-transition-to-version-2.html){:target="_blank"}. Unit: Count |
| `NetworkIn`         | The number of bytes received by the instance on all network interfaces. This metric is used to determine incoming network traffic to a single instance. The reported quantity is the number of bytes received during the period. For basic (5-minute) monitoring and Sum statistics, you can divide this number by 300 to get bytes/second. For detailed (1-minute) monitoring and Sum statistics, divide by 60. You can also use the CloudWatch metric math function `DIFF_TIME` to find bytes per second. For example, if you plot `NetworkIn` as `m1` in CloudWatch, the metric math formula `m1/(DIFF_TIME(m1))` returns the metric in bytes/second. For more information about `DIFF_TIME` and other metric math functions, see [Using Metric Math](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html){:target="_blank"} in the Amazon CloudWatch User Guide. Unit: Bytes |
| `NetworkOut`        | The number of bytes sent by the instance on all network interfaces. This metric is used to determine outgoing network traffic from a single instance. The reported quantity is the number of bytes sent during the period. For basic (5-minute) monitoring and Sum statistics, you can divide this number by 300 to get bytes/second. For detailed (1-minute) monitoring and Sum statistics, divide by 60. You can also use the CloudWatch metric math function `DIFF_TIME` to find bytes per second. For example, if you plot `NetworkOut` as `m1` in CloudWatch, the metric math formula `m1/(DIFF_TIME(m1))` returns the metric in bytes/second. For more information about `DIFF_TIME` and other metric math functions, see [Using Metric Math](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html){:target="_blank"} in the Amazon CloudWatch User Guide. Unit: Bytes |
| `NetworkPacketsIn`  | The number of packets received by the instance on all network interfaces. This metric identifies the volume of incoming traffic based on the number of packets on a single instance. This metric is only available for basic monitoring (5-minute periods). To calculate the number of packets received per second (PPS) by the instance over 5 minutes, divide the Sum statistic by 300. You can also use the CloudWatch metric math function `DIFF_TIME` to find packets per second. For example, if you plot `NetworkPacketsIn` as `m1` in CloudWatch, the metric math formula `m1/(DIFF_TIME(m1))` returns the metric in packets/second. For more information about `DIFF_TIME` and other metric math functions, see [Using Metric Math](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html){:target="_blank"} in the Amazon CloudWatch User Guide. Unit: Count |
| `NetworkPacketsOut` | The number of packets sent by the instance on all network interfaces. This metric identifies the volume of outgoing traffic based on the number of packets on a single instance. This metric is only available for basic monitoring (5-minute periods). To calculate the number of packets sent per second (PPS) by the instance over 5 minutes, divide the Sum statistic by 300. You can also use the CloudWatch metric math function `DIFF_TIME` to find packets per second. For example, if you plot `NetworkPacketsOut` as `m1` in CloudWatch, the metric math formula `m1/(DIFF_TIME(m1))` returns the metric in packets/second. For more information about `DIFF_TIME` and other metric math functions, see [Using Metric Math](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html){:target="_blank"} in the Amazon CloudWatch User Guide. Unit: Count |

### CPU Metrics

The `AWS/EC2` namespace includes the following CPU credit metrics for [burstable performance instances](https://docs.aws.amazon.com/zh_cn/AWSEC2/latest/UserGuide/burstable-performance-instances.html){:target="_blank"}.

| Metric                           | Description                                                         |
| :----------------------------- | :----------------------------------------------------------- |
| `CPUCreditUsage`           | The number of CPU credits the instance spends to maintain CPU utilization. One CPU credit equals one vCPU running at 100% utilization for one minute, or an equivalent combination of vCPU, utilization, and time (e.g., one vCPU running at 50% utilization for two minutes, or two vCPUs running at 25% utilization for two minutes). CPU credit metrics are provided every 5 minutes. If you specify a time period greater than five minutes, use `Sum` statistics rather than `Average` statistics. Unit: Credits (vCPU minutes) |
| `CPUCreditBalance`         | The number of CPU credits accumulated by the instance since launch. For T2 standard, `CPUCreditBalance` also includes accumulated launch credits. Credits accumulate in the credit balance after they are earned and are deducted from the credit balance when spent. The credit balance has a maximum limit determined by the instance size. Once the limit is reached, any newly earned credits are discarded. For T2 standard, launch credits do not count toward the limit. The instance can spend `CPUCreditBalance` credits to burst above the baseline CPU utilization. During the instance's runtime, credits in `CPUCreditBalance` do not expire. When a T3 or T3a instance stops, the `CPUCreditBalance` value is retained for seven days. After that, all accumulated credits are lost. When a T2 instance stops, the `CPUCreditBalance` value is not retained, and all accumulated credits are lost. CPU credit metrics are provided every 5 minutes. Unit: Credits (vCPU minutes) |
| `CPUSurplusCreditBalance`  | The number of surplus credits spent by the instance when the `unlimited` value is zero. The `CPUSurplusCreditBalance` value is paid for by earned CPU credits. If surplus credits exceed the maximum number of credits the instance can earn in a 24-hour period, the excess spent surplus credits incur additional charges. CPU credit metrics are provided every 5 minutes. Unit: Credits (vCPU minutes) |
| `CPUSurplusCreditsCharged` | Unpaid surplus credits that incur additional charges. Charges are applied to spent surplus credits when either: The spent surplus credits exceed the maximum number of credits the instance can earn in a 24-hour period. Charges are applied at the end of the hour for surplus credits exceeding the maximum. The instance has stopped or terminated. The instance switches from `unlimited` to `standard`. CPU credit metrics are provided every 5 minutes. Unit: Credits (vCPU minutes) |


### Status Check Metrics
The `AWS/EC2` namespace includes the following status check metrics. By default, status check metrics are available at a frequency of 1 minute free of charge. For newly launched instances, status check metrics data is only available after the instance completes initialization (within a few minutes of entering the running state). For more information about EC2 status checks, see [Instance Status Checks](https://docs.aws.amazon.com/zh_cn/AWSEC2/latest/UserGuide/monitoring-system-instance-status-check.html){:target="_blank"}.
| Metric                           | Description                                                         |
| :----------------------------- | :----------------------------------------------------------- |
|`StatusCheckFailed`|Reports whether the instance passed both the instance status check and system status check in the last minute. This metric can be 0 (passed) or 1 (failed). By default, this metric is available at a frequency of 1 minute free of charge. Unit: Count|
|`StatusCheckFailed_Instance`|Reports whether the instance passed the instance status check in the last minute. This metric can be 0 (passed) or 1 (failed). By default, this metric is available at a frequency of 1 minute free of charge. Unit: Count|
|`StatusCheckFailed_System`|Reports whether the instance passed the system status check in the last minute. This metric can be 0 (passed) or 1 (failed). By default, this metric is available at a frequency of 1 minute free of charge. Unit: Count|

## Objects {#object}

Structure of AWS EC2 object data collected, which can be viewed under 「Infrastructure - Custom」

```json
{
  "measurement": "aws_ec2",
  "tags": {
    "name"           : "i-0d7620xxxxxxx",
    "InstanceId"     : "i-0d7620xxxxxxx",
    "InstanceType"   : "c6g.xlarge",
    "PlatformDetails": "Linux/UNIX",
    "RegionId"       : "cn-northwest-1",
    "InstanceName"   : "test",
    "State"          : "running",
    "StateReason_Code"   : "Client.UserInitiatedHibernate",
    "AvailabilityZone": "cn-northwest-1",
  },
  "fields": {
    "BlockDeviceMappings": "{device JSON data}",
    "LaunchTime"         : "2021-10-26T07:00:44Z",
    "NetworkInterfaces"  : "{network JSON data}",
    "Placement"          : "{availability zone JSON data}",
    "message"            : "{instance JSON data}"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates*
>
> Tip 1: `tags.name` value is the instance ID, used as unique identification
> Tip 2: `fields.message`, `fields.NetworkInterfaces`, `fields.BlockDeviceMappings` are JSON serialized strings