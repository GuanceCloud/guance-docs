---
title: 'HUAWEI RabbitMQ'
tags: 
  - Huawei Cloud
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.'
__int_icon: 'icon/huawei_rabbitmq'
dashboard:
  - desc: 'HUAWEI CLOUD RocketMQ Monitoring View'
    path: 'dashboard/zh/huawei_rabbitmq/'

monitor:
  - desc: 'HUAWEI CLOUD RocketMQ Monitor'
    path: 'monitor/zh/huawei_rabbitmq/'
---


<!-- markdownlint-disable MD025 -->
# HUAWEI CLOUD RabbitMQ
<!-- markdownlint-enable -->

Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically. Please continue with the script installation.

If you deploy Func yourself,Refer to  [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation script

> Tip：Please prepare HUAWEI CLOUD AK that meets the requirements in advance（For simplicity's sake, you can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of  HUAWEI CLOUD RocketMQ cloud resources, we install the corresponding collection script：「Guance Integration（HUAWEI CLOUD- RabbitMQ）」(ID：`guance_huaweicloud_rabbitmq`)

Click  [ Install ]  and enter the corresponding parameters: HUAWEI CLOUD AK, HUAWEI CLOUD account name.

tap [ Deploy startup Script ] ,The system automatically creates `Startup` script sets,And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」. Click [ Run ] ,you can immediately execute once, without waiting for a regular time. After a while, you can view task execution records and corresponding logs.

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-rabbitmq/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure HUAWEI CLOUD - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them  [HUAWEI CLOUD Monitor Metrics Details](https://support.huaweicloud.com/eu/usermanual-rabbitmq/rabbitmq-ug-180413002.html){:target="_blank"}


| **MetricID**            |          **Metric Name**   | **Metric Meaning** | **Value Range**      | **Measured Object** | **Monitoring Period (Raw Metric)** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| connections |        connection count        | This metric is used to count the total number of connections in the RabbitMQ instance. unit：Count | >= 0               | RabbitMQ instance | 1 minute               |
| channels                        |        channel count        | This metric is used to count the total number of channels in the RabbitMQ instance. unit：Count | 0~2047             | RabbitMQ instance | 1 minute               |
| queues                          |        queue count        | This metric is used to count the total number of queues in the RabbitMQ instance. unit：Count | 0~1200             | RabbitMQ instance | 1 minute               |
| consumers                       |       consumer count       | This metric is used to count the total number of consumers in the RabbitMQ instance. unit：Count | 0~1200             | RabbitMQ instance | 1 minute               |
| messages_ready                  |     consumable message count     | This metric is used to count the total number of consumable messages in the RabbitMQ instance. unit：Count | 0~10000000         | RabbitMQ instance | 1 minute               |
| messages_unacknowledged         |     unacknowledged message count     | This metric is used to count the total number of messages that have been consumed but not yet acknowledged in the RabbitMQ instance. unit：Count | 0~10000000         | RabbitMQ instance | 1 minute               |
| publish                         |       message production rate       | Monitor real-time message production rate in a RabbitMQ instance. unit：Count/s | 0~25000            | RabbitMQ instance | 1 minute               |
| deliver                         | message consumption rate（manual acknowledgment） | Monitor real-time message consumption rate in a RabbitMQ instance.（manual acknowledgment）. unit：Count/s | 0~25000            | RabbitMQ instance | 1 minute               |
| deliver_no_ack                  | message consumption rate（auto-acknowledgment） | Monitor real-time message consumption rate in a RabbitMQ instance.（auto-acknowledgment）. unit：Count/s | 0~50000            | RabbitMQ instance | 1 minute               |
| connections_states_running      |  Number of connections in the running state  | This metric is used to count the total number of connections in the entire instance with the states of starting/tuning/opening/running. unit：Count**Explanation：**Supported for instances purchased on or after May 16th, 2022. | >= 0               | RabbitMQ instance | 1 minute               |
| connections_states_flow         |   Number of connections in the flow state   | This metric is used to count the total number of connections in the entire instance with the state of "flow." unit：Count **Explanation：**Supported for instances purchased on or after May 16th, 2022. | >= 0               | RabbitMQ instance | 1 minute               |
| connections_states_block        | Number of connections in the block state | This metric is used to count the total number of connections in the entire instance with the state of "blocking" or "blocked." unit：Count **Explanation：**Supported for instances purchased on or after May 16th, 2022. | >= 0               | RabbitMQ instance | 1 minute               |
| connections_states_close        | Number of connections in the close state | This metric is used to count the total number of connections in the entire instance with the state of "closing" or "closed." unit：Count **Explanation：**Supported for instances purchased on or after May 16th, 2022. | >= 0               | RabbitMQ instance | 1 minute               |
| channels_states_running         |   Number of channels in the running state   | This metric is used to count the total number of channels in the entire instance with the state of "starting," "tuning," "opening," or "running." unit：Count **Explanation：**Supported for instances purchased on or after May 16th, 2022. | >= 0               | RabbitMQ instance | 1 minute               |
| channels_states_flow            |   Number of channels in the flow state   | This metric is used to count the total number of channels in the entire instance with the state of "flow." unit：Count **Explanation：**Supported for instances purchased on or after May 16th, 2022. | >= 0               | RabbitMQ instance | 1 minute               |
| channels_states_block           | Number of channels in the block state | This metric is used to count the total number of channels in the entire instance with the state of "blocking/blocked." unit：Count **Explanation：**Supported for instances purchased on or after May 16th, 2022. | >= 0               | RabbitMQ instance | 1 minute               |
| channels_states_close           | Number of channels in the close state | This metric is used to count the total number of channels in the entire instance with the state of "closing/closed." unit：Count **Explanation：**Supported for instances purchased on or after May 16th, 2022. | >= 0               | RabbitMQ instance | 1 minute               |
| queues_states_running           |   Number of queues in the running state   | This metric is used to count the total number of queues in the entire instance with the state of "running." unit：Count **Explanation：**Supported for instances purchased on or after May 16th, 2022. | >= 0               | RabbitMQ instance | 1 minute               |
| queues_states_flow              |   Number of queues in the flow state   | This metric is used to count the total number of queues in the entire instance with the state of "flow." unit：Count **Explanation：**Supported for instances purchased on or after May 16th, 2022. | >= 0               | RabbitMQ instance | 1 minute               |
| fd_used                         |      Number of file handles      | This metric is used to count the current number of file descriptors used by the RabbitMQ process on the node. unit：Count | 0~65535            | RabbitMQ Instance Node | 1 minute               |
| socket_used                     |     Number of socket connections     | This metric is used to count the current number of Socket connections used by the RabbitMQ process on the node. unit：Count | 0~50000            | RabbitMQ Instance Node | 1 minute               |
| proc_used                       |     Number of Erlang processes     | This metric is used to count the current number of Erlang processes used by the RabbitMQ process on the node. unit：Count | 0~1048576          | RabbitMQ Instance Node | 1 minute               |
| mem_used                        |       Memory usage       | This metric is used to measure the current memory usage of the RabbitMQ process on the node. unit：Byte | 0~32000000000      | RabbitMQ Instance Node | 1 minute               |
| disk_free                       |     Available storage space     | This metric is used to measure the current available storage space on the node. unit：Byte | 0~500000000000     | RabbitMQ Instance Node | 1 minute               |
| **rabbitmq_alive**                  |     Node's status     | This metric indicates the liveness status of the RabbitMQ node. **Explanation：**This monitoring item is supported for instances purchased on and after April 2020..  | 1：Alive 0：offline | RabbitMQ Instance Node | 1 minute               |
| **rabbitmq_disk_usage**             |    Disk capacity utilization    | This metric is used to measure the disk capacity utilization of the RabbitMQ node's virtual machine. unit：% **Explanation：**This monitoring item is supported for instances purchased on and after April 2020..  | 0~100%             | RabbitMQ Instance Node | 1 minute               |
| **rabbitmq_cpu_usage**              | CPU usage rate | This metric is used to measure the CPU utilization of the RabbitMQ node's virtual machine. unit：% **Explanation：**This monitoring item is supported for instances purchased on and after April 2020..  | 0~100%             | RabbitMQ Instance Node | 1 minute               |
| **rabbitmq_cpu_core_load**          | Average CPU load per core | Monitor the memory usage rate of the RabbitMQ node's virtual machine. **Explanation：**This monitoring item is supported for instances purchased on and after April 2020..  | >0                 | RabbitMQ Instance Node | 1 minute               |
| **rabbitmq_memory_usage**           |      Memory usage rate      | Monitor the memory usage of the RabbitMQ node's virtual machine. unit：% **Explanation：**This monitoring item is supported for instances purchased on and after April 2020..  | 0~100%             | RabbitMQ Instance Node | 1 minute               |
| **rabbitmq_disk_read_await**        |  Average disk read operation time  | This metric is used to measure the average duration of each read IO operation on the disk during the measurement period. unit：ms **Explanation：**This monitoring item is supported for instances purchased on and after June 2020. | >0                 | RabbitMQ Instance Node | 1 minute               |
| **rabbitmq_disk_write_await**       |  Average disk write operation time  | This metric is used to measure the average duration of each write IO operation on the disk during the measurement period. unit：ms **Explanation：**This monitoring item is supported for instances purchased on and after June 2020. | >0                 | RabbitMQ Instance Node | 1 minute               |
| **rabbitmq_node_bytes_in_rate**     |      Network incoming traffic      | This metric is used to measure the network inbound traffic per second on the RabbitMQ node. unit：Byte/s **Explanation：**This monitoring item is supported for instances purchased on and after June 2020. | >0                 | RabbitMQ Instance Node | 1 minute               |
| **rabbitmq_node_bytes_out_rate**    |      Network outgoing traffic      | This metric is used to measure the network outbound traffic per second on the RabbitMQ node. unit：Byte/s **Explanation：**This monitoring item is supported for instances purchased on and after June 2020..  | >0                 | RabbitMQ Instance Node | 1 minute               |
| **rabbitmq_node_queues**            |      Number of queues on the node      | This metric is used to count the number of queues on the RabbitMQ node. unit：count  **Explanation：**This monitoring item is supported for instances purchased on and after June 2020..  | >0                 | RabbitMQ Instance Node | 1 minute               |
| **rabbitmq_memory_high_watermark**  |    Memory high watermark status    | This metric indicates whether the RabbitMQ node has triggered the memory high watermark. If triggered, it will block all producers in the cluster. **Explanation：**This monitoring item is supported for instances purchased on and after June 2020..  | 1：Triggered 0：Not Triggered | RabbitMQ Instance Node | 1 minute               |
| **rabbitmq_disk_insufficient**      |    Disk high watermark status    | This metric indicates whether the RabbitMQ node has triggered the disk high watermark. If triggered, it will block all producers in the cluster. **Explanation：**This monitoring item is supported for instances purchased on and after June 2020. | 1：Triggered 0：Not Triggered | RabbitMQ Instance Node | 1 minute               |
| **rabbitmq_disk_read_rate**         |      Disk read traffic      | This metric measures the disk read byte size per second on the RabbitMQ node. unit：KB/s **Explanation：**Supported for instances purchased on or after May 16th, 2022. | >= 0               | RabbitMQ Instance Node | 1 minute               |
| **rabbitmq_disk_write_rate**        |      Disk write traffic      | This metric measures the disk write byte size per second on the RabbitMQ node. unit：KB/s **Explanation：**Supported for instances purchased on or after May 16th, 2022. | >= 0               | RabbitMQ Instance Node | 1 minute               |
| queue_messages_unacknowledged   |   Number of unacknowledged messages in the queue   | This metric counts the number of consumed but unacknowledged messages in the queue. unit：Count | 0~10000000         | RabbitMQ Instance Node | 1 minute               |
| queue_messages_ready            |   Number of consumable messages in the queue   | This metric counts the number of messages in the queue that are available for consumption. unit：Count | 0~10000000         | RabbitMQ Instance Node | 1 minute               |
| queue_consumers                 |      Number of consumers      | This metric counts the number of consumers subscribed to the queue. unit：Count **Explanation：**Supported for instances purchased on or after May 16th, 2022. | >= 0               | RabbitMQ Instance Node | 1 minute               |
| queue_messages_publish_rate     |       Production rate       | This metric is used to count the number of incoming messages per second to the queue. unit：Count/s **Explanation：**Supported for instances purchased on or after May 16th, 2022. | >= 0               | RabbitMQ Instance Node | 1 minute               |
| queue_messages_ack_rate         | Consumption rate（manual acknowledgment） | This metric is used to count the number of messages delivered to the clients and acknowledged per second for the queue. unit：Count/s **Explanation：**Supported for instances purchased on or after May 16th, 2022. | >= 0               | RabbitMQ Instance Node | 1 minute               |
| queue_messages_deliver_get_rate |       Consumption speed       | This metric is used to count the number of messages sent out from the queue per second. unit：Count/s **Explanation：**Supported for instances purchased on or after May 16th, 2022. | >= 0               | RabbitMQ Instance Node | 1 minute               |
| queue_messages_redeliver_rate   |       Retransmission rate       | This metric is used to count the number of messages that are retransmitted from the queue per second. unit：Count/s **Explanation：**Supported for instances purchased on or after May 16th, 2022. | >= 0               | RabbitMQ Instance Node | 1 minute               |
| queue_messages_persistent       |  Total number of messages（Persistence）  | This metric is used to count the total number of persistent messages in the queue (it will always be 0 for transient queues). unit：Count **Explanation：**Supported for instances purchased on or after May 16th, 2022. | >= 0               | RabbitMQ Instance Node | 1 minute               |
| queue_messages_ram              |   Total Messages（Memory）   | This metric is used to count the total number of messages residing in memory in the queue. unit：Count **Explanation：**Supported for instances purchased on or after May 16th, 2022. | >= 0               | RabbitMQ Instance Node | 1 minute               |
| queue_memory                    | Erlang Process Memory Consumption (in bytes) | This metric is used to count the number of memory bytes consumed by Erlang processes associated with the queue, including the stack, heap, and internal structures. unit：Byte **Explanation：**Supported for instances purchased on or after May 16th, 2022. | >= 0               | RabbitMQ Instance Node | 1 minute               |
| queue_message_bytes             |     Total Message Size     | This metric is used to calculate the total size of all messages in the queue (in bytes). unit：Byte **Explanation：**Supported for instances purchased on or after May 16th, 2022. | >= 0               | RabbitMQ Instance Node | 1 minute               |

## Object {#object}

The collected HUAWEI CLOUD ELB object data structure can see the object data from 「Infrastructure-custom-defined」

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
    "available_zones"           : "[Instance JSON data]",
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
    "message"                   : "{Instance JSON data}"
  }
}

