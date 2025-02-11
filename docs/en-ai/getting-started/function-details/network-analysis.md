# Infrastructure Network Analysis
---

### 1. Why Perform Network Analysis

Whether running in local servers or cloud environments, modern services and applications are particularly dependent on network performance. Network stability is critical for business systems. If a critical business application fails and becomes unusable, you might need to sift through logs, check systems, access programs, view processes, and debug services to find the fault point, which can take a lot of valuable time.

However, with proper network traffic analysis and understanding of the network traffic business chain, you can quickly pinpoint fault points and determine where data packets are lost. This saves time by avoiding the need to confirm intermediate devices that are not problematic during troubleshooting, significantly reducing downtime and allowing for faster issue resolution.

Therefore, comprehensive visibility into the network is key to monitoring the operational status and performance of applications. However, as your applications grow in scale and complexity, achieving this visibility becomes challenging. [Guance](https://www.guance.com/) will provide comprehensive observability for host networks.

### 2. Scope of Network Analysis Features

Guance will provide you with host network analysis in two main areas:

- **Host Network Topology**: Automatically generate network topology diagrams based on host network connections, intuitively presenting network connection statuses and traffic volumes.
- **Host Network Details View**: Parse important network-related metrics from different angles based on transmission direction and protocol, as well as network connection statuses, supporting real-time viewing of network flow data.

## Prerequisites

You need to first create a [Guance account](https://www.guance.com/), and install [DataKit](../../datakit/datakit-install.md) on your host, enabling the [eBPF](../../integrations/ebpf.md) integration to collect network data.

## Using Network Observability to Solve Our Problems

Guance breaks down and visualizes network data streams, providing comprehensive monitoring of host network performance. It helps you gain real-time insights into the network operation status of your business systems, quickly analyze, track, and locate issues, preventing or avoiding business problems caused by network performance degradation or outages.

### Host Network Topology

View network traffic and data connections between source hosts and targets based on IP/port, automatically generating a host network distribution topology diagram that shows traffic exchange between hosts. It automatically calculates key network performance metrics, including `TCP Delay`, `TCP Jitter`, `TCP Retransmission Count`, `TCP Connection Count`, and `TCP Close Count`. Node colors and sizes visually represent these metric values, making it more intuitive for users.

| Concept      | Description                          |
| ----------- | ------------------------------------ |
| Node      | Represents source and target hosts. When the target host is not within the Guance workspace, the node displays the target domain.                          |
| Node Size      | Represents the size of inbound traffic.                          |
| Node Color      | Filled with corresponding colors based on the selected analysis metric value (e.g., "TCP Delay").                          |
| Direction of Node Links      | Represents the direction of traffic.                          |
| Thickness of Node Links      | Represents the size of inbound and outbound traffic.                          |

![](../img/7.host_network_2.png)

By observing the host network distribution and key performance indicators, you can understand current traffic conditions. For example, if an added managed service inadvertently consumes all your bandwidth, you can visualize your bandwidth data and quickly identify network issues causing connectivity problems in your infrastructure using TCP retransmission techniques. You can then investigate related logs, traces, and monitor traffic destinations for troubleshooting.

![](../img/7.host_network_1.gif)

### Host Network Details View

Guance can query detailed network information for individual hosts, currently supporting TCP and UDP protocols, combined with incoming and outgoing directions, offering multiple combinations for network performance monitoring.

Guance also provides seven types of network metrics statistics for comprehensive real-time monitoring of network traffic: received/sent bytes, TCP delay, TCP jitter, TCP connection count, TCP retransmission count, and TCP close count. It supports viewing network connection data based on `source IP/port` and `target IP/port`. You can customize and add metrics of interest and filter data based on fields.

![](../img/7.host_network_3.png)