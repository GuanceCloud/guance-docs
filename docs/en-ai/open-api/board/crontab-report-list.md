# Get Scheduled Report List

---

<br />**GET /api/v1/crontab_report/list**

## Overview




## Query Request Parameters

| Parameter Name | Type   | Required | Description              |
|:-----------|:-------|:-----|:----------------|
| search | string | No | Search scheduled report name<br>Can be empty: True <br> |
| pageIndex | integer | Yes | Page number<br>Can be empty: False <br>Example: 1 <br>$minValue: 1 <br> |
| pageSize | integer | Yes | Number of items per page<br>Can be empty: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 10000 <br> |

## Additional Parameter Explanation





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/crontab_report/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": [
        {
            "content": "",
            "createAt": 1698666812,
            "creator": "wsak_xxxxx",
            "creatorInfo": {
                "acntWsNickname": "",
                "email": "wsak_xxxxx",
                "iconUrl": "",
                "name": "a",
                "username": "wsak_xxxxx"
            },
            "crontab": "10 10 03,14,13 * *",
            "dashboardName": "whytest",
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
            "recipientInfo": [
                "fj"
            ],
            "singleExecuteTime": -1,
            "status": 0,
            "timeRange": "1d",
            "timezone": "Asia/Shanghai",
            "title": "ceshi3",
            "updateAt": 1698667256,
            "updator": "wsak_xxxxx",
            "updatorInfo": {
                "acntWsNickname": "",
                "email": "wsak_xxxxx",
                "iconUrl": "",
                "name": "a",
                "username": "wsak_xxxxx"
            },
            "uuid": "cron_xxxx32",
            "variables": {},
            "workspaceUUID": "wksp_xxxx32"
        },
        {
            "content": "",
            "createAt": 1698665760,
            "creator": "wsak_xxxxx",
            "creatorInfo": {
                "acntWsNickname": "",
                "email": "wsak_xxxxx",
                "iconUrl": "",
                "name": "a",
                "username": "wsak_xxxxx"
            },
            "crontab": "",
            "dashboardName": "whytest",
            "dashboardUUID": "dsbd_xxxx32",
            "deleteAt": -1,
            "executed": 0,
            "extend": {
                "cycleTimeType": "once",
                "dashboardInfo": {},
                "hour": "10",
                "minutes": "20"
            },
            "id": 205,
            "isLocked": 0,
            "notifyType": "dingTalkRobot",
            "recipient": [
                "notify_xxxx32"
            ],
            "recipientInfo": [
                "fj"
            ],
            "singleExecuteTime": 1698718800,
            "status": 0,
            "timeRange": "1d",
            "timezone": "Asia/Shanghai",
            "title": "ceshi2",
            "updateAt": 1698666614,
            "updator": "acnt_xxxx32",
            "updatorInfo": {
                "acntWsNickname": "",
                "email": "88@qq.com",
                "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_xxxx32.png",
                "name": "88 test",
                "username": "test"
            },
            "uuid": "cron_xxxx32",
            "variables": {
                "host": {
                    "name": "host",
                    "value": "1698666252261"
                }
            },
            "workspaceUUID": "wksp_xxxx32"
        },
        {
            "content": "",
            "createAt": 1698665649,
            "creator": "acnt_xxxx32",
            "creatorInfo": {
                "acntWsNickname": "",
                "email": "88@qq.com",
                "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_xxxx32.png",
                "name": "88 test",
                "username": "test"
            },
            "crontab": "",
            "dashboardName": "whytest",
            "dashboardUUID": "dsbd_xxxx32",
            "deleteAt": -1,
            "executed": 0,
            "extend": {
                "cycleTimeType": "once",
                "dashboardInfo": {
                    "label": "whytest",
                    "value": "dsbd_xxxx32"
                },
                "hour": "10",
                "minutes": "20"
            },
            "id": 204,
            "isLocked": 0,
            "notifyType": "email",
            "recipient": [
                "acnt_xxxx32"
            ],
            "recipientInfo": {
                "acnt_xxxx32": {
                    "acntWsNickname": "",
                    "email": "66@qq.com",
                    "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_xxxx32.png",
                    "name": "I am 66",
                    "username": "66"
                }
            },
            "singleExecuteTime": 1698718800,
            "status": 0,
            "timeRange": "1d",
            "timezone": "Asia/Shanghai",
            "title": "ceshi1",
            "updateAt": 1698665649,
            "updator": "acnt_xxxx32",
            "updatorInfo": {
                "acntWsNickname": "",
                "email": "88@qq.com",
                "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_xxxx32.png",
                "name": "88 test",
                "username": "test"
            },
            "uuid": "cron_xxxx32",
            "variables": {},
            "workspaceUUID": "wksp_xxxx32"
        },
        {
            "content": "kkkk",
            "createAt": 1698652026,
            "creator": "acnt_xxxx32",
            "creatorInfo": {
                "acntWsNickname": "",
                "email": "88@qq.com",
                "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_xxxx32.png",
                "name": "88 test",
                "username": "test"
            },
            "crontab": "50 15 01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31 * *",
            "dashboardName": "11-02",
            "dashboardUUID": "dsbd_xxxx32",
            "deleteAt": -1,
            "executed": 0,
            "extend": {
                "cycleTimeType": "day",
                "dashboardInfo": {
                    "label": "11-02",
                    "value": "dsbd_xxxx32"
                },
                "hour": "15",
                "minutes": "50"
            },
            "id": 203,
            "isLocked": 0,
            "notifyType": "email",
            "recipient": [
                "acnt_xxxx32"
            ],
            "recipientInfo": {
                "acnt_xxxx32": {
                    "acntWsNickname": "",
                    "email": "sunhui@jiagouyun.com",
                    "iconUrl": "",
                    "name": "Sun Shuhua",
                    "username": "sunhui"
                }
            },
            "singleExecuteTime": -1,
            "status": 0,
            "timeRange": "1d",
            "timezone": "Asia/Shanghai",
            "title": "mmmm",
            "updateAt": 1698652026,
            "updator": "acnt_xxxx32",
            "updatorInfo": {
                "acntWsNickname": "",
                "email": "88@qq.com",
                "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_xxxx32.png",
                "name": "88 test",
                "username": "test"
            },
            "uuid": "cron_xxxx32",
            "variables": {},
            "workspaceUUID": "wksp_xxxx32"
        }
    ],
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 4,
        "pageIndex": 1,
        "pageSize": 100,
        "totalCount": 4
    },
    "success": true,
    "traceId": "TRACE-C9E1C502-53E9-4FD0-8F3E-235FF2A811FC"
} 
```