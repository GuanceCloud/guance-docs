# 采集器「AWS-ElastiCache」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成 Core 核心包」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段         | 类型 | 是否必须 | 说明                                      |
| ------------ | ---- | -------- | ----------------------------------------- |
| `regions`    | list | 必须     | 所需采集的地域列表                        |
| `regions[#]` | str  | 必须     | 地域 ID。如：`'cn-north-1'`<br>总表见附录 |

## 2. 配置示例

### 指定地域

采集宁夏、北京地域的实例数据

~~~python
collector_configs = {
    'regions': [ 'cn-northwest-1', 'cn-north-1' ]
}
~~~

## 3. 数据上报格式

数据正常同步后，可以在观测云的「基础设施-自定义对象」中查看数据。

上报的数据示例如下：

~~~json
{
  "measurement": "aws_elasticache",
  "tags": {
    "name"                     : "test",
    "CacheClusterId"           : "test",
    "CacheNodeType"            : "cache.t3.small",
    "Engine"                   : "redis",
    "EngineVersion"            : "6.2.5",
    "CacheClusterStatus"       : " available",
    "PreferredAvailabilityZone": "cn-northwest-1b",
    "ARN"                      : "arn:aws-cn:elasticache:cn-northwest-1:5881335135:cluster:test",
    "RegionId"                 : "cn-north-1"
  },
  "fields": {
    "SecurityGroups": "{安全组 JSON 数据}}",
    "NumCacheNodes" : "1",
    "message"       : "{实例 JSON 数据}"
  }
}
~~~

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.name`值为实例 ID，作为唯一识别

> 提示 2：`fields.message`，`fields.network_interfaces`，`fields.blockdevicemappings`为 JSON 序列化后字符串

## X. 附录

请参考 AWS 官方文档：

- [AWS 地域 ID](https://docs.aws.amazon.com/zh_cn/zh_cn/AWSEC2/latest/WindowsGuide/using-regions-availability-zones.html#az-ids)