# 采集器「腾讯云-Redis」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成 Core 核心包」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段         | 类型 | 是否必须 | 说明                                       |
| ------------ | ---- | -------- | ------------------------------------------ |
| `regions`    | list | 必须     | 所需采集的地域列表                         |
| `regions[#]` | str  | 必须     | 地域 ID。如：`'ap-shanghai'`<br>总表见附录 |

## 2. 配置示例

### 指定地域

采集上海地域的数据

```python
collector_configs = {
    'regions': [ 'ap-shanghai' ]
}
```

## 3. 数据上报格式

数据正常同步后，可以在观测云的「基础设施 - 自定义（对象）」中查看数据。

上报的数据示例如下：

```json
{
  "measurement": "tencentcloud_redis",
  "tags": {
    "name"        : "crs-xxxx",
    "BillingMode" : "0",
    "Engine"      : "Redis",
    "InstanceId"  : "crs-xxxx",
    "InstanceName": "solution",
    "Port"        : "6379",
    "ProductType" : "standalone",
    "ProjectId"   : "0",
    "RegionId"    : "ap-shanghai",
    "Status"      : "2",
    "Type"        : "6",
    "WanIp"       : "172.x.x.x",
    "ZoneId"      : "200002"
  },
  "fields": {
    "ClientLimits"     : "10000",
    "Createtime"       : "2022-07-14 13:54:14",
    "DeadlineTime"     : "0000-00-00 00:00:00",
    "InstanceNodeInfo" : "{实例节点信息}",
    "InstanceTitle"    : "运行中",
    "Size"             : 1024,
    "message"          : "{实例 JSON 数据}"
  }
}
```

部分字段说明如下，具体可看附录接口返回参数

| 字段                 | 类型    | 说明                                                                                                                                                                                                                                                                                                                                     |
|--------------------| ------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Size`             | Float   | 实例容量大小，单位：MB                                                                                                                                                                                                                                                                                                                   |
| `BillingMode`      | Integer | 计费模式：0-按量计费，1-包年包月                                                                                                                                                                                                                                                                                                         |
| `Engine`           | String  | 引擎：社区版 Redis、腾讯云 CKV                                                                                                                                                                                                                                                                                                           |
| `ProductType`      | String  | 产品类型：standalone – 标准版，cluster – 集群版                                                                                                                                                                                                                                                                                          |
| `Status`           | Integer | 实例当前状态<br/>0：待初始化<br/>1：实例在流程中<br/>2：实例运行中<br/>-2：实例已隔离<br/>-3：实例待删除                                                                                                                                                                                                                                 |
| `Type`             | Integer | 实例类型：<br/>1 – Redis2.8 内存版（集群架构）<br/>2 – Redis2.8 内存版（标准架构）<br/>3 – CKV 3.2 内存版（标准架构）<br/>4 – CKV 3.2 内存版（集群架构）<br/>5 – Redis2.8 内存版（单机）<br/>6 – Redis4.0 内存版（标准架构）<br/>7 – Redis4.0 内存版（集群架构）<br/>8 – Redis5.0 内存版（标准架构）<br/>9 – Redis5.0 内存版（集群架构） |
| `InstanceNodeInfo` | Array   | 实例节点信息                                                                                                                                                                                                                                                                                                                             |

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.name` 值作为唯一识别

> 提示 2：`fields.message` 、 `fields.InstanceNode` 为 JSON 序列化后字符串

## X. 附录

请参考腾讯云官方文档：

- [腾讯云 Redis 地域和可用区](https://cloud.tencent.com/document/api/239/20005#.E5.9C.B0.E5.9F.9F.E5.88.97.E8.A1.A8)
- [腾讯云 Redis 查询 Redis 实例列表返回数据](https://cloud.tencent.com/document/api/239/20022#InstanceSet)
