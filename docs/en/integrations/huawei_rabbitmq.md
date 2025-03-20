---
title: 'Huawei Cloud DMS RabbitMQ'
tags: 
  - Huawei Cloud
summary: 'Collect Huawei Cloud DMS RabbitMQ Metrics data'
__int_icon: 'icon/huawei_rabbitmq'
dashboard:
  - desc: 'Huawei Cloud RocketMQ built-in views'
    path: 'dashboard/en/huawei_rabbitmq/'

monitor:
  - desc: 'Huawei Cloud RocketMQ monitors'
    path: 'monitor/en/huawei_rabbitmq/'
---

Collect Huawei Cloud DMS RabbitMQ Metrics data

## Configuration {#config}

### Install Func

It is recommended to activate Guance integration - extension - hosted Func: all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/)

> It is recommended to deploy the GSE version.

### Install Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize the monitoring data of RabbitMQ cloud resources, we install the corresponding collection script: "Guance Integration (Huawei Cloud - RabbitMQ)" (ID: `guance_huaweicloud_rabbitmq`)

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After the script is installed, find the script "Guance Integration (Huawei Cloud - RabbitMQ)" under "Development" in Func, unfold and modify this script. Find `collector_configs` and `monitor_configs`, respectively edit the content under `region_projects`, change the region and Project ID to the actual region and Project ID, then click Save and Publish.

In addition, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the regular time. After a while, you can view the execution task records and corresponding logs.

### Verification

1. Confirm in "Management / Automatic Trigger Configuration" whether the corresponding task has the corresponding automatic trigger configuration, and at the same time, you can check the corresponding task records and logs for any abnormalities.
2. In the Guance platform, under "Infrastructure - Resource Catalog", check if there is asset information.
3. In the Guance platform, under "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}

