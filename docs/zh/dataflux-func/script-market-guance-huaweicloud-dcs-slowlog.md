# 采集器「华为云-DCS 慢日志统计采集器」配置手册
---


阅读本文前，请先阅读：

- [观测云集成简介](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成 Core 核心包」及其配套的第三方依赖包

> 提示 2：本脚本的代码运行依赖 DCS 实例对象采集，如果未配置 DCS 的自定义对象采集，慢日志脚本无法采集到慢日志数据

## 1. 配置结构

本采集器配置结构如下：

| 字段                 | 类型     | 是否必须 | 说明                                                                                                       |
| -------------------- | -------- | -------- | ---------------------------------------------------------------------------------------------------------- |
| `region_projects`    | dict     | 必须     | 所需采集数据的「地域 - 项目 ID」列表                                                                       |
| `region_projects[#]` | str:list | 必须     | 键值对中：<br>Key 代表地域（如：`'cn-north-4'`）<br>Value 代表该地域下所需采集的项目 ID 列表<br>总表见附录 |

## 2. 配置示例

### 指定地域

采集`cn-north-4`地域对应项目的 DCS 慢日志数据

~~~python
collector_configs = {
    'region_projects': {
        'cn-north-4' : ['c631f046252d4exxxxxxxxxxx', '15c6ce1c12da40xxxxxxxx9'],
    }
}
~~~

## 3. 数据上报格式

数据正常同步后，可以在观测云的「日志」中查看数据。

上报的数据示例如下：

~~~json
{
    "measurement": "huaweicloud_dcs_slowlog",
    "tags": {
      "id"             : "674",
      "command"        : "INFO all",
      "shard_name"     : "group-0",
      "RegionId"       : "cn-north-4",
      "az_codes"       : "[\"cn-north-4c\"]",
      "charging_mode"  : "0",
      "enable_publicip": "False",
      "engine"         : "Redis",
      "engine_version" : "5.0",
      "instance_id"    : "ccbaa7e3-91e1-xxxxx-xxxx-b3955a8baa34",
      "instance_name"  : "dcs-华为云测试",
      "ip"             : "192.168.0.214",
      "name"           : "ccbaa7e3-91e1-xxxx-xxxx-b3955a8baa34",
      "port"           : "6379",
      "project_id"     : "c631f046252d4ebda45f253c62d48585",
      "spec_code"      : "redis.single.xu1.tiny.128",
      "status"         : "RUNNING"
    },
    "fields": {
			"duration"     : "62",
      "start_time": "2022-07-21T10:40:02Z",
      "message"   : "{实例 JSON 数据}"
    }
}
~~~
部分参数说明如下

| 字段       | 类型 | 说明     |
| ---------- | ---- | -------- |
| `duration` | str  | 执行时间 |

## 4. 注意事项

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`fields.message`为 JSON 序列化后字符串

## X. 附录

### HuaWeiCloud-DCS「地域」

请参考 HuaWeiCloud 官方文档：

- [HuaWeiCloud-DCS 地域 ID](https://developer.huaweicloud.com/endpoint?Redis)

### HuaWeiCloud-DCS「慢日志信息说明文档」

请参考 HuaWeiCloud 官方文档：

- [HuaWeiCloud-DCS 获取慢日志统计信息](https://support.huaweicloud.com/api-dcs/ListSlowlog.html)
