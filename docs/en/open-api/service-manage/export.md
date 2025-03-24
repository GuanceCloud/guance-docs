# [Service List] Export

---

<br />**GET /api/v1/service_manage/export**

## Overview
Service list export




## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| originStr | string |  | Pass 1 for raw string, pass 0 for structured data, default is 1<br>Can be empty: False <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/service_manage/export?originStr=0' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  -o 'serviceInfo.json'
  --compressed
```




## Response
```shell
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
                    "link": "<<< homepage >>>",
                    "name": "guance",
                    "provider": "Guance"
                },
                {
                    "link": "https://<<< custom_key.func_domain >>>/doc",
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
                    "link": "https://www.<<< custom_key.brand_main_domain >>>",
                    "name": "guance",
                    "provider": "Guance"
                },
                {
                    "link": "https://<<< custom_key.func_domain >>>",
                    "name": "func",
                    "provider": "Guance"
                }
            ],
            "Team": {
                "colour": "#40C922",
                "oncall": [
                    {
                        "emails": [
                            "xxx@<<< custom_key.brand_main_domain >>>",
                            "xxx@<<< custom_key.brand_main_domain >>>"
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
            "email": "xxx@<<< custom_key.brand_main_domain >>>",
            "iconUrl": "",
            "name": "test",
            "username": "xxx@<<< custom_key.brand_main_domain >>>"
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
            "email": "xxx@<<< custom_key.brand_main_domain >>>",
            "iconUrl": "",
            "name": "test",
            "username": "xxx@<<< custom_key.brand_main_domain >>>"
        },
        "uuid": "sman_xxxx32"
    }
] 
```