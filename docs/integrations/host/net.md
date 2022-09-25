
# Net
---

## 视图预览

网络性能指标展示，包括网络出入口流量，网络出入口数据包等

![image](imgs/input-net-1.png)

## 版本支持

操作系统支持：Linux / Windows / Mac

## 前置条件

- 服务器 <[安装 DataKit](../datakit/datakit-install.md)>

## 安装配置

说明：示例 Linux 版本为：CentOS Linux release 7.8.2003 (Core)，Windows 版本请修改对应的配置文件

### 部署实施

(Linux / Windows 环境相同)

#### 指标采集 (默认)

1、 Net 数据采集默认开启，对应配置文件 /usr/local/datakit/conf.d/host/net.conf

参数说明

- interval：数据采集频率
- interfaces：指定网络接口
- enable_virtual_interfaces：是否开启虚拟网络接口
- ignore_protocol_stats：是否忽略协议状态

```
[[inputs.net]]
  interval = '10s'
  # interfaces = ['''eth[\w-]+''', '''lo''', ]
  # enable_virtual_interfaces = true
  # ignore_protocol_stats = false
```

2、 Net 指标采集验证  /usr/local/datakit/datakit -M |egrep "最近采集|net"

![image](imgs/input-net-2.png)

指标预览

![image](imgs/input-net-3.png)

#### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 net 指标都会带有 app = oa 的标签，可以进行快速查询
- 相关文档 <[DataFlux Tag 应用最佳实践](../best-practices/insight/tag.md)>

```
# 示例
[inputs.net.tags]
   app = "oa"
```

重启 DataKit

```
systemctl restart datakit
```

## 场景视图

<场景 - 新建仪表板 - 内置模板库 - Net>

## 监控规则

<监控 - 监控器 - 从模板新建 - 主机检测库>

## 指标详解

| 指标 | 描述 | 数据类型 | 单位 |
| --- | --- | --- | --- |
| `bytes_recv` | The number of bytes received by the interface. | int | B |
| `bytes_recv/sec` | The number of bytes received by the interface per second. | int | B/S |
| `bytes_sent` | The number of bytes sent by the interface . | int | B |
| `bytes_sent/sec` | The number of bytes sent by the interface per second. | int | B/S |
| `drop_in` | The number of received packets dropped by the interface. | int | count |
| `drop_out` | The number of transmitted packets dropped by the interface. | int | count |
| `err_in` | The number of receive errors detected by the interface. | int | count |
| `err_out` | The number of transmit errors detected by the interface. | int | count |
| `packets_recv` | The number of packets received by the interface. | int | count |
| `packets_recv/sec` | The number of packets received by the interface per second. | int | count |
| `packets_sent` | The number of packets sent by the interface. | int | count |
| `packets_sent/sec` | The number of packets sent by the interface per second. | int | count |
| `tcp_activeopens` | It means the TCP layer sends a SYN, and come into the SYN-SENT state. | int | count |
| `tcp_attemptfails` | The number of times TCP connections have made a direct transition to the CLOSED state from either the SYN-SENT state or the SYN-RCVD state, plus the number of times TCP connections have made a direct transition to the LISTEN state from the SYN-RCVD state. | int | count |
| `tcp_currestab` | The number of TCP connections for which the current state is either ESTABLISHED or CLOSE-WAIT. | int | count |
| `tcp_estabresets` | The number of times TCP connections have made a direct transition to the CLOSED state from either the ESTABLISHED state or the CLOSE-WAIT state. | int | count |
| `tcp_incsumerrors` | The number of incoming TCP segments in checksum error | int | count |
| `tcp_inerrs` | The number of incoming TCP segments in error | int | count |
| `tcp_insegs` | The number of packets received by the TCP layer. | int | count |
| `tcp_insegs/sec` | The number of packets received by the TCP layer per second. | int | count |
| `tcp_maxconn` | The limit on the total number of TCP connections the entity can support. | int | count |
| `tcp_outrsts` | The number of TCP segments sent containing the RST flag. | int | count |
| `tcp_outsegs` | The number of packets sent by the TCP layer. | int | count |
| `tcp_outsegs/sec` | The number of packets sent by the TCP layer per second. | int | count |
| `tcp_passiveopens` | It means the TCP layer receives a SYN, replies a SYN+ACK, come into the SYN-RCVD state. | int | count |
| `tcp_retranssegs` | The total number of segments retransmitted - that is, the number of TCP segments transmitted containing one or more previously transmittedoctets. | int | count |
| `tcp_rtoalgorithm` | The algorithm used to determine the timeout value used for retransmitting unacknowledged octets. | int | count |
| `tcp_rtomax` | The maximum value permitted by a TCP implementation for the retransmission timeout, measured in milliseconds. | int | ms |
| `tcp_rtomin` | The minimum value permitted by a TCP implementation for the retransmission timeout, measured in milliseconds. | int | ms |
| `udp_ignoredmulti` | IgnoredMulti | int | count |
| `udp_incsumerrors` | The number of incoming UDP datagrams in checksum error | int | count |
| `udp_indatagrams` | The number of UDP datagrams delivered to UDP users. | int | count |
| `udp_indatagrams/sec` | The number of UDP datagrams delivered to UDP users per second. | int | count |
| `udp_inerrors` | The number of packet receive errors | int | count |
| `udp_noports` | The number of packets to unknown port received. | int | count |
| `udp_outdatagrams` | The number of UDP datagrams sent from this entity. | int | count |
| `udp_outdatagrams/sec` | The number of UDP datagrams sent from this entity per second. | int | count |
| `udp_rcvbuferrors` | The number of receive buffer errors. | int | count |
| `udp_sndbuferrors` | The number of send buffer errors. | int | count |

## 常见问题排查

<[无数据上报排查](../datakit/why-no-data.md)>

## 进一步阅读

<[主机可观测最佳实践](../best-practices/monitoring/host-linux)>


