# Get Custom Notification Date for Alert Strategy

---

<br />**GET /api/v1/notice/date/\{notice_date_uuid\}/get**

## Overview
Get custom notification date for alert strategy



## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:-------------------|:-------|:-----|:----------------|
| notice_date_uuid | string | Y | Unique UUID of the custom notification date configuration for the alert strategy<br>Allow empty string: False <br> |


## Additional Parameter Explanation





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/notice/date/ndate_xxxx32/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "createAt": 1705566710,
        "creator": "xxx",
        "dates": [
            "2025/01/01",
            "2025/10/01"
        ],
        "declaration": {
            "asd": [
                "afaw"
            ],
            "asdasd": [
                "dawdawd"
            ],
            "business": "aaa",
            "fawf": [
                "afawf"
            ],
            "organization": "6540c09e4243b300077a9675"
        },
        "deleteAt": -1,
        "id": 4,
        "name": "test002",
        "status": 0,
        "updateAt": 1705567170,
        "updator": "xxx",
        "uuid": "ndate_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-CB587B59-4BCA-4CEE-97FE-38334ED9F96E"
} 
```