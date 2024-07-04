# BPF Network Logs

BPF, or Berkeley Packet Filter, is a kernel-level packet filtering technology that enhances network efficiency and security by capturing and filtering packets. BPF rules define filtering criteria such as IP addresses, protocols, and port numbers, acting as a sophisticated sieve for desired network traffic.

Guance utilizes BPF for advanced Linux network packet processing, collecting, displaying, and visualizing network traffic data to facilitate a deep understanding and diagnosis of network issues.


## Classification

- [Four-layer BPF Network Logs](#l4) (`bpf_net_l4_log`): The fourth layer refers to the transport layer, which is mainly responsible for end-to-end data transmission. This module records network traffic information based on transport layer protocols (such as TCP, UDP);  
- [Seven-layer BPF Network Logs](#l7) (`bpf_net_l7_log`): The seventh layer refers to the application layer, involving specific application protocols, such as HTTP, FTP, etc. This module records network traffic information based on application layer protocols.

### L4 BPF Network Logs {#l4}

In the log explorer, filter for data with `source:bpf_net_l4_log` to enter the detail page:


![](img/bpf_net_l4_log-1.png)

* Message: View the detailed message content of each network flow, intuitively displaying different time points and packet directions.  
* Packet Interaction: Analyze the exchange of packets between the client and the server.    
* Time Difference(TD): Record the time difference in packet transmission.
  

### Network Details

Based on the direction of network transmission, the client and server are displayed:

![](img/bpf_net_l4_log-2.png)

outgoing: The source address `(src_ip)` is the client, and the destination address `(dst_ip)` is the server.
incoming: The source address `(src_ip)` is the server, and the destination address `(dst_ip)` is the client.
unknown: The source address `(src_ip)` is marked as Local, and the destination address `(dst_ip)` is marked as Remote.

#### Network Correlation Analysis

When a message is associated with the seven-layer network, display the HTTP method (`http_method`) and path (`http_path`).

If a packet contains L7 network log data, you can directly click to open a new page to view the detailed logs of the seven-layer network.

![](img/bpf_net_l4_log-1-1.png)

In the search box at the top right, you can search for packets based on seq to quickly locate.


### L7 BPF Network Logs {#l7}

Display a list of all network flows and be able to view the detailed information of each network flow. In the log explorer, filter for data with `source:bpf_net_l7_log` to enter the detail page:


![](img/bpf_net_l7_log.png)


#### Network Request Topology

Display the network request path, the request process and time consumption between physical hosts and virtual hosts. Guance will show you the flow between nodes to help you understand the complexity of network communication.


- Virtual Network Card: Display information such as `pod_name`、`nic_name`、`dst_port`、`src_port`、`k8s_namespace`、`k8s_container_name`、`host`, etc.
- Physical Network Card: Display information such as `host`、`nic_name`、`dst_port`、`src_port`、`l4_proto`、`l7_proto`, etc.


<img src="../img/bpf_net_l7_log-1.png" width="70%" >

If there is an external unknown network situation, it will show N/A.

<img src="../img/bpf_net_l7_log-2.png" width="70%" >

- Hover over the port of the network card node to display `ip:port`.
- If you need to view the details of the network data, hover over the network card node and click the :fontawesome-solid-arrow-up-right-from-square: button at the top right to jump to the corresponding page.

![](img/bpf_net_l7_log-4.png)

#### Related BPF Logs

Guance displays related log data based on three dimensions: single connection request, cross-network card request, and transport layer request.

- Single Connection: Requests and responses made between the client and server through a single network connection. 
- Cross-card: Requests that span different network cards. For example, in a virtualized environment, a request may be initiated from a virtual network card of a virtual machine, and then sent to another virtual machine or an external server through the physical network card of the host machine.
- Transport Layer: Refers to transport layer network logs, such as requests made in TCP or UDP protocols.


![](img/bpf_net_l7_log-3.png)

- Click the :material-reorder-horizontal: on the right to modify the display columns of the network logs:

![](img/bpf_net_l7_log-5.png)

## Troubleshooting

When a network problem occurs, you can follow these steps for BPF network troubleshooting:

1. Confirm the problem phenomenon: Record the manifestations of the network problem, such as connection timeouts, packet loss, etc.
2. Check the four-layer logs: Check the basic information of the relevant network flow through bpf_net_l4_log to confirm the transmission direction and basic information of the packets.
3. Dive into the seven-layer logs: If the problem may involve the application layer, check the detailed interactions of the application layer through bpf_net_l7_log.
4. Analyze the network topology: Use the network request topology function to check the calling relationship and time consumption between virtual and physical network cards, to confirm whether there is network latency or interruption.
5. Correlation analysis: Check if there are specific application layer protocols causing problems through four-seven layer correlation analysis.
6. Log correlation: Check all logs related to the problematic network flow to find potential clues to the problem.



Through the above steps, you can effectively use BPF network visualization for troubleshooting and analysis of network problems, thereby quickly locating and solving the issues.