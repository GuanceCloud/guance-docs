# 采集器「华为云-ELB」配置手册
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

```python
configs = {
    'region_projects':{
        'cn-north-4': ['c631f046252d4ebdxxxxxxxxxxx', '15c6ce1c12da4059a8xxxxxxxxxx']
    }
}
```

## 3. 数据上报格式

数据正常同步后，可以在观测云的「基础设施 - 自定义（对象）」中查看数据。

上报的数据示例如下：

```json
{
  "measurement": "huaweicloud_elb",
  "tags": {
    "name"            : "e9cb54b0-63e0-46c5xxxxxxxx",
    "description"     : "",
    "id"              : "e9cb54b0-63e0-46c5xxxxxxxxxx",
    "RegionId"        : "cn-north-4",
    "instance_name"   : "elb-xxxx",
    "operating_status": "ONLINE",
    "project_id"      : "c631f046252d4ebdaxxxxxxxxxx"
  },
  "fields": {
    "created_at": "2022-06-22T02:41:57",
    "listeners" : "{实例 JSON 数据}",
    "updated_at": "2022-06-22T02:41:57",
    "message"   : "{实例 JSON 数据}"
  }
}
```

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.name`值为实例 ID，作为唯一识别

> 提示 2：
>
> - `fields.message`、`fields.listeners`为 JSON 序列化后字符串。
> - `tags.operating_status`为负载均衡器的操作状态。取值范围：可以为 ONLINE 和 FROZEN。

## X. 附录

请参考华为云官方文档：

- [弹性负载均衡](https://support.huaweicloud.com/elb/index.html)
