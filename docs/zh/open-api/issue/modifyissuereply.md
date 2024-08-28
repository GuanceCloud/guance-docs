# Issue-回复 修改

---

<br />**POST /api/v1/issue/reply/\{reply_uuid\}/modify**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| reply_uuid | string | Y | reply_uuid<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| issueUUID | string | Y | issue的UUID<br>例子: issueUUID <br>允许为空: False <br> |
| attachmentUuids | array |  | 回复附件上传列表uuids<br>例子: [] <br>允许为空: True <br> |
| content | string |  | 回复内容<br>例子: answer_xxx <br>允许为空: True <br>允许为空字符串: True <br> |
| extend | json | Y | 额外拓展信息，没有内容默认{}<br>例子: {} <br>允许为空: True <br> |

## 参数补充说明


**基本参数说明**

|     参数名      | 参数类型 | 是否必填 |                  参数说明                   |
|:---------------:|:--------:|:--------:|:-------------------------------------------:|
|   issueUUID       |  string  |    Y     |                对应回复issue的UUID                |
|   attachmentUuids      | array  |    N     |        对应回复issue的附件列表uuid,需先通过 /api/v1/attachment/upload 接口进行上传             |
|   content    |  string  |    N     |                回复的内容                      |
|     extend      |   json   |    Y     |                  扩展字段，默认传{}                  |


**扩展字段extend说明**

**更新场景中，channels和channelUUIDs的作用会默认的向默认频道和追加的频道中进行关联处理， 如果传[]，默认只会存在空间默认频道中**

|  参数名  | 参数类型 | 是否必填 |        参数说明         |
|:--------:|:--------:|:--------:|:-----------------------:|
| channels |  array   |    N     | 期望issue投递的资源列表 |
| members  |     array     |     N     |       期望issue通知的通知对象成员    |
| extra  |     json     |     N     |       回复更新人相关名称等信息, 用于前端回显    |

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
    "extra": {
                "updator": {
                  "name": "yyy",
                  "email": "yyy@qq.com",
                }
            }
}
```




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/issue/reply/repim_xxxx32/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"issueUUID":"issue_xxxx32","content":"aaaaas","attachmentUuids":[],"extend":{"channels":[],"linkList":[],"members":[],"text":"aaaaas"}}'\
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "content": "aaaaas",
        "createAt": 1690810887,
        "creator": "acnt_xxxx32",
        "deleteAt": -1,
        "extend": {
            "channels": [],
            "linkList": [],
            "members": [],
            "text": "aaaaas"
        },
        "id": 319430,
        "issueUUID": "issue_xxxx32",
        "status": 0,
        "type": "reply",
        "updateAt": 1690811215,
        "updator": "acnt_xxxx32",
        "uuid": "repim_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "13131178623027797701"
} 
```




