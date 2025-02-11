# Network

---

The network module supports viewing network traffic between hosts, Pods, Deployments, and Services. Based on server-side and client-side perspectives, it displays the network traffic and data connection status from source IP to destination IP in real-time through visualization. This helps enterprises understand the network operation status of their business systems in real-time, quickly analyze, track, and locate issues, and prevent or avoid business problems caused by decreased network performance or interruptions.

Guance's network module includes three main sections: [Summary](#host), [Service Map](#map), and [Network Flow](#netflow), providing a comprehensive analysis of real-time network data.

## Prerequisites

You need to first register and log in to Guance, and then [install DataKit](../datakit/datakit-install.md) on your host, enabling the [eBPF collector](../integrations/ebpf.md).

## Concept Overview {#concepts}

| Parameter         | Description                                     | Statistical Method               |
| ------------ | ---------------------------------------- | ---------------------- |
| IP/Port      | Aggregates based on IP+port, returns up to 100 records | Grouped statistics by IP/port     |
| Sent Bytes   | Number of bytes sent from the source host to the target                   | Sum of all sent bytes |
| Received Bytes   | Number of bytes received by the source host from the target                   | Sum of all received bytes |
| TCP Delay     | TCP delay from the source host to the target                    | Average value                 |
| TCP Jitter     | TCP delay fluctuation from the source host to the target                | Average value                 |
| TCP Connections   | Number of TCP connections from the source host to the target                  | Total sum                   |
| TCP Retransmissions | Number of TCP retransmissions from the source host to the target                | Total sum                   |
| TCP Closures | Number of TCP closures from the source host to the target                | Total sum                   |

## Summary {#host}

Navigate to **Infrastructure > Network**, and by default, enter the **Host** **Summary** page:

![](img/net.png)

You can click on the host to switch to Pod, Deployment, or Service components:

<img src="../img/net-1.png" width="60%" >

### Network Path

Using the host network as an example, you can view network traffic and data connection status between client and server endpoints in the list, including client, server, TCP retransmissions, TCP connections, TCP closures, TCP delay, sent bytes, received bytes, etc.

Clicking on settings allows you to customize the displayed columns:

![](img/net-2.png)

**Note**: Custom display field changes are user-level and not globally saved.

### Analysis Charts

