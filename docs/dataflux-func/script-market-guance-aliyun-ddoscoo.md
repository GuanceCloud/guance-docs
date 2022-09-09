# 采集器「阿里云-DDoS 高防（新 BGP/国际）」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成 Core 核心包」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段         | 类型 | 是否必须 | 说明                                                                             |
| ------------ | ---- | -------- | -------------------------------------------------------------------------------- |
| `regions`    | list | 必须     | 所需采集的 DDoS 高防地域列表                                                     |
| `regions[#]` | str  | 必须     | 地域 ID，可选值：<br>中国内地：`"cn-hangzhou"`<br>非中国内地：`"ap-southeast-1"` |

## 2. 配置示例

### 指定地域

采集 DDoS 高防国内实例数据

~~~python
aliyun_configs = {
    'regions': [ 'cn-hangzhou' ],
}
~~~

## 3. 数据上报格式

数据正常同步后，可以在观测云的「日志」中查看数据。

上报的数据示例如下：

~~~json
{
  "measurement": "aliyun_ddoscoo",
  "tags": {
    "name"      : "rg-acfm2pz25js****",
    "InstanceId": "rg-acfm2pz25js****",
    "RegionId"  : "cn-hangzhou",
    "Status"    : "1",
    "Edition"   : "9",
    "IpVersion" : "Ipv4",
    "Enabled"   : "1"
  },
  "fields": {
    "ExpireTime": "1637812279000",
    "CreateTime": "1637812279000",
    "message"   : "{实例 JSON 数据}"
  }
}
~~~

部分参数说明如下：

Edition（实例防护套餐版本）取值含义：

| 取值 | 说明                      |
| ---- | ------------------------- |
| `0`  | DDoS 高防（国际）保险版   |
| `1`  | DDoS 高防（国际）无忧版   |
| `2`  | DDoS 高防（国际）加速线路 |
| `3`  | DDoS 高防（新 BGP）专业版 |

Status（实例状态）取值含义：

| 取值 | 说明   |
| ---- | ------ |
| `1`  | 正常   |
| `2`  | 已过期 |

Enabled（实例业务流量转发状态）取值含义：

| 取值 | 说明                   |
| ---- | ---------------------- |
| `0`  | 表示已停止转发业务流量 |
| `1`  | 表示正常转发业务流量   |

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`fields.message`为 JSON 序列化后字符串

> 提示 2：时间均使用时间戳表示 单位：毫秒

## X. 附录

请参考阿里云官方文档：

- [DDoS 高防（新 BGP/国际）](https://help.aliyun.com/document_detail/91478.html))