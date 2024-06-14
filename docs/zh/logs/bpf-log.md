# BPF 网络日志

BPF 网络，即 Berkeley Packet Filter (BPF) 技术，是一种在操作系统内核层面上运行的网络数据包过滤技术。它能够帮助我们捕获和筛选经过网络的数据包，以此来提升网络效率，进行安全检查等。BPF 规则是一种定义过滤条件的特殊语言，可以指定多种过滤标准，比如数据包的源 IP、目标 IP、使用的协议类型或者端口号等。简单来说，BPF 就像是一个高级的网络筛子，能够根据我们设定的规则，筛选出我们想要的网络数据包。

## bpf_net_l4_log

在日志查看器筛选出 `source:bpf_net_l4_log` 的数据，进入详情页：

![](img/bpf_net_l4_log-1.png)

### 网络详情

基于网络传输方向，判断客户端与服务端进行展示：

![](img/bpf_net_l4_log-2.png)

- 若 `direction` 为 outging，源 IP 为客户端，目标 IP 为服务端；
- 若 `direction` 为 incoming，源 IP 为服务端，目标 IP 为客户端；
- 若 `direction` 为 unknown，源 IP 为 Local，目标 IP 为 Remote。

若某条数据包内包含 L7 网络日志数据，可直接点击跳转至详情页。

![](img/bpf_net_l4_log-1.gif)

右上角搜索框内，支持对针对 seq 搜索数据包，快速定位。

## bpf_net_l7_log

在日志查看器筛选出 `source:bpf_net_l7_log` 的数据，进入详情页：

![](img/bpf_net_l7_log.png)


### 网络请求拓扑

展示虚拟网卡 - 物理网卡之间的网络调用关系以及调用传输耗时。

![](img/bpf_net_l7_log-1.png)

**注意**：若存在外部未知网络情况，则显示 N/A。

![](img/bpf_net_l7_log-2.png)

- 虚拟网卡：为您展示 `pod_name`、`nic_name`、`dst_port`、`src_port`、`k8s_namespace`、`k8s_container_name`、`host` 等相关信息。
- 物理网卡：为您展示 `host`、`nic_name`、`dst_port`、`src_port`、`l4_proto`、`l7_proto` 等相关信息。


### 关联网络日志

观测云基于单连接请求、跨网卡请求和传输层请求三个维度展示相关的日志数据。

![](img/bpf_net_l7_log-3.png)