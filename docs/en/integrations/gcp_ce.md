---
title: 'GCP Compute Engine'
tags: 
  - GCP
summary: 'Collect resource metrics such as CPU, memory, disk, and network for GCP Compute Engine virtual machines'
__int_icon: 'icon/gcp_ce'
dashboard:
  - desc: 'GCP Compute Engine'
    path: 'dashboard/en/gcp_ce'

---


<!-- markdownlint-disable MD025 -->
# GCP Compute Engine
<!-- markdownlint-enable -->

Collect resource metrics such as CPU, memory, disk, and network for GCP Compute Engine virtual machines


## Configuration {#config}

### Install Func

It is recommended to enable the <<< custom_key.brand_name >>> integration - extension - hosted Func: all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### GCP Client Authorization

Before running the installation script, you need to authorize. Refer to the [GCP Client Authorization](https://func.guance.com/doc/script-market-guance-gcp-client-credential/){:target="_blank"} documentation.

### Installation Script

1. Log in to the Func console, click on 【Script Market】, enter the official script market, and search for `guance_gcp_gce`
2. After clicking 【Install】, input the corresponding parameters: account file name, Target Principal, account name.
3. Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.
4. After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to immediately run it once without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.


### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm that the corresponding tasks have the appropriate automatic trigger configurations, and you can view the corresponding task records and log checks for any abnormalities.
2. In <<< custom_key.brand_name >>>, under 「Infrastructure / Custom」, check if asset information exists.
3. In <<< custom_key.brand_name >>>, under 「Metrics」, check if there are corresponding monitoring data.

## Metrics {#metric}

### `gcp_gce_instance`

| Metrics | Description | Unit |
|:---|:---|:---|
| firewall_dropped_bytes_count | Total number of bytes dropped by the firewall, used to monitor firewall traffic filtering | Bytes |
| firewall_dropped_packets_count | Total number of packets dropped by the firewall, used to monitor firewall traffic filtering | Packets |
| instance_cpu_guest_visible_vcpus | Number of virtual CPUs visible to the virtual machine within the instance | Count |
| instance_cpu_reserved_cores | Number of reserved CPU cores within the instance | Count |
| instance_cpu_scheduler_wait_time | Wait time during instance CPU scheduling, used to evaluate CPU scheduling efficiency | ms |
| instance_cpu_usage_time | Accumulated usage time of the instance CPU | s |
| instance_cpu_utilization | Utilization rate of the instance CPU, indicating the degree of CPU resource usage | % |
| instance_disk_average_io_latency | Average delay time for instance disk I/O operations | ms |
| instance_disk_average_io_queue_depth | Average depth of the instance disk I/O queue, reflecting the disk I/O load situation | Count |
| instance_disk_max_read_bytes_count | Maximum number of bytes read in a single operation by the instance disk | Bytes |
| instance_disk_max_read_ops_count | Maximum number of read operations performed in a single operation by the instance disk | Operations |
| instance_disk_max_write_bytes_count | Maximum number of bytes written in a single operation by the instance disk | Bytes |
| instance_disk_max_write_ops_count | Maximum number of write operations performed in a single operation by the instance disk | Operations |
| instance_disk_provisioning_size | Configured size of the instance disk, i.e., allocated disk space | Bytes |
| instance_disk_read_bytes_count | Total number of bytes read by the instance disk | Bytes |
| instance_disk_read_ops_count | Total number of read operations performed by the instance disk | Operations |
| instance_disk_write_bytes_count | Total number of bytes written by the instance disk | Bytes |
| instance_disk_write_ops_count | Total number of write operations performed by the instance disk | Operations |
| instance_integrity_early_boot_validation_status | Integrity validation status of the instance during the early boot phase, used for security checks | Status |
| instance_integrity_late_boot_validation_status | Integrity validation status of the instance during the late boot phase, used for security checks | Status |
| instance_memory_balloon_ram_size | Size of the memory balloon (balloon) allocated within the instance | Bytes |
| instance_memory_balloon_ram_used | Size of the memory balloon already used within the instance | Bytes |
| instance_memory_balloon_swap_in_bytes_count | Total number of bytes swapped into the instance memory balloon | Bytes |
| instance_memory_balloon_swap_out_bytes_count | Total number of bytes swapped out from the instance memory balloon | Bytes |
| instance_network_received_bytes_count | Total number of bytes received by the instance network interface | Bytes |
| instance_network_received_packets_count | Total number of packets received by the instance network interface | Packets |
| instance_network_sent_bytes_count | Total number of bytes sent by the instance network interface | Bytes |
| instance_network_sent_packets_count | Total number of packets sent by the instance network interface | Packets |
| instance_uptime | Current uptime of the instance | s |
| instance_uptime_total | Total uptime of the instance (may include cumulative time after multiple startups) | s |
| mirroring_dropped_packets_count | Total number of packets dropped in mirrored traffic | Packets |
| mirroring_mirrored_bytes_count | Total number of bytes mirrored in replicated traffic | Bytes |
| mirroring_mirrored_packets_count | Total number of packets mirrored in replicated traffic | Packets |


### `gcp_vpc_network`

| Metrics | Description | Unit |
|:---|:---|:---|
| quota_instances_per_vpc_network_limit | Maximum number of instances allowed per VPC network | Count |
| quota_instances_per_vpc_network_usage | Current number of instances used per VPC network | Count |
| quota_static_routes_per_vpc_network_limit | Maximum number of static routes allowed per VPC network | Count |
| quota_static_routes_per_vpc_network_usage | Current number of static routes used per VPC network | Count |
| quota_subnet_ranges_per_vpc_network_limit | Maximum number of subnet ranges allowed per VPC network | Count |
| quota_subnet_ranges_per_vpc_network_usage | Current number of subnet ranges used per VPC network | Count |


### `gcp_compute_operation_type`

| Metrics | Description | Unit |
|:---|:---|:---|
| quota_concurrent_regional_concurrent_operations_limit | Maximum number of concurrent operations allowed per region | Count |
| quota_concurrent_regional_concurrent_operations_usage | Current number of concurrent operations used per region | Count |

## Objects {#object}

The structure of collected GCP Compute Engine object data can be viewed under 「Infrastructure - Custom」

```json
[{
	"fields": {
		"disks": "",
		"labels": "{\"goog-ops-agent-policy\": \"v2-x86-template-1-4-0\"}",
		"machine_info": "",
		"message": "",
		"network_interfaces": "",
		"scheduling": "",
		"service_accounts": "",
		"status": "RUNNING",
		"tags": "{\"fingerprint\": \"42WmSpBxxxx=\"}"
	},
	"measurement": "gcp_gce_instance",
	"tags": {
		"account_name": "liujuan",
		"cloud_provider": "gcp",
		"instance_id": "41419888103617xxxx",
		"instance_name": "instance-20250402-xxxx",
		"instance_type": "e2-medium",
		"name": "//compute.googleapis.com/projects/df-func-453606/zones/us-central1-c/instances/instance-20250402-xxxx",
		"project_id": "df-func-453606",
		"project_name": "df-func",
		"public_ipaddress": "xx.xx.xx.xx",
		"region_id": "us-central1",
		"resource_name": "//compute.googleapis.com/projects/df-func-453606/zones/us-central1-c/instances/instance-20250402-xxxx",
		"zone": "us-central1-c"
	}
}]
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
>
> Tip 1: The value of `account_name` is the name, which serves as a unique identifier.
