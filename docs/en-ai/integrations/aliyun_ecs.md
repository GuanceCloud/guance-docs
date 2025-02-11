---
title: 'Alibaba Cloud ECS'
tags: 
  - Alibaba Cloud
  - Host
summary: 'The displayed metrics for Alibaba Cloud ECS include CPU utilization, memory utilization, network bandwidth, and disk IOPS. These metrics reflect the performance of ECS instances in terms of computing, memory, network, and storage.'
__int_icon: 'icon/aliyun_ecs'
dashboard:
  - desc: 'Alibaba Cloud ECS built-in views'
    path: 'dashboard/en/aliyun_ecs/'

monitor:
  - desc: 'Alibaba Cloud ECS monitor'
    path: 'monitor/en/aliyun_ecs/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud ECS
<!-- markdownlint-enable -->


The displayed metrics for Alibaba Cloud ECS include CPU utilization, memory utilization, network bandwidth, and disk IOPS. These metrics reflect the performance of ECS instances in terms of computing, memory, network, and storage.

## Configuration  {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant read-only access `ReadOnlyAccess`).

To synchronize monitoring data from ECS cloud resources, we install the corresponding collection script: 「Guance Integration (Alibaba Cloud-ECS Collection)」(ID: `guance_aliyun_ecs`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Once enabled, you can see the corresponding automatic trigger configurations in 「Management / Automatic Trigger Configurations」. Click 【Execute】to run it immediately without waiting for the scheduled time. Wait a moment, then check the task execution records and corresponding logs.

> If you need to collect logs, enable the corresponding log collection script. If you need to collect billing information, enable the cloud billing collection script.


By default, we collect some configurations; see the Metrics section for details.

[Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In 「Management / Automatic Trigger Configurations」, confirm whether the corresponding tasks have been configured with automatic triggers, and check the task records and logs for any anomalies.
2. In the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. In the Guance platform, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}

After configuring Alibaba Cloud Cloud Monitoring, the default metric set is as follows. You can collect more metrics by configuration. [Alibaba Cloud Cloud Monitoring Metrics Details](https://cms.console.aliyun.com/metric-meta/acs_ecs_dashboard/ecs?spm=a2c4g.11186623.0.0.252476abTrNabN){:target="_blank"}

> Note: The monitoring plugin needs to be installed in the Alibaba Cloud ECS console.

| Metric | Description                         | Type | Unit |
| ---- |-------------------------------------| :---:    | :----: |
|`CPUUtilization`| CPU utilization                              |float|%|
|`memory_usedutilization`| Memory utilization                               |float|%|
|`load_1m`| Load average over 1 minute                             |float|count|
|`load_15m`| Load average over 15 minutes                            |float|count|
|`load_5m`| Load average over 5 minutes                             |float|count|
|`DiskReadBPS`| Disk read bytes per second                           |float|bytes/s|
|`DiskWriteBPS`| Disk write bytes per second                           |float|bytes/s|
|`DiskReadIOPS`| Disk read operations per second                          |float|Count/Second|
|`DiskWriteIOPS`| Disk write operations per second                          |float|Count/Second|
|`disk_readiops`| Disk read operations per second                            |float|Count/Second|
|`disk_writeiops`| Disk write operations per second                            |float|Count/Second|
|`diskusage_utilization`| `Host.diskusage.utilization`        |float|%|
|`fs_inodeutilization`| (Agent) fs.inode.utilization_device  |float|%|
|`GroupVPC_PublicIP_InternetInRate`| Internet inbound bandwidth at IP level                          |float|bits/s|
|`GroupVPC_PublicIP_InternetOutRate`| Internet outbound bandwidth at IP level                          |float|bits/s|
|`IntranetInRate`| Intranet inbound bandwidth                              |float|bits/s|
|`IntranetOutRate`| Intranet outbound bandwidth                              |float|bits/s|
|`concurrentConnections`| Concurrent connections                               |float|count|
|`cpu_wait`| (Agent) cpu.wait                     |float|%|
|`cpu_user`| (Agent) cpu.user                     |float|%|
|`cpu_system`| (Agent) cpu.total                    |float|%|
|`memory_freeutilization`| (Agent) memory.free.utilization      |float|%|
|`disk_readbytes`| (Agent) disk.read.bytes_device       |float|bytes/s|
|`disk_writebytes`| (Agent) disk.write.bytes_device      |float|bytes/s|
|`networkin_rate`| (Agent) network.in.rate_device       |float|bits/s|
|`networkin_packages`| (Agent) network.in.packages_device   |float|Count/s|
|`net_tcpconnection`| (Agent) network.tcp.connection_state |float|Count|
|`memory_freespace`| (Agent) memory.free.space            |float|bytes|
|`memory_usedspace`| (Agent) memory.used.space            |float|bytes|
|`memory_totalspace`| (Agent) memory.total.space           |float|bytes|

## Objects {#object}

The collected Alibaba Cloud ECS object data structure can be viewed in 「Infrastructure - Custom」.

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
    "instance_renew_attribute": "[ {auto-renewal JSON data}, ...]",
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