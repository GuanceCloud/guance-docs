---
title: 'AWS EC2'
tags: 
  - AWS
summary: 'Use the script package series of 「<<< custom_key.brand_name >>> Cloud Sync」in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>'
__int_icon: 'icon/aws_ec2'
dashboard:

  - desc: 'AWS EC2 Built-in Views'
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

Use the script package series of 「<<< custom_key.brand_name >>> Cloud Sync」in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>


## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> Integration - Extension - Managed Func: All prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Enable Script

> Note: Please prepare an Alibaba Cloud AK in advance that meets the requirements (for simplicity, you can directly assign the global read-only permission `ReadOnlyAccess`).

#### Enable Script for Managed Version

1. Log in to <<< custom_key.brand_name >>> Console.
2. Click the 【Manage】 menu and select 【Cloud Account Management】.
3. Click 【Add Cloud Account】, select 【AWS】, and fill in the required information on the interface. If cloud account information has already been configured, skip this step.
4. Click 【Test】. After a successful test, click 【Save】. If the test fails, check whether the relevant configuration information is correct and retest.
5. In the 【Cloud Account Management】 list, you can see the added cloud accounts. Click the corresponding cloud account to enter the details page.
6. Click the 【Integration】 button on the cloud account details page. Under the `Not Installed` list, find `AWS EC2`, click the 【Install】 button, and install it via the pop-up installation interface.


#### Manually Enable Script

1. Log in to the Func Console, click 【Script Market】, enter the official script market, and search for: `guance_aws_ec2`.
2. After clicking 【Install】, input the corresponding parameters: AWS AK ID, AK Secret, and account name.
3. Click 【Deploy Start Script】, and the system will automatically create a `Startup` script set and configure the corresponding start scripts.
4. After enabling, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration. You can also check the corresponding task records and logs for any abnormalities.
2. In <<< custom_key.brand_name >>>, under "Infrastructure / Custom", check if there is asset information.
3. In <<< custom_key.brand_name >>>, under "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon-CloudWatch, the default metric sets are as follows. More metrics can be collected through configuration. [Amazon Cloud Monitoring Metrics Details](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/viewing_metrics_with_cloudwatch.html){:target="_blank"}

> Note: If you find that memory or disk metrics are not reported, go to the AWS console and manually enable collection.

### Instance Metrics

The `AWS/EC2` namespace includes the following instance metrics.

