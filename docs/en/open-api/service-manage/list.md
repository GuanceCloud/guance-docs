# [Service List] Listed

---

<br />**GET /api/v1/service_manage/list**

## Overview
List service list information



## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| search | string |  | Search for service name<br>Example: mysql <br>Can be empty: False <br> |
| originStr | string |  | Pass 1 for original string, pass 0 for structured data, default is 1<br>Can be empty: False <br> |
| filter | string |  | Filter condition<br>Example: total <br>Can be empty: False <br>Optional values: ['total', 'favorite', 'myCreate', 'oftenBrowse'] <br> |
| createType | commaArray |  | Creation type<br>Example: openapi,manual,automatic <br>Can be empty: False <br> |
| serviceType | commaArray |  | Service type<br>Example: web,custom <br>Can be empty: False <br> |
| teamUUID | commaArray |  | Team UUID<br>Example: group_x,group_y <br>Can be empty: False <br> |
| pageIndex | integer |  | Page number<br>Can be empty: False <br>Example: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | Number of returns per page<br>Can be empty: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Additional Parameter Notes


**Request Body Structure Description**

| Parameter Name        | type  | Required | Description          |
|---------------------|----------|----|------------------------|
| search    | string  | N | Search for service name |
| originStr | string  | N | Whether the returned serviceCatelog needs to be an original string, 1 for yes, 0 for no. Default is 1|
| filter    | string  | N | Filter condition |
| createType| string  | N | Filter service creation types, separated by ',', manual,openapi,automatic|
| serviceType| string  | N | Filter service types, separated by ',', app,framework,cache,message_queue,custom,db,web |
| teamUUID    | string  | N | Filter teams, separated by ',' |
| pageIndex | string  | N | Pagination page number |
| pageSize  | string  | N | Number of returns per page |


**Response Body Structure Description**

| Parameter Name                | type  | Description          |
|-----------------------------|----------|------------------------|
|serviceCatelog         |string,dict | Original string or structured data of the service list |
|service         |string | Service name |
|type         |string | Service type |
|dfStatus         |string | Service status |
|creatorInfo             |dict | Creator information of the service list |
|updatorInfo             |dict | Updater information of the service list |



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/service_manage/list?originStr=0' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --compressed
```




## Response
```shell
{
    "automaticFoundTime": "1693807201",
    "data": [
        {
            "uuid": "sman_xxxx32",
            "createAt": 1693798688,
            "updateAt": 1693805504,
            "creatorInfo": {
                "username": "xxx",
                "name": "Alibaba Cloud Monitoring Data Source",
                "iconUrl": "",
                "email": "wsak_xxxxx",
                "acntWsNickname": ""
            },
            "colour": "#40C922",
            "updatorInfo": {
                "username": "xxx",
                "name": "Alibaba Cloud Monitoring Data Source",
                "iconUrl": "",
                "email": "wsak_xxxxx",
                "acntWsNickname": ""
            },
            "dfStatus": "ok",
            "isFavorite": false,
            "createType": "openapi",
            "service": "test_02",
            "type": "db",
            "serviceCatelog": {
                "Team": {
                    "service": "test_02",
                    "type": "db",
                    "team": "group_xxxx32",
                    "colour": "#40C922",
                    "oncall": [
                        {
                            "name": "Guance",
                            "type": "email",
                            "emails": [
                                "xxx@<<< custom_key.brand_main_domain >>>",
                                "xxx@<<< custom_key.brand_main_domain >>>"
                            ]
                        },
                        {
                            "name": "zhuyun",
                            "type": "mobile",
                            "mobiles": [
                                "xxxxxxx5786",
                                "xxxxxxx4231"
                            ]
                        },
                        {
                            "name": "test",
                            "type": "slack",
                            "slack": "#test"
                        }
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
                    "Tags": [
                        "test"
                    ],
                    "DashboardUUIDs": [
                        "dsbd_xxxx32"
                    ]
                }
            }
        },
        {
            "uuid": "sman_xxxx32",
            "createAt": 1693728357,
            "updateAt": 1693728357,
            "creatorInfo": {
                "username": "xxx@<<< custom_key.brand_main_domain >>>",
                "name": "test",
                "iconUrl": "",
                "email": "xxx@<<< custom_key.brand_main_domain >>>",
                "acntWsNickname": ""
            },
            "colour": "",
            "updatorInfo": {
                "username": "xxx@<<< custom_key.brand_main_domain >>>",
                "name": "test",
                "iconUrl": "",
                "email": "xxx@<<< custom_key.brand_main_domain >>>",
                "acntWsNickname": ""
            },
            "dfStatus": "ok",
            "isFavorite": false,
            "createType": "manual",
            "service": "test-lml3",
            "type": "custom",
            "serviceCatelog": {
                "Team": {
                    "service": "test-lml3",
                    "type": "custom",
                    "colour": "",
                    "team": "",
                    "oncall": []
                },
                "Related": {
                    "Tags": []
                }
            }
        }
    ],
    "pageInfo": {
        "pageIndex": 1,
        "pageSize": 50,
        "count": 2,
        "totalCount": 2
    }
} 
```