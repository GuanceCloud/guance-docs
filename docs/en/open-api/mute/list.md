# Get a List of Mute Rules

---

<br />**get /api/v1/monitor/mute/list**

## Overview
Paging to get a list of silent rules.




## Query Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | Search rule name<br>Allow null: False <br> |
| pageIndex | integer |  | Page number<br>Allow null: False <br>Example: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | Quantity returned per page<br>Allow null: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Supplementary Description of Parameters





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/monitor/mute/list?pageIndex=1&pageSize=2' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed \
--insecure
```




## Response
```shell
{
    "code": 200,
    "content": [
        {
            "createAt": 1642572752,
            "creator": "wsak_220ed372243547ce847e915651664e14",
            "deleteAt": -1,
            "end": 1642576351,
            "id": 383,
            "notifyMessage": "",
            "notifyTargets": [],
            "notifyTime": -1,
            "start": 1642572751,
            "status": 0,
            "tags": [
                {
                    "host": "testname"
                }
            ],
            "type": "host",
            "updateAt": 1642572752,
            "updator": "wsak_220ed372243547ce847e915651664e14",
            "updatorInfo": {
                "name": "frasgreager",
                "username": "AK(wsak_220ed372243547ce847e915651664e14)"
            },
            "uuid": "mute_9cfc0c557a5b4df6924c0f9648be8890",
            "workspaceUUID": "wksp_2dc431d6693711eb8ff97aeee04b54af"
        }
    ],
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 1,
        "pageIndex": 1,
        "pageSize": 2,
        "totalCount": 1
    },
    "success": true,
    "traceId": "TRACE-AB73EEDD-3873-4EBD-A424-722022770AD5"
} 
```




