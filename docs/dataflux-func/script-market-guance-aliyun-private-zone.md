# 采集器「阿里云-PrivateZone」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成（核心包）」及其配套的第三方依赖包

> 提示 2：PrivateZone 采集器不需要配置地域参数

## 1. 数据上报格式

数据正常同步后，可以在观测云的「基础设施-自定义对象」中查看数据。

上报的数据示例如下：

~~~json
{
  "measurement": "aliyun_private_zone",
  "tags": {
    "name"        : "3fbfxxxxxxxxxxxxxxxxd90",
    "Status"      : "OPENED",
    "ZoneId"      : "3fbfxxxxxxxxxxxxxxxxbd90",
    "ZoneName"    : "xxxxxx",
    "ProxyPattern": "RECORD",
    "ZoneType"    : "AUTH_ZONE",
    "IsPtr"       : "false"
  },
  "fields": {
    "CreateTime": "2022-03-30T10:17Z",
    "BindVpcs"  : "[ {绑定的 VPC JSON 数据}, ... ]",
    "message"   : "{实例 JSON 数据}"
  }
}
~~~

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.name`值为实例 ID，作为唯一识别

> 提示 2：`fields.message`、`fields.BindVpcs`均为 JSON 序列化后字符串
