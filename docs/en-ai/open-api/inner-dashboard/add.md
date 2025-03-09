# Create a Single User View

---

<br />**POST /api/v1/dashboard/add**

## Overview
Create a single user view


## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:------------------|:-------|:-----|:----------------|
| sourceDashboardUUID | string | No | Source view ID<br>Allow null: False <br>Allow empty string: True <br>Maximum length: 128 <br> |
| name | string | Yes | View name<br>Allow null: False <br>Maximum length: 256 <br> |
| desc | string | No | Description<br>Example: Description1 <br>Allow null: False <br>Maximum length: 2048 <br> |
| identifier | string | No | Identifier ID -- Added on 2024.12.25<br>Example: xxxx <br>Allow null: False <br>Allow empty string: True <br>Maximum length: 128 <br> |
| templateInfos | json | No | Custom template data<br>Example: {} <br>Allow null: False <br>Allow empty string: False <br> |
| dashboardBidding | json | No | Mapping, default is {}<br>Example: {} <br>Allow null: False <br> |
| specifyDashboardUUID | string | No | Specify the UUID for the new dashboard, must start with `dsbd_custom_` followed by 32 lowercase letters or numbers<br>Example: dsbd_custom_xxxx32 <br>Allow null: False <br>Allow empty string: False <br>$matchRegExp: ^dsbd_custom_[a-z0-9]{32}$ <br> |

## Additional Parameter Notes

**Request Body Structure Explanation**

| Parameter Name       | Type  | Description          |
|----------------------|-------|------------------------|
|name         |string |  Name |
|desc         |string |  Description |
|identifier         |string |  Identifier ID -- Added on 2024.12.25 |
|dashboardBidding         |dict |   Dashboard binding information|
|sourceDashboardUUID         |string |  Clone dashboard or built-in user view UUID|
|templateInfos         |dict |  Template information for cloning built-in system views |

**Explanation of Built-in View Binding Field `dashboardBidding`**

Internal support for op values: in/wildcard

**Example of `dashboardBidding` Field:**
```
{
    "service": [
        {
            "value": [
                "*"
            ],
            "op": "in"
        }
    ],
    "app_id": [
        {
            "value": [
                "test0"
            ],
            "op": "wildcard"
        }
    ],
    "label": [
        {
            "value": [
                "Do Not Delete"
            ],
            "op": "in"
        }
    ]
}
```



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/dashboard/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept-Language: en' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'Accept: application/json, text/plain, */*' \
--data-raw '{"name":"001 Bind Built-in View","dashboardBidding":{"service":[{"value":["*"],"op":"in"}],"app_id":[{"value":["test0"],"op":"wildcard"}],"label":[{"value":["Do Not Delete"],"op":"in"}]}}' \
--compressed
```



## Response
```json
{
    "code": 200,
    "content": {
        "chartGroupPos": [],
        "chartPos": [],
        "createAt": 1713513331,
        "createdWay": "manual",
        "creator": "wsak_xxxx32",
        "identifier": "",
        "dashboardBidding": {
            "app_id": [
                {
                    "op": "wildcard",
                    "value": [
                        "test0"
                    ]
                }
            ],
            "label": [
                {
                    "op": "in",
                    "value": [
                        "Do Not Delete"
                    ]
                }
            ],
            "service": [
                {
                    "op": "in",
                    "value": [
                        "*"
                    ]
                }
            ]
        },
        "dashboardBindSet": [],
        "declaration": {
            "b": [
                "asfawfgajfasfafgafwba",
                "asfgahjfaf"
            ],
            "business": "aaa",
            "organization": "64fe7b4062f74d0007b46676"
        },
        "deleteAt": -1,
        "desc": "",
        "extend": {},
        "iconSet": {},
        "id": 5091,
        "isPublic": 1,
        "mapping": [],
        "name": "001 Bind Built-in View",
        "ownerType": "inner",
        "status": 0,
        "type": "CUSTOM",
        "updateAt": 1713513331,
        "updator": "wsak_xxxx32",
        "uuid": "dsbd_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-2FB0228E-1660-4557-AF7B-688176108C28"
} 
```