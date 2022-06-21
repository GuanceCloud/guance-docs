# 采集器「AWS-S3」配置手册
---


阅读本文前，请先阅读：

- [观测云集成简介](/dataflux-func/script-market-guance-integration)

提示：使用本采集器前，必须安装「观测云集成（核心包）」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段         | 类型 | 是否必须 | 说明                                      |
| ------------ | ---- | -------- | ----------------------------------------- |
| `regions`    | list | 必须     | 所需采集的地域列表                        |
| `regions[#]` | str  | 必须     | 地域 ID。如：`'cn-north-1'`<br>总表见附录 |

## 2. 配置示例

采集宁夏、北京地域的实例数据

```python
collector_configs = {
    'regions': [ 'cn-northwest-1', 'cn-north-1' ]
}
```

## 3. 数据上报格式

数据正常同步后，可以在观测云的「基础设施 - 自定义（对象）」中查看数据。

上报的数据示例如下：

```json
{
  "measurement": "aws_s3",
  "tags": {
    "name"              : "dataxxxx",
    "RegionId"          : "cn-northwest-1",
    "LocationConstraint": "cn-northwest-1",
    "Name"              : "dataxxxx"
  },
  "fields": {
    "CreationDate": "2022-03-09T06:13:31Z",
    "Grants"      : "{JSON 数据}",
    "message"     : "{实例 JSON 数据}"
  }
}
```

*注意：*`*tags*`*、*`*fields*`*中的字段可能会随后续更新有所变动*

> 提示：`tags.name`值为实例名称，作为唯一识别
>
> 提示 2：`fields.message`为 JSON 序列化后字符串
>
> 提示 3: `fields.Grants`为 bucket 访问控制列表

## X. 附录

请参考 AWS 官方文档：

- [Elastic Load Balancing Documentation](https://docs.aws.amazon.com/elasticloadbalancing/index.html)
- [Amazon Simple Storage Service](https://docs.aws.amazon.com/zh_cn/s3/index.html)
