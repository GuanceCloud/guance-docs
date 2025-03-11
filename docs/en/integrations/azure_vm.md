---
title: 'Azure Virtual Machines'
tags: 
  - 'AZURE'
summary: 'Collect metrics data from Azure Virtual Machines'
__int_icon: 'icon/azure_vm'
dashboard:
  - desc: 'Azure Virtual Machine monitoring view'
    path: 'dashboard/en/azure_vm'
monitor   :
  - desc  : 'Azure Virtual Machine detection library'
    path  : 'monitor/en/azure_vm'
---

<!-- markdownlint-disable MD025 -->
# Azure Virtual Machines
<!-- markdownlint-enable -->

Collect metrics data from Azure Virtual Machines.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed, please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> We recommend deploying the GSE version

### Install Script

> Note: Please prepare the required Azure application registration information in advance and assign the `Monitoring Reader` role to the application registration.

To synchronize Azure Virtual Machines monitoring data, we install the corresponding collection script: 「Guance Integration (Azure-Virtual Machine Collection)」(ID: `guance_azure_vm`)

After clicking 【Install】, enter the corresponding parameters:

- `Azure Tenant ID`: Tenant ID
- `Azure Client ID`: Application Registration Client ID
- `Azure Client Secret Value`: Client secret value, not ID
- `Subscriptions`: Subscription ID, multiple subscriptions separated by `,`

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to immediately execute once without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.

We have collected some configurations by default; see the Metrics section for details.

[Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-azure-vm/){:target="_blank"}

### Verification

1. In 「Manage / Automatic Trigger Configuration」confirm that the corresponding task has an automatic trigger configuration and check the corresponding task records and logs for any anomalies.
2. On the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. On the Guance platform, under 「Metrics」, check if the corresponding monitoring data exists.

## Metrics {#metric}

After configuring Azure Virtual Machines monitoring data, the default metric set is as follows. You can collect more metrics through configuration [Supported metrics for Microsoft.Compute/virtualMachines](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-compute-virtualmachines-metrics){:target="_blank"}

| Metric Name | Description | Unit |
| ---- | ------ | ------ |
|`available_memory_bytes_average`| The amount of physical memory immediately available for allocation to processes or the system in bytes.| byte|
|`cpu_credits_consumed_average`| Total CPU credits consumed by the virtual machine. This applies only to B-series burstable VMs.| count |
|`cpu_credits_remaining_average`| Total CPU credits available for bursting. This applies only to B-series burstable VMs.| count|
|`disk_read_bytes_total`| Total number of bytes read from all disks attached to the VM in one minute. If read-only or read/write disk caching is enabled, this metric includes bytes read from cache.| byte|
|`disk_read_operations_sec_average`| Number of input operations per second read from all disks attached to the VM. If read-only or read/write disk caching is enabled, this metric includes IOPS read from cache.| count/s|
|`disk_write_bytes_total`| Total number of bytes written to all disks attached to the VM in one minute.| byte |
|`disk_write_operations_sec_average`| Number of output operations per second written to all disks attached to the VM.| count/s|
|`inbound_flows_average`| Number of flows in the current inbound direction (traffic entering the VM).| count |
|`network_in_total`| Total network traffic entering the virtual machine.| byte |
|`network_out_total`| Total network traffic leaving the virtual machine.| byte |
|`os_disk_bandwidth_consumed_percentage_average`| Percentage of operating system disk bandwidth consumed per minute. This applies only to VM series that support premium storage.| % |
|`os_disk_iops_consumed_percentage_average`| Percentage of operating system disk I/Os consumed per minute. This applies only to VM series that support premium storage.| % |
|`os_disk_latency_average`| Average time taken to complete each IO on the operating system disk during monitoring, in milliseconds. This applies only to disks attached to the VM using a SCSI disk controller and not to disks using an NVMe disk controller.| ms |
|`os_disk_queue_depth_average`| Number of current pending IO requests waiting to be read from or written to the operating system disk.| count |
|`os_disk_read_bytes_sec_average`| Number of bytes read per second from the operating system disk. If read-only or read/write disk caching is enabled, this metric includes bytes read from cache.| byte |
|`os_disk_read_operations_sec_average`| Number of input operations per second read from the operating system disk. If read-only or read/write disk caching is enabled, this metric includes IOPS read from cache.| count/s |
|`os_disk_target_bandwidth_average`| Baseline throughput in bytes per second that the operating system disk can achieve without bursting.| count/s |
|`os_disk_target_iops_average`| Baseline IOPS that the operating system disk can achieve without bursting.| count |
|`os_disk_write_bytes_sec_average`| Number of bytes written per second to the operating system disk.| byte/s|
|`os_disk_write_operations_sec_average`| Number of output operations per second written to the operating system disk.|byte/s|
|`outbound_flows_average`| Number of flows in the current outbound direction (traffic leaving the VM).| count |
|`percentage_cpu_average`| Percentage of allocated compute units currently used by the virtual machine.| % |
|`temp_disk_latency_average`| Average time taken to complete each IO on the temporary disk during monitoring, in milliseconds. This applies only to temporary disks that are not NVMe temporary storage disks.| ms |
|`temp_disk_queue_depth_average`| Number of current pending IO requests waiting to be read from or written to the temporary disk. This applies only to temporary disks that are not NVMe temporary storage disks.| count |
|`temp_disk_read_bytes_sec_average`| Number of bytes read per second from the temporary disk. This applies only to temporary disks that are not NVMe temporary storage disks.|byte/s|
|`temp_disk_read_operations_sec_average`| Number of input operations per second read from the temporary disk. This applies only to temporary disks that are not NVMe temporary storage disks.|count/s|
|`temp_disk_write_bytes_sec_average`| Number of bytes written per second to the temporary disk. This applies only to temporary disks that are not NVMe temporary storage disks.|byte/s|
|`temp_disk_write_operations_sec_average`| Number of output operations per second written to the temporary disk. This applies only to temporary disks that are not NVMe temporary storage disks.|count/s|
|`vm_cached_bandwidth_consumed_percentage_average`| Percentage of cached bandwidth used by the virtual machine.|%|
|`vm_cached_iops_consumed_percentage_average`| Percentage of cached IOPS used by the virtual machine.|%|
|`vm_local_used_burst_bps_credits_percentage_average`| Percentage of local burst bps credits used.|%|
|`vm_local_used_burst_io_credits_percentage_average`| Percentage of local burst IO credits used.|%|
|`vm_remote_used_burst_bps_credits_percentage_average`| Percentage of remote burst bps credits used.|%|
|`vm_remote_used_burst_io_credits_percentage_average`| Percentage of remote burst IO credits used.|%|
|`vm_uncached_bandwidth_consumed_percentage_average`| Percentage of uncached bandwidth used by the virtual machine.|%|
|`vm_uncached_iops_consumed_percentage_average`| Percentage of uncached IOPS used by the virtual machine.|%|
|`percentage_cpu_average`| Percentage of allocated compute units currently used by the virtual machine.| % |
