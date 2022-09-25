---
icon: zy/intergrations
---

# 主机系统
---

DataKit 是观测云中至关重要的一个数据采集组件，几乎所有观测云中的数据都是来源于 DataKit。

对于主机系统的数据采集，需首先[安装 DataKit](../datakit/datakit-install.md)：
- 安装 DataKit 之后，会默认开启一些数据的采集，如 CPU、 Disk、Mem 等；
- 除默认采集的数据之外，用户可以根据实际需求，自定义开启更多丰富的数据采集插件，如 Diskio、 Netstat 等；
- 而对于一些特别的指标，安装 DataKit 之后，目前还需要 Telegraf 协助采集数据，如 Chrony、Directory、ebpf 等。

安装 DataKit 之后，主机指标的采集说明如下：
- 默认采集
  [CPU](../integrations/host/cpu.md)		[Conntrack](../integrations/host/conntrack.md)	[DataKit](../intergrations/host/datakit.md)	[Disk](../integrations/host/disk.md)
  [Mem](../integrations/host/mem.md)		[Net](../integrations/host/net.md)		[System](../intergrations/host/system.md)

- 自定义开启
  [Diskio](../integrations/host/diskio.md)		[Processes](../intergrations/host/processes.md)		[Swap](../integrations/host/swap.md)		[Scheck(安全巡检)](../integrations/host/mem.md)

- Telegraf
  [Chrony](../integrations/host/chrony.md)		[Directory](../integrations/host/directory.md)	[Ebpf](../intergrations/host/ebpf.md)	[EthTool](../integrations/host/ethtool.md)
  [IPMI Sensor](../integrations/host/ipmi-sensor.md)		[Net](../integrations/host/net.md)	[System](../intergrations/host/system.md)



开始[安装 DataKit](../datakit/datakit-install.md)，开启你的观测云之旅！


