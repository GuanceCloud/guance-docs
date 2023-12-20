# Network
---

In Network, you are allowed to view network traffic between hosts, Pods, Deployments, and Services. It provides real-time visualization of network traffic and data connections between source IP and destination IP, helping businesses understand the network operation status of their systems, analyze, trace, and locate issues and faults, and prevent or avoid business problems caused by network performance degradation or interruption.

The network monitoring module of Guance includes three main components: [Overview](#host), [Map](#map), and [Network Flow](#netflow), providing comprehensive analysis of network data.


## Prerequisite

You need to register and log in to Guance, and [install DataKit](../datakit/datakit-install.md) on your host and enable the [eBPF clooector](../integrations/ebpf.md).

## Concepts {#concepts}

| Parameter         | Description                                     | Statistical Method               |
| ------------ | ---------------------------------------- | ---------------------- |
| IP/Port      | The target is aggregated based on IP + port and returns up to 100 pieces of data. | Analyze by IP/Port Packet     |
| Number of bytes sent   | Number of bytes sent by source host to destination                   | Sum the number of bytes sent by all records |
| Number of bytes accepted   | Number of bytes of destination received by source host                   | Sum of bytes received by all records |
| TCP Delay     | TCP latency from source host to destination                    | Average value                 |
| TCP Fluctuation     | TCP delay fluctuation from source host to destination                | Average value                 |
| TCP Number of connections   | Number of TCP connections from source host to destination                  | Summation                   |
| TCP Number of retransmissions | Number of TCP retransmissions from source host to destination                | Summation                   |
| TCP Number of closures | Number of TCP shutdowns from source host to destination                | Summation                   |


## Overview {#host}


Enter **Infrastructure > Network** and by default, you will be directed to the **Overview** page of **Host**:

![](img/net.png)

You can click on the host to switch between the Pod, Deployment and Service components:

<img src="../img/net-1.png" width="60%" >

### Network Path

Taking the host network situation as an example, you can view the network traffic and data connection status between the server and the client in the list, including the client, server, TCP retransmission count, TCP connection count, TCP close count, TCP latency, sent bytes, received bytes, etc.


Click on settings, and you can customize the displayed columns:

![](img/net-2.png)

**Note**: Custom display field changes need to be saved based on user hierarchy, not globally.

### Analysis Charts

On the current host network overview page, you can view trend change charts for different [parameters](#concepts) over different time periods.

![](img/net-3.png)

### Filter

On the left side of the Overview page, filters for transmission direction, transmission protocol, host, PID, and client-server related fields are included.

![](img/net-4.png)

???+ info "Combination of TCP and UDP Protocol" 

    Currently, network performance monitoring is supported for protocols based on TCP and UDP. In conjunction with incoming and outgoing, there are 6 possible combinations to choose from:

    incoming + Indistinguishing protocols  
    incoming + TCP protocols  
    incoming + UDP protocols  
    outgoing + Indistinguishing protocols
    outgoing + TCP protocols  
    outgoing + UDP protocols  

### Time Widget {#widget}

In the overview mode, the time widget allows you to control the data display range of the current list as needed. You can quickly select a built-in time range or customize the time range settings.

![](img/net-5.png)

> See [How to Use Time Widget Well](../getting-started/function-details/explorer-search.md#time).

### List Details

Taking the host network as an example, after the successful collection of host network data, it will be reported to the Guance console. Click on a network in the list to open the details page, where you can view all the network performance monitoring data information within the workspace. This includes the transmission direction between the client and server at the top, analysis charts and network connection analysis.

![](img/net-6.png)

???+ warning

    - Currently, only Linux systems are supported, and except for CentOS 7.6+ and Ubuntu 16.04, other distribution versions require a Linux kernel version higher than 4.0.0.

    - The host network traffic data is stored for the latest 48 hours by default; for Experience Plan, it is stored for the latest 24 hours by default.

    - Clicking on Network in the host details page, the [time widget](../getting-started/function-details/explorer-search.md#time) retrieves data for the latest 15 minutes by default and does not support automatic refresh. You need to manually click refresh to get new data.

> In the details page, there are also other operations such as time control, search, binding built-in views, export, etc. See [How to Use the Details Page Well](../getting-started/function-details/explorer-search.md).

#### Pod、Deployment、Service Data Details

In the details page, you can view the corresponding custom name and switch between L4 network and L7 network for data viewing.

#### Network Connection Analysis {#connect}

In the Details > Network Connection Analysis page, you can further view network connection data, including client, server, direction of transmission, bytes sent, bytes received, TCP latency, TCP retransmission, etc.

At the same time, you can customize the display fields through the :fontawesome-solid-gear: button, or add filtering conditions for connection data, filtering all keyword fields of string type. If you need to view more detailed network connection data, click on the data to view its corresponding network flow data.

## Map {#map}

Click on **Infrastructure > Network > Map** to view the distribution of upstream and downstream networks.

Taking hosts as an example, you can visually query the network traffic between the current workspace hosts and analyze the TCP latency, TCP fluctuations, TCP retransmission count, TCP connection count, and TCP close count between different hosts.

![](img/4.network_1.png)


- Time widget: By default, it retrieves data from the past 48 hours and does not support automatic refresh. You need to manually click refresh to get new data;

- Search and filter: You can quickly search host names based on keyword fuzzy matching or display host nodes and their relationships based on filtered tags.
    
- Fill: You can customize the filling of host nodes. The size and custom range of the filling value will determine the color of the filled host nodes. Multiple filling metrics are supported, including TCP latency, TCP fluctuations, TCP retransmission count, TCP connection count and TCP close count.  

- Host nodes:

    - Host nodes are divided into regular hosts and cloud hosts. Cloud hosts are displayed as logos of cloud service providers.

    - The edge color of the host nodes shows the corresponding color of the field value and the custom range.

    - The network traffic between host nodes is represented by connecting lines. The lines are bidirectional curves that show the flow direction from source host to target host (incoming/outgoing).

    - The size of the host nodes is determined by the size of the incoming traffic of the current node.
    
    - The thickness of the host nodes is determined by the size of the outgoing and incoming traffic data of the obtained nodes.

- Custom range: You can enable Custom Range to customize the color range of the selected filling metric. The colors in the legend will be divided into 5 intervals based on the maximum and minimum values, with each interval automatically corresponding to a different color. Lines and nodes that are outside the data range will be displayed in gray.	

- Hover: Hover over the host node to view the number of bytes sent, received, TCP latency, TCP fluctuations, TCP retransmission count, TCP connection count, and TCP close count.


**Note**: If the target host is not in the current workspace but the target domain name exists and the target domain name's port is less than 10,000, the target domain name will be displayed in the Map.


### Association Analysis

Click on the host/Pod/Deployment/Services icon, click on **View Upstream and Downstream**, you can view the associations of the current node with its upstream and downstream nodes. You can also view the details, associated logs, associated links, and associated events of the Host/Pod/Deployment/Services by clicking on them.


![](img/4.network_9.png)

Click on **Back to overview** in the upper left corner to return to the original Network Map. You can filter the associated upstream and downstream nodes by searching or filtering in the search box, and the matching associated upstream and downstream nodes will be displayed based on the search or filter results.

![](img/4.network_10.png)

## Network Flow Data {#netflow}

As mentioned earlier, you can [view network flow data on the list details page](#connect). In addition, on the Overview or Map page, click on the View Network Flow Data in the upper right corner to jump to the corresponding page. You can view L4 (netflow) and L7 (httpflow) network flow data on the timeline. All network flow data is automatically refreshed every 30 seconds, and the default display is the data from the last 15 minutes.

Switch between **L4 Network Flow** and **L7 Network Flow** to view data from different dispatches.

![](img/net-7.png)

> On the current page, there are also other operations such as time widget, search, save snapshot, display columns, etc. See [Powerful Explorer](../getting-started/function-details/explorer-search.md).
