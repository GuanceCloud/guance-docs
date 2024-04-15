---
title: 'Tencent Cloud CVM'
summary: 'Use the "Watch Cloud Sync" script package in the script market to synchronize the data of the cloud monitoring cloud assets to the watch cloud'
__int_icon: 'icon/tencent_cvm'
dashboard:

  - desc: 'Tencent Cloud CVM Dashboard'
    path: 'dashboard/zh/tencent_cvm'

monitor:
  - desc: 'Tencent Cloud CVM Monitor'
    path: 'monitor/zh/tencent_cvm'

---


<!-- markdownlint-disable MD025 -->
# Tencent Cloud CVM
<!-- markdownlint-enable -->
Use the "Watch Cloud Sync" script package in the script market to synchronize the data of the cloud monitoring cloud assets to the watch cloud


## Config {#config}

### Install Func

It is recommended to open Observation Cloud Integration-Extension-hosted Func: all preconditions are automatically installed, please continue with the script installation

If you want to deploy Func yourself refer to [deploy Func yourself](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install scripts

> Tip: Please prepare the required Ali Cloud AK in advance (for simplicity, you can directly grant global read-only permissions`ReadOnlyAccess`）

To synchronize the monitoring data of ECS cloud resources, we install the corresponding acquisition script:「Guance Integration（Tencent Cloud-CVMCollect）」(ID：`guance_tencentcloud_cvm`)

After clicking 【Install】, input the corresponding parameters: Ali Cloud AK, Ali cloud account name.

Click to【Deploy startup Script】，It will be created automatically `Startup` script set, and automatically configure the corresponding startup script.

It can be opened in「Management / Crontab Config」to see the corresponding auto-trigger configuration in. Click to【Run】, can be executed immediately once, without waiting for a regular time. After a few moments, you can review the execution of the task and the corresponding log.

> If you want to collect the corresponding log, you also need to start the corresponding log collection script. If you want to collect a bill, start the cloud bill collection script.


We collect some configurations by default, as described in the metrics column.

[Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verification

1. Into「Management / Crontab Config」to confirm whether the corresponding task has the corresponding automatic trigger configuration, and you can view the corresponding task record and log to check whether there is an exception.
2. At the Guance cloud platform, at the「Infrastructure / Custom」to see if the asset information exists.
3. At the Guance cloud platform, at the「Metrics」check to see if there is any monitoring data.

## Metrics {#metric}
Configuring Tencent Cloud-cloud monitoring, the default metric set is as follows, and more metrics can be collected through configuration [Tencent Cloud Monitor Metrics Details](https://cloud.tencent.com/document/product/248/6843){:target="_blank"}

### CPU Monitor

| Metric Name   | Illustrate                                                         | Unit | Dimension       | Statistical granularity                      |
| ------------- | ----------------------------------------------------------  | ---- | ---------- | ----------------------------- |
| `CpuUsage`     | Percentage of CPU occupied in real time while the machine is running      | %    | InstanceId | 10s、60s、300s、3600s、86400s |
| `CpuLoadavg`    | Average number of tasks using and waiting for CPU in 1 minute (Windows machines do not have this metric) | -    | InstanceId | 10s、60s、300s、3600s、86400s |
| `Cpuloadavg5m`  | Average number of tasks using and waiting for CPU in 5 minutes (not available on Windows machines) | -    | InstanceId | 60s、300s、3600s              |
| `Cpuloadavg15m` | Average number of tasks using and waiting for CPU in 15 minutes (not available on Windows machines) | -    | InstanceId | 60s、300s、3600s              |
| `BaseCpuUsage`  | The basic CPU utilization rate is collected and reported through the host machine, and the data can be viewed without installing the monitoring component. The data can still be collected and reported under the high load of the child machine | %    | InstanceId | 10s、60s、300s、3600s、86400s |

### GPU Monitor

| Metric Name       | Illustrate                                       | Unit | Dimension       | Statistical granularity                          |
| ----------------  | ------------------------------------------ | ---- | ---------- | --------------------------------- |
| GpuMemTotal       | GPU Total memory                               | MB   | InstanceId | 10s、 60s、 300s、 3600s、 86400s |
| GpuMemUsage       | GPU memory usage                             | %    | InstanceId | 10s、60s、300s、3600s、86400s     |
| GpuMemUsed        | Evaluate the memory footprint of the load                        | MB   | InstanceId | 10s、 60s、 300s、 3600s、 86400s |
| GpuPowDraw        | GPU Power consumption usage                             | W    | InstanceId | 10s、 60s、 300s、 3600s、 86400s |
| GpuPowLimit       | GPU Total power consumption                               | W    | InstanceId | 10s、 60s、 300s、 3600s、 86400s |
| GpuPowUsage       | GPU Power usage                             | %    | InstanceId | 10s、 60s、 300s、 3600s、 86400s |
| GpuTemp           | Evaluate the GPU heat dissipation status                          | °C   | InstanceId | 10s、 60s、 300s、 3600s、 86400s |
| GpuUtil           | Evaluate the computational power consumed by the load, the percentage of non-idle states | %    | InstanceId | 10s、 60s、 300s、 3600s、 86400s |

### Network Monitor

| Metric Name    | Illustrate                                                      | Unit  | Dimension       | Statistical granularity                      |
| -------------  | ------------------------------------------------------------ | ----- | ---------- | ----------------------------- |
| `LanOuttraffic`  | The average traffic per second of an internal network card               | Mbps  | InstanceId | 10s、60s、300s、3600s、86400s |
| `LanIntraffic`   | The average incoming traffic per second of an internal network card      | Mbps  | InstanceId | 10s、60s、300s、3600s、86400s |
| `LanOutpkg`      | The average number of packets per second of an internal network card     | individual per second | InstanceId | 10s、60s、300s、3600s、86400s |
| `LanInpkg`       | The average incoming packets per second of the internal network card     | individual per second| InstanceId | 10s、60s、300s、3600s、86400s |
| `WanOuttraffic`  | The average outgoing traffic rate of the external network per second, the minimum granularity data is calculated as 10 seconds total traffic /10 seconds, which is the sum of outgoing/incoming bandwidth of the external network of EIP+CLB+CVM | Mbps  | InstanceId | 10s、60s、300s、3600s、86400s |
| `WanIntraffic`   | The average incoming traffic rate of the external network per second, the minimum granularity data is calculated as 10 seconds total traffic /10 seconds, which is the sum of outgoing/incoming bandwidth of the external network of EIP+CLB+CVM | Mbps  | InstanceId | 10s、60s、300s、3600s、86400s |
| `WanOutpkg`      | The average number of outgoing packets per second of the external network card   | individual per second | InstanceId | 10s、60s、300s、3600s、86400s |
| `WanInpkg`       | The average incoming packets per second of the external network card    | individual per second | InstanceId | 10s、60s、300s、3600s、86400s |
| `AccOuttraffic`  | The average traffic per second of the external network card   | MB    | InstanceId | 10s、60s、300s、3600s、86400s |
| `TcpCurrEstab`   | The number of TCP connections in the ESTABLISHED state     | individual  | InstanceId | 10s、60s、300s、3600s、86400s |
| `TimeOffset`     | The difference between utc time and ntp time of the child      | second    | InstanceId | 60s、300s、3600s、86400s      |

### Memory Monitor

| Metric Name   | Illustrate                                                         | Unit | Dimension       | Statistical granularity                      |
| ---------- | ------------------------------------------------------------ | ---- | ---------- | ----------------------------- |
| MemUsed     | The actual amount of memory used by the user, excluding the memory occupied by buffers and system caches, the total memory-available memory (including buffers and cached) gets the memory usage value. Do not include the buffers and cached | MB | InstanceId | 10 s, 60 s and 300 s, 3600 s and 86400 s |

| MemUsage | user actual memory usage, not including the buffer cache memory, and system to remove the cache, buffer, and rest, Users actually use the memory and the ratio of the total memory | % | InstanceId | 10 s, 60 s and 300 s, 3600 s and 86400 s |

### Disk Monitor

| Metric Name   | Illustrate                                     | Unit | Dimension       | Statistical granularity  |
| ------------  | ---------------------------------------- | ---- | ---------- | --------- |
| CvmDiskUsage  | Disk used capacity as a percentage of total capacity (all disks) | %    | InstanceId | 60s、300s |

### **RDMA Monitor**

| Metric Name        | Illustrate         | Unit  | Dimension       | Statistical granularity                    |
| -----------------  | ------------------ | ----- | ---------- | --------------------------- |
| `RdmaIntraffic`      | **RDMA** network cards receive bandwidth  | Mbps  | InstanceId | 60s、 300s、 3600s、 86400s |
| `RdmaOuttraffic`     | **RDMA** network card send bandwidth | Mbps  | InstanceId | 60s、 300s、 3600s、 86400s |
| `RdmaInpkt`          | **RDMA** network card packet size    | individual per second | InstanceId | 60s、 300s、 3600s、 86400s |
| `RdmaOutpkt`         | **RDMA** network card output packets   | individual per second | InstanceId | 60s、 300s、 3600s、 86400s |
| `CnpCount`           | Congestion notification packet statistics   | individual per second | InstanceId | 60s、 300s、 3600s、 86400s |
| `EcnCount`           | Display congestion notification statistics   | individual per second | InstanceId | 60s、 300s、 3600s、 86400s |
| `RdmaPktDiscard`     | End measurement of packet loss        | individual per second | InstanceId | 60s、 300s、 3600s、 86400s |
| `RdmaOutOfSequence`  | The amount of out-of-order error at the receiver   | individual per second | InstanceId | 60s、 300s、 3600s、 86400s |
| `RdmaTimeoutCount`   | The amount of sender timeout error   | individual per second | InstanceId | 60s、 300s、 3600s、 86400s |
| `TxPfcCount`         | TX PFC statistics     | individual per second | InstanceId | 60s、 300s、 3600s、 86400s |
| `RxPfcCount`        | RX PFC statistics     | individual per second | InstanceId | 60s、 300s、 3600s、 86400s |

## Object {#object}
You could see the object data structure of the collected Tencent Cloud CVM objects obtained .

```json
{
  "measurement": "tencentcloud_cvm",
  "tags": {
    "name"              : "ins-bahxxxx",
    "RegionId"          : "ap-shanghai",
    "Zone"              : "ap-shanghai-1",
    "InstanceId"        : "ins-bahxxxx",
    "InstanceChargeType": "POSTPAID_BY_HOUR",
    "InstanceType"      : "SA2.MEDIUM2",
    "OsName"            : "TencentOS Server 3.1 (TK4)"
  },
  "fields": {
    "CPU"               : 2,
    "Memory"            : 2,
    "InstanceState"     : "RUNNING",
    "PublicIpAddresses" : "{Public network IP data}",
    "PrivateIpAddresses": "{Private network IP data}",
    "SystemDisk"        : "{System disk JSON data}",
    "DataDisks"         : "{data disk JSON data}",
    "Placement"         : "{Region JSON data}",
    "ExpiredTime"       : "2022-05-07T01:51:38Z",
    "message"           : "{Instance JSON data}"
  }
}
```

