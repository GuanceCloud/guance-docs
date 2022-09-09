# 采集器「阿里云-mongodb」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成 Core 核心包」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段         | 类型 | 是否必须 | 说明                                       |
| ------------ | ---- | -------- | ------------------------------------------ |
| `regions`    | list | 必须     | 所需采集的地域列表                         |
| `regions[#]` | str  | 必须     | 地域 ID。如：`'cn-hangzhou'`<br>总表见附录 |

## 2. 配置示例

### 指定地域

采集杭州、上海地域的数据

~~~python
collector_configs = {
    'regions': [ 'cn-hangzhou', 'cn-shanghai' ]
}
~~~

## 3. 数据上报格式

数据正常同步后，可以在观测云的「基础设施-自定义对象」中查看数据。

上报的数据示例如下：

~~~json
{
  "measurement": "aliyun_mongodb",
  "tags": {
    "name"                 : "dds-bpxxxxxxxx",
    "DBInstanceType"       : "replicate",
    "ChargeType"           : "PrePaid",
    "Engine"               : "MongoDB",
    "DBInstanceClass"      : "dds.xxxxxxxx",
    "DBInstanceId"         : "dds-bpxxxxxxx",
    "ZoneId"               : "cn-hangzhou",
    "RegionId"             : "cn-hangzhou-h",
    "VPCId"                : "vpc-bpxxxxxxxx",
    "EngineVersion"        : "4.2",
    "CurrentKernelVersion" : "mongodb_20210204_4.0.14",
    "StorageEngine"        : "WiredTiger",
    "DBInstanceDescription": "业务系统"
  },
  "fields": {
    "ExpireTime"       : "2020-11-18T08:47:11Z",
    "DBInstanceStorage": "20",
    "ReplicaSets"      : "{连接地址 JSON 数据}",
    "message"          : "{实例 JSON 数据}",
  }
}
~~~

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.name`值为实例 ID，作为唯一识别

> 提示 2：`fields.message`为 JSON 序列化后字符串

## X. 附录

请参考阿里云官方文档：

- [云数据库 mongodb 地域 ID](https://help.aliyun.com/document_detail/72379.html)
