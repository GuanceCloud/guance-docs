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

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites will be automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

> It is recommended to deploy the GSE version.

### Installation Script

> Note: Please prepare the required Azure application registration information in advance and assign the `Monitoring Reader` role to the application registration.

To synchronize the monitoring data of Azure Virtual Machines, we install the corresponding collection script: 「<<< custom_key.brand_name >>> Integration (Azure-Virtual Machine Collection)」(ID: `guance_azure_vm`)

After clicking 【Install】, enter the corresponding parameters:

- `Azure Tenant ID`: Tenant ID
- `Azure Client ID`: Application Registration Client ID
- `Azure Client Secret Value`: Client secret value, note that it is not the ID
- `Subscriptions`: Subscription ID, multiple subscriptions are separated by `,`

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in the 「Manage / Automatic Trigger Configuration」section. Click 【Execute】to immediately run once without waiting for the regular time. After a short wait, you can view the execution task records and corresponding logs.

We default to collecting some configurations, details are shown in the metrics section.

[Configure custom cloud object metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-azure-vm/){:target="_blank"}

### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding tasks have the corresponding automatic trigger configuration, and at the same time, you can check the corresponding task records and logs for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, under 「Infrastructure / Custom」, check if there is any asset information.
3. On the <<< custom_key.brand_name >>> platform, under 「Metrics」, check if there are any corresponding monitoring data.

## Metrics {#metric}

After configuring Azure Virtual Machines monitoring data, the default metric set is as follows. You can collect more metrics through configuration [Microsoft.Compute/virtualMachines supported metrics](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-compute-virtualmachines-metrics){:target="_blank"}

| Metric Name | Description| Unit |
| ---- | ------ | ------ |
|`available_memory_bytes_average`| The amount of physical memory immediately available for allocation to processes or the system, in bytes.| byte|
|`cpu_credits_consumed_average`| The total number of CPU credits consumed by the virtual machine. This only applies to B-series burstable VMs.| count |
|`cpu_credits_remaining_average`| The total number of CPU credits available for bursting. This only applies to B-series burstable VMs.| count|
|`disk_read_bytes_total`| Total number of bytes read from all disks attached to the VM in one minute. If read-only or read/write disk caching is enabled, this metric includes bytes read from the cache.| byte|
|`disk_read_operations_sec_average`| Number of input operations read per second from all disks attached to the VM. If read-only or read/write disk caching is enabled, this metric includes cached IOPS.| count/s|
|`disk_write_bytes_total`| Total number of bytes written to all disks attached to the VM in one minute.| byte |
|`disk_write_operations_sec_average`| Number of output operations written per second to all disks attached to the VM.| count/s|
|`inbound_flows_average`| Number of flows currently in the inbound direction (traffic entering the VM).| count |
|`network_in_total`| Total network traffic entering the virtual machine.| byte |
|`network_out_total`| Total network traffic going out from the virtual machine.| byte |
|`os_disk_bandwidth_consumed_percentage_average`| Percentage of operating system disk bandwidth consumed each minute. This only applies to VM series that support premium storage.| % |
|`os_disk_iops_consumed_percentage_average`| Percentage of operating system disk I/Os consumed each minute. This only applies to VM series that support premium storage.| % |
|`os_disk_latency_average`| Average time taken to complete each IO on the operating system disk during monitoring, in milliseconds. This only applies to disks attached to the VM using the SCSI disk controller, and does not apply to disks using the NVMe disk controller.| ms |
|`os_disk_queue_depth_average`| Number of current outstanding IO requests waiting to be read from or written to the operating system disk.| count |
|`os_disk_read_bytes_sec_average`| Number of bytes read per second from the operating system disk. If read-only or read/write disk caching is enabled, this metric includes bytes read from the cache.| byte |
|`os_disk_read_operations_sec_average`| Number of input operations read per second from the operating system disk. If read-only or read/write disk caching is enabled, this metric includes cached IOPS.| count/s |
|`os_disk_target_bandwidth_average`| Baseline throughput per second that the operating system disk can achieve without bursting.| count/s |
|`os_disk_target_iops_average`| Baseline IOPS that the operating system disk can achieve without bursting.| count |
|`os_disk_write_bytes_sec_average`| Number of bytes written per second to the operating system disk.| byte/s|
|`os_disk_write_operations_sec_average`| Number of output operations written per second to the operating system disk.|byte/s|
|`outbound_flows_average`| Number of flows currently in the outbound direction (traffic leaving the VM).| count |
|`percentage_cpu_average`| Percentage of allocated compute units currently used by the virtual machine.| % |
|`temp_disk_latency_average`| Average time taken to complete each IO on the temporary disk during monitoring, in milliseconds. This only applies to temporary disks that are not NVMe temporary storage disks.| ms |
|`temp_disk_queue_depth_average`| Number of current outstanding IO requests waiting to be read from or written to the temporary disk. This only applies to temporary disks that are not NVMe temporary storage disks.| count |
|`temp_disk_read_bytes_sec_average`| Number of bytes read per second from the temporary disk. This only applies to temporary disks that are not NVMe temporary storage disks.|byte/s|
|`temp_disk_read_operations_sec_average`| Number of input operations read per second from the temporary disk. This only applies to temporary disks that are not NVMe temporary storage disks.|count/s|
|`temp_disk_write_bytes_sec_average`| Number of bytes written per second to the temporary disk. This only applies to temporary disks that are not NVMe temporary storage disks.|byte/s|
|`temp_disk_write_operations_sec_average`| Number of output operations written per second to the temporary disk. This only applies to temporary disks that are not NVMe temporary storage disks.|count/s|
|`vm_cached_bandwidth_consumed_percentage_average`| Percentage of virtual machine cached bandwidth used.|%|
|`vm_cached_iops_consumed_percentage_average`| Percentage of virtual machine cached IOPS used.|%|
|`vm_local_used_burst_bps_credits_percentage_average`| Percentage of local burst bps credits used.|%|
|`vm_local_used_burst_io_credits_percentage_average`| Percentage of local burst IO credits used.|%|
|`vm_remote_used_burst_bps_credits_percentage_average`| Percentage of remote burst bps credits used.|%|
|`vm_remote_used_burst_io_credits_percentage_average`| Percentage of remote burst IO credits used.|%|
|`vm_uncached_bandwidth_consumed_percentage_average`| Percentage of uncached bandwidth used by the virtual machine.|%|
|`vm_uncached_iops_consumed_percentage_average`| Percentage of uncached IOPS used by the virtual machine.|%|