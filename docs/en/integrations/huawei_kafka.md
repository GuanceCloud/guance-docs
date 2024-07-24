---
title: 'HUAWEI DMS Kafka'
tags: 
  - Huawei Cloud
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.'
__int_icon: 'icon/huawei_kafka'
dashboard:
  - desc: 'HUAWEI CLOUD Kafka Dashboard'
    path: 'dashboard/zh/huawei_kafka'

monitor:
  - desc: 'HUAWEI CLOUD Kafka Monitor'
    path: 'monitor/zh/huawei_kafka'

---


<!-- markdownlint-disable MD025 -->
# HUAWEI CLOUD DMS Kafka
<!-- markdownlint-enable -->

Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to  [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare HUAWEI CLOUD AK that meets the requirements in advance（For simplicity's sake, you can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of  HUAWEI CLOUD Kafka cloud resources, we install the corresponding collection script：「Guance Integration (HUAWEI CLOUD-Kafka Collection)」(ID：`guance_huaweicloud_kafka`)

Click 【Install】 and enter the corresponding parameters: HUAWEI CLOUD AK, HUAWEI CLOUD account name.

tap【Deploy startup Script】,The system automatically creates `Startup` script sets,And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Guance Integration (HUAWEI CLOUD-Kafka Collection)」,Click【Run】,you can immediately execute once, without waiting for a regular time.After a while, you can view task execution records and corresponding logs.

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column
[Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-rds-postgresql/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task. In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure HUAWEI CLOUD Kafka collection, the default set of metrics is as follows, you can configure the way to collect more metrics [HUAWEI CLOUD cloud monitoring metrics details](https://support.huaweicloud.com/usermanual-kafka/kafka-ug-180413002.html){:target="_blank"}

### Example monitoring metrics

| Metric Name  | Metric Meaning  | Unit   |  Dimension   |
| -------- | -------- | -------- | -------- |
| current_partitions | This metric is used to count the number of partitions that have been used in a Kafka instance | Count | instance_id |
| current_topics | This metric is used to count the number of topics that have been created in a Kafka instance | Count | instance_id |
| group_msgs | This metric is used to count the total number of stacked messages in all consumption groups in a Kafka instance | Count | instance_id |

### Node monitoring metrics
| Metric Name  | Metric Meaning  | Unit   |  Dimension   |
| -------- | -------- | -------- | -------- |
| broker_data_size | This metric is used to count the current message data size of the node | Byte | instance_id |
| broker_messages_in_rate | This metric is used to count the number of messages produced per second | Count/s | instance_id |
| broker_bytes_in_rate | This metric is used to count the number of bytes produced per second | Byte/s | instance_id |
| broker_bytes_out_rate | This metric is used to count the number of bytes consumed per second | Byte/s | instance_id |
| broker_public_bytes_in_rate | Statistics of public access inflow traffic per second on Broker nodes | Byte/s | instance_id |
| broker_public_bytes_out_rate | Statistics of outgoing public access traffic of Broker nodes per second | Byte/s | instance_id |
| broker_fetch_mean | Statistics on the average length of time Broker nodes take to process consumption requests | ms | instance_id |
| broker_produce_mean | Average processing time for production requests | ms | instance_id |
| broker_cpu_core_load | Average load per CPU core captured at the Kafka node VM level | % | instance_id |
| broker_disk_usage | Disk capacity utilization captured at the virtual machine level for Kafka nodes | % | instance_id |
| broker_memory_usage | Memory utilization captured at the virtual machine level for Kafka nodes | % | instance_id |
| broker_heap_usage | Heap Memory Utilization Captured in the Kafka Process JVM for Kafka Nodes | % | instance_id |
| broker_alive | Indicates whether the Kafka node is alive | 1: alive 0: offline | instance_id |
| broker_connections | Number of all current TCP connections to Kafka n | Count | instance_id |
| broker_cpu_usage | CPU utilization of Kafka node VMs | % | instance_id |
| broker_total_bytes_in_rate | Incoming network access traffic per second for Broker nodes | Byte/s | instance_id |
| broker_total_bytes_out_rate | Broker node outgoing network access traffic per second | Byte/s | instance_id |
| broker_disk_read_rate | Disk read operation traffic | Byte/s | instance_id |
| broker_disk_write_rate | Disk Write Traffic | Byte/s | instance_id |
| network_bandwidth_usage | Network bandwidth utilization | % | instance_id |

### Consumer Group Monitoring Metrics
| Metric Name  | Metric Meaning  | Unit   |  Dimension   |
| -------- | -------- | -------- | -------- |
| messages_consumed | This metric is used to count the number of messages that have been consumed by the current consumer group | Count | instance_id |
| messages_remained | This metric is used to count the number of messages that can be consumed by the consumer group | Count | instance_id |
| topic_messages_remained | This metric is used to count the number of messages that can be consumed by the specified queue of the consumption group | Count | instance_id |
| topic_messages_consumed | This metric is used to count the number of messages that have been consumed by the specified queue of the consumer group | Count | instance_id |
| consumer_messages_remained | This metric is used to count the number of messages remaining to be consumed by the consumption group | Count | instance_id |
| consumer_messages_consumed | This metric is used to count the number of messages that have currently been consumed by the consumption group | Count | instance_id |


## 对象 {#object}

Collected HUAWEI CLOUD Kafka object data structure, you can see the object data from "Infrastructure - Customization".

```json
{
  "measurement": "huaweicloud_kafka",
  "tags": {      
    "RegionId"           : "cn-north-4",
    "charging_mode"      : "1",
    "connect_address"    : "192.168.0.161,192.168.0.126,192.168.0.31",
    "description"        : "",
    "engine"             : "kafka",
    "engine_version"     : "2.7",
    "instance_id"        : "beb33e02-xxxx-xxxx-xxxx-628a3994fd1f",
    "kafka_manager_user" : "",
    "name"               : "beb33e02-xxxx-xxxx-xxxx-628a3994fd1f",
    "port"               : "9092",
    "project_id"         : "f5f4c067d68xxxx86e173b18367bf",
    "resource_spec_code" : "",
    "service_type"       : "advanced",
    "specification"      : "kafka.2u4g.cluster.small * 3 broker",
    "status"             : "RUNNING",
    "storage_type"       : "hec",
    "user_id"            : "e4b27d49128e4bd0893b28d032a2e7c0",
    "user_name"          : "xxxx"
  },
  "fields": {
    "created_at"          : "1693203968959",
    "maintain_begin"      : "02:00:00",
    "maintain_end"        : "06:00:00",
    "storage_space"       : 186,
    "total_storage_space" : 300,
    "message"             : "{Instance JSON data}"
  }
}

```

> *Note: Fields in `tags`, `fields` are subject to change with subsequent updates.*
>
> Tip 1: The `tags.name` value is the instance ID, which serves as a unique identifier.
>
> Tip 2: The following fields are JSON serialized strings

