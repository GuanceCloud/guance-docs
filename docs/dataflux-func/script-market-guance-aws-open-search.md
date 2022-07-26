# 采集器「AWS-OpenSearch」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成（核心包）」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段         | 类型 | 是否必须 | 说明                                      |
| ------------ | ---- | -------- | ----------------------------------------- |
| `regions`    | list | 必须     | 所需采集的地域列表                        |
| `regions[#]` | str  | 必须     | 地域 ID。如：`'cn-north-1'`<br>总表见附录 |

## 2. 配置示例

### 指定地域

采集宁夏、北京地域的实例数据

~~~python
collector_configs = {
    'regions': [ 'cn-northwest-1', 'cn-north-1' ]
}
~~~

## 3. 数据上报格式

数据正常同步后，可以在观测云的「基础设施 - 自定义（对象）」中查看数据。

上报的数据示例如下：

~~~json
{
  "measurement": "aws_opensearch",
  "tags": {
    "name"                  : "df-prd-es",
    "EngineVersion"         : "Elasticsearch_7.10",
    "DomainId"              : "5882XXXXX135/df-prd-es",
    "DomainName"            : "df-prd-es",
    "ClusterConfig"         : "{域中的实例类型和实例数量 JSON 数据}",
    "ServiceSoftwareOptions": "{服务软件的当前状态 JSON 数据}",
    "region"                : "cn-northwest-1",
    "RegionId"              : "cn-northwest-1"
  },
  "fields": {
    "EBSOptions": "{指定域的弹性块存储数据 JSON 数据}",
    "Endpoints" : "{用于提交索引和搜索请求的域端点的映射 JSON 数据}",
    "message"   : "{实例 JSON 数据}"
  }
}
~~~

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.name`值为实例 ID，作为唯一识别

> 提示 2：本脚本`tags.name`对应的数据字段为`DomainName`，使用本脚本的时候需要注意多个 AWS 账户内不要出现重复的`DomainName`值。

> 提示 3：`tags.ClusterConfig`、`tags.Endpoint`、`tags.ServiceSoftwareOptions`、`fields.message`、`fields.EBSOptions`、`fields.Endpoints`、均为 JSON 序列化后字符串

## X. 附录

请参考 AWS 官方文档：

- [AWS OpenSearch 地域 ID](https://docs.aws.amazon.com/zh_cn/opensearch-service/latest/developerguide/createupdatedomains.html)
