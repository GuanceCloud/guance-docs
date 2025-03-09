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

### Installing Func

We recommend enabling the Guance Integration - Extensions - DataFlux Func (Automata): All prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installing CKafka Collection Script

> Note: Please prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize CKafka monitoring data, we install the corresponding collection script: "Guance Integration (Tencent Cloud-CKafka)" (ID: `guance_tencentcloud_ckafka`)

After clicking 【Install】, enter the required parameters: Tencent Cloud AK and Tencent Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Once enabled, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Click 【Execute】to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

By default, we collect some configurations; for more details, see [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}

### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have been configured for automatic triggers, and check the task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, under "Metrics", check if the corresponding monitoring data is available.

## Metrics {#metric}
After configuring Tencent Cloud Cloud Monitor, the default metric set is as follows. You can collect more metrics through configuration. For detailed information, see [Tencent Cloud Cloud Monitor Metrics Details](https://cloud.tencent.com/document/product/248/45121){:target="_blank"}

### Performance Metrics

| Metric Name          | Metric Description       | Meaning                                           | Unit | Dimension       |
| -------------------- | ------------------------ | ------------------------------------------------- | ---- | --------------- |
| InstanceProCount     | Instance Message Production Count | Number of messages produced by the instance, aggregated over the selected time granularity | Count | instanceId      |
| InstanceConCount     | Instance Message Consumption Count | Number of messages consumed by the instance, aggregated over the selected time granularity | Count | instanceId      |
| InstanceConReqCount  | Instance Consumption Request Count | Number of consumption requests made by the instance, aggregated over the selected time granularity | Count | instanceId      |
| InstanceProReqCount  | Instance Production Request Count | Number of production requests made by the instance, aggregated over the selected time granularity | Count | instanceId      |

### System Metrics

| Metric Name        | Metric Description     | Meaning                                 | Unit | Dimension       |
| ------------------ | ---------------------- | --------------------------------------- | ---- | --------------- |
| InstanceDiskUsage  | Disk Usage Percentage  | Percentage of current disk usage relative to the total disk capacity of the instance | %    | instanceId      |

### Cumulative Usage Metrics

| Metric Name                         | Metric Description                              | Meaning                                                     | Unit | Dimension       |
| ----------------------------------- | ----------------------------------------------- | ----------------------------------------------------------- | ---- | --------------- |
| InstanceConnectCount                | Instance Connection Count                       | Number of connections between clients and servers            | Count | instanceId      |
| InstanceConFlow                     | Instance Consumption Traffic                    | Instance consumption traffic (excluding replica traffic), aggregated over the selected time granularity | MB   | instanceId      |
| InstanceMaxConFlow                  | Instance Consumption Peak Bandwidth             | Instance consumption peak bandwidth (no concept of replicas) | MB/s | instanceId      |
| InstanceMaxProFlow                  | Instance Production Peak Bandwidth              | Instance production peak bandwidth (excluding replica bandwidth) | MB/s | instanceId      |
| InstanceMsgCount                    | Instance Total Messages Persisted               | Total number of messages persisted to disk (excluding replicas), latest value within the selected time granularity | Count | instanceId      |
| InstanceMsgHeap                     | Instance Disk Usage                             | Instance disk usage (including replicas), latest value within the selected time granularity | MB   | instanceId      |
| InstanceProFlow                     | Instance Production Traffic                     | Instance production traffic (excluding replica traffic), aggregated over the selected time granularity | MB   | instanceId      |
| InstanceConnectPercentage           | Instance Connection Percentage                  | Percentage of instance connections (client and server connections as a percentage of quota) | %    | instanceId      |
| InstanceConsumeBandwidthPercentage  | Instance Consumption Bandwidth Percentage       | Percentage of instance consumption bandwidth (as a percentage of quota) | %    | instanceId      |
| InstanceConsumeGroupNum             | Instance Consumption Group Count                | Number of instance consumption groups                        | Count | instanceId      |
| InstanceConsumeGroupPercentage      | Instance Consumption Group Percentage           | Percentage of instance consumption groups (as a percentage of quota) | %    | instanceId      |
| InstanceConsumeThrottle             | Instance Consumption Throttling Count           | Number of times instance consumption was throttled           | Count | instanceId      |
| InstancePartitionNum               | Instance Partition Count                        | Number of partitions in the instance                         | Count | instanceId      |
| InstancePartitionPercentage         | Instance Partition Percentage (Quota Usage)     | Percentage of partitions used (as a percentage of quota)     | %    | instanceId      |
| InstanceProduceBandwidthPercentage  | Instance Production Bandwidth Percentage        | Percentage of instance production bandwidth (as a percentage of quota) | %    | instanceId      |
| InstanceProduceThrottle             | Instance Production Throttling Count            | Number of times instance production was throttled            | Count | instanceId      |
| InstanceReplicaProduceFlow          | Instance Production Peak Bandwidth (Including Replicas) | Instance production peak bandwidth (including replica bandwidth) | MB/s | instanceId      |
| InstanceTopicNum                    | Instance Topic Count                            | Number of topics in the instance                             | Count | instanceId      |
| InstanceTopicPercentage             | Instance Topic Percentage (Quota Usage)         | Percentage of topics used (as a percentage of quota)         | %    | instanceId      |

## Objects {#object}

The collected Tencent Cloud CKafka object data structure can be viewed under "Infrastructure - Custom" objects.

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
  "InstanceName": "Unnamed",
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