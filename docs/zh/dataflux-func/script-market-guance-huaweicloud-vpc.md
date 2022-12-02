# 采集器「华为云-VPC」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成 Core 核心包」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段                 | 类型     | 是否必须 | 说明                                                                                                 |
| -------------------- | -------- | -------- | ---------------------------------------------------------------------------------------------------- |
| `region_projects`    | dict     | 必须     | 所需采集的 VPC 地区-项目 ID 映射                                                                     |
| `region_projects[#]` | str:list | 必须     | 键值对 key 代表地域如：`cn-north-4` 总表见附录。value 代表该地域下所需采集的项目 ID 列表，总表见附录 |

## 2. 配置示例

```python
configs = {
    'region_projects': {
        'cn-north-4': ['c631f046252d4ebdxxxxxxxxxxx', '15c6ce1c12da4059a8xxxxxxxxxx']
    }
}
```

## 3. 数据上报格式

数据正常同步后，可以在观测云的「基础设施 - 自定义（对象）」中查看数据。

上报的数据示例如下：

```json
{
  "measurement": "huaweicloud_vpc",
  "tags": {
    "name"          : "3ddxxx-axxx-48xx-a9xx-28fxxxxxxx",
    "RegionId"      : "cn-north-4",
    "account_name"  : "脚本开发用华为云账号",
    "project_id"    : "15c6ce1c12daxxxxxxx",
    "cloud_provider": "huaweicloud",
    "id"            : "3ddxxx-axxx-48xx-a9xx-28fxxxxxxx",
    "instance_name" : "vpc-default",
    "status"        : "ACTIVE"
  },
  "fields": {
    "created_at": "2022-06-16T10:12:12Z",
    "updated_at": "2022-06-16T10:12:13Z",
    "cidr"      : "192.168.0.0/16",
    "message"   : "{实例 JSON 数据}"
  }
}
```

部分字段说明如下，具体可看附录接口返回参数

| 字段            | 类型   | 说明                                                  |
| --------------- | ------ | ----------------------------------------------------- |
| `cidr`          | string | VPC 下可用子网的范围                                  |
| `status`        | string | VPC 对应的状态<br>PENDING：创建中<br>ACTIVE：创建成功 |
| `instance_name` | string | 实例名称                                              |

*注意：*`*tags*`*、*`*fields*`*中的字段可能会随后续更新有所变动*

> 提示：`tags.name` 值为实例 id，作为唯一识别

> 提示 2：`fields.message` 为 JSON 序列化后字符；

## X. 附录

请参考华为云官方文档：

- [华为云 VPC](https://support.huaweicloud.com/api-vpc/vpc_apiv3_0004.html)
- [区域和可用区](https://support.huaweicloud.com/productdesc-vpc/overview_region.html)