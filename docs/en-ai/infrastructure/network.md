# Network

---

The network module supports viewing network traffic between hosts, Pods, Deployments, and Services. Based on the server and client side, it monitors network traffic and data connections from source IP to destination IP, providing real-time visualization to help enterprises understand their business system's network operation status in real time. This allows for rapid analysis, tracking, and pinpointing of issues, preventing or avoiding business problems caused by decreased network performance or interruptions.

<<< custom_key.brand_name >>>'s network module contains three main sections: [Summary](#host), [Service Map](#map), and [Network Flow](#netflow), offering a comprehensive analysis of real-time network data.

## Prerequisites

You need to first register and log in to <<< custom_key.brand_name >>>, then install DataKit on your host [Install DataKit](../datakit/datakit-install.md) and enable the [eBPF collector](../integrations/ebpf.md).

## Concepts {#concepts}

| Parameter         | Description                                     | Statistical Method               |
| ------------ | ---------------------------------------- | ---------------------- |
| IP/Port      | Aggregated based on IP + port, returns up to 100 records | Grouped statistics by IP/port     |
| Sent Bytes   | Number of bytes sent from the source host to the target | Sum of all sent bytes across records |
| Received Bytes   | Number of bytes received by the source host from the target | Sum of all received bytes across records |
| TCP Delay     | TCP delay from the source host to the target                    | Average value                 |
| TCP Jitter     | TCP delay fluctuation from the source host to the target                | Average value                 |
| TCP Connections   | Number of TCP connections from the source host to the target                  | Total sum                   |
| TCP Retransmissions | Number of TCP retransmissions from the source host to the target                | Total sum                   |
| TCP Closures | Number of TCP closures from the source host to the target                | Total sum                   |

## Summary {#host}

Navigate to **Infrastructure > Network**, which defaults to the **Host** **Summary** page:

![](img/net.png)

You can click on the host to switch views to Pod, Deployment, Service components:

<img src="../img/net-1.png" width="60%" >

### Network Path

Taking the host network as an example, you can view network traffic and data connections between server and client endpoints, including client, server, TCP retransmission count, TCP connection count, TCP closure count, TCP delay, sent bytes, received bytes, etc.

Click on settings to customize displayed columns:

![](img/net-2.png)

**Note**: Custom display field changes are user-level and not globally saved.

### Analysis Charts

