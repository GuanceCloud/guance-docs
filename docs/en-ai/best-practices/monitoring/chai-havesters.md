# Chia Harvesters Best Practices

---

## Introduction
Chia users need to perform real-time monitoring of Harvesters across multiple hosts, analyzing the availability, status, and profitability of different Harvesters in detail. This enhances Chia users' control over their Harvesters. Dataflux adopts active and passive monitoring with a comprehensive anomaly detection module that aligns closely with the needs of Chia users. It builds a unified Chia business management platform for users to have an intuitive overview of Harvester operations globally, improving output efficiency and facilitating troubleshooting for Harvester failures or insufficient expected profits. Additionally, it offers expert-level Chia performance services and on-site support services to help Chia users achieve higher returns. Key areas that need monitoring are:

- **Harvesters**

- **CPU**
- **Memory**
- **Disk**
- **Network**

## Scene View

![image.png](../images/chai-havesters-1.png)

## Built-in Views

## Disk

![image.png](../images/chai-havesters-2.png)

## Prerequisites

DataKit has been installed ([DataKit Installation Documentation](/datakit/datakit-install/))

## Configuration

### Log Collection

This example uses a Windows client (Linux is similar).

#### Create a chia farm log collection script

Git is installed ([Git Installation Reference](https://git-scm.com/))

Navigate to the `chia-blockchain` directory (`C:\Users\{your user}\AppData\Local\chia-blockchain\app-{your chia version}\resources\app.asar.unpacked\daemon`) and create a log collection script named `farmer.sh`, saving the Chia client farm information to `farmer.log`.

> First, create a `data_collect` folder in `C:\Users\{your user}\AppData\Local\chia-blockchain\app-{your chia version}\`

```shell
#!/bin/bash

while true; do
    sleep 2
    ./chia.exe farm summary | awk '{line=line "," $0} NR%10==0{print substr(line,1); line=""}' >> ../../../data_collect/farmer.log
done
```

### DataKit Pipeline Configuration
Navigate to the `pipeline` directory under the DataKit installation directory and create `farm_log.p` and `chia_debug_log.p` to process the collected logs. Example as follows:
#### chia_debug_log.p
```shell
# chia_debug_log
# Name	Description
# strptime($timestamp, "2006-01-02T15:04:05") 
# total_plots  Number of Plots
# eligible_plots   Number of Eligible Plots
# proofs_found   Number of Proofs Found
# check_duration  Query Time

# Log Example:
# 2021-04-24T11:01:53.390 harvester chia.harvester.harvester: INFO     1 plots were eligible for farming 940b588c2a... Found 0 proofs. Time: 0.98087 s. Total 19 plots


grok(_, "%{TIMESTAMP_ISO8601:strptime} harvester chia.harvester.harvester: INFO \\s+ %{NUMBER:eligible_plots} plots were eligible for farming \\w+\\.\\.\\. Found %{NUMBER:proofs_found} proofs\\. Time: %{NUMBER:check_duration} s\\. Total %{NUMBER:total_plots} plots.*")

# Convert data types
cast(eligible_plots, "float")
cast(proofs_found, "float")
cast(check_duration, "float")
cast(total_plots, "float")

# Drop original content
drop_origin_data()
```
#### farm_log.p
```shell
# farm_log
# Name	Description
# farming_status  Farmer Status
# xch_count	 XCH Mined
# last_farm_height  Farm Height
# total_plot  Number of Plots
# total_plots_size_GiB Plot Size in GiB
# total_plots_size_TiB Plot Size in TiB
# total_plots_size_PiB Plot Size in PiB
# network_space   Network Space in PiB

# Log Example:
#,Farming status: Farming,Total chia farmed: 0.0,User transaction fees: 0.0,Block rewards: 0.0,Last height farmed: 0,Plot count: 137,Total size of plots: 13.561 TiB,Estimated network space: 12457.266 PiB,Expected time to win: 5 months and 4 weeks,Note: log into your key using 'chia wallet show' to see rewards for each key

grok(_, ",Farming status: %{WORD:farming_status},Total chia farmed: %{NUMBER:xch_count},User transaction fees: %{NUMBER},Block rewards: %{NUMBER},Last height farmed: %{NUMBER:last_farm_height},Plot count: %{NUMBER:total_plot},Total size of plots: %{NUMBER:total_plots_size_GiB} GiB,Estimated network space: %{NUMBER:network_space_PiB} PiB.*")
grok(_, ",Farming status: %{WORD:farming_status},Total chia farmed: %{NUMBER:xch_count},User transaction fees: %{NUMBER},Block rewards: %{NUMBER},Last height farmed: %{NUMBER:last_farm_height},Plot count: %{NUMBER:total_plot},Total size of plots: %{NUMBER:total_plots_size_TiB} TiB,Estimated network space: %{NUMBER:network_space_PiB} PiB.*")
grok(_, ",Farming status: %{WORD:farming_status},Total chia farmed: %{NUMBER:xch_count},User transaction fees: %{NUMBER},Block rewards: %{NUMBER},Last height farmed: %{NUMBER:last_farm_height},Plot count: %{NUMBER:total_plot},Total size of plots: %{NUMBER:total_plots_size_PiB} PiB,Estimated network space: %{NUMBER:network_space_PiB} PiB.*")

# Convert data types
cast(farming_status, "str")
cast(xch_count, "float")
cast(last_farm_height, "float")
cast(total_plot, "float")
cast(total_plots_size_GiB, "float")
cast(total_plots_size_TiB, "float")
cast(total_plots_size_PiB, "float")
cast(network_space_PiB, "float")

# Drop original content
drop_origin_data()
```
### DataKit Log Collection Configuration
Navigate to the `conf.d/log` directory under the DataKit installation directory, copy `logging.conf.sample` and rename it to `logging.conf`. Example as follows:
> Note: Change the two logfiles directories to your Chia log file location.

```yaml
[[inputs.logging]]
    # required, glob logfiles
    logfiles = ['''C:\Users\Administrator\.chia\mainnet\log\debug.*''']

    # glob filter
    ignore = [""]

    # your logging source, if it's empty, use 'default'
    source = "chia_harvester"

    # add service tag, if it's empty, use $source.
    service = ""

    # grok pipeline script path
    pipeline = "chia_debug_log.p"

    # optional status:
    #   "emerg","alert","critical","error","warning","info","debug","OK"
    ignore_status = []

    # optional encodings:
    #    "utf-8", "utf-16le", "utf-16le", "gbk", "gb18030" or ""
    character_encoding = ""

    # The pattern should be a regexp. Note the use of '''this regexp'''
    # regexp link: https://golang.org/pkg/regexp/syntax/#hdr-Syntax
    match = '''^\S'''

    [inputs.logging.tags]
    # tags1 = "value1"

[[inputs.logging]]
    # required, glob logfiles
    logfiles = ['''C:\Users\Administrator\AppData\Local\chia-blockchain\app-1.1.6\data_collect\farmer.log''']

    # glob filter
    ignore = [""]

    # your logging source, if it's empty, use 'default'
    source = "chia_farmer"

    # add service tag, if it's empty, use $source.
    service = ""

    # grok pipeline script path
    pipeline = "farm_log.p"

    # optional status:
    #   "emerg","alert","critical","error","warning","info","debug","OK"
    ignore_status = []

    # optional encodings:
    #    "utf-8", "utf-16le", "utf-16le", "gbk", "gb18030" or ""
    character_encoding = ""

    # The pattern should be a regexp. Note the use of '''this regexp'''
    # regexp link: https://golang.org/pkg/regexp/syntax/#hdr-Syntax
    match = '''^\S'''

    [inputs.logging.tags]
    # tags1 = "value1"
```
#### Restart DataKit to Apply Changes

## Monitoring Metrics Description

### 1 Harvesters
Real-time monitoring of Harvesters across multiple hosts analyzes the availability, status, and profitability of different Harvesters in detail, enhancing Chia users' control over their Harvesters.

![image.png](../images/chai-havesters-3.png)

| **Metric Description** | **Name** | **Measurement Standard** |
| --- | --- | --- |
| Network Space | `chia_farmer.network_space` | None |
| Personal Space | `chia_farmer.total_plots_size` | None |
| Farm Height | `chia_farmer.last_farm_height` | None |
| Expected Daily Profit | `chia_harvester.expected_xch` | None |
| Challenges Queried | `chia_harvester.count_eligible` | None |
| Eligible Plots | `chia_harvester.eligible_plots` | None |
| Blocks Found | `chia_harvester.proofs_found` | Performance Metric |
| Average Challenge Query Duration | `chia_harvester.check_duration` | Performance Metric |
| XCH Profit | `chia_farmer.xch_count` | None |

#### Expected Daily Profit
To ensure stable daily profit, maintain a steady plot growth rate and stable network space share. If you notice rapid changes in expected daily profit, investigate whether any Harvester nodes are offline or if the network space has grown rapidly, reducing your share. Set alerts to monitor daily expected profit stability.

#### Harvester Eligibility Rate
Monitor the number of eligible plots from Harvesters to ensure stable earnings. Under healthy network and disk conditions, eligibility rates should remain stable. Investigate disk and network issues if there are sudden fluctuations.

#### Average Challenge Query Duration
Monitor the average challenge query duration and set alerts to ensure it does not exceed 5 seconds. Investigate network or disk issues if the duration exceeds this threshold.

### 2 CPU Monitoring

CPU monitoring helps analyze CPU load peaks and identify excessive CPU usage. It can improve CPU capacity or reduce load, find potential issues, and avoid unnecessary upgrades. CPU monitoring metrics also help identify unnecessary background processes and their impact on overall system performance.

![image.png](../images/chai-havesters-4.png)

| **Metric Description** | **Name** | **Measurement Standard** |
| --- | --- | --- |
| CPU Load | `system.load1`<br />`system.load5`<br />`system.load15` | Resource Utilization |
| CPU Usage | `cpu.usage_idle`<br />`cpu.usage_user`<br />`cpu.usage_system` | Resource Utilization |

#### CPU Usage
CPU usage can be divided into:
- `User Time` (Percentage of time spent executing user processes)
- `System Time` (Percentage of time spent executing kernel processes and interrupts)
- `Idle Time` (Percentage of time CPU is idle)

For optimal CPU performance, ensure the run queue does not exceed 3 for each CPU. When fully loaded, `User Time` should be around 65%~70%, `System Time` around 30%~35%, and `Idle Time` close to 0%~5%.

### 3 Memory Monitoring
Memory is one of the main factors affecting Linux performance. Adequate memory resources directly impact application system performance.

![image.png](../images/chai-havesters-5.png)

| **Metric Description** | **Name** | **Measurement Standard** |
| --- | --- | --- |
| Memory Usage Percentage | `mem.used_percent` | Resource Utilization |
| Memory Usage | mem.free<br />`mem.used` | Resource Utilization |
| Memory Cache | `mem.buffered` | Resource Utilization |
| Memory Buffer | `mem.cached` | Resource Utilization |

#### Memory Usage Percentage
Closely monitor available memory usage because RAM contention can lead to paging and performance degradation. Ensure the machine has enough RAM to meet your workload. Persistent low memory availability can cause segmentation faults and other severe issues. Remedies include increasing physical memory or enabling memory page merging if possible.

### 4 Disk Monitoring

![image.png](../images/chai-havesters-6.png)

| **Metric Description** | **Name** | **Measurement Standard** |
| --- | --- | --- |
| Disk Health | `disk.health`<br />`disk.pre_fail` | Availability |
| Disk Space | `disk.free`<br />`disk.used` | Resource Utilization |
| Disk Inodes | `disk.inodes_free`<br />`disk.inodes_used` | Resource Utilization |
| Disk I/O | `diskio.read_bytes`<br />`diskio.write_bytes` | Resource Utilization |
| Disk Temperature | `disk.temperature` | Availability |
| Disk Model | `disk.device_model` | Basic Information |
| Disk I/O Time | `diskio.read_time`<br />`disk.io.write_time` | Resource Utilization |

#### Disk Space
Maintaining sufficient free disk space is essential for any operating system. Core system processes store logs and other data on disk. Configure alerts when available disk space drops below 15% to ensure continuous operation.

#### Disk I/O Time
These metrics track the average time spent on disk read/write operations. Set alerts for values greater than 50 milliseconds (ideally less than 10 milliseconds). For high-latency servers, consider faster disks.

#### Disk I/O
If your server hosts resource-intensive applications, monitor disk I/O rates. High disk activity can degrade service quality and system stability, especially with high RAM and page file usage. Consider adding more disks, using faster disks, increasing file system cache RAM, or distributing workloads across more machines.

#### Disk Temperature
Set alerts to monitor disk temperature, especially if it exceeds 65°C (75°C for SSDs). Overheating can damage disks and result in data loss.

### 5 Network Monitoring
Your applications and infrastructure components depend on increasingly complex architectures. Whether you run monolithic applications or microservices, deploy to cloud infrastructure, private data centers, or both, virtualized infrastructure allows developers to respond at scale and create dynamic network patterns that traditional monitoring tools may not match. Datadog provides network performance monitoring tailored for the cloud era.

![image.png](../images/chai-havesters-7.png)

| **Metric Description** | **Name** | **Measurement Standard** |
| --- | --- | --- |
| Network Traffic | `net.bytes_recv`<br />`net.bytes_sent` | Resource Utilization |
| Network Packets | `net.packets_recv`<br />`net.packets_sent` | Resource Utilization |
| Retransmissions | `net.tcp_retranssegs` | Availability |

#### Network Traffic
These metrics measure total network throughput for a given network interface. For most consumer hardware, NIC transmission speeds are 1 Gbps or higher. Network bottlenecks are unlikely except in extreme cases. Set alerts when interface bandwidth exceeds 80% utilization (for 1 Gbps links, this is about 100 MB/s).

#### Retransmissions
TCP retransmissions occur frequently but are not errors. They can indicate network congestion and high bandwidth consumption. Monitor this metric as excessive retransmissions can cause significant application delays. If the sender does not receive acknowledgment for transmitted packets, it will delay sending more packets (usually for about 1 second), increasing latency.

High packet drop rates and retransmission rates can lead to excessive buffering. Regardless of the cause, track this metric to understand seemingly random variations in network application response times.

## Conclusion
In this article, we covered some of the most useful metrics to monitor for maintaining labels during mining. If you are running a mining operation, monitoring the metrics listed below will give you a good understanding of the mine's health and availability:

- **Disk I/O Latency**
- **Disk Temperature**
- **Network Traffic**
- **Expected Daily Profit**
- **Harvester Eligibility Rate**
- **Processes**

Ultimately, you will identify additional metrics relevant to your specific use case. You can also learn more through [<<< custom_key.brand_name >>>](http://guance.com).