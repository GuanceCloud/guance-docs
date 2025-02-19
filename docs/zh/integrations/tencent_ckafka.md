---
title: '腾讯云 CKafka'
tags: 
  - 腾讯云
summary: '腾讯云CKafka的展示指标包括消息吞吐量、延迟、并发连接数和可靠性，这些指标反映了CKafka在处理大规模消息传递和实时数据流时的性能表现和可靠性保证。'
__int_icon: 'icon/tencent_ckafka'
dashboard:

  - desc: '腾讯云 CKafka 监控视图'
    path: 'dashboard/zh/tencent_ckafka'

monitor:
  - desc: 'Tencent CKafka 监控器'
    path: 'monitor/zh/tencent_ckafka'
---

<!-- markdownlint-disable MD025 -->
# 腾讯云 CKafka
<!-- markdownlint-enable -->

腾讯云CKafka的展示指标包括消息吞吐量、延迟、并发连接数和可靠性，这些指标反映了CKafka在处理大规模消息传递和实时数据流时的性能表现和可靠性保证。

## 配置 {#config}

### 安装 Func

推荐开通 {{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装 CKafka 采集脚本

> 提示：请提前准备好符合要求的腾讯云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 CKafka 的监控数据，我们安装对应的采集脚本：「{{{ custom_key.brand_name }}}集成（腾讯云-CKafka）」(ID：`guance_tencentcloud_ckafka`)

点击【安装】后，输入相应的参数：腾讯云 AK、腾讯云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在{{{ custom_key.brand_name }}}平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在{{{ custom_key.brand_name }}}平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好腾讯云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [腾讯云云监控指标详情](https://cloud.tencent.com/document/product/248/45121){:target="_blank"}

### 性能类

| 指标英文名          | 指标中文名       | 指标含义                                           | 单位 | 维度       |
| ------------------- | ---------------- | -------------------------------------------------- | ---- | ---------- |
| InstanceProCount    | 实例生产消息条数 | 实例生产消息条数，按照所选择的时间粒度统计求和     | 条   | instanceId |
| InstanceConCount    | 实例消费消息条数 | 实例消费消息条数，按照所选择的时间粒度统计求和     | 条   | instanceId |
| InstanceConReqCount | 实例消费请求次数 | 实例级别消费请求次数，按照所选择的时间粒度统计求和 | 次   | instanceId |
| InstanceProReqCount | 实例生产请求次数 | 实例级别生产请求次数，按照所选择的时间粒度统计求和 | 次   | instanceId |

### 系统类

| 指标英文名        | 指标中文名     | 指标含义                                 | 单位 | 维度       |
| ----------------- | -------------- | ---------------------------------------- | ---- | ---------- |
| InstanceDiskUsage | 磁盘使用百分比 | 当前磁盘占用与实例规格磁盘总容量的百分比 | %    | instanceId |

### 累计用量类

| 指标英文名                         | 指标中文名                              | 指标含义                                                     | 单位 | 维度       |
| ---------------------------------- | --------------------------------------- | ------------------------------------------------------------ | ---- | ---------- |
| InstanceConnectCount               | 实例连接数                              | 客户端和服务器的连接数                                       | 个   | instanceId |
| InstanceConFlow                    | 实例消费流量                            | 实例消费流量（不包含副本产生的流量），按照所选择的时间粒度统计求和 | MB   | instanceId |
| InstanceMaxConFlow                 | 实例消费消息峰值带宽                    | 实例消费消息峰值带宽（消费时无副本的概念）                   | MB/s | instanceId |
| InstanceMaxProFlow                 | 实例生产消息峰值带宽                    | 实例生产消息峰值带宽（不包含副本生产的带宽）                 | MB/s | instanceId |
| InstanceMsgCount                   | 实例落盘的消息总条数                    | 实例落盘的消息总条数（不包含副本），按照所选择的时间粒度取最新值 | 条   | instanceId |
| InstanceMsgHeap                    | 实例磁盘占用量                          | 实例磁盘占用量（包含副本），按照所选择的时间粒度取最新值     | MB   | instanceId |
| InstanceProFlow                    | 实例生产带宽                            | 实例生产流量（不包含副本产生的流量），按照所选择的时间粒度统计求和 | MB   | instanceId |
| InstanceConnectPercentage          | 实例连接数百分比                        | 实例连接数百分比(客户端和服务端连接数占配额百分比)           | %    | instanceId |
| InstanceConsumeBandwidthPercentage | 实例消费带宽百分比                      | 实例消费带宽百分比(实例消费带宽占配额百分比)                 | %    | instanceId |
| InstanceConsumeGroupNum            | 实例消费分组数量                        | 实例消费分组数量                                             | 个   | instanceId |
| InstanceConsumeGroupPercentage     | 实例消费分组百分比                      | 实例消费分组百分比(实例消费组数占配额百分比)                 | %    | instanceId |
| InstanceConsumeThrottle            | 实例消费限流次数                        | 实例消费限流次数                                             | 次   | instanceId |
| InstancePartitionNum               | 实例 partition 数量                     | 实例 partition 数量                                          | 个   | instanceId |
| InstancePartitionPercentage        | 实例 partition 百分比（占用配额百分比） | 实例 partition 百分比（占用配额百分比）                      | %    | instanceId |
| InstanceProduceBandwidthPercentage | 实例生产带宽百分比                      | 实例生产带宽百分比（占用配额百分比）                         | %    | instanceId |
| InstanceProduceThrottle            | 实例生产限流次数                        | 实例生产限流次数                                             | 次   | instanceId |
| InstanceReplicaProduceFlow         | 实例生产消息峰值带宽                    | 实例生产消息峰值带宽（包含副本生产的带宽）                   | MB/s | instanceId |
| InstanceTopicNum                   | 实例 Topic 数量                         | 实例 Topic 数量                                              | 个   | instanceId |
| InstanceTopicPercentage            | 实例 Topic 百分比                       | 实例 Topic 百分比（占用配额）                                | %    | instanceId |

## 对象 {#object}

采集到的腾讯云 CKafka 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

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
  "InstanceName": "未命名",
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

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

### 附录

#### TencentCloud-CKafka「地域和可用性」

请参考 Tencent 官方文档：

- [TencentCloud-CKafka 地域列表](https://cloud.tencent.com/document/api/597/40826#.E5.9C.B0.E5.9F.9F.E5.88.97.E8.A1.A8)
