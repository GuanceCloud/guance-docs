# Swarm Bee Observability Best Practices
---

## Introduction

Swarm is an official part of the Ethereum project, primarily developed by the foundation. It allows mining pools to provide storage, bandwidth, and computational resources to support applications based on the Ethereum network. The team aims to create a decentralized, peer-to-peer storage and service solution that is always available, fault-tolerant, and censorship-resistant. By creating an economic incentive system within Swarm, it facilitates the payment and transfer of value for resource exchanges using different protocols and technologies from the Ethereum blockchain. Swarm provides decentralized content storage and distribution services, which can be considered as a CDN, distributing content over the internet across computers. Similar to running an Ethereum node, you can run a Swarm node and connect it to the Swarm network. This is similar to BitTorrent and can be compared to IPFS, with ETH used as an incentive. Files are broken down into chunks, distributed, and stored by participating volunteers. Nodes that store and serve these chunks receive ETH from nodes that require storage and retrieval services. Unlike mining, Swarm does not offer block rewards but instead rewards interactions between nodes. After interactions, nodes can earn checks, which can be exchanged for BZZ, making the network environment and node status of the BZZ cluster particularly important.

- **Bee**

- **CPU**
- **Memory**
- **Disk**
- **Network**

## Scene View

![image.png](../images/swarm-bee-1.png)

## Built-in Views

### Disk

![image.png](../images/swarm-bee-2.png)

## Prerequisites

