# Infrastructure Network Analysis
---

### 1. Why Perform Network Analysis

Whether running in local servers or cloud environments, modern services and applications heavily depend on network performance. Network stability is critical for business systems. If a critical business application fails and becomes unusable, you may need to troubleshoot by reviewing logs, examining the system, accessing programs, checking processes, and debugging services, which can consume a lot of valuable time.

However, with proper network traffic analysis and a clear understanding of the business chain, you can quickly pinpoint issues and identify where data packets are being lost. This saves time by avoiding unnecessary confirmation of middleware devices that are not problematic, significantly reducing troubleshooting time and enabling faster issue resolution.

Therefore, comprehensive visibility into the network is crucial for monitoring the operational status and performance of applications. However, as your applications grow larger and more complex, achieving this visibility becomes challenging. [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>/) will provide comprehensive observability for host networks.

### 2. Scope of Network Analysis Features

<<< custom_key.brand_name >>> offers host network analysis in the following two areas:

- **Host Network Topology**: Automatically generates network topology diagrams based on host network connections, providing a visual representation of network connectivity and traffic volume.
- **Host Network Details View**: Analyzes key network-related metrics from different perspectives based on transmission direction and protocol, as well as network connection details. It supports viewing real-time network flow data.

## Prerequisites

You need to first create a [<<< custom_key.brand_name >>> account](https://<<< custom_key.brand_main_domain >>>/), and install [DataKit](../../datakit/datakit-install.md) on your hosts. Enable the [eBPF](../../integrations/ebpf.md) integration to collect network data.

## Solving Problems with Network Observability

<<< custom_key.brand_name >>> decomposes and visualizes network data streams to provide comprehensive monitoring of host network performance. It helps you understand the real-time network operation status of your business systems, quickly analyze, track, and locate issues, preventing or avoiding business problems caused by network performance degradation or outages.

### Host Network Topology

View network traffic and data connections between source hosts and targets based on IP/port. Automatically generate host network distribution topology diagrams to show traffic exchange between hosts. Key network performance metrics such as `TCP delay`, `TCP jitter`, `TCP retransmission count`, `TCP connection count`, and `TCP close count` are automatically calculated. Node color, size, and other visual elements represent monitored metric data, making it more intuitive for users.

| Concept      | Description                          |
| ------------ | ------------------------------------ |
| Node         | Nodes represent source and target hosts. When the target host is not in the <<< custom_key.brand_name >>> workspace, the node displays the target domain name.                          |
| Node Size    | Represents the size of inbound traffic.                          |
| Node Color   | Filled with corresponding colors based on the selected analysis metric value (e.g., "TCP delay" as shown in the figure).                          |
| Connection Direction | Represents the direction of traffic.                          |
| Connection Thickness | Represents the size of inbound and outbound traffic.                          |

![](../img/7.host_network_2.png)

By observing the host network distribution and key performance indicators, you can understand current traffic conditions. For example, if an added managed service unintentionally consumes all your bandwidth, you can visualize your bandwidth data. Using TCP retransmission technology, you can quickly reveal where network issues are causing connection problems within your infrastructure. You can then investigate relevant logs, traces, and monitor traffic flow for troubleshooting.

![](../img/7.host_network_1.gif)

### Host Network Details View

<<< custom_key.brand_name >>> can query detailed network information for individual hosts, currently supporting TCP and UDP protocols, combined with incoming (inbound) and outgoing (outbound) directions, offering various combinations for network performance monitoring.

<<< custom_key.brand_name >>> provides seven types of network metric statistics for comprehensive real-time monitoring of network traffic: received/sent bytes, TCP delay, TCP jitter, TCP connection count, TCP retransmission count, and TCP close count. It supports viewing network connection data based on `source IP/port` and `destination IP/port`. You can customize and add metrics you need to focus on and filter data based on specific fields.

![](../img/7.host_network_3.png)