# 采集器「阿里云-VPN」配置手册
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

数据正常同步后，可以在观测云的「基础设施 - 自定义（对象）」中查看数据。

上报的数据示例如下：

~~~json
{
  "measurement": "aliyun_vpn",
  "tags": {
    "name"            : "vpn-xxxx",
    "VpnGatewayId"    : "vpn-xxxx",
    "vpn_gateway_name": "DMS 测试",
    "InternetIp"      : "47.xxxx",
    "RegionId"        : "cn-hangzhou",
    "VpcId"           : "vpc-xxxx",
    "BusinessStatus"  : "Normal"
  },
  "fields": {
    "CreateTime": 1650357175000,
    "EndTime"   : 1652976000000,
    "message"   : "{实例 JSON 数据}"
  }
}
~~~

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.name`值为实例 ID，作为唯一识别

> 提示 2：`fields.message`均为 JSON 序列化后字符串

> 提示 3：`tags.vpn_gateway_name`取值为阿里云 api 返回的 Name 字段，值为 vpn 网关名

## X. 附录

请参考阿里云官方文档：

- [地域和可用区](https://help.aliyun.com/document_detail/199009.html)
- [VPN 网关](https://help.aliyun.com/document_detail/199009.html)