On the current host network summary page, you can view trend charts for different [parameters](#concepts) over various time periods.

![](img/net-3.png)

### Quick Filters

On the summary page’s left side, quick filters primarily include transmission direction, transmission protocol, host, PID, and fields related to clients and servers:

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

In summary mode, the time widget allows you to control the data display range of the current list as needed. You can quickly select built-in time ranges or set a custom time range.

![](img/net-5.png)

> For more details, refer to [How to Use the Time Widget](../getting-started/function-details/explorer-search.md#time).

### List Details

Taking the host network as an example, after successful data collection, network performance monitoring data is reported to the <<< custom_key.brand_name >>> console. Clicking on a network data entry in the list opens the details page where you can view all network performance monitoring data within the workspace, including top-level client and server transmission directions, analysis charts, and network connection analysis.

![](img/net-6.png)

To avoid query failures due to excessive return query counts, you can choose to **statistically aggregate by IP dimension** the current data.

![](img/net-8.png)

???+ warning

    - Currently only supports Linux systems, and except for CentOS 7.6+ and Ubuntu 16.04, other distributions require a Linux kernel version higher than 4.0.0;

    - Host network traffic data is retained for the last 48 hours by default, while the Free Plan retains data for the last 24 hours;

    - In the host details page, clicking into **Network**, the [time widget](../getting-started/function-details/explorer-search.md#time) defaults to fetching data from the past 15 minutes and does not support auto-refresh; manual refresh is required to fetch new data.

> The details page also includes operations such as time widget, search, bind built-in views, export, etc., refer to [Using the Details Page Effectively](../getting-started/function-details/explorer-search.md).

#### Pod, Deployment, Service Data Details

In the details page, you can view the corresponding object names and switch between L4 and L7 networks for data viewing.

#### Network Connection Analysis {#connect}

In the details page > Network Connection Analysis, you can further examine network connection data, including client, server, transmission direction, sent bytes, received bytes, TCP delay, TCP retransmission count, etc.

Additionally, you can customize displayed fields via the **Settings** button or add filter conditions for keyword fields of string type. If you need to view more detailed network connection data, clicking on the data will display its corresponding network flow data.

## Topology {#map}

Click into **Infrastructure > Network > Topology** to view the upstream and downstream distribution of the network.

Taking the host as an example, it supports visual queries of network traffic between hosts within the current workspace, allowing for rapid analysis of TCP delays, TCP jitter, TCP retransmission counts, TCP connection attempts, and TCP closures between different hosts.

![](img/4.network_1.png)

- Time Widget: Defaults to fetching data from the last 48 hours and does not support auto-refresh; manual refresh is required to fetch new data.

- Search and Filtering: You can quickly search for host names based on fuzzy keyword matching or display host nodes and their associated relationships based on selected tags.

- Filling: You can use **Filling** to customize fill values for host nodes. The size and custom range of fill values determine the color of the filled host nodes. Supports multiple fill metrics such as TCP delay, TCP jitter, TCP retransmission count, TCP connection attempts, and TCP closures.

- Host Nodes:

    - Host node icons are divided into regular hosts and cloud hosts, with cloud hosts displaying the logo of the cloud service provider.

    - Host node edge colors show corresponding segment colors based on the numeric values of the filled fields and custom ranges.

    - Host nodes are connected by lines indicating network traffic. The lines are bidirectional curves showing incoming/outgoing traffic from the source host to the target host.

    - Host node sizes are determined by the inbound traffic volume of the current node.

    - Host node line thicknesses are determined by the size of the inbound and outbound traffic data.

- Custom Range: You can enable **Custom Range** to define a custom legend color range for the selected fill metric. The legend colors are divided into five intervals based on the maximum and minimum values, each automatically corresponding to five different colors. Lines and nodes outside the data range are grayed out.

- Mouse Hover: Hovering over a host node displays sent bytes, received bytes, TCP delay, TCP jitter, TCP retransmission count, TCP connection attempts, and TCP closures.

**Note**: If the target host is not in the current workspace but the target domain exists and the target domain port is less than 10000, the target domain will be displayed in the topology map.

### Associated Analysis

Click on the icon of the host/Pod/Deployment/Services, then click **View Upstream/Downstream** to view the upstream/downstream nodes associated with the current node. You can also view details, related logs, related traces, and related events for the host/Pod/Deployment/Services, and navigate accordingly.

![](img/4.network_9.png)

Click the **Return to Summary** in the upper-left corner to return to the original network map. Searching or filtering in the search box filters associated upstream/downstream nodes, displaying matching nodes based on the search or filter results.

![](img/4.network_10.png)

## Network Flow Data {#netflow}

As mentioned earlier, you can [view network flow data in the list details page](#connect). Additionally, in the **Summary** or **Topology** pages, click **View Network Flow Data** in the upper-right corner to navigate to the corresponding page. You can view L4 (netflow) and L7 (httpflow) network flow data on the timeline. All network flow data automatically refreshes every 30 seconds, defaulting to the most recent 15 minutes of data.

Switch between **L4 Network Flow** and **L7 Network Flow** at the top to view data under different schedules.

![](img/net-7.png)

> On this page, it also includes operations such as time widget, search, save snapshot, display columns, etc. Refer to [Powerful Features of Explorer](../getting-started/function-details/explorer-search.md).

<!-- 
### Host Network List

In **Infrastructure > Network**, selecting **Host** allows you to switch to the host network list to view network traffic and data connections between source host IP/port and target IP/port, including TCP retransmission count, TCP connection count, TCP closure count, TCP delay, sent bytes, received bytes, etc.

**Note**: Due to network pre-aggregation time units being in minutes, there may be slight differences between data in the network list mode and the details page. In case of discrepancies, follow the content in the details page.

![](img/4.network_2.png)


## Pods Network {#pod}

### Pods Topology Diagram

In **Infrastructure > Network**, selecting **Pods** allows you to view the Pods network distribution. In the **Pods Network Map**, you can visually query network traffic between Pods within the current workspace, quickly analyzing TCP delays, TCP jitter, TCP retransmission counts, TCP connection attempts, TCP closures, sent bytes, received bytes, requests per second, error rates, and average response times between different Pods.

- Time Widget: Defaults to fetching data from the past 15 minutes and does not support auto-refresh; manual refresh is required to fetch new data.

- Search and Filtering: You can quickly search for Pods names based on fuzzy keyword matching or display Pods and their associated relationships based on selected tags.

- Filling: You can use **Filling** to customize fill values for host nodes. The size and custom range of fill values determine the color of the filled host nodes. Supports multiple fill metrics such as TCP delay, TCP jitter, TCP retransmission count, TCP connection attempts, TCP closures, sent bytes, received bytes, requests per second, error rate, and average response time for L7 network fill metrics.

- Pods Nodes:

    - Pods node edge colors show corresponding segment colors based on the numeric values of the filled fields and custom ranges.

    - Pods nodes are connected by lines indicating network traffic. The lines are bidirectional curves showing incoming/outgoing traffic from the source Pods to the target Pods.

    - Pods node sizes are determined by the inbound traffic volume of the current node.

    - Pods node line thicknesses are determined by the size of the inbound and outbound traffic data.

- Custom Range: You can enable **Custom Range** to define a custom legend color range for the selected fill metric. The legend colors are divided into five intervals based on the maximum and minimum values, each automatically corresponding to five different colors. Lines and nodes outside the data range are grayed out.

- Mouse Hover: Hovering over a Pods node displays sent bytes, received bytes, TCP delay, TCP jitter, TCP retransmission count, TCP connection attempts, TCP closures, sent bytes, received bytes, requests per second, error rate, and average response time.

![](img/4.network_3.png)

### Pods Network List

In **Infrastructure > Network**, selecting **Pods** allows you to switch to the Pods network list to view network traffic, data connections, and status codes between source Pods IP/port and target IP/port, including TCP delay, sent bytes, received bytes, request count, 3xx status codes, 4xx status codes, etc.

**Note**: Due to network pre-aggregation time units being in minutes, there may be slight differences between data in the network list mode and the details page. In case of discrepancies, follow the content in the details page.

![](img/4.network_4.png)

### Pods Network Details

Pods network supports viewing network traffic between Pods. It supports viewing network traffic and data connections between source IP and target IP based on IP/port, providing real-time visualization to help enterprises understand their business system's network operation status in real time. This allows for rapid analysis, tracking, and pinpointing of issues, preventing or avoiding business problems caused by decreased network performance or interruptions.

After successful data collection, Pods network data is reported to the <<< custom_key.brand_name >>> console. In **Network > Pods**, clicking on View Network Details allows you to view all Pods network performance monitoring data within the workspace.

???+ warning

    - Currently only supports Linux systems, and except for CentOS 7.6+ and Ubuntu 16.04, other distributions require a Linux kernel version higher than 4.0.0;
    - Pods network traffic data is retained for the last 48 hours by default, while the Free Plan retains data for the last 24 hours;
    - In the Pods details page, clicking into **Network**, the time widget defaults to fetching data from the past 15 minutes and does not support auto-refresh; manual refresh is required to fetch new data.

#### TCP, UDP Protocols

Pods network supports network performance monitoring based on TCP and UDP protocols. Combined with incoming and outgoing, there are six combination options:

- incoming + no protocol distinction
- incoming + tcp protocol
- incoming + udp protocol
- outgoing + no protocol distinction
- outgoing + tcp protocol
- outgoing + udp protocol

##### Parameter Description

| Parameter         | Description                                     | Statistical Method               |
| ------------ | ---------------------------------------- | ---------------------- |
| IP/Port      | Aggregated based on IP + port, returns up to 100 records | Grouped statistics by IP/port     |
| Sent Bytes   | Number of bytes sent from the source host to the target | Sum of all sent bytes across records |
| Received Bytes   | Number of bytes received by the source host from the target | Sum of all received bytes across records |
| TCP Delay     | TCP delay from the source host to the target                    | Average value                 |
| TCP Jitter     | TCP delay fluctuation from the source host to the target                | Average value                 |
| TCP Connections   | Number of TCP connections from the source host to the target                  | Total sum                   |
| TCP Retransmissions | Number of TCP retransmissions from the source host to the target                | Total sum                   |
| TCP Closures | Number of TCP closures from the source host to the target                | Total sum                   |

##### Network Connection Analysis

<<< custom_key.brand_name >>> supports viewing Pods network connection data, including source IP/port, destination IP/port, sent bytes, received bytes, TCP delay, TCP retransmission count, etc.

Additionally, you can customize displayed fields via the **Settings** button or add filter conditions for keyword fields of string type. If you need to view more detailed network connection data, clicking on the data or **View Network Flow Data** will display its corresponding network flow data.

![](img/9.network_map_2.png)

#### HTTP Protocol

Pods network supports L7 network performance monitoring based on the HTTP protocol.

##### Parameter Description

| Parameter           | Description                                                         | Statistical Method |
| -------------- | ------------------------------------------------------------ | -------- |
| Request Count         | Total number of requests within the time range for the current Pods                              | Total sum     |
| Average Requests per Second | Average "total number of Pods requests / total duration" within the time range               | Average value   |
| Average Response Time   | Average response time of the current Pods within the time range                                | Average value   |
| Error Count         | Total number of request errors within the time range for the current Pods, i.e., sum of status_code field values 4xx,5xx | Total sum     |
| Error Rate         | "Total number of request errors / total number of requests" within the time range         | Percentage   |

##### Network Connection Analysis

<<< custom_key.brand_name >>> supports viewing Pods network request counts, error counts, and error rate visual chart trends. It also supports viewing Pods network connection analysis, including source IP/port, destination IP/port, status code, request method, response time, etc.

Additionally, you can customize displayed fields via the **Settings** button or add filter conditions for keyword fields of string type. If you need to view more detailed network connection data, clicking on the data or **View Network Flow Data** will display its corresponding network flow data.

![](img/9.network_map_2.1.png)

##### View Network Flow Data

<<< custom_key.brand_name >>> supports viewing network flow data, refreshing automatically every 30 seconds, and defaulting to displaying the most recent day's data, including time, source IP/port, destination IP/port, status code, request method, response time, etc.

Additionally, you can customize displayed fields via the **Settings** button or add filter conditions for keyword fields of string type.

![](img/9.network_map_3.png)

## Deployments Network {#deployment}

### Deployments Topology Diagram

In **Infrastructure > Network**, selecting **Deployment** allows you to view the Deployments network distribution. In the **Deployments Network Map**, you can visually query network traffic between Deployments within the current workspace, quickly analyzing TCP delays, TCP jitter, TCP retransmission counts, TCP connection attempts, TCP closures, sent bytes, received bytes, requests per second, error rates, and average response times between different Deployments.

- Time Widget: Defaults to fetching data from the past 15 minutes and does not support auto-refresh; manual refresh is required to fetch new data.
- Search and Filtering: You can quickly search for Deployments names based on fuzzy keyword matching or display Deployments and their associated relationships based on selected tags.
- Filling: You can use **Filling** to customize fill values for host nodes. The size and custom range of fill values determine the color of the filled host nodes. Supports multiple fill metrics such as TCP delay, TCP jitter, TCP retransmission count, TCP connection attempts, TCP closures, sent bytes, received bytes, requests per second, error rate, and average response time for L7 network fill metrics.
- Deployments Nodes:
    - Deployments node edge colors show corresponding segment colors based on the numeric values of the filled fields and custom ranges.
    - Deployments nodes are connected by lines indicating network traffic. The lines are bidirectional curves showing incoming/outgoing traffic from the source Deployments to the target Deployments.
    - Deployments node sizes are determined by the inbound traffic volume of the current node.
    - Deployments node line thicknesses are determined by the size of the inbound and outbound traffic data.
- Custom Range: You can enable **Custom Range** to define a custom legend color range for the selected fill metric. The legend colors are divided into five intervals based on the maximum and minimum values, each automatically corresponding to five different colors. Lines and nodes outside the data range are grayed out.
- Mouse Hover: Hovering over a Deployments node displays sent bytes, received bytes, TCP delay, TCP jitter, TCP retransmission count, TCP connection attempts, TCP closures, sent bytes, received bytes, requests per second, error rate, and average response time.

![](img/4.network_5.png)

### Deployments Network List

In **Infrastructure > Network**, selecting **Deployment** allows you to switch to the Deployments network list to view network traffic, data connections, and status codes between source Deployments IP/port and target IP/port, including TCP delay, sent bytes, received bytes, request count, 3xx status codes, 4xx status codes, etc.

???+ warning

    Due to network pre-aggregation time units being in minutes, there may be slight differences between data in the network list mode and the details page. In case of discrepancies, follow the content in the details page.

![](img/4.network_6.png)

### Deployments Network Details

Deployments network supports viewing network traffic between Deployments. It supports viewing network traffic and data connections between source IP and target IP based on IP/port, providing real-time visualization to help enterprises understand their business system's network operation status in real time. This allows for rapid analysis, tracking, and pinpointing of issues, preventing or avoiding business problems caused by decreased network performance or interruptions.

After successful data collection, Deployments network data is reported to the <<< custom_key.brand_name >>> console. In **Network > Deployment**, clicking on View Network Details allows you to view the network performance monitoring data information of the current Deployments.

???+ warning

    - Currently only supports Linux systems, and except for CentOS 7.6+ and Ubuntu 16.04, other distributions require a Linux kernel version higher than 4.0.0;
    - Deployments network traffic data is retained for the last 48 hours by default, while the Free Plan retains data for the last 24 hours;
    - In the Deployments details page, clicking into **Network**, the time widget defaults to fetching data from the past 15 minutes and does not support auto-refresh; manual refresh is required to fetch new data.

#### TCP, UDP Protocols

Deployments network supports network performance monitoring based on TCP and UDP protocols. Combined with incoming and outgoing, there are six combination options:

- incoming + no protocol distinction
- incoming + tcp protocol
- incoming + udp protocol
- outgoing + no protocol distinction
- outgoing + tcp protocol
- outgoing + udp protocol

##### Parameter Description

| Parameter         | Description                                     | Statistical Method               |
| ------------ | ---------------------------------------- | ---------------------- |
| IP/Port      | Aggregated based on IP + port, returns up to 100 records | Grouped statistics by IP/port     |
| Sent Bytes   | Number of bytes sent from the source host to the target | Sum of all sent bytes across records |
| Received Bytes   | Number of bytes received by the source host from the target | Sum of all received bytes across records |
| TCP Delay     | TCP delay from the source host to the target                    | Average value                 |
| TCP Jitter     | TCP delay fluctuation from the source host to the target                | Average value                 |
| TCP Connections   | Number of TCP connections from the source host to the target                  | Total sum                   |
| TCP Retransmissions | Number of TCP retransmissions from the source host to the target                | Total sum                   |
| TCP Closures | Number of TCP closures from the source host to the target                | Total sum                   |

##### Network Connection Analysis

<<< custom_key.brand_name >>> supports viewing Deployments network connection data, including source IP/port, destination IP/port, sent bytes, received bytes, TCP delay, TCP retransmission count, etc.

Additionally, you can customize displayed fields via the **Settings** button or add filter conditions for keyword fields of string type. If you need to view more detailed network connection data, clicking on the data or **View Network Flow Data** will display its corresponding network flow data.

![](img/9.network_map_4.png)

#### HTTP Protocol

Pods network supports L7 network performance monitoring based on the HTTP protocol.

##### Parameter Description

| Parameter           | Description                                                         | Statistical Method |
| -------------- | ------------------------------------------------------------ | -------- |
| Request Count         | Total number of requests within the time range for the current Pods                              | Total sum     |
| Average Requests per Second | Average "total number of Pods requests / total duration" within the time range               | Average value   |
| Average Response Time   | Average response time of the current Pods within the time range                                | Average value   |
| Error Count         | Total number of request errors within the time range for the current Pods, i.e., sum of status_code field values 4xx,5xx | Total sum     |
| Error Rate         | "Total number of request errors / total number of requests" within the time range         | Percentage   |

##### Network Connection Analysis

<<< custom_key.brand_name >>> supports viewing Pods network request counts, error counts, and error rate visual chart trends. It also supports viewing Pods network connection analysis, including source IP/port, destination IP/port, status code, request method, response time, etc.

Additionally, you can customize displayed fields via the **Settings** button or add filter conditions for keyword fields of string type. If you need to view more detailed network connection data, clicking on the data or **View Network Flow Data** will display its corresponding network flow data.

![](img/9.network_map_4.1.png)

##### View Network Flow Data

<<< custom_key.brand_name >>> supports viewing network flow data, refreshing automatically every 30 seconds, and defaulting to displaying the most recent day's data, including time, source IP/port, destination IP/port, status code, request method, response time, etc.

Additionally, you can customize displayed fields via the **Settings** button or add filter conditions for keyword fields of string type.

![](img/9.network_map_5.png)

## Services Network {#service}

In K8S environments, you can use the Services network topology diagram to view request relationships between various Services in the K8S environment, judging their status based on the color of the topology diagram. When a Services connection issue is detected, you can view the corresponding logs to identify the problem.

???+ warning

    Only supports viewing Services network data in K8S environments with Linux operating systems and versions higher than 4.0. Data retention period is 48 hours.

### Services Topology Diagram

<<< custom_key.brand_name >>> supports displaying traffic, requests, response times, error rates, etc., between various Services through a topology diagram based on L7 network data. In **Infrastructure > Network**, selecting **Service** allows you to view the Services network distribution, including requests per second, error rates, average response times between Services.

- Time Widget: Defaults to fetching data from the past 15 minutes and does not support auto-refresh; manual refresh is required to fetch new data.
- Search and Filtering: You can quickly search for Services names based on fuzzy keyword matching or display Services and their associated relationships based on selected tags.
- Filling: You can use **Filling** to customize fill values for Services nodes. The size and custom range of fill values determine the color of the filled Services nodes. Supports selecting requests per second, error rate, and average response time as fill metrics.
- Services Nodes: Each node represents a Services, defaulting to filling with requests per second. Higher request counts result in larger nodes and thicker lines between Services.
- Custom Range: You can enable **Custom Range** to define a custom legend color range for the selected fill metric. The legend colors are divided into five intervals based on the maximum and minimum values, each automatically corresponding to five different colors. Lines and nodes outside the data range are grayed out.
- Mouse Hover: Hovering over a Services network node displays requests per second, error rate, and average response time.

![](img/4.network_7.png)

### Services Network List

In **Infrastructure > Network**, selecting **Service** allows you to switch to the Services network list to view network traffic, data connections, and status codes between source Services IP/port and target IP/port, including request count, 3xx status codes, 4xx status codes, 5xx status codes, average response time, P95 response time, etc.

???+ warning

    Due to network pre-aggregation time units being in minutes, there may be slight differences between data in the network list mode and the details page. In case of discrepancies, follow the content in the details page.

![](img/4.network_8.png)

### Services Network Details

In **Network > Service**, clicking on View Services Network Details allows you to view status codes, request methods, response times, etc., based on IP/port between source IP and target IP.

![](img/9.network_map_6.png)

Clicking **View Network Flow Data** displays the corresponding network flow data.

![](img/9.network_map_7.png)

### Services Details

In **Network > Service**, clicking on View Services Details allows you to view information such as the host, IP address, extended attributes, etc., associated with the Services.

![](img/5.service_map_12.png)

## Associated Analysis

You can click on the icons of hosts/Pods/Deployments/Services to perform associated queries, supporting views of upstream/downstream, network details, host/Pod/Deployment/Services details, associated logs, associated traces, and associated events.