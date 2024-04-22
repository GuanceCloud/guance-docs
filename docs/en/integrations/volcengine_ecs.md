---
title: 'Volcengine ECS'
tags: 
  - `Volcengine`
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
Configure `Volcenine` Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [`Volcenine` Cloud Monitor Metrics Details](https://console.volcengine.com/cloud_monitor/metricDoc?tabKey=metric&namespace=VCM_ECS){:target="_blank"}

| Metric | Description                          | Unit |
| ---- |-------------------------------------| :----: |
|`LoadPerCore1m` | Average load per minute for a single instance core | None |
|`LoadPerCore5m` | Average 5-minute load of a single instance core | None |
|`LoadPerCore15m` | Average 15-minute load of a single instance core | None |
|`CpuTotal` |CPU usage rate|Percent|
|`CPUIowait` |CPU usage rate（IoWait）|Percent|
|`CPUUser` |CPU usage rate（user）|Percent|
|`CpuSystem` |CPU usage rate（System）|Percent|
|`MemoryFreeSpace`|Remaining memory capacity|Bytes(IEC)|
|`MemoryTotalSpace`|Total Memory|Bytes(IEC)|
|`MemoryUsedUtilization`|Memory usage rate|Percent|
|`DiskUsageUtilization`|Disk usage rate|Percent|
|`DiskInodesUsedPercent`| inode usage rate | Percent |
|`DiskReadIOPS`| Disk read IOPS |Count/Second|
|`DiskWriteIOPS`| Disk write IOPS |Count/Second|
|`DiskReadBytes`| Disk read bandwidth | Bytes/Second(SI) |
|`DiskWriteBytes`|Disk write bandwidth| Bytes/Second(SI) |
|`NetworkInRate`| Network inflow rate | Bits/Second(IEC) |
|`NetworkOutRate`|Network outflow rate|Bits/Second(IEC) |
|`NetworkInPackages`| Network packet inflow rate | Packet/Second |
|`NetworkOutPackages`| Network packet sending rate | Packet/Second|
|`NetTcpConnectionStatus`| Total TCP connections | Count|
|`NetTcpConnectionStatusESTABLISHED`| ESTABLISHED | Count|
|`NetTcpConnectionStatusNONESTABLISHED`| `NONESTABLISHED` | Count|

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

