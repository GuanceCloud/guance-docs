---
title: 'Tencent Cloud CKafka'
tags: 
  - Tencent Cloud
summary: 'The displayed metrics for Tencent Cloud CKafka include message throughput, latency, concurrent connections, and reliability. These metrics reflect the performance and reliability of CKafka in handling large-scale message delivery and real-time data streams.'
__int_icon: 'icon/tencent_ckafka'
dashboard:

  - desc: 'Tencent Cloud CKafka Monitoring View'
    path: 'dashboard/en/tencent_ckafka'

monitor:
  - desc: 'Tencent CKafka Monitor'
    path: 'monitor/en/tencent_ckafka'
---

<!-- markdownlint-disable MD025 -->
# Tencent Cloud CKafka
<!-- markdownlint-enable -->

The displayed metrics for Tencent Cloud CKafka include message throughput, latency, concurrent connections, and reliability. These metrics reflect the performance and reliability of CKafka in handling large-scale message delivery and real-time data streams.

## Configuration {#config}

### Install Func

We recommend enabling Guance Integration - Extensions - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install CKafka Collection Script

> Note: Please prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant read-only access `ReadOnlyAccess`).

To synchronize CKafka monitoring data, we install the corresponding collection script: "Guance Integration (Tencent Cloud-CKafka)" (ID: `guance_tencentcloud_ckafka`)

After clicking 【Install】, enter the required parameters: Tencent Cloud AK, Tencent Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the startup script accordingly.

Once enabled, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click 【Execute】to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

By default, we collect some configurations. For details, see [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}

### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have the automatic trigger configuration and check the task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, under "Metrics", check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Tencent Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration [Tencent Cloud Cloud Monitoring Metrics Details](https://cloud.tencent.com/document/product/248/45121){:target="_blank"}

### Performance Metrics

| Metric Name          | Metric Description       | Metric Meaning                                           | Unit | Dimension       |
| ------------------- | ---------------- | -------------------------------------------------- | ---- | ---------- |
| InstanceProCount    | Number of Messages Produced by Instance | Number of messages produced by the instance, summed up according to the selected time granularity     | Count   | instanceId |
| InstanceConCount    | Number of Messages Consumed by Instance | Number of messages consumed by the instance, summed up according to the selected time granularity     | Count   | instanceId |
| InstanceConReqCount | Number of Consumption Requests by Instance | Number of consumption requests at the instance level, summed up according to the selected time granularity | Count   | instanceId |
| InstanceProReqCount | Number of Production Requests by Instance | Number of production requests at the instance level, summed up according to the selected time granularity | Count   | instanceId |

### System Metrics

| Metric Name        | Metric Description     | Metric Meaning                                 | Unit | Dimension       |
| ----------------- | -------------- | ---------------------------------------- | ---- | ---------- |
| InstanceDiskUsage | Disk Usage Percentage | Current disk usage as a percentage of the total disk capacity of the instance | %    | instanceId |

### Cumulative Usage Metrics

| Metric Name                         | Metric Description                              | Metric Meaning                                                     | Unit | Dimension       |
| ---------------------------------- | --------------------------------------- | ------------------------------------------------------------ | ---- | ---------- |
| InstanceConnectCount               | Number of Connections | Number of client-server connections                                       | Count   | instanceId |
| InstanceConFlow                    | Consumption Traffic | Consumption traffic (excluding replica traffic), summed up according to the selected time granularity | MB   | instanceId |
| InstanceMaxConFlow                 | Peak Consumption Bandwidth | Peak consumption bandwidth (no concept of replicas during consumption)                   | MB/s | instanceId |
| InstanceMaxProFlow                 | Peak Production Bandwidth | Peak production bandwidth (excluding replica bandwidth)                 | MB/s | instanceId |
| InstanceMsgCount                   | Total Number of Persisted Messages | Total number of persisted messages (excluding replicas), latest value taken according to the selected time granularity | Count   | instanceId |
| InstanceMsgHeap                    | Disk Usage | Disk usage (including replicas), latest value taken according to the selected time granularity     | MB   | instanceId |
| InstanceProFlow                    | Production Traffic | Production traffic (excluding replica traffic), summed up according to the selected time granularity | MB   | instanceId |
| InstanceConnectPercentage          | Connection Percentage | Connection percentage (client and server connections as a percentage of quota)           | %    | instanceId |
| InstanceConsumeBandwidthPercentage | Consumption Bandwidth Percentage | Consumption bandwidth percentage (instance consumption bandwidth as a percentage of quota)                 | %    | instanceId |
| InstanceConsumeGroupNum            | Number of Consumer Groups | Number of consumer groups                                             | Count   | instanceId |
| InstanceConsumeGroupPercentage     | Consumer Group Percentage | Consumer group percentage (number of consumer groups as a percentage of quota)                 | %    | instanceId |
| InstanceConsumeThrottle            | Number of Consumption Throttling Events | Number of consumption throttling events                                             | Count   | instanceId |
| InstancePartitionNum               | Number of Partitions | Number of partitions                                          | Count   | instanceId |
| InstancePartitionPercentage        | Partition Percentage (Quota Usage) | Partition percentage (quota usage)                      | %    | instanceId |
| InstanceProduceBandwidthPercentage | Production Bandwidth Percentage | Production bandwidth percentage (quota usage)                         | %    | instanceId |
| InstanceProduceThrottle            | Number of Production Throttling Events | Number of production throttling events                                             | Count   | instanceId |
| InstanceReplicaProduceFlow         | Peak Production Bandwidth | Peak production bandwidth (including replica bandwidth)                   | MB/s | instanceId |
| InstanceTopicNum                   | Number of Topics | Number of topics                                              | Count   | instanceId |
| InstanceTopicPercentage            | Topic Percentage | Topic percentage (quota usage)                                | %    | instanceId |

