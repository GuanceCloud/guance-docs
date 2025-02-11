# [Service List] Listed

---

<br />**GET /api/v1/service_manage/list**

## Overview
List the service list information


## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| search | string | No  | Search service name<br>Example: mysql <br>Can be empty: False <br> |
| originStr | string | No  | Pass 1 for raw string, pass 0 for structured data, default is 1<br>Can be empty: False <br> |
| filter | string | No  | Filter condition<br>Example: total <br>Can be empty: False <br>Optional values: ['total', 'favorite', 'myCreate', 'oftenBrowse'] <br> |
| createType | commaArray | No  | Creation type<br>Example: openapi,manual,automatic <br>Can be empty: False <br> |
| serviceType | commaArray | No  | Service type<br>Example: web,custom <br>Can be empty: False <br> |
| teamUUID | commaArray | No  | Team UUID<br>Example: group_x,group_y <br>Can be empty: False <br> |
| pageIndex | integer | No  | Page number<br>Can be empty: False <br>Example: 1 <br>$minValue: 1 <br> |
| pageSize | integer | No  | Number of items per page<br>Can be empty: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Additional Parameter Explanation

**Request Body Structure Explanation**

| Parameter Name        | Type  | Required  | Description          |
|-------------------|----------|----|------------------------|
| search    | string  | No | Search service name |
| originStr | string  | No | Whether to return the original string of `serviceCatelog`, 1 for yes, 0 for no. Default is 1 |
| filter    | string  | No | Filter condition |
| createType| string  | No | Filter service creation type, separated by ',', manual,openapi,automatic |
| serviceType| string  | No | Filter service type, separated by ',', app,framework,cache,message_queue,custom,db,web |
| teamUUID    | string  | No | Filter teams, separated by ',' |
| pageIndex | string  | No | Page number |
| pageSize  | string  | No | Number of items per page |


**Response Body Structure Explanation**

| Parameter Name                | Type  | Description          |
|---------------------------|----------|------------------------|
| serviceCatelog         | string,dict | Original string or structured data of the service list |
| service         | string | Service name |
| type         | string | Service type |
| dfStatus         | string | Service status |
| creatorInfo             | dict | Creator information of the service list |
| updatorInfo             | dict | Updater information of the service list |



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/service_manage/list?originStr=0' \
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
                                "test1@guance.com",
                                "test3@guance.com"
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
                        "link": "https://www.guance.com",
                        "name": "Guance",
                        "provider": "Guance"
                    },
                    {
                        "link": "https://func.guance.com",
                        "name": "Func",
                        "provider": "Guance"
                    }
                ],
                "Docs": [
                    {
                        "link": "https://www.docs.guance.com",
                        "name": "Guance",
                        "provider": "Guance"
                    },
                    {
                        "link": "https://func.guance.com/doc",
                        "name": "Func",
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
                "username": "test@jiagouyun.com",
                "name": "test",
                "iconUrl": "",
                "email": "test@jiagouyun.com",
                "acntWsNickname": ""
            },
            "colour": "",
            "updatorInfo": {
                "username": "test@jiagouyun.com",
                "name": "test",
                "iconUrl": "",
                "email": "test@jiagouyun.com",
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