# Get Alert Strategies List

---

<br />**GET /api/v1/alert_policy/list**

## Overview
Retrieve a paginated list of alert strategies


## Query Request Parameters

| Parameter Name    | Type      | Required | Description                                      |
|:--------------|:-------|:-----|:---------------------------------------------|
| search     | string | No   | Search for alert strategy names<br>Allow empty: True <br> |
| pageIndex  | integer | Yes  | Page number<br>Allow empty: False <br>Example: 1 <br>$minValue: 1 <br> |
| pageSize   | integer | Yes  | Number of items per page<br>Allow empty: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/alert_policy/list?pageIndex=1&pageSize=10' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```



## Response
```shell
{
    "code": 200,
    "content": {
        "data": [
            {
                "alertOpt": {
                    "aggFields": [
                        "df_monitor_checker_id"
                    ],
                    "aggInterval": 120,
                    "alertTarget": [
                        {
                            "targets": [
                                {
                                    "status": "warning",
                                    "to": [
                                        "notify_xxx99e"
                                    ]
                                }
                            ]
                        }
                    ],
                    "silentTimeout": 21600
                },
                "createAt": 1706152082,
                "creator": "xx",
                "creatorInfo": {
                    "uuid": "xx",
                    "status": 0,
                    "username": "xx",
                    "name": "xx",
                    "iconUrl": "",
                    "email": "xx",
                    "acntWsNickname": "xx"
                },
                "deleteAt": -1,
                "id": 4100,
                "name": "jj_modify",
                "refCountInfo": {},
                "ruleCount": 0,
                "ruleTimezone": "Asia/Shanghai",
                "score": 0,
                "status": 0,
                "updateAt": 1706152340,
                "updator": "xx",
                "updatorInfo": {
                    "uuid": "xx",
                    "status": 0,
                    "username": "xx",
                    "name": "xx",
                    "iconUrl": "",
                    "email": "xx",
                    "acntWsNickname": "xx"
                },
                "uuid": "altpl_xxxc11",
                "workspaceUUID": "wksp_xxxa4b"
            }
        ],
        "declaration": {}
    },
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 1,
        "pageIndex": 1,
        "pageSize": 10,
        "totalCount": 1
    },
    "success": true,
    "traceId": "TRACE-6E1F1053-C2FF-4FAD-95FC-3108AFB9BD51"
} 
```