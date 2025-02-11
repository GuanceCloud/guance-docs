# Get a Single Scheduled Report

---

<br />**GET /api/v1/crontab_report/\{report_uuid\}/get**

## Overview




## Route Parameters

| Parameter Name     | Type   | Required | Description             |
|:-----------------|:------|:-------|:----------------------|
| report_uuid      | string | Y     | UUID of the scheduled report<br> |


## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/crontab_report/cron_xxxx32/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "content": "",
        "createAt": 1698666812,
        "creator": "wsak_xxxxx",
        "crontab": "10 10 03,14,13 * *",
        "dashboardUUID": "dsbd_xxxx32",
        "deleteAt": -1,
        "executed": 0,
        "extend": {
            "cycleTimeType": "day",
            "dashboardInfo": {},
            "hour": "10",
            "minutes": "10"
        },
        "id": 206,
        "isLocked": 0,
        "notifyType": "dingTalkRobot",
        "recipient": [
            "notify_xxxx32"
        ],
        "singleExecuteTime": -1,
        "status": 0,
        "timeRange": "1d",
        "timezone": "Asia/Shanghai",
        "title": "ceshi3",
        "updateAt": 1698667256,
        "updator": "wsak_xxxxx",
        "uuid": "cron_xxxx32",
        "variables": {},
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-52DF7B37-376D-4AA4-9E1D-5879AA41F03E"
} 
```