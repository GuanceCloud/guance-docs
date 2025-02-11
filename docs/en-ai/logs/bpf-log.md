# BPF Network Logs

BPF Network, which stands for Berkeley Packet Filter (BPF) technology, is a network packet filtering technique that operates at the operating system kernel level. It helps capture and filter packets passing through the network to improve network efficiency and perform security checks. BPF rules are a special language used to define filtering conditions, such as source IP, destination IP, protocol type, or port number. In short, BPF acts like an advanced network sieve that filters out network packets based on predefined rules.

As an advanced Linux network packet processing technology, Guance leverages BPF technology to collect and display network traffic data, providing visualizations that help you gain deep insights into network behavior and diagnose issues.

## Module Breakdown

- [Layer 4 BPF Network Logs](#l4) (`bpf_net_l4_log`): Layer 4 refers to the transport layer, primarily responsible for end-to-end data transmission. This module logs network traffic information based on transport layer protocols such as TCP and UDP.
- [Layer 7 BPF Network Logs](#l7) (`bpf_net_l7_log`): Layer 7 refers to the application layer, involving specific application protocols like HTTP and FTP. This module logs network traffic information based on application layer protocols.

### Layer 4 BPF Network Logs {#l4}

In the log Explorer, filter for `source:bpf_net_l4_log` to access detailed pages:

![](img/bpf_net_l4_log-1.png)

* Packet Content: View detailed packet content for each network flow, visually displaying different time points and packet directions.
* Packet Interaction: Analyze packet exchanges between client and server.
* Time Difference: Record the time differences in packet transmission.

### Network Details

Based on network transmission direction, the client and server are displayed accordingly:

![](img/bpf_net_l4_log-2.png)

* outgoing: Source address (`src_ip`) is the client, destination address (`dst_ip`) is the server.
* incoming: Source address (`src_ip`) is the server, destination address (`dst_ip`) is the client.
* unknown: Source address (`src_ip`) is marked as Local, destination address (`dst_ip`) is marked as Remote.

#### Layer 4 and Layer 7 Network Correlation Analysis

When packets are associated with Layer 7 networks, HTTP methods (`http_method`) and paths (`http_path`) are displayed.

If a packet contains L7 network log data, you can directly click to open a new page to view detailed Layer 7 network logs.

![](img/bpf_net_l4_log-1.gif)

The search box in the top-right corner supports searching for packets by seq, allowing quick location.

### Layer 7 BPF Network Logs {#l7}

Displays a list of all network flows and allows viewing detailed information for each flow. In the log Explorer, filter for `source:bpf_net_l7_log` to access detailed pages:

![](img/bpf_net_l7_log.png)

#### Network Request Topology

Shows the path of network requests, including the request process between physical hosts and virtual hosts, along with response times. Guance displays the flow between nodes, helping you understand the complexity of network communication.

- Virtual NICs: Displays information such as `pod_name`, `nic_name`, `dst_port`, `src_port`, `k8s_namespace`, `k8s_container_name`, `host`, etc.
- Physical NICs: Displays information such as `host`, `nic_name`, `dst_port`, `src_port`, `l4_proto`, `l7_proto`, etc.

**Note**: If there are unknown external network situations, it will show N/A.

<img src="../img/bpf_net_l7_log-1.png" width="70%" >

For network NICs, you can perform the following operations:

1. Hover over the port of a NIC node to display `ip:port`.
2. To view network data details, hover over the NIC node and click the :fontawesome-solid-arrow-up-right-from-square: button in the top-right corner to navigate to the corresponding page.

![](img/bpf_net_l7_log-4.png)

#### Associated Network Logs

Guance displays related log data from three dimensions: single connection requests, cross-NIC requests, and transport layer requests.

* Single Connection Requests: Requests and responses between client and server via a single network connection.
* Cross-NIC Requests: Requests spanning different NICs. For example, in a virtualized environment, a request may originate from one virtual NIC of a VM and then be sent through the host's physical NIC to another VM or external server.
* Transport Layer Requests: Refers to transport layer network logs, such as requests made using TCP or UDP protocols.

Click the :material-reorder-horizontal: icon on the right to modify the columns displayed in the network logs:

![](img/bpf_net_l7_log-5.png)

## Example of Network Issue Troubleshooting

When a network issue occurs, follow these steps for BPF network troubleshooting:

1. Confirm the issue: Document the symptoms of the network problem, such as connection timeouts or packet loss.
2. Check Layer 4 Logs: Use `bpf_net_l4_log` to view basic information about relevant network flows, confirming transmission direction and packet details.
3. Delve into Layer 7 Logs: If the issue involves the application layer, use `bpf_net_l7_log` to examine detailed interactions at the application layer.
4. Analyze Network Topology: Utilize the network request topology feature to check call relationships and response times between virtual and physical NICs, identifying potential network delays or interruptions.
5. Correlation Analysis: Through Layer 4 and Layer 7 correlation analysis, check if specific application layer protocols are causing the issue.
6. Log Correlation: Review all logs related to the problematic network flow to identify potential clues.

By following these steps, you can effectively use BPF network visualization to troubleshoot and analyze network issues, quickly pinpointing and resolving problems.