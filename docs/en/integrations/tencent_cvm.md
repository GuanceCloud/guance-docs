---
title: 'Tencent Cloud CVM'
tags: 
  - Tencent Cloud
summary: 'Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>'
__int_icon: 'icon/tencent_cvm'
dashboard:

  - desc: 'Tencent Cloud CVM built-in view'
    path: 'dashboard/en/tencent_cvm'

monitor:
  - desc: 'Tencent Cloud CVM monitor'
    path: 'monitor/en/tencent_cvm'

---


<!-- markdownlint-disable MD025 -->
# Tencent Cloud CVM
<!-- markdownlint-enable -->
Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>


## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites will be automatically installed, please continue with the script installation

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Please prepare a qualified Alibaba Cloud AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize CVM monitoring data, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (Tencent Cloud-CVM Collection)" (ID: `guance_tencentcloud_cvm`)

After clicking 【Install】, input the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the regular time. After a while, you can check the execution task records and corresponding logs.

> If you want to collect the corresponding logs, you also need to enable the corresponding log collection script. If you want to collect billing information, you need to enable the cloud billing collection script.


We default to collecting some configurations, see the metrics section for details.

[Configure custom cloud object metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and at the same time, you can view the corresponding task records and logs to check for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, under "Infrastructure / Custom", check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, under "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Tencent Cloud - Cloud Monitoring, the default metric sets are as follows. You can collect more metrics through configuration. [Tencent Cloud Cloud Monitoring Metric Details](https://cloud.tencent.com/document/product/248/6843){:target="_blank"}

### CPU Monitoring

| Metric English Name | Metric Chinese Name | Description | Unit | Dimension | Statistical Granularity |
| --------------------|-------------------- |-------------|------|-----------|------------------------|
| `CpuUsage`          | CPU Utilization Rate | The real-time percentage of CPU usage during machine operation | %    | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `CpuLoadavg`        | CPU One-minute Average Load | The average number of tasks using and waiting to use the CPU within one minute (Windows machines do not have this metric) | -    | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `Cpuloadavg5m`      | CPU Five-minute Average Load | The average number of tasks using and waiting to use the CPU within five minutes (Windows machines do not have this metric) | -    | `InstanceId` | 60s、300s、3600s              |
| `Cpuloadavg15m`     | CPU Fifteen-minute Average Load | The average number of tasks using and waiting to use the CPU within fifteen minutes (Windows machines do not have this metric) | -    | `InstanceId` | 60s、300s、3600s              |
| `BaseCpuUsage`       | Base CPU Usage Rate | The base CPU usage rate is collected and reported via the host machine, no need to install monitoring components to view data, and data can still be continuously collected and reported even when the sub-machine is under high load | %    | `InstanceId` | 10s、60s、300s、3600s、86400s |

### GPU Monitoring

| Metric English Name | Metric Chinese Name | Description | Unit | Dimension | Statistical Granularity |
| --------------------|-------------------- |-------------|------|-----------|------------------------|
| `GpuMemTotal`       | Total GPU Memory   | Total GPU memory | MB   | `InstanceId` | 10s、 60s、 300s、 3600s、 86400s |
| `GpuMemUsage`       | GPU Memory Usage Rate | GPU memory usage rate | %    | `InstanceId` | 10s、60s、300s、3600s、86400s     |
| `GpuMemUsed`        | GPU Memory Used | Assess the memory usage under load | MB   | `InstanceId` | 10s、 60s、 300s、 3600s、 86400s |
| `GpuPowDraw`        | GPU Power Consumption | GPU power consumption | W    | `InstanceId` | 10s、 60s、 300s、 3600s、 86400s |
| `GpuPowLimit`       | Total GPU Power | Total GPU power | W    | `InstanceId` | 10s、 60s、 300s、 3600s、 86400s |
| `GpuPowUsage`       | GPU Power Usage Rate | GPU power usage rate | %    | `InstanceId` | 10s、 60s、 300s、 3600s、 86400s |
| `GpuTemp`           | GPU Temperature | Assess GPU cooling status | °C   | `InstanceId` | 10s、 60s、 300s、 3600s、 86400s |
| `GpuUtil`           | GPU Usage Rate | Assess the computational capability consumed by the load, non-idle state percentage | %    | `InstanceId` | 10s、 60s、 300s、 3600s、 86400s |

### Network Monitoring

| Metric English Name | Metric Chinese Name | Description | Unit | Dimension | Statistical Granularity |
| --------------------|-------------------- |-------------|------|-----------|------------------------|
| `LanOuttraffic`     | Internal Network Outbound Bandwidth | Average outbound traffic per second on the internal network card | Mbps  | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `LanIntraffic`      | Internal Network Inbound Bandwidth | Average inbound traffic per second on the internal network card | Mbps  | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `LanOutpkg`         | Internal Network Outbound Packet Volume | Average outbound packet volume per second on the internal network card | packets/sec | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `LanInpkg`          | Internal Network Inbound Packet Volume | Average inbound packet volume per second on the internal network card | packets/sec | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `WanOuttraffic`     | External Network Outbound Bandwidth | Average outbound traffic rate per second on the external network, calculated from the total 10-second traffic divided by 10 seconds, which represents the total external outbound/inbound bandwidth of EIP+CLB+CVM | Mbps  | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `WanIntraffic`      | External Network Inbound Bandwidth | Average inbound traffic rate per second on the external network, calculated from the total 10-second traffic divided by 10 seconds, which represents the total external outbound/inbound bandwidth of EIP+CLB+CVM | Mbps  | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `WanOutpkg`         | External Network Outbound Packet Volume | Average outbound packet volume per second on the external network card | packets/sec | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `WanInpkg`          | External Network Inbound Packet Volume | Average inbound packet volume per second on the external network card | packets/sec | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `AccOuttraffic`     | External Network Outbound Traffic | Average outbound traffic per second on the external network card | MB    | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `TcpCurrEstab`      | TCP Connections | Number of TCP connections in ESTABLISHED state | count | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `TimeOffset`        | Sub-machine UTC Time Difference from NTP | Difference between sub-machine UTC time and NTP time | seconds | `InstanceId` | 60s、300s、3600s、86400s |

### Memory Monitoring

| Metric English Name | Metric Chinese Name | Description | Unit | Dimension | Statistical Granularity |
| --------------------|-------------------- |-------------|------|-----------|------------------------|
| `MemUsed`           | Memory Used | Actual memory used by users, excluding buffer and system cache memory usage, total memory - available memory (including buffers & cached) gives the memory usage value, excluding buffers and cached | MB   | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `MemUsage`          | Memory Usage Rate | Actual user memory usage rate, excluding buffer and system cache memory usage, ratio of actual user memory usage to total memory excluding cache, buffer, and remaining | %    | `InstanceId` | 10s、60s、300s、3600s、86400s |

### Disk Monitoring

| Metric English Name | Metric Chinese Name | Description | Unit | Dimension | Statistical Granularity |
| --------------------|-------------------- |-------------|------|-----------|------------------------|
| `CvmDiskUsage`      | Disk Usage Rate | Percentage of used disk capacity out of total capacity (all disks) | %    | `InstanceId` | 60s、300s |

### **RDMA** Monitoring

| Metric English Name | Metric Chinese Name | Metric Description (optional) | Unit | Dimension | Statistical Granularity |
| --------------------|-------------------- |------------------------------|------|-----------|------------------------|
| `RdmaIntraffic`     | RDMA NIC Receive Bandwidth | RDMA NIC receive bandwidth | Mbps  | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `RdmaOuttraffic`    | RDMA NIC Send Bandwidth | RDMA NIC send bandwidth | Mbps  | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `RdmaInpkt`         | RDMA NIC Inbound Packet Volume | RDMA NIC inbound packet volume | packets/sec | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `RdmaOutpkt`        | RDMA NIC Outbound Packet Volume | RDMA NIC outbound packet volume | packets/sec | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `CnpCount`          | CNP Statistics | Congestion notification message statistics | packets/sec | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `EcnCount`          | ECN Statistics | Display congestion notification statistics | packets/sec | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `RdmaPktDiscard`    | Endpoint Packet Loss Volume | Endpoint packet loss volume | packets/sec | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `RdmaOutOfSequence` | Receiver Out-of-order Error Volume | Receiver out-of-order error volume | packets/sec | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `RdmaTimeoutCount`  | Sender Timeout Error Volume | Sender timeout error volume | packets/sec | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `TxPfcCount`        | TX PFC Statistics | TX PFC Statistics | packets/sec | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `RxPfcCount`        | RX PFC Statistics | RX PFC Statistics | packets/sec | `InstanceId` | 60s、 300s、 3600s、 86400s |

## Objects {#object}

The Tencent Cloud CVM object data structure collected can be seen in "Infrastructure - Custom".

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
    "PublicIpAddresses" : "{Public IP Data}",
    "PrivateIpAddresses": "{Private IP Data}",
    "SystemDisk"        : "{System Disk JSON Data}",
    "DataDisks"         : "{Data Disk JSON Data}",
    "Placement"         : "{Region JSON Data}",
    "ExpiredTime"       : "2022-05-07T01:51:38Z",
    "message"           : "{Instance JSON Data}"
  }
}
```