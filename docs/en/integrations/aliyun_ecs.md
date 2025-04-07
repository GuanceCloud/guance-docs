---
title: 'Alibaba Cloud ECS'
tags: 
  - Alibaba Cloud
  - HOSTs
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

## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata)

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Enable Script

> Note: Please prepare the required Alibaba Cloud AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

#### Script for Enabling Managed Version

1. Log in to the <<< custom_key.brand_name >>> console
2. Click on the 【Manage】 menu, select 【Cloud Account Management】
3. Click 【Add Cloud Account】, select 【Alibaba Cloud】, fill in the required information on the interface; if cloud account information has been configured before, skip this step
4. Click 【Test】, after a successful test, click 【Save】; if the test fails, check whether the related configuration information is correct and retest
5. In the 【Cloud Account Management】 list, you can see the added cloud account, click on the corresponding cloud account to enter the details page
6. Click the 【Integration】 button on the cloud account detail page, in the `Not Installed` list, find `Alibaba Cloud ECS`, click the 【Install】 button, and install it via the installation interface.


#### Manual Enable Script

1. Log in to the Func console, click 【Script Market】, go to the official script market, and search for:`guance_aliyun_ecs`

2. After clicking 【Install】, input the corresponding parameters: Alibaba Cloud AK ID, AK Secret, and account name.

3. Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and configure the corresponding startup script.

4. After enabling, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】 to run immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.


We default collect some configurations, see the metric column for details.

[Configure Custom Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. Confirm in 「Management / Automatic Trigger Configuration」 that the corresponding task has an automatic trigger configuration, and check the corresponding task records and logs for any abnormalities.
2. In <<< custom_key.brand_name >>>, under 「Infrastructure / Custom」, check if there is asset information.
3. In <<< custom_key.brand_name >>>, under 「Metrics」, check if there are corresponding monitoring data.

## Metrics {#metric}

After configuring Alibaba Cloud - Cloud Monitor, the default metric set is as follows. You can collect more metrics through configuration. [Alibaba Cloud Cloud Monitor Metric Details](https://cms.console.aliyun.com/metric-meta/acs_ecs_dashboard/ecs?spm=a2c4g.11186623.0.0.252476abTrNabN){:target="_blank"}

> Note: The monitoring plugin needs to be installed in the Aliyun ECS console.

| Metric | Description                         | Type | Unit |
| ---- |-------------------------------------| :---:    | :----: |
|`CPUUtilization`| CPU utilization                              |float|%|
|`memory_usedutilization`| Memory utilization                               |float|%|
|`load_1m`| load.1m                             |float|count|
|`load_15m`| load.15m                            |float|count|
|`load_5m`| load.5m                             |float|count|
|`DiskReadBPS`| All disk read BPS                           |float|bytes/s|
|`DiskWriteBPS`| All disk write BPS                           |float|bytes/s|
|`DiskReadIOPS`| All disk read count per second                          |float|Count/Second|
|`DiskWriteIOPS`| All disk write count per second                          |float|Count/Second|
|`disk_readiops`| Disk read count per second                            |float|Count/Second|
|`disk_writeiops`| Disk write count per second                            |float|Count/Second|
|`diskusage_utilization`| `HOST.diskusage.utilization`        |float|%|
|`fs_inodeutilization`| (Agent)fs.inode.utilization_device  |float|%|
|`GroupVPC_PublicIP_InternetInRate`| Public IP dimension inbound bandwidth                          |float|bits/s|
|`GroupVPC_PublicIP_InternetOutRate`| Public IP dimension outbound bandwidth                          |float|bits/s|
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

The collected Alibaba Cloud ECS object data structure can be seen in 「Infrastructure - Custom」

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