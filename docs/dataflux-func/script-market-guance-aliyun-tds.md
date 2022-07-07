# 采集器「阿里云-TDS」配置手册
---


阅读本文前，请先阅读：

- [观测云集成简介](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成（核心包）」及其配套的第三方依赖包

## 1. 配置结构

本采集器无需配置

## 2. 数据上报格式

数据正常同步后，可以在观测云的「基础设施-自定义对象」中查看数据。

上报的数据示例如下：

~~~json
{
  "measurement": "aliyun_tds",
  "tags": {
    "InstanceId": "sas-3dvxxxczf07",
    "Version"   : "3",
    "name"      : "sas-3dxxx0xczf07"
  },
  "fields": {
    "ReleaseTime"   : 1668182400000,
    "IsTrialVersion": 0,
    "MVAuthCount"   : 0,
    "AssetLevel"    : 66,
    "IsOverBalance" : false,
    "SlsCapacity"   : 1540,
    "message"       : "{实例 JSON 数据}"
  }
}
~~~

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.name`值为实例 ID，作为唯一识别

> 提示 2：`fields.message`均为 JSON 序列化后字符串

## X. 附录

请参考阿里云官方文档：

- [云安全中心实例的版本详情](https://help.aliyun.com/document_detail/421770.html)
