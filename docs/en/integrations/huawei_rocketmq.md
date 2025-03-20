---
title: 'Huawei Cloud DMS RocketMQ'
tags: 
  - Huawei Cloud
summary: 'Collect Metrics data from Huawei Cloud DMS RocketMQ'
__int_icon: 'icon/huawei_rocketmq'
dashboard:
  - desc: 'Huawei Cloud RocketMQ built-in view'
    path: 'dashboard/en/huawei_rocketmq/'

monitor:
  - desc: 'Huawei Cloud RocketMQ monitors'
    path: 'monitor/en/huawei_rocketmq/'
---

Collect Metrics data from Huawei Cloud DMS RocketMQ

## Configuration {#config}

### Install Func

It is recommended to enable Guance Integration - Extension - Managed Func: all prerequisites will be automatically installed, please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/)

> It is recommended to deploy the GSE version.

### Install Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize the monitoring data of RocketMQ cloud resources, we install the corresponding collection script: "Guance Integration (Huawei Cloud - RocketMQ)" (ID: `guance_huaweicloud_rocketmq`).

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create the `Startup` script set and automatically configure the corresponding startup script.

After the script is installed, find the script "Guance Integration (Huawei Cloud - RocketMQ)" under "Development" in Func, unfold and modify this script. Find `collector_configs` and `monitor_configs`, respectively edit the content of `region_projects`, change the region and Project ID to the actual region and Project ID, then click Save and Publish.

In addition, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the regular time. After a while, you can check the execution task records and corresponding logs.

### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and at the same time, you can check the corresponding task records and logs for any abnormalities.
2. On the Guance platform, in "Infrastructure - Resource Catalog", check if there is asset information.
3. On the Guance platform, in "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}

