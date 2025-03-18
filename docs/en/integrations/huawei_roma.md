---
title: 'Huawei Cloud ROMA'
tags: 
  - Huawei Cloud
summary: 'Use the script packages in the script market of Guance Cloud Sync series to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/huawei_roma'
dashboard:
  - desc: 'Huawei Cloud ROMA for Kafka'
    path: 'dashboard/en/huawei_roma_kafka'


---


<!-- markdownlint-disable MD025 -->
# Huawei Cloud ROMA
<!-- markdownlint-enable -->

Use the script packages in the script market of the Guance Cloud Sync series to synchronize cloud monitoring and cloud asset data to Guance.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Prepare a qualified Huawei Cloud AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data from Huawei Cloud ROMA, install the corresponding collection script: access the web service of func to enter the 【Script Market】, 「Guance Integration (Huawei Cloud-ROMA Collection)」(ID: `guance_huaweicloud_roma`)

Click 【Install】and input the required parameters: Huawei Cloud AK, SK, and Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script.

After the script installation is complete, find the script 「Guance Integration (Huawei Cloud-Kafka Collection)」in the 「Development」section of Func, expand and modify this script. Find and edit the content of `region_projects` under `collector_configs` and `monitor_configs`, change the region and Project ID to the actual ones, then click Save and Publish.

Additionally, view the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. Wait a moment, and you can check the execution task records and corresponding logs.



### Verification

1. In 「Management / Automatic Trigger Configuration」confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and check the corresponding task records and logs for any anomalies.
2. On the Guance platform, in 「Infrastructure / Custom」check if there is asset information.
3. On the Guance platform, in 「Metrics」check if there is corresponding monitoring data.

## Metrics {#metric}
When configuring Huawei Cloud-`ROMA` collection, the default metric sets are as follows. You can collect more metrics through configuration [Huawei Cloud ROMA Metric Details](https://support.huaweicloud.com/usermanual-roma/roma_03_0023.html#section4){:target="_blank"}

### Instance Monitoring Metrics

| Metric Name  | Metric Meaning  | Unit  | Dimension  |
| -------- | -------- | -------- | -------- |
| current_partitions | This metric counts the number of partitions used in the Kafka instance | Count | instance_id |
| current_topics | This metric counts the number of topics created in the Kafka instance | Count | instance_id |
| group_msgs | This metric counts the total backlog message count across all consumer groups in the Kafka instance | Count | instance_id |

### Node Monitoring Metrics
| Metric Name  | Metric Meaning  | Unit  | Dimension  |
| -------- | -------- | -------- | -------- |
| broker_data_size | This metric counts the size of the current message data on the node | Byte | instance_id |
| broker_messages_in_rate | This metric counts the number of messages produced per second | Count/s | instance_id |
| broker_bytes_in_rate | This metric counts the number of bytes produced per second | Byte/s | instance_id |
| broker_bytes_out_rate | This metric counts the number of bytes consumed per second | Byte/s | instance_id |
| broker_public_bytes_in_rate | This metric counts the inbound public network traffic to Broker nodes per second | Byte/s | instance_id |
| broker_public_bytes_out_rate | This metric counts the outbound public network traffic from Broker nodes per second | Byte/s | instance_id |
| broker_fetch_mean | This metric counts the average duration of handling consumption requests on Broker nodes | ms | instance_id |
| broker_produce_mean | This metric counts the average processing time for production requests | ms | instance_id |
| broker_cpu_core_load | This metric collects the average load of each CPU core at the virtual machine level for Kafka nodes | % | instance_id |
| broker_disk_usage | This metric collects the disk capacity usage rate at the virtual machine level for Kafka nodes | % | instance_id |
| broker_memory_usage | This metric collects the memory usage rate at the virtual machine level for Kafka nodes | % | instance_id |
| broker_heap_usage | This metric collects the heap memory usage rate from the JVM of the Kafka process on Kafka nodes | % | instance_id |
| broker_alive | Indicates whether the Kafka node is alive | 1: Alive 0: Offline | instance_id |
| broker_connections | The current number of all TCP connections on Kafka nodes | Count | instance_id |
| broker_cpu_usage | The CPU usage rate of Kafka nodes at the virtual machine level | % | instance_id |
| broker_total_bytes_in_rate | The inbound network traffic to Broker nodes per second | Byte/s | instance_id |
| broker_total_bytes_out_rate | The outbound network traffic from Broker nodes per second | Byte/s | instance_id |
| broker_disk_read_rate | Disk read operation traffic | Byte/s | instance_id |
| broker_disk_write_rate | Disk write operation traffic | Byte/s | instance_id |
| network_bandwidth_usage | Network bandwidth utilization | % | instance_id |

### Consumer Group Monitoring Metrics
| Metric Name  | Metric Meaning  | Unit  | Dimension  |
| -------- | -------- | -------- | -------- |
| messages_consumed | This metric counts the number of messages already consumed by the current consumer group | Count | instance_id |
| messages_remained | This metric counts the number of messages that can be consumed by the consumer group | Count | instance_id |
| topic_messages_remained | This metric counts the number of messages that can be consumed from the specified queue of the consumer group | Count | instance_id |
| topic_messages_consumed | This metric counts the number of messages already consumed from the specified queue of the consumer group | Count | instance_id |
| consumer_messages_remained | This metric counts the number of messages remaining that can be consumed by the consumer group | Count | instance_id |
| consumer_messages_consumed | This metric counts the number of messages already consumed by the consumer group | Count | instance_id |


## Objects {#object}

The structure of the collected Huawei Cloud ROMA object data can be seen in 「Infrastructure - Custom」

```json
{
  "measurement": "huaweicloud_SYS.ROMA",
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

> *Note: Fields in `tags` and `fields` may change with subsequent updates*
>
> Note 1: The value of `tags.name` is the instance ID, which serves as a unique identifier
>
> Note 2: The following fields are serialized JSON strings