- DataKit installed ([DataKit Installation Documentation](/datakit/datakit-install/))
- Docker installed and Docker Swarm initialized ([Docker Installation Reference](https://docs.docker.com/engine/install/))

## Configuration

### Configure Prom Exporter

Navigate to the `conf.d/prom` directory under the DataKit installation directory, copy `prom.conf.sample`, and rename it to `prom.conf`. Example configuration:

```yaml
 ## Exporter address
  url = "http://127.0.0.1:1635/metrics"

  ## Metric type filtering, optional values are counter, gauge, histogram, summary
  # By default, only counter and gauge types of metrics are collected
  # If empty, no filtering is applied
  metric_types = ["counter", "gauge"]

  ## Metric name filtering
  # Supports regular expressions, multiple configurations can be set, where satisfying any one condition is sufficient
  # If empty, no filtering is applied
  # metric_name_filter = ["cpu"]

  ## Measurement name prefix
  # Configuring this item adds a prefix to the measurement name
  # measurement_prefix = "prom_"

  ## Measurement name
  # By default, the measurement name is split by underscores "_", with the first field as the measurement name and the remaining fields as the current metric name
  # If measurement_name is configured, no splitting of the metric name occurs
  # The final measurement name will include the measurement_prefix prefix
  # measurement_name = "prom"

  ## Collection interval "ns", "us" (or "µs"), "ms", "s", "m", "h"
  interval = "10s"

  ## TLS configuration
  tls_open = false
  # tls_ca = "/tmp/ca.crt"
  # tls_cert = "/tmp/peer.crt"
  # tls_key = "/tmp/peer.key"

  ## Custom measurement names
  # Metrics containing the prefix can be grouped into one measurement
  # Custom measurement name configuration takes precedence over the measurement_name option
  #[[inputs.prom.measurements]]
  #  prefix = "cpu_"
  #  name = "cpu"

  # [[inputs.prom.measurements]]
  # prefix = "mem_"
  # name = "mem"

  ## Custom Tags
  [inputs.prom.tags]
  bee_debug_port = "1635"
  # more_tag = "some_other_value"
```

### Configure Swarm API Service Collector

### Install DataFlux Func

#### Modify DataKit 

Navigate to the `conf.d` directory under the DataKit installation directory, modify the `datakit.conf` file to change `http_listen`. Example configuration:

```yaml
http_listen = "0.0.0.0:9529"
log = "/var/log/datakit/log"
log_level = "debug"
log_rotate = 32
gin_log = "/var/log/datakit/gin.log"
protect_mode = true
interval = "10s"
output_file = ""
default_enabled_inputs = ["cpu", "disk", "diskio", "mem", "swap", "system", "hostobject", "net", "host_processes", "docker", "container"]
install_date = 2021-05-14T05:03:35Z
enable_election = false
disable_404page = false

[dataway]
  urls = ["https://openway.dataflux.cn?token=tkn_9a49a7e9343c432eb0b99a297401c3bb"]
  timeout = "5s"
  http_proxy = ""

[http_api]
  rum_origin_ip_header = "X-Forward-For"

[global_tags]
  cluster = ""
  host = "df_solution_ecs_004"
  project = ""
  site = ""

[[black_lists]]
  hosts = []
  inputs = []

[[white_lists]]
  hosts = []
  inputs = []
```
Save and restart DataKit:
```bash
datakit --restart
```
#### Install Func
Download the DataFlux Func dependency files:
```yaml
/bin/bash -c "$(curl -fsSL https://t.dataflux.cn/func-portable-download)"
```
After executing the command, all required files will be saved in the newly created `dataflux-func-portable` directory under the current directory.

In the downloaded `dataflux-func-portable` directory, run the following command to automatically configure and start DataFlux Func:
```yaml
sudo /bin/bash run-portable.sh
```
Installation successful:
```systemverilog
Please wait for the container to run, wait 30 seconds...
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES


Installed dir:
    /usr/local/dataflux-func
To shutdown:
    sudo docker stack remove dataflux-func
To start:
    sudo docker stack deploy dataflux-func -c /usr/local/dataflux-func/docker-stack.yaml
To uninstall:
    sudo docker stack remove dataflux-func
    sudo rm -rf /usr/local/dataflux-func
    sudo rm -f /etc/logrotate.d/dataflux-func

Now open http://<IP or Hostname>:8088/ and have fun!
```
Visit `http://<IP or Hostname>:8088` to see the following interface:

![image.png](../images/swarm-bee-3.png)

#### Configure DataKit Data Source for Data Reporting

![image.png](../images/swarm-bee-4.png)
#### Write Script to Collect Peer Data

![image.png](../images/swarm-bee-5.png)
```python
import requests


@DFF.API('peer')
def peer():
    # Get DataKit operation object
    datakit = DFF.SRC('datakit')
    response = requests.get("http://172.17.0.1:1635/peers")
    response_health = requests.get("http://172.17.0.1:1635/health")
    peers = response.json()
    health = response_health.json()
    res = datakit.write_metric(measurement='bee', tags={'bee_debug_port':'1635','host':'df-solution-ecs-013'}, fields={'swap_peers':len(peers["peers"]),'version':health["version"]})
    print(res, "swap_peers: ", len(peers["peers"]), "    version: ", health["version"])

```
> Since DataFlux Func runs via Docker Stack and bridges to the host's `docker0`, it does not directly connect to the host's local network. Therefore, even if DataFlux Func and DataFlux DataKit are installed on the same server, you cannot simply bind the DataFlux DataKit listening port to the local network (`127.0.0.1`).
>
> At this point, you should modify the configuration to bind the listening port to `docker0` (`172.17.0.1`) or `0.0.0.0`.
> Note to change the local listening port `:1635` to `0.0.0.0:1635` in the Swarm Bee configuration.

Insert data obtained through API requests into the corresponding measurement with appropriate tags for display in Studio.
#### Create Automatic Trigger to Execute Function Scheduling

![image.png](../images/swarm-bee-6.png)

Select the function just written, set up a scheduled task, add validity, and click save.

> Scheduled tasks can trigger at least once every minute. For special requirements, you can use `while + sleep` to increase the data collection frequency.

#### Check Function Execution Status via Automatic Trigger Configuration

![image.png](../images/swarm-bee-7.png)

If it shows success, congratulations! You can now view your reported metrics in Studio.

## Monitoring Metrics Explanation

### 1. Bee

Monitor multiple Harvesters in real-time, analyzing their availability, status, and earnings, thereby enhancing Chia users' control over Harvesters.

![image.png](../images/swarm-bee-11.png)

| **Metric Description** | **Name** | **Measurement Standard** |
| --- | --- | --- |
| Number of received checks | `bee.swap_cheques_received` | Revenue metric |
| Number of rejected checks | `bee.swap_cheques_rejected` | Revenue metric |
| Number of sent checks | `bee.swap_cheques_sent` | Revenue metric |
| Number of connected peers | `bee.swap_peers` | Performance metric |

#### Number of Rejected Checks

To ensure stable daily earnings, please monitor the number of rejected checks. When the number of rejected checks rises rapidly, promptly check the status of the Bee node and network to maintain stable daily earnings.

#### Number of Connected Peers

To ensure stable earnings and network stability, monitor the number of connected peers. Normally, when the network and node statuses are healthy, the number of connected peers remains stable within a certain range without significant fluctuations. If you notice significant fluctuations in the number of connected peers, promptly check the status of the Bee node and network to ensure stable earnings.

### 2. CPU Monitoring

CPU monitoring helps analyze CPU load peaks and identify excessive CPU usage. Through CPU monitoring metrics, you can improve CPU capacity or reduce load, find potential issues, and avoid unnecessary upgrade costs. CPU monitoring metrics also help identify unnecessary background processes and determine process or application resource utilization and its impact on the entire network.

![image.png](../images/swarm-bee-8.png)

| **Metric Description** | **Name** | **Measurement Standard** |
| --- | --- | --- |
| CPU Load | `system.load1`<br />`system.load5`<br />`system.load15` | Resource Utilization |
| CPU Usage | `cpu.usage_idle`<br />`cpu.usage_user`<br />`cpu.usage_system` | Resource Utilization |

#### CPU Usage

CPU usage can be divided into: `User Time` (percentage of time spent executing user processes); `System Time` (time spent executing kernel processes and interrupts); `Idle Time` (time CPU is in Idle state). For CPU performance, first, ensure the run queue for each CPU does not exceed 3. Secondly, if the CPU is fully loaded, `User Time` should be around 65%~70%, `System Time` around 30%~35%, and `Idle Time` around 0%~5%.

### 3. Memory Monitoring

Memory is one of the main factors affecting Linux performance, and the sufficiency of memory resources directly impacts the performance of application systems.

![image.png](../images/swarm-bee-9.png)

| **Metric Description** | **Name** | **Measurement Standard** |
| --- | --- | --- |
| Memory Usage Rate | `mem.used_percent` | Resource Utilization |
| Memory Usage | mem.free<br />`mem.used` | Resource Utilization |
| Memory Cache | `mem.buffered` | Resource Utilization |
| Memory Buffer | `mem.cached` | Resource Utilization |

#### Memory Usage Rate

Closely monitoring available memory usage is crucial because RAM contention inevitably leads to paging and performance degradation. To keep the machine running smoothly, ensure it has enough RAM to meet your workload. Persistent low memory availability can lead to segmentation faults and other serious issues. Remedial measures include increasing the physical memory capacity of the system, and if possible, enabling memory page merging.

### 4. Disk Monitoring

![image.png](../images/swarm-bee-10.png)

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
Maintaining sufficient free disk space is necessary for any operating system. Besides regular processes requiring disk space, core system processes store logs and other types of data on the disk. Set alerts to notify when available disk space drops below 15% to ensure business continuity.
#### Disk Read/Write Time
These metrics track the average time spent on disk read/write operations. Values greater than 50 milliseconds indicate relatively high latency (ideally less than 10 milliseconds), typically suggesting transferring business workloads to faster disks to reduce latency. You can set different alert thresholds based on the server role, as acceptable thresholds vary.
#### Disk Read/Write
If your server hosts high-demand applications, monitor disk I/O rates. Disk read/write metrics aggregate read (`diskio.read_bytes`) and write (`diskio.write_bytes`) activities marked by the disk. Persistent high disk activity can degrade services and cause system instability, especially when combined with high RAM and page files. During high disk activity, consider increasing the number of disks in use (especially if you see a large number of operations in the queue), using faster disks, increasing RAM reserved for file system caching, or distributing workloads across more machines if possible.
#### Disk Temperature
If your business requires high disk availability, set alerts to monitor disk working temperature. Temperatures above 65°C (75°C for SSDs) are concerning. If your hard drive overheating protection or temperature control mechanisms fail, rising temperatures could damage the disk and result in data loss.

### 5. Network Monitoring

Your applications and infrastructure components depend on increasingly complex architectures. Whether you run monolithic applications or microservices, whether deployed to cloud infrastructure, private data centers, or both, virtualized infrastructure enables developers to respond dynamically to arbitrary scale, creating network patterns that do not match traditional network monitoring tools. To provide visibility into each component and all connections within the environment, Datadog introduced network performance monitoring for the cloud era.

![image.png](../images/swarm-bee-13.png)

| **Metric Description** | **Name** | **Measurement Standard** |
| --- | --- | --- |
| Network Traffic | `net.bytes_recv`<br />`net.bytes_sent` | Resource Utilization |
| Network Packets | `net.packets_recv`<br />`net.packets_sent` | Resource Utilization |
| Retransmission Count | `net.tcp_retranssegs` | Availability |

#### Network Traffic
Together, these two metrics measure total network throughput for a given network interface. For most consumer hardware, NIC transmission speeds are 1 Gbps or higher, so except in extreme cases, the network is unlikely to become a bottleneck. Set alerts when the interface bandwidth exceeds 80% utilization to prevent network saturation (for a 1 Gbps link, reaching 100 megabytes per second).

#### Retransmission Count
TCP retransmissions occur frequently but are not errors; however, their presence may indicate issues. Retransmissions are usually the result of network congestion and often correlate with high bandwidth consumption. Monitor this metric because excessive retransmissions can cause significant application delays. If the sender does not receive acknowledgment of transmitted packets, it will delay sending more packets (typically for about 1 second), increasing latency and congestion-related speed reductions.

If not caused by network congestion, the source of retransmissions may be faulty network hardware. A small number of dropped packets and high retransmission rates can lead to excessive buffering. Regardless of the cause, tracking this metric helps understand seemingly random fluctuations in network application response times.

## Conclusion

In this article, we mentioned some of the most useful metrics to monitor for maintaining labels during mining. If you are conducting mining operations, monitoring the metrics listed below will give you a good understanding of the mine's operational status and availability:

- **Disk Read/Write Latency**

- **Disk Temperature**
- **Network Traffic**
- **Daily Expected Earnings**
- **Harvester Screening Pass Rate**
- **Processes**

Ultimately, you will recognize other metrics relevant to your specific use case. Of course, you can also learn more through [<<< custom_key.brand_name >>>](http://guance.com).