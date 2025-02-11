---
title: 'Tencent Cloud CVM'
tags: 
  - Tencent Cloud
summary: 'Use the script packages in the Script Market series "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance'
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
Use the script packages in the Script Market series "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable Guance integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed, please proceed with script installation

If you deploy Func on your own, refer to [Deploy Func on Your Own](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Please prepare a qualified Alibaba Cloud AK in advance (for simplicity, you can directly grant read-only access `ReadOnlyAccess`)

To synchronize CVM monitoring data, install the corresponding collection script: "Guance Integration (Tencent Cloud-CVM Collection)" (ID: `guance_tencentcloud_cvm`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Once enabled, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click 【Execute】to run it immediately without waiting for the scheduled time. Wait a moment, then check the execution task records and corresponding logs.

> If you need to collect corresponding logs, also enable the corresponding log collection script. If you need to collect billing information, enable the cloud billing collection script.


By default, we collect some configurations; for more details, see the Metrics section

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm that the corresponding task has an automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Tencent Cloud-Cloud Monitoring, the default metric sets are as follows. You can collect more metrics through configuration. [Details of Tencent Cloud Cloud Monitoring Metrics](https://cloud.tencent.com/document/product/248/6843){:target="_blank"}

### CPU Monitoring

| Metric Name      | Metric Description           | Explanation                                                         | Unit | Dimension         | Statistical Granularity                      |
| --------------- | -------------------- | ------------------------------------------------------------ | ---- | ------------ | ----------------------------- |
| `CpuUsage`      | CPU Utilization           | Real-time percentage of CPU usage during machine operation                            | %    | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `CpuLoadavg`    | CPU One-Minute Average Load   | Average number of tasks using or waiting to use the CPU over 1 minute (not available for Windows machines) | -    | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `Cpuloadavg5m`  | CPU Five-Minute Average Load   | Average number of tasks using or waiting to use the CPU over 5 minutes (not available for Windows machines) | -    | `InstanceId` | 60s、300s、3600s              |
| `Cpuloadavg15m` | CPU Fifteen-Minute Average Load | Average number of tasks using or waiting to use the CPU over 15 minutes (not available for Windows machines) | -    | `InstanceId` | 60s、300s、3600s              |
| `BaseCpuUsage`  | Base CPU Usage      | Base CPU usage collected from the host machine, no need to install monitoring components to view data, continues to collect data even under high load conditions | %    | `InstanceId` | 10s、60s、300s、3600s、86400s |

### GPU Monitoring

| Metric Name    | Metric Description     | Explanation                                       | Unit | Dimension         | Statistical Granularity                          |
| ------------- | -------------- | ------------------------------------------ | ---- | ------------ | --------------------------------- |
| `GpuMemTotal` | Total GPU Memory   | Total GPU memory                               | MB   | `InstanceId` | 10s、 60s、 300s、 3600s、 86400s |
| `GpuMemUsage` | GPU Memory Utilization | GPU memory utilization                             | %    | `InstanceId` | 10s、60s、300s、3600s、86400s     |
| `GpuMemUsed`  | GPU Memory Used  | Evaluate the VRAM occupancy                         | MB   | `InstanceId` | 10s、 60s、 300s、 3600s、 86400s |
| `GpuPowDraw`  | GPU Power Consumption  | GPU power consumption                             | W    | `InstanceId` | 10s、 60s、 300s、 3600s、 86400s |
| `GpuPowLimit` | Total GPU Power   | Total GPU power                               | W    | `InstanceId` | 10s、 60s、 300s、 3600s、 86400s |
| `GpuPowUsage` | GPU Power Utilization | GPU power utilization                             | %    | `InstanceId` | 10s、 60s、 300s、 3600s、 86400s |
| `GpuTemp`     | GPU Temperature       | Evaluate the GPU cooling state                          | °C   | `InstanceId` | 10s、 60s、 300s、 3600s、 86400s |
| `GpuUtil`     | GPU Utilization     | Evaluate the computational power consumed by the load, non-idle state percentage | %    | `InstanceId` | 10s、 60s、 300s、 3600s、 86400s |

### Network Monitoring

| Metric Name      | Metric Description                   | Explanation                                                         | Unit  | Dimension         | Statistical Granularity                      |
| --------------- | ---------------------------- | ------------------------------------------------------------ | ----- | ------------ | ----------------------------- |
| `LanOuttraffic` | Internal Network Outbound Bandwidth                   | Average outbound traffic per second on the internal network card                                     | Mbps  | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `LanIntraffic`  | Internal Network Inbound Bandwidth                   | Average inbound traffic per second on the internal network card                                     | Mbps  | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `LanOutpkg`     | Internal Network Outbound Packet Rate                   | Average outbound packet rate per second on the internal network card                                     | Packets/sec | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `LanInpkg`      | Internal Network Inbound Packet Rate                   | Average inbound packet rate per second on the internal network card                                     | Packets/sec | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `WanOuttraffic` | External Network Outbound Bandwidth                   | Average external outbound traffic rate per second, minimum granularity data is total 10-second traffic divided by 10 seconds, this data is the sum of EIP+CLB+CVM external outbound/inbound bandwidth | Mbps  | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `WanIntraffic`  | External Network Inbound Bandwidth                   | Average external inbound traffic rate per second, minimum granularity data is total 10-second traffic divided by 10 seconds, this data is the sum of EIP+CLB+CVM external outbound/inbound bandwidth | Mbps  | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `WanOutpkg`     | External Network Outbound Packet Rate                   | Average outbound packet rate per second on the external network card                                     | Packets/sec | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `WanInpkg`      | External Network Inbound Packet Rate                   | Average inbound packet rate per second on the external network card                                     | Packets/sec | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `AccOuttraffic` | External Network Outbound Traffic                   | Average outbound traffic per second on the external network card                                     | MB    | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `TcpCurrEstab`  | TCP Connections                   | Number of TCP connections in ESTABLISHED state                         | Count    | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `TimeOffset`    | Submachine UTC Time Difference with NTP Time | Submachine UTC time difference with NTP time                                 | Seconds    | `InstanceId` | 60s、300s、3600s、86400s      |

### Memory Monitoring

| Metric Name | Metric Description | Explanation                                                         | Unit | Dimension         | Statistical Granularity                      |
| ---------- | ---------- | ------------------------------------------------------------ | ---- | ------------ | ----------------------------- |
| `MemUsed`  | Memory Used | Actual memory used by users, excluding buffer and system cache, total memory - available memory (including buffers & cached) gives the memory used value, not including buffers and cached | MB   | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `MemUsage` | Memory Utilization | Actual user memory utilization, excluding buffer and system cache, user actual memory usage ratio to total memory | %    | `InstanceId` | 10s、60s、300s、3600s、86400s |

### Disk Monitoring

| Metric Name     | Metric Description | Explanation                                     | Unit | Dimension         | Statistical Granularity  |
| -------------- | ---------- | ---------------------------------------- | ---- | ------------ | --------- |
| `CvmDiskUsage` | Disk Utilization | Percentage of disk used capacity out of total capacity (all disks) | %    | `InstanceId` | 60s、300s |

### **RDMA** Monitoring

| Metric Name          | Metric Description        | Metric Explanation (Optional) | Unit  | Dimension         | Statistical Granularity                    |
| ------------------- | ----------------- | ------------------ | ----- | ------------ | --------------------------- |
| `RdmaIntraffic`     | RDMA NIC Receive Bandwidth | RDMA NIC receive bandwidth  | Mbps  | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `RdmaOuttraffic`    | RDMA NIC Send Bandwidth | RDMA NIC send bandwidth  | Mbps  | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `RdmaInpkt`         | RDMA NIC Inbound Packet Rate   | RDMA NIC inbound packet rate    | Packets/sec | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `RdmaOutpkt`        | RDMA NIC Outbound Packet Rate   | RDMA NIC outbound packet rate    | Packets/sec | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `CnpCount`          | CNP Statistics        | Congestion notification message statistics   | Packets/sec | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `EcnCount`          | ECN Statistics        | Explicit congestion notification statistics   | Packets/sec | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `RdmaPktDiscard`    | Endpoint Packet Drop Rate        | Endpoint packet drop rate         | Packets/sec | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `RdmaOutOfSequence` | Receiver Out-of-Order Error Rate  | Receiver out-of-order error rate   | Packets/sec | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `RdmaTimeoutCount`  | Sender Timeout Error Rate  | Sender timeout error rate   | Packets/sec | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `TxPfcCount`        | TX PFC Statistics     | TX PFC statistics      | Packets/sec | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `RxPfcCount`        | RX PFC Statistics     | RX PFC statistics      | Packets/sec | `InstanceId` | 60s、 300s、 3600s、 86400s |

## Objects {#object}

The structure of collected Tencent Cloud CVM object data can be viewed under "Infrastructure - Custom".

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
    "PublicIpAddresses" : "{public IP data}",
    "PrivateIpAddresses": "{private IP data}",
    "SystemDisk"        : "{system disk JSON data}",
    "DataDisks"         : "{data disk JSON data}",
    "Placement"         : "{region JSON data}",
    "ExpiredTime"       : "2022-05-07T01:51:38Z",
    "message"           : "{instance JSON data}"
  }
}
```