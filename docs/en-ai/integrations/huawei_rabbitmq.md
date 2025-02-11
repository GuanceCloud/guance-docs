---
title: 'Huawei Cloud DMS RabbitMQ'
tags: 
  - Huawei Cloud
summary: 'Use the "Guance Cloud Sync" series of script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance.'
__int_icon: 'icon/huawei_rabbitmq'
dashboard:
  - desc: 'Huawei Cloud RocketMQ built-in view'
    path: 'dashboard/en/huawei_rabbitmq/'

monitor:
  - desc: 'Huawei Cloud RocketMQ monitor'
    path: 'monitor/en/huawei_rabbitmq/'
---


<!-- markdownlint-disable MD025 -->
# Huawei Cloud DMS RabbitMQ
<!-- markdownlint-enable -->

Use the "Guance Cloud Sync" series of script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/)

> We recommend deploying the GSE version

### Install Script

> Note: Prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize the monitoring data of RabbitMQ cloud resources, we install the corresponding collection script: "Guance Integration (Huawei Cloud - RabbitMQ)" (ID: `guance_huaweicloud_rabbitmq`)

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK, Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script automatically.

After the script is installed, find the script "Guance Integration (Huawei Cloud - RabbitMQ)" under "Development" in Func, expand and modify this script, locate `collector_configs`, change the regions after `regions` to your actual region, then find `monitor_configs` under `region_projects`, change it to the actual region and Project ID. Then click save and publish.

Additionally, in "Management / Automatic Trigger Configuration", you can see the corresponding automatic trigger configuration. Click 【Execute】 to execute immediately without waiting for the scheduled time. After a while, you can check the execution task records and corresponding logs.

By default, we collect some configurations, see the Metrics section for details.

[Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-rabbitmq/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and check the corresponding task records and logs for any abnormalities.
2. On the Guance platform, in "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, in "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Huawei Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration [Huawei Cloud Cloud Monitoring Metric Details](https://support.huaweicloud.com/usermanual-rabbitmq/rabbitmq-ug-180413002.html){:target="_blank"}


| **Metric ID**            |          **Metric Name**   | **Metric Meaning** | **Value Range**      | **Measurement Object** | **Monitoring Period (Raw Metrics)** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| `connections` |        Connections        | This metric counts the total number of connections in the **RabbitMQ** instance. Unit: Count      | >= 0               | **RabbitMQ** instance | 1 minute                    |
| `channels`                      |        Channels        | This metric counts the total number of channels in the **RabbitMQ** instance. Unit: Count      | 0~2047             | **RabbitMQ** instance | 1 minute                    |
| `queues`                        |        Queues        | This metric counts the total number of queues in the **RabbitMQ** instance. Unit: Count      | 0~1200             | **RabbitMQ** instance | 1 minute                    |
| `consumers`                     |       Consumers       | This metric counts the total number of consumers in the **RabbitMQ** instance. Unit: Count    | 0~1200             | **RabbitMQ** instance | 1 minute                    |
| `messages_ready`                |     Ready Messages     | This metric counts the total number of ready messages in the **RabbitMQ** instance. Unit: Count | 0~10000000         | **RabbitMQ** instance | 1 minute                    |
| `messages_unacknowledged`       |     Unacknowledged Messages     | This metric counts the total number of consumed but unacknowledged messages in the **RabbitMQ** instance. Unit: Count | 0~10000000         | **RabbitMQ** instance | 1 minute                    |
| `publish`                       |       Publish Rate       | This metric counts the real-time message production rate in the **RabbitMQ** instance. Unit: Count/s        | 0~25000            | **RabbitMQ** instance | 1 minute                    |
| `deliver`                       | Deliver Rate (Manual Ack) | This metric counts the real-time message consumption rate (manual acknowledgment) in the **RabbitMQ** instance. Unit: Count/s | 0~25000            | **RabbitMQ** instance | 1 minute                    |
| `deliver_no_ack`                | Deliver Rate (Auto Ack) | This metric counts the real-time message consumption rate (automatic acknowledgment) in the **RabbitMQ** instance. Unit: Count/s | 0~50000            | **RabbitMQ** instance | 1 minute                    |
| `connections_states_running`    |  Number of Running Connections  | This metric counts the total number of connections in the entire instance where the state is starting/tuning/opening/running. Unit: Count **Note:** Instances purchased on or after May 16, 2022 support this metric. | >= 0               | **RabbitMQ** instance | 1 minute                    |
| `connections_states_flow`       |   Number of Flow State Connections   | This metric counts the total number of connections in the entire instance where the state is flow. Unit: Count **Note:** Instances purchased on or after May 16, 2022 support this metric. | >= 0               | **RabbitMQ** instance | 1 minute                    |
| `connections_states_block`      |  Number of Blocking/Blocked Connections   | This metric counts the total number of connections in the entire instance where the state is blocking/blocked. Unit: Count **Note:** Instances purchased on or after May 16, 2022 support this metric. | >= 0               | **RabbitMQ** instance | 1 minute                    |
| `connections_states_close`      |  Number of Closing/Closed Connections   | This metric counts the total number of connections in the entire instance where the state is closing/closed. Unit: Count **Note:** Instances purchased on or after May 16, 2022 support this metric. | >= 0               | **RabbitMQ** instance | 1 minute                    |
| `channels_states_running`       |   Number of Running Channels   | This metric counts the total number of channels in the entire instance where the state is starting/tuning/opening/running. Unit: Count **Note:** Instances purchased on or after May 16, 2022 support this metric. | >= 0               | **RabbitMQ** instance | 1 minute                    |
| `channels_states_flow`          |   Number of Flow State Channels   | This metric counts the total number of channels in the entire instance where the state is flow. Unit: Count **Note:** Instances purchased on or after May 16, 2022 support this metric. | >= 0               | **RabbitMQ** instance | 1 minute                    |
| `channels_states_block`         |  Number of Blocking/Blocked Channels   | This metric counts the total number of channels in the entire instance where the state is blocking/blocked. Unit: Count **Note:** Instances purchased on or after May 16, 2022 support this metric. | >= 0               | **RabbitMQ** instance | 1 minute                    |
| `channels_states_close`         |  Number of Closing/Closed Channels   | This metric counts the total number of channels in the entire instance where the state is closing/closed. Unit: Count **Note:** Instances purchased on or after May 16, 2022 support this metric. | >= 0               | **RabbitMQ** instance | 1 minute                    |
| `queues_states_running`         |   Number of Running Queues   | This metric counts the total number of queues in the entire instance where the state is running. Unit: Count **Note:** Instances purchased on or after May 16, 2022 support this metric. | >= 0               | **RabbitMQ** instance | 1 minute                    |
| `queues_states_flow`            |   Number of Flow State Queues   | This metric counts the total number of queues in the entire instance where the state is flow. Unit: Count **Note:** Instances purchased on or after May 16, 2022 support this metric. | >= 0               | **RabbitMQ** instance | 1 minute                    |
| `fd_used`                       |      File Handles      | This metric counts the number of file handles used by the current node's RabbitMQ. Unit: Count | 0~65535            | **RabbitMQ** instance node | 1 minute                    |
| `socket_used`                   |     Socket Connections     | This metric counts the number of Socket connections used by the current node's **RabbitMQ**. Unit: Count | 0~50000            | **RabbitMQ** instance node | 1 minute                    |
| `proc_used`                     |     Erlang Processes     | This metric counts the number of Erlang processes used by the current node's **RabbitMQ**. Unit: Count | 0~1048576          | **RabbitMQ** instance node | 1 minute                    |
| `mem_used`                      |       Memory Usage       | This metric counts the memory usage of the current node's RabbitMQ. Unit: Byte           | 0~32000000000      | **RabbitMQ** instance node | 1 minute                    |
| `disk_free`                     |     Available Storage Space     | This metric counts the available storage space of the current node. Unit: Byte           | 0~500000000000     | **RabbitMQ** instance node | 1 minute                    |
| `rabbitmq_alive`                |     Node Status     | Indicates whether the RabbitMQ node is alive. **Note:** Instances purchased on or after April 2020 support this metric. | 1: Alive 0: Offline     | **RabbitMQ** instance node | 1 minute                    |
| `rabbitmq_disk_usage`           |    Disk Usage Percentage    | This metric counts the disk usage percentage of the RabbitMQ node virtual machine. Unit: % **Note:** Instances purchased on or after April 2020 support this metric. | 0~100%             | RabbitMQ instance node | 1 minute                    |
| `rabbitmq_cpu_usage`            |      CPU Usage       | This metric counts the CPU usage of the RabbitMQ node virtual machine. Unit: % **Note:** Instances purchased on or after April 2020 support this metric. | 0~100%             | RabbitMQ instance node | 1 minute                    |
| `rabbitmq_cpu_core_load`        |     Average CPU Core Load      | This metric counts the average load per CPU core of the RabbitMQ node virtual machine. **Note:** Instances purchased on or after April 2020 support this metric. | >0                 | RabbitMQ instance node | 1 minute                    |
| `rabbitmq_memory_usage`         |      Memory Usage      | This metric counts the memory usage of the RabbitMQ node virtual machine. Unit: % **Note:** Instances purchased on or after April 2020 support this metric. | 0~100%             | RabbitMQ instance node | 1 minute                    |
| `rabbitmq_disk_read_await`      |  Average Disk Read Operation Time  | This metric counts the average duration of each read IO operation during the measurement period. Unit: ms **Note:** Instances purchased on or after June 2020 support this metric. | >0                 | RabbitMQ instance node | 1 minute                    |
| `rabbitmq_disk_write_await`     |  Average Disk Write Operation Time  | This metric counts the average duration of each write IO operation during the measurement period. Unit: ms **Note:** Instances purchased on or after June 2020 support this metric. | >0                 | RabbitMQ instance node | 1 minute                    |
| `rabbitmq_node_bytes_in_rate`   |      Network Inbound Traffic      | This metric counts the network inbound traffic per second of the RabbitMQ node. Unit: Byte/s **Note:** Instances purchased on or after June 2020 support this metric. | >0                 | RabbitMQ instance node | 1 minute                    |
| `rabbitmq_node_bytes_out_rate`  |      Network Outbound Traffic      | This metric counts the network outbound traffic per second of the RabbitMQ node. Unit: Byte/s **Note:** Instances purchased on or after June 2020 support this metric. | >0                 | RabbitMQ instance node | 1 minute                    |
| `rabbitmq_node_queues`          |      Number of Node Queues      | This metric counts the number of queues in the RabbitMQ node. Unit: Count  **Note:** Instances purchased on or after June 2020 support this metric. | >0                 | RabbitMQ instance node | 1 minute                    |
| `rabbitmq_memory_high_watermark` |    High Watermark Memory Status    | Indicates whether the RabbitMQ node has triggered high watermark memory, which would block all producers in the cluster. **Note:** Instances purchased on or after June 2020 support this metric. | 1: Triggered 0: Not Triggered | RabbitMQ instance node | 1 minute                    |
| `rabbitmq_disk_insufficient`    |    High Watermark Disk Status    | Indicates whether the RabbitMQ node has triggered high watermark disk, which would block all producers in the cluster. **Note:** Instances purchased on or after June 2020 support this metric. | 1: Triggered 0: Not Triggered | RabbitMQ instance node | 1 minute                    |
| `rabbitmq_disk_read_rate`       |      Disk Read Throughput      | This metric counts the disk read throughput in bytes per second of the node. Unit: KB/s **Note:** Instances purchased on or after May 16, 2022 support this metric. | >= 0               | RabbitMQ instance node | 1 minute                    |
| `rabbitmq_disk_write_rate`      |      Disk Write Throughput      | This metric counts the disk write throughput in bytes per second of the node. Unit: KB/s **Note:** Instances purchased on or after May 16, 2022 support this metric. | >= 0               | RabbitMQ instance node | 1 minute                    |
| `queue_messages_unacknowledged` |   Queue Unacknowledged Messages   | This metric counts the number of consumed but unacknowledged messages in the queue. Unit: Count          | 0~10000000         | RabbitMQ instance queue | 1 minute                    |
| `queue_messages_ready`          |   Queue Ready Messages   | This metric counts the number of ready messages in the queue. Unit: Count              | 0~10000000         | RabbitMQ instance queue | 1 minute                    |
| `queue_consumers`               |      Number of Consumers      | This metric counts the number of consumers subscribed to the queue. Unit: Count **Note:** Instances purchased on or after May 16, 2022 support this metric. | >= 0               | RabbitMQ instance queue | 1 minute                    |
| `queue_messages_publish_rate`   |       Publish Rate       | This metric counts the number of messages flowing into the queue per second. Unit: Count/s **Note:** Instances purchased on or after May 16, 2022 support this metric. | >= 0               | RabbitMQ instance queue | 1 minute                    |
| `queue_messages_ack_rate`       | Deliver Rate (Manual Ack) | This metric counts the number of messages delivered to clients and acknowledged per second. Unit: Count/s **Note:** Instances purchased on or after May 16, 2022 support this metric. | >= 0               | RabbitMQ instance queue | 1 minute                    |
| `queue_messages_deliver_get_rate` |       Deliver Rate       | This metric counts the number of messages flowing out of the queue per second. Unit: Count/s **Note:** Instances purchased on or after May 16, 2022 support this metric. | >= 0               | RabbitMQ instance queue | 1 minute                    |
| `queue_messages_redeliver_rate` |       Redelivery Rate       | This metric counts the number of redelivered messages per second. Unit: Count/s **Note:** Instances purchased on or after May 16, 2022 support this metric. | >= 0               | RabbitMQ instance queue | 1 minute                    |
| `queue_messages_persistent`     |  Total Persistent Messages  | This metric counts the total number of persistent messages in the queue (always 0 for transient queues). Unit: Count **Note:** Instances purchased on or after May 16, 2022 support this metric. | >= 0               | RabbitMQ instance queue | 1 minute                    |
| `queue_messages_ram`            |   Total Messages in RAM   | This metric counts the total number of messages residing in RAM in the queue. Unit: Count **Note:** Instances purchased on or after May 16, 2022 support this metric. | >= 0               | RabbitMQ instance queue | 1 minute                    |
| `queue_memory`                  | Erlang Process Consumed Bytes | This metric counts the memory bytes consumed by the Erlang process associated with the queue, including stack, heap, and internal structures. Unit: Byte **Note:** Instances purchased on or after May 16, 2022 support this metric. | >= 0               | RabbitMQ instance queue | 1 minute                    |
| `queue_message_bytes`           |     Total Message Size     | This metric counts the total size of all messages in the queue (bytes). Unit: Byte **Note:** Instances purchased on or after May 16, 2022 support this metric. | >= 0               | RabbitMQ instance queue | 1 minute                    |

## Objects {#object}

After data synchronization is normal, you can view the data in "Infrastructure / Custom (Objects)" on the Guance platform.

```json
{
  "measurement": "huaweicloud_rabbitmq",
  "tags": {      
    "RegionId"       : "cn-north-4",
    "charging_mode"  : "1",
    "connect_address": "192.xxx.0.xxx",
    "engine"         : "rabbitmq",
    "engine_version" : "3.8.35",
    "instance_id"    : "f127cbb0-xxxx-xxxx-xxxx-aed5a36da5d9",
    "instance_name"  : "rabbitmq-xxxx",
    "name"           : "f127cbb0-xxxx-xxxx-xxxx-aed5a36da5d9",
    "status"         : "RUNNING",
    "port"           : "xxxx"
  },
  "fields": {
    "access_user"               : "rabbit_mh",
    "available_zones"           : "[Instance JSON Data]",
    "connect_address"           : "192.xxx.0.xxx",
    "created_at"                : "1687143955266",
    "description"               : "",
    "enable_publicip"           : false,
    "maintain_begin"            : "02:00:00",
    "maintain_end"              : "06:00:00",
    "management_connect_address": "http://192.xxx.0.xxx:15672",
    "resource_spec_code"        : "",
    "specification"             : "rabbitmq.2u4g.single * 1 broker",
    "storage_space"             : 83,
    "total_storage_space"       : 100,
    "used_storage_space"        : 0,
    "message"                   : "{Instance JSON Data}"
  }
}

```

Some field explanations are as follows:

| Field                 | Type   | Explanation                                                         |
| :------------------- | :----- | :----------------------------------------------------------- |
| `specification`      | String | Instance specification. For single-node RabbitMQ instances, it returns VM specifications. For RabbitMQ clusters, it returns VM specifications and node count. |
| `charging_mode`      | String | Billing mode, 1 indicates pay-as-you-go, 0 indicates prepaid.                |
| `available_zones`    | String | The availability zone where the instance nodes reside, returning the "availability zone ID".                       |
| `maintain_begin`     | String | Start time of maintenance window, format HH:mm:ss                           |
| `maintain_end`       | String | End time of maintenance window, format HH:mm:ss                           |
| `created_at`         | String | Completion creation time. Format is timestamp, indicating the deviation in milliseconds from Greenwich Mean Time January 1, 1970 00:00:00 to the specified time. |
| `resource_spec_code` | String | Resource specification identifier `dms.instance.rabbitmq.single.c3.2u4g`: Single-node RabbitMQ, VM specification 2u4g `dms.instance.rabbitmq.single.c3.4u8g`: Single-node RabbitMQ, VM specification 4u8g `dms.instance.rabbitmq.single.c3.8u16g`: Single-node RabbitMQ, VM specification 8u16g `dms.instance.rabbitmq.single.c3.16u32g`: Single-node RabbitMQ, VM specification 16u32g `dms.instance.rabbitmq.cluster.c3.4u8g.3`: RabbitMQ cluster, VM specification 4u8g, 3 nodes `dms.instance.rabbitmq.cluster.c3.4u8g.5`: RabbitMQ cluster, VM specification 4u8g, 5 nodes `dms.instance.rabbitmq.cluster.c3.4u8g.7`: RabbitMQ cluster, VM specification 4u8g, 7 nodes `dms.instance.rabbitmq.cluster.c3.8u16g.3`: RabbitMQ cluster, VM specification 8u16g, 3 nodes `dms.instance.rabbitmq.cluster.c3.8u16g.5`: RabbitMQ cluster, VM specification 8u16g, 5 nodes `dms.instance.rabbitmq.cluster.c3.8u16g.7`: RabbitMQ cluster, VM specification 8u16g, 7 nodes `dms.instance.rabbitmq.cluster.c3.16u32g.3`: RabbitMQ cluster, VM specification 16u32g, 3 nodes `dms.instance.rabbitmq.cluster.c3.16u32g.5`: RabbitMQ cluster, VM specification 16u32g, 5 nodes `dms.instance.rabbitmq.cluster.c3.16u32g.7`: RabbitMQ cluster, VM specification 16u32g, 7 nodes |



> *Note: Fields in `tags` and `fields` may vary with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, used as a unique identifier
>
> Tip 2:
>
> - `fields.message`, `fields.listeners` are JSON serialized strings.
> - `tags.operating_status` is the operational status of the load balancer. Possible values: ONLINE and FROZEN.