Configure Huawei Cloud DMS RabbitMQ metrics. More metrics can be collected via configuration [Huawei Cloud DMS RabbitMQ Metrics Details](https://support.huaweicloud.com/usermanual-rabbitmq/rabbitmq-ug-180413002.html){:target="_blank"}

| **Metric ID**            |          **Metric Name**   | **Metric Meaning** | **Value Range**      | **Measurement Object** | **Monitoring Cycle (Original Metric)** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| `connections` |        Connections       | This metric counts the total number of connections in the **RabbitMQ** instance. Unit: Count      | >= 0               | **RabbitMQ** instances | 1 minute                    |
| `channels`                      |        Channels       | This metric counts the total number of channels in the **RabbitMQ** instance. Unit: Count      | 0~2047             | **RabbitMQ** instances | 1 minute                    |
| `queues`                        |        Queues       | This metric counts the total number of queues in the **RabbitMQ** instance. Unit: Count      | 0~1200             | **RabbitMQ** instances | 1 minute                    |
| `consumers`                     |       Consumers      | This metric counts the total number of consumers in the **RabbitMQ** instance. Unit: Count    | 0~1200             | **RabbitMQ** instances | 1 minute                    |
| `messages_ready`                |     Ready Messages    | This metric counts the total number of consumable messages in the **RabbitMQ** instance. Unit: Count | 0~10000000         | **RabbitMQ** instances | 1 minute                    |
| `messages_unacknowledged`       |     Unacknowledged Messages    | This metric counts the total number of consumed but unacknowledged messages in the **RabbitMQ** instance. Unit: Count | 0~10000000         | **RabbitMQ** instances | 1 minute                    |
| `publish`                       |       Publish Rate      | Counts the real-time message production rate in the **RabbitMQ** instance. Unit: Count/s        | 0~25000            | **RabbitMQ** instances | 1 minute                    |
| `deliver`                       | Consume Rate (Manual Ack) | Counts the real-time message consumption rate (manual acknowledgment) in the **RabbitMQ** instance. Unit: Count/s | 0~25000            | **RabbitMQ** instances | 1 minute                    |
| `deliver_no_ack`                | Consume Rate (Auto Ack) | Counts the real-time message consumption rate (automatic acknowledgment) in the **RabbitMQ** instance. Unit: Count/s | 0~50000            | **RabbitMQ** instances | 1 minute                    |
| `connections_states_running`    |  Running State Connections  | This metric counts the total number of connections in the starting/tuning/opening/running states across the entire instance. Unit: Count**Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >= 0               | **RabbitMQ** instances | 1 minute                    |
| `connections_states_flow`       |   Flow State Connections   | This metric counts the total number of connections in the flow state across the entire instance. Unit: Count **Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >= 0               | **RabbitMQ** instances | 1 minute                    |
| `connections_states_block`      |  Blocked State Connections   | This metric counts the total number of connections in the blocking/blocked state across the entire instance. Unit: Count **Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >= 0               | **RabbitMQ** instances | 1 minute                    |
| `connections_states_close`      |  Closed State Connections   | This metric counts the total number of connections in the closing/closed state across the entire instance. Unit: Count **Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >= 0               | **RabbitMQ** instances | 1 minute                    |
| `channels_states_running`       |   Running State Channels   | This metric counts the total number of channels in the starting/tuning/opening/running states across the entire instance. Unit: Count **Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >= 0               | **RabbitMQ** instances | 1 minute                    |
| `channels_states_flow`          |   Flow State Channels   | This metric counts the total number of channels in the flow state across the entire instance. Unit: Count **Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >= 0               | **RabbitMQ** instances | 1 minute                    |
| `channels_states_block`         |  Blocked State Channels   | This metric counts the total number of channels in the blocking/blocked state across the entire instance. Unit: Count **Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >= 0               | **RabbitMQ** instances | 1 minute                    |
| `channels_states_close`         |  Closed State Channels   | This metric counts the total number of channels in the closing/closed state across the entire instance. Unit: Count **Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >= 0               | **RabbitMQ** instances | 1 minute                    |
| `queues_states_running`         |   Running State Queues   | This metric counts the total number of queues in the running state across the entire instance. Unit: Count **Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >= 0               | **RabbitMQ** instances | 1 minute                    |
| `queues_states_flow`            |   Flow State Queues   | This metric counts the total number of queues in the flow state across the entire instance. Unit: Count **Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >= 0               | **RabbitMQ** instances | 1 minute                    |
| `fd_used`                       |      File Handles      | This metric counts the current number of file handles used by the RabbitMQ node. Unit: Count | 0~65535            | **RabbitMQ** instance nodes | 1 minute                    |
| `socket_used`                   |     Socket Connections     | This metric counts the current number of Socket connections used by the **RabbitMQ** node. Unit: Count | 0~50000            | **RabbitMQ** instance nodes | 1 minute                    |
| `proc_used`                     |     Erlang Processes     | This metric counts the current number of Erlang processes used by the **RabbitMQ** node. Unit: Count | 0~1048576          | **RabbitMQ** instance nodes | 1 minute                    |
| `mem_used`                      |       Memory Usage       | This metric counts the current memory usage of the RabbitMQ node. Unit: Byte           | 0~32000000000      | **RabbitMQ** instance nodes | 1 minute                    |
| `disk_free`                     |     Available Storage Space     | This metric counts the available storage space of the current node. Unit: Byte           | 0~500000000000     | **RabbitMQ** instance nodes | 1 minute                    |
| `rabbitmq_alive`                |     Node Alive Status     | Indicates whether the RabbitMQ node is alive. **Note:** Instances purchased on or after April 2020 support this monitoring item. | 1: Alive 0: Offline     | **RabbitMQ** instance nodes | 1 minute                    |
| `rabbitmq_disk_usage`           |    Disk Capacity Usage    | Counts the disk capacity usage rate of the RabbitMQ virtual machine node. Unit: % **Note:** Instances purchased on or after April 2020 support this monitoring item. | 0~100%             | RabbitMQ instance nodes | 1 minute                    |
| `rabbitmq_cpu_usage`            |      CPU Usage       | Counts the CPU usage rate of the RabbitMQ virtual machine node. Unit: % **Note:** Instances purchased on or after April 2020 support this monitoring item. | 0~100%             | RabbitMQ instance nodes | 1 minute                    |
| `rabbitmq_cpu_core_load`        |     Average CPU Core Load      | Counts the average load per core of the CPU on the RabbitMQ virtual machine node. **Note:** Instances purchased on or after April 2020 support this monitoring item. | >0                 | RabbitMQ instance nodes | 1 minute                    |
| `rabbitmq_memory_usage`         |      Memory Usage      | Counts the memory usage rate of the RabbitMQ virtual machine node. Unit: % **Note:** Instances purchased on or after April 2020 support this monitoring item. | 0~100%             | RabbitMQ instance nodes | 1 minute                    |
| `rabbitmq_disk_read_await`      |  Average Disk Read Operation Time  | This metric counts the average operation time for each read IO during the measurement cycle. Unit: ms **Note:** Instances purchased on or after June 2020 support this monitoring item. | >0                 | RabbitMQ instance nodes | 1 minute                    |
| `rabbitmq_disk_write_await`     |  Average Disk Write Operation Time  | This metric counts the average operation time for each write IO during the measurement cycle. Unit: ms **Note:** Instances purchased on or after June 2020 support this monitoring item. | >0                 | RabbitMQ instance nodes | 1 minute                    |
| `rabbitmq_node_bytes_in_rate`   |      Network Inbound Traffic      | Counts the network inbound traffic per second for the RabbitMQ node. Unit: Byte/s **Note:** Instances purchased on or after June 2020 support this monitoring item. | >0                 | RabbitMQ instance nodes | 1 minute                    |
| `rabbitmq_node_bytes_out_rate`  |      Network Outbound Traffic      | Counts the network outbound traffic per second for the RabbitMQ node. Unit: Byte/s **Note:** Instances purchased on or after June 2020 support this monitoring item. | >0                 | RabbitMQ instance nodes | 1 minute                    |
| `rabbitmq_node_queues`          |      Node Queue Count      | This metric counts the number of queues on the RabbitMQ node. Unit: Count **Note:** Instances purchased on or after June 2020 support this monitoring item. | >0                 | RabbitMQ instance nodes | 1 minute                    |
| `rabbitmq_memory_high_watermark` |    High Memory Watermark Status    | Indicates whether the RabbitMQ node has triggered the high memory watermark. If triggered, it will block all producers in the cluster. **Note:** Instances purchased on or after June 2020 support this monitoring item. | 1: Triggered 0: Not Triggered | RabbitMQ instance nodes | 1 minute                    |
| `rabbitmq_disk_insufficient`    |    High Disk Watermark Status    | Indicates whether the RabbitMQ node has triggered the high disk watermark. If triggered, it will block all producers in the cluster. **Note:** Instances purchased on or after June 2020 support this monitoring item. | 1: Triggered 0: Not Triggered | RabbitMQ instance nodes | 1 minute                    |
| `rabbitmq_disk_read_rate`       |      Disk Read Throughput      | Counts the number of bytes read per second from the disk node. Unit: KB/s **Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >= 0               | RabbitMQ instance nodes | 1 minute                    |
| `rabbitmq_disk_write_rate`      |      Disk Write Throughput      | Counts the number of bytes written per second to the disk node. Unit: KB/s **Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >= 0               | RabbitMQ instance nodes | 1 minute                    |
| `queue_messages_unacknowledged` |   Unacknowledged Messages in Queue   | This metric counts the number of consumed but unacknowledged messages in the queue. Unit: Count          | 0~10000000         | RabbitMQ instance queues | 1 minute                    |
| `queue_messages_ready`          |   Ready Messages in Queue   | This metric counts the number of consumable messages in the queue. Unit: Count              | 0~10000000         | RabbitMQ instance queues | 1 minute                    |
| `queue_consumers`               |      Consumer Count      | This metric counts the number of consumers subscribed to the queue. Unit: Count **Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >= 0               | RabbitMQ instance queues | 1 minute                    |
| `queue_messages_publish_rate`   |       Publish Rate       | This metric counts the number of messages flowing into the queue per second. Unit: Count/s **Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >= 0               | RabbitMQ instance queues | 1 minute                    |
| `queue_messages_ack_rate`       | Consume Rate (Manual Ack) | This metric counts the number of messages passed to the client and acknowledged per second for the queue. Unit: Count/s **Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >= 0               | RabbitMQ instance queues | 1 minute                    |
| `queue_messages_deliver_get_rate` |       Consume Rate       | This metric counts the number of messages flowing out of the queue per second. Unit: Count/s **Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >= 0               | RabbitMQ instance queues | 1 minute                    |
| `queue_messages_redeliver_rate` |       Redelivery Rate       | This metric counts the number of redelivered messages per second for the queue. Unit: Count/s **Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >= 0               | RabbitMQ instance queues | 1 minute                    |
| `queue_messages_persistent`     |  Total Persistent Messages  | This metric counts the total number of persistent messages in the queue (always 0 for transient queues). Unit: Count **Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >= 0               | RabbitMQ instance queues | 1 minute                    |
| `queue_messages_ram`            |   Total Messages in RAM   | This metric counts the total number of messages residing in RAM in the queue. Unit: Count **Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >= 0               | RabbitMQ instance queues | 1 minute                    |
| `queue_memory`                  | Erlang Process Consumed Bytes | This metric counts the memory bytes consumed by the Erlang process associated with the queue, including stack, heap, and internal structures. Unit: Byte **Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >= 0               | RabbitMQ instance queues | 1 minute                    |
| `queue_message_bytes`           |     Total Message Size     | This metric counts the total size (in bytes) of all messages in the queue. Unit: Byte **Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >= 0               | RabbitMQ instance queues | 1 minute                    |

## Objects {#object}

After data synchronization is normal, you can view the data in the "Infrastructure - Resource Catalog" of Guance.

```json
{
  "measurement": "huaweicloud_rabbitmq",
  "tags": {
    "RegionId"              : "cn-north-4",
    "project_id"            : "756ada1aa17e4049b2a16ea41912e52d",
    "enterprise_project_id" : "o78hhbss-xxxx-xxxx-xxxx-cba3d38cf2f9",
    "instance_id"           : "c0b0ea90-xxxx-xxxx-xxxx-cba3d38cf2f9",
    "instance_name"         : "rabbitmq-xxxx",
    "engine"                : "rabbitmq",
    "status"                : "RUNNING"
  },
  "fields": {
    "charging_mode"             :     "1",
    "engine"                    : "rabbitmq",
    "engine_version"            : "3.8.35",
    "connect_address"           : "192.xxx.0.xxx",
    "description"               : "",
    "specification"             : "rabbitmq.2u4g.single * 1 broker",
    "storage_space"             : 83,
    "used_storage_space"        : 0,
    "access_user"               : "rabbit_mh",
    "resource_spec_code"        : "",
    "created_at"                : "1687143955266",
    "maintain_begin"            : "02:00:00",
    "maintain_end"              : "06:00:00",
    "enable_publicip"           : false,
    "publicip_address"          : "127.xx.xx.34",
    "publicip_id"               : "xxxxxxxxxxx",
    "management_connect_address": "http://192.xxx.0.xxx:15672",  
    "storage_space"             : 83,
    "available_zones"           : "[Instance JSON Data]"
  }
}

```

Descriptions of some fields are as follows:

| Field                 | Type   | Description                                                         |
| :------------------- | :----- | :----------------------------------------------------------- |
| `specification`      | String | Instance specification. RabbitMQ single-instance returns VM specifications. RabbitMQ cluster returns VM specifications and the number of nodes. |
| `charging_mode`      | String | Billing mode, 1 indicates pay-as-you-go billing, 0 indicates annual/monthly billing.                |
| `available_zones`    | String | The availability zone where the instance nodes are located, returning “Availability Zone ID”.                       |
| `maintain_begin`     | String | Start time of the maintenance window, format HH:mm:ss                           |
| `maintain_end`       | String | End time of the maintenance window, format HH:mm:ss                           |
| `created_at`         | String | Completion creation time. Format is timestamp, indicating the total milliseconds deviation from Greenwich Mean Time January 01, 1970 00:00:00 to the specified time. |
| `resource_spec_code` | String | Resource specification identifier `dms.instance.rabbitmq.single.c3.2u4g`: RabbitMQ single-node, VM specification 2u4g `dms.instance.rabbitmq.single.c3.4u8g`: RabbitMQ single-node, VM specification 4u8g `dms.instance.rabbitmq.single.c3.8u16g`: RabbitMQ single-node, VM specification 8u16g `dms.instance.rabbitmq.single.c3.16u32g`: RabbitMQ single-node, VM specification 16u32g `dms.instance.rabbitmq.cluster.c3.4u8g.3`: RabbitMQ cluster, VM specification 4u8g, 3 nodes `dms.instance.rabbitmq.cluster.c3.4u8g.5`: RabbitMQ cluster, VM specification 4u8g, 5 nodes `dms.instance.rabbitmq.cluster.c3.4u8g.7`: RabbitMQ cluster, VM specification 4u8g, 7 nodes `dms.instance.rabbitmq.cluster.c3.8u16g.3`: RabbitMQ cluster, VM specification 8u16g, 3 nodes `dms.instance.rabbitmq.cluster.c3.8u16g.5`: RabbitMQ cluster, VM specification 8u16g, 5 nodes `dms.instance.rabbitmq.cluster.c3.8u16g.7`: RabbitMQ cluster, VM specification 8u16g, 7 nodes `dms.instance.rabbitmq.cluster.c3.16u32g.3`: RabbitMQ cluster, VM specification 16u32g, 3 nodes `dms.instance.rabbitmq.cluster.c3.16u32g.5`: RabbitMQ cluster, VM specification 16u32g, 5 nodes `dms.instance.rabbitmq.cluster.c3.16u32g.7`: RabbitMQ cluster, VM specification 16u32g, 7 nodes |

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.instance_id` is the instance ID, used as unique identification
>