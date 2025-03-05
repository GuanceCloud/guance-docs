---
title: 'AWS EC2'
tags: 
  - AWS
summary: 'Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.'
__int_icon: 'icon/aws_ec2'
dashboard:

  - desc: 'AWS EC2 Monitoring View'
    path: 'dashboard/en/aws_ec2'

monitor:
  - desc: 'AWS EC2 Monitor'
    path: 'monitor/en/aws_ec2'

cloudCollector:
  desc: 'cloud collector'
  path: 'cloud-collector/en/aws_ec2'
---


<!-- markdownlint-disable MD025 -->
# AWS EC2
<!-- markdownlint-enable -->

Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.


## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip：Please prepare AWS AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of EC2 cloud resources, we install the corresponding collection script: `ID:guance_aws_ec2`

Click 【Install】 and enter the corresponding parameters: AWS AK, AWS account name.

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.


We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

Configure AWS Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/viewing_metrics_with_cloudwatch.html){:target="_blank"}


| Metric                    | Description                                                         |
| :---------------------- | :----------------------------------------------------------- |
| `CPUUtilization`    | The percentage of physical CPU time that Amazon EC2 uses to run the EC2 instance, which includes time spent to run both the user code and the Amazon EC2 code.At a very high level, CPUUtilization is the sum of guest CPUUtilization and hypervisor CPUUtilization.Tools in your operating system can show a different percentage than CloudWatch due to factors such as legacy device simulation, configuration of non-legacy devices, interrupt-heavy workloads, live migration, and live update. Units: Percent |
| `DiskReadOps`       | Completed read operations from all instance store volumes available to the instance in a specified period of time.To calculate the average I/O operations per second (IOPS) for the period, divide the total operations in the period by the number of seconds in that period.If there are no instance store volumes, either the value is 0 or the metric is not reported. Units: Count |
| `DiskWriteOps`      | Completed write operations to all instance store volumes available to the instance in a specified period of time.To calculate the average I/O operations per second (IOPS) for the period, divide the total operations in the period by the number of seconds in that period.If there are no instance store volumes, either the value is 0 or the metric is not reported. Units: Count |
| `DiskReadBytes`     | Bytes read from all instance store volumes available to the instance.This metric is used to determine the volume of the data the application reads from the hard disk of the instance. This can be used to determine the speed of the application.The number reported is the number of bytes received during the period. If you are using basic (5-minute) monitoring, you can divide this number by 300 to find Bytes/second. If you have detailed (1-minute) monitoring, divide it by 60. You can also use the CloudWatch metric math function DIFF_TIME to find the bytes per second. For example, if you have graphed DiskReadBytes in CloudWatch as m1, the metric math formula m1/(DIFF_TIME(m1)) returns the metric in bytes/second. For more information about DIFF_TIME and other metric math functions, see Use metric math in the Amazon CloudWatch User Guide.If there are no instance store volumes, either the value is 0 or the metric is not reported. Units: Bytes |
| `DiskWriteBytes`    | Bytes written to all instance store volumes available to the instance.This metric is used to determine the volume of the data the application writes onto the hard disk of the instance. This can be used to determine the speed of the application.The number reported is the number of bytes received during the period. If you are using basic (5-minute) monitoring, you can divide this number by 300 to find Bytes/second. If you have detailed (1-minute) monitoring, divide it by 60. You can also use the CloudWatch metric math function DIFF_TIME to find the bytes per second. For example, if you have graphed DiskWriteBytes in CloudWatch as m1, the metric math formula m1/(DIFF_TIME(m1)) returns the metric in bytes/second. For more information about DIFF_TIME and other metric math functions, see Use metric math in the Amazon CloudWatch User Guide.If there are no instance store volumes, either the value is 0 or the metric is not reported. Units: Bytes |
| `MetadataNoToken`   | The number of times the Instance Metadata Service was successfully accessed using a method that does not use a token.This metric is used to determine if there are any processes accessing instance metadata that are using Instance Metadata Service Version 1, which does not use a token. If all requests use token-backed sessions, i.e., Instance Metadata Service Version 2, the value is 0. For more information, see Transition to using Instance Metadata Service Version 2.Units: Count |
| `NetworkIn`         | The number of bytes received by the instance on all network interfaces. This metric identifies the volume of incoming network traffic to a single instance.The number reported is the number of bytes received during the period. If you are using basic (5-minute) monitoring and the statistic is Sum, you can divide this number by 300 to find Bytes/second. If you have detailed (1-minute) monitoring and the statistic is Sum, divide it by 60. You can also use the CloudWatch metric math function DIFF_TIME to find the bytes per second. For example, if you have graphed NetworkIn in CloudWatch as m1, the metric math formula m1/(DIFF_TIME(m1)) returns the metric in bytes/second. For more information about DIFF_TIME and other metric math functions, see Use metric math in the Amazon CloudWatch User Guide. Units: Bytes |
| `NetworkOut`        | The number of bytes sent out by the instance on all network interfaces. This metric identifies the volume of outgoing network traffic from a single instance.The number reported is the number of bytes sent during the period. If you are using basic (5-minute) monitoring and the statistic is Sum, you can divide this number by 300 to find Bytes/second. If you have detailed (1-minute) monitoring and the statistic is Sum, divide it by 60. You can also use the CloudWatch metric math function DIFF_TIME to find the bytes per second. For example, if you have graphed NetworkOut in CloudWatch as m1, the metric math formula m1/(DIFF_TIME(m1)) returns the metric in bytes/second. For more information about DIFF_TIME and other metric math functions, see Use metric math in the Amazon CloudWatch User Guide. Units: Bytes |
| `NetworkPacketsIn`  | The number of packets received by the instance on all network interfaces. This metric identifies the volume of incoming traffic in terms of the number of packets on a single instance.This metric is available for basic monitoring only (5-minute periods). To calculate the number of packets per second (PPS) your instance received for the 5 minutes, divide the Sum statistic value by 300. You can also use the CloudWatch metric math function DIFF_TIME to find the packets per second. For example, if you have graphed NetworkPacketsIn in CloudWatch as m1, the metric math formula m1/(DIFF_TIME(m1)) returns the metric in packets/second. For more information about DIFF_TIME and other metric math functions, see Use metric math in the Amazon CloudWatch User Guide. Units: Count |
| `NetworkPacketsOut` | The number of packets sent out by the instance on all network interfaces. This metric identifies the volume of outgoing traffic in terms of the number of packets on a single instance.This metric is available for basic monitoring only (5-minute periods). To calculate the number of packets per second (PPS) your instance sent for the 5 minutes, divide the Sum statistic value by 300. You can also use the CloudWatch metric math function DIFF_TIME to find the packets per second. For example, if you have graphed NetworkPacketsOut in CloudWatch as m1, the metric math formula m1/(DIFF_TIME(m1)) returns the metric in packets/second. For more information about DIFF_TIME and other metric math functions, see Use metric math in the Amazon CloudWatch User Guide. Units: Count |

