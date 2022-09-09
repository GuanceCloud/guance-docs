# 采集器「阿里云-EIP」配置手册
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
  "measurement": "aliyun_eip",
  "tags": {
    "name"              : "eip-xxxxx",
    "AllocationId"      : "eip-bp1lfsikwo4roa0mcqg9u",
    "RegionId"          : "cn-hangzhou",
    "Bandwidth"         : "1",
    "IpAddress"         : "47.96.22.249",
    "InternetChargeType": "PayByTraffic",
    "BusinessStatus"    : "Normal",
    "ChargeType"        : "PostPaid"
  },
  "fields": {
    "AllocationTime": "2022-01-20T03:06:51Z",
    "ExpiredTime"   : "",
    "message"       : "{实例 JSON 数据}"
  }
}
~~~

部分参数说明如下：

`tags.InternetChargeType`（付费类型）取值含义：

| 取值             | 说明           |
| ---------------- | -------------- |
| `PayByBandwidth` | 按固定带宽计费 |
| `PayByTraffic`   | 按使用流量计费 |

`tags.ChargeType`（计费模式）取值含义：

| 取值       | 说明     |
| ---------- | -------- |
| `PrePaid`  | 包年包月 |
| `PostPaid` | 按量计费 |

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.name`值为实例 ID，作为唯一识别

> 提示 2：`fields.message`均为 JSON 序列化后字符串

## X. 附录

请参考阿里云官方文档：

- [阿里云弹性公网 IP](https://help.aliyun.com/product/61789.html)
