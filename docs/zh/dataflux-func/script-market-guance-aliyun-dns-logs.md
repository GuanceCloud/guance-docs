# 采集器「阿里云-DNSLogs」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成 Core 核心包」及其配套的第三方依赖包

## 1. 配置结构

本脚本无需额外配置

## 2. 数据上报格式

数据正常同步后，可以在观测云的「日志-查看器」中查看数据。

解析操作日志数据示例如下：

```json
{
  "measurement": "aliyun_dns_record_logs",
  "tags": {
    "domain" : "cloudxxxxxx",
    "Action" : "DEL",
    "Message": "Delete resolution record.xxxxxx"
  },
  "fields": {
    "ActionTime": "2022-03-15T14:56Z",
    "message"   : "{日志完整实例 JSON 数据}"
  }
}
```

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动。*

*注意 2：当开启定时任务时，考虑到接口只能以天为单位返回数据，在保证不重复上报日志数据的前提下，定时任务按照 1 天为时间范围对数据进行同步。*

> 提示：`tags.domain`值为域名，作为日志数据来源

> 提示 2：`fields.message`为完整日志 JSON 序列化后字符串

## X. 附录

请参考阿里云官方文档：

- [地域和可用区](https://help.aliyun.com/document_detail/188196.html)
- [云解析 DNS](https://help.aliyun.com/product/29697.html)