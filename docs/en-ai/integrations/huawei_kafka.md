---
title: 'Huawei Cloud DMS Kafka'
tags: 
  - Huawei Cloud
summary: 'Use the script packages in the script market of the "Guance Cloud Sync" series to synchronize cloud monitoring and cloud asset data to Guance'
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

Use the script packages in the script market of the "Guance Cloud Sync" series to synchronize cloud monitoring and cloud asset data to Guance.


## Configuration {#config}

### Install Func

It is recommended to activate the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of Huawei Cloud Kafka, we install the corresponding collection script: access the web service of func to enter the 【Script Market】, 「Guance Integration (Huawei Cloud-Kafka Collection)」(ID: `guance_huaweicloud_kafka`)

Click 【Install】and then enter the corresponding parameters: Huawei Cloud AK, SK, Huawei Cloud account name.

Click 【Deploy Start Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After the script installation is complete, find the script 「Guance Integration (Huawei Cloud-Kafka Collection)」in the「Development」section of Func, expand and modify this script, find collector_configs and monitor_configs and edit the content of region_projects, change the region and Project ID to the actual ones, then click Save and Publish.

In addition, you can see the corresponding automatic trigger configuration in「Management / Automatic Trigger Configuration」. Click【Execute】, it can be executed immediately without waiting for the scheduled time. Wait a moment, you can check the execution task records and corresponding logs.

We have collected some configurations by default, see the metrics section for details [Configuration Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-rds-postgresql/){:target="_blank"}


### Verification

1. In「Management / Automatic Trigger Configuration」confirm whether the corresponding tasks have corresponding automatic trigger configurations, and at the same time, you can check the corresponding task records and logs to check for any abnormalities.
2. On the Guance platform, in「Infrastructure / Custom」check if there is asset information.
3. On the Guance platform, in「Metrics」check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring the Huawei Cloud-Kafka collection, the default metric sets are as follows. You can collect more metrics through configuration [Huawei Cloud Cloud Monitoring Metric Details](https://support.huaweicloud.com/usermanual-kafka/kafka-ug-180413002.html){:target="_blank"}

### Instance Monitoring Metrics

| Metric Name | Metric Meaning | Unit | Dimension |
| -------- | -------- | -------- | -------- |
| current_partitions | This metric counts the number of partitions already used in the Kafka instance | Count | instance_id |
| current_topics | This metric counts the number of topics already created in the Kafka instance | Count | instance_id |
| group_msgs | This metric counts the total backlog message count in all consumer groups of the Kafka instance | Count | instance_id |

### Node Monitoring Metrics
| Metric Name | Metric Meaning | Unit | Dimension |
| -------- | -------- | -------- | -------- |
| broker_data_size | This metric counts the current message data size of the node | Byte | instance_id |
| broker_messages_in_rate | This metric counts the number of messages produced per second | Count/s | instance_id |
| broker_bytes_in_rate | This metric counts the number of bytes produced per second | Byte/s | instance_id |
| broker_bytes_out_rate | This metric counts the number of bytes consumed per second | Byte/s | instance_id |
| broker_public_bytes_in_rate | Statistics on public network incoming traffic per second for Broker nodes | Byte/s | instance_id |
| broker_public_bytes_out_rate | Statistics on public network outgoing traffic per second for Broker nodes | Byte/s | instance_id |
| broker_fetch_mean | Statistics on average processing time for consumption requests on Broker nodes | ms | instance_id |
| broker_produce_mean | Average processing time for production requests | ms | instance_id |
| broker_cpu_core_load | Average load of each CPU core of Kafka node VM | % | instance_id |
| broker_disk_usage | Disk usage rate of Kafka node VM | % | instance_id |
| broker_memory_usage | Memory usage rate of Kafka node VM | % | instance_id |
| broker_heap_usage | Heap memory usage rate of Kafka process JVM on Kafka node | % | instance_id |
| broker_alive | Indicates whether the Kafka node is alive | 1: Alive 0: Offline | instance_id |
| broker_connections | Current TCP connection count of Kafka node | Count | instance_id |
| broker_cpu_usage | CPU usage rate of Kafka node VM | % | instance_id |
| broker_total_bytes_in_rate | Network incoming traffic per second for Broker nodes | Byte/s | instance_id |
| broker_total_bytes_out_rate | Network outgoing traffic per second for Broker nodes | Byte/s | instance_id |
| broker_disk_read_rate | Disk read operation traffic | Byte/s | instance_id |
| broker_disk_write_rate | Disk write operation traffic | Byte/s | instance_id |
| network_bandwidth_usage | Network bandwidth utilization | % | instance_id |

### Consumer Group Monitoring Metrics
| Metric Name | Metric Meaning | Unit | Dimension |
| -------- | -------- | -------- | -------- |
| messages_consumed | This metric counts the number of messages consumed by the current consumer group | Count | instance_id |
| messages_remained | This metric counts the number of messages that can be consumed by the consumer group | Count | instance_id |
| topic_messages_remained | This metric counts the number of messages that can be consumed by the specified queue of the consumer group | Count | instance_id |
| topic_messages_consumed | This metric counts the number of messages currently consumed by the specified queue of the consumer group | Count | instance_id |
| consumer_messages_remained | This metric counts the number of messages that can still be consumed by the consumer group | Count | instance_id |
| consumer_messages_consumed | This metric counts the number of messages currently consumed by the consumer group | Count | instance_id |


## Objects {#object}

The structure of the collected Huawei Cloud Kafka object data can be seen in the object data from「Infrastructure-Custom」

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

> *Note: The fields in `tags`, `fields` may vary with subsequent updates.*
>
> Note 1: The value of `tags.name` is the instance ID, used as a unique identifier.
>
> Note 2: The following fields are serialized JSON strings.