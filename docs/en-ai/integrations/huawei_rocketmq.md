---
title: 'Huawei Cloud DMS RocketMQ'
tags: 
  - Huawei Cloud
summary: 'Use the "Guance Cloud Sync" series of script packages from the script market to synchronize cloud monitoring and cloud asset data to Guance.'
__int_icon: 'icon/huawei_rocketmq'
dashboard:
  - desc: 'Huawei Cloud RocketMQ built-in views'
    path: 'dashboard/en/huawei_rocketmq/'

monitor:
  - desc: 'Huawei Cloud RocketMQ monitor'
    path: 'monitor/en/huawei_rocketmq/'
---


<!-- markdownlint-disable MD025 -->
# Huawei Cloud DMS RocketMQ
<!-- markdownlint-enable -->

Use the "Guance Cloud Sync" series of script packages from the script market to synchronize cloud monitoring and cloud asset data to Guance.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - Extensions - DataFlux Func (Automata): All prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/)

> We recommend deploying the GSE version.

### Install Script

> Note: Prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize the monitoring data of Huawei Cloud RocketMQ resources, install the corresponding collection script: "Guance Integration (Huawei Cloud - RocketMQ)" (ID: `guance_huaweicloud_rocketmq`).

Click [Install], then enter the required parameters: Huawei Cloud AK and Huawei Cloud account name.

Click [Deploy Startup Script], and the system will automatically create a `Startup` script set and configure the startup scripts accordingly.

After the script is installed, find the script "Guance Integration (Huawei Cloud - RocketMQ)" under "Development" in Func, expand and modify this script. Edit the content of `region_projects` in `collector_configs` and `monitor_configs`, changing the region and Project ID to the actual ones, then click Save and Publish.

Additionally, in "Management / Automatic Trigger Configuration," you can see the corresponding automatic trigger configuration. Click [Execute] to run it immediately without waiting for the scheduled time. After a short wait, you can view the task execution records and corresponding logs.

We default collect some configurations; see the Metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-rocketmq/){:target="_blank"}

### Verification

