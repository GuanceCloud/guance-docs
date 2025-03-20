---
title: 'Volcengine ECS'
tags: 
  - Volcengine
summary: 'The displayed Metrics for Volcengine ECS include CPU utilization, memory utilization, network bandwidth, and disk IOPS. These Metrics reflect the performance of ECS instances in terms of computation, memory, network, and storage.'
__int_icon: 'icon/volcengine_ecs'
dashboard:
  - desc: 'Volcengine ECS View'
    path: 'dashboard/en/volcengine_ecs/'

---

<!-- markdownlint-disable MD025 -->
# Volcengine ECS
<!-- markdownlint-enable -->


The displayed Metrics for Volcengine ECS include CPU utilization, memory utilization, network bandwidth, and disk IOPS. These Metrics reflect the performance of ECS instances in terms of computation, memory, network, and storage.

## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Please prepare a qualified Volcengine AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data for ECS cloud resources, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (Volcengine-ECS Collection)" (ID: `guance_volcengine_ecs`)

After clicking 【Install】, enter the corresponding parameters: Volcengine AK, Volcengine account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately run it once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

> If you want to collect the corresponding logs, you also need to enable the corresponding log collection script. If you want to collect billing information, you need to enable the cloud billing collection script.


We default collect some configurations, details are shown in the Metrics section.

[Configure custom cloud object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-volcengine-monitor/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and you can check the corresponding task records and logs for any anomalies.
2. On the <<< custom_key.brand_name >>> platform, under "Infrastructure / Custom", check if asset information exists.
3. On the <<< custom_key.brand_name >>> platform, under "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Volcengine-Cloud Monitoring, the default Measurement set is as follows. You can collect more Metrics through configuration [Volcengine Cloud Monitoring Metrics Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_ECS){:target="_blank"}

> Note: You need to install the monitoring plugin in the `volcengine` ECS console.

|`MetricName` |`Subnamespace` |Metric Name |MetricUnit | Dimension|
| ---- |-------------------------------------| :----: |:----: |:----: |
|`MetricName` |`SubNamespace` |Metric Name |MetricUnit | Dimension|
|`Instance_CpuBusy` |`Instance` |Out-of-band CPU Utilization |Percent | ResourceID|
|`Instance_DiskReadBytes` |`Instance` |Out-of-band Disk Read Bandwidth |Bytes/Second(IEC) | ResourceID|
|`Instance_DiskWriteBytes` |`Instance` |Out-of-band Disk Write Bandwidth |Bytes/Second(IEC) | ResourceID|
|`Instance_DiskReadIOPS` |`Instance` |Out-of-band Disk Read IOPS |Count/Second | ResourceID|
|`Instance_DiskWriteIOPS` |`Instance` |Out-of-band Disk Write IOPS |Count/Second | ResourceID|
|`Instance_NetTxBits` |`Instance` |Out-of-band Network Outbound Rate |Bits/Second(IEC) | ResourceID|
|`Instance_NetRxBits` |`Instance` |Out-of-band Network Inbound Rate |Bits/Second(IEC) | ResourceID|
|`Instance_NetTxPackets` |`Instance` |Out-of-band Network Sent Packets Rate |Packet/Second | ResourceID|
|`Instance_NetRxPackets` |`Instance` |Out-of-band Network Received Packets Rate |Packet/Second | ResourceID|
|`CpuTotal` |`Instance` |CPU Usage |Percent | ResourceID|
|`MemoryUsedSpace` |`Instance` |Used Memory |Bytes(IEC) | ResourceID|
|`MemoryUsedUtilization` |`Instance` |Memory Usage |Percent | ResourceID|
|`LoadPerCore1m` |`Instance` |vCPU Load (1-minute Average) |None | ResourceID|
|`LoadPerCore5m` |`Instance` |vCPU Load (5-minute Average) |None | ResourceID|
|`LoadPerCore15m` |`Instance` |vCPU Load (15-minute Average) |None | ResourceID|
|`NetworkInPackages` |`Instance` |Network Inbound Packets Rate |Packet/Second | ResourceID|
|`NetworkOutPackages` |`Instance` |Network Sent Packets Rate |Packet/Second | ResourceID|
|`NetTcpConnection` |`Instance` |TOTAL |Count | ResourceID|
|`NetworkInRate` |`Instance` |Network Inbound Rate |Bits/Second(IEC) | ResourceID|
|`NetworkOutRate` |`Instance` |Network Outbound Rate |Bits/Second(IEC) | ResourceID|


## Objects {#object}
The collected Volcengine ECS object data structure can be viewed from "Infrastructure - Custom".

``` json
[
  {
    "category": "custom_object",
    "fields": {
      "CpuOptions": "{\"CoreCount\": 1, \"ThreadsPerCore\": 2}",
      "CreatedAt": "2024-03-11T14:01:05+08:00",
      "Description": "",
      "LocalVolumes": "[]",
    ...
    },
    "measurement": "volcengine_ecs",
    "tags": {
      "Cpus": "1",
      "DeploymentSetGroupNumber": "0",
      "DeploymentSetId": "",
      "ElasticScheduledInstanceType": "NoEsi",
      "Hostname": "iv-xx",
      "ImageId": "image-xx",
      "InstanceChargeType": "PostPaid",
      "InstanceId": "i-xx",
      "InstanceName": "ECS-0XQq",
      "InstanceTypeId": "ecs.s2-c1m2.small",
      "KeyPairId": "kp-xx",
      "KeyPairName": "xxx-test",
      "MemorySize": "2048",
      "OsName": "CentOS Stream 9 64-bit",
      "OsType": "Linux",
      "ProjectName": "default",
      "RegionId": "cn-beijing",
      "ScheduledInstanceId": "",
      "Status": "RUNNING",
      "Uuid": "000c65ee-9e1c-xxx-xxx-xxxx",
      "VpcId": "vpc-xxx",
      "ZoneId": "cn-beijing-b",
      "name": "i-xxx"
    }
  }
]
```