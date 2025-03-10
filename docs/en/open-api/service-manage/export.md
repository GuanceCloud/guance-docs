# 【Service List】Export

---

<br />**GET /api/v1/service_manage/export**

## Overview
Service list export



## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:--------|:--------------------------|
| originStr          | string | No      | Pass 1 for raw string, pass 0 for structured data, default is 1<br>Allow empty: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/service_manage/export?originStr=0' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  -o 'serviceInfo.json'
  --compressed
```



## Response
```json
[
    {
        "colour": "#40C922",
        "createAt": 1693798688,
        "createType": "openapi",
        "creatorInfo": {
            "acntWsNickname": "",
            "email": "xxx",
            "iconUrl": "",
            "name": "Alibaba Cloud Monitoring Data Source",
            "username": "xxx"
        },
        "dfStatus": "ok",
        "isFavorite": false,
        "service": "test_02",
        "serviceCatelog": {
            "Docs": [
                {
                    "link": "https://www.docs.guance.com",
                    "name": "Guance",
                    "provider": "Guance"
                },
                {
                    "link": "https://func.guance.com/doc",
                    "name": "func",
                    "provider": "Guance"
                }
            ],
            "Related": {
                "AppId": "a138bcb0_47ef_11ee_9d75_31ea50b9d85a",
                "DashboardUUIDs": [
                    "dsbd_xxxx32"
                ],
                "Tags": [
                    "test"
                ]
            },
            "Repos": [
                {
                    "link": "https://www.guance.com",
                    "name": "Guance",
                    "provider": "Guance"
                },
                {
                    "link": "https://func.guance.com",
                    "name": "func",
                    "provider": "Guance"
                }
            ],
            "Team": {
                "colour": "#40C922",
                "oncall": [
                    {
                        "emails": [
                            "test1@guance.com",
                            "test3@guance.com"
                        ],
                        "name": "Guance",
                        "type": "email"
                    },
                    {
                        "mobiles": [
                            "xxxxxxx5786",
                            "xxxxxxx4231"
                        ],
                        "name": "zhuyun",
                        "type": "mobile"
                    },
                    {
                        "name": "test",
                        "slack": "#test",
                        "type": "slack"
                    }
                ],
                "service": "test_02",
                "team": "group_xxxx32",
                "type": "db"
            }
        },
        "type": "db",
        "updateAt": 1693805504,
        "updatorInfo": {
            "acntWsNickname": "",
            "email": "xxx",
            "iconUrl": "",
            "name": "Alibaba Cloud Monitoring Data Source",
            "username": "xxx"
        },
        "uuid": "sman_xxxx32"
    },
    {
        "colour": "",
        "createAt": 1693728357,
        "createType": "manual",
        "creatorInfo": {
            "acntWsNickname": "",
            "email": "test@jiagouyun.com",
            "iconUrl": "",
            "name": "test",
            "username": "test@jiagouyun.com"
        },
        "dfStatus": "ok",
        "isFavorite": false,
        "service": "test-lml3",
        "serviceCatelog": {
            "Team": {
                "colour": "",
                "oncall": [],
                "service": "test-lml3",
                "team": "",
                "type": "custom"
            }
        },
        "type": "custom",
        "updateAt": 1693728357,
        "updatorInfo": {
            "acntWsNickname": "",
            "email": "test@jiagouyun.com",
            "iconUrl": "",
            "name": "test",
            "username": "test@jiagouyun.com"
        },
        "uuid": "sman_xxxx32"
    }
]
```