## Objects {#object}

The collected Tencent Cloud CKafka object data structure can be viewed in "Infrastructure - Custom"

```json
{
  "Healthy": "1",
  "account_name": "guance",
  "InstanceType": "profession",
  "RenewFlag": "0",
  "SubnetId": "subnet-bp2jqhcj",
  "Vip": "172.17.32.16",
  "Bandwidth": "160",
  "ZoneId": "200002",
  "message": "{\"AllowDowngrade\": true, \"Bandwidth\": 160, \"ClusterType\": \"CLOUD_EKS_TSE\", \"CreateTime\": 1692066710, \"Cvm\": 1, \"DiskSize\": 200, \"DiskType\": \"CLOUD_BASIC\", \"ExpireTime\": -62170009580, \"Features\": [], \"Healthy\": 1, \"HealthyMessage\": \"\", \"InstanceId\": \"ckafka-jamo82wo\", \"InstanceName\": \"\\u672a\\u547d\\u540d\", \"InstanceType\": \"profession\", \"IsInternal\": 0, \"MaxPartitionNumber\": 400, \"MaxTopicNumber\": 200, \"PartitionNumber\": 3, \"PublicNetwork\": 3, \"PublicNetworkChargeType\": \"BANDWIDTH_POSTPAID_BY_HOUR\", \"RebalanceDeadLineTimeStamp\": \"0000-00-00 00:00:00\", \"RebalanceTime\": \"0000-00-00 00:00:00\", \"RegionId\": \"ap-shanghai\", \"RenewFlag\": 0, \"Status\": 1, \"SubnetId\": \"subnet-bp2jqhcj\", \"Tags\": [], \"TopicNum\": 1, \"Version\": \"2.4.1\", \"Vip\": \"172.17.32.16\", \"VipList\": [{\"Vip\": \"172.17.32.16\", \"Vport\": \"9092\"}], \"VpcId\": \"vpc-kcphyzty\", \"Vport\": \"9092\", \"ZoneId\": 200002, \"ZoneIds\": [200002, 200003]}",
  "__docid": "CO_31e0187c3c5c2842b60f88a87c11eca0",
  "InstanceId": "ckafka-jamo82wo",
  "InstanceName": "Unspecified",
  "Status": "1",
  "VpcId": "vpc-kcphyzty",
  "Cvm": "1",
  "__namespace": "custom_object",
  "cloud_provider": "tencentcloud",
  "create_time": 1692089426315,
  "DiskType": "CLOUD_BASIC",
  "ExpireTime": "-62170009580",
  "TopicNum": "1",
  "VipList": "[{\"Vip\": \"172.17.32.16\", \"Vport\": \"9092\"}]",
  "time": 1692089425851,
  "IsInternal": "0",
  "Vport": "9092",
  "class": "tencentcloud_ckafka",
  "date": 1692089425000,
  "date_ns": 0,
  "name": "ckafka-jamo82wo",
  "CreateTime": "1692066710",
  "DiskSize": "200",
  "RegionId": "ap-shanghai",
  "Version": "2.4.1"
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*

### Appendix

#### TencentCloud-CKafka「Regions and Availability」

Refer to the official Tencent documentation:

- [TencentCloud-CKafka Region List](https://cloud.tencent.com/document/api/597/40826#.E5.9C.B0.E5.9F.9F.E5.88.97.E8.A1.A8)