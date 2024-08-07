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
curl 'https://openapi.guance.com/api/v1/issue/reply/repim_73265eb9e69449de8d0b98e3b789a174/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"issueUUID":"issue_a3c3f3850d914a0d8ad5dee4f8ac6040","content":"aaaaas","attachmentUuids":[],"extend":{"channels":[],"linkList":[],"members":[],"text":"aaaaas"}}'\
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "content": "aaaaas",
        "createAt": 1690810887,
        "creator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
        "deleteAt": -1,
        "extend": {
            "channels": [],
            "linkList": [],
            "members": [],
            "text": "aaaaas"
        },
        "id": 319430,
        "issueUUID": "issue_a3c3f3850d914a0d8ad5dee4f8ac6040",
        "status": 0,
        "type": "reply",
        "updateAt": 1690811215,
        "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
        "uuid": "repim_73265eb9e69449de8d0b98e3b789a174",
        "workspaceUUID": "wksp_a7baa18031fb4a2db2ad467d384fd804"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "13131178623027797701"
} 
```




