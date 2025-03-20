---
title: 'Huawei Cloud DMS Kafka'
tags: 
  - Huawei Cloud
summary: 'Collect Huawei Cloud DMS Kafka Metrics data'
__int_icon: 'icon/huawei_kafka'
dashboard:

  - desc: 'Huawei Cloud Kafka Built-in Views'
    path: 'dashboard/en/huawei_kafka'

monitor:
  - desc: 'Huawei Cloud Kafka Monitors'
    path: 'monitor/en/huawei_kafka'

---

Collect Huawei Cloud DMS Kafka Metrics data

## Configuration {#config}

### Install Func

It is recommended to activate Guance Integration - Extension - DataFlux Func (Automata): all prerequisites will be automatically installed, please proceed with the script installation.

If you deploy Func yourself, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize Huawei Cloud Kafka monitoring data, we install the corresponding collection script: by accessing the web service of func and entering the 【Script Market】, 「Guance Integration (Huawei Cloud-Kafka Collection)」(ID: `guance_huaweicloud_kafka`)

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK, SK, Huawei Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After the script is installed, find the script 「Guance Integration (Huawei Cloud-Kafka Collection)」in the "Development" section of Func, expand and modify this script. Find `collector_configs` and `monitor_configs` respectively and edit the content of `region_projects`. Change the region and Project ID to the actual region and Project ID, then click Save and Publish.

In addition, you can see the corresponding automatic trigger configuration in the 「Management / Automatic Trigger Configuration」. Click 【Execute】to immediately execute once without waiting for the scheduled time. After a while, you can view the execution task records and corresponding logs.

### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm whether the corresponding tasks have the corresponding automatic trigger configurations. You can also check the corresponding task records and logs to check for any abnormalities.
2. On the Guance platform, in 「Infrastructure - Resource Catalog」, check if there is any asset information.
3. On the Guance platform, in 「Metrics」, check if there are any corresponding monitoring data.

## Metrics {#metric}

Collect Huawei Cloud DMS Kafka Metrics data, you can collect more metrics through configuration [Huawei Cloud DMS kafka Metrics Details](https://support.huaweicloud.com/usermanual-kafka/kafka-ug-180413002.html){:target="_blank"}

### Instance Monitoring Metrics

| Metric Name | Metric Meaning | Unit | Dimension |
| ----------- | -------------- | ---- | --------- |
| current_partitions | This metric counts the number of partitions already used in the Kafka instance | Count | instance_id |
| current_topics | This metric counts the number of topics already created in the Kafka instance | Count | instance_id |
| group_msgs | This metric counts the total backlog messages in all consumer groups in the Kafka instance | Count | instance_id |

### Node Monitoring Metrics

| Metric Name | Metric Meaning | Unit | Dimension |
| ----------- | -------------- | ---- | --------- |
| broker_data_size | This metric counts the current message data size on the node | Byte | instance_id |
| broker_messages_in_rate | This metric counts the number of messages produced per second | Count/s | instance_id |
| broker_bytes_in_rate | This metric counts the number of bytes produced per second | Byte/s | instance_id |
| broker_bytes_out_rate | This metric counts the number of bytes consumed per second | Byte/s | instance_id |
| broker_public_bytes_in_rate | Counts the public network incoming traffic per second for the Broker node | Byte/s | instance_id |
| broker_public_bytes_out_rate | Counts the public network outgoing traffic per second for the Broker node | Byte/s | instance_id |
| broker_fetch_mean | Counts the average processing time for consumption requests on the Broker node | ms | instance_id |
| broker_produce_mean | Average processing time for production requests | ms | instance_id |
| broker_cpu_core_load | CPU average load per core collected at the virtual machine level for the Kafka node | % | instance_id |
| broker_disk_usage | Disk capacity usage rate collected at the virtual machine level for the Kafka node | % | instance_id |
| broker_memory_usage | Memory usage rate collected at the virtual machine level for the Kafka node | % | instance_id |
| broker_heap_usage | Heap memory usage rate collected from the Kafka process JVM on the Kafka node | % | instance_id |
| broker_alive | Indicates whether the Kafka node is alive | 1: Alive 0: Offline | instance_id |
| broker_connections | The number of all current TCP connections on the Kafka node | Count | instance_id |
| broker_cpu_usage | CPU usage rate of the virtual machine for the Kafka node | % | instance_id |
| broker_total_bytes_in_rate | Network access incoming traffic per second for the Broker node | Byte/s | instance_id |
| broker_total_bytes_out_rate | Network access outgoing traffic per second for the Broker node | Byte/s | instance_id |
| broker_disk_read_rate | Disk read operation traffic | Byte/s | instance_id |
| broker_disk_write_rate | Disk write operation traffic | Byte/s | instance_id |
| network_bandwidth_usage | Network bandwidth utilization | % | instance_id |

### Consumer Group Monitoring Metrics

| Metric Name | Metric Meaning | Unit | Dimension |
| ----------- | -------------- | ---- | --------- |
| messages_consumed | This metric counts the number of messages already consumed by the current consumer group | Count | instance_id |
| messages_remained | This metric counts the number of messages available for consumption by the consumer group | Count | instance_id |
| topic_messages_remained | This metric counts the number of messages available for consumption in the specified queue for the consumer group | Count | instance_id |
| topic_messages_consumed | This metric counts the number of messages already consumed in the specified queue for the consumer group | Count | instance_id |
| consumer_messages_remained | This metric counts the number of messages remaining for consumption by the consumer group | Count | instance_id |
| consumer_messages_consumed | This metric counts the number of messages already consumed by the consumer group | Count | instance_id |

## Objects {#object}

The structure of the collected Huawei Cloud Kafka object data can be viewed in 「Infrastructure - Resource Catalog」

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

> *Note: Fields in `tags`, `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, which serves as a unique identifier.
>
> Tip 2: The following fields are all strings serialized in JSON.