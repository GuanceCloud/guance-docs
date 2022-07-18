# 采集器「华为云-RDS」配置手册
---


阅读本文前，请先阅读：

- [观测云集成简介](/dataflux-func/script-market-guance-integration-intro)

> 提示：使用本采集器前，必须安装「观测云集成（核心包）」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段                 | 类型     | 是否必须 | 说明                                                                                                       |
| -------------------- | -------- | -------- | ---------------------------------------------------------------------------------------------------------- |
| `region_projects`    | dict     | 必须     | 所需采集数据的「地域 - 项目 ID」列表                                                                       |
| `region_projects[#]` | str:list | 必须     | 键值对中：<br>Key 代表地域（如：`'cn-north-4'`）<br>Value 代表该地域下所需采集的项目 ID 列表<br>总表见附录 |

## 2. 配置示例

### 指定地域

采集`cn-north-4`地域对应项目的 RDS 实例数据

~~~python
collector_configs = {
    'region_projects': {
        'cn-north-4' : ['c631f046252d4exxxxxxxxxxx', '15c6ce1c12da40xxxxxxxx9'],
    }
}
~~~

## 3. 数据上报格式

数据正常同步后，可以在观测云的「基础设施 - 自定义对象」中查看数据。

上报的数据示例如下：

~~~json
{
  "measurement": "huaweicloud_rds",
  "tags": {
    "id"                     : "1d0c91561f4644dxxxxxxd68304b0520din01",
    "instance_name"          : "rds-df54-xxxx",
    "status"                 : "ACTIVE",
    "port"                   : "3306",
    "type"                   : "Single",
    "RegionId"               : "cn-north-4",
    "security_group_id"      : "d13ebb59-d4fe-xxxx-xxxx-c22bcea6f987",
    "switch_strategy"        : "xxx",
    "project_id"             : "c631f046252dxxxxxxxf253c62d48585",
    "time_zone"              : "UTC+08:00",
    "enable_ssl"             : "False",
    "charge_info.charge_mode": "postPaid",
    "name"                   : "1d0c91561f4644daxxxxx68304b0520din01"
  },
  "fields": {
    "created"         : "2022-06-21T06:17:27+0000",
    "updated"         : "2022-06-21T06:20:03+0000",
    "alias"           : "xxx",
    "private_ips"     : "[\"192.xxx.x.144\"]",
    "public_ips"      : "[]",
    "datastore"       : "{数据库信息}",
    "cpu"             : "2",
    "mem"             : "4",
    "volume"          : "{volume 信息}",
    "nodes"           : "[{主备实例信息}]",
    "related_instance": "[]",
    "backup_strategy" : "{备份策略}",
    "message"         : "{实例 JSON 数据}"
  }
}
~~~

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.name`值为实例 ID，作为唯一识别

> 提示 2：以下字段均为 JSON 序列化后字符串
>
> - `fields.message`
> - `fields.private_ips`
> - `fields.public_ips`
> - `fields.datastore`
> - `fields.volume`
> - `fields.nodes`
> - `fields.related_instance`
> - `fields.backup_strategy`

## X. 附录

### 华为云 RDS「地域 ID」

请参考华为云官方文档：

- [云数据库 RDS 实例列表接口](https://support.huaweicloud.com/api-rds/rds_01_0004.html#section4)
- [云数据库 RDS 地域 ID](https://developer.huaweicloud.com/endpoint?RDS)
