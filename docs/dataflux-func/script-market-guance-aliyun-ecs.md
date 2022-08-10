# 采集器「阿里云-ECS」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成（核心包）」及其配套的第三方依赖包

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

数据正常同步后，可以在观测云的「基础设施 - 自定义（对象）」中查看数据。

上报的数据示例如下：

~~~json
{
  "measurement": "aliyun_ecs",
  "tags": {
    "name"              : "i-xxxxx",
    "HostName"          : "xxxxx",
    "InstanceName"      : "xxxxx",
    "InstanceId"        : "i-xxxxx",
    "RegionId"          : "cn-hangzhou",
    "ZoneId"            : "cn-hangzhou-a",
    "InstanceChargeType": "PrePaid",
    "InternetChargeType": "PayByTraffic",
    "OSType"            : "linux"
  },
  "fields": {
    "CreationTime"      : "2022-01-01T00:00Z",
    "StartTime"         : "2022-01-02T00:00Z",
    "ExpiredTime"       : "2023-01-01T00:00Z",
    "disks"             : "[ {关联磁盘 JSON 数据}, ... ]",
    "network_interfaces": "[ {关联网卡 JSON 数据}, ... ]",
    "message"           : "{实例 JSON 数据}"
  }
}
~~~

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.name`值为实例 ID，作为唯一识别

> 提示 2：`fields.message`、`fields.disks`、`fields.network_interfaces`均为 JSON 序列化后字符串

## X. 附录

请参考阿里云官方文档：

- [云服务器 ECS / 产品简介 / 地域和可用区](https://help.aliyun.com/document_detail/188196.html)
