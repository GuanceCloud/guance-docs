---
title: 'Alibaba Cloud ECS'
tags: 
  - Alibaba Cloud
  - Host
summary: 'The displayed metrics for Alibaba Cloud ECS include CPU utilization, memory utilization, network bandwidth, and disk IOPS. These metrics reflect the performance of ECS instances in terms of computing, memory, network, and storage.'
__int_icon: 'icon/aliyun_ecs'
dashboard:
  - desc: 'Built-in view for Alibaba Cloud ECS'
    path: 'dashboard/en/aliyun_ecs/'

monitor:
  - desc: 'Alibaba Cloud ECS Monitor'
    path: 'monitor/en/aliyun_ecs/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud ECS
<!-- markdownlint-enable -->


The displayed metrics for Alibaba Cloud ECS include CPU utilization, memory utilization, network bandwidth, and disk IOPS. These metrics reflect the performance of ECS instances in terms of computing, memory, network, and storage.

## Configuration  {#config}

### Install Func

We recommend enabling the Guance integration - Extensions - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize monitoring data from ECS cloud resources, we install the corresponding collection script: 「Guance Integration (Alibaba Cloud-ECS Collection)」(ID: `guance_aliyun_ecs`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short wait, you can view the task execution records and corresponding logs.

> If you need to collect logs, enable the corresponding log collection script. If you need to collect billing data, enable the cloud billing collection script.


By default, we collect some configurations; see the metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding tasks have the automatic trigger configuration and check the task records and logs for any anomalies.
2. In the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. In the Guance platform, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}

After configuring Alibaba Cloud Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration [Alibaba Cloud Cloud Monitoring Metric Details](https://cms.console.aliyun.com/metric-meta/acs_ecs_dashboard/ecs?spm=a2c4g.11186623.0.0.252476abTrNabN){:target="_blank"}

> Note: You need to install the monitoring plugin in the Alibaba Cloud ECS console.

| Metric | Description                         | Type | Unit |
| ---- |-------------------------------------| :---:    | :----: |
|`CPUUtilization`| CPU Utilization                             |float|%|
|`memory_usedutilization`| Memory Utilization                            |float|%|
|`load_1m`| Load Average over 1 minute                          |float|count|
|`load_15m`| Load Average over 15 minutes                         |float|count|
|`load_5m`| Load Average over 5 minutes                          |float|count|
|`DiskReadBPS`| Disk Read Throughput                           |float|bytes/s|
|`DiskWriteBPS`| Disk Write Throughput                           |float|bytes/s|
|`DiskReadIOPS`| Disk Reads per Second                          |float|Count/Second|
|`DiskWriteIOPS`| Disk Writes per Second                          |float|Count/Second|
|`disk_readiops`| Disk Reads per Second                            |float|Count/Second|
|`disk_writeiops`| Disk Writes per Second                            |float|Count/Second|
|`diskusage_utilization`| Disk Usage Utilization        |float|%|
|`fs_inodeutilization`| File System Inode Utilization  |float|%|
|`GroupVPC_PublicIP_InternetInRate`| Internet Inbound Bandwidth by IP                          |float|bits/s|
|`GroupVPC_PublicIP_InternetOutRate`| Internet Outbound Bandwidth by IP                          |float|bits/s|
|`IntranetInRate`| Internal Network Inbound Bandwidth                              |float|bits/s|
|`IntranetOutRate`| Internal Network Outbound Bandwidth                              |float|bits/s|
|`concurrentConnections`| Concurrent Connections                               |float|count|
|`cpu_wait`| CPU Wait Time                     |float|%|
|`cpu_user`| CPU User Time                     |float|%|
|`cpu_system`| CPU System Time                    |float|%|
|`memory_freeutilization`| Free Memory Utilization      |float|%|
|`disk_readbytes`| Disk Read Bytes       |float|bytes/s|
|`disk_writebytes`| Disk Write Bytes      |float|bytes/s|
|`networkin_rate`| Network Inbound Rate       |float|bits/s|
|`networkin_packages`| Network Inbound Packets   |float|Count/s|
|`net_tcpconnection`| TCP Connections State |float|Count|
|`memory_freespace`| Free Memory Space            |float|bytes|
|`memory_usedspace`| Used Memory Space            |float|bytes|
|`memory_totalspace`| Total Memory Space           |float|bytes|

## Objects {#object}

The collected Alibaba Cloud ECS object data structure can be viewed under 「Infrastructure - Custom」

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
    "disks"                  : "[ {Associated Disk JSON Data}, ... ]",
    "network_interfaces"     : "[ {Associated Network Interface JSON Data}, ... ]",
    "instance_renew_attribute": "[ {Auto Renewal JSON Data}, ...]",
    "instances_full_status"  : "[ {Full Status Information JSON Data}, ...]",
    "OperationLocks"         : "[ {Lock Reason JSON Data}, ...]",
    "Memory"                 : "8192",
    "Cpu"                    : "4",
    "InternetMaxBandwidthOut": "0",
    "InternetMinBandwidthIn" : "0",
    "AutoReleaseTime"        : "xxxx",
    "message"                : "{Instance JSON Data}"
  }
}
```
