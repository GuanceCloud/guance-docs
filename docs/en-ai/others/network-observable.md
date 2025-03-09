# How to Enable Network Monitoring
---

## Introduction

Whether running on local servers or cloud environments, modern services and applications heavily rely on network performance. Network stability is crucial for business systems. If a critical business application fails and becomes unusable, you may need to sift through logs, check the system, access programs, review processes, debug services, and more to find the fault point, which can consume valuable time.

Therefore, comprehensive visibility into the network becomes a key part of monitoring the operational status and performance of applications. However, as your applications scale up and become more complex, achieving this visibility becomes challenging. [<<< custom_key.brand_name >>>](https://www.guance.com/) will provide full observability for host networks.

## Prerequisites

- You need to first create a [<<< custom_key.brand_name >>> account](https://www.guance.com);
- Install DataKit on your host [Install DataKit](../datakit/datakit-install.md);

## Method Steps

### Step 1: Enable the [eBPF](../integrations/ebpf.md) Integration to Collect Network Data

The eBPF collector gathers information about host network TCP, UDP connections, bash execution logs, etc., including `ebpf-net` and `ebpf-bash`:

- `ebpf-net`: 
   - Data Category: Network
   - Composed of netflow and dnsflow, used to collect statistics on host TCP/UDP connections and DNS resolution information;
- `ebpf-bash`: 
   - Data Category: Logging
   - Collects bash execution logs, including process ID, username, executed commands, and timestamps;

The eBPF collector supports the operating system: `linux/amd64`, except for CentOS 7.6+ and Ubuntu 16.04, other distributions require a Linux kernel version higher than 4.0.0.

#### Configure the eBPF Collector

Navigate to the `conf.d/host` directory under the DataKit installation directory, copy `ebpf.conf.sample` and rename it to `ebpf.conf`. Example configuration:

```toml
[[inputs.ebpf]]
  daemon = true
  name = 'ebpf'
  cmd = "/usr/local/datakit/externals/datakit-ebpf"
  args = ["--datakit-apiserver", "0.0.0.0:9529"]
  envs = []

  ## all supported plugins:
  ## - "ebpf-net":
  ##     contains L4-network, dns collection
  ## - "ebpf-bash":
  ##     log bash
  ##
  enabled_plugins = ["ebpf-net"]

  [inputs.ebpf.tags]
    # some_tag = "some_value"
    # more_tag = "some_other_value"

#############################
# Parameter Description (if marked with * it's required)
#############################
#  --hostname               : Hostname, this parameter can change the value of the host tag when uploading data; priority order: specified parameter > ENV_HOSTNAME in datakit.conf (if not empty, added automatically at startup) > collector default retrieval
#  --datakit-apiserver      : DataKit API Server address, default value 0.0.0.0:9529
#  --log                    : Log output path, default value DataKitInstallDir/externals/datakit-ebpf.log
#  --log-level              : Log level, default info
#  --service                : Default value ebpf
```

By default, `ebpf-bash` is not enabled. To enable it, add `"ebpf-bash"` to the `enabled_plugins` configuration.

After configuring, restart DataKit.

### Step 2: Log in to <<< custom_key.brand_name >>> to View Host Network Details

Once the host network data is successfully collected, it will be reported to the <<< custom_key.brand_name >>> console. In the "Infrastructure" - "Host" detail page under "Network," you can view all network performance monitoring data within your workspace.

<<< custom_key.brand_name >>> allows querying detailed network information for individual hosts, currently supporting TCP and UDP protocols, combined with incoming and outgoing directions, offering multiple combinations for network performance monitoring. It also provides seven types of network metrics statistics for real-time monitoring of network traffic, including: received/transmitted bytes, TCP delay, TCP jitter, TCP connection count, TCP retransmission count, and TCP close count.

![](img/01.png)

#### Network Connection Analysis

<<< custom_key.brand_name >>> supports viewing network connection data based on `source IP/port` and "destination IP/port." You can customize and add metrics of interest, filter data by fields, such as querying network connections with a target port of 443 and analyzing real-time network flow data.

![](img/444.gif)

### Step 3: Advanced Usage - Host Network Distribution Map

In "Infrastructure" - "Host," click the small icon of the network distribution map in the top-left corner to switch to viewing the host network distribution. In the "Network Distribution Map," you can visually query network traffic between hosts within your workspace, quickly analyze TCP delay, TCP jitter, TCP retransmission count, TCP connection count, and TCP close count between different hosts.

- Time Widget: Defaults to fetching data from the last 48 hours and does not support auto-refresh; manual refresh is required.
- Search and Filtering: Quickly search for host names using keyword matching or filter by Tag labels to display host nodes and their relationships.
- Filling: Customize the filling of host nodes using selected metrics like TCP delay, TCP jitter, TCP retransmission count, TCP connection count, and TCP close count. The size and interval of the fill values determine the color of the host nodes.
- Host Nodes:
   - Icons are divided into regular hosts and cloud hosts, with cloud hosts displaying logos of cloud service providers.
   - Edge colors of host nodes are determined by the fill field values and custom intervals.
   - Network traffic between host nodes is represented by bidirectional curves showing incoming/outgoing traffic.
   - Node size is determined by the inbound traffic volume.
   - Line thickness is determined by the inbound/outbound traffic data volume.
- Associated Queries: Clicking on a host icon allows associated queries, including host details, related logs, related traces, and related events.
- Custom Intervals: Enable "Custom Intervals" to set color ranges for selected fill metrics. The legend is divided into five intervals based on the maximum and minimum values, each corresponding to a different color. Connections and nodes outside the data range are displayed in gray.
- Mouse Hover: Hovering over a host node displays sent/received bytes, TCP delay, TCP jitter, TCP retransmission count, TCP connection count, and TCP close count.

![](img/5.host_network.png)

By observing the host network distribution and key performance indicators, you can understand current traffic conditions. For example, if an added managed service inadvertently consumes all your bandwidth, you can visualize your bandwidth data and use TCP retransmission techniques to quickly identify network issues causing connection problems in your infrastructure. You can then investigate related logs and request trace monitoring to troubleshoot the issue.

![](img/22.gif)

## Additional References
For more information on network performance monitoring, refer to: [eBPF Collector](../integrations/ebpf.md)