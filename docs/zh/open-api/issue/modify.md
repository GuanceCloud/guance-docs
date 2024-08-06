# Issue 修改

---

<br />**POST /api/v1/issue/\{issue_uuid\}/modify**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| issue_uuid | string | Y | issueUUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string |  | 标题名称<br>例子: name <br>允许为空: False <br>$maxCustomLength: 256 <br> |
| level | string |  | 等级,对应等级配置uuid<br>例子: level <br>允许为空: False <br>允许为空字符串: True <br> |
| description | string |  | 描述<br>例子: description <br>允许为空: False <br> |
| statusType | integer |  | issue的状态<br>例子: statusType <br>允许为空: False <br>可选值: [10, 20, 30] <br> |
| extend | json | Y | 额外拓展信息，没有内容默认{}<br>例子: {} <br>允许为空: True <br> |
| attachmentUuids | array |  | 附件上传列表uuid<br>例子: [] <br>允许为空: True <br> |

## 参数补充说明


**基本参数说明**

|     参数名      | 参数类型 | 是否必填 |                  参数说明                   |
|:---------------:|:--------:|:--------:|:-------------------------------------------:|
|      name       |  string  |    N     |                issue标题名称                |
|      level      | string  |    N    |        issue等级 对应配置等级uuid        |
|      statusType      | integer  |    N     |        issue状态, 10: Open, 20: Resolved, 30: Pending        |
|   decription    |  string  |    N     |                issue描述信息                |
| attachmentUuids |  array   |    N     |              附件上传列表uuid, 需先通过 /api/v1/attachment/upload 接口进行上传          |
|     extend      |   json   |    N    |                  扩展字段，默认传{}                  |

**level 等级字段说明**
level 分为系统等级/自定义等级(可在配置管理中进行配置)

|     level      | value |                  参数说明                   |
|:---------------:|:--------:|:-------------------------------------------:|
|      P0       |  system_level_0  |      传参 level: system_level_0, 表示系统等级 P0               |
|      P1       |  system_level_1  |      传参 level: system_level_1, 表示系统等级 P1               |
|      P2       |  system_level_2  |      传参 level: system_level_2, 表示系统等级 P2               |
|      P3       |  system_level_3  |      传参 level: system_level_3, 表示系统等级 P3               |
|      xxx      |  issl_yyyyy      |      传参 level: issl_yyyyy, 表示自定义等级 xxx            |


**扩展字段extend说明**

|  参数名  | 参数类型 | 是否必填 |        参数说明         |
|:--------:|:--------:|:--------:|:-----------------------:|
| channels |  array   |    N     | 描述内容里的 # : 期望issue投递的资源列表, |
| linkList |  array   |    N     | 添加issue 链接 |
| members  |     array     |     N     |       描述内容里的 @ 期望issue通知的通知对象成员    |
| manager |  array   |    N     |              用户账号uuid, 邮箱, 团队uuid        |
| extra  |     json     |     N     |      issue更新人/负责人邮箱对应名称等信息, 用于前端回显    |

extend 字段示例:
```json
{
    "members": [
        {
            "type": "@",
            "uuid": "acnt_d72e117f8902419fa1d135d1d781b79d",
            "exists": true
        }
    ],
    "channels": [
        {
            "type": "#",
            "uuid": "chan_cf4f9aa671ef4dffa5a2b5d1824cd5b7",
            "exists": true
        }
    ],
    "manager": [
        "acnt_xxxxx",
        "111@qq.com",
        "group_xxx",
        "222@qq.com"
    ],
    "linkList": [
        {
            "name": "解决",
            "link": "https://sd.com",
        }
    ],
    "extra":{
              "updator": {
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
curl 'https://openapi.guance.com/api/v1/issue/issue_7b1f8986a7b44d7a987976fb5c7876fc/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"statusType":20}'\
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1686398344,
        "creator": "acnt_861cf6dd440348648861247ae42909c3",
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
                    "uuid": "chan_d5054276d1a74b518bf1b16f59c26e95"
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
        "updator": "acnt_861cf6dd440348648861247ae42909c3",
        "updatorInfo": {
            "acntWsNickname": "",
            "email": "1061379682@qq.com",
            "iconUrl": "",
            "name": "wanglei-testing",
            "username": "1061379682@qq.com"
        },
        "uuid": "issue_7b1f8986a7b44d7a987976fb5c7876fc",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "1744405827768254151"
} 
```