Configure Huawei Cloud DMS RocketMQ Metrics, more Metrics can be collected through configuration [Huawei Cloud DMS RocketMQ Metrics Details](https://support.huaweicloud.com/usermanual-hrm/hrm-ug-018.html){:target="_blank"}

| **Metric ID**            |          **Metric Name**   | **Metric Meaning** | **Value Range**      | **Measurement Object** | **Monitoring Cycle (Raw Metric)** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| instance_produce_msg |        Messages Produced        | The number of messages received by the instance per minute Unit: Count | >0 | RocketMQ Instance     | 1 minute    |
| instance_consume_msg | Messages Consumed | The number of messages consumed by the instance per minute Unit: Count | >0 | RocketMQ Instance     | 1 minute |
| current_topics | Topics Count | The number of topics in the instance Unit: Count![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >=0 | RocketMQ Instance     | 1 minute |
| current_queues | Queues Count | The number of queues in the instance Unit: Count![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >=0 | RocketMQ Instance     | 1 minute |
| instance_accumulation | Accumulated Messages | The sum of accumulated messages for all consumer groups in the instance Unit: Count![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >=0 | RocketMQ Instance     | 1 minute |
| broker_produce_msg | Messages Produced | The number of messages received by the node per minute Unit: Count | >0 | RocketMQ Instance Node | 1 minute |
| broker_consume_msg | Messages Consumed | The number of messages consumed by the node per minute Unit: Count | >0 | RocketMQ Instance Node | 1 minute |
| broker_produce_rate | Message Production Rate | The number of messages received per second by the node Unit: Count/s | >0 | RocketMQ Instance Node | 1 minute |
| broker_consume_rate | Message Consumption Rate | The number of messages consumed per second by the node Unit: Count/s | >0 | RocketMQ Instance Node | 1 minute |
| broker_total_bytes_in_rate | Network Inbound Traffic | The network access inflow traffic received per second by the node Unit: Byte/s | >0 | RocketMQ Instance Node | 1 minute |
| broker_total_bytes_out_rate | Network Outbound Traffic | The network access outflow traffic sent per second by the node Unit: Byte/s | >0 | RocketMQ Instance Node | 1 minute |
| broker_cpu_core_load | CPU Core Load | This metric is used to calculate the average load of each core of the virtual machine's CPU on the node | >0 | RocketMQ Instance Node | 1 minute |
| broker_disk_usage | Disk Capacity Usage | This metric is used to calculate the disk capacity usage rate of the virtual machine on the node Unit: % | 0~100 | RocketMQ Instance Node | 1 minute |
| broker_memory_usage | Memory Usage | This metric is used to calculate the memory usage rate of the virtual machine on the node Unit: % | 0~100 | RocketMQ Instance Node | 1 minute |
| broker_alive | Node Alive Status | Node alive status![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | 1: Alive 0: Offline | RocketMQ Instance Node | 1 minute |
| broker_connections | Connections Count | The number of connections used by the virtual machine Unit: Count![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >=0 | RocketMQ Instance Node | 1 minute |
| broker_cpu_usage | CPU Usage | The CPU usage rate of the virtual machine Unit: %![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >=0 | RocketMQ Instance Node | 1 minute |
| broker_disk_read_rate | Disk Read Traffic | Disk read operation traffic Unit: Byte/s![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >=0 | RocketMQ Instance Node | 1 minute |
| broker_disk_write_rate | Disk Write Traffic | Disk write operation traffic Unit: Byte/s![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >=0 | RocketMQ Instance Node | 1 minute |
| topic_produce_msg | Messages Produced | The number of messages received by the Topic per minute Unit: Count | >0 | RocketMQ Instance Queue | 1 minute |
| topic_consume_msg | Messages Consumed | The number of messages consumed by the Topic per minute Unit: Count | >0 | RocketMQ Instance Queue | 1 minute |
| topic_produce_rate | Message Production Rate | The number of messages received per second by the Topic Unit: Count/s | >0 | RocketMQ Instance Queue | 1 minute |
| topic_consume_rate | Message Consumption Rate | The number of messages consumed per second by the Topic Unit: Count/s | >0 | RocketMQ Instance Queue | 1 minute |
| topic_bytes_in_rate | Production Traffic | The production traffic of the current topic Unit: Byte/s![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >=0 | RocketMQ Instance Queue | 1 minute |
| topic_bytes_out_rate | Consumption Traffic | The consumption traffic of the current topic Unit: Byte/s![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png)**Note:** Instances purchased on or after May 16, 2022 support this monitoring item. | >=0 | RocketMQ Instance Queue | 1 minute |

## Objects {#object}

After the data is synchronized normally, you can view the data in the "Infrastructure - Resource Catalog" of Guance.

```json
{
  "measurement": "huaweicloud_rocketmq",
  "tags": {      
    "RegionId"              : "cn-north-4",
    "project_id"            : "756ada1aa17e4049b2a16ea41912e52d",
    "enterprise_project_id" : "o78hhbss-xxxx-xxxx-xxxx-cba3d38cf2f9",
    "instance_id"           : "c0b0ea90-xxxx-xxxx-xxxx-cba3d38cf2f9",
    "instance_name"         : "rocketmq-xxxxx",
    "engine"                : "reliability",
    "status"                : "RUNNING"  
  },
  "fields": {
    "charging_mode"      : "1",
    "type"               : "cluster.small",
    "engine_version"     : "4.8.0",
    "description"        : "",
    "specification"      : "rocketmq.4u8g.cluster.small * 1 broker",
    "storage_space"      : 250,
    "used_storage_space" : 0,
    "resource_spec_code" : "xxxx",
    "created_at"         : "1687158517888",
    "maintain_begin"     : "02:00:00",
    "maintain_end"       : "06:00:00",
    "enable_publicip"    : false,
    "publicip_address"   : "12.xx.xx.32",
    "publicip_id"        : "xxxxxxxxxxxxxxxxxxxss",
    "total_storage_space": 300,
    "available_zones"    : "xxxxxx"
  }
}
```

Some field explanations are as follows:

| Field                 | Type   | Explanation                                                         |
| :------------------- | :----- | :----------------------------------------------------------- |
| `specification`      | String | Instance specification.                                                   |
| `charging_mode`      | String | Billing mode, 1 indicates pay-as-you-go billing, 0 indicates annual/monthly billing.                |
| `created_at`         | String | Completion creation time. Format is timestamp, indicating the total milliseconds deviation from Greenwich Mean Time January 01, 1970 00:00:00 to the specified time. |
| `resource_spec_code` | String | Resource specification                                                     |
| `maintain_begin`     | String | Maintenance window start time, format HH:mm:ss                           |
| `maintain_end`       | String | Maintenance window end time, format HH:mm:ss                           |

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.instance_id` is the instance ID, which serves as a unique identifier.