---
icon: material/table-column-plus-after
---
# 主机系统

---

[DataKit](../../datakit/) 是观测云中至关重要的一个数据采集组件，几乎所有观测云中的数据都是来源于 DataKit。

<br/>

[**安装 DataKit**](../../datakit/datakit-install.md)之后，对于如下指标集，可通过不同采集方式获取：

|默认采集 |   |  |  |    |
| :----: | :------: | :------: | :---------------: | :-----------: |
|  [CPU](default/cpu.md){ .md-button .md-button--primary }  | [Conntrack](default/conntrack.md){ .md-button .md-button--primary } | [DataKit](default/datakit.md){ .md-button .md-button--primary } |  [MEM](default/mem.md){ .md-button .md-button--primary }  |
| [Disk](default/disk.md){ .md-button .md-button--primary } |    [DiskIO](default/diskio.md){ .md-button .md-button--primary }    |     [Net](default/net.md){ .md-button .md-button--primary }     | [Swap](default/swap.md){ .md-button .md-button--primary } | [System](default/system.md){ .md-button .md-button--primary } |


|  {==**自定义开启**==}  |  |    |   |
| :---------------------------------------------------------: | :---------------------------------------------------------: | :---------------------------------------------------------: | :-------------------------------------------------------------: |
| [:octicons-file-directory-16: Directory](directory.md){ .md-button .md-button--primary } |      [:integrations-ebpf: eBPF](ebpf.md){ .md-button .md-button--primary }      | [:material-vector-square-plus: Processes](processes.md){ .md-button .md-button--primary } | [:material-security: Scheck(安全巡检)](scheck.md){ .md-button .md-button--primary } |


|                     {++**Telegraf**++}                      |                                                             |                                                             |                                                                 |
| :---------------------------------------------------------: | :---------------------------------------------------------: | :---------------------------------------------------------: | :-------------------------------------------------------------: |
|    [:material-clock-time-three-outline: Chrony](chrony.md){ .md-button .md-button--primary }    | [:material-dns-outline: DNS Query](dns-query.md){ .md-button .md-button--primary } |   [:integrations-ethtool: EthTool](ethtool.md){ .md-button .md-button--primary }   | [:fontawesome-solid-sliders: IPMI Sensor](ipmi-sensor.md){ .md-button .md-button--primary } |
|   [:octicons-arrow-switch-16: NetStat](netstat.md){ .md-button .md-button--primary }   |      [:material-timeline-clock-outline: NtpQ](ntpq.md){ .md-button .md-button--primary }      |  [:material-camera-timer: ProcStat](procstat.md){ .md-button .md-button--primary }  |                                                                 |     |

<br/>

**开始[安装 DataKit](../../datakit/datakit-install.md)，开启你的观测云之旅！**