### CPU credit metrics

The `AWS/EC2` namespace includes the following CPU credit metrics for your [`burstable performance instances`](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances.html){:target="_blank"}.

| Metric                           | Description                                                         |
| :----------------------------- | :----------------------------------------------------------- |
| `CPUCreditUsage`           | The number of CPU credits spent by the instance for CPU utilization. One CPU credit equals one vCPU running at 100% utilization for one minute or an equivalent combination of vCPUs, utilization, and time (for example, one vCPU running at 50% utilization for two minutes or two vCPUs running at 25% utilization for two minutes).CPU credit metrics are available at a 5-minute frequency only. If you specify a period greater than five minutes, use the Sum statistic instead of the Average statistic. Units: Credits (vCPU-minutes) |
| `CPUCreditBalance`         | The number of earned CPU credits that an instance has accrued since it was launched or started. For T2 Standard, the CPUCreditBalance also includes the number of launch credits that have been accrued.Credits are accrued in the credit balance after they are earned, and removed from the credit balance when they are spent. The credit balance has a maximum limit, determined by the instance size. After the limit is reached, any new credits that are earned are discarded. For T2 Standard, launch credits do not count towards the limit.The credits in the CPUCreditBalance are available for the instance to spend to burst beyond its baseline CPU utilization.When an instance is running, credits in the CPUCreditBalance do not expire. When a T3 or T3a instance stops, the CPUCreditBalance value persists for seven days. Thereafter, all accrued credits are lost. When a T2 instance stops, the CPUCreditBalance value does not persist, and all accrued credits are lost.CPU credit metrics are available at a 5-minute frequency only. Units: Credits (vCPU-minutes) |
| `CPUSurplusCreditBalance`  | The number of surplus credits that have been spent by an unlimited instance when its CPUCreditBalance value is zero.The CPUSurplusCreditBalance value is paid down by earned CPU credits. If the number of surplus credits exceeds the maximum number of credits that the instance can earn in a 24-hour period, the spent surplus credits above the maximum incur an additional charge.CPU credit metrics are available at a 5-minute frequency only.Units: Credits (vCPU-minutes) |
| `CPUSurplusCreditsCharged` | The number of spent surplus credits that are not paid down by earned CPU credits, and which thus incur an additional charge.Spent surplus credits are charged when any of the following occurs:The spent surplus credits exceed the maximum number of credits that the instance can earn in a 24-hour period. Spent surplus credits above the maximum are charged at the end of the hour.The instance is stopped or terminated.The instance is switched from unlimited to standard.CPU credit metrics are available at a 5-minute frequency only. Units: Credits (vCPU-minutes) |


### Status check metrics

The `AWS/EC2` namespace includes the following status check metrics. By default, status check metrics are available at a 1-minute frequency at no charge. For a newly-launched instance, status check metric data is only available after the instance has completed the initialization state (within a few minutes of the instance entering the running state). For more information about EC2 status checks, see [Status checks for your instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/monitoring-system-instance-status-check.html){:target="_blank"}.

| Metric                           | Description                                                         |
| :----------------------------- | :----------------------------------------------------------- |
|`StatusCheckFailed`|Reports whether the instance has passed both the instance status check and the system status check in the last minute.This metric can be either 0 (passed) or 1 (failed).By default, this metric is available at a 1-minute frequency at no charge.Units: Count|
|`StatusCheckFailed_Instance`|Reports whether the instance has passed the instance status check in the last minute.This metric can be either 0 (passed) or 1 (failed).By default, this metric is available at a 1-minute frequency at no charge. Units: Count|
|`StatusCheckFailed_System`|Reports whether the instance has passed the system status check in the last minute.This metric can be either 0 (passed) or 1 (failed).By default, this metric is available at a 1-minute frequency at no charge.Units: Count|

## Object {#object}

The collected AWS EC2 object data structure can see the object data from 「Infrastructure-Custom」

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

> *Note: Fields in `tags`, `fields` are subject to change with subsequent updates.*
>
> Tip 1: The `tags.name` value is the instance ID, which serves as a unique identifier.
> Tip 2: `fields.message`, `fields.NetworkInterfaces`, and `fields.BlockDeviceMappings` are JSON serialized strings.
