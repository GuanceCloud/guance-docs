---
title: 'Azure Virtual Machines'
tags: 
  - 'Azure'
summary: '采集 Azure Virtual Machines 指标数据'
__int_icon: 'icon/azure_vm'
dashboard:
  - desc: 'Azure Virtual Machine 监控视图'
    path: 'dashboard/zh/azure_vm'
monitor   :
  - desc  : 'Azure Virtual Machine 检测库'
    path  : 'monitor/zh/azure_vm'
---

<!-- markdownlint-disable MD025 -->
# Azure Virtual Machines
<!-- markdownlint-enable -->

采集 Azure Virtual Machines 指标数据。

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> 推荐部署 GSE 版

### 安装脚本

> 提示：请提前准备好符合要求的 Azure 应用注册信息，并将订阅 `Monitoring Reader`（监视查阅者） 的角色赋予给应用注册

同步 Azure Virtual Machines 的监控数据，我们安装对应的采集脚本：「观测云集成（Azure-Virtual Machine 采集）」(ID：`guance_azure_vm`)

点击【安装】后，输入相应的参数：

- `Azure Tenant ID`：租户 ID
- `Azure Client ID`：应用注册 Client ID
- `Azure Client Secret Value`：客户端密码值，注意不是 ID
- `Subscriptions`：订阅 ID ,多个订阅用`,`分割

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-azure-vm/){:target="_blank"}

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}

配置 Azure Virtual Machines 监控数据后,默认的指标集如下, 可以通过配置的方式采集更多的指标 [Microsoft.Compute/virtualMachines 受支持的指标](https://learn.microsoft.com/zh-cn/azure/azure-monitor/reference/supported-metrics/microsoft-compute-virtualmachines-metrics){:target="_blank"}

| Metric Name | Description| Unit |
| ---- | ------ | ------ |
|`available_memory_bytes_average`| 虚拟机中立即可供分配给进程或系统使用的物理内存量，以字节为单位。| byte|
|`cpu_credits_consumed_average`| 虚拟机消耗的 CPU 信用点数总和。这只适用于 B 系列可突发 VM。| count |
|`cpu_credits_remaining_average`| 可用于突发的 CPU 信用点数总数。这只适用于 B 系列可突发 VM。| count|
|`disk_read_bytes_total`| 一分钟内从所有附加到 VM 的磁盘读取的总字节数。如果启用了只读或读写磁盘缓存，此指标包括从缓存中读取的字节。| byte|
|`disk_read_operations_sec_average`| 每秒从所有附加到 VM 的磁盘读取的输入操作数。如果启用了只读或读写磁盘缓存，此指标包括从缓存中读取的 IOPS。| count/s|
|`disk_write_bytes_total`| 一分钟内从所有附加到 VM 的磁盘写入的字节数。| byte |
|`disk_write_operations_sec_average`| 每秒从所有附加到 VM 的磁盘写入的输出操作数。| count/s|
|`inbound_flows_average`| 当前流入方向（进入 VM 的流量）的流数。| count |
|`network_in_total`| 进入虚拟机的总网络流量。| byte |
|`network_out_total`| 从虚拟机出去的总网络流量。| byte |
|`os_disk_bandwidth_consumed_percentage_average`| 每分钟操作系统磁盘带宽消耗的百分比。这只适用于支持高级存储的 VM 系列。| % |
|`os_disk_iops_consumed_percentage_average`| 每分钟操作系统磁盘 I/Os 消耗的百分比。这只适用于支持高级存储的 VM 系列。| % |
|`os_disk_latency_average`| 监控期间完成操作系统磁盘上每个 IO 的平均时间，以毫秒为单位。这只适用于使用 SCSI 磁盘控制器附加到 VM 的磁盘，并且不适用于使用 NVMe 磁盘控制器的磁盘。| ms |
|`os_disk_queue_depth_average`| 等待从操作系统磁盘读取或写入的当前未完成 IO 请求的数量。| count |
|`os_disk_read_bytes_sec_average`| 每秒从操作系统磁盘读取的字节数。如果启用了只读或读写磁盘缓存，此指标包括从缓存中读取的字节。| byte |
|`os_disk_read_operations_sec_average`| 每秒从操作系统磁盘读取的输入操作数。如果启用了只读或读写磁盘缓存，此指标包括从缓存中读取的 IOPS。| count/s |
|`os_disk_target_bandwidth_average`| 操作系统磁盘在不进行突发的情况下可以实现的基线每秒吞吐量。| count/s |
|`os_disk_target_iops_average`| 操作系统磁盘在不进行突发的情况下可以实现的基线 IOPS。| count |
|`os_disk_write_bytes_sec_average`| 每秒向操作系统磁盘写入的字节数。| byte/s|
|`os_disk_write_operations_sec_average`| 每秒向操作系统磁盘写入的输出操作数。|byte/s|
|`outbound_flows_average`| 当前流出方向（出 VM 的流量）的流数。| count |
|`percentage_cpu_average`| 当前由虚拟机使用的分配计算单元的百分比。| % |
|`temp_disk_latency_average`| 监控期间完成临时磁盘上每个 IO 的平均时间，以毫秒为单位。这只适用于不是 NVMe 临时存储磁盘的临时磁盘。| ms |
|`temp_disk_queue_depth_average`| 等待从临时磁盘读取或写入的当前未完成 IO 请求的数量。这只适用于不是 NVMe 临时存储磁盘的临时磁盘。| count |
|`temp_disk_read_bytes_sec_average`| 每秒从临时磁盘读取的字节数。这只适用于不是 NVMe 临时存储磁盘的临时磁盘。|byte/s|
|`temp_disk_read_operations_sec_average`| 每秒从临时磁盘读取的输入操作数。这只适用于不是 NVMe 临时存储磁盘的临时磁盘。|count/s|
|`temp_disk_write_bytes_sec_average`| 每秒向临时磁盘写入的字节数。这只适用于不是 NVMe 临时存储磁盘的临时磁盘。|byte/s|
|`temp_disk_write_operations_sec_average`| 每秒向临时磁盘写入的输出操作数。这只适用于不是 NVMe 临时存储磁盘的临时磁盘。|count/s|
|`vm_cached_bandwidth_consumed_percentage_average`| 已使用的虚拟机缓存带宽的百分比。|%|
|`vm_cached_iops_consumed_percentage_average`| 已使用的虚拟机缓存 IOPS 的百分比。|%|
|`vm_local_used_burst_bps_credits_percentage_average`| 本地使用的突发bps信用点数的百分比。|%|
|`vm_local_used_burst_io_credits_percentage_average`| 本地使用的突发IO信用点数的百分比。|%|
|`vm_remote_used_burst_bps_credits_percentage_average`| 远程使用的突发bps信用点数的百分比。|%|
|`vm_remote_used_burst_io_credits_percentage_average`| 远程使用的突发IO信用点数的百分比。|%|
|`vm_uncached_bandwidth_consumed_percentage_average`| 已使用的虚拟机未缓存带宽的百分比。|%|
|`vm_uncached_iops_consumed_percentage_average`| 已使用的虚拟机未缓存 IOPS 的百分比。|%|
