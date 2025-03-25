# Chia Harvesters Best Practices

---

## Introduction
Chia users need to perform real-time monitoring of multiple hosts' Harvesters, analyzing in detail the availability, status, and profits of different Harvesters, continuously enhancing Chia users' control over Harvesters. Dataflux adopts active and passive monitoring, a global anomaly detection module, truly aligning with the needs of Chia users, building a unified Chia business management platform, allowing Chia users to have a global intuitive grasp of Harvester operating states, improving output efficiency, and facilitating the troubleshooting of Harvester failures or issues of insufficient expected profits. It also provides expert-level Chia performance services and on-site support services, helping Chia users achieve higher profits. The key areas that need to be monitored are:

- **Harvesters**

- **CPUs**
- **Memory**
- **Disk**
- **Network**

## Use Cases

![image.png](../images/chai-havesters-1.png)

## Built-in Views

## Disk

![image.png](../images/chai-havesters-2.png)

## Prerequisites

DataKit is installed ([DataKit Installation Documentation](/datakit/datakit-install/))

## Configuration

### Log Collection

This article uses the Windows client as an example (Linux works similarly).

#### Create chia farm log collection script

Git is already installed ([Git Installation Reference](https://git-scm.com/))

Enter the `chia-blockchain` directory (C:\Users\{Your User}\AppData\Local\chia-blockchain\app-{Your Chia Version}\resources\app.asar.unpacked\daemon) and create a log collection script farmer.sh, saving the chia client farm information into farmer.log.

> Please first create a data_collect folder in C:\Users\{Your User}\AppData\Local\chia-blockchain\app-{Your Chia Version}\

```shell
#!/bin/bash

while true; do
    sleep 2
    ./chia.exe farm summary  | awk '{line=line "," $0} NR%10==0{print substr(line,1); line=""}' >> ../../../data_collect/farmer.log
done
```

### DataKit Pipeline Configuration
Enter the `pipeline` directory under the DataKit installation directory and create `farm_log.p`, `chai_debug_log.p` respectively to complete the segmentation work of the collected logs. Example:

#### chia_debug_log.p
```shell
#chia_debug_log
#Name	Description
#strptime($timestamp, "2006-01-02T15:04:05") 
#total_plots	Plot quantities
#eligible_plots	Passed preliminary screening Plot quantities
#proofs_found	Burst block quantities
#check_duration	Query time

# Log Example:
#2021-04-24T11:01:53.390 harvester chia.harvester.harvester: INFO     1 plots were eligible for farming 940b588c2a... Found 0 proofs. Time: 0.98087 s. Total 19 plots


grok(_, "%{TIMESTAMP_ISO8601:strptime} harvester chia.harvester.harvester: INFO \\s+ %{NUMBER:eligible_plots} plots were eligible for farming \\w+\\.\\.\\. Found %{NUMBER:proofs_found} proofs\\. Time: %{NUMBER:check_duration} s\\. Total %{NUMBER:total_plots} plots.*")

# Convert numerical types
cast(eligible_plots, "float")
cast(proofs_found, "float")
cast(check_duration, "float")
cast(total_plots, "float")

# Drop original content
drop_origin_data()
```

#### farm_log.p
```shell
#farm_log
#Name	Description
#farming_status	farmer status
#xch_count	XCH mined
#last_farm_height	Farm height
#total_plot	Cultivated quantity
#total_plots_size_GiB	Cultivated size
#total_plots_size_TiB	Cultivated size
#total_plots_size_PiB	
#network_space	Total network power PiB

#Log Example:
#,Farming status: Farming,Total chia farmed: 0.0,User transaction fees: 0.0,Block rewards: 0.0,Last height farmed: 0,Plot count: 137,Total size of plots: 13.561 TiB,Estimated network space: 12457.266 PiB,Expected time to win: 5 months and 4 weeks,Note: log into your key using 'chia wallet show' to see rewards for each key

grok(_, ",Farming status: %{WORD:farming_status},Total chia farmed: %{NUMBER:xch_count},User transaction fees: %{NUMBER},Block rewards: %{NUMBER},Last height farmed: %{NUMBER:last_farm_height},Plot count: %{NUMBER:total_plot},Total size of plots: %{NUMBER:total_plots_size_GiB} GiB,Estimated network space: %{NUMBER:network_space_PiB} PiB.*")
grok(_, ",Farming status: %{WORD:farming_status},Total chia farmed: %{NUMBER:xch_count},User transaction fees: %{NUMBER},Block rewards: %{NUMBER},Last height farmed: %{NUMBER:last_farm_height},Plot count: %{NUMBER:total_plot},Total size of plots: %{NUMBER:total_plots_size_TiB} TiB,Estimated network space: %{NUMBER:network_space_PiB} PiB.*")
grok(_, ",Farming status: %{WORD:farming_status},Total chia farmed: %{NUMBER:xch_count},User transaction fees: %{NUMBER},Block rewards: %{NUMBER},Last height farmed: %{NUMBER:last_farm_height},Plot count: %{NUMBER:total_plot},Total size of plots: %{NUMBER:total_plots_size_PiB} PiB,Estimated network space: %{NUMBER:network_space_PiB} PiB.*")

#Convert numerical types
cast(farming_status, "str")
cast(xch_count, "float")
cast(last_farm_height, "float")
cast(total_plot, "float")
cast(total_plots_size_GiB, "float")
cast(total_plots_size_TiB, "float")
cast(total_plots_size_PiB, "float")
cast(network_space_PiB, "float")

#Drop original content
drop_origin_data()
```

### DataKit Log Collection Configuration
Enter the `conf.d/log` directory under the DataKit installation directory, copy `logging.conf.sample` and rename it to `logging.conf`. Example:
> Note to change both logfiles directories to the location of your chia log files.

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
#### Restart DataKit to take effect

## Monitoring Metrics Description

### 1 Harvesters
Perform real-time monitoring of Harvesters across multiple hosts, analyzing in detail the availability, status, and profits of different Harvesters, continuously enhancing Chia users' control over Harvesters.

![image.png](../images/chai-havesters-3.png)

| **Metric Description** | **Name** | **Measurement Standard** |
| --- | --- | --- |
| Total Network Power | `chia_farmer.network_space` | None |
| Personal Power | `chia_farmer.total_plots_size` | None |
| Farm Height | `chia_farmer.last_farm_height` | None |
| Daily Expected Profit | `chia_harvester.expected_xch` | None |
| Challenges Searched | `chia_harvester.count_eligible` | None |
| Passed Preliminary Screening Quantity | `chia_harvester.eligible_plots` | None |
| Burst Block Quantity | `chia_harvester.proofs_found` | Performance Metric |
| Average Challenge Query Duration | `chia_harvester.check_duration` | Performance Metric |
| XCH Profit | `chia_farmer.xch_count` | None |

#### Daily Expected Profit
Ensure stable plot growth daily to stabilize your share of computing power, ensuring that your daily expected profit does not fluctuate drastically. If you notice rapid changes in your daily expected profit, it may indicate that a Harvester node has gone offline or that the total network power has grown too fast, causing your share of computing power to drop too low. It is recommended to always monitor the daily expected profit and set alerts to ensure stable income.
#### Harvester Preliminary Screening Pass Rate
To ensure stable income, please monitor the number of Harvesters passing the preliminary screening. Normally, when the network state and disk state are healthy, the pass rate of Harvester preliminary screening will remain stable within a certain range without drastic fluctuations. When you find that the pass rate of Harvester preliminary screening has changed drastically, please check the disk and network states promptly to ensure stable income.
#### Average Challenge Query Duration
Please pay attention to the average challenge query duration of Harvesters and set alerts to ensure that each Harvester's query does not exceed 5 seconds. If you find that it exceeds 5 seconds, please check the network information or disk information promptly to ensure stable income.
### 2 CPU Monitoring

CPU monitoring helps analyze CPU load peaks and identify excessive CPU usage. You can improve CPU capacity or reduce load through CPU monitoring metrics, find potential problems, and avoid unnecessary upgrade costs. CPU monitoring metrics can also help you identify unnecessary background processes running and determine the resource utilization of processes or applications and their impact on the entire network.

![image.png](../images/chai-havesters-4.png)

| **Metric Description** | **Name** | **Measurement Standard** |
| --- | --- | --- |
| CPU Load | `system.load1`<br />`systeml.load5`<br />`system.load15` | Resource Utilization |
| CPU Usage | `cpu.usage_idle`<br />`cpu.usage_user`<br />`cpu.usage_system` | Resource Utilization |


#### CPU Usage
CPU usage can be divided into: `User Time`(percentage of time executing user processes); `System Time`(percentage of time executing kernel processes and interrupts); `Idle Time`(percentage of time the CPU is in Idle state). For CPU performance, first, the run queue for each CPU should not exceed 3, secondly, if the CPU is fully loaded, `User Time` should be around 65%~70%, `System Time` should be around 30%~35%, and `Idle Time` should be around 0%~5%.
### 3 Memory Monitoring
Memory is one of the main factors affecting Linux performance. The adequacy of memory resources directly affects the usage performance of application systems.

![image.png](../images/chai-havesters-5.png)

| **Metric Description** | **Name** | **Measurement Standard** |
| --- | --- | --- |
| Memory Usage Percentage | `mem.used_percent` | Resource Utilization |
| Memory Usage | mem.free<br />`mem.used` | Resource Utilization |
| Memory Cache | `mem.buffered` | Resource Utilization |
| Memory Buffer | `mem.cached` | Resource Utilization |

#### Memory Usage
It is important to closely monitor the usage of available memory because contention for RAM will inevitably lead to paging and performance degradation. To keep the machine running smoothly, ensure it has enough RAM to meet your workload. Persistent low memory availability can lead to segmentation faults and other serious issues. Remedies include increasing the physical memory capacity in the system, or enabling memory page merging if possible.
### 4 Disk Monitoring

![image.png](../images/chai-havesters-6.png)

| **Metric Description** | **Name** | **Measurement Standard** |
| --- | --- | --- |
| Disk Health Status | `disk.health`<br />`disk.pre_fail` | Availability |
| Disk Space | `disk.free`<br />`disk.used` | Resource Utilization |
| Disk Inode | `disk.inodes_free`<br />`disk.inodes_used` | Resource Utilization |
| Disk Read/Write | `diskio.read_bytes`<br />`diskio.write_bytes` | Resource Utilization |
| Disk Temperature | `disk.temperature` | Availability |
| Disk Model | `disk.device_model` | Basic Information |
| Disk Read/Write Time | `diskio.read_time`<br />`disk.io.write_time` | Resource Utilization |

#### Disk Space
For any operating system, maintaining sufficient free disk space is necessary. Besides regular disk processes, core system processes store logs and other types of data on the disk. You can configure alerts to remind you when your available disk space drops below 15%, ensuring continuous business operations.
#### Disk Read/Write Time
These metrics track the average time spent on disk read/write operations. A value greater than 50 milliseconds indicates relatively high latency (with less than 10 milliseconds being optimal), usually suggesting that business jobs should be transferred to faster disks to reduce latency. You can set different alert thresholds based on the server role, as acceptable thresholds vary by role.
#### Disk Read/Write
If your server hosts demanding applications, you will want to monitor disk I/O rates. Disk read/write metrics aggregate read (`diskio.read_bytes`) and write (`diskio.write_bytes`) activities marked by the disk. Persistent high disk activity can lead to service degradation and system instability, especially when combined with high RAM and page file usage. When experiencing high disk activity, consider increasing the number of disks used (especially when you see a large number of operations in the queue), using faster disks, increasing RAM reserved for file system caching, or distributing the workload to more machines if possible.
#### Disk Temperature
If your business requires very high disk availability, you can set alerts to monitor the working temperature of disks continuously. Temperatures above 65°C (or 75°C for SSDs) deserve attention. If your hard drive overheating protection or temperature control mechanism fails, further increases in temperature could damage the hard drive and result in data loss.
### 5 Network Monitoring
Your applications and infrastructure components depend on increasingly complex architectures, whether you are running monolithic applications or microservices, deploying to cloud infrastructure, private data centers, or both. Virtualized infrastructure allows developers to respond at any scale and creates dynamic network patterns that don't quite match traditional network monitoring tools. To provide visibility into every component in your environment and all connections between them, Datadog introduces network performance monitoring for the cloud era.

![image.png](../images/chai-havesters-7.png)

| **Metric Description** | **Name** | **Measurement Standard** |
| --- | --- | --- |
| Network Traffic | `net.bytes_recv`<br />`net.bytes_sent` | Resource Utilization |
| Network Packets | `net.packets_recv`<br />`net.packets_sent` | Resource Utilization |
| Retransmissions | `net.tcp_retranssegs` | Availability |

#### Network Traffic
Together, these two metrics measure the total network throughput of a given network interface. For most consumer hardware, the NIC transmission speed is at least 1 GB per second or higher, so except in extreme cases, the network is unlikely to become a bottleneck in all situations. You can set alerts to remind you when the interface bandwidth is utilized more than 80%, preventing network saturation (for a 1 Gbps link, this would mean reaching 100 megabytes per second).
#### Retransmissions
TCP retransmissions happen frequently but are not errors, though their presence may indicate signs of problems. Retransmissions are typically the result of network congestion and often correlate with high bandwidth consumption. You should monitor this metric because excessive retransmissions can cause significant application delays. If the sender does not receive confirmation of the sent packets, it will delay sending more packets (usually lasting about one second), thereby increasing latency related to congestion speeds.

If not caused by network congestion, the source of retransmissions could be faulty network hardware. Few dropped packets and a high retransmission rate might lead to excessive buffering. Regardless of the cause, you should track this metric to understand seemingly random fluctuations in network application response times.
## Conclusion
In this article, we mentioned some of the most useful metrics you can monitor while mining to retain labels. If you are conducting mining operations, monitoring the metrics listed below will give you a good understanding of the mine's operational health and availability:

- **Disk Read/Write Latency**
- **Disk Temperature**
- **Network Traffic**
- **Daily Expected Profit**
- **Harvester Preliminary Screening Pass Rate**
- **Processes**

Ultimately, you will recognize other metrics particularly relevant to your own use case. Of course, you can also learn more through [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>).