# Swarm Bee Observability Best Practices
---

## Introduction

Swarm is an official part of the Ethereum project, primarily developed by the foundation. It allows mining pools to provide storage, bandwidth, and computational resources to support applications based on the Ethereum network. The team aims to create a decentralized peer-to-peer storage and service solution that never goes down, has zero failures, and is censorship-resistant. A system of economic incentives within Swarm promotes the exchange of resource value payments and transfers using different protocols and technologies from the Ethereum blockchain. Swarm provides decentralized content storage and distribution services, similar to a CDN, distributing content over the internet across computers. You can run a Swarm node like an Ethereum node and connect it to the Swarm network. This is similar to BitTorrent and can be compared to IPFS, with ETH as the reward incentive. Files are broken down into chunks, distributed, and stored by participating volunteers. Nodes that store and serve these chunks receive ETH as compensation from nodes that need storage and retrieval services. Unlike mining, Swarm does not have block rewards but instead rewards interaction between nodes. After interactions, nodes can earn checks, which can be exchanged for BZZ, making the network environment and node status of the BZZ cluster particularly important.

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

- DataKit is installed ([DataKit Installation Documentation](/datakit/datakit-install/))
- Docker is installed and Docker Swarm is initialized ([Docker Installation Reference](https://docs.docker.com/engine/install/))

## Configuration

### Configure Prom Exporter

Enter the `conf.d/prom` directory under the DataKit installation directory, copy `prom.conf.sample`, and rename it to `prom.conf`. Example:

```yaml
 ## Exporter address
  url = "http://127.0.0.1:1635/metrics"

  ## Metric type filtering, optional values are counter, gauge, histogram, summary
  # By default, only counter and gauge types of metrics are collected
  # If empty, no filtering is performed
  metric_types = ["counter", "gauge"]

  ## Metric name filtering
  # Supports regex, multiple configurations can be set, satisfying any one condition is sufficient
  # If empty, no filtering is performed
  # metric_name_filter = ["cpu"]

  ## Measurement name prefix
  # Configuring this item adds a prefix to the measurement name
  # measurement_prefix = "prom_"

  ## Measurement name
  # By default, the first field after splitting the metric name by "_" is used as the measurement name, and the remaining fields as the current metric name
  # If measurement_name is configured, no splitting of the metric name will occur
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
  # Custom measurement name configuration takes precedence over measurement_name configuration
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

Enter the `conf.d` directory under the DataKit installation directory and modify the `http_listen` in the `datakit.conf` file. Example:

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

Download DataFlux Func dependencies:
```yaml
/bin/bash -c "$(curl -fsSL https://t.dataflux.cn/func-portable-download)"
```

After execution, all required files are saved in the newly created `dataflux-func-portable` directory under the current directory.

In the downloaded `dataflux-func-portable` directory, run the following command to automatically configure and start the entire DataFlux Func:
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

Access `http://<IP or Hostname>:8088` to see the following interface:

![image.png](../images/swarm-bee-3.png)

#### Configure DataKit Data Source for Data Reporting

![image.png](../images/swarm-bee-4.png)

#### Write Script for Peer Data Collection

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

> Since DataFlux Func runs via Docker Stack and bridges to the host's `docker0`, it is not directly connected to the host's local network. Therefore, even if DataFlux Func and DataFlux DataKit are installed on the same server, you cannot simply bind the DataFlux DataKit listening port to the local network (`127.0.0.1`).
>
> At this time, you should modify the configuration to bind the listening port to `docker0` (`172.17.0.1`) or `0.0.0.0`.
> Note to change the local listening port `:1635` to `0.0.0.0:1635` in the Swarm Bee configuration.

Insert the data obtained through API requests into the corresponding measurement with appropriate tags for display in Studio.
#### Create Automatic Triggers for Function Scheduling

![image.png](../images/swarm-bee-6.png)

Select the function you just wrote, set up a scheduled task, add an expiration date, and click save.

> Scheduled tasks can trigger at least once per minute. For special needs, you can use while + sleep to increase the data collection frequency.

#### Check Function Execution Status via Automatic Triggers

![image.png](../images/swarm-bee-7.png)

If it shows success, congratulations! You can now view the reported metrics in Studio.

## Monitoring Metrics Explanation

### 1. Bee

Real-time monitoring of multiple hosts' Harvesters analyzes the availability, status, and earnings of different Harvesters, enhancing Chia users' control over their Harvesters.

![image.png](../images/swarm-bee-11.png)

| **Metric Description** | **Name** | **Measurement Standard** |
| --- | --- | --- |
| Number of received checks | `bee.swap_cheques_received` | Earnings metric |
| Number of rejected checks | `bee.swap_cheques_rejected` | Earnings metric |
| Number of sent checks | `bee.swap_cheques_sent` | Earnings metric |
| Number of linked peers | `bee.swap_peers` | Performance metric |

#### Number of Rejected Checks

To ensure stable daily earnings, always monitor the number of rejected checks. When this number rises rapidly, promptly check the status of the Bee node and network to ensure stable daily earnings.

#### Number of Linked Peers

To ensure stable earnings and network stability, monitor the number of linked peers. Normally, when the network and node status are healthy, the number of linked peers remains stable within a certain range without significant fluctuations. When you notice significant fluctuations in the number of linked peers, promptly check the status of the Bee node and network to ensure stable earnings.

### 2. CPU Monitoring

CPU monitoring helps analyze CPU load peaks and identify excessive CPU usage. Through CPU monitoring metrics, you can improve CPU capacity or reduce load, find potential issues, and avoid unnecessary upgrade costs. CPU monitoring metrics also help identify unnecessary background processes running and determine process or application resource utilization and its impact on the entire network.

![image.png](../images/swarm-bee-8.png)

| **Metric Description** | **Name** | **Measurement Standard** |
| --- | --- | --- |
| CPU Load | `system.load1`<br />`system.load5`<br />`system.load15` | Resource Utilization |
| CPU Usage | `cpu.usage_idle`<br />`cpu.usage_user`<br />`cpu.usage_system` | Resource Utilization |

#### CPU Usage

CPU usage can be divided into:
- `User Time` (Percentage of time executing user processes)
- `System Time` (Percentage of time executing kernel processes and interrupts)
- `Idle Time` (Percentage of time CPU is idle)

For CPU performance, the run queue for each CPU should not exceed 3. If the CPU is fully loaded:
- `User Time` should be around 65%~70%
- `System Time` should be around 30%~35%
- `Idle Time` should be around 0%~5%

### 3. Memory Monitoring

Memory is one of the main factors affecting Linux performance. Adequate memory resources directly impact application system performance.

![image.png](../images/swarm-bee-9.png)

| **Metric Description** | **Name** | **Measurement Standard** |
| --- | --- | --- |
| Memory Usage Rate | `mem.used_percent` | Resource Utilization |
| Memory Usage | mem.free<br />`mem.used` | Resource Utilization |
| Memory Cache | `mem.buffered` | Resource Utilization |
| Memory Buffer | `mem.cached` | Resource Utilization |

#### Memory Usage Rate

Closely monitoring available memory usage is important because RAM contention inevitably leads to paging and performance degradation. To keep the machine running smoothly, ensure it has enough RAM to meet your workload. Persistent low memory availability can lead to segmentation faults and other serious issues. Remedies include increasing physical memory or enabling memory page merging if possible.

### 4. Disk Monitoring

![image.png](../images/swarm-bee-10.png)

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

Maintaining sufficient free disk space is essential for any operating system. Core system processes store logs and other types of data on the disk. Set alerts when available disk space drops below 15% to ensure business continuity.

#### Disk Read/Write Time

These metrics track the average time spent on disk read/write operations. Set alerts for values greater than 50 milliseconds, indicating relatively high latency (ideally less than 10 milliseconds). Transferring workloads to faster disks is recommended to reduce latency. Different roles may have different acceptable thresholds.

#### Disk Read/Write

If your server hosts resource-intensive applications, monitor disk I/O rates. Disk read/write metrics aggregate disk-marked read (`diskio.read_bytes`) and write (`diskio.write_bytes`) activities. Persistent high disk activity can degrade service performance and cause system instability, especially when combined with high RAM usage and swap files. Recommendations include increasing the number of disks, using faster disks, increasing RAM reserved for filesystem caching, or distributing workloads across more machines.

#### Disk Temperature

If your business requires high disk availability, set alerts to monitor disk working temperature. Temperatures above 65°C (SSD 75°C) require attention. If the disk overheats, it could damage the drive and result in data loss.

### 5. Network Monitoring

Your applications and infrastructure components depend on increasingly complex architectures. Whether you run monolithic applications or microservices, whether deployed to cloud infrastructure, private data centers, or both, virtualized infrastructure enables developers to respond dynamically, creating network patterns that do not match traditional monitoring tools. Datadog introduces network performance monitoring tailored for the cloud era.

![image.png](../images/swarm-bee-13.png)

| **Metric Description** | **Name** | **Measurement Standard** |
| --- | --- | --- |
| Network Traffic | `net.bytes_recv`<br />`net.bytes_sent` | Resource Utilization |
| Network Packets | `net.packets_recv`<br />`net.packets_sent` | Resource Utilization |
| Retransmissions | `net.tcp_retranssegs` | Availability |

#### Network Traffic

Together, these two metrics measure the total network throughput of a given network interface. For most consumer hardware, NIC transmission speed is at least 1 Gbps. Except in extreme cases, the network is unlikely to become a bottleneck. Set alerts when the interface bandwidth exceeds 80% utilization to prevent network saturation (for a 1 Gbps link, reaching 100 MBps).

#### Retransmissions

TCP retransmissions often occur but are not errors; however, they can indicate underlying issues. Retransmissions are usually due to network congestion and are associated with high bandwidth consumption. Monitor this metric because excessive retransmissions can cause significant application delays. If the sender does not receive acknowledgment of sent packets, it will delay sending more packets (typically for about 1 second), increasing latency and congestion-related speed.

If not caused by network congestion, the source of retransmissions might be faulty network hardware. Few dropped packets and high retransmission rates can lead to excessive buffering. Regardless of the cause, tracking this metric helps understand seemingly random fluctuations in network application response times.

## Conclusion

In this article, we discussed some of the most useful metrics you can monitor to retain labels during mining. If you are conducting mining operations, monitoring the following list of metrics will give you a good understanding of the mine's operational status and availability:

- **Disk Read/Write Latency**

- **Disk Temperature**
- **Network Traffic**
- **Daily Expected Earnings**
- **Harvester Preliminary Screening Pass Rate**
- **Processes**

Ultimately, you will recognize other metrics relevant to your specific use case. Of course, you can also learn more through [Guance](http://guance.com).