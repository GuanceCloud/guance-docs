---
title: 'Huawei Cloud DMS Kafka'
tags: 
  - Huawei Cloud
summary: 'Use the script packages in the script market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/huawei_kafka'
dashboard:

  - desc: 'Huawei Cloud Kafka built-in view'
    path: 'dashboard/en/huawei_kafka'

monitor:
  - desc: 'Huawei Cloud Kafka monitor'
    path: 'monitor/en/huawei_kafka'

---


<!-- markdownlint-disable MD025 -->
# Huawei Cloud DMS Kafka
<!-- markdownlint-enable -->

Use the script packages in the script market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Please prepare a qualified Huawei Cloud AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of Huawei Cloud Kafka, we install the corresponding collection script: access the web service of func and enter the 【Script Market】, 「Guance Integration (Huawei Cloud-Kafka Collection)」(ID: `guance_huaweicloud_kafka`)

Click 【Install】, then input the corresponding parameters: Huawei Cloud AK, SK, and Huawei Cloud account name.

Click 【Deploy Start Script】, the system will automatically create a `Startup` script set and configure the corresponding start script automatically.

After the script is installed, find the script 「Guance Integration (Huawei Cloud-Kafka Collection)」in the "Development" section of Func, expand and modify this script. Find `collector_configs` and `monitor_configs`, edit the content of `region_projects`, change the region and Project ID to the actual ones, and click Save and Publish.

In addition, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to immediately execute once without waiting for the scheduled time. After a while, you can check the execution task records and corresponding logs.

By default, we collect some configurations, see the metrics section for details [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-rds-postgresql/){:target="_blank"}


### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm that the corresponding tasks have the corresponding automatic trigger configurations, and you can check the corresponding task records and logs for any abnormalities.
2. On the Guance platform, in 「Infrastructure / Custom」, check if there is asset information.
3. On the Guance platform, in 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring the Huawei Cloud-Kafka collection, the default metric set is as follows. You can collect more metrics through configuration [Huawei Cloud Monitoring Metrics Details](https://support.huaweicloud.com/usermanual-kafka/kafka-ug-180413002.html){:target="_blank"}

### Instance Monitoring Metrics

| Metric Name  | Metric Meaning  | Unit  | Dimension  |
| -------- | -------- | -------- | -------- |
| current_partitions | This metric counts the number of partitions used in the Kafka instance | Count | instance_id |
| current_topics | This metric counts the number of topics created in the Kafka instance | Count | instance_id |
| group_msgs | This metric counts the total backlog messages in all consumer groups of the Kafka instance | Count | instance_id |

### Node Monitoring Metrics
| Metric Name  | Metric Meaning  | Unit  | Dimension  |
| -------- | -------- | -------- | -------- |
| broker_data_size | This metric counts the size of message data currently on the node | Byte | instance_id |
| broker_messages_in_rate | This metric counts the number of messages produced per second | Count/s | instance_id |
| broker_bytes_in_rate | This metric counts the number of bytes produced per second | Byte/s | instance_id |
| broker_bytes_out_rate | This metric counts the number of bytes consumed per second | Byte/s | instance_id |
| broker_public_bytes_in_rate | Counts the inbound public network traffic per second on the Broker node | Byte/s | instance_id |
| broker_public_bytes_out_rate | Counts the outbound public network traffic per second on the Broker node | Byte/s | instance_id |
| broker_fetch_mean | Counts the average duration of handling consumer requests on the Broker node | ms | instance_id |
| broker_produce_mean | Average processing time for production requests | ms | instance_id |
| broker_cpu_core_load | Average load of each CPU core collected at the VM level of the Kafka node | % | instance_id |
| broker_disk_usage | Disk usage rate collected at the VM level of the Kafka node | % | instance_id |
| broker_memory_usage | Memory usage rate collected at the VM level of the Kafka node | % | instance_id |
| broker_heap_usage | Heap memory usage rate collected from the Kafka process JVM on the Kafka node | % | instance_id |
| broker_alive | Indicates whether the Kafka node is alive | 1: Alive 0: Offline | instance_id |
| broker_connections | Number of all current TCP connections on the Kafka node | Count | instance_id |
| broker_cpu_usage | CPU usage rate of the Kafka node VM | % | instance_id |
| broker_total_bytes_in_rate | Network inbound traffic per second on the Broker node | Byte/s | instance_id |
| broker_total_bytes_out_rate | Network outbound traffic per second on the Broker node | Byte/s | instance_id |
| broker_disk_read_rate | Disk read operation traffic | Byte/s | instance_id |
| broker_disk_write_rate | Disk write operation traffic | Byte/s | instance_id |
| network_bandwidth_usage | Network bandwidth utilization rate | % | instance_id |

### Consumer Group Monitoring Metrics
| Metric Name  | Metric Meaning  | Unit  | Dimension  |
| -------- | -------- | -------- | -------- |
| messages_consumed | This metric counts the number of messages already consumed by the current consumer group | Count | instance_id |
| messages_remained | This metric counts the number of messages that can be consumed by the consumer group | Count | instance_id |
| topic_messages_remained | This metric counts the number of messages that can be consumed by the specified queue of the consumer group | Count | instance_id |
| topic_messages_consumed | This metric counts the number of messages already consumed by the specified queue of the consumer group | Count | instance_id |
| consumer_messages_remained | This metric counts the number of messages remaining to be consumed by the consumer group | Count | instance_id |
| consumer_messages_consumed | This metric counts the number of messages already consumed by the consumer group | Count | instance_id |


## Objects {#object}

The structure of the collected Huawei Cloud Kafka object data can be viewed under 「Infrastructure - Custom」

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
    "message"             : "{Instance JSON Data}"
  }
}

```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Note 1: The value of `tags.name` is the instance ID, which serves as a unique identifier.
>
> Note 2: The following fields are serialized JSON strings.