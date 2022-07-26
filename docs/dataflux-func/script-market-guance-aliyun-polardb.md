# 采集器「阿里云-POLARDB」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成（核心包）」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段         | 类型 | 是否必须 | 说明                                       |
| ------------ | ---- | -------- | ------------------------------------------ |
| `regions`    | list | 必须     | 所需采集的地域列表                         |
| `regions[#]` | str  | 必须     | 地域 ID。如：`'cn-hangzhou'`<br>总表见附录 |

## 2. 配置示例

### 指定地域

采集杭州地域的数据

~~~python
collector_configs = {
    'regions': [ 'cn-hangzhou']
}
~~~

## 3. 数据上报格式

数据正常同步后，可以在观测云的「基础设施-自定义对象」中查看数据。

上报的数据示例如下：

~~~json
{
  "measurement": "aliyun_polardb",
  "tags": {
    "name"                : "pc-xxxx",
    "RegionId"            : "cn-hangzhou",
    "VpcId"               : "vpc-xxxx",
    "DBNodeNumber"        : "2",
    "PayType"             : "Postpaid",
    "DBType"              : "MySQL",
    "LockMode"            : "Unlock",
    "DBVersion"           : "8.0",
    "DBClusterId"         : "pc-xxxx",
    "DBClusterNetworkType": "VPC",
    "ZoneId"              : "cn-hangzhou-i",
    "Engine"              : "POLARDB",
    "Category"            : "Normal",
    "DBClusterDescription": "pc-xxxx",
    "DBNodeClass"         : "polar.mysql.x4.medium"
  },
  "fields": {
    "DBNodes"   : "{节点列表 JSON 数据}",
    "Database"  : "[数据库详情 JSON 数据]",
    "ExpireTime": "",
    "CreateTime": "2022-06-17T06:07:19Z",
    "message"   : "{实例 JSON 数据}"
  }
}
~~~

部分参数说明如下

tags.Category（集群系列）取值含义：

| 取值      | 说明   |
| --------- | ------ |
| `Normal`  | 集群版 |
| `Basic`   | 单节点 |
| `Archive` | 历史库 |

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.DBClusterId`值为实例 ID，作为唯一识别

## X. 附录

请参考阿里云官方文档：

- [地域和可用区](https://help.aliyun.com/document_detail/98469.html)
- [POlARDB](https://help.aliyun.com/document_detail/98094.htm?spm=a2c4g.11186623.0.0.38ca662bUEfp2W#t64946.html)
