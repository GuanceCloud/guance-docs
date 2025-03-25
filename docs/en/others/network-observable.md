# How to Enable Network Monitoring
---

## Introduction

Whether running in a local server or cloud environment, modern services and applications are particularly dependent on network performance. The stability of the network is crucial for business systems. If critical business applications fail and become unusable, you may need to spend valuable time troubleshooting by reviewing logs, examining systems, accessing programs, checking processes, and debugging services.

Therefore, having full visibility into the network becomes a key part of monitoring the operational status and performance of applications. However, as your application scale grows and becomes more complex, achieving this visibility becomes challenging. [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>/) will provide comprehensive observability for host networks.

## Prerequisites

- You need to first create a [<<< custom_key.brand_name >>> account](https://<<< custom_key.brand_main_domain >>>);
- Install DataKit on your host [Install DataKit](../datakit/datakit-install.md);

## Method Steps

### Step 1: Enable the [eBPF](../integrations/ebpf.md) integration runtime to collect network data

The eBPF collector gathers host network TCP, UDP connection information, bash execution logs, etc., including ebpf-net and ebpf-bash:

- ebpf-net:
   - Data category: NETWORK
   - Composed of netflow and dnsflow, used respectively for collecting host TCP/UDP connection statistics and host DNS resolution information;
- ebpf-bash:
   - Data category: LOGGING
   - Collects bash execution logs, including bash process ID, username, executed commands, and time;

The eBPF collector supports operating systems: `linux/amd64`, except for CentOS 7.6+ and Ubuntu 16.04, other distributions require a Linux kernel version higher than 4.0.0.

#### Configure the eBPF Collector

Navigate to the `conf.d/host` directory under the DataKit installation directory, copy `ebpf.conf.sample` and rename it to `ebpf.conf`. Example:

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
# Parameter Description (* indicates required options)
#############################
#  --hostname               : Hostname, this parameter can change the value of the host tag when uploading data from the collector; priority order: specifying this parameter > ENV_HOSTNAME value in datakit.conf (if not empty, automatically added at startup) > collector self-obtained (default value)
#  --datakit-apiserver      : DataKit API Server address, default value 0.0.0.0:9529
#  --log                    : Log output path, default value DataKitInstallDir/externals/datakit-ebpf.log
#  --log-level              : Log level, default info
#  --service                : Default value ebpf
```

By default, ebpf-bash is not enabled. To enable it, add "ebpf-bash" to the enabled_plugins configuration item.

After configuring, restart DataKit.

### Step 2: Log in to <<< custom_key.brand_name >>> to view detailed host network views

After successfully collecting host network data, it will be reported to the <<< custom_key.brand_name >>> console. In the "Infrastructure" - "Host" details page under "Network," you can view all network performance monitoring data within the workspace.

<<< custom_key.brand_name >>> allows querying detailed network information for individual hosts. Currently, it supports TCP and UDP protocols combined with incoming (inbound) and outgoing (outbound) traffic for various network performance monitoring combinations. It also provides seven types of network Metrics statistics for real-time monitoring of network traffic, including: received/sent bytes, TCP delay, TCP jitter, TCP connections, TCP retransmissions, and TCP closes.

![](img/01.png)

#### Network Connection Analysis


<<< custom_key.brand_name >>> supports viewing network connection data based on `source IP/port` and "destination IP/port". You can customize and add metrics of interest, supporting data filtering by fields. For example, if you want to query network connections where the target port is 443 and analyze the real-time network flow data for these connections.

![](img/444.gif)

### Step 3: Advanced Usage - Host Network Distribution Map

In "Infrastructure" - "Host," click the small icon in the upper left corner of the network distribution map to switch to the host network distribution view. In the "Network Distribution Map," you can visually query the network traffic between hosts within the current workspace, quickly analyzing TCP delays, TCP jitter, TCP retransmission counts, TCP connection counts, and TCP close counts between different hosts.

- Time Widget: By default, retrieves data from the last 48 hours and does not support automatic refresh; you need to manually click to refresh for new data.
- Search and Filter: You can quickly search for host names based on keyword fuzzy matching; or display host nodes and their relationships based on filtered Tags.
- Fill: You can customize the fill of host nodes through "Fill." The size of the fill value and the custom range will determine the color of the filled host nodes. Supports selecting multiple fill Metrics such as TCP delay, TCP jitter, TCP retransmission count, TCP connection count, and TCP close count.
- Host Nodes:
   - Host node icons are divided into regular hosts and cloud hosts; cloud hosts display as cloud service provider logos.
   - The edge color of host nodes displays corresponding segment colors based on the field values and custom ranges filled.
   - Connections between host nodes represent network traffic. The connections are bidirectional curves showing the incoming/outgoing direction of traffic from the source host to the destination host.
   - The size of the host nodes is determined by the inbound traffic size of the current node.
   - The thickness of the lines connecting the host nodes is determined by the size of the inbound/outbound traffic data obtained from the nodes.
- Associated Queries: You can perform associated queries by clicking on host icons, supporting viewing host details, associated logs, related traces, and associated events.
- Custom Ranges: You can enable "Custom Ranges" to define legend color range intervals for selected fill Metrics. The legend colors will be divided into five equal intervals based on the maximum and minimum values of the legend, each corresponding to five different colors. Connections and nodes outside the data range will be displayed in gray.
- Mouse Hover: Hovering the mouse over host object nodes allows you to view sent bytes, received bytes, TCP delay, TCP jitter, TCP retransmission count, TCP connection count, and TCP close count.

![](img/5.host_network.png)

By observing the host network distribution and key performance indicators, understand the current traffic situation. Suppose an added managed service unintentionally consumes all your bandwidth. You can visualize your bandwidth data and use TCP retransmission techniques to quickly reveal the location of network issues causing connection problems within your infrastructure. Afterwards, you can understand relevant logs and request trace monitoring of traffic destinations for troubleshooting.

![](img/22.gif)

## More References
For more about network performance monitoring, refer to: [eBPF collector](../integrations/ebpf.md)