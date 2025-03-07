---
title: 'Azure Virtual Machines'
tags:
  - 'AZURE'
summary: 'Collect Azure Virtual Machines metric data'
__int_icon: 'icon/azure_vm'
dashboard:
  - desc: 'Azure Virtual Machine'
    path: 'dashboard/en/azure_vm'
monitor   :
  - desc  : 'Azure Virtual Machine'
    path  : 'monitor/en/azure_vm'
---

<!-- markdownlint-disable MD025 -->
# Azure Virtual Machines
<!-- markdownlint-enable -->

Collect Azure Virtual Machines metric data.

## Config {#config}

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> Recommend deploying GSE (Game Server Engine) edition translation.

### Installation script


> Tip: Please prepare the required Azure application registration information in advance and assign the role of subscribing to `Monitoring Reader` to the application registration

To synchronize the monitoring data of Azure Virtual Machines resources, we install the corresponding collection script: `ID:guance_azure_vm`


After clicking on **Install**, enter the corresponding parameters:

- `Azure Tenant ID`: Tenant ID
- `Azure Client ID`: Application Registration Client ID
- `Azure Client Secret Value`: Client password value, note not ID
- `Subscriptions`: subscription ID, multiple subscriptions used `,` split


tap **Deploy startup Script**，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in "**Management / Crontab Config**". Click "**Run**"，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-azure-vm/){:target="_blank"}



### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure Azure Virtual Machines monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Microsoft.Compute/virtualMachines](https://learn.microsoft.com/zh-cn/azure/azure-monitor/reference/supported-metrics/microsoft-compute-virtualmachines-metrics){:target="_blank"}

| Metric Name | Description | Unit |
|-------------|-------------|------|
| `available_memory_bytes_average` | The amount of physical memory immediately available for allocation to processes or the system in the virtual machine, in bytes. | byte |
| `cpu_credits_consumed_average` | The total number of CPU credit points consumed by the virtual machine. This only applies to B-series burstable VMs. | count |
| `cpu_credits_remaining_average` | The total number of CPU credit points available for bursting. This only applies to B-series burstable VMs. | count |
| `disk_read_bytes_total` | The total number of bytes read from all disks attached to the VM within a minute. If read-only or read-write disk caching is enabled, this metric includes bytes read from the cache. | byte |
| `disk_read_operations_sec_average` | The number of input operations read from all disks attached to the VM per second. If read-only or read-write disk caching is enabled, this metric includes IOPS read from the cache. | count/s |
| `disk_write_bytes_total` | The number of bytes written to all disks attached to the VM within a minute. | byte |
| `disk_write_operations_sec_average` | The number of output operations written to all disks attached to the VM per second. | count/s |
| `inbound_flows_average` | The current number of flows in the inbound direction (traffic entering the VM). | count |
| `network_in_total` | The total network traffic entering the virtual machine. | byte |
| `network_out_total` | The total network traffic outgoing from the virtual machine. | byte |
| `os_disk_bandwidth_consumed_percentage_average` | The percentage of operating system disk bandwidth consumption per minute. This only applies to VM series that support premium storage. | % |
| `os_disk_iops_consumed_percentage_average` | The percentage of operating system disk I/Os consumption per minute. This only applies to VM series that support premium storage. | % |
| `os_disk_latency_average` | The average time to complete each IO on the operating system disk during monitoring, in milliseconds. This only applies to disks attached to the VM using a SCSI disk controller and does not apply to disks using an NVMe disk controller. | ms |
| `os_disk_queue_depth_average` | The number of current pending IO requests waiting to be read or written from the operating system disk. | count |
| `os_disk_read_bytes_sec_average` | The number of bytes read from the operating system disk per second. If read-only or read-write disk caching is enabled, this metric includes bytes read from the cache. | byte |
| `os_disk_read_operations_sec_average` | The number of input operations read from the operating system disk per second. If read-only or read-write disk caching is enabled, this metric includes IOPS read from the cache. | count/s |
| `os_disk_target_bandwidth_average` | The baseline throughput per second that the operating system disk can achieve without bursting. | count/s |
| `os_disk_target_iops_average` | The baseline IOPS that the operating system disk can achieve without bursting. | count |
| `os_disk_write_bytes_sec_average` | The number of bytes written to the operating system disk per second. | byte/s |
| `os_disk_write_operations_sec_average` | The number of output operations written to the operating system disk per second. | byte/s |
| `outbound_flows_average` | The current number of flows in the outbound direction (traffic outgoing from the VM). | count |
| `percentage_cpu_average` | The percentage of allocated computing units currently used by the virtual machine. | % |
| `temp_disk_latency_average` | The average time to complete each IO on the temporary disk during monitoring, in milliseconds. This only applies to temporary disks that are not NVMe temporary storage disks. | ms |
| `temp_disk_queue_depth_average` | The number of current pending IO requests waiting to be read or written from the temporary disk. This only applies to temporary disks that are not NVMe temporary storage disks. | count |
| `temp_disk_read_bytes_sec_average` | The number of bytes read from the temporary disk per second. This only applies to temporary disks that are not NVMe temporary storage disks. | byte/s |
| `temp_disk_read_operations_sec_average` | The number of input operations read from the temporary disk per second. This only applies to temporary disks that are not NVMe temporary storage disks. | count/s |
| `temp_disk_write_bytes_sec_average` | The number of bytes written to the temporary disk per second. This only applies to temporary disks that are not NVMe temporary storage disks. | byte/s |
| `temp_disk_write_operations_sec_average` | The number of output operations written to the temporary disk per second. This only applies to temporary disks that are not NVMe temporary storage disks. | count/s |
| `vm_cached_bandwidth_consumed_percentage_average` | The percentage of virtual machine cached bandwidth consumed. | % |
| `vm_cached_iops_consumed_percentage_average` | The percentage of virtual machine cached IOPS consumed. | % |
| `vm_local_used_burst_bps_credits_percentage_average` | The percentage of locally used burst bps credit points. | % |
| `vm_local_used_burst_io_credits_percentage_average` | The percentage of locally used burst IO credit points. | % |
| `vm_remote_used_burst_bps_credits_percentage_average` | The percentage of remotely used burst bps credit points. | % |
| `vm_remote_used_burst_io_credits_percentage_average` | The percentage of remotely used burst IO credit points. | % |
| `vm_uncached_bandwidth_consumed_percentage_average` | The percentage of virtual machine uncached bandwidth consumed. | % |
| `vm_uncached_iops_consumed_percentage_average` | The percentage of virtual machine uncached IOPS consumed. | % |
