---
title: 'Aliyun ECS'
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.'   
__int_icon: 'icon/aliyun_ecs'
dashboard:
  - desc: 'Aliyun ECS Monitoring View'
    path: 'dashboard/zh/aliyun_ecs/'

monitor:
  - desc: 'Aliyun ECS Monitor'
    path: 'monitor/zh/aliyun_ecs/'
---

<!-- markdownlint-disable MD025 -->
# Aliyun ECS
<!-- markdownlint-enable -->


Use the「Guance Synchronization」series script package in the script market to monitor the cloud ,The data of the cloud asset is synchronized to the Guance。


## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of ECS cloud resources, we install the corresponding collection script：「Guance Integration（Aliyun -ECS Collect）」(ID：`guance_aliyun_ecs`)

Click 【Install】 and enter the corresponding parameters: Aliyun AK, Aliyun account name.。

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.



We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure Ali Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Alibaba Cloud Monitor Metrics Details](https://cms.console.aliyun.com/metric-meta/acs_ecs_dashboard/ecs?spm=a2c4g.11186623.0.0.252476abTrNabN){:target="_blank"}

> Tip：The monitoring plug-in needs to be installed on the Aliyun ECS console

| Metric | Description                        | Type | Unit |
| ---- |------------------------------------| :---:    | :----: |
|`CPUUtilization`| CPU usage                            |float|%|
|`memory_usedutilization`| Memory usage                            |float|%|
|`load_1m`| load.1m                            |float|count|
|`load_15m`| load.15m                           |float|count|
|`load_5m`| load.5m                            |float|count|
|`DiskReadBPS`| All disks read BPS  |float|bytes/s|
|`DiskWriteBPS`| All disks are written to BPS   |float|bytes/s|
|`DiskReadIOPS`| Number of reads per second for all disks |float|Count/Second|
|`DiskWriteIOPS`| Number of writes per second for all disks|float|Count/Second|
|`disk_readiops`| Number of disk reads per second  |float|Count/Second|
|`disk_writeiops`| Number of disk writes per second |float|Count/Second|
|`diskusage_utilization`| `Host.diskusage.utilization`         |float|%|
|`fs_inodeutilization`| (Agent)fs.inode.utilization_device |float|%|
|`GroupVPC_PublicIP_InternetInRate`| IP bandwidth of the public network                       |float|bits/s|
|`GroupVPC_PublicIP_InternetOutRate`| IP address outbound bandwidth of the public network                         |float|bits/s|
|`IntranetInRate`| Intranet inbound bandwidth                          |float|bits/s|
|`IntranetOutRate`| Intranet outgoing bandwidth                         |float|bits/s|
|`concurrentConnections`| Number of simultaneous connections                             |float|count|
|`cpu_wait`| (Agent)cpu.wait                    |float|%|
|`cpu_user`| (Agent)cpu.user                    |float|%|
|`cpu_system`| (Agent)cpu.total                   |float|%|
|`memory_freeutilization`| (Agent)memory.free.utilization     |float|%|
|`disk_readbytes`| (Agent)disk.read.bytes_device      |float|bytes/s|
|`disk_writebytes`| (Agent)disk.write.bytes_device     |float|bytes/s|
|`networkin_rate`| (Agent)network.in.rate_device      |float|bits/s|
|`networkin_packages`| (Agent)network.in.packages_device  |float|Count/s|
|`net_tcpconnection`| (Agent)network.tcp.connection_state |float|Count|
|`memory_freespace`| (Agent)memory.free.space           |float|bytes|
|`memory_usedspace`| (Agent)memory.free.space           |float|bytes|
|`memory_totalspace`| (Agent)memory.total.space          |float|bytes|

## Object {#object}
The collected Alibaba Cloud ECS object data structure can see the object data from 「Infrastructure-Custom」

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
    "disks"                  : "[ {关联磁盘 JSON data}, ... ]",
    "network_interfaces"     : "[ {关联网卡 JSON data}, ... ]",
    "instance_renew_attribute": "[ {自动续费 JSON data}, ...]",
    "instances_full_status"  : "[ {全状态信息 JSON data}, ...]",
    "OperationLocks"         : "[ {锁定原因 JSON data}, ...]",
    "Memory"                 : "8192",
    "Cpu"                    : "4",
    "InternetMaxBandwidthOut": "0",
    "InternetMinBandwidthIn" : "0",
    "AutoReleaseTime"        : "xxxx",
    "message"                : "{Instance JSON data}"
  }
}
```

