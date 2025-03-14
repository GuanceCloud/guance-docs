---
title: 'Alibaba Cloud Tair Community Edition'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud Tair Community Edition metrics display, including CPU usage, memory usage, total proxy QPS, network traffic, hit rate, etc.'
__int_icon: 'icon/aliyun_tair'
dashboard:
  - desc: 'Alibaba Cloud Tair Community Edition built-in views'
    path: 'dashboard/en/aliyun_tair'
monitor:
  - desc: 'Alibaba Cloud Tair monitor'
    path: 'monitor/en/aliyun_tair'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud **Tair** Community Edition
<!-- markdownlint-enable -->

Alibaba Cloud **Tair** Community Edition metrics display, including CPU usage, memory usage, total proxy QPS, network traffic, hit rate, etc.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

Synchronize monitoring data for Alibaba Cloud `tair` Community Edition by installing the corresponding collection script: Guance Integration (Alibaba Cloud - `tair` Collection) (ID: `startup__guance_aliyun_tair`)

After clicking 【Install】, enter the required parameters: Alibaba Cloud AK and Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Additionally, you can view the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.

We default collect some configurations; see the metrics section for details.

[Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding tasks have been configured with automatic triggers, and check the task records and logs for any anomalies.
2. In the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. In the Guance platform, under 「Metrics」, check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Alibaba Cloud CloudMonitor, the default metric set is as follows. You can collect more metrics through configuration. [Alibaba Cloud CloudMonitor Metric Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                | Metric Name      | Dimensions        | Statistics      | Unit     |
| ---- | ---- | ---- | ---- | ---- |
| ShardingAvgRt | Average Response Time     | userId,instanceId | Average,Maximum | us       |
| ShardingProxyUsedConnection | Shard Proxy Connection Usage | userId,instanceId | Average,Maximum | Count    |
| StandardConnectionUsage  | Connection Usage Rate     | userId,instanceId | Average,Maximum | %        |
| ShardingCpuUsage | CPU Usage        | userId,instanceId | Average,Maximum | %        |
| ShardingHitRate  | Hit Rate           | userId,instanceId | Average,Maximum | %        |
| ShardingIntranetIn | Inbound Traffic       | userId,instanceId | Average,Maximum | KBytes/s |
| ShardingIntranetInRatio | Inbound Bandwidth Usage   | userId,instanceId | Average,Maximum | %        |
| ShardingIntranetOut | Outbound Traffic       | userId,instanceId | Average,Maximum | KBytes/s |
| ShardingIntranetOutRatio | Outbound Bandwidth Usage   | userId,instanceId | Average,Maximum | %        |
| ShardingKeys     | Number of Keys in Cache  | userId,instanceId | Average,Maximum | Count    |
| ShardingMemoryUsage | Memory Usage       | userId,instanceId | Average,Maximum | %        |
| ShardingSyncDelayTime | Multi-Live Sync Delay     | userId,instanceId | Average,Maximum | seconds  |
| ShardingUsedConnection      | Used Connections       | userId,instanceId | Average,Maximum | Count    |
| ShardingUsedMemory          | Memory Usage Amount       | userId,instanceId | Average,Maximum | Bytes    |
| ShardingUsedQPS             | Average Queries Per Second | userId,instanceId | Average,Maximum | Count    |



## Object {#object}

The object data structure collected from Alibaba Cloud Redis can be viewed in 「Infrastructure - Custom」

```json
"measurement": "aliyun_acs_kvstore",
    "tags": {
      "ArchitectureType": "cluster",
      "ChargeType": "PostPaid",
      "CreateTime": "2023-07-26T07:51:00Z",
      "EditionType": "Community",
      "EngineVersion": "5.0",
      "GlobalInstanceId": "",
      "InstanceClass": "redis.logic.sharding.1g.2db.0rodb.4proxy.default",
      "InstanceName": "redis",
      "InstanceStatus": "Normal",
      "InstanceType": "Redis",
      "NetworkType": "VPC",
      "NodeType": "double",
      "PackageType": "standard",
      "PrivateIp": "172.16.0.246",
      "RegionId": "cn-hangzhou",
      "ResourceGroupId": "rg-acfmv3ro3xnfwaa",
      "UserName": "r-bp153nzuqbc1m4uvd0",
      "VSwitchId": "vsw-bp10hgbody9mjgvt8rfxv",
      "VpcId": "vpc-bp1uhj8mimgturv8c0gg6",
      "ZoneId": "cn-hangzhou-h",
      "instanceId": "r-bp153nzuqbc1m4uvd0",
      "name": "r-bp153nzuqbc1m4uvd0",
      "nodeId": "r-bp153nzuqbc1m4uvd0-db-1",
      "userId": "1067807587588864"
    },
    "timestamp": 1692338533
  },
  {
    "category": "metric",
    "fields": {
      "ShardingAvgRt_Average": 21.6,
      "ShardingAvgRt_Maximum": 21.6,
      "ShardingConnectionUsage_Average": 0.0,
      "ShardingConnectionUsage_Maximum": 0.0,
      "ShardingCpuUsage_Average": 0.233,
      "ShardingCpuUsage_Maximum": 0.233,
      "ShardingIntranetIn_Average": 0.283,
      "ShardingIntranetIn_Maximum": 0.283,
      "ShardingIntranetOut_Average": 5.513,
      "ShardingIntranetOut_Maximum": 5.513,
      "ShardingMemoryUsage_Average": 6.855,
      "ShardingMemoryUsage_Maximum": 6.855,
      "ShardingUsedQPS_Average": 7.266,
      "ShardingUsedQPS_Maximum": 7.266
    },
    "measurement": "aliyun_acs_kvstore",
    "tags": {
      "ArchitectureType": "cluster",
      "ChargeType": "PostPaid",
      "CreateTime": "2023-07-26T07:51:00Z",
      "EditionType": "Community",
      "EngineVersion": "5.0",
      "GlobalInstanceId": "",
      "InstanceClass": "redis.logic.sharding.1g.2db.0rodb.4proxy.default",
      "InstanceName": "redis",
      "InstanceStatus": "Normal",
      "InstanceType": "Redis",
      "NetworkType": "VPC",
      "NodeType": "double",
      "PackageType": "standard",
      "PrivateIp": "172.16.0.246",
      "RegionId": "cn-hangzhou",
      "ResourceGroupId": "rg-acfmv3ro3xnfwaa",
      "UserName": "r-bp153nzuqbc1m4uvd0",
      "VSwitchId": "vsw-bp10hgbody9mjgvt8rfxv",
      "VpcId": "vpc-bp1uhj8mimgturv8c0gg6",
      "ZoneId": "cn-hangzhou-h",
      "instanceId": "r-bp153nzuqbc1m4uvd0",
      "name": "r-bp153nzuqbc1m4uvd0",
      "nodeId": "r-bp153nzuqbc1m4uvd0-db-0",
      "userId": "1067807587588864"
    },
    "timestamp": 1692338533
  },
  {
    "category": "metric",
    "fields": {
      "ShardingProxyAvgRt_Average": 0.0,
      "ShardingProxyAvgRt_Maximum": 0.0,
      "ShardingProxyConnectionUsage_Average": 0.0,
      "ShardingProxyConnectionUsage_Maximum": 0.0,
      "ShardingProxyCpuUsage_Average": 0.0,
      "ShardingProxyCpuUsage_Maximum": 0.0,
      "ShardingProxyIntranetIn_Average": 0.002,
      "ShardingProxyIntranetIn_Maximum": 0.002,
      "ShardingProxyIntranetOut_Average": 0.0,
      "ShardingProxyIntranetOut_Maximum": 0.0,
      "ShardingProxyUsedConnection_Average": 0.0,
      "ShardingProxyUsedConnection_Maximum": 0.0
    },
    "measurement": "aliyun_acs_kvstore",
    "tags": {
      "ArchitectureType": "cluster",
      "ChargeType": "PostPaid",
      "CreateTime": "2023-07-26T07:51:00Z",
      "EditionType": "Community",
      "EngineVersion": "5.0",
      "GlobalInstanceId": "",
      "InstanceClass": "redis.logic.sharding.1g.2db.0rodb.4proxy.default",
      "InstanceName": "redis",
      "InstanceStatus": "Normal",
      "InstanceType": "Redis",
      "NetworkType": "VPC",
      "NodeType": "double",
      "PackageType": "standard",
      "PrivateIp": "172.16.0.246",
      "RegionId": "cn-hangzhou",
      "ResourceGroupId": "rg-acfmv3ro3xnfwaa",
      "UserName": "r-bp153nzuqbc1m4uvd0",
      "VSwitchId": "vsw-bp10hgbody9mjgvt8rfxv",
      "VpcId": "vpc-bp1uhj8mimgturv8c0gg6",
      "ZoneId": "cn-hangzhou-h",
      "instanceId": "r-bp153nzuqbc1m4uvd0",
      "name": "r-bp153nzuqbc1m4uvd0",
      "nodeId": "r-bp153nzuqbc1m4uvd0-proxy-0",
      "userId": "1067807587588864"
    },
    "timestamp": 1692338533
  }
]
```
