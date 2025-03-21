# Get Role List

---

<br />**GET /api/v1/role/list**

## Overview
Get a list of roles.

## Query Request Parameters

| Parameter Name | Type   | Required | Description                                      |
|:--------------|:-------|:--------|:------------------------------------------------|
| search        | string | No      | Search by name. Example: read. Allow empty: False |
| statMember    | boolean| No      | Whether to display member statistics. Example: read. Allow empty: False |
| pageSize      | integer| No      | Number of items per page. Allow empty: False. Example: 10 |
| pageIndex     | integer| No      | Page number. Allow empty: False. Example: 1 |

## Additional Parameter Notes

## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/role/list?pageIndex=1&pageSize=3&statMember=true' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```

## Response
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
            "desc": "Owner",
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
            "desc": "Administrator",
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
            "desc": "Standard Member",
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