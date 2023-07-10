# 修改一个Issue信息

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
| level | integer |  | 等级<br>例子: level <br>允许为空: False <br>可选值: [0, 1, 2] <br> |
| description | string |  | 描述<br>例子: description <br>允许为空: False <br> |
| statusType | integer |  | issue的状态<br>例子: statusType <br>允许为空: False <br>可选值: [10, 20, 30] <br> |
| extend | json |  | 额外拓展信息<br>例子: {} <br>允许为空: True <br> |
| attachmentUuids | array |  | 附件上传列表uuid<br>例子: [] <br>允许为空: True <br> |

## 参数补充说明





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
        "level": 2,
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