| Metric                    | Description                                                         |
| :---------------------- | :----------------------------------------------------------- |
| `CPUUtilization`    | The percentage of physical CPU time used by Amazon EC2 to run EC2 instances, including time spent running user code and Amazon EC2 code. At a high level, `CPUUtilization` is the sum of guest `CPUUtilization` and hypervisor `CPUUtilization`. Due to factors such as legacy device emulation, non-legacy device configurations, interrupt-intensive workloads, live migrations, and live updates, the percentage shown by tools in the operating system may differ from what is shown in CloudWatch. Unit: Percentage |
| `DiskReadOps`       | The number of read operations completed on all instance store volumes available to the instance during the specified time period. To calculate the average I/O operations per second (IOPS) for the period, divide the total number of operations for the period by the total number of seconds. If there are no instance store volumes, the value is 0 or the metric is not reported. Unit: Count |
| `DiskWriteOps`      | The number of write operations completed on all instance store volumes available to the instance during the specified time period. To calculate the average I/O operations per second (IOPS) for the period, divide the total number of operations for the period by the total number of seconds. If there are no instance store volumes, the value is 0 or the metric is not reported. Unit: Count |
| `DiskReadBytes`     | The number of bytes read from all instance store volumes available to the instance. This metric determines how much data the application reads from the instance's hard drive and can be used to determine the speed of the application. The reported amount is the number of bytes received during the period. If you use basic (5-minute) monitoring, you can divide this number by 300 to get bytes/second. If you use detailed (1-minute) monitoring, divide it by 60. You can also use the CloudWatch metric math function `DIFF_TIME` to find the number of bytes per second. For example, if you plot `DiskReadBytes` as `m1` in CloudWatch, the metric math formula `m1/(DIFF_TIME(m1))` returns the metric in bytes/second. For more information about `DIFF_TIME` and other metric math functions, see [Using Metric Math](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html){:target="_blank"} in the Amazon CloudWatch User Guide. If there are no instance store volumes, the value is 0 or the metric is not reported. Unit: Bytes |
| `DiskWriteBytes`    | The number of bytes written to all instance store volumes available to the instance. This metric determines how much data the application writes to the instance's hard drive and can be used to determine the speed of the application. The reported amount is the number of bytes received during the period. If you use basic (5-minute) monitoring, you can divide this number by 300 to get bytes/second. If you use detailed (1-minute) monitoring, divide it by 60. You can also use the CloudWatch metric math function `DIFF_TIME` to find the number of bytes per second. For example, if you plot `DiskWriteBytes` as `m1` in CloudWatch, the metric math formula `m1/(DIFF_TIME(m1))` returns the metric in bytes/second. For more information about `DIFF_TIME` and other metric math functions, see [Using Metric Math](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html){:target="_blank"} in the Amazon CloudWatch User Guide. If there are no instance store volumes, the value is 0 or the metric is not reported. Unit: Bytes |
| `MetadataNoToken`   | The number of successful accesses to the instance metadata service without a token. This metric is used to determine if any processes are accessing instance metadata using Instance Metadata Service version 1 without a token. If all requests use sessions that support tokens (i.e., Instance Metadata Service version 2), the value is 0. For more information, see [Transitioning to Using Instance Metadata Service Version 2](https://docs.aws.amazon.com/zh_cn/AWSEC2/latest/UserGuide/instance-metadata-transition-to-version-2.html){:target="_blank"}. Unit: Count |
| `NetworkIn`         | The number of bytes received by the instance on all network interfaces. This metric determines the incoming network traffic flowing to a single instance. The reported amount is the number of bytes received during the period. If you use basic (5-minute) monitoring and the statistic is Sum, you can divide this number by 300 to get bytes/second. If you use detailed (1-minute) monitoring and the statistic is Sum, divide it by 60. You can also use the CloudWatch metric math function `DIFF_TIME` to find the number of bytes per second. For example, if you plot `NetworkIn` as `m1` in CloudWatch, the metric math formula `m1/(DIFF_TIME(m1))` returns the metric in bytes/second. For more information about `DIFF_TIME` and other metric math functions, see [Using Metric Math](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html){:target="_blank"} in the Amazon CloudWatch User Guide. Unit: Bytes |
| `NetworkOut`        | The number of bytes sent by the instance on all network interfaces. This metric determines the outgoing network traffic from a single instance. The reported number is the number of bytes sent during the period. If you use basic (5-minute) monitoring and the statistic is Sum, you can divide this number by 300 to get bytes/second. If you use detailed (1-minute) monitoring and the statistic is Sum, divide it by 60. You can also use the CloudWatch metric math function `DIFF_TIME` to find the number of bytes per second. For example, if you plot `NetworkOut` as `m1` in CloudWatch, the metric math formula `m1/(DIFF_TIME(m1))` returns the metric in bytes/second. For more information about `DIFF_TIME` and other metric math functions, see [Using Metric Math](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html){:target="_blank"} in the Amazon CloudWatch User Guide. Unit: Bytes |
| `NetworkPacketsIn`  | The number of packets received by the instance on all network interfaces. This metric identifies the amount of incoming traffic based on the number of packets on a single instance. This metric is only available for basic monitoring (5-minute periods). To calculate the number of packets per second (PPS) received by the instance over 5 minutes, divide the Sum statistic by 300. You can also use the CloudWatch metric math function `DIFF_TIME` to find the number of packets per second. For example, if you plot `NetworkPacketsIn` as `m1` in CloudWatch, the metric math formula `m1/(DIFF_TIME(m1))` returns the metric in packets/second. For more information about `DIFF_TIME` and other metric math functions, see [Using Metric Math](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html){:target="_blank"} in the Amazon CloudWatch User Guide. Unit: Count |
| `NetworkPacketsOut` | The number of packets sent by the instance on all network interfaces. This metric identifies the amount of outgoing traffic based on the number of packets on a single instance. This metric is only available for basic monitoring (5-minute periods). To calculate the number of packets per second (PPS) sent by the instance over 5 minutes, divide the Sum statistic by 300. You can also use the CloudWatch metric math function `DIFF_TIME` to find the number of packets per second. For example, if you plot `NetworkPacketsOut` as `m1` in CloudWatch, the metric math formula `m1/(DIFF_TIME(m1))` returns the metric in packets/second. For more information about `DIFF_TIME` and other metric math functions, see [Using Metric Math](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html){:target="_blank"} in the Amazon CloudWatch User Guide. Unit: Count |

### CPU Metrics

The `AWS/EC2` namespace includes the following CPU credit metrics for [burstable performance instances](https://docs.aws.amazon.com/zh_cn/AWSEC2/latest/UserGuide/burstable-performance-instances.html){:target="_blank"}.

| Metric                           | Description                                                         |
| :----------------------------- | :----------------------------------------------------------- |
| `CPUCreditUsage`           | The number of CPU credits spent by the instance to sustain CPU usage. One CPU credit equals one vCPU running at 100% utilization for one minute, or an equivalent combination of vCPU, utilization, and time (for example, one vCPU running at 50% utilization for two minutes, or two vCPU running at 25% utilization for two minutes). CPU credit metrics are only provided every 5 minutes. If you specify a time period greater than five minutes, use the `Sum` statistic rather than the `Average` statistic. Unit: Credits (vCPU minutes) |
| `CPUCreditBalance`         | The number of CPU credits accumulated by the instance since it was launched. For T2 Standard, `CPUCreditBalance` also includes accumulated launch credits. After credits are earned, they accumulate in the credit balance; after credits are spent, they are deducted from the credit balance. The credit balance has a maximum limit determined by the instance size. Any new credits earned after reaching the limit are discarded. For T2 Standard, launch credits do not count towards the limit. The instance can spend credits in `CPUCreditBalance` to burst above the baseline CPU utilization. During the instance's runtime, credits in `CPUCreditBalance` do not expire. When a T3 or T3a instance is stopped, the `CPUCreditBalance` value is retained for seven days. After that, all accumulated credits are lost. When a T2 instance is stopped, the `CPUCreditBalance` value is not retained, and all accumulated credits are lost. CPU credit metrics are only provided every 5 minutes. Unit: Credits (vCPU minutes) |
| `CPUSurplusCreditBalance`  | The number of surplus credits spent by the `CPUCreditBalance` instance when the `unlimited` value is zero. The `CPUSurplusCreditBalance` value is paid for by earned CPU credits. If the surplus credits exceed the maximum number of credits the instance can earn in a 24-hour period, the spent surplus credits exceeding the maximum will incur additional charges. CPU credit metrics are only provided every 5 minutes. Unit: Credits (vCPU minutes) |
| `CPUSurplusCreditsCharged` | The number of surplus credits spent that were not paid for by earned CPU credits and will incur additional charges. Charges are applied to spent surplus credits in either of the following cases: Spent surplus credits exceed the maximum number of credits the instance can earn in a 24-hour period. For surplus credits exceeding the maximum, you are charged at the end of the hour. The instance is stopped or terminated. The instance switches from `unlimited` to `standard`. CPU credit metrics are only provided every 5 minutes. Unit: Credits (vCPU minutes) |


### Status Check Metrics
The AWS/EC2 namespace includes the following status check metrics. By default, status check metrics are freely provided at a 1-minute frequency. For newly launched instances, status check metric data is only provided after the instance completes initialization (within a few minutes of entering the running state). For more information about EC2 status checks, see [Instance Status Checks](https://docs.aws.amazon.com/zh_cn/AWSEC2/latest/UserGuide/monitoring-system-instance-status-check.html){:target="_blank"}.
| Metric                           | Description                                                         |
| :----------------------------- | :----------------------------------------------------------- |
|`StatusCheckFailed`|Reports whether the instance passed both the instance status check and the system status check in the last minute. This metric can be 0 (passed) or 1 (failed). By default, this metric is freely provided at a 1-minute frequency. Unit: Count|
|`StatusCheckFailed_Instance`|Reports whether the instance passed the instance status check in the last minute. This metric can be 0 (passed) or 1 (failed). By default, this metric is freely provided at a 1-minute frequency. Unit: Count|
|`StatusCheckFailed_System`|Reports whether the instance passed the system status check in the last minute. This metric can be 0 (passed) or 1 (failed). By default, this metric is freely provided at a 1-minute frequency. Unit: Count|

## Objects {#object}

The structure of the AWS EC2 object data collected can be seen in "Infrastructure - Custom".

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
    "BlockDeviceMappings": "{Device JSON Data}",
    "LaunchTime"         : "2021-10-26T07:00:44Z",
    "NetworkInterfaces"  : "{Network JSON Data}",
    "Placement"          : "{Availability Zone JSON Data}",
    "message"            : "{Instance JSON Data}"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, used as a unique identifier.
> Tip 2: `fields.message`, `fields.NetworkInterfaces`, and `fields.BlockDeviceMappings` are strings serialized as JSON.