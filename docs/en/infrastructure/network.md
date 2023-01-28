# Network
---

## Introduction

Network supports to check network traffic between the host/container Pod. It also supports to view the network traffic and data connection between source IP and target IP based on IP/port, and displays it in real time in a visual way, so as to help enterprises know the network running status of business systems in real time, quickly analyze, track and locate problems and faults and prevent or avoid business problems caused by network performance degradation or interruption.

## Preconditions

You need to create a [Guance account]](https://auth.guance.com/register?channel=帮助文档), and on your host [install DataKit](../datakit/datakit-install.md), open [eBPF collector](../integrations/host/ebpf.md).

## Host Network

### Host Topological Graph

In "Infrastructure"-"Network", select "Host" to view the host network distribution. In "Host Network Map", you can visually query the network traffic between hosts in the current workspace, and quickly analyze TCP latency, TCP fluctuation, TCP retransmission times, TCP connection times and TCP shutdown times between different hosts.

- Time control: the data of the last 48 hours is obtained by default and automatic refresh is not supported. You need to manually click Refresh to obtain new data;
- Searching and Filtering: You can quickly search for host names based on keyword fuzzy matching; Or you can filter Tag tags by displaying host nodes and their associations.
- Fill: You can customize to fill host nodes through "Fill". The size of the fill value and the custom interval will determine the color of the filled host nodes. The function supports the selection of TCP delay, TCP fluctuation, TCP retransmission times, TCP connection times and TCP shutdown times.
- Host node:
   - The icon of the host node is divided into ordinary host and cloud host, and the cloud host is displayed as the Logo of the cloud service supplier;
   - The edge color of the host node displays the color of the corresponding section according to the filled field value and the custom interval;
   - The network traffic is represented by connecting lines between host nodes, and the connecting lines are bidirectional curves, showing the traffic in the incoming/outgoing direction from the source host to the target host;
   - The display of the host node size determines the size of the node according to the incoming flow size of the current node;
   - The display of the thickness of the host node determines the thickness of the connection line according to the data size of the incoming and outgoing flow of the obtained node.
- Custom Interval: You can open "Custom Interval" to customize the legend color range for the selected fill metric. The color of the legend will be divided into five intervals according to the maximum and minimum values of the legend, and each interval will automatically correspond to five different colors. The lines and nodes that are not within the data interval will be grayed out.	
- Mouse Hover: Hover the mouse to the host object node to view the number of bytes sent, the number of bytes received, TCP delay, TCP fluctuation, TCP retransmission times, TCP connection times and TCP shutdown times.

Note: If the target host is not in the current workspace but the target domain name exists and the port of the target domain name is less than 10000, the target domain name will be displayed in the topology graph.

![](img/5.network_2.png)

### Host Network Details

Host network supports viewing network traffic between hosts. It supports to view the network traffic and data connection between the source host and the target based on IP/port, and displays it in real time in a visual way. This helps enterprises know the network running status of the business system in real time, quickly analyze, track and locate problems and faults and prevent or avoid business problems caused by network performance degradation or interruption.

The host will report to the observation cloud console after successfully collected network data. In Infrastructure-Network-Host, click View Network Details, and you can view all network performance monitoring data information in the workspace.

Note:

- Currently only Linux systems are supported, and other distributions except CentOS 7.6 + and Ubuntu 16.04 require a Linux kernel version higher than 4.0. 0.
- The host network traffic data is saved for the last 48 hours by default, and the free version is saved for the last 24 hours by default;
- Click on the host details page to enter "Network". The time control obtains the data of the last 15 minutes by default and does not support automatic refresh. You need to manually click Refresh to obtain new data;
- At present, it supports network performance monitoring based on TCP and UDP protocols. With incoming and outgoing, it is divided into 6 combination choices:
  - incoming + Indistinguishing protocols
  - incoming + tcp protocols
  - incoming + udp protocols
  - outgoing + indistinguishing protocols
  - outgoing + tcp protocols
  - outgoing + udp protocols

#### Parameter Description

| Parameter         | Description                                     | Statistical Method               |
| ------------ | ---------------------------------------- | ---------------------- |
| IP/端口      | 目标基于IP+端口做聚合，最多返回100条数据 | 按 IP/端口分组统计     |
| 发送字节数   | 源主机发送给目标字节数                   | 所有记录发送字节数求和 |
| 接受字节数   | 源主机接收目标的字节数                   | 所有记录接收字节数求和 |
| TCP 延时     | 源主机到目标的TCP延时                    | 平均值                 |
| TCP 波动     | 源主机到目标的TCP延时波动                | 平均值                 |
| TCP 连接数   | 源主机到目标的TCP连接数                  | 总和                   |
| TCP 重传次数 | 源主机到目标的TCP重传次数                | 总和                   |
| TCP 关闭次数 | 源主机到目标的TCP关闭次数                | 总和                   |

#### 网络连接分析

“观测云”支持查看网络连接数据，包括源IP/端口、目标IP/端口、发送字节数、接收字节数、TCP延时、TCP重传次数等。同时，您还可以通过"设置"按钮自定义显示字段，或针对连接数据添加筛选条件，筛选所有字符串类型的keyword字段。如若您需要查看更详细网络连接数据，点击该数据即可查看其对应的网络流数据。

**注意**：自定义显示字段变更需要基于用户层级，非全局保存

#### 网络流数据

“观测云”支持查看网络流数据，每30s自动刷新一次，默认展示最近2天数据，包括时间、源IP/端口、目标IP/端口、源主机、传输方向、协议等。同时，您还可以通过"设置"按钮自定义显示字段，或针对网络流数据添加筛选条件，筛选所有字符串类型的keyword字段。如若您需要查看关联的网络流数据，点击该数据即可查看对应主机、传输方向、协议等相关字段对应的其他网络流数据。

![](img/image_2.png)

#### 网络 48 小时回放

在链路网络，支持点击时间控件选择查看 48 小时网络数据回放。

- 时间范围：默认查看该链路前后 30 分钟的数据，若是当前发生的链路，默认查看最近 1 小时的数据；
- 支持任意拖动时间范围查看对应的网络流量；
- 拖动后，查询的是历史网络数据；
- 拖动后，点击「播放」按钮或刷新页面，回到查看「最近 1 小时」的网络数据。

![](img/4.network_reply_1.png)



## Pod 网络

### Pod 拓扑图

在「基础设施」-「网络」，选择「Pod」即可查看 Pod 网络分布情况。在「Pod 网络 Map」，您能够可视化查询当前工作空间 Pod 与 Pod 之间的网络流量，快速分析不同 Pod 之间的 TCP延迟、TCP波动、TCP重传次数、TCP建连次数、TCP关闭次数、发送字节数、接收字节数、每秒请求数、错误率以及平均响应时间。

- 时间控件：默认获取最近 15 分钟的数据且不支持自动刷新，需手动点击刷新获取新的数据；
- 搜索和筛选：你可以快速基于关键词模糊匹配搜索 Pod 名称；或基于筛选标签显示 Pod 及其关联关系。
- 填充：你可以通过「填充」自定义填充主机节点，填充值的大小及自定义区间将决定填充的主机节点颜色。支持选择 TCP延迟、TCP波动、TCP重传次数、TCP建连次数、TCP关闭次数、发送字节数、接收字节数、每秒请求数、错误率以及平均响应时间等七层网络填充指标。
- Pod 节点：
   - Pod 节点边缘颜色根据填充的字段数值及自定义区间显示对应区段的颜色；
   - Pod 节点之间通过连线表示网络流量，连线为双向曲线，显示源 Pod 到目标 Pod 的incoming / outgoing方向的流量；
   - Pod 节点大小的显示根据当前节点的入向流量大小，确定节点的尺寸大小；
   - Pod 节点粗细的显示根据获取节点的出入向流量数据大小，确定连线的粗细。
- 自定义区间：你可以开启「自定义区间」为选择的填充指标自定义图例颜色区间范围。图例的颜色将依据图例的最大值和最小值等分为 5 个区间，每个区间将自动对应五个不同的颜色，不在数据区间范围内的连线和节点置灰显示。	
- 鼠标悬停：悬停鼠标至 Pod 节点，可查看发送字节数、接收字节数、TCP延迟、TCP波动、TCP重传次数、TCP建连次数、TCP关闭次数、发送字节数、接收字节数、每秒请求数、错误率以及平均响应时间。

![](img/5.network_2.png)

### Pod 网络详情

Pod 网络支持查看 Pod 之间的网络流量。支持基于 IP/端口查看源 IP 到目标 IP 之间的网络流量和数据连接情况，通过可视化的方式进行实时展示，帮助企业实时了解业务系统的网络运行状态，快速分析、追踪和定位问题故障，预防或避免因网络性能下降或中断而导致的业务问题。

Pod 网络数据采集成功后会上报到观测云控制台，在「网络」-「Pod」，点击查看网路详情，您可以查看到工作空间内全部 Pod 网络性能监测数据信息。

注意：

- 目前仅支持 Linux 系统，且除 CentOS 7.6+ 和 Ubuntu 16.04 以外，其他发行版本需要 Linux 内核版本高于 4.0.0。
- Pod 网络流量数据默认保存最近48小时，免费版默认保存最近24小时；
- 在 Pod 详情页点击进入「网络」，时间控件默认获取最近 15 分钟的数据且不支持自动刷新，需手动点击刷新获取新的数据；

#### TCP、UDP 协议

Pod 网络支持基于 TCP、UDP 协议的网络性能监测。配合 incoming 和 outgoing ，分成 6 种组合选择：

   - incoming + 不区分协议
   - incoming + tcp 协议
   - incoming + udp 协议
   - outgoing + 不区分协议
   - outgoing + tcp 协议
   - outgoing + udp 协议

##### Parameter Description

| Parameter         | Description                                     | Statistical Method               |
| ------------ | ---------------------------------------- | ---------------------- |
| IP/Port      | The target is aggregated based on IP + port and returns up to 100 pieces of data. | Statistics by IP/Port Packet     |
| Number of bytes sent   | Number of bytes sent by source host to destination                   | Sum the number of bytes sent by all records |
| Number of bytes accepted   | Number of bytes of destination received by source host                   | Sum of bytes received by all records |
| TCP delay     | TCP latency from source host to destination                    | Average value                 |
| TCP fluctuation     | TCP delay fluctuation from source host to destination                | Average value                 |
| TCP number of connections   | Number of TCP connections from source host to destination                  | Summation                   |
| TCP number of retransmissions | Number of TCP retransmissions from source host to destination                | Summation                   |
| TCP number of closures | Number of TCP shutdowns from source host to destination                | Summation                   |

##### Network Connection Analysis

 Guance supports viewing Pod network connection data, including source IP/port, target IP/port, number of bytes sent, number of bytes received, TCP delay, TCP retransmission times and so on. At the same time, you can customize the display fields through the "Settings" button, or add filters for connection data to filter keywords of all string types. If you need to view more detailed network connection data, click this data or "View Network Flow Data" to view its corresponding network flow data.

![](img/5.network_3.png)

#### HTTP Protocol

Pod network supports seven layers of network performance monitoring based on HTTP protocol.

##### Parameter Description

| Parameter           | Description                                                         | Statistical Method |
| -------------- | ------------------------------------------------------------ | -------- |
| Number of Requests         | Total number of requests for the current Pod in the time range                              | Summation     |
| Average requests per second | Current "total Pod requests/total time spent on requests" within the time range               | Average   |
| Average response time   | Time range, current Pod response time                                | Average   |
| Number of errors         | The number of request errors for the current Pod in the time range, that is, the sum of status_code field values of 4xx and 5xx. | Summation     |
| Error rate         | The value of "Number of Request Errors/Total Requests" of the current Pod in the time range         | Percentage   |

##### Network Connection Analysis

 Guance supports viewing the visual chart trend of Pod network request number, error number and error rate, and it also supports viewing Pod network connection analysis, including source IP/port, target IP/port, status code, request mode and response time. At the same time, you can customize the display fields through the "Settings" button, or add filters for connection data to filter keywords of all string types. If you need to view more detailed network connection data, click this data or "View Network Flow Data" to view its corresponding network flow data.

![](img/5.network_4.png)

##### View Network Flow Data

Guance supports viewing network flow data, which is automatically refreshed every 30s. The data of the last day is displayed by default, including time, source IP/port, target IP/port, status code, request mode and response time. At the same time, you can customize the display fields through the Settings button, or add filters for network stream data to filter keywords of all string types.

![](img/5.network_5.png)

## Deployment Network

### Deployment Topology Graph

In "Infrastructure"-"Network", select "Deployment" to view the Deployment network distribution. In the Deployment Network Map, you can visually query the network traffic between Deployments in the current workspace, and quickly analyze TCP latency, TCP fluctuation, TCP retransmission times, TCP connection times, TCP shutdown times, number of bytes sent, number of bytes received, number of requests per second, error rate and average response time between different Deployments.

- Time control: the data of the last 15 minutes is obtained by default and automatic refresh is not supported. You need to manually click Refresh to obtain new data;
- Searching and filtering: you can quickly search for Deployment names based on keyword fuzzy matching; Or display Deployment and its relationships based on filter labels.
- Fill: You can customize to fill host nodes through "Fill". The size of the fill value and the custom interval will determine the color of the filled host nodes. The function supports the selection of TCP delay, TCP fluctuation, TCP retransmission times, TCP connection times, TCP shutdown times, number of bytes sent, number of bytes received, number of requests per second, error rate and average response time.
- Deployment node:
   - Deployment node edge color displays the color of the corresponding section according to the filled field value and the custom interval;
   - The network traffic is represented by connecting lines between Deployment nodes, and the connecting lines are bidirectional curves, showing the traffic in the incoming/outgoing direction from the source Deployment to the target Deployment;
   - Display of Deployment node size determines the size of the node according to the incoming flow size of the current node;
   - Display of the thickness of the Deployment node determines the thickness of the connection according to the size of the incoming and outgoing flow data of the obtained node.
- Custom Interval: You can open "Custom Interval" to customize the legend color range for the selected fill metric. The color of the legend will be divided into five intervals according to the maximum and minimum values of the legend, and each interval will automatically correspond to five different colors. The lines and nodes that are not within the data interval will be grayed out.	
- Mouse hovering: Hovering the mouse to the Deployment node can view the number of bytes sent, received, TCP delay, TCP fluctuation, TCP retransmission times, TCP connection times, TCP shutdown times, sent bytes, received bytes, requests per second, error rate and average response time.

![](img/5.network_6.png)

### Deployment Network Details

Deployment Network supports viewing network traffic between Deployments. Support to view the network traffic and data connection between source IP and target IP based on IP/port, and display it in real time in a visual way, so as to help enterprises know the network running status of business systems in real time, quickly analyze, track and locate problems and faults, and prevent or avoid business problems caused by network performance degradation or interruption.

Deployment network data will report to the Guance console after being successfully collected. You can click View Network Details in "Network"-"Deployment" to view the network performance monitoring data information of the current Deployment.

Note:

- Currently only Linux systems are supported, and other distributions except CentOS 7.6 + and Ubuntu 16.04 require a Linux kernel version higher than 4.0. 0;
- Deployment network traffic data is saved for the last 48 hours by default, and the free version is saved for the last 24 hours by default;
- Click on the Deployment Details page to enter "Network". The time control obtains the data of the last 15 minutes by default and does not support automatic refresh. You need to manually click Refresh to obtain new data;

#### TCP and UDP Protocol

Deployment Network supports network performance monitoring based on TCP and UDP protocols. With incoming and outgoing, it is divided into 6 combination choices:

   - incoming + Indistinguishing protocols
   - incoming + tcp protocols
   - incoming + udp protocols
   - outgoing + Indistinguishing protocols
   - outgoing + tcp protocols
   - outgoing + udp protocols

##### Parameter Description

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

##### Network Connection Analysis

Guance supports viewing Deployment network connection data, including source IP/port, target IP/port, number of bytes sent, number of bytes received, TCP delay, TCP retransmission times and so on. At the same time, you can customize the display fields through the "Settings" button, or add filters for connection data to filter keywords of all string types. If you need to view more detailed network connection data, click this data or "View Network Flow Data" to view its corresponding network flow data.

![](img/5.network_7.png)

#### HTTP Protocol

Pod network supports seven layers of network performance monitoring based on HTTP protocol.

##### Parameter Description

| Parameter           | Description                                                         | Statistical Method |
| -------------- | ------------------------------------------------------------ | -------- |
| Number of requests         | Total number of requests for the current Pod in the time range                              | Summation     |
| Average requests per second | Current "total Pod requests/total time spent on requests" within the time range               | Average value   |
| Average response time   | Time range, current Pod response time                                | Average value   |
| Number of errors         | The number of request errors for the current Pod in the time range, that is, the sum of status_code field values of 4xx and 5xx. | Summation     |
| Error rate         | The value of "Number of Request Errors/Total Requests" of the current Pod in the time range.         | Percentage   |

##### Network Connection Analysis

Guance supports viewing the visual chart trend of Pod network request number, error number and error rate. It also supports viewing Pod network connection analysis, including source IP/port, target IP/port, status code, request mode and response time. At the same time, you can customize the display fields through the "Settings" button, or add filters for connection data to filter keywords of all string types. If you need to view more detailed network connection data, click this data or "View Network Flow Data" to view its corresponding network flow data.

![](img/5.network_7.png)

##### View Network Flow Data

Guance supports viewing network flow data, which is automatically refreshed every 30s. The data of the last day is displayed by default, including time, source IP/port, target IP/port, status code, request mode and response tim. At the same time, you can customize the display fields through the Settings button, or add filters for network stream data to filter keywords of all string types.

![](img/5.network_8.png)

## Association analysis

You can click on the Host/Pod/Deployment icon for association query, which supports viewing upstream and downstream, network details, host/Pod/Deployment details, association logs, association links and association events.

### View Upstream and Downstream

In the infrastructure network, click the Host/Pod/Deployment icon and click "View Upstream and Downstream" to view the upstream and downstream node association of the current node.

![](img/11.network_1.png)

Click "Return Overview" in the upper left corner to return to the original network Map, search or filter the associated upstream and downstream nodes in the search box, and display the matching associated upstream and downstream nodes according to the search or screening results.

![img](img/11.network_3.png)


