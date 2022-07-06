# 采集器「阿里云-CAS」配置手册
---


阅读本文前，请先阅读：

- [观测云集成简介](/dataflux-func/script-market-guance-integration)

提示：使用本采集器前，必须安装「观测云集成（核心包）」及其配套的第三方依赖包

## 1. 配置结构

本脚本无需额外配置

## 3. 数据上报格式

数据正常同步后，可以在观测云的「基础设施 - 自定义（对象）」中查看数据。

上报的数据示例如下：

```json
{
  "measurement": "aliyun_cas",
  "tags": {
    "name": "2022-jixxx-com",
    "id"  : "6397xxx"
  },
  "fields": {
    "buyInAliyun": false,
    "endDate"    : "2022-10-08",
    "expired"    : false,
    "message"    : "{示例 json 数据}",
    "sans"       : "*.jixx.com,jixx.com",
    "startDate"  : "2021-10-08"
  }
}
```

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.name`值为证书名称，作为唯一识别

> 提示 2：`fields.message`为 JSON 序列化后字符串，`fields.buyInAliyun`字段表示该证书是否为阿里云证书，`fields.sans`为该证书绑定的所有域名。

## X. 附录

请参考阿里云官方文档：

- [数字证书管理服务](https://help.aliyun.com/product/28533.html)