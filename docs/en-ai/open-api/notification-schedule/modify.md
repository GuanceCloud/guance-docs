# Modify Schedule

---

<br />**POST /api/v1/notification_schedule/{notification_schedule_uuid}/modify**

## Overview
Modify an existing schedule.

## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:---------|:-------------------------|
| notification_schedule_uuid | string | Yes | Schedule UUID<br> |

## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:---------|:-------------------------|
| name | string | Yes | Name<br>Allow empty: False <br>Maximum length: 256 <br>Allow empty string: False <br> |
| timezone | string | No | Time zone, default Asia/Shanghai<br>Example: Asia/Shanghai <br>Allow empty: False <br>Maximum length: 48 <br> |
| start | string | Yes | Start time of the time period<br>Example: 00:00 <br>Allow empty: False <br>Maximum length: 48 <br> |
| end | string | Yes | End time of the time period<br>Example: 23:59 <br>Allow empty: False <br>Maximum length: 48 <br> |
| notifyTargets | array | Yes | Notification targets, including account UUID, notification target UUID, email<br>Example: ['acnt_xxx', 'notify_', 'test@qq.com'] <br>Allow empty: False <br> |
| extend | json | No | Extended information, including rotating notification target configuration<br>Allow empty: False <br> |
| extend.enableRotateNotification | boolean | No | Whether to enable rotation, default is disabled<br>Example: False <br>Allow empty: False <br> |
| extend.rotationCycle | string | No | Rotation cycle, day: day, week: week, month: month, workday: workDay, weekend: weekend<br>Example: day <br>Allow empty: False <br>Allowed values: ['day', 'week', 'month', 'workDay', 'weekend'] <br> |
| extend.effectiveTime | json | No | Validity period of the schedule, default is permanent, start/end times are 11-digit timestamps<br>Example: {'start': 1719990196, 'end': 1729990196} <br>Allow empty: False <br> |

## Additional Parameter Notes

Parameter descriptions: Refer to the create interface.

## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/notification_schedule/nsche_3512c1f4d176433484676225b547ef7a/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"schecule_modify","timezone":"Asia/Shanghai","start":"11:00","end":"23:59","notifyTargets":["acnt_8b4bd2b8782646f3ba8f6554193f5997"],"extend":{"enableRotateNotification":false,"effectiveTime":{"start":1735747200,"end":1737603472}}}' \
--compressed
```

## Response
```json
{
    "code": 200,
    "content": {
        "createAt": 1735797896,
        "creator": "wsak_f2ba9858f4414655be39efc882b120dd",
        "declaration": {},
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
        "name": "schecule_modify",
        "notifyTargets": [
            "acnt_8b4bd2b8782646f3ba8f6554193f5997"
        ],
        "rotationUpdateAt": 1735798211,
        "start": "11:00",
        "status": 0,
        "timezone": "Asia/Shanghai",
        "updateAt": 1735798211,
        "updator": "wsak_f2ba9858f4414655be39efc882b120dd",
        "uuid": "nsche_3512c1f4d176433484676225b547ef7a",
        "workspaceUUID": "wksp_798c5e0f589e4992994196832f64b6ba"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-0AC2A410-36A0-4694-879B-732A416A673B"
}
```