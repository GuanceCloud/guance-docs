---
title: 'Tencent Cloud CVM'
tags: 
  - Tencent Cloud
summary: 'Use the script packages in the script market of Guance series to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/tencent_cvm'
dashboard:

  - desc: 'Built-in View for Tencent Cloud CVM'
    path: 'dashboard/en/tencent_cvm'

monitor:
  - desc: 'Tencent Cloud CVM Monitor'
    path: 'monitor/en/tencent_cvm'

---


<!-- markdownlint-disable MD025 -->
# Tencent Cloud CVM
<!-- markdownlint-enable -->
Use the script packages in the script market of Guance series to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed, please proceed with the script installation

If you deploy Func on your own, refer to [Deploy Func on Your Own](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Please prepare a qualified Alibaba Cloud AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize CVM monitoring data, we install the corresponding collection script: "Guance Integration (Tencent Cloud-CVM Collection)" (ID: `guance_tencentcloud_cvm`)

After clicking [Install], enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click [Deploy Startup Script], the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Click [Execute] to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, you should also enable the corresponding log collection script. If you need to collect billing information, enable the cloud billing collection script.


We default to collecting some configurations; see the Metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configurations. You can also check the corresponding task records and logs to ensure there are no anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, under "Metrics", check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Tencent Cloud Cloud Monitoring, the default metric sets are as follows. You can collect more metrics through configuration [Tencent Cloud Cloud Monitoring Metric Details](https://cloud.tencent.com/document/product/248/6843){:target="_blank"}

### CPU Monitoring

| Metric English Name | Metric Chinese Name | Description                                                     | Unit | Dimension     | Statistical Granularity                    |
| ------------------- | ------------------- | --------------------------------------------------------------- | ---- | ------------- | ------------------------------------------ |
| `CpuUsage`          | CPU Utilization     | Real-time percentage of CPU usage during machine operation      | %    | `InstanceId`  | 10s、60s、300s、3600s、86400s             |
| `CpuLoadavg`        | 1-Minute Average Load | Average number of tasks using or waiting for CPU within 1 minute (Windows machines do not have this metric) | -    | `InstanceId`  | 10s、60s、300s、3600s、86400s             |
| `Cpuloadavg5m`      | 5-Minute Average Load | Average number of tasks using or waiting for CPU within 5 minutes (Windows machines do not have this metric) | -    | `InstanceId`  | 60s、300s、3600s                          |
| `Cpuloadavg15m`     | 15-Minute Average Load | Average number of tasks using or waiting for CPU within 15 minutes (Windows machines do not have this metric) | -    | `InstanceId`  | 60s、300s、3600s                          |
| `BaseCpuUsage`      | Base CPU Usage      | Base CPU usage reported by the host machine without installing monitoring components, still collects data under high load conditions | %    | `InstanceId`  | 10s、60s、300s、3600s、86400s             |

### GPU Monitoring

| Metric English Name | Metric Chinese Name | Description                                             | Unit | Dimension     | Statistical Granularity                      |
| ------------------- | ------------------- | ------------------------------------------------------- | ---- | ------------- | -------------------------------------------- |
| `GpuMemTotal`       | Total GPU Memory    | Total GPU memory                                        | MB   | `InstanceId`  | 10s、60s、300s、3600s、86400s               |
| `GpuMemUsage`       | GPU Memory Usage    | GPU memory usage rate                                    | %    | `InstanceId`  | 10s、60s、300s、3600s、86400s               |
| `GpuMemUsed`        | GPU Memory Used     | Assess memory usage                                      | MB   | `InstanceId`  | 10s、60s、300s、3600s、86400s               |
| `GpuPowDraw`        | GPU Power Draw      | GPU power consumption                                    | W    | `InstanceId`  | 10s、60s、300s、3600s、86400s               |
| `GpuPowLimit`       | Total GPU Power     | Total GPU power                                          | W    | `InstanceId`  | 10s、60s、300s、3600s、86400s               |
| `GpuPowUsage`       | GPU Power Usage Rate | GPU power consumption rate                               | %    | `InstanceId`  | 10s、60s、300s、3600s、86400s               |
| `GpuTemp`           | GPU Temperature     | Evaluate GPU cooling status                              | °C   | `InstanceId`  | 10s、60s、300s、3600s、86400s               |
| `GpuUtil`           | GPU Utilization     | Evaluate computational power consumed by load, non-idle state percentage | %    | `InstanceId`  | 10s、60s、300s、3600s、86400s               |

### Network Monitoring

| Metric English Name | Metric Chinese Name | Description                                                                 | Unit  | Dimension     | Statistical Granularity                      |
| ------------------- | ------------------- | --------------------------------------------------------------------------- | ----- | ------------- | -------------------------------------------- |
| `LanOuttraffic`     | Internal Outbound Bandwidth | Average outbound traffic per second on internal network interface           | Mbps  | `InstanceId`  | 10s、60s、300s、3600s、86400s               |
| `LanIntraffic`      | Internal Inbound Bandwidth | Average inbound traffic per second on internal network interface            | Mbps  | `InstanceId`  | 10s、60s、300s、3600s、86400s               |
| `LanOutpkg`         | Internal Outbound Packets | Average number of packets sent per second on internal network interface     | pkts/s | `InstanceId`  | 10s、60s、300s、3600s、86400s               |
| `LanInpkg`          | Internal Inbound Packets | Average number of packets received per second on internal network interface | pkts/s | `InstanceId`  | 10s、60s、300s、3600s、86400s               |
| `WanOuttraffic`     | External Outbound Bandwidth | Average external outbound traffic per second, minimum granularity data is total 10-second traffic divided by 10 seconds, this data is the sum of EIP+CLB+CVM external bandwidth | Mbps  | `InstanceId`  | 10s、60s、300s、3600s、86400s               |
| `WanIntraffic`      | External Inbound Bandwidth | Average external inbound traffic per second, minimum granularity data is total 10-second traffic divided by 10 seconds, this data is the sum of EIP+CLB+CVM external bandwidth | Mbps  | `InstanceId`  | 10s、60s、300s、3600s、86400s               |
| `WanOutpkg`         | External Outbound Packets | Average number of packets sent per second on external network interface     | pkts/s | `InstanceId`  | 10s、60s、300s、3600s、86400s               |
| `WanInpkg`          | External Inbound Packets | Average number of packets received per second on external network interface | pkts/s | `InstanceId`  | 10s、60s、300s、3600s、86400s               |
| `AccOuttraffic`     | External Outbound Traffic | Average external outbound traffic per second on external network interface | MB    | `InstanceId`  | 10s、60s、300s、3600s、86400s               |
| `TcpCurrEstab`      | TCP Connections     | Number of TCP connections in ESTABLISHED state                             | count | `InstanceId`  | 10s、60s、300s、3600s、86400s               |
| `TimeOffset`        | Submachine UTC Time Difference | Difference between submachine UTC time and NTP time                        | sec   | `InstanceId`  | 60s、300s、3600s、86400s                     |

### Memory Monitoring

| Metric English Name | Metric Chinese Name | Description                                                                 | Unit | Dimension     | Statistical Granularity                      |
| ------------------- | ------------------- | --------------------------------------------------------------------------- | ---- | ------------- | -------------------------------------------- |
| `MemUsed`           | Memory Used         | Actual user memory usage excluding buffer and system cache                 | MB   | `InstanceId`  | 10s、60s、300s、3600s、86400s               |
| `MemUsage`          | Memory Usage Rate   | Actual user memory usage rate excluding buffer and system cache             | %    | `InstanceId`  | 10s、60s、300s、3600s、86400s               |

### Disk Monitoring

| Metric English Name | Metric Chinese Name | Description                                           | Unit | Dimension     | Statistical Granularity |
| ------------------- | ------------------- | ----------------------------------------------------- | ---- | ------------- | ----------------------- |
| `CvmDiskUsage`      | Disk Usage Rate     | Percentage of used disk capacity out of total capacity | %    | `InstanceId`  | 60s、300s              |

### **RDMA** Monitoring

| Metric English Name | Metric Chinese Name | Metric Description (Optional) | Unit  | Dimension     | Statistical Granularity                    |
| ------------------- | ------------------- | ---------------------------- | ----- | ------------- | ------------------------------------------ |
| `RdmaIntraffic`     | RDMA NIC Receive Bandwidth | RDMA NIC receive bandwidth  | Mbps  | `InstanceId`  | 60s、300s、3600s、86400s                  |
| `RdmaOuttraffic`    | RDMA NIC Send Bandwidth    | RDMA NIC send bandwidth     | Mbps  | `InstanceId`  | 60s、300s、3600s、86400s                  |
| `RdmaInpkt`         | RDMA NIC Inbound Packets   | RDMA NIC inbound packets    | pkts/s | `InstanceId`  | 60s、300s、3600s、86400s                  |
| `RdmaOutpkt`        | RDMA NIC Outbound Packets  | RDMA NIC outbound packets   | pkts/s | `InstanceId`  | 60s、300s、3600s、86400s                  |
| `CnpCount`          | CNP Statistics       | Congestion notification packet statistics | pkts/s | `InstanceId`  | 60s、300s、3600s、86400s                  |
| `EcnCount`          | ECN Statistics       | Explicit congestion notification statistics | pkts/s | `InstanceId`  | 60s、300s、3600s、86400s                  |
| `RdmaPktDiscard`    | Packet Drop Count    | Packet drop count at endpoint | pkts/s | `InstanceId`  | 60s、300s、3600s、86400s                  |
| `RdmaOutOfSequence` | Out-of-Order Errors  | Receiver-side out-of-order errors | pkts/s | `InstanceId`  | 60s、300s、3600s、86400s                  |
| `RdmaTimeoutCount`  | Sender Timeout Errors | Sender-side timeout errors | pkts/s | `InstanceId`  | 60s、300s、3600s、86400s                  |
| `TxPfcCount`        | TX PFC Statistics    | TX PFC statistics | pkts/s | `InstanceId`  | 60s、300s、3600s、86400s                  |
| `RxPfcCount`        | RX PFC Statistics    | RX PFC statistics | pkts/s | `InstanceId`  | 60s、300s、3600s、86400s                  |

## Objects {#object}

The collected Tencent Cloud CVM object data structure can be viewed from "Infrastructure - Custom".

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