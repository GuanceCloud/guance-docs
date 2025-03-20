---
title: 'AWS EC2'
tags: 
  - AWS
summary: 'Use script market "Guance cloud sync" series script packages to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/aws_ec2'
dashboard:

  - desc: 'AWS EC2 built-in view'
    path: 'dashboard/en/aws_ec2'

monitor:
  - desc: 'AWS EC2 monitor'
    path: 'monitor/en/aws_ec2'

cloudCollector:
  desc: 'Cloud collector'
  path: 'cloud-collector/en/aws_ec2'
---


<!-- markdownlint-disable MD025 -->
# AWS EC2
<!-- markdownlint-enable -->

Use script market "Guance cloud sync" series script packages to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable Guance integration - extension - DataFlux Func (Automata): all prerequisites will be automatically installed, please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare the required Amazon AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize EC2 cloud resource monitoring data, we install the corresponding collection script: "Guance Integration (AWS EC2 Collection)" (ID: `guance_aws_ec2`)

After clicking 【Install】, enter the corresponding parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the scheduled time. After a while, you can check the execution task records and corresponding logs.

We default to collecting some configurations, for details see Metrics section [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration, and at the same time, you can view the corresponding task records and logs to check for any abnormalities.
2. On the Guance platform, in "Infrastructure / Custom", check if there are any asset information.
3. On the Guance platform, in "Metrics", check if there are any corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric sets are as follows, more metrics can be collected through configuration [Amazon CloudWatch Metric Details](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/viewing_metrics_with_cloudwatch.html){:target="_blank"}

> Note: If memory or disk does not report metrics, go to the aws console to manually enable collection.

### Instance Metrics

The `AWS/EC2` namespace includes the following instance metrics.

| Metrics                    | Description                                                         |
| :---------------------- | :----------------------------------------------------------- |
| `CPUUtilization`    | The percentage of physical CPU time used by Amazon EC2 to run EC2 instances, including time spent running user code and Amazon EC2 code. At a high level, `CPUUtilization` is the sum of guest `CPUUtilization` and hypervisor `CPUUtilization`. Due to factors such as legacy device emulation, non-legacy device configurations, interrupt-intensive workloads, live migrations, and live updates, the percentages displayed in the operating system's tools may differ from those in CloudWatch. Unit: Percentage |
| `DiskReadOps`       | The number of read operations completed on all instance store volumes available to the instance during the specified time period. To calculate the average I/O operations per second (IOPS) for this period, divide the total number of operations for this period by the total number of seconds. If there are no instance store volumes, the value is 0 or the metric is not reported. Unit: Count |
| `DiskWriteOps`      | The number of write operations completed on all instance store volumes available to the instance during the specified time period. To calculate the average I/O operations per second (IOPS) for this period, divide the total number of operations for this period by the total number of seconds. If there are no instance store volumes, the value is 0 or the metric is not reported. Unit: Count |
| `DiskReadBytes`     | The number of bytes read from all instance store volumes available to the instance. This metric determines how much data the application reads from the instance's hard drive. It can be used to determine the speed of the application. The reported amount is the number of bytes received during the period. If you are using basic (5-minute) monitoring, you can divide this number by 300 to get bytes/second. If you use detailed (1-minute) monitoring, divide it by 60. You can also use the CloudWatch metric math function `DIFF_TIME` to find the number of bytes per second. For example, if you plot `DiskReadBytes` as `m1` in CloudWatch, the metric math formula `m1/(DIFF_TIME(m1))` returns the metric in bytes/second. For more information about `DIFF_TIME` and other metric math functions, see [Using Metric Math](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html){:target="_blank"} in the Amazon CloudWatch User Guide. If there are no instance store volumes, the value is 0 or the metric is not reported. Unit: Bytes |
| `DiskWriteBytes`    | The number of bytes written to all instance store volumes available to the instance. This metric determines how much data the application writes to the instance's hard drive. It can be used to determine the speed of the application. The reported amount is the number of bytes received during the period. If you are using basic (5-minute) monitoring, you can divide this number by 300 to get bytes/second. If you use detailed (1-minute) monitoring, divide it by 60. You can also use the CloudWatch metric math function `DIFF_TIME` to find the number of bytes per second. For example, if you plot `DiskWriteBytes` as `m1` in CloudWatch, the metric math formula `m1/(DIFF_TIME(m1))` returns the metric in bytes/second. For more information about `DIFF_TIME` and other metric math functions, see [Using Metric Math](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html){:target="_blank"} in the Amazon CloudWatch User Guide. If there are no instance store volumes, the value is 0 or the metric is not reported. Unit: Bytes |
| `MetadataNoToken`   | The number of successful accesses to the instance metadata service without a token. This metric is used to determine if any process is accessing the instance metadata using Instance Metadata Service Version 1 but not using a token. If all requests use a token-enabled session (i.e., Instance Metadata Service Version 2), then the value is 0. For more information, see [Transitioning to Using Instance Metadata Service Version 2](https://docs.aws.amazon.com/zh_cn/AWSEC2/latest/UserGuide/instance-metadata-transition-to-version-2.html){:target="_blank"}. Unit: Count |
| `NetworkIn`         | The number of bytes received by the instance on all network interfaces. This metric determines the incoming network traffic flowing to a single instance. The reported amount is the number of bytes received during the period. If you are using basic (5-minute) monitoring and the statistic is Sum, you can divide this number by 300 to get bytes/second. If you use detailed (1-minute) monitoring and the statistic is Sum, divide it by 60. You can also use the CloudWatch metric math function `DIFF_TIME` to find the number of bytes per second. For example, if you plot `NetworkIn` as `m1` in CloudWatch, the metric math formula `m1/(DIFF_TIME(m1))` returns the metric in bytes/second. For more information about `DIFF_TIME` and other metric math functions, see [Using Metric Math](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html){:target="_blank"} in the Amazon CloudWatch User Guide. Unit: Bytes |
| `NetworkOut`        | The number of bytes sent by the instance on all network interfaces. This metric determines the outgoing network traffic from a single instance. The reported amount is the number of bytes sent during the period. If you are using basic (5-minute) monitoring and the statistic is Sum, you can divide this number by 300 to get bytes/second. If you use detailed (1-minute) monitoring and the statistic is Sum, divide it by 60. You can also use the CloudWatch metric math function `DIFF_TIME` to find the number of bytes per second. For example, if you plot `NetworkOut` as `m1` in CloudWatch, the metric math formula `m1/(DIFF_TIME(m1))` returns the metric in bytes/second. For more information about `DIFF_TIME` and other metric math functions, see [Using Metric Math](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html){:target="_blank"} in the Amazon CloudWatch User Guide. Unit: Bytes |
| `NetworkPacketsIn`  | The number of packets received by the instance on all network interfaces. This metric identifies the volume of incoming traffic based on the number of packets on a single instance. This metric is only available for basic monitoring (5-minute periods). To calculate the number of packets per second (PPS) received by the instance in 5 minutes, divide the Sum statistic by 300. You can also use the CloudWatch metric math function `DIFF_TIME` to find the number of packets per second. For example, if you plot `NetworkPacketsIn` as `m1` in CloudWatch, the metric math formula `m1/(DIFF_TIME(m1))` returns the metric in packets/second. For more information about `DIFF_TIME` and other metric math functions, see [Using Metric Math](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html){:target="_blank"} in the Amazon CloudWatch User Guide. Unit: Count |
| `NetworkPacketsOut` | The number of packets sent by the instance on all network interfaces. This metric identifies the volume of outgoing traffic based on the number of packets on a single instance. This metric is only available for basic monitoring (5-minute periods). To calculate the number of packets per second (PPS) sent by the instance in 5 minutes, divide the Sum statistic by 300. You can also use the CloudWatch metric math function `DIFF_TIME` to find the number of packets per second. For example, if you plot `NetworkPacketsOut` as `m1` in CloudWatch, the metric math formula `m1/(DIFF_TIME(m1))` returns the metric in packets/second. For more information about `DIFF_TIME` and other metric math functions, see [Using Metric Math](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html){:target="_blank"} in the Amazon CloudWatch User Guide. Unit: Count |

### CPU Metrics

The `AWS/EC2` namespace includes the following CPU credit metrics for [burstable performance instances](https://docs.aws.amazon.com/zh_cn/AWSEC2/latest/UserGuide/burstable-performance-instances.html){:target="_blank"}.

| Metrics                           | Description                                                         |
| :----------------------------- | :----------------------------------------------------------- |
| `CPUCreditUsage`           | The number of CPU credits spent by the instance to maintain CPU usage. One CPU credit equals one vCPU running at 100% utilization for one minute, or an equivalent combination of vCPU, utilization, and time (for example, one vCPU running at 50% utilization for two minutes, or two vCPUs running at 25% utilization for two minutes). CPU credit metrics are only provided every five minutes. If you specify a time period greater than five minutes, use the `Sum` statistic rather than the `Average` statistic. Unit: Credits (vCPU minutes) |
| `CPUCreditBalance`         | The number of CPU credits that the instance has accumulated since it was launched. For T2 standard, `CPUCreditBalance` also includes accumulated launch credits. After earning credits, they accumulate in the credit balance; after spending credits, they are deducted from the credit balance. The credit balance has a maximum limit determined by the instance size. Any new credits earned after reaching the limit are discarded. T2 instances can spend credits from `CPUCreditBalance` to burst above the baseline CPU utilization. During the instance's operation, credits in `CPUCreditBalance` do not expire. When a T3 or T3a instance stops, the `CPUCreditBalance` value is retained for seven days. After that, all accumulated credits are lost. When a T2 instance stops, the `CPUCreditBalance` value is not retained, and all accumulated credits are lost. CPU credit metrics are only provided every five minutes. Unit: Credits (vCPU minutes) |
| `CPUSurplusCreditBalance`  | The number of surplus credits spent by the `CPUCreditBalance` instance when the `unlimited` value is zero. The `CPUSurplusCreditBalance` value is paid for by earned CPU credits. If the number of surplus credits exceeds the maximum number of credits the instance can earn in a 24-hour period, the excess spent surplus credits incur additional charges. CPU credit metrics are only provided every five minutes. Unit: Credits (vCPU minutes) |
| `CPUSurplusCreditsCharged` | The number of surplus credits spent that were not paid for by earned CPU credits and incur additional charges. Charges are incurred for spent surplus credits under either of the following conditions: The spent surplus credits exceed the maximum number of credits the instance can earn in a 24-hour period. You are charged for the spent surplus credits exceeding the maximum at the end of the hour. The instance has stopped or terminated. The instance switches from `unlimited` to `standard`. CPU credit metrics are only provided every five minutes. Unit: Credits (vCPU minutes) |


### Status Check Metrics
The AWS/EC2 namespace includes the following status check metrics. By default, status check metrics are available for free at a frequency of one minute. For newly launched instances, status check metric data is only available after the instance completes initialization (within a few minutes of the instance entering the running state). For more information about EC2 status checks, see [Instance Status Checks](https://docs.aws.amazon.com/zh_cn/AWSEC2/latest/UserGuide/monitoring-system-instance-status-check.html){:target="_blank"}.
| Metrics                           | Description                                                         |
| :----------------------------- | :----------------------------------------------------------- |
|`StatusCheckFailed`|Reports whether the instance passed both the instance status check and the system status check in the previous minute. This metric can be 0 (passed) or 1 (failed). By default, this metric is available for free at a frequency of one minute. Unit: Count|
|`StatusCheckFailed_Instance`|Reports whether the instance passed the instance status check in the previous minute. This metric can be 0 (passed) or 1 (failed). By default, this metric is available for free at a frequency of one minute. Unit: Count|
|`StatusCheckFailed_System`|Reports whether the instance passed the system status check in the previous minute. This metric can be 0 (passed) or 1 (failed). By default, this metric is available for free at a frequency of one minute. Unit: Count|

## Objects {#object}

The structure of the AWS EC2 object data collected can be viewed in the "Infrastructure - Custom" section.

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
    "BlockDeviceMappings": "{Device JSON data}",
    "LaunchTime"         : "2021-10-26T07:00:44Z",
    "NetworkInterfaces"  : "{Network JSON data}",
    "Placement"          : "{Availability Zone JSON data}",
    "message"            : "{Instance JSON data}"
  }
}
```

> *Note: Fields in `tags`, `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, used as a unique identifier.
> Tip 2: `fields.message`, `fields.NetworkInterfaces`, `fields.BlockDeviceMappings` are serialized JSON strings.