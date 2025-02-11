# How to Enable Network Monitoring
---

## Introduction

Whether running on local servers or cloud environments, modern services and applications heavily rely on network performance. Network stability is crucial for business systems. If a critical business application fails and becomes unusable, you might need to sift through logs, inspect the system, access programs, check processes, and debug services, all of which can consume valuable time.

Therefore, comprehensive visibility into the network has become a key component in monitoring the operational status and performance of applications. However, as your applications scale and become more complex, achieving this visibility becomes challenging. [Guance](https://www.guance.com/) will provide comprehensive observability for host networks.

## Prerequisites

- You need to create a [Guance account](https://www.guance.com) first;
- Install [DataKit](../datakit/datakit-install.md) on your host;

## Method Steps

### Step 1: Enable the [eBPF](../integrations/ebpf.md) Integration to Collect Network Data

The eBPF collector gathers information about TCP and UDP connections on the host, bash execution logs, etc., including `ebpf-net` and `ebpf-bash`:

- **ebpf-net**:
   - Data Category: Network
   - Comprises netflow and dnsflow, used for collecting statistics on host TCP/UDP connections and DNS resolution information.
- **ebpf-bash**:
   - Data Category: Logging
   - Collects bash execution logs, including process IDs, usernames, executed commands, and timestamps.

The eBPF collector supports the operating system: `linux/amd64`. Except for CentOS 7.6+ and Ubuntu 16.04, other distributions require a Linux kernel version higher than 4.0.0.

#### Configure the eBPF Collector

Navigate to the `conf.d/host` directory under the DataKit installation directory, copy `ebpf.conf.sample`, and rename it to `ebpf.conf`. Example configuration:

```toml

[[inputs.ebpf]]
  daemon = true
  name = 'ebpf'
  cmd = "/usr/local/datakit/externals/datakit-ebpf"
  args = ["--datakit-apiserver", "0.0.0.0:9529"]
  envs = []

  ## All supported plugins:
  ## - "ebpf-net":
  ##     contains L4-network, DNS collection
  ## - "ebpf-bash":
  ##     log bash
  ##
  enabled_plugins = ["ebpf-net"]

  [inputs.ebpf.tags]
    # some_tag = "some_value"
    # more_tag = "some_other_value"

#############################
# Parameter Description (Parameters marked with * are required)
#############################
# --hostname               : Hostname, this parameter changes the value of the host tag when uploading data, priority order: specified parameter > ENV_HOSTNAME in datakit.conf (if not empty, added automatically at startup) > default value obtained by the collector
# --datakit-apiserver      : DataKit API Server address, default value 0.0.0.0:9529
# --log                    : Log output path, default value DataKitInstallDir/externals/datakit-ebpf.log
# --log-level              : Log level, default info
# --service                : Default value ebpf
```

By default, `ebpf-bash` is not enabled. To enable it, add `"ebpf-bash"` to the `enabled_plugins` configuration.

After configuring, restart DataKit.

### Step 2: Log in to Guance to View Host Network Details

Once host network data is successfully collected and reported to the Guance console, you can view all network performance monitoring data in the "Network" section of the host details page under "Infrastructure". 

Guance allows querying detailed network information for a single host, currently supporting TCP and UDP protocols, combined with incoming (inbound) and outgoing (outbound) directions, offering multiple combinations for network performance monitoring. It also provides seven network metrics for comprehensive real-time monitoring of network traffic, including: received/sent bytes, TCP delay, TCP jitter, TCP connection count, TCP retransmission count, and TCP close count.

![](img/01.png)

#### Network Connection Analysis

Guance supports viewing network connection data based on `source IP/port` and `destination IP/port`. You can customize and add metrics you care about and filter data based on fields. For example, if you want to query network connections where the destination port is 443 and analyze real-time network flow data.

![](img/444.gif)

### Step 3: Advanced Usage - Host Network Distribution Map

In "Infrastructure" -> "Host", click the small icon for the network distribution map in the top-left corner to switch to viewing the host network distribution. In the "Network Distribution Map," you can visually query network traffic between hosts within the current workspace, quickly analyzing TCP delay, TCP jitter, TCP retransmission count, TCP connection count, and TCP close count between different hosts.

- **Time Control**: Defaults to fetching data from the past 48 hours and does not support automatic refresh; you need to manually click to refresh for new data.
- **Search and Filtering**: Quickly search for host names using keyword matching or filter host nodes and their relationships based on tags.
- **Filling**: Customize the fill color of host nodes based on selected metrics such as TCP delay, TCP jitter, TCP retransmission count, TCP connection count, and TCP close count. The size and interval of the fill values determine the node colors.
- **Host Nodes**:
   - Icons for regular hosts and cloud hosts differ, with cloud hosts displaying logos of cloud service providers.
   - Edge colors of host nodes change based on the fill field values and custom intervals.
   - Network traffic between hosts is represented by bidirectional curves indicating inbound/outbound traffic.
   - Node sizes are determined by the inbound traffic volume.
   - Line thickness reflects the inbound/outbound traffic volume.
- **Associated Queries**: Clicking a host icon allows associated queries for host details, related logs, traces, and events.
- **Custom Intervals**: Enable "Custom Intervals" to set color ranges for selected fill metrics. The legend is divided into five intervals based on max and min values, each corresponding to a different color. Lines and nodes outside the data range are displayed in gray.
- **Mouse Hover**: Hovering over a host node shows sent/received bytes, TCP delay, TCP jitter, TCP retransmission count, TCP connection count, and TCP close count.

![](img/5.host_network.png)

By observing the host network distribution and key performance metrics, you can understand current traffic conditions. For instance, if an added managed service inadvertently consumes all your bandwidth, you can visualize your bandwidth data and quickly identify network issues causing connection problems in your infrastructure using TCP retransmission techniques. You can then investigate related logs and trace the flow of traffic for troubleshooting.

![](img/22.gif)

## Further References

For more information on network performance monitoring, refer to: [eBPF Collector](../integrations/ebpf.md)