```


| Field                | Type   | Description                                                  |
| :------------------- | :----- | :----------------------------------------------------------- |
| `specification`      | String | Instance Specification. For single-node RabbitMQ instances, it returns the VM specification. For RabbitMQ cluster instances, it returns the VM specification and the number of nodes. |
| `charging_mode`      | String | Billing Mode: 1 indicates pay-as-you-go, and 0 indicates subscription (monthly/yearly) billing. |
| `available_zones`    | String | The Availability Zone where the instance node is located. It returns the "Availability Zone ID". |
| `maintain_begin`     | String | The start time of the maintenance window, in the format "HH:mm:ss". |
| `maintain_end`       | String | The end time of the maintenance window, in the format "HH:mm:ss". |
| `created_at`         | String | The completion creation time in timestamp format, which represents the total milliseconds offset from Greenwich Mean Time (GMT) on January 1, 1970, to the specified time. |
| `resource_spec_code` | String | Resource specification identifier `dms.instance.rabbitmq.single.c3.2u4g`：RabbitMQ Standalone,vm Specification 2u4g `dms.instance.rabbitmq.single.c3.4u8g`：RabbitMQ Standalone,vm Specification 4u8g `dms.instance.rabbitmq.single.c3.8u16g`：RabbitMQ Standalone,vm Specification 8u16g `dms.instance.rabbitmq.single.c3.16u32g`：RabbitMQStandalone,vm Specification 16u32g `dms.instance.rabbitmq.cluster.c3.4u8g.3`：RabbitMQ Cluster ,vm Specification 4u8g,3 Nodes  `dms.instance.rabbitmq.cluster.c3.4u8g.5`：RabbitMQ Cluster ,vm Specification 4u8g,5 Nodes  `dms.instance.rabbitmq.cluster.c3.4u8g.7`：RabbitMQ Cluster ,vm Specification 4u8g,7 Nodes  `dms.instance.rabbitmq.cluster.c3.8u16g.3`：RabbitMQ Cluster ,vm Specification 8u16g,3 Nodes  `dms.instance.rabbitmq.cluster.c3.8u16g.5`：RabbitMQ Cluster ,vm Specification 8u16g,5 Nodes  `dms.instance.rabbitmq.cluster.c3.8u16g.7`：RabbitMQ Cluster ,vm Specification 8u16g,7 Node  `dms.instance.rabbitmq.cluster.c3.16u32g.3`：RabbitMQ Cluster ,vm Specification 16u32g,3 Node  `dms.instance.rabbitmq.cluster.c3.16u32g.5`：RabbitMQ Cluster ,vm Specification 16u32g,5 Nodes  `dms.instance.rabbitmq.cluster.c3.16u32g.7`：RabbitMQ Cluster ,vm Specification 16u32g,7 Node |



> *notice：`tags`,`fields`The fields in this section may change with subsequent updates*
>
> Tips 1：`tags.name`The value is the instance ID for unique identification
>
> Tips 2：
>
> - `fields.message`,`fields.listeners` are JSON-serialized strings.
> - `tags.operating_status`represents the operating status of the load balancer. It can have the values "ONLINE" and "FROZEN".

