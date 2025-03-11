---
title: 'VolcEngine ECS'
tags: 
  - VolcEngine
summary: 'The displayed Metrics of VolcEngine ECS include CPU utilization, memory utilization, network bandwidth, and disk IOPS. These Metrics reflect the performance of ECS instances in terms of computing, memory, network, and storage.'
__int_icon: 'icon/volcengine_ecs'
dashboard:
  - desc: 'VolcEngine ECS View'
    path: 'dashboard/en/volcengine_ecs/'

---

<!-- markdownlint-disable MD025 -->
# VolcEngine ECS
<!-- markdownlint-enable -->


The displayed Metrics of VolcEngine ECS include CPU utilization, memory utilization, network bandwidth, and disk IOPS. These Metrics reflect the performance of ECS instances in terms of computing, memory, network, and storage.

## Configuration {#config}

### Install Func

We recommend enabling the Guance Integration - Extension - DataFlux Func (Automata): All prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare a VolcEngine AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize monitoring data for ECS cloud resources, we install the corresponding collection script: "Guance Integration (VolcEngine-ECS Collection)" (ID: `guance_volcengine_ecs`)

After clicking [Install], enter the corresponding parameters: VolcEngine AK, VolcEngine account name.

Click [Deploy Startup Script], and the system will automatically create a `Startup` script set and automatically configure the corresponding startup scripts.

Once enabled, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Click [Execute] to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you need to collect logs, enable the corresponding log collection script. If you need to collect billing information, enable the cloud billing collection script.


By default, we collect some configurations; see the Metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-volcengine-monitor/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have the appropriate automatic trigger configurations. You can also check the task records and logs to ensure there are no anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, under "Metrics", check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring VolcEngine Cloud Monitoring, the default Measurement set is as follows. You can collect more Metrics through configuration. [VolcEngine Cloud Monitoring Metrics Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_ECS){:target="_blank"}

> Note: The monitoring plugin needs to be installed in the VolcEngine ECS console.

|`MetricName` |`Subnamespace` |Metric Name |MetricUnit | Dimension|
| ---- |-------------------------------------| :----: |:----: |:----: |
|`Instance_CpuBusy` |`Instance` |Out-of-band CPU Utilization |Percent | ResourceID|
|`Instance_DiskReadBytes` |`Instance` |Out-of-band Disk Read Bandwidth |Bytes/Second(IEC) | ResourceID|
|`Instance_DiskWriteBytes` |`Instance` |Out-of-band Disk Write Bandwidth |Bytes/Second(IEC) | ResourceID|
|`Instance_DiskReadIOPS` |`Instance` |Out-of-band Disk Read IOPS |Count/Second | ResourceID|
|`Instance_DiskWriteIOPS` |`Instance` |Out-of-band Disk Write IOPS |Count/Second | ResourceID|
|`Instance_NetTxBits` |`Instance` |Out-of-band Network Outbound Rate |Bits/Second(IEC) | ResourceID|
|`Instance_NetRxBits` |`Instance` |Out-of-band Network Inbound Rate |Bits/Second(IEC) | ResourceID|
|`Instance_NetTxPackets` |`Instance` |Out-of-band Network Send Packet Rate |Packet/Second | ResourceID|
|`Instance_NetRxPackets` |`Instance` |Out-of-band Network Receive Packet Rate |Packet/Second | ResourceID|
|`CpuTotal` |`Instance` |CPU Usage |Percent | ResourceID|
|`MemoryUsedSpace` |`Instance` |Used Memory |Bytes(IEC) | ResourceID|
|`MemoryUsedUtilization` |`Instance` |Memory Usage |Percent | ResourceID|
|`LoadPerCore1m` |`Instance` |vCPU Load (1-minute Average) |None | ResourceID|
|`LoadPerCore5m` |`Instance` |vCPU Load (5-minute Average) |None | ResourceID|
|`LoadPerCore15m` |`Instance` |vCPU Load (15-minute Average) |None | ResourceID|
|`NetworkInPackages` |`Instance` |Network Inbound Packet Rate |Packet/Second | ResourceID|
|`NetworkOutPackages` |`Instance` |Network Send Packet Rate |Packet/Second | ResourceID|
|`NetTcpConnection` |`Instance` |TOTAL |Count | ResourceID|
|`NetworkInRate` |`Instance` |Network Inbound Rate |Bits/Second(IEC) | ResourceID|
|`NetworkOutRate` |`Instance` |Network Outbound Rate |Bits/Second(IEC) | ResourceID|


## Objects {#object}
The collected VolcEngine ECS object data structure can be viewed under "Infrastructure - Custom".

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
