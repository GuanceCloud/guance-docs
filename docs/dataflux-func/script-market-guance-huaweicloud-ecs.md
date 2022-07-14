# 采集器「华为云-ECS」配置手册
---


阅读本文前，请先阅读：

- [观测云集成简介](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成（核心包）」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段                 | 类型     | 是否必须 | 说明                                                                                                       |
| -------------------- | -------- | -------- | ---------------------------------------------------------------------------------------------------------- |
| `region_projects`    | dic      | 必须     | 所需采集数据的「地域 - 项目 ID」列表                                                                       |
| `region_projects[#]` | str:list | 必须     | 键值对中：<br>Key 代表地域（如：`'cn-north-4'`）<br>Value 代表该地域下所需采集的项目 ID 列表<br>总表见附录 |

## 2. 配置示例

### 指定地域

采集`cn-north-4`地域下对应项目的 ECS 实例数据

~~~python
collector_configs = {
    'region_projects':{
        'cn-north-4': ['c631f046252d4exxxxxxxxxxx', '15c6ce1c12da40xxxxxxxx9']
}
~~~

## 3. 数据上报格式

数据正常同步后，可以在观测云的「基础设施-自定义对象」中查看数据。

上报的数据示例如下：

~~~json
{
    "measurement": "huaweicloud_ecs",
    "tags": {
      "status"                     : "ACTIVE",
      "id"                         : "xxxxx",
      "OS-EXT-AZ:availability_zone": "cn-southeast-1",
      "name"                       : "xxxxx",
      "project_id"                 : "xxxxxxx",
      "vpc_id"                     : "3dda7d4b-aec0-4838-a91a-28xxxxxxxx",
      "instance_name"              : "ecs-3384",
      "charging_mode"              : "0",
      "resource_spec_code"         : "sn3.small.1.linux",
      "resource_type"              : "1",
      "metadata_os_type"           : "Linux",
      "RegionId"                   : "cn-north-4"
    },
    "fields": {
        "hostId"                              : "1e122315dac18163814b9e0d0fc6xxxxxx",
        "created"                             : "2022-06-16T10:13:24Z",
        "description"                         : "{JSON 数据}",
        "addresses"                           : "{IPJSON 数据}",
        "os-extended-volumes:volumes_attached": "{JSON 数据}",
        "message"                             : "{实例 JSON 数据}",
		}
}
~~~

部分参数说明如下：

| 参数名称             | 说明                   |
| -------------------- | ---------------------- |
| `resource_spec_code` | 资源规格               |
| `resource_type`      | 云服务器对应的资源类型 |

charging_mode（云服务器付费类型）取值含义：

| 取值 | 说明                                  |
| ---- | ------------------------------------- |
| `0`  | 按需计费（即 postPaid-后付费方式）    |
| `1`  | 包年包月计费（即 prePaid-预付费方式） |
| `2`  | 竞价实例计费                          |

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

>提示：`tags.name`值为实例 ID，作为唯一识别

>提示 2：`status`取值范围及对应含义请见附录云服务器状态

## X. 附录

### 华为云 ECS「地域 ID」

请参考华为云官方文档：

- [华为云 地域 ID](https://developer.huaweicloud.com/endpoint)
- [华为云 云服务器状态](https://support.huaweicloud.com/api-ecs/ecs_08_0002.html)
