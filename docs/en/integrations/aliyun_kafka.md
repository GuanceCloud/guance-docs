---
title: 'aliyun Kafka'
summary: 'AliCloud Kafka's presentation metrics include message throughput, latency, number of concurrent connections, and reliability, which reflect Kafka's performance performance and reliability guarantees when dealing with large-scale messaging and real-time data streams.'
__int_icon: 'icon/aliyun_kafka'
dashboard:

  - desc: 'aliyun Kafka Dashboard'  
    path: 'dashboard/zh/aliyun_kafka'

monitor:
  - desc: 'aliyun Kafka Monitor'
    path: 'monitor/zh/aliyun_kafka/'

---

<!-- markdownlint-disable MD025 -->
# Aliyun Kafka
<!-- markdownlint-enable -->

Aliyun Kafka's presentation metrics include message throughput, latency, number of concurrent connections, and reliability, which reflect Kafka's performance performance and reliability guarantees when dealing with large-scale messaging and real-time data streams.

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of Kafka, install the corresponding data collection script: "Guance Integration (aliyun - Kafka)" (ID: `guance_aliyun_kafka`).

Click 【Install】 and enter the corresponding parameters: Aliyun AK, Aliyun account name.

Click [Deploy Startup Scripts], the system will automatically create the `Startup` script set and automatically configure the corresponding startup scripts.

You can see the corresponding auto-trigger configuration in "Management / Auto-trigger Configuration" after you turn it on. Click "Execute" to execute the task immediately without waiting for the regular time. Wait for a while, you can check the record and log of the executed task.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verify

1. Check whether the automatic triggering configuration exists for the corresponding task in "Management / Crontab Config". Additionally, you can review task records and logs to identify any exceptions.
2. On the Guance platform, go to "Infrastructure / Custom" to verify the presence of asset information.
3. Press "Metrics" on the Guance platform to confirm the availability of monitoring data.

## Metrics {#metric}
Configure AliCloud-Cloud Monitor, the default set of metrics are as follows, you can configure the way to collect more metrics [AliCloud Cloud Monitor metrics details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                      | Metric Name                    | Dimensions        | Statistics      | Unit     |
| -------------------- | ------------------- | ------------------------------------------------------- | ---- | ---------- |
| instance_disk_capacity_Maximum | instance_disk_capacity_Maximum | userId,instanceId | Average,Maximum | KBytes/s |
| instance_message_input         | instance_message_input         | userId,instanceId | Average,Maximum | messages |
| instance_message_num_inp       | instance_message_num_inp       | userId,instanceId | Average,Maximum | messages |
| instance_message_output        | instance_message_output        | userId,instanceId | Average,Maximum | messages |
| instance_reqs_input            | instance_reqs_input            | userId,instanceId | Average,Maximum | Count    |
| instance_reqs_output           | instance_reqs_output           | userId,instanceId | Average,Maximum | Count    |

## Objects {#object}

The collected Aliyun Kafka object data structure can be viewed from "Infrastructure / Custom".

```json


{
  "measurement": "aliyun_kafka",
  "tags": {
    "InstanceId"        : "alikafka_post-cn-zsk3cluq100d",
    "InstanceName"      : "alikafka_post-cn-zsk3cluq100d",
    "RegionId"          : "cn-hangzhou",
    "ResourceGroupId"   : "rg-acfmv3ro3xnfwaa",
    "SpecType"          : "normal",
    "cloud_provider"    : "aliyun",
    "name"              : "alikafka_post-cn-zsk3cluq100d"
  },
  "fields": {
    "AllConfig"         : "{}",
    "CreateTime"        : 1692080715000,
    "DeployType"        : 5,
    "EipMax"            : 0,
    "ExpiredTime"       : 2007699914000,
    "IoMax"             : 20,
    "IoMaxSpec"         : "alikafka.hw.2xlarge",
    "PaidType"          : 1,
    "ServiceStatus"     : 0,
    "TopicNumLimit"     : 1000,
    "UsedGroupCount"    : 0,
    "UsedTopicCount"    : 0,
  }
}
```

