# Create Schedule

---

<br />**POST /api/v1/notification_schedule/add**

## Overview
Create a new schedule



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:----------|:------------------------|
| name | string | Y | Name<br>Allow null: False <br>Maximum length: 256 <br>Allow empty string: False <br> |
| timezone | string |  | Time zone, default Asia/Shanghai<br>Example: Asia/Shanghai <br>Allow null: False <br>Maximum length: 48 <br> |
| start | string | Y | Time period start time<br>Example: 00:00 <br>Allow null: False <br>Maximum length: 48 <br> |
| end | string | Y | Time period end time<br>Example: 23:59 <br>Allow null: False <br>Maximum length: 48 <br> |
| notifyTargets | array | Y | Notification targets, includes account UUID, notification target UUID, email<br>Example: ['acnt_xxx', 'notify_', 'test@qq.com'] <br>Allow null: False <br> |
| extend | json |  | Extended information, includes rotation notification target configuration<br>Allow null: False <br> |
| extend.enableRotateNotification | boolean |  | Whether to enable rotation, default is off<br>Example: False <br>Allow null: False <br> |
| extend.rotationCycle | string |  | Rotation cycle, day: day, week: week, month: month, workday: workDay, weekend: weekend<br>Example: day <br>Allow null: False <br>Optional values: ['day', 'week', 'month', 'workDay', 'weekend'] <br> |
| extend.effectiveTime | json |  | Schedule validity period, default is permanent, start/end times are 11-digit timestamps<br>Example: {'start': 1719990196, 'end': 1729990196} <br>Allow null: False <br> |

## Additional Parameter Explanation


**1. Request Parameter Description**

| Parameter Name                | Type  | Required  | Description          |
|-------------------------------|-------|-----------|----------------------|
|name                          |String|Required| Schedule name|
|start                         |String|Required| Time period start time|
|end                           |String|Required| Time period end time|
|timezone                      |String|| Time zone|
|notifyTargets                 |array|Required| Notification targets, includes account UUID, notification target UUID, email|
|extend                        |Json|| Extended information|

--------------

**2. Parameter Description within `extend`**

| Parameter Name                | Type  | Required  | Description          |
|-------------------------------|-------|-----------|----------------------|
|enableRotateNotification       |Boolean|| Whether to enable notification target rotation, default is off|
|rotationCycle                  |string|| Rotation cycle after enabling notification target rotation|
|effectiveTime                  |json|| Validity period configuration for the schedule, default is permanent, start/end times are 11-digit timestamps|




## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/notification_schedule/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"schecule_add","timezone":"Asia/Shanghai","start":"00:00","end":"23:59","notifyTargets":["acnt_8b4bd2b8782646f3ba8f6554193f5997","notify_1c08db8458ba4ecabd27b8ce805e8502"],"extend":{"enableRotateNotification":true,"rotationCycle":"workDay","effectiveTime":{"start":1735747200,"end":1737603472}}}' \
--compressed
```




## Response
```shell
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
            "enableRotateNotification": true,
            "rotationCycle": "workDay"
        },
        "id": null,
        "name": "schecule_add",
        "notifyTargets": [
            "acnt_8b4bd2b8782646f3ba8f6554193f5997",
            "notify_1c08db8458ba4ecabd27b8ce805e8502"
        ],
        "rotationUpdateAt": 1735797896,
        "start": "00:00",
        "status": 0,
        "timezone": "Asia/Shanghai",
        "updateAt": null,
        "updator": null,
        "uuid": "nsche_3512c1f4d176433484676225b547ef7a",
        "workspaceUUID": "wksp_798c5e0f589e4992994196832f64b6ba"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-2655C615-0DA5-4391-8528-E46D1783B3F6"
} 
```