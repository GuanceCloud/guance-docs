# Issue 创建

---

<br />**POST /api/v1/issue/add**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 标题名称<br>例子: name <br>允许为空: False <br>最大长度: 256 <br> |
| level | string | Y | 等级,对应等级配置的uuid<br>例子: level <br>允许为空: False <br>允许为空字符串: True <br> |
| description | string | Y | 描述<br>例子: description <br>允许为空: False <br> |
| attachmentUuids | array |  | 附件上传列表uuid<br>例子: [] <br>允许为空: True <br> |
| extend | json | Y | 额外拓展信息<br>例子: {} <br>允许为空: True <br> |
| resourceType | string |  | 来源类型,没有场景就不需要传<br>例子: resourceType <br>允许为空: False <br>可选值: ['event', 'dashboard', 'viewer'] <br> |
| resourceUUID | string |  | 对应来源的uuid分别 docid,dashboardUUID,dashboardUUID<br>例子: resourceUuid <br>允许为空: False <br>允许为空字符串: True <br> |
| resource | string |  | 对应来源带入的来源名称<br>例子: resource <br>允许为空: False <br>允许为空字符串: True <br> |
| channelUUIDs | array |  | issue投递追踪频道uuids<br>例子: [] <br>允许为空: True <br> |

## 参数补充说明


**基本参数说明**

|     参数名      | 参数类型 | 是否必填 |                  参数说明                   |
|:---------------:|:--------:|:--------:|:-------------------------------------------:|
|      name       |  string  |    N     |                issue标题名称                |
|      level      | string  |    N    |        issue等级 对应配置等级uuid        |
|      statusType      | integer  |    N     |        issue状态, 10: Open, 15: Working, 20: Resolved, 25: Closed, 30: Pending        |
|   decription    |  string  |    N     |                issue描述信息                |
| attachmentUuids |  array   |    N     |              附件上传列表uuid, 需先通过 /api/v1/attachment/upload 接口进行上传          |
|     extend      |   json   |    N    |                  扩展字段，默认传{}                  |
|  resourceType   |  string  |    N     | event:事件, dashboard:仪表板, viewer:查看器 (checker:监控器, 此类型为自动创建) |
|  resourceUUID   |  string  |    N     |     资源关联的uuid     |
|    resource     |  string  |    N     |                对应资源名称                 |
|  channelUUIDs   |  array   |    N     |           期望issue投递的资源列表，默认投递默认空间默认频道  |

**level 等级字段说明**
level 分为系统等级/自定义等级(可在配置管理中进行配置)

|     level      | value |                  参数说明                   |
|:---------------:|:--------:|:-------------------------------------------:|
|      P0       |  system_level_0  |      传参 level: system_level_0, 表示系统等级 P0               |
|      P1       |  system_level_1  |      传参 level: system_level_1, 表示系统等级 P1               |
|      P2       |  system_level_2  |      传参 level: system_level_2, 表示系统等级 P2               |
|      P3       |  system_level_3  |      传参 level: system_level_3, 表示系统等级 P3               |
|      xxx      |  issl_yyyyy      |      传参 level: issl_yyyyy, 表示自定义等级 xxx            |


**Issue频道说明，所有 issue 会自动被归类在默认频道(全部)中**
issue 所关联频道为:  默认频道(全部), channels 和 channelUUIDs

**扩展字段extend说明**

|  参数名  | 参数类型 | 是否必填 |        参数说明         |
|:--------:|:--------:|:--------:|:-----------------------:|
| channels |  array   |    N     | 描述内容里的 #: 期望issue投递的资源列表, |
| linkList |  array   |    N     | 添加 issue 链接 |
| members  |     array     |     N     |       描述内容里的 @: 期望issue通知的通知对象成员    |
| manager |  array   |    N     |              用户账号uuid, 邮箱, 团队uuid        |
| extra  |     json     |     N     |      issue新建人/负责人名称等信息, 用于前端回显    |

extend 字段示例:
```json
{
    "members": [
        {
            "type": "@",
            "uuid": "acnt_xxxx32",
            "exists": true
        }
    ],
    "channels": [
        {
            "type": "#",
            "uuid": "chan_xxxx32",
            "exists": true
        }
    ],
    "manager": [
        "acnt_xxxx32",
        "abc@11.com",
        "group_xxx"
    ],
    "linkList": [
        {
            "name": "解决",
            "link": "https://sd.com",
        }
    ],
    "extra": {
            "creator": {
                "name": "xxx",
                "email": "xxx@qq.com",
            },
            "managerInfos": {
                "111@qq.com": {"name": "111"},
                "222@qq.com": {"name": "222"}

            }
            }
}
```




## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/issue/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"dcacscsc","level":"system_level_2","description":"<span>cdscascas</span>","extend":{"channels":[{"type":"#","uuid":"chan_xxxx32"}],"view_isuue_url":"/exceptions/exceptionsTracking?leftActiveKey=ExceptionsTracking&activeName=ExceptionsTracking&w=wksp_xxxx32&classic=exceptions_tracing&issueName=SYS&activeChannel=%7BdefaultChannelUUID%7D&sourceType=exceptions_tracing&__docid=%7BissueUUID%7D"},"attachmentUuids":[]}'\
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1686398344,
        "creator": "acnt_xxxx32",
        "creatorInfo": {
            "acntWsNickname": "",
            "email": "1061379682@qq.com",
            "iconUrl": "",
            "name": "wanglei-testing",
            "username": "1061379682@qq.com"
        },
        "deleteAt": -1,
        "description": "",
        "extend": {
            "channels": [
                {
                    "exists": true,
                    "type": "#",
                    "uuid": "chan_xxxx32"
                }
            ],
            "view_isuue_url": ""
        },
        "id": 47402,
        "level": "system_level_2",
        "name": "dcacscsc",
        "resource": "",
        "resourceType": "",
        "resourceUUID": "",
        "status": 0,
        "statusType": 20,
        "subIdentify": "",
        "updateAt": 1686400483,
        "updator": "acnt_xxxx32",
        "updatorInfo": {
            "acntWsNickname": "",
            "email": "1061379682@qq.com",
            "iconUrl": "",
            "name": "wanglei-testing",
            "username": "1061379682@qq.com"
        },
        "uuid": "issue_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "1744405827768254151"
} 
```




