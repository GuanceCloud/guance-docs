# 日程获取

---

<br />**GET /api/v1/notification_schedule/\{notification_schedule_uuid\}/get**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| notification_schedule_uuid | string | Y | 日程 uuid<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/notification_schedule/nsche_3512c1f4d176433484676225b547ef7a/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1735797896,
        "creator": "wsak_f2ba9858f4414655be39efc882b120dd",
        "declaration": {},
        "deleteAt": -1,
        "end": "23:59",
        "extend": {
            "effectiveTime": {
                "end": 1737603472,
                "start": 1735747200
            },
            "enableRotateNotification": false
        },
        "id": 131,
        "issueNotificationPolicyInfos": [],
        "name": "schecule_modify",
        "notifyTargets": [
            "acnt_8b4bd2b8782646f3ba8f6554193f5997"
        ],
        "notifyTargetsInfos": [
            {
                "acntWsNickname": "",
                "email": "jinlei940@guance.com",
                "iconUrl": "",
                "mobile": "17621725046",
                "name": "金磊lll",
                "status": 0,
                "username": "金磊lll",
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
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-2ACE3D6C-8210-407C-9DDC-5A79AF8F1E6C"
} 
```




