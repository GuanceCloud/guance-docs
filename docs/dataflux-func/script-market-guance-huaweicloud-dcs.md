# 采集器「华为云-Dcs」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成（核心包）」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段                 | 类型     | 是否必须 | 说明                                                                                                       |
| -------------------- | -------- | -------- | ---------------------------------------------------------------------------------------------------------- |
| `region_projects`    | dict     | 必须     | 所需采集数据的「地域 - 项目 ID」列表                                                                       |
| `region_projects[#]` | str:list | 必须     | 键值对中：<br>Key 代表地域（如：`'cn-north-4'`）<br>Value 代表该地域下所需采集的项目 ID 列表<br>总表见附录 |

## 2. 配置示例

### 指定地域

采集`cn-north-4`地域对应项目的 Dcs 实例数据

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
  "measurement": "huaweicloud_redis",
  "tags": {
    "name"              : "71be0037-xxxx-xxxx-xxxx-b6b91f134066",
    "instance_id"       : "71be0037-xxxx-xxxx-xxxx-b6b91f134066",
    "instance_name"     : "dcs-iash",
    "RegionId"          : "cn-north-4",
    "project_id"        : "c631f04625xxxxxxxxxxf253c62d48585",
    "engine"            : "Redis",
    "engine_version"    : "5.0",
    "status"            : "RUNNING",
    "az_codes"          : "[\"cn-north-4c\", \"cn-north-4a\"]",
    "port"              : "6379",
    "ip"                : "192.xxx.x.144",
    "charging_mode"     : "0",
    "no_password_access": "true",
    "enable_publicip"   : "False"
  },
  "fields": {
    "created_at" : "2022-07-12T07:29:56.875Z",
    "max_memory" : 128,
    "used_memory": 2,
    "capacity"   : 0,
    "description": "",
    "message"    : "{实例 JSON 数据}"
  }
}
~~~

部分字段说明如下：

| 字段                 | 类型    | 说明                                                                                                                                                                                                                                                                                                                                                                                                         |
| -------------------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `ip`                 | String  | 连接缓存实例的 IP 地址。如果是集群实例，返回多个 IP 地址，使用逗号分隔。如：192.168.0.1，192.168.0.2。                                                                                                                                                                                                                                                                                                       |
| `charging_mode`      | String  | 计费模式，0 表示按需计费，1 表示包年/包月计费。                                                                                                                                                                                                                                                                                                                                                              |
| `no_password_access` | String  | 是否允许免密码访问缓存实例：<br>true：该实例无需密码即可访问。<br>false：该实例必须通过密码认证才能访问                                                                                                                                                                                                                                                                                                      |
| `enable_publicip`    | String  | Redis 缓存实例是否开启公网访问功能<br>True：开启<br>False：不开启                                                                                                                                                                                                                                                                                                                                            |
| `max_memory`         | Integer | 总内存，单位：MB。                                                                                                                                                                                                                                                                                                                                                                                           |
| `used_memory`        | Integer | 已使用的内存，单位：MB。                                                                                                                                                                                                                                                                                                                                                                                     |
| `capacity`           | Integer | 缓存容量（G Byte）。                                                                                                                                                                                                                                                                                                                                                                                         |
| `status`             | String  | CREATING ：申请缓存实例后，在缓存实例状态进入运行中之前的状态。<br>CREATEFAILED：缓存实例处于创建失败的状态。<br>RUNNING：缓存实例正常运行状态。<br>RESTARTING：缓存实例正在进行重启操作。<br/>FROZEN：缓存实例处于已冻结状态，用户可以在“我的订单”中续费开启冻结的缓存实例。<br/>EXTENDING：缓存实例处于正在扩容的状态。<br/>RESTORING：缓存实例数据恢复中的状态。<br/>FLUSHING：缓存实例数据清空中的状态。 |

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.name`值为实例 ID，作为唯一识别

> 提示 2：以下字段均为 JSON 序列化后字符串
> - `fields.message`
> - `tags.az_codes`

## X. 附录

### 华为云 Dcs「地域 ID」

请参考华为云官方文档：

- [分布式缓存服务  Dcs 实例列表接口](https://support.huaweicloud.com/api-dcs/ListInstances.html)
- [分布式缓存服务  Dcs  地域 ID](https://developer.huaweicloud.com/endpoint?Redis)
