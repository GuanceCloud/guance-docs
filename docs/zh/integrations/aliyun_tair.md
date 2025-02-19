---
title: '阿里云 Tair 社区版'
tags: 
  - 阿里云
summary: '阿里云 Tair 社区版指标展示，包括 CPU 使用率、内存使用率、代理总QPS、网络流量、命中率等。'
__int_icon: 'icon/aliyun_tair'
dashboard:
  - desc: '阿里云 Tair 社区版内置视图'
    path: 'dashboard/zh/aliyun_tair'
monitor:
  - desc: '阿里云 Tair 监控器'
    path: 'monitor/zh/aliyun_tair'
---

<!-- markdownlint-disable MD025 -->
# 阿里云 **Tair** 社区版
<!-- markdownlint-enable -->

阿里云 **Tair** 社区版指标展示，包括CPU 使用率、内存使用率、代理总QPS、网络流量、命中率等。


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步阿里云 `tair` 社区版的监控数据，我们安装对应的采集脚本：观测云集成（阿里云- `tair`采集）」(ID：`startup__guance_aliyun_tair`)

点击【安装】后，输入相应的参数：阿里云 AK、阿里云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好阿里云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [阿里云云监控指标详情](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                | Metric Name      | Dimensions        | Statistics      | Unit     |
| ---- | ---- | ---- | ---- | ---- |
| ShardingAvgRt | 平均响应时间     | userId,instanceId | Average,Maximum | us       |
| ShardingProxyUsedConnection | 分片连接使用率 | userId,instanceId | Average,Maximum | Count    |
| StandardConnectionUsage  | 连接数使用率     | userId,instanceId | Average,Maximum | %        |
| ShardingCpuUsage | CPU使用率        | userId,instanceId | Average,Maximum | %        |
| ShardingHitRate  | 命中率           | userId,instanceId | Average,Maximum | %        |
| ShardingIntranetIn | 入方向流量       | userId,instanceId | Average,Maximum | KBytes/s |
| ShardingIntranetInRatio | 流入带宽使用率   | userId,instanceId | Average,Maximum | %        |
| ShardingIntranetOut | 出方向流量       | userId,instanceId | Average,Maximum | KBytes/s |
| ShardingIntranetOutRatio | 流出带宽使用率   | userId,instanceId | Average,Maximum | %        |
| ShardingKeys     | 缓存内 Key 数量  | userId,instanceId | Average,Maximum | Count    |
| ShardingMemoryUsage | 内存使用率       | userId,instanceId | Average,Maximum | %        |
| ShardingSyncDelayTime | 多活同步时延     | userId,instanceId | Average,Maximum | seconds  |
| ShardingUsedConnection      | 已用连接数       | userId,instanceId | Average,Maximum | Count    |
| ShardingUsedMemory          | 内存使用量       | userId,instanceId | Average,Maximum | Bytes    |
| ShardingUsedQPS             | 平均每秒访问次数 | userId,instanceId | Average,Maximum | Count    |



## 对象 {#object}

采集到的阿里云 redis 的对象数据结构, 可以从「基础设施-自定义」里看到对象数据

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
