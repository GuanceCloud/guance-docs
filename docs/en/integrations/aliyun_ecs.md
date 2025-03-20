---
title: 'Alibaba Cloud ECS'
tags: 
  - Alibaba Cloud
  - HOST
summary: 'The displayed metrics for Alibaba Cloud ECS include CPU utilization, memory utilization, network bandwidth, and disk IOPS. These metrics reflect the performance of ECS instances in terms of computing, memory, networking, and storage.'
__int_icon: 'icon/aliyun_ecs'
dashboard:
  - desc: 'Alibaba Cloud ECS built-in views'
    path: 'dashboard/en/aliyun_ecs/'

monitor:
  - desc: 'Alibaba Cloud ECS monitors'
    path: 'monitor/en/aliyun_ecs/'

cloudCollector:
  desc: 'cloud collector'
  path: 'cloud-collector/en/aliyun_ecs'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud ECS
<!-- markdownlint-enable -->


The displayed metrics for Alibaba Cloud ECS include CPU utilization, memory utilization, network bandwidth, and disk IOPS. These metrics reflect the performance of ECS instances in terms of computing, memory, networking, and storage.

## Configuration  {#config}

### Install Func

It is recommended to enable Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Please prepare the required Alibaba Cloud AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data of ECS cloud resources, we install the corresponding collection script: "Guance Integration (Alibaba Cloud-ECS Collection)" (ID: `guance_aliyun_ecs`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

> If you want to collect corresponding logs, you also need to enable the corresponding log collection script. If you want to collect billing information, you need to enable the cloud billing collection script.


We default to collecting some configurations; for more details, see the Metrics section.

[Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration, and check the corresponding task records and logs to ensure there are no abnormalities.
2. In the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. In the Guance platform, under "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}

After configuring Alibaba Cloud - Cloud Monitor, the default metric sets are as follows. You can collect more metrics through configuration. [Alibaba Cloud Cloud Monitor Metric Details](https://cms.console.aliyun.com/metric-meta/acs_ecs_dashboard/ecs?spm=a2c4g.11186623.0.0.252476abTrNabN){:target="_blank"}

> Note: You need to install the monitoring plugin in the Aliyun ECS console.

| Metric | Description                         | Type | Unit |
| ---- |-------------------------------------| :---:    | :----: |
|`CPUUtilization`| CPU usage                              |float|%|
|`memory_usedutilization`| Memory usage                               |float|%|
|`load_1m`| load.1m                             |float|count|
|`load_15m`| load.15m                            |float|count|
|`load_5m`| load.5m                             |float|count|
|`DiskReadBPS`| Total disk read BPS                           |float|bytes/s|
|`DiskWriteBPS`| Total disk write BPS                           |float|bytes/s|
|`DiskReadIOPS`| Total disk reads per second                          |float|Count/Second|
|`DiskWriteIOPS`| Total disk writes per second                          |float|Count/Second|
|`disk_readiops`| Disk reads per second                            |float|Count/Second|
|`disk_writeiops`| Disk writes per second                            |float|Count/Second|
|`diskusage_utilization`| `Host.diskusage.utilization`        |float|%|
|`fs_inodeutilization`| (Agent)fs.inode.utilization_device  |float|%|
|`GroupVPC_PublicIP_InternetInRate`| Public IP inbound bandwidth                          |float|bits/s|
|`GroupVPC_PublicIP_InternetOutRate`| Public IP outbound bandwidth                          |float|bits/s|
|`IntranetInRate`| Internal network inbound bandwidth                              |float|bits/s|
|`IntranetOutRate`| Internal network outbound bandwidth                              |float|bits/s|
|`concurrentConnections`| Concurrent connections                               |float|count|
|`cpu_wait`| (Agent)cpu.wait                     |float|%|
|`cpu_user`| (Agent)cpu.user                     |float|%|
|`cpu_system`| (Agent)cpu.total                    |float|%|
|`memory_freeutilization`| (Agent)memory.free.utilization      |float|%|
|`disk_readbytes`| (Agent)disk.read.bytes_device       |float|bytes/s|
|`disk_writebytes`| (Agent)disk.write.bytes_device      |float|bytes/s|
|`networkin_rate`| (Agent)network.in.rate_device       |float|bits/s|
|`networkin_packages`| (Agent)network.in.packages_device   |float|Count/s|
|`net_tcpconnection`| (Agent)network.tcp.connection_state |float|Count|
|`memory_freespace`| (Agent)memory.free.space            |float|bytes|
|`memory_usedspace`| (Agent)memory.used.space            |float|bytes|
|`memory_totalspace`| (Agent)memory.total.space           |float|bytes|

## Objects {#object}

The collected Alibaba Cloud ECS object data structure can be viewed from "Infrastructure - Custom".

``` json
{
  "measurement": "aliyun_ecs",
  "tags": {
    "name"                     : "i-xxxxx",
    "HostName"                 : "xxxxx",
    "InstanceName"             : "xxxxx",
    "InstanceId"               : "i-xxxxx",
    "RegionId"                 : "cn-hangzhou",
    "ZoneId"                   : "cn-hangzhou-a",
    "InstanceChargeType"       : "PrePaid",
    "InternetChargeType"       : "PayByTraffic",
    "OSType"                   : "linux",
    "PublicIpAddress_IpAddress": "['xxxx',]",
    "InstanceType"             : "ecs.c6.xlarge",
    "InstanceTypeFamily"       : "ecs.c6",
    "Status"                   : "Running"
  },
  "fields": {
    "CreationTime"           : "2022-01-01T00:00Z",
    "StartTime"              : "2022-01-02T00:00Z",
    "ExpiredTime"            : "2023-01-01T00:00Z",
    "disks"                  : "[ {associated disk JSON data}, ... ]",
    "network_interfaces"     : "[ {associated network card JSON data}, ... ]",
    "instance_renew_attribute": "[ {automatic renewal JSON data}, ...]",
    "instances_full_status"  : "[ {full status information JSON data}, ...]",
    "OperationLocks"         : "[ {lock reason JSON data}, ...]",
    "Memory"                 : "8192",
    "Cpu"                    : "4",
    "InternetMaxBandwidthOut": "0",
    "InternetMinBandwidthIn" : "0",
    "AutoReleaseTime"        : "xxxx",
    "message"                : "{instance JSON data}"
  }
}
```