# Get Team List

---

<br />**GET /api/v1/workspace/member_group/list**

## Overview
List all teams in the current workspace



## Query Request Parameters

| Parameter Name | Type   | Required | Description              |
|:-----------|:-------|:-----|:----------------|
| search | string | No | Search by team name<br>Allow null: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/workspace/member_group/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```



## Response
```shell
{
    "code": 200,
    "content": [
        {
            "member_count": 1,
            "member_name_list": [
                "88 Test"
            ],
            "name": "Test",
            "uuid": "group_xxxx32"
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-26F96A09-C4FC-434F-A818-6631AB72AD03"
} 
```