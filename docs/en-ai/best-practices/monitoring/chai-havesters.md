# Best Practices for Monitoring Chia Harvesters
---

## Introduction
Chia users need to monitor Harvesters on multiple hosts in real-time, analyzing the availability, status, and profitability of different Harvesters in detail. This enhances Chia users' control over their Harvesters. DataFlux takes an active and passive monitoring approach with a comprehensive anomaly detection module that aligns with the actual needs of Chia users. This builds a unified Chia business management platform, allowing Chia users to have a global and intuitive view of Harvester operational status, improving output efficiency, and facilitating troubleshooting of Harvester issues or insufficient expected profits. Additionally, expert-level performance services and on-site support services are provided to help Chia users achieve higher returns. The key areas that need monitoring are:

- **Harvesters**

- **CPU**
- **Memory**
- **Disk**
- **Network**

## Scenario View

![image.png](../images/chai-havesters-1.png)

## Built-in Views

## Disk

![image.png](../images/chai-havesters-2.png)

## Prerequisites

DataKit is installed ([DataKit Installation Documentation](/datakit/datakit-install/))

## Configuration

### Log Collection

This section uses the Windows client as an example (similar for Linux)

#### Create a Chia Farm Log Collection Script

Git is installed ([Git Installation Reference](https://git-scm.com/))

Enter the `chia-blockchain` directory (`C:\Users\{Your User}\AppData\Local\chia-blockchain\app-{Your Chia Version}\resources\app.asar.unpacked\daemon`) and create a log collection script named `farmer.sh`, which saves Chia client farm information to `farmer.log`.

> First, create a `data_collect` folder in `C:\Users\{Your User}\AppData\Local\chia-blockchain\app-{Your Chia Version}\`

```shell
#!/bin/bash

while true; do
	sleep 2
	./chia.exe farm summary  | awk '{line=line "," $0} NR%10==0{print substr(line,1); line=""}' >> ../../../data_collect/farmer.log
done
```

### DataKit Pipeline Configuration
Enter the `pipeline` directory under the DataKit installation directory and create `farm_log.p` and `chia_debug_log.p` to complete the log parsing work. Examples are as follows:
#### chia_debug_log.p
```shell
# chia_debug_log
# Name	Description
# strptime($timestamp, "2006-01-02T15:04:05") 
# total_plots  Number of Plots
# eligible_plots   Number of Eligible Plots
# proofs_found   Number of Blocks Found
# check_duration  Query Time

# Log Example:
# 2021-04-24T11:01:53.390 harvester chia.harvester.harvester: INFO     1 plots were eligible for farming 940b588c2a... Found 0 proofs. Time: 0.98087 s. Total 19 plots


grok(_, "%{TIMESTAMP_ISO8601:strptime} harvester chia.harvester.harvester: INFO \\s+ %{NUMBER:eligible_plots} plots were eligible for farming \\w+\\.\\.\\. Found %{NUMBER:proofs_found} proofs\\. Time: %{NUMBER:check_duration} s\\. Total %{NUMBER:total_plots} plots.*")

# Convert to numeric types
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
# xch_count	Chia Coins Mined
# last_farm_height  Farm Height
# total_plot  Number of Plots
# total_plots_size_GiB Plot Size in GiB
# total_plots_size_TiB Plot Size in TiB
# total_plots_size_PiB Plot Size in PiB
# network_space   Network Power in PiB

# Log Example:
#,Farming status: Farming,Total chia farmed: 0.0,User transaction fees: 0.0,Block rewards: 0.0,Last height farmed: 0,Plot count: 137,Total size of plots: 13.561 TiB,Estimated network space: 12457.266 PiB,Expected time to win: 5 months and 4 weeks,Note: log into your key using 'chia wallet show' to see rewards for each key

grok(_, ",Farming status: %{WORD:farming_status},Total chia farmed: %{NUMBER:xch_count},User transaction fees: %{NUMBER},Block rewards: %{NUMBER},Last height farmed: %{NUMBER:last_farm_height},Plot count: %{NUMBER:total_plot},Total size of plots: %{NUMBER:total_plots_size_GiB} GiB,Estimated network space: %{NUMBER:network_space_PiB} PiB.*")
grok(_, ",Farming status: %{WORD:farming_status},Total chia farmed: %{NUMBER:xch_count},User transaction fees: %{NUMBER},Block rewards: %{NUMBER},Last height farmed: %{NUMBER:last_farm_height},Plot count: %{NUMBER:total_plot},Total size of plots: %{NUMBER:total_plots_size_TiB} TiB,Estimated network space: %{NUMBER:network_space_PiB} PiB.*")
grok(_, ",Farming status: %{WORD:farming_status},Total chia farmed: %{NUMBER:xch_count},User transaction fees: %{NUMBER},Block rewards: %{NUMBER},Last height farmed: %{NUMBER:last_farm_height},Plot count: %{NUMBER:total_plot},Total size of plots: %{NUMBER:total_plots_size_PiB} PiB,Estimated network space: %{NUMBER:network_space_PiB} PiB.*")

# Convert to numeric types
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
Enter the `conf.d/log` directory under the DataKit installation directory, copy `logging.conf.sample` and rename it to `logging.conf`. Example configuration follows:
> Note: Change the two logfiles directories to the location of your Chia log files.

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

## Monitoring Metrics Explanation

### 1 Harvesters
Real-time monitoring of Harvesters on multiple hosts analyzes the availability, status, and profitability of different Harvesters in detail, enhancing Chia users' control over their Harvesters.

![image.png](../images/chai-havesters-3.png)

| **Metric Description** | **Name** | **Measurement Standard** |
| --- | --- | --- |
| Network Power | `chia_farmer.network_space` | N/A |
| Personal Power | `chia_farmer.total_plots_size` | N/A |
| Farm Height | `chia_farmer.last_farm_height` | N/A |
| Daily Expected Profit | `chia_harvester.expected_xch` | N/A |
| Challenges Queried | `chia_harvester.count_eligible` | N/A |
| Eligible Plots | `chia_harvester.eligible_plots` | N/A |
| Blocks Found | `chia_harvester.proofs_found` | Performance Metric |
| Average Challenge Query Duration | `chia_harvester.check_duration` | Performance Metric |
| XCH Profit | `chia_farmer.xch_count` | N/A |

#### Daily Expected Profit
To ensure stable daily profit, maintain a steady increase in plot quantity to stabilize your share of network power. Sudden changes in daily expected profit may indicate offline Harvester nodes or rapid growth in network power leading to lower share. It's recommended to monitor daily expected profit and set alerts to ensure stable earnings.

#### Harvester Eligibility Rate
To ensure stable earnings, monitor the number of eligible plots from Harvesters. When network and disk states are healthy, the eligibility rate should remain stable within a certain range. Significant fluctuations suggest potential issues with disk or network states.

#### Average Challenge Query Duration
Monitor the average challenge query duration and set alerts to ensure it does not exceed 5 seconds. If it does, investigate network or disk conditions to ensure stable earnings.

### 2 CPU Monitoring

CPU monitoring helps analyze CPU load peaks and identify excessive CPU usage. This can improve CPU capacity or reduce load, find potential problems, and avoid unnecessary upgrade costs. CPU metrics also help identify unnecessary background processes and their impact on overall network performance.

![image.png](../images/chai-havesters-4.png)

| **Metric Description** | **Name** | **Measurement Standard** |
| --- | --- | --- |
| CPU Load | `system.load1`<br />`system.load5`<br />`system.load15` | Resource Utilization |
| CPU Usage | `cpu.usage_idle`<br />`cpu.usage_user`<br />`cpu.usage_system` | Resource Utilization |

#### CPU Usage
CPU usage can be divided into: `User Time` (percentage of time spent executing user processes), `System Time` (percentage of time spent executing kernel processes and interrupts), and `Idle Time` (percentage of time CPU is idle). For optimal CPU performance, the run queue for each CPU should not exceed 3. If the CPU is fully loaded, `User Time` should be between 65%-70%, `System Time` between 30%-35%, and `Idle Time` between 0%-5%.

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
Closely monitor available memory usage because RAM contention inevitably leads to paging and performance degradation. Ensure the machine has enough RAM to meet your workload to maintain smooth operation. Persistent low memory availability can lead to segmentation faults and other serious issues. Remedial measures include increasing physical memory or enabling memory deduplication if possible.

### 4 Disk Monitoring

![image.png](../images/chai-havesters-6.png)

| **Metric Description** | **Name** | **Measurement Standard** |
| --- | --- | --- |
| Disk Health Status | `disk.health`<br />`disk.pre_fail` | Availability |
| Disk Space | `disk.free`<br />`disk.used` | Resource Utilization |
| Disk Inodes | `disk.inodes_free`<br />`disk.inodes_used` | Resource Utilization |
| Disk Read/Write | `diskio.read_bytes`<br />`diskio.write_bytes` | Resource Utilization |
| Disk Temperature | `disk.temperature` | Availability |
| Disk Model | `disk.device_model` | Basic Information |
| Disk Read/Write Time | `diskio.read_time`<br />`disk.io.write_time` | Resource Utilization |

#### Disk Space
Maintaining sufficient free disk space is essential for any operating system. Besides regular processes requiring disk space, core system processes store logs and other data on the disk. Set alerts when available disk space drops below 15% to ensure business continuity.

#### Disk Read/Write Time
These metrics track the average time spent on disk read/write operations. Values greater than 50 milliseconds indicate relatively high latency (less than 10 milliseconds is ideal). Consider transferring business tasks to faster disks to reduce latency. Set different alert thresholds based on server roles, as acceptable thresholds vary by role.

#### Disk Read/Write
If your server hosts resource-intensive applications, monitor disk I/O rates. Disk read/write metrics aggregate read (`diskio.read_bytes`) and write (`diskio.write_bytes`) activities. High disk activity can degrade service and cause system instability, especially when combined with high RAM and page file usage. Recommendations include increasing the number of disks used, using faster disks, increasing RAM reserved for file system caching, and distributing workloads across more machines if possible.

#### Disk Temperature
For critical business operations, monitor disk working temperature continuously. Temperatures exceeding 65°C (SSD above 75°C) warrant attention. Overheating protection mechanisms can prevent damage and data loss due to overheating disks.

### 5 Network Monitoring
Your applications and infrastructure components depend on increasingly complex architectures. Whether you're running monolithic applications or microservices, deployed to cloud infrastructure, private data centers, or both, virtualized infrastructure enables developers to respond to any scale and create dynamic network patterns that traditional network monitoring tools don't match. To provide visibility into each component and all connections between them, Datadog introduces network performance monitoring for the cloud era.

![image.png](../images/chai-havesters-7.png)

| **Metric Description** | **Name** | **Measurement Standard** |
| --- | --- | --- |
| Network Traffic | `net.bytes_recv`<br />`net.bytes_sent` | Resource Utilization |
| Network Packets | `net.packets_recv`<br />`net.packets_sent` | Resource Utilization |
| Retransmissions | `net.tcp_retranssegs` | Availability |

#### Network Traffic
These metrics together measure the total network throughput of a given network interface. For most consumer hardware, NIC transmission speed is at least 1 Gbps. Network bottlenecks are unlikely except in extreme cases. Set alerts when interface bandwidth exceeds 80% utilization (for a 1 Gbps link, this is 100 MBps).

#### Retransmissions
TCP retransmissions are common but not errors, although they can indicate underlying issues. Retransmissions are often due to network congestion and high bandwidth consumption. Monitor this metric because excessive retransmissions can cause significant application delays. If the sender doesn't receive acknowledgment of sent packets, it delays sending more packets (typically for about 1 second), increasing delay and congestion-related speed.

If not caused by network congestion, retransmissions may indicate faulty network hardware. A small number of dropped packets and high retransmission rates can lead to excessive buffering. Regardless of the cause, tracking this metric helps understand seemingly random fluctuations in network application response times.

## Conclusion
In this article, we discussed some of the most useful metrics you can monitor to retain labels during mining. If you are conducting mining operations, monitoring the metrics listed below will give you a good understanding of the mine's operational status and availability:

- **Disk Read/Write Latency**
- **Disk Temperature**
- **Network Traffic**
- **Daily Expected Profit**
- **Harvester Eligibility Rate**
- **Processes**

Ultimately, you will identify additional metrics relevant to your specific use case. You can also learn more via [Guance](http://guance.com).