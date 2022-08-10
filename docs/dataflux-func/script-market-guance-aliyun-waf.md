# 采集器「阿里云-Web 应用防火墙」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成（核心包）」及其配套的第三方依赖包

## 1. 配置结构

本脚本无需额外配置

## 2. 数据上报格式

数据正常同步后，可以在观测云的「基础设施 - 自定义（对象）」中查看数据。

上报的数据示例如下：

```json
{
  "measurement": "aliyun_waf",
  "tags": {
    "name"            : "waf-4haczyxxxxx",
    "InstanceId"      : "waf-4haczyzxxxxx",
    "PayType"         : "1",
    "Region"          : "cn",
    "Status"          : "1",
    "SubscriptionType": "Subscription",
    "Version"         : "version_2"
  },
  "fields": {
    "EndDate": 1669651200,
    "message": "{实例 JSON 数据}",
  }
}
```

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.name`值为实例 ID，作为唯一识别

> 提示 2：

> `fields.message`为 JSON 序列化后字符串。

> `tags.PayType`表示 WAF 实例的开通状态， 取值：0、表示当前阿里云账号未开通 WAF 实例；1：表示当前阿里云账号已开通 WAF 包年包月实例；2、表示当前阿里云账号已开通 WAF 按量计费实例。

> `tags.SubscriptionType`表示 WAF 实例计费方式，取值：1、Subscription 表示包年包月；2、PayAsYouGo 表示按量计费。

> `tags.Status`表示 WAF 实例业务状态，取值：0、表示已过期；1、表示未过期。

> `tags.Version`表示 WAF 实例的版本，取值详见附录文档。

## X. 附录

请参考阿里云官方文档：

- [阿里云 WAF](https://help.aliyun.com/document_detail/140857.html)
- [支持的地域列表](https://help.aliyun.com/document_detail/141033.html)
