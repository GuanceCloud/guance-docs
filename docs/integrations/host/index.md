# 主机系统
---

[DataKit](../../datakit/) 是观测云中至关重要的一个数据采集组件，几乎所有观测云中的数据都是来源于 DataKit。

<br/>

对于主机系统的数据采集，需首先[**安装 DataKit**](../../datakit/datakit-install.md)：

- 安装 DataKit 之后，会**默认开启**一些数据的采集：

| 采集方式 | 指标集名称      | 
| --------------------------- | ------------------------------------------------------------ | 
| 默认采集 | [CPU](default/cpu.md) 、 [Conntrack](default/conntrack.md) 、 [DataKit](default/datakit.md) 、 [Disk](default/disk.md) 、  [DiskIO](default/diskio.md) 、 [MEM](default/mem.md) 、 [Net](default/net.md) 、 [Swap](default/swap.md)、  [System](default/system.md) |

- 除默认采集的数据之外，用户可以根据实际需求，**自定义开启**更多丰富的数据采集插件：

| 指标集名称                  | 指标举例                                                     | 指标集名称                        | 指标举例                                                   |
| --------------------------- | ------------------------------------------------------------ | --------------------------------- | ---------------------------------------------------------- |
| [Directory](directory.md) |  文件个数、文件大小信息等                        | [eBPF](ebpf.md) | 主机网络 TCP/UDP 连接信息、Bash 执行日志等 |
| [Processes](processes.md) | 进程指标数据、进程对象信息等              | [Scheck(安全巡检)](scheck.md)          | 系统、网络、数据库、存储信息等         |

- 安装 DataKit 之后，对于如下指标集，需要 **Telegraf** 协助采集数据：

| 指标集名称                  | 指标举例                                                     | 指标集名称                        | 指标举例                                                   |
| --------------------------- | ------------------------------------------------------------ | --------------------------------- | ---------------------------------------------------------- |
| [Chrony](chrony.md) |  轮询速率、时间偏移、可达性寄存器信息等等                        | [DNS Query](dns-query.md) | 查询时间、记录类型、返回码信息等 |
| [EthTool](ethtool.md) | 网络接口出入流量、出入数据包、丢弃数据包等              | [IPMI Sensor](ipmi-sensor.md)             | 查询操作、文档操作、TTL 索引、游标、队列信息等         |
| [NetStat](netstat.md)           |  TCP/UDP 连接数、等待连接、等待处理请求信息等         | [NtpQ](ntpq.md)              | 延迟、抖动、轮询、偏移量信息等     |
| [ProcStat](procstat.md)           | 文件数、进程数、返回码等         |         |       |



**开始[安装 DataKit](../../datakit/datakit-install.md)，开启你的观测云之旅！**


