---
title: 'Tencent Cloud CKafka'
tags: 
  - Tencent Cloud
summary: 'The displayed metrics for Tencent Cloud CKafka include message throughput, latency, concurrent connections, and reliability. These metrics reflect the performance and reliability guarantees of CKafka when handling large-scale message passing and real-time data streams.'
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

The displayed metrics for Tencent Cloud CKafka include message throughput, latency, concurrent connections, and reliability. These metrics reflect the performance and reliability guarantees of CKafka when handling large-scale message passing and real-time data streams.

## Configuration {#config}

### Installing Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Installing CKafka Collection Script

> Note: Please prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize CKafka monitoring data, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (Tencent Cloud-CKafka)" (ID: `guance_tencentcloud_ckafka`)

After clicking 【Install】, enter the corresponding parameters: Tencent Cloud AK, Tencent Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

We default collect some configurations, details see the metrics section [Customize Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configuration. You can also check the task records and logs for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, under "Infrastructure / Custom", check if there is any asset information.
3. On the <<< custom_key.brand_name >>> platform, under "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Tencent Cloud - Cloud Monitor, the default metric set is as follows. You can collect more metrics through configuration [Tencent Cloud Cloud Monitor Metric Details](https://cloud.tencent.com/document/product/248/45121){:target="_blank"}

### Performance Class

| Metric Name          | Metric Description       | Metric Meaning                                           | Unit | Dimension       |
| ------------------- | ---------------- | -------------------------------------------------- | ---- | ---------- |
| InstanceProCount    | Number of messages produced by instance | Number of messages produced by instance, summed according to the selected time granularity     | Count   | instanceId |
| InstanceConCount    | Number of messages consumed by instance | Number of messages consumed by instance, summed according to the selected time granularity     | Count   | instanceId |
| InstanceConReqCount | Number of consumption requests by instance | Number of consumption requests at the instance level, summed according to the selected time granularity | Count   | instanceId |
| InstanceProReqCount | Number of production requests by instance | Number of production requests at the instance level, summed according to the selected time granularity | Count   | instanceId |

### System Class

| Metric Name        | Metric Description     | Metric Meaning                                 | Unit | Dimension       |
| ----------------- | -------------- | ---------------------------------------- | ---- | ---------- |
| InstanceDiskUsage | Disk usage percentage | Current disk usage as a percentage of the total disk capacity of the instance specification | %    | instanceId |

### Cumulative Usage Class

| Metric Name                         | Metric Description                              | Metric Meaning                                                     | Unit | Dimension       |
| ---------------------------------- | --------------------------------------- | ------------------------------------------------------------ | ---- | ---------- |
| InstanceConnectCount               | Number of instance connections                              | Number of connections between clients and servers                                       | Connections   | instanceId |
| InstanceConFlow                    | Instance consumption traffic                            | Instance consumption traffic (excluding traffic generated by replicas), summed according to the selected time granularity | MB   | instanceId |
| InstanceMaxConFlow                 | Peak bandwidth for instance consumption messages                    | Peak bandwidth for instance consumption messages (no concept of replicas during consumption)                   | MB/s | instanceId |
| InstanceMaxProFlow                 | Peak bandwidth for instance production messages                    | Peak bandwidth for instance production messages (excluding bandwidth generated by replicas)                 | MB/s | instanceId |
| InstanceMsgCount                   | Total number of messages written to disk by the instance                    | Total number of messages written to disk by the instance (excluding replicas), latest value taken according to the selected time granularity | Messages   | instanceId |
| InstanceMsgHeap                    | Instance disk usage                          | Instance disk usage (including replicas), latest value taken according to the selected time granularity     | MB   | instanceId |
| InstanceProFlow                    | Instance production bandwidth                            | Instance production traffic (excluding traffic generated by replicas), summed according to the selected time granularity | MB   | instanceId |
| InstanceConnectPercentage          | Percentage of instance connections                        | Percentage of instance connections (percentage of client and server connections out of quota)           | %    | instanceId |
| InstanceConsumeBandwidthPercentage | Percentage of instance consumption bandwidth                      | Percentage of instance consumption bandwidth (instance consumption bandwidth out of quota)                 | %    | instanceId |
| InstanceConsumeGroupNum            | Number of instance consumption groups                        | Number of instance consumption groups                                             | Groups   | instanceId |
| InstanceConsumeGroupPercentage     | Percentage of instance consumption groups                      | Percentage of instance consumption groups (percentage of instance consumption groups out of quota)                 | %    | instanceId |
| InstanceConsumeThrottle            | Number of instance consumption throttling occurrences                        | Number of instance consumption throttling occurrences                                             | Count   | instanceId |
| InstancePartitionNum               | Number of instance partitions                     | Number of instance partitions                                          | Partitions   | instanceId |
| InstancePartitionPercentage        | Percentage of instance partitions (percentage of quota used) | Percentage of instance partitions (percentage of quota used)                      | %    | instanceId |
| InstanceProduceBandwidthPercentage | Percentage of instance production bandwidth                      | Percentage of instance production bandwidth (percentage of quota used)                         | %    | instanceId |
| InstanceProduceThrottle            | Number of instance production throttling occurrences                        | Number of instance production throttling occurrences                                             | Count   | instanceId |
| InstanceReplicaProduceFlow         | Peak bandwidth for instance production messages                    | Peak bandwidth for instance production messages (including bandwidth generated by replicas)                   | MB/s | instanceId |
| InstanceTopicNum                   | Number of instance topics                         | Number of instance topics                                              | Topics   | instanceId |
| InstanceTopicPercentage            | Percentage of instance topics                       | Percentage of instance topics (quota used)                                | %    | instanceId |

## Objects {#object}

The collected Tencent Cloud CKafka object data structure can be seen in "Infrastructure - Custom"

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

> *Note: Fields in `tags` and `fields` may change with subsequent updates*

### Appendix

#### TencentCloud-CKafka「Regions and Availability」

Refer to the official Tencent documentation:

- [TencentCloud-CKafka Region List](https://cloud.tencent.com/document/api/597/40826#.E5.9C.B0.E5.9F.9F.E5.88.97.E8.A1.A8)