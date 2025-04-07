---
title: 'GCP Compute Engine'
tags: 
  - GCP
summary: '采集 GCP Compute Engine 虚拟机CPU、内存、磁盘、网络等资源指标'
__int_icon: 'icon/gcp_ce'
dashboard:
  - desc: 'GCP Compute Engine'
    path: 'dashboard/zh/gcp_ce'

---


<!-- markdownlint-disable MD025 -->
# GCP Compute Engine
<!-- markdownlint-enable -->

采集 GCP Compute Engine 虚拟机 CPU、内存、磁盘、网络等资源指标


## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考[自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### GCP 客户端授权

在安装脚本前需要开通授权方式，参考[GCP 客户端授权](https://func.guance.com/doc/script-market-guance-gcp-client-credential/){:target="_blank"}文档

### 安装脚本

1. 登陆Func 控制台，点击【脚本市场】，进入官方脚本市场，搜索 `guance_gcp_gce`

2. 点击【安装】后，输入相应的参数：账户文件名、Target Principal、帐号名

3. 点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

4. 开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}

### `gcp_gce_instance`

| 指标 | 描述信息 | 单位 |
|:---|:---|:---|
| firewall_dropped_bytes_count | 防火墙丢弃的数据包总字节数，用于监控防火墙过滤流量的情况 | Bytes |
| firewall_dropped_packets_count | 防火墙丢弃的数据包总数，用于监控防火墙过滤流量的情况 | Packets |
| instance_cpu_guest_visible_vcpus | 实例中对虚拟机可见的虚拟CPU数量 | Count |
| instance_cpu_reserved_cores | 实例中预留的CPU核心数量 | Count |
| instance_cpu_scheduler_wait_time | 实例CPU调度时的等待时间，用于评估CPU调度效率 | ms |
| instance_cpu_usage_time | 实例CPU的累计使用时间 | s |
| instance_cpu_utilization | 实例CPU的利用率，表示CPU资源的使用程度 | % |
| instance_disk_average_io_latency | 实例磁盘I/O操作的平均延迟时间 | ms |
| instance_disk_average_io_queue_depth | 实例磁盘I/O队列的平均深度，反映磁盘I/O负载情况 | Count |
| instance_disk_max_read_bytes_count | 实例磁盘单次读取操作的最大字节数 | Bytes |
| instance_disk_max_read_ops_count | 实例磁盘单次读取操作的最大操作次数 | Operations |
| instance_disk_max_write_bytes_count | 实例磁盘单次写入操作的最大字节数 | Bytes |
| instance_disk_max_write_ops_count | 实例磁盘单次写入操作的最大操作次数 | Operations |
| instance_disk_provisioning_size | 实例磁盘的配置大小，即分配的磁盘空间 | Bytes |
| instance_disk_read_bytes_count | 实例磁盘读取操作的总字节数 | Bytes |
| instance_disk_read_ops_count | 实例磁盘读取操作的总次数 | Operations |
| instance_disk_write_bytes_count | 实例磁盘写入操作的总字节数 | Bytes |
| instance_disk_write_ops_count | 实例磁盘写入操作的总次数 | Operations |
| instance_integrity_early_boot_validation_status | 实例在早期启动阶段的完整性验证状态，用于安全检查 | Status |
| instance_integrity_late_boot_validation_status | 实例在后期启动阶段的完整性验证状态，用于安全检查 | Status |
| instance_memory_balloon_ram_size | 实例中内存气球（balloon）分配的内存大小 | Bytes |
| instance_memory_balloon_ram_used | 实例中内存气球已使用的内存大小 | Bytes |
| instance_memory_balloon_swap_in_bytes_count | 实例内存气球交换入操作的总字节数 | Bytes |
| instance_memory_balloon_swap_out_bytes_count | 实例内存气球交换出操作的总字节数 | Bytes |
| instance_network_received_bytes_count | 实例网络接口接收的数据总字节数 | Bytes |
| instance_network_received_packets_count | 实例网络接口接收的数据包总数 | Packets |
| instance_network_sent_bytes_count | 实例网络接口发送的数据总字节数 | Bytes |
| instance_network_sent_packets_count | 实例网络接口发送的数据包总数 | Packets |
| instance_uptime | 实例的当前运行时间 | s |
| instance_uptime_total | 实例的总运行时间（可能包括多次启动后的累计时间） | s |
| mirroring_dropped_packets_count | 镜像流量中丢弃的数据包总数 | Packets |
| mirroring_mirrored_bytes_count | 镜像复制的数据总字节数 | Bytes |
| mirroring_mirrored_packets_count | 镜像复制的数据包总数 | Packets |


### `gcp_vpc_network`

| 指标 | 描述信息 | 单位 |
|:---|:---|:---|
| quota_instances_per_vpc_network_limit | 每个VPC网络允许的最大实例数量限制 | Count |
| quota_instances_per_vpc_network_usage | 每个VPC网络当前使用的实例数量 | Count |
| quota_static_routes_per_vpc_network_limit | 每个VPC网络允许的最大静态路由数量限制 | Count |
| quota_static_routes_per_vpc_network_usage | 每个VPC网络当前使用的静态路由数量 | Count |
| quota_subnet_ranges_per_vpc_network_limit | 每个VPC网络允许的最大子网范围数量限制 | Count |
| quota_subnet_ranges_per_vpc_network_usage | 每个VPC网络当前使用的子网范围数量 | Count |


### `gcp_compute_operation_type`

| 指标 | 描述信息 | 单位 |
|:---|:---|:---|
| quota_concurrent_regional_concurrent_operations_limit | 每个区域允许的最大并发操作数量限制 | Count |
| quota_concurrent_regional_concurrent_operations_usage | 每个区域当前使用的并发操作数量 | Count |

## 对象 {#object}

采集到的 GCP Compute Engine 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

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

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
>
> 提示 1：`account_name`值为名称，作为唯一识别.
