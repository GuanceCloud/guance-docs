---
title: 'Aliyun Tair Standard'
summary: 'Aliyun Tair Standard Metric display,including cpu usage, memory usage, disk read and write, network traffic, accesses per second, etc.'
__int_icon: 'icon/aliyun_tair'
dashboard:
  - desc: 'Aliyun Tair Standard Built-in Dashboard'
    path: 'dashboard/zh/aliyun_tair/'
monitor:
  - desc: 'Aliyun Tair Standard Monitor'
    path: 'monitor/zh/aliyun_tair/'
---

<!-- markdownlint-disable MD025 -->
# Aliyun **Tair** Standard
<!-- markdownlint-enable -->

Aliyun **Tair** Standard Metric display,including cpu usage, memory usage, disk read and write, network traffic, accesses per second, etc.


## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to  [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance (For simplicity's sake,，You can directly grant the global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of Aliyun **Tair** Standard resources,we install the corresponding collection script:「Guance Integration（Aliyun - **Tair** Collect）」(ID：`startup__guance_aliyun_tair`)

Click "Install" and enter the corresponding parameters: Aliyun AK, Aliyun account name.

Tap "Deploy startup Script"，The system automatically creates Startup script sets，And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」. Click "Run", you can immediately execute once, without waiting for a regular time. After a while, you can view task execution records and corresponding logs.

We have collected some configurations by default, see the index column for details

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure Ali Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Aliyun Monitor Metrics Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                | Metric Name      | Dimensions        | Statistics      | Unit     |
| ---- | ---- | ---- | ---- | ---- |
| ShardingAvgRt | Average response time     | userId,instanceId | Average,Maximum | us       |
| ShardingProxyUsedConnection | Number of blocked client connections | userId,instanceId | Average,Maximum | Count    |
| StandardConnectionUsage | Connection usage     | userId,instanceId | Average,Maximum | %        |
| ShardingCpuUsage | Cpu usage        | userId,instanceId | Average,Maximum | %        |
| ShardingHitRate | Hit rate           | userId,instanceId | Average,Maximum | %        |
| ShardingIntranetIn | Inbound traffic       | userId,instanceId | Average,Maximum | KBytes/s |
| ShardingIntranetInRatio | Incoming bandwidth utilization   | userId,instanceId | Average,Maximum | %        |
| ShardingIntranetOut | Outbound traffic       | userId,instanceId | Average,Maximum | KBytes/s |
| ShardingIntranetOutRatio | Outgoing bandwidth usage   | userId,instanceId | Average,Maximum | %        |
| ShardingKeys | Number of keys in the cache  | userId,instanceId | Average,Maximum | Count    |
| ShardingMemoryUsage | Memory usage       | userId,instanceId | Average,Maximum | %        |
| ShardingSyncDelayTime | Multi-active synchronization delay     | userId,instanceId | Average,Maximum | seconds  |
| ShardingUsedConnection | Used connections       | userId,instanceId | Average,Maximum | Count    |
| ShardingUsedMemory | Used memory       | userId,instanceId | Average,Maximum | Bytes    |
| StandingUsedQPS       | Average Used QPS | userId,instanceId | Average,Maximum | Count    |

## Object {#object}

The collected Aliyun **Tair** object data structure can see the object data from「Infrastructure-Custom」

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

## Logging {#logging}

### **Longquery**

#### Prerequisite

> Tip：The code operation of this script depends on the collection of **Tair** instance objects. If the custom object collection of **Tair** is not configured, the slow log script cannot collect slow log data

<!-- markdownlint-disable MD024 -->
#### Installation script
<!-- markdownlint-enable -->
On the previous basis, you need to install **Tair Script for longquery log**

Click and install the corresponding script package in [Management / Script Market]:「Guance Integration（Aliyun - **Tair** Slow Log Collect）」(ID：`guance_aliyun_Tair_slowlog`)

After the data is synchronized normally, you can view the data in the [log] of Guance platform.

An example of reported data is as follows:

```json
{
  "measurement": "aliyun_Tair_slowlog",
  "tags": {
      "name"            : "r-bp1c4xxxxxxxofy2vm",
      "Account"         : "(null)",
      "IPAddress"       : "172.xx.x.201",
      "AccountName"     : "(null)",
      "DBName"          : "3",
      "NodeId"          : "(null)",
      "ChargeType"      : "PrePaid",
      "ConnectionDomain": "r-bpxxxxxxxxxxy2vm.Tair.rds.aliyuncs.com",
      "EngineVersion"   : "4.0",
      "InstanceClass"   : "Tair.master.small.default",
      "InstanceId"      : "r-bpxxxxxxxxxxxxxxx2vm",
      "InstanceName"    : "xx3.0-xx System",
      "NetworkType"     : "VPC",
      "Port"            : "6379",
      "PrivateIp"       : "172.xxx.xx.200",
      "RegionId"        : "cn-hangzhou",
      "ZoneId"          : "cn-hangzhou-h"
  },
  "fields": {
    "Command"    : "latency:eventloop",
    "ElapsedTime": 192000,
    "ExecuteTime": "2022-07-26T03:18:36Z",
    "message"    : "{Instance JSON data}"
  }
}

```

Some parameters are described as follows:

| Field          | Type | Description                 |
| :------------ | :--- | :------------------- |
| `ElapsedTime` | int  | Execution time, in milliseconds |
| `ExecuteTime` | str  | Execution start time         |
| `IPAddress`   | str  | Client ip address     |

> *Notice：The fields in `tags` and `fields` may change with subsequent updates*
>
> Tip：The `fields.message` is JSON serialized string
