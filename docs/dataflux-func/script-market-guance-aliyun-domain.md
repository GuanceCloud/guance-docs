# 采集器「阿里云-域名」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成 Core 核心包」及其配套的第三方依赖包

## 1. 配置结构

本脚本无需额外配置

## 2. 数据上报格式

数据正常同步后，可以在观测云的「基础设施 - 自定义（对象）」中查看数据。

上报的数据示例如下：

```json
{
  "measurement": "aliyun_domain",
  "tags": {
    "name"        : "S202182xxx",
    "DomainType"  : "New gTLD",
    "InstanceId"  : "S202182xxx",
    "DomainName"  : "slxxx",
    "DomainStatus": "3"
  },
  "fields": {
    "ExpirationDate"      : "2023-10-18 07:59:59",
    "ExpirationDateStatus": "1",
    "RegistrationDate"    : "2021-10-17 10:01:53",
    "message"             : "{实例 JSON 数据}"
  }
}
```

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.name`值为实例 ID，作为唯一识别

> 提示 2：`fields.message`为 JSON 序列化后字符串，`fields.DomainStatus`表示域名状态，取值：1：急需续费。2：急需赎回。3：正常。`fields.ExpirationDateStatus`表示域名过期状态，取值：1：域名未过期。2：域名已过期。

## X. 附录

请参考阿里云官方文档：

- [阿里云域名](https://help.aliyun.com/product/35473.html)