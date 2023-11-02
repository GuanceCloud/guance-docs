---
title: 'HUAWEI RocketMQ'
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.'
__int_icon: 'icon/huawei_rocketmq'
dashboard:
  - desc: 'HUAWEI CLOUD RocketMQ Monitoring View'
    path: 'dashboard/zh/huawei_rocketmq/'

monitor:
  - desc: 'HUAWEI CLOUD RocketMQ Monitor'
    path: 'monitor/zh/huawei_rocketmq/'
---


<!-- markdownlint-disable MD025 -->
# HUAWEI CLOUD RocketMQ
<!-- markdownlint-enable -->

Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to  [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation script

> Tip：Please prepare HUAWEI CLOUD AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of  HUAWEI CLOUD RocketMQ cloud resources, we install the corresponding collection script：「Guance Integration（HUAWEI CLOUD- RocketMQ Collect）」(ID：`guance_huaweicloud_rocketmq`)

Click [Install] and enter the corresponding parameters: HUAWEI CLOUD AK, HUAWEI CLOUD account name.

tap[Deploy startup Script]，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」.Click[Run]，you can immediately execute once, without waiting for a regular time.After a while, you can view task execution records and corresponding logs.

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-rocketmq/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure HUAWEI CLOUD - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [HUAWEI CLOUD Monitor Metrics Details](https://support.huaweicloud.com/usermanual-hrm/hrm-ug-018.html){:target="_blank"}

| **MetricID**            |          **Metric Name**   | **Metric Meaning** | **Value Range**      | **Measured Object** | **Monitoring Period (Raw Metric)** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| `nstance_produce_msg` |        Message Production Count        | Instance Messages Received per Minute, Unit：Count | >0 | RocketMQ Instance | 1minute |
| `instance_consume_msg` | Message Consumption Count | Instance Messages Consumed per Minute, Unit：Count | >0 | RocketMQ Instance | 1minute |
| `current_topics` | Number of Topics | The number of topics in the instance. Unit：Count  **Note:** This metric is supported for instances purchased on or after May 16, 2022. | >=0 | RocketMQ Instance | 1minute |
| `current_queues` | Number of Queues | The number of queues in the instance. Unit：Count  **Note:** This metric is supported for instances purchased on or after May 16, 2022. | >=0 | RocketMQ Instance | 1minute |
| `instance_accumulation` | Number of Accumulated Messages | The total number of accumulated messages for all consumer groups in the instance. Unit：Count  **Note:** This metric is supported for instances purchased on or after May 16, 2022. | >=0 | RocketMQ Instance | 1minute |
| `broker_produce_msg` | Message Production Count | The number of messages received by the node in one minute.  Unit：Count | >0 | RocketMQ Instance node | 1minute |
| `broker_consume_msg` | Message Consumption Count | The number of messages consumed from the node in one minute. Unit：Count | >0 | RocketMQ Instance node | 1minute |
| `broker_produce_rate` | Message Production Rate | The number of messages received by the node per second. Unit：Count/s | >0 | RocketMQ Instance node | 1minute |
| `broker_consume_rate` | Message Consumption Rate | The number of messages consumed by the node per second. Unit：Count/s | >0 | RocketMQ Instance node | 1minute |
| `broker_total_bytes_in_rate` | Incoming Network Traffic | The amount of incoming network traffic to the node per second. Unit：Byte/s | >0 | RocketMQ Instance node | 1minute |
| `broker_total_bytes_out_rate` | Outgoing Network Traffic | The amount of outgoing network traffic from the node per second. Unit：Byte/s | >0 | RocketMQ Instance node | 1minute |
| `broker_cpu_core_load` | Average CPU Load per Core | This metric is used to calculate the average load on each core of the node's virtual machine CPU. | >0 | RocketMQ Instance node | 1minute |
| `broker_disk_usage` | Disk Capacity Usage Rate | This metric is used to monitor the disk capacity usage rate of the node's virtual machine. Unit：% | 0~100 | RocketMQ Instance node | 1minute |
| `broker_memory_usage` | Memory Usage Rate | This metric is used to monitor the memory usage rate of the node's virtual machine.  Unit：% | 0~100 | RocketMQ Instance node | 1minute |
| `broker_alive` | Node Alive Status | Node's health status  **Note:** This metric is supported for instances purchased on or after May 16, 2022. | 1:Survival 0:off-line | RocketMQ Instance node | 1minute |
| `broker_connections` | Connection Count | Number of connections used by the virtual machine. Unit：Count  **Note:** This metric is supported for instances purchased on or after May 16, 2022. | >=0 | RocketMQ Instance node | 1minute |
| `broker_cpu_usage` | CPU Usage Rate | Virtual machine's CPU usage rate. Unit：%  **Note:** This metric is supported for instances purchased on or after May 16, 2022. | >=0 | RocketMQ Instance node | 1minute |
| `broker_disk_read_rate` | Disk Read Traffic | Disk read operation traffic. Unit：Byte/s  **Note:** This metric is supported for instances purchased on or after May 16, 2022. | >=0 | RocketMQ Instance node | 1minute |
| `broker_disk_write_rate` | Disk Write Traffic | Disk write operation traffic. Unit：Byte/s  **Note:** This metric is supported for instances purchased on or after May 16, 2022. | >=0 | RocketMQ Instance node | 1minute |
| `topic_produce_msg` | Message Production Count | The number of messages received by the topic in one minute. Unit：Count | >0 | RocketMQ Instance queue | 1minute |
| `topic_consume_msg` | Message Consumption Count | The number of messages consumed from the topic in one minute. Unit：Count | >0 | RocketMQ Instance queue | 1minute |
| `topic_produce_rate` | Message Production Rate | The number of messages received per second for the topic. Unit：Count/s | >0 | RocketMQ Instance queue | 1minute |
| `topic_consume_rate` | Message Consumption Rate | The number of messages consumed per second for the topic.  Unit：Count/s | >0 | RocketMQ Instance queue | 1minute |
| `topic_bytes_in_rate` | Production Traffic | The production traffic of the current topic.  Unit：Byte/s   **Note:** This metric is supported for instances purchased on or after May 16, 2022. | >=0 | RocketMQ Instance queue | 1minute |
| `topic_bytes_out_rate` | Consumption Traffic | The consumption traffic of the current topic.  Unit：Byte/s   **Note:** This metric is supported for instances purchased on or after May 16, 2022. | >=0 | RocketMQ Instance queue | 1minute |

**## Object {#**object}

The collected HUAWEI CLOUD ELB object data structure can see the object data from 「Infrastructure-custom-defined」

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

| field                 | type   |  description                                                         |
| :------------------- | :----- | :----------------------------------------------------------- |
| `specification`      | String | instance type.                                                   |
| `charging_mode`      | String | Payment mode, where 1 represents pay-as-you-go (on-demand billing) and 0 represents subscription billing (annual/monthly billing).                |
| `created_at`         | String | Completion creation time. The format is a timestamp, indicating the total number of milliseconds since January 1, 1970, 00:00:00 GMT to the specified time. |
| `resource_spec_code` | String | Resource specification or resource size.                                                    |
| `maintain_begin`     | String | Maintenance time window start time in the format HH:mm:ss.                          |
| `maintain_end`       | String | Maintenance time window end time in the format HH:mm:ss.                          |

> *notice：`tags`,`fields`The fields in this section may change with subsequent updates*
>
> Tips 1：`tags.name`The value is the instance ID for unique identification
>
> Tips 2：
>
> - `fields.message`,`fields.listeners` are JSON-serialized strings.
> - `tags.operating_status`represents the operating status of the load balancer. It can have the values "ONLINE" and "FROZEN".
