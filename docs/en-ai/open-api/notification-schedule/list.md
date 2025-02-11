# Schedule Listing

---

<br />**GET /api/v1/notification_schedule/list**

## Overview




## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-------|:----------------|
| mySchedule | string | No | View my schedule, default false: view all schedules<br>Allow empty: True <br>Optional values: ['true', 'false'] <br> |
| notificationScheduleUUIDs | commaArray | No | Filter schedule UUIDs<br>Allow empty: False <br> |
| issueNotificationPolicyUUIDs | commaArray | No | Filter notification policy UUIDs<br>Allow empty: False <br> |
| notifyTargets | commaArray | No | Filter notification targets, acnt_xxx,notify_yyy,jj@qq.com<br>Allow empty: False <br> |
| search | string | No | Search name<br>Allow empty: True <br> |
| pageIndex | integer | No | Page number<br>Allow empty: False <br>Example: 1 <br>$minValue: 1 <br> |
| pageSize | integer | No | Number of items per page<br>Allow empty: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Additional Parameter Explanation





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/notification_schedule/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "data": [
            {
                "createAt": 1735798360,
                "creator": "acnt_8b4bd2b8782646f3ba8f6554193f5997",
                "deleteAt": -1,
                "effectiveTimeInfos": {
                    "expired": false,
                    "timeStr": ""
                },
                "end": "23:59",
                "extend": {
                    "enableRotateNotification": false,
                    "rotationCycle": "day"
                },
                "id": 132,
                "inEffectNotifyTargetsInfos": [
                    {
                        "name": "tempN",
                        "status": 0,
                        "type": "HTTPRequest",
                        "uuid": "notify_1c08db8458ba4ecabd27b8ce805e8502"
                    }
                ],
                "issueNotificationPolicyInfos": [],
                "name": "temp22",
                "notifyTargets": [
                    "notify_1c08db8458ba4ecabd27b8ce805e8502"
                ],
                "notifyTargetsInfos": [
                    {
                        "name": "tempN",
                        "status": 0,
                        "type": "HTTPRequest",
                        "uuid": "notify_1c08db8458ba4ecabd27b8ce805e8502"
                    }
                ],
                "rotationUpdateAt": 1735798360,
                "start": "00:00",
                "status": 0,
                "timezone": "Asia/Shanghai",
                "updateAt": -1,
                "updator": "",
                "uuid": "nsche_6c18b90a5900413f960114058fce4d4c",
                "workspaceUUID": "wksp_798c5e0f589e4992994196832f64b6ba"
            },
            {
                "createAt": 1735797896,
                "creator": "wsak_f2ba9858f4414655be39efc882b120dd",
                "deleteAt": -1,
                "effectiveTimeInfos": {
                    "expired": false,
                    "timeStr": "2025/01/02 00:00:00~2025/01/23 11:37:52"
                },
                "end": "23:59",
                "extend": {
                    "effectiveTime": {
                        "end": 1737603472,
                        "start": 1735747200
                    },
                    "enableRotateNotification": false
                },
                "id": 131,
                "inEffectNotifyTargetsInfos": [
                    {
                        "acntWsNickname": "",
                        "email": "jinlei940@guance.com",
                        "iconUrl": "",
                        "mobile": "17621725046",
                        "name": "Jin Lei lll",
                        "status": 0,
                        "username": "Jin Lei lll",
                        "uuid": "acnt_8b4bd2b8782646f3ba8f6554193f5997",
                        "wsAccountStatus": 0
                    }
                ],
                "issueNotificationPolicyInfos": [],
                "name": "schedule_modify",
                "notifyTargets": [
                    "acnt_8b4bd2b8782646f3ba8f6554193f5997"
                ],
                "notifyTargetsInfos": [
                    {
                        "acntWsNickname": "",
                        "email": "jinlei940@guance.com",
                        "iconUrl": "",
                        "mobile": "17621725046",
                        "name": "Jin Lei lll",
                        "status": 0,
                        "username": "Jin Lei lll",
                        "uuid": "acnt_8b4bd2b8782646f3ba8f6554193f5997",
                        "wsAccountStatus": 0
                    }
                ],
                "rotationUpdateAt": 1735798211,
                "start": "11:00",
                "status": 0,
                "timezone": "Asia/Shanghai",
                "updateAt": 1735798211,
                "updator": "wsak_f2ba9858f4414655be39efc882b120dd",
                "uuid": "nsche_3512c1f4d176433484676225b547ef7a",
                "workspaceUUID": "wksp_798c5e0f589e4992994196832f64b6ba"
            }
        ],
        "declaration": {},
        "myScheduleCount": 0,
        "totalScheduleCount": 2
    },
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 2,
        "pageIndex": 1,
        "pageSize": 10,
        "totalCount": 2
    },
    "success": true,
    "traceId": "TRACE-0D517EFF-5D02-4672-9189-1C9DEB248E23"
} 
```