# Create Custom Notification Date Alert Policy

---

<br />**POST /api/v1/notice/date/add**

## Overview
Create a custom notification date alert policy



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------------|:-------|:-----|:----------------|
| name | string | Y | Name<br>Allow null: False <br>Maximum length: 256 <br> |
| noticeDates | array |  | Date list<br>Example: ['2024/01/02', '2024/02/03'] <br>Allow null: False <br> |

## Additional Parameter Explanation


Data Explanation.*

- Request body parameter explanation

| Parameter Name           | Type | Description                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| name       | str | Custom notification date configuration name for the alert policy |
| noticeDates    | list | Date list, example: ["2024/01/01","2024/05/01", "2024/10/01"]                               |

------




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/notice/date/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name": "test001", "noticeDates": ["2024/01/01","2024/05/01"]}' \
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
            "2024/01/01",
            "2024/05/01"
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
        "id": null,
        "name": "test001",
        "status": 0,
        "updateAt": 1705566710,
        "updator": "xxx",
        "uuid": "ndate_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-6C9D0B1B-9591-45B9-B196-692A8FDF06F2"
} 
```