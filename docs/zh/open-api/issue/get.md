# issue 详情获取

---

<br />**GET /api/v1/issue/\{issue_uuid\}/get**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| issue_uuid | string | Y | issueUUID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/issue/<issue_uuid>/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "attachments": [
            {
                "fileName": "特殊字符。  集?image (3)::&*.png",
                "fileSuffix": "png",
                "uuid": "att_xxxx32"
            },
            {
                "fileName": "\\图标\\1.png",
                "fileSuffix": "png",
                "uuid": "att_xxxx32"
            },
            {
                "fileName": "{{{ custom_key.brand_name }}}图标2.png",
                "fileSuffix": "png",
                "uuid": "att_xxxx32"
            },
            {
                "fileName": "im:age.png",
                "fileSuffix": "png",
                "uuid": "att_xxxx32"
            },
            {
                "fileName": "im:age.png",
                "fileSuffix": "png",
                "uuid": "att_xxxx32"
            }
        ],
        "bindChannels": [
            {
                "name": "default",
                "uuid": "chan_xxxx32"
            }
        ],
        "createAt": 1714113844,
        "creator": "wsak_xxxx32",
        "creatorInfo": {
            "acntWsNickname": "",
            "email": "wsak_xxxx32",
            "iconUrl": "",
            "name": "接口测试",
            "username": "wsak_xxxx32",
            "uuid": "wsak_xxxx32"
        },
        "declaration": {
            "business": "",
            "organization": "66013f10dae37200078d0fcd"
        },
        "deleteAt": -1,
        "description": "kong",
        "extend": {
            "manager": [
                "group_xxxx32",
                "acnt_xxxx32",
                "jj@qq.com"
            ]
        },
        "id": 212982,
        "level": "system_level_3",
        "levelInfo": {
            "color": "#C9C9C9",
            "name": "未知"
        },
        "managerInfos": [
            {
                "name": "team-pass",
                "uuid": "group_xxxx32"
            },
            {
                "acntWsNickname": "",
                "email": "88@qq.com",
                "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_xxxx32.png",
                "name": "88测试",
                "username": "测试",
                "uuid": "acnt_xxxx32"
            },
            {
                "email": "jj@qq.com",
                "name": "jj@qq.com"
            }
        ],
        "name": "上传",
        "resource": "",
        "resourceType": "",
        "resourceUUID": "",
        "status": 0,
        "statusType": 10,
        "subIdentify": "",
        "updateAt": 1716888575,
        "updator": "acnt_xxxx32",
        "updatorInfo": {
            "acntWsNickname": "",
            "email": "88@qq.com",
            "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_xxxx32.png",
            "name": "88测试",
            "username": "测试",
            "uuid": "acnt_xxxx32"
        },
        "uuid": "issue_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-DF67F85B-2603-46B8-B122-7D98CA39BC95"
} 
```




