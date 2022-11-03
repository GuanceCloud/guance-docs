# 主机系统
---

[DataKit](../../datakit/) 是观测云中至关重要的一个数据采集组件，几乎所有观测云中的数据都是来源于 DataKit。

<br/>

**对于主机系统的数据采集，需首先[安装 DataKit](../../datakit/datakit-install.md)：**

- 安装 DataKit 之后，会默认开启一些数据的采集；

- 除默认采集的数据之外，用户可以根据实际需求，自定义开启更多丰富的数据采集插件；

- 而对于一些特别的指标，安装 DataKit 之后，目前还需要 Telegraf 协助采集数据。



**安装 DataKit 之后，主机指标的采集说明如下：**

- 默认采集：[CPU](default/cpu.md) 、 [Conntrack](default/conntrack.md) 、 [DataKit](default/datakit.md) 、 [Disk](default/disk.md) 、  [DiskIO](default/diskio.md) 、 [MEM](default/mem.md) 、 [Net](default/net.md) 、 [Swap](default/swap.md)、  [System](default/system.md)

- 自定义开启：[Directory](directory.md) 、 [eBPF](ebpf.md) 、 [Processes](processes.md) 、 [Scheck(安全巡检)](default/mem.md)

- Telegraf：[Chrony](chrony.md) 、 [DNS Query](dns-query.md) 、 [EthTool](ethtool.md) 、 [IPMI Sensor](ipmi-sensor.md) 、 [NetStat](netstat.md) 、 [NtpQ](ntpq.md) 、 [ProcStat](procstat.md)

<br/>

**开始[安装 DataKit](../../datakit/datakit-install.md)，开启你的观测云之旅！**


