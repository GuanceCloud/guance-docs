# 采集器「华为云-BMS」配置手册
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

采集`cn-north-4`地域对应项目的 BMS 实例数据

~~~python
collector_configs = {
    'region_projects': {
        'cn-north-4': ['c631f046252d4exxxxxxxxxxx', '15c6ce1c12da40xxxxxxxx9'],
    }
}
~~~

## 3. 数据上报格式

数据正常同步后，可以在观测云的「基础设施 - 自定义对象」中查看数据。

上报的数据示例如下：

~~~json
{
  "measurement": "huaweicloud_bms",
  "tags": {
    "name"                       : "bc49dcf2-ce5d-4a74-8960-92b00b19b24c",
    "id"                         : "bc49dcf2-ce5d-4a74-8960-92b00b19b24c",
    "user_id"                    : "869acd7a3xxxxxxxxxb9f12ed3",
    "tenant_id"                  : "0ad96f54xxxxxxxxxxxc0091a9278a4",
    "hostId"                     : "9f15596e0b9xxxxxxxxxxx04dcad81cd36c36c8f7045",
    "instance_name"              : "开发_中国铁塔视联基础平台_存储-02",
    "status"                     : "ACTIVE",
    "OS-EXT-STS:vm_state"        : "active",
    "OS-EXT-AZ:availability_zone": "cn-north-4a",
    "OS-EXT-SRV-ATTR:hostname"   : "02",
    "host_status"                : "UP",
    "locked"                     : "False",
    "RegionId"                   : "cn-north-4",
    "project_id"                 : "0ad96f54c800xxxxxxxxxxxxx91a9278a4"
  },
  "fields": {
    "created"                             : "2022-01-10T01:27:13Z",
    "updated"                             : "2022-07-02T20:15:19Z",
    "addresses"                           : "{裸金属服务器所属网络信息}",
    "image"                               : "{裸金属服务器镜像信息}",
    "flavor"                              : "{裸金属服务器规格信息}",
    "security_groups"                     : "[{裸金属服务器所属安全组}]",
    "OS-SRV-USG:launched_at"              : "2022-01-10T01:33:27.000000",
    "os-extended-volumes:volumes_attached": "{挂载到裸金属服务器上的磁盘}",
    "description"                         : "开发_中国铁塔视联基础平台_存储-01",
    "tags"                                : "['裸金属服务器的标签']",
    "os:scheduler_hints"                  : "{裸金属服务器的调度信息}",
    "enterprise_project_id"               : "239bcb77-3d92-4962-89ab-945a03327922",
    "message"                             : "{实例 JSON 数据}"
  }
}
~~~

部分参数说明

| 参数                | 参数类型 | 描述                                                                                                                                                                                                                                                                |
| ------------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| status              | String   | 裸金属服务器当前状态信息。取值范围：<br>ACTIVE：运行中/正在关机/删除中<br>BUILD：创建中<br/>ERROR：故障 <br/>HARD_REBOOT：强制重启中<br/>REBOOT：重启中<br/>DELETED：实例已被正常删除<br/>SHUTOFF：关机/正在开机/删除中/重建中/重装操作系统中/重装操作系统失败/冻结 |
| OS-EXT-STS:vm_state | String   | 扩展属性，裸金属服务器的稳定状态。例如：<br>active：运行中<br>shutoff：关机 <br>suspended：暂停<br>reboot：重启                                                                                                                                                     |
| host_status         | String   | 裸金属服务器宿主机状态：<br>UP：服务正常<br/>UNKNOWN：状态未知<br/>DOWN：服务异常 <br/>MAINTENANCE：维护状态 <br/>空字符串：裸金属服务器无主机信息                                                                                                                  |
| locked              | String   | 裸金属服务器是否为锁定状态。<br>True：锁定 <br>False：未锁定                                                                                                                                                                                                        |

*注意：`tags`、`fields` 中的字段可能会随后续更新有所变动*

> 提示：`tags.name` 值为实例 ID，作为唯一识别

> 提示 2：以下字段均为 JSON 序列化后字符串
>
> - `fields.message`
> - `fields.addresses`
> - `fields.flavor`
> - `fields.image`
> - `fields.os-extended-volumes:volumes_attached`
> - `fields.os:scheduler_hints`
> - `fields.security_groups`

## X. 附录

### 华为云 BMS「地域 ID」

请参考华为云官方文档：

- [云数据库 BMS 详情列表](https://support.huaweicloud.com/api-bms/bms_api_0609.html#section4)
- [云数据库 BMS 地域 ID](https://developer.huaweicloud.com/endpoint?BMS)
