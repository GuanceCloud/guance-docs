# 获取角色列表

---

<br />**GET /api/v1/role/list**

## 概述
获取角色列表




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 根据名称/搜索<br>例子: read <br>允许为空: False <br> |
| statMember | boolean |  | 是否显示成员统计信息<br>例子: read <br>允许为空: False <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 10 <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/role/list?pageIndex=1&pageSize=3&statMember=true' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "createAt": -1,
            "creator": "SYS",
            "creatorInfo": {
                "uuid": "xx",
                "status": 0,
                "username": "xx",
                "name": "xx",
                "iconUrl": "",
                "email": "xx",
                "acntWsNickname": "xx"
            },
            "deleteAt": -1,
            "desc": "拥有者",
            "id": 1,
            "isSystem": 1,
            "memberCount": 1,
            "name": "Owner",
            "status": 0,
            "updateAt": -1,
            "updator": "SYS",
            "updatorInfo": {
                "uuid": "xx",
                "status": 0,
                "username": "xx",
                "name": "xx",
                "iconUrl": "",
                "email": "xx",
                "acntWsNickname": "xx"
            },
            "uuid": "owner",
            "workspaceUUID": ""
        },
        {
            "createAt": -1,
            "creator": "SYS",
            "creatorInfo": {
                "uuid": "xx",
                "status": 0,
                "username": "xx",
                "name": "xx",
                "iconUrl": "",
                "email": "xx",
                "acntWsNickname": "xx"
            },
            "deleteAt": -1,
            "desc": "管理员",
            "id": 2,
            "isSystem": 1,
            "memberCount": 45,
            "name": "Administrator",
            "status": 0,
            "updateAt": -1,
            "updator": "SYS",
            "updatorInfo": {
                "uuid": "xx",
                "status": 0,
                "username": "xx",
                "name": "xx",
                "iconUrl": "",
                "email": "xx",
                "acntWsNickname": "xx"
            },
            "uuid": "wsAdmin",
            "workspaceUUID": ""
        },
        {
            "createAt": -1,
            "creator": "SYS",
            "creatorInfo": {
                "uuid": "xx",
                "status": 0,
                "username": "xx",
                "name": "xx",
                "iconUrl": "",
                "email": "xx",
                "acntWsNickname": "xx"
            },
            "deleteAt": -1,
            "desc": "标准成员",
            "id": 3,
            "isSystem": 1,
            "memberCount": 29,
            "name": "Standard",
            "status": 0,
            "updateAt": -1,
            "updator": "SYS",
            "updatorInfo": {
                "uuid": "xx",
                "status": 0,
                "username": "xx",
                "name": "xx",
                "iconUrl": "",
                "email": "xx",
                "acntWsNickname": "xx"
            },
            "uuid": "general",
            "workspaceUUID": ""
        }
    ],
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 3,
        "pageIndex": 1,
        "pageSize": 3,
        "totalCount": 41
    },
    "success": true,
    "traceId": "TRACE-BE9CDC06-73DF-434D-813A-5BDBA94DD4E6"
} 
```




