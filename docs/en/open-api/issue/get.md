# Issue Details Retrieval

---

<br />**GET /api/v1/issue/\{issue_uuid\}/get**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:------------------------|
| issue_uuid           | string   | Y          | Issue UUID              |


## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/issue/<issue_uuid>/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "attachments": [
            {
                "fileName": "Special characters.  Collection?image (3)::&*.png",
                "fileSuffix": "png",
                "uuid": "att_xxxx32"
            },
            {
                "fileName": "\\Icon\\1.png",
                "fileSuffix": "png",
                "uuid": "att_xxxx32"
            },
            {
                "fileName": "<<< custom_key.brand_name >>> Icon2.png",
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
            "name": "Interface Testing",
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
            "managers": [
                "group_xxxx32",
                "acnt_xxxx32",
                "xxx@<<< custom_key.brand_main_domain >>>"
            ]
        },
        "id": 212982,
        "level": "system_level_3",
        "levelInfo": {
            "color": "#C9C9C9",
            "name": "Unknown"
        },
        "managerInfos": [
            {
                "name": "team-pass",
                "uuid": "group_xxxx32"
            },
            {
                "acntWsNickname": "",
                "email": "xxx@<<< custom_key.brand_main_domain >>>",
                "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_xxxx32.png",
                "name": "88 Test",
                "username": "Test",
                "uuid": "acnt_xxxx32"
            },
            {
                "email": "xxx@<<< custom_key.brand_main_domain >>>",
                "name": "xxx@<<< custom_key.brand_main_domain >>>"
            }
        ],
        "name": "Upload",
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
            "email": "xxx@<<< custom_key.brand_main_domain >>>",
            "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_xxxx32.png",
            "name": "88 Test",
            "username": "Test",
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