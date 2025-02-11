# Modify Alert Policy - Custom Notification Date

---

<br />**POST /api/v1/notice/date/\{notice_date_uuid\}/modify**

## Overview
Modify Alert Policy - Custom Notification Date



## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:-------------------|:-------|:-----|:----------------|
| notice_date_uuid | string | Y | Unique UUID for the custom notification date configuration of the alert policy<br>Allow empty string: False <br> |


## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:-------------------|:-------|:-----|:----------------|
| name | string | Y | Name<br>Allow empty: False <br>Maximum length: 256 <br> |
| noticeDates | array |  | Date list<br>Example: ['2024/01/02', '2024/02/03'] <br>Allow empty: False <br> |

## Additional Parameter Notes

Data Explanation.*

- Request body parameter explanation

| Parameter Name           | Type | Description                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| name       | str | Name of the custom notification date configuration for the alert policy |
| noticeDates    | list | Date list, example: ["2024/01/01","2024/05/01", "2024/10/01"]                               |

------




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/notice/date/ndate_xxxx32/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name": "test002", "noticeDates": ["2025/01/01","2025/10/01"]}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "createAt": 1705566710,
        "creator": "xxxx",
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
        "updateAt": 1705567170.109928,
        "updator": "xxxx",
        "uuid": "ndate_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-53EB1233-2398-4ABD-8CA0-BF14D8C3AA4D"
} 
```