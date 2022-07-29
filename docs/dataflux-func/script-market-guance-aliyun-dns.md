# 采集器「阿里云-DNS」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成（核心包）」及其配套的第三方依赖包

## 1. 配置结构

本脚本无需额外配置

## 2. 数据上报格式

数据正常同步后，可以在观测云的「基础设施-自定义」中查看数据。

DNS（免费版）上报的数据示例如下：

```json
{
  "measurement": "aliyun_dns",
  "tags": {
    "name"       : "ccc16844xxxxx",
    "DomainId"   : "ccc16844xxxxx",
    "DomainName" : "slo.xxxxx",
    "VersionCode": "mianfei",
    "VersionName": "Alibaba Cloud DNS"
  },
  "fields": {
    "CreateTime": "2021-10-17T02:01Z",
    "message"   : "{实例 JSON 数据}"
  }
}
```

DNS（付费版）上报的数据示例如下：

```json
{
  "measurement": "aliyun_dns",
  "tags": {
    "name"          : "dns-cn-xxxxx",
    "DomainId"      : "dns-cn-xxxxx",
    "DomainName"    : "slo.xxxxx",
    "VersionCode"   : "xxxxxx",
    "InstanceId"    : "dns-cn-xxxxx",
    "VersionName"   : "Alibaba Cloud DNS",
    "account_name"  : "脚本开发用阿里云账号",
    "cloud_provider": "aliyun"
  },
  "fields": {
    "CreateTime"     : "2021-10-17T02:01Z",
    "InstanceEndTime": "2022-04-24T16:00Z",
    "InstanceExpired": false,
    "message"        : "{实例 JSON 数据}"
  }
}
```

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.name`值为实例 ID，作为唯一识别

> 提示 2：`fields.message`为 JSON 序列化后字符串

## X. 附录

请参考阿里云官方文档：

- [地域和可用区](https://help.aliyun.com/document_detail/188196.html)
- [云解析 DNS](https://help.aliyun.com/product/29697.html)