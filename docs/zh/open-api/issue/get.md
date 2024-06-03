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
                "uuid": "att_fe0db0e6c2204b99bdd481359cb0cfcb"
            },
            {
                "fileName": "\\图标\\1.png",
                "fileSuffix": "png",
                "uuid": "att_a8973199dcdc4a1b9a62117f1943d4a3"
            },
            {
                "fileName": "观测云图标2.png",
                "fileSuffix": "png",
                "uuid": "att_ca7d54e9d34a470597ffefd50bef8f26"
            },
            {
                "fileName": "im:age.png",
                "fileSuffix": "png",
                "uuid": "att_eaf3e026589a4cb7941e496288800fdf"
            },
            {
                "fileName": "im:age.png",
                "fileSuffix": "png",
                "uuid": "att_f4e129f9baa24ddaad5280dd348bbfcf"
            }
        ],
        "bindChannels": [
            {
                "name": "default",
                "uuid": "chan_44555c0071654f21918fbbb576dd4860"
            }
        ],
        "createAt": 1714113844,
        "creator": "wsak_736968854c44472688307662695ae591",
        "creatorInfo": {
            "acntWsNickname": "",
            "email": "wsak_736968854c44472688307662695ae591",
            "iconUrl": "",
            "name": "接口测试",
            "username": "wsak_736968854c44472688307662695ae591",
            "uuid": "wsak_736968854c44472688307662695ae591"
        },
        "declaration": {
            "business": "",
            "organization": "66013f10dae37200078d0fcd"
        },
        "deleteAt": -1,
        "description": "kong",
        "extend": {
            "manager": [
                "group_d8b27efcf7214e95a70585b532fe730f",
                "acnt_349ee5f70a89442fa94b4f754b5acbfe",
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
                "uuid": "group_d8b27efcf7214e95a70585b532fe730f"
            },
            {
                "acntWsNickname": "",
                "email": "88@qq.com",
                "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_349ee5f70a89442fa94b4f754b5acbfe.png",
                "name": "88测试",
                "username": "测试",
                "uuid": "acnt_349ee5f70a89442fa94b4f754b5acbfe"
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
        "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
        "updatorInfo": {
            "acntWsNickname": "",
            "email": "88@qq.com",
            "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_349ee5f70a89442fa94b4f754b5acbfe.png",
            "name": "88测试",
            "username": "测试",
            "uuid": "acnt_349ee5f70a89442fa94b4f754b5acbfe"
        },
        "uuid": "issue_7572b4f7aea4473697e0f0949f4c9035",
        "workspaceUUID": "wksp_1776556484b7412db06d6c428d3aaa6e"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-DF67F85B-2603-46B8-B122-7D98CA39BC95"
} 
```