On the current host network summary page, you can view trend charts for different [parameters](#concepts) over various time periods.

![](img/net-3.png)

### Quick Filters

On the summary page’s left side, quick filters mainly include transmission direction, transmission protocol, host, PID, and fields related to clients and servers:

![](img/net-4.png)

???+ info "Combination of Transmission Direction and Protocol"

    Currently supports network performance monitoring based on TCP and UDP protocols. Combined with incoming and outgoing, there are six combination options:

    incoming + no protocol distinction  
    incoming + TCP protocol  
    incoming + UDP protocol  
    outgoing + no protocol distinction  
    outgoing + TCP protocol  
    outgoing + UDP protocol  

### Time Widget {#widget}

In summary mode, the time widget allows you to control the data display range as needed. You can quickly select built-in time ranges or set custom time ranges.

![](img/net-5.png)

> For more details, refer to [How to Use the Time Widget](../getting-started/function-details/explorer-search.md#time).

### List Details

Taking the host network as an example, after successful data collection, host network data is reported to the Guance console. Clicking on a network data entry in the list opens the details page where you can view all network performance monitoring data within the workspace, including top-level client-server transmission directions, analysis charts, and network connection analysis.

![](img/net-6.png)

To avoid query failures due to excessive return results, you can choose to aggregate data by IP dimension.

![](img/net-8.png)

???+ warning

    - Currently only supports Linux systems, and except for CentOS 7.6+ and Ubuntu 16.04, other distributions require a Linux kernel version higher than 4.0.0;

    - Host network traffic data is retained for the last 48 hours by default, while Free Plan retains data for the last 24 hours;

    - In the host detail page, clicking into **Network**, the [time widget](../getting-started/function-details/explorer-search.md#time) defaults to fetching the last 15 minutes of data and does not support automatic refresh; manual refresh is required.

> The detail page also includes other operations such as time widgets, search, binding built-in views, export, etc. Refer to [Effective Use of Detail Pages](../getting-started/function-details/explorer-search.md).

#### Pod, Deployment, and Service Data Details

In the detail page, you can view the corresponding object names and switch between L4 and L7 networks for data viewing.

#### Network Connection Analysis {#connect}

In the detail page > Network Connection Analysis, you can further view network connection data, including client, server, transmission direction, sent bytes, received bytes, TCP delay, TCP retransmissions, etc.

Additionally, you can customize the displayed fields via the **Settings** button or add filter conditions for keyword fields. To view more detailed network connection data, click on the data to view its corresponding network flow data.

## Service Map {#map}

Click into **Infrastructure > Network > Service Map** to view the upstream and downstream distribution of the network.

Using hosts as an example, it supports visual queries of network traffic between hosts in the current workspace, allowing for quick analysis of TCP delays, TCP jitter, TCP retransmissions, TCP connection counts, and TCP closure counts between different hosts.

![](img/4.network_1.png)

- Time Widget: Defaults to fetching data from the last 48 hours and does not support automatic refresh; manual refresh is required.
- Search and Filtering: You can quickly search for host names based on fuzzy keyword matching or display host nodes and their associated relationships based on filtered tags.
- Filling: You can customize the filling of host nodes, with fill values determining the size and custom intervals of the node colors. Supports multiple fill metrics like TCP delay, TCP jitter, TCP retransmissions, TCP connection counts, and TCP closure counts.
- Host Nodes:
    - Host node icons are divided into regular hosts and cloud hosts, with cloud hosts displaying logos of cloud service providers.
    - Edge colors of host nodes are determined by the values of filled fields and custom intervals.
    - Host nodes are connected by lines representing network traffic, with bidirectional curves showing incoming/outgoing traffic from source to target hosts.
    - Node sizes are determined by the inbound traffic volume.
    - Line thicknesses are determined by the inbound and outbound traffic volumes.
- Custom Intervals: You can enable **Custom Intervals** to define color ranges for selected fill metrics. Legend colors are divided into five intervals based on maximum and minimum values, each corresponding to a different color. Lines and nodes outside the data range are grayed out.
- Mouse Hover: Hovering over a host node shows sent bytes, received bytes, TCP delay, TCP jitter, TCP retransmissions, TCP connection counts, and TCP closure counts.

**Note**: If the target host is not in the current workspace but the target domain exists and the port number is less than 10000, the target domain will be displayed in the service map.

### Correlation Analysis

Click on the host/Pod/Deployment/Services icon, then click **View Upstream/Downstream** to see the upstream/downstream nodes of the current node. You can also view host/Pod/Deployment/Services details, associated logs, traces, and events, and navigate accordingly.

![](img/4.network_9.png)

Click the **Return to Summary** button in the top-left corner to return to the original network map. Searching or filtering in the search box filters the associated upstream/downstream nodes according to the search or filter results.

![](img/4.network_10.png)

## Network Flow Data {#netflow}

As mentioned earlier, you can [view network flow data in the list detail page](#connect). Additionally, on the **Summary** or **Service Map** pages, click the **View Network Flow Data** button in the top-right corner to navigate to the corresponding page. You can view L4 (netflow) and L7 (httpflow) network flow data on the timeline. All network flow data auto-refreshes every 30 seconds, defaulting to the last 15 minutes of data.

Switch between **L4 Network Flow** and **L7 Network Flow** at the top to view different scheduled data.

![](img/net-7.png)

> On this page, other operations such as time widgets, search, snapshot saving, column display, etc., are available. Refer to [The Power of Explorer](../getting-started/function-details/explorer-search.md).

<!-- 
### Host Network List

In **Infrastructure > Network**, selecting **Host** allows switching to the host network list to view network traffic and data connection status between source host IP/port and target IP/port, including TCP retransmissions, TCP connections, TCP closures, TCP delay, sent bytes, received bytes, etc.

**Note**: Due to network pre-aggregation time units being minutes, there may be slight differences between network list mode and detail page data. In case of discrepancies, follow the content on the detail page.

![](img/4.network_2.png)

## Pods Network {#pod}

### Pods Topology Map

In **Infrastructure > Network**, selecting **Pods** allows viewing the network distribution of Pods. In the **Pods Network Map**, you can visualize queries of network traffic between Pods in the current workspace, quickly analyzing TCP delays, TCP jitter, TCP retransmissions, TCP connection counts, TCP closure counts, sent bytes, received bytes, requests per second, error rates, and average response times between different Pods.

- Time Widget: Defaults to fetching the last 15 minutes of data and does not support automatic refresh; manual refresh is required.
- Search and Filtering: Quickly search for Pod names based on fuzzy keyword matching or display Pods and their associated relationships based on filtered tags.
- Filling: Customize the filling of host nodes, with fill values determining the size and custom intervals of the node colors. Supports seven-layer network fill metrics like TCP delay, TCP jitter, TCP retransmissions, TCP connection counts, TCP closure counts, sent bytes, received bytes, requests per second, error rates, and average response times.

- Pods Nodes:
    - Edge colors of Pods nodes are determined by the values of filled fields and custom intervals.
    - Pods nodes are connected by lines representing network traffic, with bidirectional curves showing incoming/outgoing traffic from source Pods to target Pods.
    - Node sizes are determined by the inbound traffic volume.
    - Line thicknesses are determined by the inbound and outbound traffic volumes.
- Custom Intervals: Enable **Custom Intervals** to define color ranges for selected fill metrics. Legend colors are divided into five intervals based on maximum and minimum values, each corresponding to a different color. Lines and nodes outside the data range are grayed out.
- Mouse Hover: Hovering over Pods nodes shows sent bytes, received bytes, TCP delay, TCP jitter, TCP retransmissions, TCP connection counts, TCP closure counts, sent bytes, received bytes, requests per second, error rates, and average response times.

![](img/4.network_3.png)

### Pods Network List

In **Infrastructure > Network**, selecting **Pods** allows switching to the Pods network list to view network traffic, data connection status, and status codes between source Pods IP/port and target IP/port, including TCP delay, sent bytes, received bytes, request count, 3xx status codes, 4xx status codes, etc.

**Note**: Due to network pre-aggregation time units being minutes, there may be slight differences between network list mode and detail page data. In case of discrepancies, follow the content on the detail page.

![](img/4.network_4.png)

### Pods Network Details

Pods network supports viewing network traffic between Pods. It supports viewing network traffic and data connection status between source IP and target IP based on IP/port in real-time through visualization, helping enterprises understand the network operation status of their business systems in real-time, quickly analyze, track, and locate issues, and prevent or avoid business problems caused by decreased network performance or interruptions.

After successful Pods network data collection, it is reported to the Guance console. In **Network > Pods**, clicking on **View Network Details** allows you to view all Pods network performance monitoring data information within the workspace.

???+ warning

    - Currently only supports Linux systems, and except for CentOS 7.6+ and Ubuntu 16.04, other distributions require a Linux kernel version higher than 4.0.0;
    - Pods network traffic data is retained for the last 48 hours by default, while Free Plan retains data for the last 24 hours;
    - In the Pods detail page, clicking into **Network**, the time widget defaults to fetching the last 15 minutes of data and does not support automatic refresh; manual refresh is required.

#### TCP, UDP Protocols

Pods network supports network performance monitoring based on TCP and UDP protocols. Combining incoming and outgoing, there are six combination options:

- incoming + no protocol distinction
- incoming + tcp protocol    
- incoming + udp protocol     
- outgoing + no protocol distinction          
- outgoing + tcp protocol      
- outgoing + udp protocol     

##### Parameter Description

| Parameter         | Description                                     | Statistical Method               |
| ------------ | ---------------------------------------- | ---------------------- |
| IP/Port      | Aggregates based on IP+port, returns up to 100 records | Grouped statistics by IP/port     |
| Sent Bytes   | Number of bytes sent from the source host to the target                   | Sum of all sent bytes |
| Received Bytes   | Number of bytes received by the source host from the target                   | Sum of all received bytes |
| TCP Delay     | TCP delay from the source host to the target                    | Average value                 |
| TCP Jitter     | TCP delay fluctuation from the source host to the target                | Average value                 |
| TCP Connections   | Number of TCP connections from the source host to the target                  | Total sum                   |
| TCP Retransmissions | Number of TCP retransmissions from the source host to the target                | Total sum                   |
| TCP Closures | Number of TCP closures from the source host to the target                | Total sum                   |

##### Network Connection Analysis

Guance supports viewing Pods network connection data, including source IP/port, destination IP/port, sent bytes, received bytes, TCP delay, TCP retransmissions, etc.

Additionally, you can customize the displayed fields via the **Settings** button or add filter conditions for keyword fields. To view more detailed network connection data, click on the data or **View Network Flow Data** to view its corresponding network flow data.

![](img/9.network_map_2.png)

#### HTTP Protocol

Pods network supports seven-layer network performance monitoring based on the HTTP protocol.

##### Parameter Description

| Parameter           | Description                                                         | Statistical Method |
| -------------- | ------------------------------------------------------------ | -------- |
| Request Count         | Total number of requests in the time range                              | Total sum     |
| Average Requests per Second | Average "total requests / total duration" in the time range               | Average value   |
| Average Response Time   | Average response time in the time range                                | Average value   |
| Error Count         | Total number of errors in the time range, i.e., status_code field values of 4xx,5xx | Total sum     |
| Error Rate         | "Error count / total requests" in the time range         | Percentage   |

##### Network Connection Analysis

Guance supports viewing Pods network request count, error count, and error rate trend charts, and network connection analysis, including source IP/port, destination IP/port, status code, request method, response time, etc.

Additionally, you can customize the displayed fields via the **Settings** button or add filter conditions for keyword fields. To view more detailed network connection data, click on the data or **View Network Flow Data** to view its corresponding network flow data.

![](img/9.network_map_2.1.png)

##### View Network Flow Data

Guance supports viewing network flow data, which auto-refreshes every 30 seconds, defaulting to the last day's data, including time, source IP/port, destination IP/port, status code, request method, response time, etc.

Additionally, you can customize the displayed fields via the **Settings** button or add filter conditions for keyword fields.

![](img/9.network_map_3.png)

## Deployments Network {#deployment}

### Deployments Topology Map

In **Infrastructure > Network**, selecting **Deployment** allows viewing the network distribution of Deployments. In the **Deployments Network Map**, you can visualize queries of network traffic between Deployments in the current workspace, quickly analyzing TCP delays, TCP jitter, TCP retransmissions, TCP connection counts, TCP closure counts, sent bytes, received bytes, requests per second, error rates, and average response times between different Deployments.

- Time Widget: Defaults to fetching the last 15 minutes of data and does not support automatic refresh; manual refresh is required.
- Search and Filtering: Quickly search for Deployment names based on fuzzy keyword matching or display Deployments and their associated relationships based on filtered tags.
- Filling: Customize the filling of host nodes, with fill values determining the size and custom intervals of the node colors. Supports seven-layer network fill metrics like TCP delay, TCP jitter, TCP retransmissions, TCP connection counts, TCP closure counts, sent bytes, received bytes, requests per second, error rates, and average response times.
- Deployments Nodes:
    - Edge colors of Deployment nodes are determined by the values of filled fields and custom intervals.
    - Deployment nodes are connected by lines representing network traffic, with bidirectional curves showing incoming/outgoing traffic from source Deployments to target Deployments.
    - Node sizes are determined by the inbound traffic volume.
    - Line thicknesses are determined by the inbound and outbound traffic volumes.
- Custom Intervals: Enable **Custom Intervals** to define color ranges for selected fill metrics. Legend colors are divided into five intervals based on maximum and minimum values, each corresponding to a different color. Lines and nodes outside the data range are grayed out.
- Mouse Hover: Hovering over Deployment nodes shows sent bytes, received bytes, TCP delay, TCP jitter, TCP retransmissions, TCP connection counts, TCP closure counts, sent bytes, received bytes, requests per second, error rates, and average response times.

![](img/4.network_5.png)

### Deployments Network List

In **Infrastructure > Network**, selecting **Deployment** allows switching to the Deployments network list to view network traffic, data connection status, and status codes between source Deployments IP/port and target IP/port, including TCP delay, sent bytes, received bytes, request count, 3xx status codes, 4xx status codes, etc.

???+ warning

    Network list mode and detail page data may have slight differences due to network pre-aggregation time units being minutes. In case of discrepancies, follow the content on the detail page.

![](img/4.network_6.png)

### Deployments Network Details

Deployments network supports viewing network traffic between Deployments. It supports viewing network traffic and data connection status between source IP and target IP based on IP/port in real-time through visualization, helping enterprises understand the network operation status of their business systems in real-time, quickly analyze, track, and locate issues, and prevent or avoid business problems caused by decreased network performance or interruptions.

After successful Deployments network data collection, it is reported to the Guance console. In **Network > Deployment**, clicking on **View Network Details** allows you to view the network performance monitoring data information of the current Deployments.

???+ warning

    - Currently only supports Linux systems, and except for CentOS 7.6+ and Ubuntu 16.04, other distributions require a Linux kernel version higher than 4.0.0;
    - Deployments network traffic data is retained for the last 48 hours by default, while Free Plan retains data for the last 24 hours;
    - In the Deployments detail page, clicking into **Network**, the time widget defaults to fetching the last 15 minutes of data and does not support automatic refresh; manual refresh is required.

#### TCP, UDP Protocols

Deployments network supports network performance monitoring based on TCP and UDP protocols. Combining incoming and outgoing, there are six combination options:

- incoming + no protocol distinction 
- incoming + tcp protocol   
- incoming + udp protocol     
- outgoing + no protocol distinction           
- outgoing + tcp protocol        
- outgoing + udp protocol     

##### Parameter Description

| Parameter         | Description                                     | Statistical Method               |
| ------------ | ---------------------------------------- | ---------------------- |
| IP/Port      | Aggregates based on IP+port, returns up to 100 records | Grouped statistics by IP/port     |
| Sent Bytes   | Number of bytes sent from the source host to the target                   | Sum of all sent bytes |
| Received Bytes   | Number of bytes received by the source host from the target                   | Sum of all received bytes |
| TCP Delay     | TCP delay from the source host to the target                    | Average value                 |
| TCP Jitter     | TCP delay fluctuation from the source host to the target                | Average value                 |
| TCP Connections   | Number of TCP connections from the source host to the target                  | Total sum                   |
| TCP Retransmissions | Number of TCP retransmissions from the source host to the target                | Total sum                   |
| TCP Closures | Number of TCP closures from the source host to the target                | Total sum                   |

##### Network Connection Analysis

Guance supports viewing Deployments network connection data, including source IP/port, destination IP/port, sent bytes, received bytes, TCP delay, TCP retransmissions, etc.

Additionally, you can customize the displayed fields via the **Settings** button or add filter conditions for keyword fields. To view more detailed network connection data, click on the data or **View Network Flow Data** to view its corresponding network flow data.

![](img/9.network_map_4.png)

#### HTTP Protocol

Pods network supports seven-layer network performance monitoring based on the HTTP protocol.

##### Parameter Description

| Parameter           | Description                                                         | Statistical Method |
| -------------- | ------------------------------------------------------------ | -------- |
| Request Count         | Total number of requests in the time range                              | Total sum     |
| Average Requests per Second | Average "total requests / total duration" in the time range               | Average value   |
| Average Response Time   | Average response time in the time range                                | Average value   |
| Error Count         | Total number of errors in the time range, i.e., status_code field values of 4xx,5xx | Total sum     |
| Error Rate         | "Error count / total requests" in the time range         | Percentage   |

##### Network Connection Analysis

Guance supports viewing Pods network request count, error count, and error rate trend charts, and network connection analysis, including source IP/port, destination IP/port, status code, request method, response time, etc.

Additionally, you can customize the displayed fields via the **Settings** button or add filter conditions for keyword fields. To view more detailed network connection data, click on the data or **View Network Flow Data** to view its corresponding network flow data.

![](img/9.network_map_4.1.png)

##### View Network Flow Data

Guance supports viewing network flow data, which auto-refreshes every 30 seconds, defaulting to the last day's data, including time, source IP/port, destination IP/port, status code, request method, response time, etc.

Additionally, you can customize the displayed fields via the **Settings** button or add filter conditions for keyword fields.

![](img/9.network_map_5.png)

## Services Network {#service}

In K8S environments, you can use the Services network topology map to view request relationships between Services in the K8S environment, judging their status by the color of the topology map. When a Services connection issue is detected, you can view the corresponding logs to pinpoint the problem.

???+ warning

    Only supports viewing Services network data in K8S environments, operating system is Linux, and version is higher than 4.0, data retention period is 48 hours.

### Services Topology Map

Guance supports displaying traffic, request, response time, and error rate information between Services through a topology diagram based on seven-layer network data. In **Infrastructure > Network**, selecting **Service** allows viewing the network distribution of Services, including requests per second, error rates, and average response times between Services.

- Time Widget: Defaults to fetching the last 15 minutes of data and does not support automatic refresh; manual refresh is required.
- Search and Filtering: Quickly search for Services names based on fuzzy keyword matching or display Services and their associated relationships based on filtered tags.
- Filling: Customize the filling of Services nodes, with fill values determining the size and custom intervals of the node colors. Supports selecting requests per second, error rates, and average response times as fill metrics.
- Services Nodes: Each node represents a Service, defaulting to filling with requests per second. Higher request counts result in larger nodes and thicker lines between Services.
- Custom Intervals: Enable **Custom Intervals** to define color ranges for selected fill metrics. Legend colors are divided into five intervals based on maximum and minimum values, each corresponding to a different color. Lines and nodes outside the data range are grayed out.
- Mouse Hover: Hovering over a Services node shows requests per second, error rates, and average response times.

![](img/4.network_7.png)

### Services Network List

In **Infrastructure > Network**, selecting **Service** allows switching to the Services network list to view network traffic, data connection status, and status codes between source Services IP/port and target IP/port, including request count, 3xx status codes, 4xx status codes, 5xx status codes, average response time, P95 response time, etc.

???+ warning

    Network list mode and detail page data may have slight differences due to network pre-aggregation time units being minutes. In case of discrepancies, follow the content on the detail page.

![](img/4.network_8.png)

### Services Network Details

In **Network > Service**, clicking on **View Network Details** allows viewing status codes, request methods, response times, etc., based on IP/port between source IP and target IP.

![](img/9.network_map_6.png)

Clicking **View Network Flow Data** allows viewing its corresponding network flow data.

![](img/9.network_map_7.png)

### Services Details

In **Network > Service**, clicking on **View Service Details** allows viewing the host, IP address, extended attributes, etc., associated with the Services.

![](img/5.service_map_12.png)

## Correlation Analysis

You can click on host/Pod/Deployment/Services icons for correlation queries, supporting the viewing of upstream/downstream, network details, host/Pod/Deployment/Services details, associated logs, traces, and events.