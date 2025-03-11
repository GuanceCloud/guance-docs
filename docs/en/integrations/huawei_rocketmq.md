---
title: 'Huawei Cloud DMS RocketMQ'
tags: 
  - Huawei Cloud
summary: 'Use the script packages in the script market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance.'
__int_icon: 'icon/huawei_rocketmq'
dashboard:
  - desc: 'Huawei Cloud RocketMQ built-in view'
    path: 'dashboard/en/huawei_rocketmq/'

monitor:
  - desc: 'Huawei Cloud RocketMQ monitor'
    path: 'monitor/en/huawei_rocketmq/'
---


<!-- markdownlint-disable MD025 -->
# Huawei Cloud DMS RocketMQ
<!-- markdownlint-enable -->

Use the script packages in the script market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance.

## Configuration {#config}

### Install Func

It is recommended to enable Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with the script installation

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/)

> It is recommended to deploy the GSE version

### Install Script

> Note: Please prepare a qualified Huawei Cloud AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize the monitoring data of RocketMQ cloud resources, we install the corresponding collection script: "Guance Integration (Huawei Cloud - RocketMQ)" (ID: `guance_huaweicloud_rocketmq`)

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK, Huawei Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and configure the corresponding startup script automatically.

After the script is installed, find the script "Guance Integration (Huawei Cloud - RocketMQ)" under "Development" in Func, expand and modify this script. Find `collector_configs` and `monitor_configs` and edit the content of `region_projects`, changing the region and Project ID to the actual region and Project ID, then click Save and Publish.

Additionally, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. Wait a moment, you can check the execution task records and corresponding logs.

We default to collecting some configurations, see the Metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-rocketmq/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and check the corresponding task records and logs for any anomalies.
2. On the Guance platform, in "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, in "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Huawei Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration [Huawei Cloud Cloud Monitoring Metric Details](https://support.huaweicloud.com/usermanual-hrm/hrm-ug-018.html){:target="_blank"}

| **Metric ID**            |          **Metric Name**   | **Metric Meaning** | **Value Range**      | **Measurement Object** | **Monitoring Period (Original Metric)** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| instance_produce_msg |        Message Production Count        | Number of messages received by the instance per minute unit: Count | >0 | RocketMQ Instance     | 1 minute    |
| instance_consume_msg | Message Consumption Count | Number of messages consumed by the instance per minute unit: Count | >0 | RocketMQ Instance     | 1 minute |
| current_topics | Topic Count | Number of topics in the instance unit: Count![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >=0 | RocketMQ Instance     | 1 minute |
| current_queues | Queue Count | Number of queues in the instance unit: Count![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >=0 | RocketMQ Instance     | 1 minute |
| instance_accumulation | Accumulated Message Count | Sum of accumulated messages across all consumer groups in the instance unit: Count![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >=0 | RocketMQ Instance     | 1 minute |
| broker_produce_msg | Message Production Count | Number of messages received by the node per minute unit: Count | >0 | RocketMQ Instance Node | 1 minute |
| broker_consume_msg | Message Consumption Count | Number of messages consumed by the node per minute unit: Count | >0 | RocketMQ Instance Node | 1 minute |
| broker_produce_rate | Message Production Rate | Number of messages received by the node per second unit: Count/s | >0 | RocketMQ Instance Node | 1 minute |
| broker_consume_rate | Message Consumption Rate | Number of messages consumed by the node per second unit: Count/s | >0 | RocketMQ Instance Node | 1 minute |
| broker_total_bytes_in_rate | Network Inbound Traffic | Network access inbound traffic per second unit: Byte/s | >0 | RocketMQ Instance Node | 1 minute |
| broker_total_bytes_out_rate | Network Outbound Traffic | Network access outbound traffic per second unit: Byte/s | >0 | RocketMQ Instance Node | 1 minute |
| broker_cpu_core_load | Average CPU Core Load | This metric is used to calculate the average load of each core of the virtual machine's CPU | >0 | RocketMQ Instance Node | 1 minute |
| broker_disk_usage | Disk Usage | This metric is used to calculate the disk usage percentage of the virtual machine unit: % | 0~100 | RocketMQ Instance Node | 1 minute |
| broker_memory_usage | Memory Usage | This metric is used to calculate the memory usage percentage of the virtual machine unit: % | 0~100 | RocketMQ Instance Node | 1 minute |
| broker_alive | Node Status | Node status![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | 1: Alive 0: Offline | RocketMQ Instance Node | 1 minute |
| broker_connections | Connection Count | Number of connections used by the virtual machine unit: Count![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >=0 | RocketMQ Instance Node | 1 minute |
| broker_cpu_usage | CPU Usage | Virtual machine CPU usage percentage unit: %![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >=0 | RocketMQ Instance Node | 1 minute |
| broker_disk_read_rate | Disk Read Throughput | Disk read operation throughput unit: Byte/s![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >=0 | RocketMQ Instance Node | 1 minute |
| broker_disk_write_rate | Disk Write Throughput | Disk write operation throughput unit: Byte/s![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >=0 | RocketMQ Instance Node | 1 minute |
| topic_produce_msg | Message Production Count | Number of messages received by the topic per minute unit: Count | >0 | RocketMQ Instance Queue | 1 minute |
| topic_consume_msg | Message Consumption Count | Number of messages consumed by the topic per minute unit: Count | >0 | RocketMQ Instance Queue | 1 minute |
| topic_produce_rate | Message Production Rate | Number of messages received by the topic per second unit: Count/s | >0 | RocketMQ Instance Queue | 1 minute |
| topic_consume_rate | Message Consumption Rate | Number of messages consumed by the topic per second unit: Count/s | >0 | RocketMQ Instance Queue | 1 minute |
| topic_bytes_in_rate | Production Throughput | Current topic production throughput unit: Byte/s![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >=0 | RocketMQ Instance Queue | 1 minute |
| topic_bytes_out_rate | Consumption Throughput | Current topic consumption throughput unit: Byte/s![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >=0 | RocketMQ Instance Queue | 1 minute |

## Objects {#object}

After data synchronization is normal, you can view the data in the "Infrastructure / Custom (Objects)" section of Guance.

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
    "message"            : "{Instance JSON Data}"
  }
}
```

Descriptions of some fields are as follows:

| Field                 | Type   | Description                                                         |
| :------------------- | :----- | :----------------------------------------------------------- |
| `specification`      | String | Instance specification.                                                   |
| `charging_mode`      | String | Billing mode, 1 indicates pay-as-you-go, 0 indicates subscription billing.                |
| `created_at`         | String | Completion creation time. Format is timestamp, indicating the total milliseconds since January 1, 1970, 00:00:00 GMT. |
| `resource_spec_code` | String | Resource specification                                                     |
| `maintain_begin`     | String | Maintenance window start time, format HH:mm:ss                           |
| `maintain_end`       | String | Maintenance window end time, format HH:mm:ss                           |

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, used as a unique identifier.
>
> Tip 2:
>
> - `fields.message`, `fields.listeners` are serialized JSON strings.
> - `tags.operating_status` represents the operational status of the load balancer. Possible values: ONLINE, FROZEN.
