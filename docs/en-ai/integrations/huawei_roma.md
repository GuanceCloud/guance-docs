---
title: 'Huawei Cloud ROMA'
tags: 
  - Huawei Cloud
summary: 'Use the "Guance Cloud Sync" script package series from the script market to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/huawei_roma'
dashboard:
  - desc: 'Huawei Cloud ROMA for Kafka'
    path: 'dashboard/en/huawei_roma_kafka'


---


<!-- markdownlint-disable MD025 -->
# Huawei Cloud ROMA
<!-- markdownlint-enable -->

Use the "Guance Cloud Sync" script package series from the script market to synchronize cloud monitoring and cloud asset data to Guance.


## Configuration {#config}

### Install Func

We recommend enabling the Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Prepare a Huawei Cloud AK in advance that meets the requirements (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data from Huawei Cloud ROMA, install the corresponding collection script: access the web service of func and enter the 【Script Market】, then select 「Guance Integration (Huawei Cloud-ROMA Collection)」(ID: `guance_huaweicloud_roma`).

After clicking 【Install】, enter the required parameters: Huawei Cloud AK, SK, and Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Once the script is installed, find the script 「Guance Integration (Huawei Cloud-Kafka Collection)」 under 「Development」 in Func, expand and modify this script. Edit the `region_projects` content under `collector_configs` and `monitor_configs`, changing the region and Project ID to the actual ones, then click Save and Publish.

Additionally, view the corresponding automatic trigger configuration under 「Management / Automatic Trigger Configuration」. Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.


### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm that the corresponding tasks have the appropriate automatic trigger configurations, and check the task records and logs for any anomalies.
2. In the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. In the Guance platform, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}
For configuring Huawei Cloud-`ROMA` collection, the default metrics set is as follows. You can collect more metrics by configuring them [Huawei Cloud ROMA Metrics Details](https://support.huaweicloud.com/usermanual-roma/roma_03_0023.html#section4){:target="_blank"}

### Instance Monitoring Metrics

| Metric Name  | Metric Meaning  | Unit  | Dimensions  |
| -------- | -------- | -------- | -------- |
| current_partitions | This metric counts the number of partitions used in the Kafka instance | Count | instance_id |
| current_topics | This metric counts the number of topics created in the Kafka instance | Count | instance_id |
| group_msgs | This metric counts the total number of backlog messages in all consumer groups in the Kafka instance | Count | instance_id |

### Node Monitoring Metrics
| Metric Name  | Metric Meaning  | Unit  | Dimensions  |
| -------- | -------- | -------- | -------- |
| broker_data_size | This metric counts the size of message data on the node | Byte | instance_id |
| broker_messages_in_rate | This metric counts the number of messages produced per second | Count/s | instance_id |
| broker_bytes_in_rate | This metric counts the number of bytes produced per second | Byte/s | instance_id |
| broker_bytes_out_rate | This metric counts the number of bytes consumed per second | Byte/s | instance_id |
| broker_public_bytes_in_rate | This metric counts the inbound public network traffic per second on the Broker node | Byte/s | instance_id |
| broker_public_bytes_out_rate | This metric counts the outbound public network traffic per second on the Broker node | Byte/s | instance_id |
| broker_fetch_mean | This metric counts the average duration of processing consumption requests on the Broker node | ms | instance_id |
| broker_produce_mean | This metric counts the average duration of processing production requests on the Broker node | ms | instance_id |
| broker_cpu_core_load | This metric collects the average load on each CPU core of the Kafka node VM | % | instance_id |
| broker_disk_usage | This metric collects the disk usage rate of the Kafka node VM | % | instance_id |
| broker_memory_usage | This metric collects the memory usage rate of the Kafka node VM | % | instance_id |
| broker_heap_usage | This metric collects the heap memory usage rate of the Kafka process in the Kafka node JVM | % | instance_id |
| broker_alive | Indicates whether the Kafka node is alive | 1: Alive 0: Offline | instance_id |
| broker_connections | The total number of TCP connections on the Kafka node | Count | instance_id |
| broker_cpu_usage | The CPU usage rate of the Kafka node VM | % | instance_id |
| broker_total_bytes_in_rate | Network inbound traffic per second on the Broker node | Byte/s | instance_id |
| broker_total_bytes_out_rate | Network outbound traffic per second on the Broker node | Byte/s | instance_id |
| broker_disk_read_rate | Disk read operation traffic | Byte/s | instance_id |
| broker_disk_write_rate | Disk write operation traffic | Byte/s | instance_id |
| network_bandwidth_usage | Network bandwidth utilization | % | instance_id |

### Consumer Group Monitoring Metrics
| Metric Name  | Metric Meaning  | Unit  | Dimensions  |
| -------- | -------- | -------- | -------- |
| messages_consumed | This metric counts the number of messages consumed by the current consumer group | Count | instance_id |
| messages_remained | This metric counts the number of messages available for consumption by the consumer group | Count | instance_id |
| topic_messages_remained | This metric counts the number of messages available for consumption by the specified queue of the consumer group | Count | instance_id |
| topic_messages_consumed | This metric counts the number of messages consumed by the specified queue of the consumer group | Count | instance_id |
| consumer_messages_remained | This metric counts the number of messages remaining for consumption by the consumer group | Count | instance_id |
| consumer_messages_consumed | This metric counts the number of messages consumed by the consumer group | Count | instance_id |


## Objects {#object}

The collected Huawei Cloud ROMA object data structure can be viewed in 「Infrastructure - Custom」

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

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Note 1: The value of `tags.name` is the instance ID, used for unique identification.
>
> Note 2: The following fields are serialized JSON strings.