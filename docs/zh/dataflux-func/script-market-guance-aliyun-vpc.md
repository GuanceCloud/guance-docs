# 采集器「阿里云-VPC」配置手册
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

```python
collector_configs = {
    'regions': [ 'cn-hangzhou', 'cn-shanghai' ]
}
```

## 3. 数据上报格式

数据正常同步后，可以在观测云的「基础设施 - 自定义（对象）」中查看数据。

上报的数据示例如下：

```json
 {
  "measurement": "aliyun_vpc",
  "tags": {
    "name" : "vpc-bpxxxxxxxxxx",
    "VpcId": "vpc-bpxxxxxxxxxx"
  },
  "fields": {
    "VpcName"  : "Operator",
    "RegionId" : "cn-hangzhou",
    "VRouterId": "vrt-bp13e10uxxxxxxxxxx",
    "CidrBlock": "192.168.0.0/16",
    "message"  : "{实例 JSON 数据}"
  }
}
```

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.VpcId` 值作为唯一识别

> 提示 2：`fields.message` 为 JSON 序列化后字符串

## X. 附录

请参考阿里云官方文档：

- [地域和可用区](https://help.aliyun.com/document_detail/188196.html)
- [专有网络 VPC](https://help.aliyun.com/product/27706.html)
