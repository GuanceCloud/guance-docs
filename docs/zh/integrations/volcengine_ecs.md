---
title: '火山引擎 ECS'
tags: 
  - 火山引擎
summary: '火山引擎 ECS 的展示指标包括CPU利用率、内存利用率、网络带宽和磁盘IOPS，这些指标反映了ECS实例的计算、内存、网络和存储性能表现。'
__int_icon: 'icon/volcengine_ecs'
dashboard:
  - desc: '火山引擎 ECS 视图'
    path: 'dashboard/zh/volcengine_ecs/'

---

<!-- markdownlint-disable MD025 -->
# 火山引擎 ECS
<!-- markdownlint-enable -->


火山引擎ECS的展示指标包括CPU利用率、内存利用率、网络带宽和磁盘IOPS，这些指标反映了ECS实例的计算、内存、网络和存储性能表现。

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的火山引擎 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 ECS 云资源的监控数据，我们安装对应的采集脚本：「观测云集成（火山引擎-ECS采集）」(ID：`guance_volcengine_ecs`)

点击【安装】后，输入相应的参数：火山引擎 AK、火山引擎账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

> 如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。


我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-volcengine-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好火山引擎-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [火山引擎云监控指标详情](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_ECS){:target="_blank"}

> 注意：需要在 `volcengine` ECS 控制台安装监控插件

|`MetricName` |`Subnamespace` |指标中文名称 |MetricUnit | Dimension|
| ---- |-------------------------------------| :----: |:----: |:----: |
|`MetricName` |`SubNamespace` |指标名称 |MetricUnit | Dimension|
|`Instance_CpuBusy` |`Instance` |带外CPU利用率 |Percent | ResourceID|
|`Instance_DiskReadBytes` |`Instance` |带外磁盘读带宽 |Bytes/Second(IEC) | ResourceID|
|`Instance_DiskWriteBytes` |`Instance` |带外磁盘写带宽 |Bytes/Second(IEC) | ResourceID|
|`Instance_DiskReadIOPS` |`Instance` |带外磁盘读IOPS |Count/Second | ResourceID|
|`Instance_DiskWriteIOPS` |`Instance` |带外磁盘写IOPS |Count/Second | ResourceID|
|`Instance_NetTxBits` |`Instance` |带外网络流出速率 |Bits/Second(IEC) | ResourceID|
|`Instance_NetRxBits` |`Instance` |带外网络流入速率 |Bits/Second(IEC) | ResourceID|
|`Instance_NetTxPackets` |`Instance` |带外网络发送包速率 |Packet/Second | ResourceID|
|`Instance_NetRxPackets` |`Instance` |带外网络接收包速率 |Packet/Second | ResourceID|
|`CpuTotal` |`Instance` |CPU使用率 |Percent | ResourceID|
|`MemoryUsedSpace` |`Instance` |已用内存量 |Bytes(IEC) | ResourceID|
|`MemoryUsedUtilization` |`Instance` |内存使用率 |Percent | ResourceID|
|`LoadPerCore1m` |`Instance` |vCPU负载（1分钟平均） |None | ResourceID|
|`LoadPerCore5m` |`Instance` |vCPU负载（5分钟平均） |None | ResourceID|
|`LoadPerCore15m` |`Instance` |vCPU负载（15分钟平均） |None | ResourceID|
|`NetworkInPackages` |`Instance` |网络流入包速率 |Packet/Second | ResourceID|
|`NetworkOutPackages` |`Instance` |网络发送包速率 |Packet/Second | ResourceID|
|`NetTcpConnection` |`Instance` |TOTAL |Count | ResourceID|
|`NetworkInRate` |`Instance` |网络流入速率 |Bits/Second(IEC) | ResourceID|
|`NetworkOutRate` |`Instance` |网络流出速率 |Bits/Second(IEC) | ResourceID|


## 对象 {#object}
采集到的火山引擎 ECS 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

``` json
[
  {
    "category": "custom_object",
    "fields": {
      "CpuOptions": "{\"CoreCount\": 1, \"ThreadsPerCore\": 2}",
      "CreatedAt": "2024-03-11T14:01:05+08:00",
      "Description": "",
      "LocalVolumes": "[]",
    ...
    },
    "measurement": "volcengine_ecs",
    "tags": {
      "Cpus": "1",
      "DeploymentSetGroupNumber": "0",
      "DeploymentSetId": "",
      "ElasticScheduledInstanceType": "NoEsi",
      "Hostname": "iv-xx",
      "ImageId": "image-xx",
      "InstanceChargeType": "PostPaid",
      "InstanceId": "i-xx",
      "InstanceName": "ECS-0XQq",
      "InstanceTypeId": "ecs.s2-c1m2.small",
      "KeyPairId": "kp-xx",
      "KeyPairName": "xxx-test",
      "MemorySize": "2048",
      "OsName": "CentOS Stream 9 64位",
      "OsType": "Linux",
      "ProjectName": "default",
      "RegionId": "cn-beijing",
      "ScheduledInstanceId": "",
      "Status": "RUNNING",
      "Uuid": "000c65ee-9e1c-xxx-xxx-xxxx",
      "VpcId": "vpc-xxx",
      "ZoneId": "cn-beijing-b",
      "name": "i-xxx"
    }
  }
]
```
