---
title: 'Volcengine ECS'
tags: 
  - Volcengine
summary: 'The display metrics of Voltage ECS include CPU utilization, memory utilization, network bandwidth, and disk IOPS, which reflect the computing, memory, network, and storage performance of ECS instances.'
__int_icon: 'icon/volcengine_ecs'
dashboard:
  - desc: 'Volcengine ECS'
    path: 'dashboard/en/volcengine_ecs/'
---

<!-- markdownlint-disable MD025 -->
# `Volcengine` ECS
<!-- markdownlint-enable -->


The display metrics of Voltage ECS include CPU utilization, memory utilization, network bandwidth, and disk IOPS, which reflect the computing, memory, network, and storage performance of ECS instances.

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation script


> Tip：Please prepare `Volcenine`  AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of **ECS** cloud resources, we install the corresponding collection script：「Guance Integration（`Volcenine` -**ECS** Collect）」(ID：`guance_volcengine_ecs`)

Click "Install" and enter the corresponding parameters: `Volcenine` AK, `Volcenine` account name.

tap "Deploy startup Script"，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click "Run"，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs.

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-volcengine-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists


## Metric  {#metric}
Configure `Volcenine` Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [`Volcenine` Cloud Monitor Metrics Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_ECS){:target="_blank"}

| `MetricName` | `Subnamespace` | Description | MetricUnit | Dimension |
|-------------|---------------|-----------------------|------------|-----------|
| `Instance_CpuBusy` | Instance | Out-of-band CPU Utilization | Percent | ResourceID |
| `Instance_DiskReadBytes` | Instance | Out-of-band Disk Read Bandwidth | Bytes/Second(IEC) | ResourceID |
| `Instance_DiskWriteBytes` | Instance | Out-of-band Disk Write Bandwidth | Bytes/Second(IEC) | ResourceID |
| `Instance_DiskReadIOPS` | Instance | Out-of-band Disk Read IOPS | Count/Second | ResourceID |
| `Instance_DiskWriteIOPS` | Instance | Out-of-band Disk Write IOPS | Count/Second | ResourceID |
| `Instance_NetTxBits` | Instance | Out-of-band Network Egress Rate | Bits/Second(IEC) | ResourceID |
| `Instance_NetRxBits` | Instance | Out-of-band Network Ingress Rate | Bits/Second(IEC) | ResourceID |
| `Instance_NetTxPackets` | Instance | Out-of-band Network Packets Sent Rate | Packet/Second | ResourceID |
| `Instance_NetRxPackets` | Instance | Out-of-band Network Packets Received Rate | Packet/Second | ResourceID |
| `CpuTotal` | Instance | CPU Utilization | Percent | ResourceID |
| `MemoryUsedSpace` | Instance | Used Memory Amount | Bytes(IEC) | ResourceID |
| `MemoryUsedUtilization` | Instance | Memory Utilization Rate | Percent | ResourceID |
| `LoadPerCore1m` | Instance | vCPU Load (1-minute Average) | None | ResourceID |
| `LoadPerCore5m` | Instance | vCPU Load (5-minute Average) | None | ResourceID |
| `LoadPerCore15m` | Instance | vCPU Load (15-minute Average) | None | ResourceID |
| `NetworkInPackages` | Instance | Network Ingress Packet Rate | Packet/Second | `ResourceID` |
| `NetworkOutPackages` | Instance | Network Egress Packet Rate | Packet/Second | ResourceID |
| `NetTcpConnection` | Instance | Total TCP Connections | Count | ResourceID |
| `NetworkInRate` | Instance | Network Ingress Rate | Bits/Second(IEC) | ResourceID |
| `NetworkOutRate` | Instance | Network Egress Rate | Bits/Second(IEC) | ResourceID |

## Object  {#object}
The collected `Volcenine` Cloud **ECS** object data structure can see the object data from 「Infrastructure-Custom」

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
      "OsName": "CentOS Stream 9 64",
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

