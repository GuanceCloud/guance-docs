---
title: 'Azure Virtual Machines'
tags: 
  - 'AZURE'
summary: 'Collect Azure Virtual Machines Metrics data'
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

Collect Azure Virtual Machines Metrics data.

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> It is recommended to deploy the GSE version

### Install Script

> Note: Please prepare the required Azure application registration information in advance and assign the `Monitoring Reader` role to the application registration.

To synchronize Azure Virtual Machines monitoring data, we install the corresponding collection script: 「Guance Integration (Azure-Virtual Machine Collection)」(ID: `guance_azure_vm`)

After clicking 【Install】, enter the corresponding parameters:

- `Azure Tenant ID`: Tenant ID
- `Azure Client ID`: Application Registration Client ID
- `Azure Client Secret Value`: Client secret value, not the ID
- `Subscriptions`: Subscription ID, multiple subscriptions separated by `,`

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

After enabling, you can see the corresponding automatic trigger configuration under 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

We default to collecting some configurations; see the metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-azure-vm/){:target="_blank"}

### Verification

1. Confirm that the corresponding tasks exist under 「Management / Automatic Trigger Configuration」and check the corresponding task records and logs for any abnormalities.
2. In the Guance platform, check 「Infrastructure / Custom」to see if asset information exists.
3. In the Guance platform, check 「Metrics」to see if there is corresponding monitoring data.

## Metrics {#metric}

After configuring Azure Virtual Machines monitoring data, the default metric set is as follows. You can collect more metrics through configuration. [Microsoft.Compute/virtualMachines Supported Metrics](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-compute-virtualmachines-metrics){:target="_blank"}

| Metric Name | Description | Unit |
| ---- | ------ | ------ |
|`available_memory_bytes_average`| The amount of physical memory immediately available to be allocated to processes or the system in the VM, in bytes.| byte|
|`cpu_credits_consumed_average`| The total number of CPU credits consumed by the VM. This applies only to B-series burstable VMs.| count |
|`cpu_credits_remaining_average`| The total number of CPU credits available for bursting. This applies only to B-series burstable VMs.| count|
|`disk_read_bytes_total`| Total number of bytes read from all disks attached to the VM in one minute. If read-only or read-write disk caching is enabled, this metric includes bytes read from cache.| byte|
|`disk_read_operations_sec_average`| Number of input operations per second read from all disks attached to the VM. If read-only or read-write disk caching is enabled, this metric includes IOPS read from cache.| count/s|
|`disk_write_bytes_total`| Total number of bytes written to all disks attached to the VM in one minute.| byte |
|`disk_write_operations_sec_average`| Number of output operations per second written to all disks attached to the VM.| count/s|
|`inbound_flows_average`| Number of flows currently in the inbound direction (traffic entering the VM).| count |
|`network_in_total`| Total network traffic entering the virtual machine.| byte |
|`network_out_total`| Total network traffic leaving the virtual machine.| byte |
|`os_disk_bandwidth_consumed_percentage_average`| Percentage of operating system disk bandwidth consumed per minute. This applies only to VM series that support premium storage.| % |
|`os_disk_iops_consumed_percentage_average`| Percentage of operating system disk I/Os consumed per minute. This applies only to VM series that support premium storage.| % |
|`os_disk_latency_average`| Average time taken to complete each IO on the operating system disk during monitoring, in milliseconds. This applies only to disks attached to the VM using a SCSI disk controller and does not apply to disks using an NVMe disk controller.| ms |
|`os_disk_queue_depth_average`| Number of current incomplete IO requests waiting to be read from or written to the operating system disk.| count |
|`os_disk_read_bytes_sec_average`| Number of bytes read per second from the operating system disk. If read-only or read-write disk caching is enabled, this metric includes bytes read from cache.| byte |
|`os_disk_read_operations_sec_average`| Number of input operations per second read from the operating system disk. If read-only or read-write disk caching is enabled, this metric includes IOPS read from cache.| count/s |
|`os_disk_target_bandwidth_average`| Baseline throughput in IOPS that the operating system disk can achieve without bursting.| count/s |
|`os_disk_target_iops_average`| Baseline IOPS that the operating system disk can achieve without bursting.| count |
|`os_disk_write_bytes_sec_average`| Number of bytes written per second to the operating system disk.| byte/s|
|`os_disk_write_operations_sec_average`| Number of output operations per second written to the operating system disk.|byte/s|
|`outbound_flows_average`| Number of flows currently in the outbound direction (traffic leaving the VM).| count |
|`percentage_cpu_average`| Percentage of allocated compute units currently used by the virtual machine.| % |
|`temp_disk_latency_average`| Average time taken to complete each IO on the temporary disk during monitoring, in milliseconds. This applies only to temporary disks that are not NVMe temporary storage disks.| ms |
|`temp_disk_queue_depth_average`| Number of current incomplete IO requests waiting to be read from or written to the temporary disk. This applies only to temporary disks that are not NVMe temporary storage disks.| count |
|`temp_disk_read_bytes_sec_average`| Number of bytes read per second from the temporary disk. This applies only to temporary disks that are not NVMe temporary storage disks.|byte/s|
|`temp_disk_read_operations_sec_average`| Number of input operations per second read from the temporary disk. This applies only to temporary disks that are not NVMe temporary storage disks.|count/s|
|`temp_disk_write_bytes_sec_average`| Number of bytes written per second to the temporary disk. This applies only to temporary disks that are not NVMe temporary storage disks.|byte/s|
|`temp_disk_write_operations_sec_average`| Number of output operations per second written to the temporary disk. This applies only to temporary disks that are not NVMe temporary storage disks.|count/s|
|`vm_cached_bandwidth_consumed_percentage_average`| Percentage of cached bandwidth used by the VM.|%|
|`vm_cached_iops_consumed_percentage_average`| Percentage of cached IOPS used by the VM.|%|
|`vm_local_used_burst_bps_credits_percentage_average`| Percentage of locally used burst bps credits.|%|
|`vm_local_used_burst_io_credits_percentage_average`| Percentage of locally used burst IO credits.|%|
|`vm_remote_used_burst_bps_credits_percentage_average`| Percentage of remotely used burst bps credits.|%|
|`vm_remote_used_burst_io_credits_percentage_average`| Percentage of remotely used burst IO credits.|%|
|`vm_uncached_bandwidth_consumed_percentage_average`| Percentage of uncached bandwidth used by the VM.|%|
|`vm_uncached_iops_consumed_percentage_average`| Percentage of uncached IOPS used by the VM.|%|
|`vm_write_bandwidth_consumed_percentage_average`| Percentage of write bandwidth consumed by the VM.|%|
|`vm_write_iops_consumed_percentage_average`| Percentage of write IOPS consumed by the VM.|%|
|`vm_write_latency_average`| Average latency of write operations on the VM.|ms|
|`vm_write_queue_depth_average`| Average queue depth of write operations on the VM.|count|

Note: Some metric descriptions have been adjusted for clarity and consistency.