# 采集器「华为云-DDS」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成 Core 核心包」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段                 | 类型     | 是否必须 | 说明                                                                                                       |
| -------------------- | -------- | -------- | ---------------------------------------------------------------------------------------------------------- |
| `region_projects`    | dict     | 必须     | 所需采集数据的「地域 - 项目 ID」列表                                                                       |
| `region_projects[#]` | str:list | 必须     | 键值对中：<br>Key 代表地域（如：`'cn-north-4'`）<br>Value 代表该地域下所需采集的项目 ID 列表<br>总表见附录 |

## 2. 配置示例

### 指定地域

采集`cn-north-4`地域对应项目的 DDS 实例数据

~~~python
collector_configs = {
    'region_projects': {
        'cn-north-4': ['c631f046252d4exxxxxxxxxxx'],
    }
}
~~~

## 3. 数据上报格式

数据正常同步后，可以在观测云的「基础设施 - 自定义对象」中查看数据。

上报的数据示例如下：

~~~json
{
  "measurement": "huaweicloud_dds",
  "tags": {
    "name"                 : "2afe1b3ce2xxxxxx",
    "RegionId"             : "cn-north-4",
    "db_user_name"         : "rwuser",
    "engine"               : "wiredTiger",
    "enterprise_project_id": "0",
    "id"                   : "2afe1b3ce2xxxxxx",
    "instance_name"        : "dds-xxxx",
    "mode"                 : "Single",
    "pay_mode"             : "0",
    "port"                 : "8635",
    "project_id"           : "c631f046252d4ebdaxxxx",
    "security_group_id"    : "d13ebb59-d4fe-43a5-9832-xxxx",
    "ssl"                  : "0",
    "status"               : "normal",
    "vpc_id"               : "f6bc2c55-2a95-40ce-835b-xxxx"
  },
  "fields": {
    "backup_strategy": "{备份策略}",
    "created"        : "2022-08-01T10:07:41",
    "datastore"      : "{数据库信息}",
    "groups"         : "[{组信息}]",
    "updated"        : "2022-08-01T10:07:40",
    "message"        : "{实例 JSON 数据}"
  }
}
~~~

部分字段说明如下：

| 字段                    | 类型    | 说明                                                                                                                                                                                                                                                    |
| ----------------------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `enterprise_project_id` | String  | 企业项目 ID。<br>取值为“0”，表示为 default 企业项目。                                                                                                                                                                                                   |
| `engine`                | String  | 存储引擎。支持 WiredTiger/RocksDB 存储引擎。<br>数据库版本为 4.2 时，存储引擎为 RocksDB，取值为“rocksDB”。<br>数据库版本为 4.0 和 3.4 时，存储引擎为 WiredTiger，取值为“wiredTiger”。                                                                   |
| `mode`                  | String  | 实例类型。<br>取值为“Sharding”，表示集群实例。<br>取值为“ReplicaSet”，表示副本集实例。<br>取值为“Single”，表示单节点实例。                                                                                                                              |
| `pay_mode`              | String  | 计费方式。<br>取值为“0”，表示按需计费。<br>取值为“1”，表示包年/包月计费                                                                                                                                                                                 |
| `ssl`                   | Integer | 是否开启 SSL 安全连接。<br>取值为“1”，表示开启。<br>取值为“0”，表示不开启。                                                                                                                                                                             |
| `status`                | String  | 实例状态。<br>取值：<br>normal，表示实例正常。<br>abnormal，表示实例异常。<br>creating，表示实例创建中。<br>frozen，表示实例被冻结。<br>data_disk_full，表示存储空间满。 <br>createfail，表示实例创建失败。 <br>enlargefail，表示实例扩容节点个数失败。 |

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示 1：`tags.name`值为实例 ID，作为唯一识别

> 提示 2：以下字段均为 JSON 序列化后字符串
> - `fields.messages`
> - `fields.backup_strategy`
> - `fields.datastore`
> - `fields.groups`

> 提示 3：fields.backup_strategy 和 fields.datastore 和 fields.groups 里面的具体字段含义可以查看附录里面的查询实例列表和详情接口文档

## X. 附录

### 华为云 DDS「地域 ID」

请参考华为云官方文档：

- [文档数据库服务 DDS 查询实例列表和详情接口](https://support.huaweicloud.com/api-dds/dds_api_0023.html)
- [文档数据库服务 DDS 地域 ID](https://developer.huaweicloud.com/endpoint?DDS)
