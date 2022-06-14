# 采集器「AWS-RDS」配置手册
---


阅读本文前，请先阅读：

- [观测云集成简介](/dataflux-func/script-market-guance-integration-intro)

> 提示：使用本采集器前，必须安装「观测云集成（核心包）」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段         | 类型 | 是否必须 | 说明                                     |
| ------------ | ---- | -------- | ---------------------------------------- |
| `regions`    | list | 必须     | 所需采集的地域列表                       |
| `regions[#]` | str  | 必须     | 地域ID。如：`'cn-north-1'`<br>总表见附录 |

## 2. 配置示例

### 指定地域

采集宁夏、北京地域的实例数据

~~~python
collector_configs = {
    'regions': [ 'cn-northwest-1', 'cn-north-1' ]
}
~~~

## 3. 数据上报格式

数据正常同步后，可以在观测云的「基础设施 - 自定义（对象）」中查看数据。

上报的数据示例如下：

~~~json
{
  "measurement": "aws_rds",
  "tags": {
    "name"                     : "xxxxx",
    "RegionId"                 : "cn-northwest-1",
    "Engine"                   : "mysql",
    "DBInstanceClass"          : "db.t3.medium",
    "DBInstanceIdentifier"     : "xxxxxx",
    "AvailabilityZone"         : "cn-northwest-1c",
    "SecondaryAvailabilityZone": "cn-northwest-1d"
  },
  "fields": {
    "InstanceCreateTime"  : "2018-03-28T19:54:07.871Z",
    "LatestRestorableTime": "2018-03-28T19:54:07.871Z",
    "Endpoint"            : "{连接地址JSON数据}",
    "AllocatedStorage"    : 100,
    "message"             : "{实例JSON数据}",
  }
}
~~~

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.name`值为实例ID，作为唯一识别

> 提示2：`fields.message`、`fields.Endpoint`、均为JSON序列化后字符串

## X. 附录

请参考AWS官方文档：

- [AWS RDS地域ID](https://docs.aws.amazon.com/zh_cn/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html)
