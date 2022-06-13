# 采集器「阿里云-OSS」配置手册
---


阅读本文前，请先阅读：

- [观测云集成简介](https://docs.guance.com/dataflux-func/script-market-guance-integration-intro)

> 提示：使用本采集器前，必须安装「观测云集成（核心包）」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段         | 类型 | 是否必须 | 说明                                      |
| ------------ | ---- | -------- | ----------------------------------------- |
| `regions`    | list | 必须     | 所需采集的地域列表                        |
| `regions[#]` | str  | 必须     | 地域ID。如：`'cn-hangzhou'`<br>总表见附录 |

## 2. 配置示例

### 指定地域

采集杭州、上海地域的数据

~~~python
collector_configs = {
    'regions': [ 'cn-hangzhou', 'cn-shanghai' ]
}
~~~

## 3. 数据上报格式

数据正常同步后，可以在观测云的「基础设施 - 自定义对象」中查看数据。

上报的数据示例如下：

~~~json
{
  "measurement": "aliyun_oss",
  "tags": {
    "name"         : "ack-backup-hangzhou",
    "RegionId"     : "oss-cn-hangzhou",
    "storage_class": "IA",
    "location"     : "oss-cn-hangzhou",
    "grant"        : "private"
  },
  "fields": {
    "extranet_endpoint": "oss-cn-hangzhou.aliyuncs.com",
    "intranet_endpoint": "oss-cn-hangzhou-internal.aliyuncs.com",
    "creation_date"    : 1638415082,
    "message"          : "{实例JSON数据}"
  }
}
~~~

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.name` 值为 Bucket 名称，作为唯一识别

> 提示2：`fields.message`为JSON序列化后字符串

## X. 附录

请参考阿里云官方文档：

- [对象存储 OSS / 开发指南 / 访问域名 / 访问域名和数据中心](https://help.aliyun.com/document_detail/31837.html)
