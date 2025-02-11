# Get an Alert Policy

---

<br />**GET /api/v1/alert_policy/\{alert_policy_uuid\}/get**

## Overview
Retrieve an alert policy


## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:---------|:-------------------------|
| alert_policy_uuid     | string   | Y        | Alert policy UUID        |


## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/alert_policy/altpl_xxxx32/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```



## Response
```shell
{
    "code": 200,
    "content": {
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
                                "notify_xxxx32"
                            ]
                        }
                    ]
                }
            ],
            "silentTimeout": 21600
        },
        "createAt": 1706152082,
        "creator": "xx",
        "declaration": {},
        "deleteAt": -1,
        "id": 4100,
        "name": "jj_modify",
        "notifyObjectName": {
            "notify_xxxx32": "Jinlei Test Without Key"
        },
        "ruleTimezone": "Asia/Shanghai",
        "score": 0,
        "status": 0,
        "updateAt": 1706152340,
        "updator": "xx",
        "uuid": "altpl_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-F50BB1EB-5CF5-4B07-A633-4EF2E7EA4FD8"
} 
```