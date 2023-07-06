# Network Analysis
---
## Overview
### 1. Why do we want to do network analysis?

Whether running on a local server or in a cloud environment, modern services and applications are especially dependent on network performance. The stability of network is very important for business system. If a business-critical application fails and the program is unusable, you may need to sort through logs, view systems and access programs to find the point of failure, which can take a lot of valuable time.

However, if you master the correct network traffic analysis and comb the network traffic business chain, you can quickly locate the fault point and determine the packet loss location. It saves the confirmation process of middleware equipment without problems in the troubleshooting process.

So full network visibility becomes a key part of monitoring application health and performance, but as your applications grow in size and complexity, gaining that visibility becomes challenging. [Guance](https://www.guance.one/) will provide comprehensive observability of the host network.

### 2. Functional of Network Analysis

Guance will provide you with host network analysis from the following two aspects.

- **Host Network Distribution Diagram**: Automatically draw the network topology diagram and visually present the network connection situation and network traffic size according to the host network connection.
- **Host Network Details View**: Analyze important network-related metrics and network connectivity from different angles according to transmission direction and protocol. Viewing real-time network flow data is supported.

## Precondition

You need to create a [Guance account](https://www.guance.com) and [install DataKit](../../datakit/datakit-install.md) on your host to start the [eBPF](../../datakit/ebpf.md) integration to collect network data.

## Network Observable Positioning

Guance provides comprehensive monitoring of host network performance by decomposing and visualizing network data flow. It helps you know the network running status of business system in real time, quickly analyze and locate problems and prevent or avoid business problems caused by network performance degradation or interruption.

### Host Network Distribution

Based on IP/port, the network traffic and data connection between the source host and the target are viewed, and the network topology diagram of the host is automatically drawn to present the traffic exchange between the hosts. Host network distribution automatically counts the key performance metrics of the network, including `TCP delay`, `TCP fluctuation`, `TCP retransmission times`, `TCP connection times` and `TCP closure times` and expresses the monitored metric data through node color and size, so that users can be more intuitive.

- **Nod**: Nodes represent source and target hosts, and are displayed as target domain names when the target host is not in the Guance workspace.
- **Node size**: Represent the size of incoming traffic.
- **Node color**: Fill the corresponding color according to the value of the selected analysis indicator (as shown in the figure: the currently selected analysis indicator is "TCP Delay").
- **Direction of node connection**: Represent the direction of traffic.
- **Thickness of node wiring**: Represent the size of incoming and outgoing traffic.

![](../img/7.host_network_2.png)

By observing the host network distribution and key performance metrics, we can understand the current traffic situation. If you add a hosting service that inadvertently drains all of your bandwidth, you can visualize your bandwidth data, and through TCP retransmission technology, you can quickly reveal where network problems cause connection problems in your infrastructure. You can then troubleshoot by learning about the logs and links, and requesting tracks to monitor where the traffic is going.


![](../img/7.host_network_1.gif)



### Host Network Details View

Guance can query the detailed network information of a single host. At present, it supports network performance monitoring based on TCP and UDP protocols, with incoming and outgoing, and has a variety of combination choices. At the same time, it provides seven kinds of network index statistics to monitor network traffic in real time, namely received/sent bytes, TCP delay, TCP fluctuation, TCP connections, TCP retransmissions and TCP closures. It supports for viewing network connection data based on `source IP/port` and `destination IP/port`, you can customize to add metrics that need attention. Data filtering for fields is also supported.

![](../img/7.host_network_3.png)
