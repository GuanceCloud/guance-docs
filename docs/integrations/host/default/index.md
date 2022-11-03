# 默认采集

---

主机[**安装 DataKit**](../../../datakit/datakit-install.md) 之后，会**默认开启**一些采集器，**无需手动**开启。默认采集的主机系统指标数据如下：

| 指标名称                                     | 说明                       | 指标举例                                              | 指标详解                                                         |
| -------------------------------------------- | -------------------------- | ----------------------------------------------------- | ---------------------------------------------------------------- |
| [CPU](cpu.md)                                | 采集主机的 CPU 使用情况    | CPU 使用率、IO 等待、用户态、核心态、软中断、硬中断等 | [CPU 指标详解](../../../../datakit/cpu#measurements)             |
| [Conntrack](conntrack.md)                    | 采集主机网络连接情况       | 搜索条目数、插入的包数、连接数量等                    | [Conntrack 指标详解](../../../../datakit/system#conntrack)       |
| [DataKit](datakit.md)                        | 采集 DataKit 自身使用情况  | CPU 使用率、内存信息、运行时间、日志记录等            | [DataKit 指标详解](../../../../datakit/self#measurements)        |
| [Disk](disk.md)                              | 采集磁盘占用情况           | 磁盘使用率、磁盘剩余空间、Inode 使用率、Inode 大小等  | [Disk 指标详解](../../../../datakit/disk#measurements)           |
| [DiskIO](diskio.md)                          | 采集主机的磁盘 IO 情况     | 磁盘读写、磁盘读写时间、IOPS 等                       | [DiskIO 指标详解](../../../../datakit/diskio#measurements)       |
| [MEM](mem.md)                                | 采集主机的内存使用情况     | 内存使用率、内存大小、缓存、缓冲等                    | [Memory 指标详解](../../../../datakit/mem#measurements)          |
| [Net](net.md)                                | 采集主机的网络流量情况     | 网络出/入口流量、网络出/入口数据包等                  | [Net 指标详解](../../../../datakit/net#measurements)             |
| [Swap](swap.md)                              | 采集 Swap 内存使用情况     | Swap 使用率、Swap 大小等                              | [Swap 指标详解](../../../../datakit/swap#measurements)           |
| [System](system.md)                          | 采集主机的操作系统负载情况 | CPU 平均负载、在线用户数、系统运行时间等              | [System 指标详解](../../../../datakit/system#system_1)           |
| [Hostobject](../../../datakit/hostobject.md) | 采集主机的基础信息         | 硬件型号、基础资源消耗等                              | [主机对象 指标详解](../../../../datakit/hostobject#measurements) |