1. In "Management / Automatic Trigger Configuration," confirm whether the corresponding tasks have the automatic trigger configuration and check the task records and logs for any anomalies.
2. On the Guance platform, go to "Infrastructure / Custom" to check if asset information exists.
3. On the Guance platform, go to "Metrics" to check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Huawei Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics by configuring them. [Huawei Cloud Cloud Monitoring Metrics Details](https://support.huaweicloud.com/usermanual-hrm/hrm-ug-018.html){:target="_blank"}

| **Metric ID**            |          **Metric Name**   | **Metric Meaning** | **Value Range**      | **Measurement Object** | **Monitoring Period (Original Metric)** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| instance_produce_msg |        Message Production Count        | Number of messages received by the instance per minute (unit: Count) | >0 | RocketMQ Instance     | 1 minute    |
| instance_consume_msg | Message Consumption Count | Number of messages consumed by the instance per minute (unit: Count) | >0 | RocketMQ Instance     | 1 minute |
| current_topics | Topic Count | Number of topics in the instance (unit: Count)![]()**Note:** Instances purchased on or after May 16, 2022, support this monitoring item. | >=0 | RocketMQ Instance     | 1 minute |
| current_queues | Queue Count | Number of queues in the instance (unit: Count)![]()**Note:** Instances purchased on or after May 16, 2022, support this monitoring item. | >=0 | RocketMQ Instance     | 1 minute |
| instance_accumulation | Accumulated Message Count | Sum of accumulated messages across all consumer groups (unit: Count)![]()**Note:** Instances purchased on or after May 16, 2022, support this monitoring item. | >=0 | RocketMQ Instance     | 1 minute |
| broker_produce_msg | Message Production Count | Number of messages received by the node per minute (unit: Count) | >0 | RocketMQ Instance Node | 1 minute |
| broker_consume_msg | Message Consumption Count | Number of messages consumed by the node per minute (unit: Count) | >0 | RocketMQ Instance Node | 1 minute |
| broker_produce_rate | Message Production Rate | Number of messages received by the node per second (unit: Count/s) | >0 | RocketMQ Instance Node | 1 minute |
| broker_consume_rate | Message Consumption Rate | Number of messages consumed by the node per second (unit: Count/s) | >0 | RocketMQ Instance Node | 1 minute |
| broker_total_bytes_in_rate | Network Inbound Traffic | Network inbound traffic rate per second (unit: Byte/s) | >0 | RocketMQ Instance Node | 1 minute |
| broker_total_bytes_out_rate | Network Outbound Traffic | Network outbound traffic rate per second (unit: Byte/s) | >0 | RocketMQ Instance Node | 1 minute |
| broker_cpu_core_load | CPU Core Load | Average load per virtual machine CPU core | >0 | RocketMQ Instance Node | 1 minute |
| broker_disk_usage | Disk Usage Rate | Disk usage rate of the virtual machine (unit: %) | 0~100 | RocketMQ Instance Node | 1 minute |
| broker_memory_usage | Memory Usage Rate | Memory usage rate of the virtual machine (unit: %) | 0~100 | RocketMQ Instance Node | 1 minute |
| broker_alive | Node Status | Node status![]()**Note:** Instances purchased on or after May 16, 2022, support this monitoring item. | 1: Alive 0: Offline | RocketMQ Instance Node | 1 minute |
| broker_connections | Connection Count | Number of connections used by the virtual machine (unit: Count)![]()**Note:** Instances purchased on or after May 16, 2022, support this monitoring item. | >=0 | RocketMQ Instance Node | 1 minute |
| broker_cpu_usage | CPU Usage Rate | CPU usage rate of the virtual machine (unit: %)![]()**Note:** Instances purchased on or after May 16, 2022, support this monitoring item. | >=0 | RocketMQ Instance Node | 1 minute |
| broker_disk_read_rate | Disk Read Traffic | Disk read operation traffic (unit: Byte/s)![]()**Note:** Instances purchased on or after May 16, 2022, support this monitoring item. | >=0 | RocketMQ Instance Node | 1 minute |
| broker_disk_write_rate | Disk Write Traffic | Disk write operation traffic (unit: Byte/s)![]()**Note:** Instances purchased on or after May 16, 2022, support this monitoring item. | >=0 | RocketMQ Instance Node | 1 minute |
| topic_produce_msg | Message Production Count | Number of messages received by the Topic per minute (unit: Count) | >0 | RocketMQ Instance Queue | 1 minute |
| topic_consume_msg | Message Consumption Count | Number of messages consumed by the Topic per minute (unit: Count) | >0 | RocketMQ Instance Queue | 1 minute |
| topic_produce_rate | Message Production Rate | Number of messages received by the Topic per second (unit: Count/s) | >0 | RocketMQ Instance Queue | 1 minute |
| topic_consume_rate | Message Consumption Rate | Number of messages consumed by the Topic per second (unit: Count/s) | >0 | RocketMQ Instance Queue | 1 minute |
| topic_bytes_in_rate | Production Traffic | Production traffic of the current Topic (unit: Byte/s)![]()**Note:** Instances purchased on or after May 16, 2022, support this monitoring item. | >=0 | RocketMQ Instance Queue | 1 minute |
| topic_bytes_out_rate | Consumption Traffic | Consumption traffic of the current Topic (unit: Byte/s)![]()**Note:** Instances purchased on or after May 16, 2022, support this monitoring item. | >=0 | RocketMQ Instance Queue | 1 minute |

## Objects {#object}

After data synchronization is successful, you can view the data in the "Infrastructure / Custom (Objects)" section of Guance.

```json
{
  "measurement": "huaweicloud_rocketmq",
  "tags": {      
    "RegionId"      : "cn-north-4",
    "charging_mode" : "1",
    "engine"        : "reliability",
    "engine_version": "4.8.0",
    "instance_id"   : "c0b0ea90-xxxx-xxxx-xxxx-cba3d38cf2f9",
    "instance_name" : "rocketmq-xxxxx",
    "name"          : "c0b0ea90-xxxx-xxxx-xxxx-cba3d38cf2f9",
    "status"        : "RUNNING",
    "type"          : "cluster.small"
  },
  "fields": {
    "created_at"         : "1687158517888",
    "description"        : "",
    "enable_publicip"    : false,
    "maintain_begin"     : "02:00:00",
    "maintain_end"       : "06:00:00",
    "resource_spec_code" : "",
    "specification"      : "rocketmq.4u8g.cluster.small * 1 broker",
    "storage_space"      : 250,
    "total_storage_space": 300,
    "used_storage_space" : 0,
    "message"            : "{Instance JSON data}"
  }
}
```

Some field explanations are as follows:

| Field                 | Type   | Description                                                         |
| :------------------- | :----- | :----------------------------------------------------------- |
| `specification`      | String | Instance specification.                                                   |
| `charging_mode`      | String | Billing mode, 1 indicates pay-as-you-go, 0 indicates subscription billing.                |
| `created_at`         | String | Completion creation time. Format is timestamp, representing the total milliseconds deviation from Greenwich Mean Time January 1, 1970 00:00:00 to the specified time. |
| `resource_spec_code` | String | Resource specification                                                     |
| `maintain_begin`     | String | Maintenance window start time, format HH:mm:ss                           |
| `maintain_end`       | String | Maintenance window end time, format HH:mm:ss                           |

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, used as a unique identifier.
>
> Tip 2:
>
> - `fields.message`, `fields.listeners` are serialized JSON strings.
> - `tags.operating_status` represents the operational status of the load balancer. Possible values: ONLINE and FROZEN.