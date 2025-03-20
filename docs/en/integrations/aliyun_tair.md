---
title: 'Alibaba Cloud Tair Community Edition'
tags: 
  - Alibaba Cloud
summary: 'Display of metrics for the Alibaba Cloud Tair Community Edition, including CPU usage, memory usage, total proxy QPS, network traffic, hit rate, etc.'
__int_icon: 'icon/aliyun_tair'
dashboard:
  - desc: 'Built-in views for Alibaba Cloud Tair Community Edition'
    path: 'dashboard/en/aliyun_tair'
monitor:
  - desc: 'Alibaba Cloud Tair Monitor'
    path: 'monitor/en/aliyun_tair'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud **Tair** Community Edition
<!-- markdownlint-enable -->

Display of metrics for the Alibaba Cloud **Tair** Community Edition, including CPU usage, memory usage, total proxy QPS, network traffic, hit rate, etc.


## Configuration {#config}

### Install Func

We recommend enabling <<< custom_key.brand_name >>> integration - extension - hosted Func: all prerequisites are automatically installed. Please continue with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data from the Alibaba Cloud `tair` community edition, we install the corresponding collection script: <<< custom_key.brand_name >>> Integration (Alibaba Cloud - `tair` collection) (ID: `startup__guance_aliyun_tair`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

We collect some configurations by default; see the metrics section for details.

[Configure custom cloud object metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration, and you can check the corresponding task records and logs to see if there are any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, under "Infrastructure / Custom", check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration. [Details of Alibaba Cloud Cloud Monitoring Metrics](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                | Metric Name      | Dimensions        | Statistics      | Unit     |
| ---- | ---- | ---- | ---- | ---- |
| ShardingAvgRt | Average Response Time     | userId,instanceId | Average,Maximum | us       |
| ShardingProxyUsedConnection | Sharding Connection Usage Rate | userId,instanceId | Average,Maximum | Count    |
| StandardConnectionUsage  | Connection Usage Rate     | userId,instanceId | Average,Maximum | %        |
| ShardingCpuUsage | CPU Usage Rate        | userId,instanceId | Average,Maximum | %        |
| ShardingHitRate  | Hit Rate           | userId,instanceId | Average,Maximum | %        |
| ShardingIntranetIn | Inbound Traffic       | userId,instanceId | Average,Maximum | KBytes/s |
| ShardingIntranetInRatio | Inbound Bandwidth Usage Rate   | userId,instanceId | Average,Maximum | %        |
| ShardingIntranetOut | Outbound Traffic       | userId,instanceId | Average,Maximum | KBytes/s |
| ShardingIntranetOutRatio | Outbound Bandwidth Usage Rate   | userId,instanceId | Average,Maximum | %        |
| ShardingKeys     | Number of Keys in Cache  | userId,instanceId | Average,Maximum | Count    |
| ShardingMemoryUsage | Memory Usage Rate       | userId,instanceId | Average,Maximum | %        |
| ShardingSyncDelayTime | Multi-active Synchronization Delay     | userId,instanceId | Average,Maximum | seconds  |
| ShardingUsedConnection      | Used Connections       | userId,instanceId | Average,Maximum | Count    |
| ShardingUsedMemory          | Memory Usage       | userId,instanceId | Average,Maximum | Bytes    |
| ShardingUsedQPS             | Average Queries per Second | userId,instanceId | Average,Maximum | Count    |



## Objects {#object}

The structure of collected Alibaba Cloud redis object data can be seen in "Infrastructure - Custom".

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