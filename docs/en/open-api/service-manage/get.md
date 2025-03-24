# [Service List] Retrieval

---

<br />**GET /api/v1/service_manage/\{service_uuid\}/get**

## Overview
Retrieve information for a single service entry.



## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| service_uuid | string | Y | UUID corresponding to the service<br>Example: xxxx <br>Can be empty string: False <br> |


## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| originStr | string |  | Pass 1 for raw string, pass 0 for structured data, default is 1<br>Can be empty: False <br> |

## Additional Parameter Notes


**Request Body Structure Description**

|  Parameter Name        |   Type  | Required  |          Description          |
|----------------------|----------|----|------------------------|
| service_uuid    |  string  |  Y | Unique UUID of the service list, prefix is sman_ |
| originStr |  string  |  N | Whether to return the serviceCatelog as a raw string, 1 for yes, 0 for no. Default is 1 |

**Response Body Structure Description**

|  Parameter Name                |   Type  |          Description          |
|-----------------------------|----------|------------------------|
|serviceCatelog         |string,dict |  Raw string or structured data of the service list |
|service         |string |  Service name |
|type         |string |  Service type |



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/service_manage/sman_xxxx32/get?originStr=0' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "colour": "#40C9C9",
        "createAt": 1693798688,
        "creatorInfo": {
            "acntWsNickname": "",
            "email": "xxx",
            "iconUrl": "",
            "name": "Alibaba Cloud Monitoring Data Source",
            "username": "xxx"
        },
        "service": "test",
        "serviceCatelog": {
            "Docs": [
                {
                    "link": "<<< homepage >>>",
                    "name": "guance",
                    "provider": "guanceyun"
                },
                {
                    "link": "https://<<< custom_key.func_domain >>>/doc",
                    "name": "func",
                    "provider": "guanceyun"
                }
            ],
            "Related": {
                "AppId": "a138bcb0_47ef_11ee_9d75_31ea50b9d85a",
                "DashboardUUIDs": [
                    "dsbd_xxxx32",
                    "dsbd_xxxx32"
                ],
                "Tags": [
                    "mysql",
                    "test"
                ]
            },
            "Repos": [
                {
                    "link": "https://www.<<< custom_key.brand_main_domain >>>",
                    "name": "guance",
                    "provider": "guanceyun"
                },
                {
                    "link": "https://<<< custom_key.func_domain >>>",
                    "name": "func",
                    "provider": "guanceyun"
                }
            ],
            "Team": {
                "colour": "#40C9C9",
                "oncall": [
                    {
                        "emails": [
                            "xxx@<<< custom_key.brand_main_domain >>>",
                            "xxx@<<< custom_key.brand_main_domain >>>"
                        ],
                        "name": "guanceyun",
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
                "service": "jinlei_1",
                "team": "group_xxxx32",
                "type": "db"
            }
        },
        "type": "db",
        "updateAt": 1693798688,
        "updatorInfo": {
            "acntWsNickname": "",
            "email": "xxx",
            "iconUrl": "",
            "name": "Alibaba Cloud Monitoring Data Source",
            "username": "xxx"
        },
        "uuid": "sman_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-1255F7E2-9035-4696-B7EE-9DDBB2BC13D2"
} 
```